@isTest
public  class ClientServiceTest {
    @isTest static void test() {
        Lead lead = ClientService.getClient();
        System.assertEquals('Test', lead.LastName);
        System.assertEquals('test@test.test', lead.Email);
    }
}
