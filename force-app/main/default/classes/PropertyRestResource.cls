@RestResource(urlMapping='/propery/v1/*')
global class PropertyRestResource {

    @HttpGet
    global static Property__c doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);

        System.debug('==========='+ req.requestURI);
        System.debug('==========='+ accountId);
        Property__c result = [SELECT Id, Name  FROM Property__c WHERE Id = :accountId ];
        return result;
    
}
}