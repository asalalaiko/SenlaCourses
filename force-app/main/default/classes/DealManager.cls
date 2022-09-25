public inherited sharing class DealManager {
    
    private static final String DEFAULT_TYPE = 'Sale';

    public class DealWrapper {
        public String type {get; set;}
        public String property {get; set;}   
        public String buyer {get; set;}   
        public String seller {get; set;}   
    }

    public static Deal__c createDeal(DealWrapper wrapper, Boolean serialize) {
        
        Deal__c deal = new Deal__c();

        deal.RecordTypeId = (String.isNotBlank(wrapper.type)) ?
                               [SELECT Id FROM RecordType WHERE Name = :wrapper.type limit 1].Id : 
                               [SELECT Id FROM RecordType WHERE Name = :DEFAULT_TYPE limit 1].Id;
        
        deal.Property__c = [SELECT Id FROM Property__c WHERE Name = :wrapper.seller limit 1].Id;
        deal.Contact_buyer__c = [SELECT Id FROM Contact WHERE Name = :wrapper.buyer limit 1].Id;
        deal.Contact__c = [SELECT Id FROM Contact WHERE Name = :wrapper.seller limit 1].Id;
        
        if (serialize) insert deal;
 
        return deal;
    }

    public static Deal__c getDealById(Id id, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Deal__c WHERE Id IN :id LIMIT 1');
    }   

    public static List<Deal__c> getDealsByIds(List<Id> ids, String fields) {
       return Database.query('SELECT ' + fields + ' FROM Deal__c WHERE Id IN :ids');
    }

    public static Deal__c getDealByName(String name, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Deal__c WHERE Name IN :name LIMIT 1');
    }

    public static Deal__c updateDealByID(Id id, DealWrapper wrapper, Boolean serialize) {
        
        Deal__c deal = Database.query('SELECT Id FROM Deal__c WHERE Id IN :id LIMIT 1');

        deal.RecordTypeId = (String.isNotBlank(wrapper.type)) ?
                               [SELECT Id FROM RecordType WHERE Name = :wrapper.type limit 1].Id : 
                               [SELECT Id FROM RecordType WHERE Name = :DEFAULT_TYPE limit 1].Id;
        
        deal.Property__c = [SELECT Id FROM Property__c WHERE Name = :wrapper.seller limit 1].Id;
        deal.Contact_buyer__c = [SELECT Id FROM Contact WHERE Name = :wrapper.buyer limit 1].Id;
        deal.Contact__c = [SELECT Id FROM Contact WHERE Name = :wrapper.seller limit 1].Id;
         
        if (serialize) update deal; 
    
       return deal;
    }

    public static void deleteDealByID(Id id) {
        delete [SELECT id FROM Deal__c WHERE Id = :id];
    }

    public static void deleteDealByName(String name) {
        delete [SELECT id FROM Deal__c WHERE Name = :name];
    }



}