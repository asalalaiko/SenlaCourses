public inherited sharing class PropertyManager {

    private static final String DEFAULT_TYPE = 'Office';

    public class PropertyWrapper {
        public String type {get; set;}
        public String address {get; set;}   
        public String sellingPrice {get; set;}   
        public String reptPrice {get; set;}   
        public String contact {get; set;}   
    }

    public static Property__c createProperty(PropertyWrapper wrapper, Boolean serialize) {
        
        Property__c property = new Property__c();

        property.RecordTypeId = (String.isNotBlank(wrapper.type)) ?
                               [SELECT Id FROM RecordType WHERE Name = :wrapper.type limit 1].Id : 
                               [SELECT Id FROM RecordType WHERE Name = :DEFAULT_TYPE limit 1].Id;
        property.Address__c = wrapper.address;
        property.Selling_price__c = Decimal.valueOf(wrapper.sellingPrice);
        property.Rent_price__c = Decimal.valueOf(wrapper.reptPrice);
        property.Contact__c = [SELECT Id FROM Contact WHERE Name = :wrapper.contact limit 1].Id;

        if (serialize) insert property;
 
        return property;
    }

    public static Property__c getPropertyById(Id id, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Property__c WHERE Id IN :id LIMIT 1');
    }   

   public static List<Property__c> getPropertyesByIds(List<Id> ids, String fields) {
       return Database.query('SELECT ' + fields + ' FROM Property__c WHERE Id IN :ids');
    }

    public static Property__c getPropertyByName(String name, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Property__c WHERE Name IN :name LIMIT 1');
    } 

    public static Property__c updatePropertyByID(Id id, PropertyWrapper wrapper, Boolean serialize) {
        
        Property__c property = Database.query('SELECT Id FROM Property__c WHERE Id IN :id LIMIT 1');

        property.RecordTypeId = (String.isNotBlank(wrapper.type)) ?
                              [SELECT Id FROM RecordType WHERE Name = :wrapper.type limit 1].Id : 
                              [SELECT Id FROM RecordType WHERE Name = :DEFAULT_TYPE limit 1].Id;
        property.Address__c = wrapper.address;
        property.Selling_price__c = Decimal.valueOf(wrapper.sellingPrice);
        property.Rent_price__c = Decimal.valueOf(wrapper.reptPrice);
        property.Contact__c = [SELECT Id FROM Contact WHERE Name = :wrapper.contact limit 1].Id;
         
        if (serialize) update property; 
    
       return property;
    }

    public static void deletePropertyByID(Id id) {
        delete [SELECT id FROM Property__c WHERE Id = :id];
    }

    public static void deletePropertyByName(String name) {
    
        delete [SELECT id FROM Property__c WHERE Name = :name];

    }
}
