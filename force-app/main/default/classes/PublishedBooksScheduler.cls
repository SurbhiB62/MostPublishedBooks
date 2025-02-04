/**
* @author            : Surbhi Bhati
* @description       : Scheduler class to schedule and run the PublishedBooksHandler class 
**/

global class PublishedBooksScheduler implements Schedulable {
    
    global void execute(SchedulableContext SC) {
        PublishedBooksHandler pbHandler = new PublishedBooksHandler();
        PublishedBooksHandler.getPublishedBooksDetails();
    }
}