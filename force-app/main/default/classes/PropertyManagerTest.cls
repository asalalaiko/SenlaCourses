@isTest
private class PropertyManagerTest {
    
    @testSetup
    static void makeData(){
        Contact contact = TestDataFactory.createContactPropertyOwner('Owner', '+375112223344', '+375112223355');

        for (Integer i = 0; i < 5; i++)
            TestDataFactory.createPropertyIndustrial(contact, 'Address'+String.valueOf(i), 1000.00, 1.00) ;
                
        for (Integer i = 5; i < 10; i++)
            TestDataFactory.createPropertyOffice(contact, 'Address'+String.valueOf(i), 2000.00, 2.00);

        for (Integer i = 10; i < 15; i++)
            TestDataFactory.createPropertySpace(contact, 'Address'+String.valueOf(i), 3000.00, 3.00);
    }

    @isTest  
    static void createPropertyTest(){
        Contact contact = TestDataFactory.createContactPropertyOwner('BigBoss', '+375112223344', '+375112223355');

        PropertyManager.PropertyWrapper propertyW = new PropertyManager.PropertyWrapper(); 
        propertyW.type = TestDataFactory.PROPERTY_TYPE_OFFICE;
        propertyW.address = 'Grodno, Gorkogo str., 91';
        propertyW.sellingPrice = 100000.00;
        propertyW.reptPrice = 100.00;
        propertyW.contact = contact.Id;
        
         System.assertEquals('Grodno, Gorkogo str., 91', PropertyManager.createProperty(propertyW, true).Address__c);
    }
    
    @isTest  
    static void notCreateContactTest(){
        Contact contact = TestDataFactory.createContactPropertyOwner('BigBoss', '+375112223344', '+375112223355');

        PropertyManager.PropertyWrapper propertyW = new PropertyManager.PropertyWrapper(); 
        propertyW.type = TestDataFactory.PROPERTY_TYPE_OFFICE;
        propertyW.address = 'Grodno, sq.Lenina, 1';
        propertyW.sellingPrice = 100.00;
        propertyW.reptPrice = 1.00;
        propertyW.contact = contact.Id;
        PropertyManager.createProperty(propertyW, false);
        List<Property__c> cPropertyes = new List<Property__c>();
        cPropertyes = [SELECT Id FROM Property__c WHERE Address__c =: 'Grodno, sq.Lenina, 1' LIMIT 1];
        System.assertEquals(0, cPropertyes.size());
    }

    @isTest  
    static void getPropertyesByAddress(){
        
        System.assertEquals(15, PropertyManager.getPropertyesByAddress('Address', 'Address__c').size());
    }

    @isTest  
    static void getPropertyByNameTest(){
             System.assertEquals('P-100010', PropertyManager.getPropertyByName('P-100010', 'Name').Name);
    }

    @isTest  
    static void getPropertyByIdTest(){
        Property__c p= new Property__c();
        p = PropertyManager.getPropertyByName('P-100010', 'Name');
        System.assertEquals('P-100010', PropertyManager.getPropertyById(p.Id, 'Name').Name);

    }


    @isTest  
    static void updatePropertyByIdTest(){
        Contact contact = TestDataFactory.createContactPropertyOwner('BigBoss2', '+37512223344', '+375182623355');

        Property__c p = new Property__c();
        p = PropertyManager.getPropertyByName('P-100010', 'id');
        

        PropertyManager.PropertyWrapper propertyW = new PropertyManager.PropertyWrapper(); 
        propertyW.type = TestDataFactory.PROPERTY_TYPE_OFFICE;
        propertyW.address = 'Grodno, sq.Lenina, 2';
        propertyW.sellingPrice = 200.00;
        propertyW.reptPrice = 2.00;
        propertyW.contact = contact.Id;

        Property__c upProperty = new Property__c();
        upProperty = PropertyManager.updatePropertyById(p.Id, PropertyW, true);
        System.assertEquals('Grodno, sq.Lenina, 2', upProperty.Address__c);
    }

    @isTest  
    static void gettPropertyesByIdsTest(){
        List<Id> ids = new List<Id>();
        for (Integer i=0;i<5;i++) {
        ids.add(PropertyManager.getPropertyByName('P-10001'+i, 'Id').Id);
        }
        System.assertEquals(5, PropertyManager.getPropertyesByIds(ids,'Name').size());
    }

    @isTest  
    static void deletePropertyByIdTest(){
        Property__c p = new Property__c();
        p = PropertyManager.getPropertyByName('P-100010', 'Name');

        PropertyManager.deletePropertyByID(p.id);
        
        List<Property__c> cPropertyes = new List<Property__c>();
        cPropertyes = [SELECT Id FROM Property__c WHERE Name =: 'P-100010' LIMIT 1];
        System.assertEquals(0, cPropertyes.size());

    }

    @isTest  
    static void deletePropertyByNameTest(){
        PropertyManager.deletePropertyByName('P-100011');
        List<Property__c> cPropertyes = new List<Property__c>();
        cPropertyes = [SELECT Id FROM Property__c WHERE Name =: 'P-100011' LIMIT 1];
        System.assertEquals(0, cPropertyes.size());

    }


}
