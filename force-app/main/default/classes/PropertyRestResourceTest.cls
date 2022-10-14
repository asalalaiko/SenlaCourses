@IsTest
public class PropertyRestResourceTest {
    @testSetup 
    static void setup() {
        Contact owner1 = TestDataFactory.createContactPropertyOwner('BigBoss', '+375112223344', '+375112223355');
        Contact owner2 = TestDataFactory.createContactPropertyOwner('BigBoss2', '+37512223344', '+375182623355');


        Property__c prop1 = TestDataFactory.createPropertyOffice(owner1, 'Minsk', 1000.00, 10.00);
        Property__c prop2 = TestDataFactory.createPropertyOffice(owner2, 'Grodno', 100.00, 1.00);

        
        Deal__c lease1 = TestDataFactory.createDealSale(owner1, owner2, prop1);
        Deal__c lease2 = TestDataFactory.createDealSale(owner1, owner2, prop1);
        Deal__c sale1 = TestDataFactory.createDealLease(owner2, owner1, prop2);
        Deal__c sale2 = TestDataFactory.createDealLease(owner2, owner1, prop2);
    }      

    @isTest static void getPropertyByOwnerTest() {

        Contact owner  = [SELECT Id FROM Contact WHERE Firstname = 'FirstBigBoss' LIMIT 1];

        ID recordId = owner.Id;

        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();

        req.requestUri =
            'https://senlacourses2-dev-ed.lightning.force.com/services/apexrest/propery/v1/by_owner?owner='
            + recordId;
            req.httpMethod = 'GET';

        RestContext.request = req;
        RestContext.response= res;

        Test.startTest();
        PropertyRestResource.doGet();
        Test.stopTest();

        System.assert(res != null);
        System.assertEquals(200, res.statusCode);
    }


}
