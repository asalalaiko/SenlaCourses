@IsTest
public class PropertyRestResourceTest {
    @testSetup 
    static void setup() {
        Contact owner1 = TestDataFactory.createContactPropertyOwner('BigBoss', '+375112223344', '+375112223355');
        Contact owner2 = TestDataFactory.createContactPropertyOwner('BigBoss2', '+37512223344', '+375182623355');


        Property__c prop1 = TestDataFactory.createPropertyOffice(owner1, 'Minsk', 1000.00, 10.00);
        
    }      

    @isTest static void getPropertyByOwnerTest() {
        
    }


}
