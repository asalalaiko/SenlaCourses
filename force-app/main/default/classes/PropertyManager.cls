public class PropertyManager {

    private static final String DEFAULT_TYPE = 'Office';

    public class PropertyWrapper {
        public Id type {get; set;}
        public String address {get; set;}   
        public Decimal sellingPrice {get; set;}   
        public Decimal reptPrice {get; set;}   
        public Id contact {get; set;}   
    }

    public static Property__c createProperty(PropertyWrapper wrapper, Boolean serialize) {
        
        Property__c property = new Property__c();

        property.RecordTypeId = wrapper.type;
        property.Address__c = wrapper.address;
        property.Selling_price__c = wrapper.sellingPrice;
        property.Rent_price__c = wrapper.reptPrice;
        property.Contact__c = wrapper.contact;

        if (serialize) insert property;
 
        return property;
    }

    public static Property__c getPropertyById(Id id, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Property__c WHERE Id = :id LIMIT 1');
    }   

   public static List<Property__c> getPropertyesByIds(List<Id> ids, String fields) {
       return Database.query('SELECT ' + fields + ' FROM Property__c WHERE Id IN :ids');
    }

    public static Property__c getPropertyByName(String name, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Property__c WHERE Name = :name LIMIT 1');
    } 

    public static List<Property__c> getPropertyesByAddress(String address, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Property__c WHERE Address__c LIKE \'%'+ address +'%\' LIMIT 100');
    } 

    
    public static Property__c updatePropertyByID(Id id, PropertyWrapper wrapper, Boolean serialize) {
        
        Property__c property = Database.query('SELECT Id FROM Property__c WHERE Id = :id LIMIT 1');

        property.RecordTypeId = wrapper.type;
        property.Address__c = wrapper.address;
        property.Selling_price__c = wrapper.sellingPrice;
        property.Rent_price__c = wrapper.reptPrice;
         
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
