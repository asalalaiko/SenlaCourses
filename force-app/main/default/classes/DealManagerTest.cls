@isTest
private class DealManagerTest {
    @testSetup
    static void makeData(){
        Contact seller = TestDataFactory.createContactPropertyOwner('Owner', '+375112223344', '+375112223355');
        Contact buyer = TestDataFactory.createContactBroker('Broker', '+37555666777', '+37588999999');
        Property__c property = TestDataFactory.createPropertyOffice(seller, 'Grodno', 1000.00, 10.00);

        for (Integer i = 0; i < 5; i++)
            TestDataFactory.createDealSale(seller, buyer, property) ;
                
        for (Integer i = 5; i < 10; i++)
           TestDataFactory.createDealLease(seller, buyer, property) ;

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
    
    @isTest  
    static void notCreateContactTest(){
        Contact seller = TestDataFactory.createContactPropertyOwner('NewOwner1', '+375112223344', '+375112223355');
        Contact buyer = TestDataFactory.createContactBroker('NewBroker1', '+37555666777', '+37588999999');
        Property__c property = TestDataFactory.createPropertyOffice(seller, 'Minsk', 1000.00, 10.00);

        DealManager.DealWrapper dealW = new DealManager.DealWrapper(); 
        dealW.type = TestDataFactory.DEAL_TYPE_SALE;
        dealW.property = property.id;
        dealW.seller = seller.id;
        dealW.buyer = buyer.id;
     
        DealManager.createDeal(dealW, false);
        List<Deal__c> cDeals = new List<Deal__c>();
        cDeals = [SELECT Id FROM Deal__c WHERE Contact__c =: seller.Id LIMIT 1];
        System.assertEquals(0, cDeals.size());
    }

    @isTest  
    static void getDealByNameTest(){
             System.assertEquals('D-100010', DealManager.getDealByName('D-100010', 'Name').Name);
    }

    @isTest  
    static void getDealByIdTest(){
        Deal__c c = new Deal__c();
        c = DealManager.getDealByName('D-100010', 'Name');
        System.assertEquals('D-100010', DealManager.getDealById(c.Id, 'Name').Name);

    }


    @isTest  
    static void getDealsByIdsTest(){
        List<Id> ids = new List<Id>();
        for (Integer i=0;i<5;i++) {
        ids.add(DealManager.getDealByName('D-10001'+i, 'Id').Id);
        }
        System.assertEquals(5, DealManager.getDealsByIds(ids,'Name').size());
    }

    @isTest  static void updateDealByIdTest(){
        Contact seller = TestDataFactory.createContactPropertyOwner('NewOwner1', '+375112223344', '+375112223355');
        Contact buyer = TestDataFactory.createContactBroker('NewBroker1', '+37555666777', '+37588999999');
        Contact buyer2 = TestDataFactory.createContactBroker('NewBroker2', '+37555616777', '+37588999299');
        Property__c property = TestDataFactory.createPropertyOffice(seller, 'Minsk', 1000.00, 10.00);
        Deal__C deal = TestDataFactory.createDealSale(seller, buyer, property);

        DealManager.DealWrapper dealW = new DealManager.DealWrapper(); 
        dealW.type = TestDataFactory.DEAL_TYPE_SALE;
        dealW.property = property.id;
        dealW.seller = seller.id;
        dealW.buyer = buyer2.id;

        Deal__c upDeal = new Deal__c();
        upDeal = DealManager.updateDealById(deal.Id, dealW, true);
        System.assertEquals(buyer2.Id, upDeal.Contact_buyer__c);
    }


    @isTest  
    static void deleteDealByIdTest(){
        Deal__c p = new Deal__c();
        p = DealManager.getDealByName('D-100010', 'Name');

        DealManager.deleteDealByID(p.id);
        
        List<Deal__c> cDeals = new List<Deal__c>();
        cDeals = [SELECT Id FROM Deal__c WHERE Name =: 'D-100010' LIMIT 1];
        System.assertEquals(0, cDeals.size());

    }

    @isTest  
    static void deleteDealByNameTest(){
        DealManager.deleteDealByName('P-100011');
        List<Deal__c> cDeals = new List<Deal__c>();
        cDeals = [SELECT Id FROM Deal__c WHERE Name =: 'P-100011' LIMIT 1];
        System.assertEquals(0, cDeals.size());

    }

}
