@isTest
private class LogLWCManagerTest {
    @testSetup 
    static void setup() 
    {      
        List<LogLWC__c> logLWCs = TestDataFactory.createLogLWCsForInsertObject('Property__c',10);
    }
    
    @isTest static void createLogLWC(){
        LogLWCManager.LogLWCWrapper wrapper = new LogLWCManager.LogLWCWrapper();
        wrapper.objectType = 'Property__c';
        wrapper.actionType = 'Insert';
        wrapper.description = 'Insert 1 records';
        wrapper.isSuccessful = true;
        wrapper.errorMessage = '';

        LogLWC__c resultLog = LogLWCManager.createLogLWC(wrapper, false);
        System.assertEquals(true, resultLog.IsSuccessful__c);
    }

    @isTest static void testGetLogLWCs(){
        List<LogLWC__c> logsList = [SELECT Id FROM LogLWC__c];
        List<LogLWC__c> resultLogsList = LogLWCManager.getLogLWCs('Id');
        System.assertEquals(logsList.size(), resultLogsList.size());
    }
}
