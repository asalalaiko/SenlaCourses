@isTest
private class LogManagerTest {
    @testSetup
    static void makeData(){

        TestDataFactory.createLogs(10);
       
    }

    @isTest  static void createLogTest(){
        LogManager.LogWrapper logW = new LogManager.LogWrapper(); 
         logW.name = 'LogForCreate';
         logW.message = 'Message LogForCreate';
        
         System.assertEquals('LogForCreate',LogManager.createLog(logW, true).Name);
    }

    @isTest  static void notCreateLogTest(){
        LogManager.LogWrapper logW = new LogManager.LogWrapper(); 
        logW.name = 'LogForNotCreate';
        logW.message = 'Message LogForNotCreate';
        
        LogManager.createLog(logW, false);

        List<Log__c> cLogs = new List<Log__c>();
        cLogs = [SELECT Id FROM Log__c WHERE Name =: 'LogForNotCreate' LIMIT 1];
        System.assertEquals(0, cLogs.size());
    }

    @isTest  static void getLogByNameTest(){
        System.assertEquals('TestLog1', LogManager.getLogByName('TestLog1', 'Name').Name);
    }

    @isTest  static void getLogByIdTest(){
        Log__c log = new Log__c();
        log = LogManager.getLogByName('TestLog1', 'Name');
        System.assertEquals('TestLog1', LogManager.getLogById(log.Id, 'Name').name);

    }

    @isTest  static void getLogsByIdsTest(){
        List<Id> ids = new List<Id>();
        for (Integer i=0;i<10;i++) {
        ids.add(LogManager.getLogByName('TestLog'+i, 'Id').Id);
        }
        System.assertEquals(10, LogManager.getLogsByIds(ids,'Name').size());
    }

    @isTest  static void updateLogByIdTest(){
        Log__c log = new Log__c();
        log = LogManager.getLogByName('TestLog1', 'id');

        LogManager.LogWrapper logW = new LogManager.LogWrapper(); 
        logW.name = 'UpdatedLog';
        logW.message = 'Message UpdatedLog';
        
        Log__c upLog = new Log__c();
        upLog = LogManager.updateLogById(log.Id, logW, true);
        System.assertEquals('UpdatedLog', upLog.Name);
    }


    @isTest  static void deleteLogByIdTest(){
        Log__c log = new Log__c();
        log = LogManager.getLogByName('TestLog2', 'Name');

        LogManager.deleteLogByID(log.id);
        
        List<Log__c> cLogs = new List<Log__c>();
        cLogs = [SELECT Id FROM Log__c WHERE Name =: 'TestLog2' LIMIT 1];
        System.assertEquals(0, cLogs.size());

    }

    @isTest  static void deleteLogByNameTest(){
        LogManager.deleteLogByName('TestLog3');
        List<Log__c> cLogs = new List<Log__c>();
        cLogs = [SELECT Id FROM Log__c WHERE Name =: 'TestLog3' LIMIT 1];
        System.assertEquals(0, cLogs.size());

    }
}

