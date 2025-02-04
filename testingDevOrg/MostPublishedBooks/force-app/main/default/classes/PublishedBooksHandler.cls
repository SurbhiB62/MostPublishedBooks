/**
* @author            : Surbhi Bhati
* @description       : Handler class to call the endpoint and have buisness logic to publish platform event.
**/

Global class PublishedBooksHandler  {
    
    /**
* @Method Name       : getPublishedBooksDetails
* @description       : This is to get all the published books detail where edition is greater than 600000 and then publish the platform event.  
* @Input params      : void
**/
    
    @future(callout=true)
    public static void getPublishedBooksDetails(){
        
        //creating HTTP request
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        //getting end point detils from named credential
        request.setEndpoint('callout:PublishedBooksCallout');
        request.setMethod('GET');
        
        //retrieving response
        HttpResponse response = http.send(request);
        
        // If the request is successful, parse the JSON response.
        try{
            if(response.getStatusCode() == 200) {
                
                //debug
                system.debug('response'+ response.getBody());
                
                String serializedResponse = Json.serialize(response.getBody());
                
                system.debug('deserializing--'+ JSON.deserializeUntyped(serializedResponse));
                
                //retrieving response 
                // List<Object> tempRecords = (List<Object>) JSON.deserializeUntyped(response.getBody());
                
                //Parsing response 
                BookWrapperCls[] wrapperList = (List<BookWrapperCls>)JSON.deserialize( response.getBody(), List<BookWrapperCls>.class);
                
                //List to store all books where edition > 600000
                List<BookWrapperCls.Books> bookList = new List<BookWrapperCls.Books>() ;
                
                //platform event list 
                List<MostPublishedBook__e> publisheBookList = new List<MostPublishedBook__e>();
                
                if(!wrapperList.isEmpty()){
                    
                    //iterating to get all Books detail including Publisher Name
                    for(BookWrapperCls wrapr : wrapperList){
                        
                        for(BookWrapperCls.Books book: wrapr.Books){
                            
                            if(book.edition > 600000){
                                //debug
                                //System.debug('book'+ book);
                                book.Publisher = wrapr.Publisher;
                                bookList.add(book);
                                
                            }
                            
                        }                    
                    }
                    
                }
                
                //check if book list is not null then do sorting to get the book list having highest copies to lowed copies
                if(!bookList.isEmpty()){
                    //using custom comparator class to sort the Book list 
                    PublishedBookComparator editionCompare = new PublishedBookComparator();
                    //sorting starts------
                    bookList.sort(editionCompare);
                    //sorting ends------
                    //debug
                    System.debug('after compare---'+ bookList);
                }
                
                if(!bookList.isEmpty()){
                    For(BookWrapperCls.Books book: bookList){
                        //creating platform event record
                        MostPublishedBook__e event = new MostPublishedBook__e(Author__c=book.Author,Title__c=book.Title,	Publisher__c=book.Publisher,Edition__c=book.Edition);
                        publisheBookList.add(event);
                        
                    }
                    //debug
                    //System.debug('publisheBookList size'+ publisheBookList.size());
                    //publish platform event
                    publishBookEvnt(publisheBookList);
                }
                else{
                    System.debug('Book list not found');
                }
                
            }
        }
        catch(Exception ex){
            System.debug('Error occured: '+ ex.getMessage());
        }
    }
    
    
    /**
* @Method Name       : publishBookEvnt
* @description       : This is to publish platform event - MostPublishedBook__e with the sorted book list records
* @Input params      : List of Books getting from callout response
**/
    
    Public static void publishBookEvnt(List<MostPublishedBook__e> publisheBookList){
        
        // publish platform event 
        //debug
        System.debug('publishBookEvnt list size'+ publisheBookList.size());
        
        List<Database.SaveResult> results = EventBus.publish(publisheBookList);
        
        for (Database.SaveResult sr : results) {
            if (sr.isSuccess()) {
                System.debug('Successfully published event.');
            } else {
                for(Database.Error err : sr.getErrors()) {
                    System.debug('Error returned: ' + err.getStatusCode() );
                }
            }
        }     
    }
    
    global void execute(SchedulableContext sc){}
    
}