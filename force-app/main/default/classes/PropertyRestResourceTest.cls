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


    @isTest static void getPropertyReportTest() {
        Property__c prop = [SELECT Id FROM Property__c WHERE Address__c = 'Minsk' LIMIT 1];
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();

        req.requestUri = 'https://senlacourses2-dev-ed.lightning.force.com/services/apexrest/propery/v1/report/' 
                        + prop.Id +'?startDate='
                        +DateTime.now().format('yyyy-MM-dd')+'&endDate='
                        +DateTime.now().format('yyyy-MM-dd')+'&dealType=Lease';

        
        req.httpMethod = 'GET';
        
        RestContext.request = req;
        RestContext.response= res;

        Test.startTest();
        PropertyRestResource.doGet();
        Test.stopTest();
        
        System.assert(res != null);
        System.assertEquals(200, res.statusCode);
    }

    @isTest static void createPropertyTest() {
        Contact owner  = [SELECT Id FROM Contact WHERE Firstname = 'FirstBigBoss' LIMIT 1];

        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();

        Wrappers.PropertyPostWrapper wrap = new Wrappers.PropertyPostWrapper();
        wrap.type = 'Office';
        wrap.country = 'USA';
        wrap.city = 'NY';
        wrap.address = 'Cental st.';
        wrap.ownerID = String.valueOf(owner.Id);
        wrap.rentalPrice = '500';
        wrap.sellingPrice = '10000';

        req.requestURI = 'https://senlacourses2-dev-ed.lightning.force.com/services/apexrest/propery/v1/add';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(JSON.serializePretty(wrap));

        RestContext.request = req;
   	    RestContext.response= res;
        
        Test.startTest();
        PropertyRestResource.createProperty();
        Test.stopTest();

        System.assertEquals(200, res.statusCode);
    }

    @isTest static void updatePropertyOwnerTest() {
        Contact owner  = [SELECT Id FROM Contact WHERE Firstname = 'FirstBigBoss' LIMIT 1];
        Property__c prop = [SELECT Id FROM Property__c WHERE Address__c = 'Grodno' LIMIT 1];

        Wrappers.PropertyPutWrapper wrap = new Wrappers.PropertyPutWrapper();
        wrap.propertyId = prop.Id;
        wrap.newOwner= new Wrappers.Client();
        wrap.newOwner.sfId = owner.Id;
        wrap.newOwner.firstName = 'David';
        wrap.newOwner.lastName = 'Duchowny';
        wrap.newOwner.email = 'david.du@facke.com';

        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();

        req.requestUri = 'https://senla50-dev-ed.my.salesforce.com/services/data/v55.0/sobjects/propery/v1';
        req.httpMethod = 'PUT';
        req.requestBody = Blob.valueOf(JSON.serialize(wrap));

        RestContext.request = req;
   	    RestContext.response= res;

           Test.startTest();
           PropertyRestResource.updatePropertyOwner();
           Test.stopTest();
    }

}
