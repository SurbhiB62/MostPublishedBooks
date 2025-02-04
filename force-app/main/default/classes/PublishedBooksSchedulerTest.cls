/**
* @author            : Surbhi Bhati
* @description       : Test class for PublishedBooksScheduler
**/
@isTest
public class PublishedBooksSchedulerTest {


    static testMethod void myTestMethod() {        
         test.starttest();
         PublishedBooksScheduler schedulerClass = new PublishedBooksScheduler ();   
         String chron = '0 0 23 * * ?';        
         system.schedule('Test Sched', chron, schedulerClass);
         test.stopTest();
    }

}