@isTest
private class SendEmailEndedLeaseTest {
    @testSetup
    static void setup() {
       
        for (Integer i = 0; i < 10; i++)
         TestDataFactory.createContactPropertyOwner('Owner'+i, '+375112223344', '+375112223355');

    }


    @IsTest
   static void testThatEmailWasSent(){
        List<Id> idContacts = new List<id>();

        List<Contact> contacts = [SELECT Id, Email FROM Contact WHERE Name LIKE '%Owner%' LIMIT 10];
        for (Contact contact : contacts)
        idContacts.add(contact.id);


       Test.startTest();
       System.assertEquals(0, Limits.getEmailInvocations(), 'No emails should be sent');

       SendEmailEndedLease.sendEmails(idContacts);

       System.assertEquals(1, Limits.getEmailInvocations(), 'Emails should be sent');
       Test.stopTest();
   }
}
