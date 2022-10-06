@isTest
private class DealTriggerHandlerTest {
    
    @isTest  
    static void afterUpdateTest(){

        Contact seller = TestDataFactory.createContactPropertyOwner('NewOwner1', '+375112223344', '+375112223355');
        Contact buyer = TestDataFactory.createContactBroker('NewBroker1', '+37555666777', '+37588999999');
        Property__c property = TestDataFactory.createPropertyOffice(seller, 'Minsk', 1000.00, 10.00);

        for (Integer i = 0; i < 10; i++)
            TestDataFactory.createDealOpenSale(seller,buyer,property);
            
        Deal__c dealNew = TestDataFactory.createDealOpenSale(seller, buyer, property);

        DealManager.updateDealToCloseWon(dealNew);

        List<Deal__c> deals = [SELECT id FROM Deal__c WHERE Status__c = :TestDataFactory.DEAL_STATUS_CLOSED_LOST];

        System.assertEquals(10, deals.size());
    
    }

}
