@isTest
public class PropertyOwnerInfoReportControllerTest {
    @TestSetup
    static void setup(){
        Contact seller = TestDataFactory.createContactPropertyOwner('NewOwner1', '+375112223344', '+375112223355');
        Contact buyer = TestDataFactory.createContactBroker('NewBroker1', '+37555666777', '+37588999999');
        Property__c property = TestDataFactory.createPropertyOffice(seller, 'Minsk', 1000.00, 10.00);
        Property__c property2 = TestDataFactory.createPropertyOffice(seller, 'Minsk', 2000.00, 20.00);

        for (Integer i = 0; i < 10; i++){
            TestDataFactory.createDealCloseWonSale(seller,buyer,property);
            TestDataFactory.createDealCloseWonSale(seller,buyer,property2);
        }
    }


    @isTest Public static void testController(){
        PageReference testPage = Page.PropertyOwnerInfoReport;
        Test.setCurrentPage(testPage);


        
        testPage.getParameters().put('id', String.valueOf(ContactManager.getContactByName('FirstNewOwner1 LastNewOwner1', 'Id').Id));

        PropertyOwnerInfoReportController testController = new PropertyOwnerInfoReportController();
        testController.getPropertyInfo();

        System.assertEquals(30000.00, testController.totalPrice);

    }
}
