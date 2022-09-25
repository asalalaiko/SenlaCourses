public inherited sharing class LogManager {

    public class LogWrapper {
         public String name {get; set;}
         public String message {get; set;}   
    }

    public static Log__c createLog(LogWrapper wrapper, Boolean serialize) {
        Log__c log = new Log__c();
        log.Name = wrapper.name;
        log.Message__c = wrapper.message;
 
        if (serialize) insert log;
 
        return log;
    }

    public static Log__c getLogById(Id id, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Log__c WHERE Id IN :id LIMIT 1');
    }

    public static List<Log__c> getLogsByIds(List<Id> ids, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Log__c WHERE Id IN :ids');
    }

    public static Log__c getLogsByName(String name, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Log__c WHERE Name IN :name');
    }

    public static Log__c updateLogById(Id id, LogWrapper wrapper, Boolean serialize) {
        Log__c log = Database.query('SELECT Id FROM Log__c WHERE Id IN :id LIMIT 1');
        log.Name = wrapper.name;
        log.Message__c = wrapper.message;

        if (serialize) update log;    

        return log; 
    }

    public static void deleteLogByID(Id id) {
        delete [SELECT Id FROM Log__c WHERE  Id = :id];
    }

    public static void deleteLogByName(String name) {
        delete [SELECT Id FROM Log__c WHERE Name = :name];
    }
}