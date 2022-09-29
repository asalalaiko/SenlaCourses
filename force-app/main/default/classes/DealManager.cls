public inherited sharing class DealManager {
    
    private static final String DEFAULT_TYPE = 'Sale';

    public class DealWrapper {
        public Id type {get; set;}
        public Id property {get; set;}   
        public Id buyer {get; set;}   
        public Id seller {get; set;}   
    }

    public static Deal__c createDeal(DealWrapper wrapper, Boolean serialize) {
        
        Deal__c deal = new Deal__c();

        deal.RecordTypeId = wrapper.type;
        deal.Property__c = wrapper.property;
        deal.Contact_buyer__c = wrapper.buyer;
        deal.Contact__c = wrapper.seller;
        
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

        deal.RecordTypeId = wrapper.type;
        deal.Property__c = wrapper.property;
        deal.Contact_buyer__c = wrapper.buyer;
        deal.Contact__c = wrapper.seller;
         
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