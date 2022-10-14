@isTest
public class BatchEndedLeaseDealsTest {
    
    @testSetup
    static void setup() {
        Contact seller = TestDataFactory.createContactPropertyOwner('Owner', '+375112223344', '+375112223355');
        Contact buyer = TestDataFactory.createContactBroker('Broker', '+37555666777', '+37588999999');
        Property__c property = TestDataFactory.createPropertyOffice(seller, 'Grodno', 1000.00, 10.00);

        for (Integer i = 0; i < 50; i++)
            TestDataFactory.createDealLeaseFinishLeaseTomorrow(seller, buyer, property) ;

    }

    @isTest static void test() {
        Test.startTest();
        BatchEndedLeaseDeals uca = new BatchEndedLeaseDeals();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();


        List<Log__c> log = [SELECT Id, Message__c FROM Log__c WHERE Name = 'BatchEndedLeaseDeals' LIMIT 1];

        System.assertEquals(0, log.size());
        
    }
}
