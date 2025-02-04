@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        //System.assertEquals('https://example.com/example/test', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
		 String mockResponse = '[{"Publisher":"Test Publisher","Books":[{"Author":"Test Author","Title":"Test Title","Edition":700000}]}]';
       HttpResponse mockHttpResponse = new HttpResponse();
        mockHttpResponse.setBody(mockResponse);
        return mockHttpResponse;
    }
}