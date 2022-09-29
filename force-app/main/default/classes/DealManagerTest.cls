@isTest
private class DealManagerTest {
    @testSetup
    static void makeData(){
        Contact seller = TestDataFactory.createContactPropertyOwner('Owner', '+375112223344', '+375112223355');
        Contact buyer = TestDataFactory.createContactBroker('Broker', '+37555666777', '+37588999999');
        Property__c property = TestDataFactory.createPropertyOffice(seller, 'Grodno', 1000.00, 10.00);
        
        for (Integer i = 0; i < 5; i++)
            TestDataFactory.createDealSale(seller, buyer, property) ;
                
        // for (Integer i = 5; i < 10; i++)
        //     TestDataFactory.createDealLease(seller, buyer, property) ;

    }

    @isTest  
    static void createDealTest(){
        Contact seller = TestDataFactory.createContactPropertyOwner('NewOwner', '+375112223344', '+375112223355');
        Contact buyer = TestDataFactory.createContactBroker('NewBroker', '+37555666777', '+37588999999');
        Property__c property = TestDataFactory.createPropertyOffice(seller, 'NewGrodno', 1000.00, 10.00);

        DealManager.DealWrapper dealW = new DealManager.DealWrapper(); 
        dealW.type = TestDataFactory.DEAL_TYPE_SALE;
        dealW.property = property.id;
        dealW.seller = seller.id;
        dealW.buyer = buyer.id;
     
        System.assertEquals(seller.Id, DealManager.createDeal(dealW, true).Contact__c);
    }
    
    // @isTest  
    // static void notCreateContactTest(){
    //     Contact contact = TestDataFactory.createContactPropertyOwner('BigBoss', '+375112223344', '+375112223355');

    //     PropertyManager.PropertyWrapper propertyW = new PropertyManager.PropertyWrapper(); 
    //     propertyW.type = TestDataFactory.PROPERTY_TYPE_OFFICE;
    //     propertyW.address = 'Grodno, sq.Lenina, 1';
    //     propertyW.sellingPrice = 100.00;
    //     propertyW.reptPrice = 1.00;
    //     propertyW.contact = contact.Id;
    //     PropertyManager.createProperty(propertyW, false);
    //     List<Property__c> cPropertyes = new List<Property__c>();
    //     cPropertyes = [SELECT Id FROM Property__c WHERE Address__c =: 'Grodno, sq.Lenina, 1' LIMIT 1];
    //     System.assertEquals(0, cPropertyes.size());
    // }

}
