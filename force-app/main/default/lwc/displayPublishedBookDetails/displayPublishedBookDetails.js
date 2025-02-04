import { LightningElement, track } from 'lwc';
import { subscribe, unsubscribe, onError } from 'lightning/empApi';
export default class DisplayPublishedBookDetails extends LightningElement {

    @track books = [];
    subscription = {};
    channelName = '/event/MostPublishedBook__e';

    connectedCallback() {
        this.handleSubscribe();
        this.registerErrorListener();
    }

    handleSubscribe() {
        const messageCallback = (response) => {
            console.log('New event received:', response);
            if (response && response.data && response.data.payload) {
                this.books = [...this.books, {
                    title: response.data.payload.Title__c,
                    editionSize: response.data.payload.Edition__c,
                    author: response.data.payload.Author__c,
                    publisher: response.data.payload.Publisher__c
                }];
            }
        };
        
        subscribe(this.channelName, -1, messageCallback).then(response => {
            this.subscription = response;
        });
    }

    registerErrorListener() {
        onError(error => {
            console.error('Streaming API error:', error);
        });
    }

    disconnectedCallback() {
        unsubscribe(this.subscription, () => {
            console.log('Unsubscribed from event channel');
        });
    }
}