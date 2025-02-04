/**
 * @author            : Surbhi Bhati
 * @description       : Scheduler class to schedule and run the PublishedBooksHandler class 
 **/

global without sharing class PublishedBooksScheduler implements Schedulable {

    global void execute(SchedulableContext SC) {
        System.debug('in scheduler');
        
        // Directly call the static method from the class
        PublishedBooksHandler.getPublishedBooksDetails();
    }
}
