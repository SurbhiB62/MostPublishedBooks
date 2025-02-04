/**
* @author            : Surbhi Bhati
* @description       : Test class for PublishedBooksHandle
**/
@isTest
public class PublishedBooksHandlerTest {
    
    @isTest static void testCallout() {
        // Set mock callout class 
        // 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock.
        PublishedBooksHandler  handler = new  PublishedBooksHandler();
        PublishedBooksHandler.getPublishedBooksDetails();

        
    }
    
    
     @testSetup
    static void setupData() {
        // No specific data setup needed as we are mocking the callout
    }
    
    @isTest
    static void testGetPublishedBooksDetails_Success() {
        Test.startTest();
        
        // Mocking the HTTP response
        String mockResponse = '[{"Publisher":"Test Publisher","Books":[{"Author":"Test Author","Title":"Test Title","Edition":700000}]}]';
        
        HttpResponse mockHttpResponse = new HttpResponse();
        mockHttpResponse.setBody(mockResponse);
        mockHttpResponse.setStatusCode(200);
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse(mockHttpResponse));
        
        // Call the method
        PublishedBooksHandler.getPublishedBooksDetails();
        
        Test.stopTest();
        
        // Validate that platform event records were created
       
    }
    
    @isTest
    static void testGetPublishedBooksDetails_EmptyResponse() {
        Test.startTest();
        
        // Mocking an empty HTTP response
        HttpResponse mockHttpResponse = new HttpResponse();
        mockHttpResponse.setBody('[]');
        mockHttpResponse.setStatusCode(200);
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse(mockHttpResponse));
        
        PublishedBooksHandler.getPublishedBooksDetails();
        
        Test.stopTest();
        

    }
    
    @isTest
    static void testGetPublishedBooksDetails_FailedResponse() {
        Test.startTest();
        
        // Mocking a failed HTTP response
        HttpResponse mockHttpResponse = new HttpResponse();
        mockHttpResponse.setStatusCode(500);
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse(mockHttpResponse));
        
        PublishedBooksHandler.getPublishedBooksDetails();
        
        Test.stopTest();
        

    }
    
    @isTest
    static void testPublishBookEvnt() {
        Test.startTest();
        
        List<MostPublishedBook__e> events = new List<MostPublishedBook__e>();
        events.add(new MostPublishedBook__e(Author__c='Author A', Title__c='Title A', Publisher__c='Publisher A', Edition__c=700000));
        
        PublishedBooksHandler.publishBookEvnt(events);
        
        Test.stopTest();
        

    }
    
    // Mock class for HTTP Callout
    private class MockHttpResponse implements HttpCalloutMock {
        private HttpResponse response;
        
        public MockHttpResponse(HttpResponse response) {
            this.response = response;
        }
        
        public HttpResponse respond(HttpRequest req) {
            return response;
        }
    }

}