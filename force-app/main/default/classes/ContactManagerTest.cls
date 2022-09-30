@isTest
private class ContactManagerTest {
    
    @testSetup
    static void makeData(){
        for (Integer i = 0; i < 5; i++)
                TestDataFactory.createContactBroker(String.valueOf(i), '+37529111111'+String.valueOf(i),'+37515211111'+String.valueOf(i));

        for (Integer i = 6; i < 10; i++)
                TestDataFactory.createContactPropertyOwner(String.valueOf(i), '+37529111111'+String.valueOf(i),'+37515211111'+String.valueOf(i));

    }

    @isTest  static void createContactTest(){
        ContactManager.ContactWrapper contactW = new ContactManager.ContactWrapper(); 
        contactW.firstName = 'FirstName for Create';
        contactW.lastName = 'Last for Create';
        contactW.phone = '+375XXXXXXXXX';
        contactW.homePhone = '+375152xxxxxx';
        contactW.email = 'create@contact.by';
        contactW.type = TestDataFactory.CONTACT_TYPE_BROKER;
        
        System.assertEquals('FirstName for Create', ContactManager.createContact(contactW, true).firstName);
    }

    @isTest  static void notCreateContactTest(){
        ContactManager.ContactWrapper contactW = new ContactManager.ContactWrapper(); 
        contactW.firstName = 'FirstName for NOTCreate';
        contactW.lastName = 'Last for NOTCreate';
        contactW.phone = '+375XXXXXXXXX';
        contactW.homePhone = '+375152xxxxxx';
        contactW.email = 'create@contact.by';
        contactW.type = TestDataFactory.CONTACT_TYPE_BROKER;
        
        ContactManager.createContact(contactW, false);
        List<Contact> cContacts = new List<Contact>();
        cContacts = [SELECT Id FROM Contact WHERE firstName =: 'FirstName for NOTCreate' LIMIT 1];
        System.assertEquals(0, cContacts.size());
    }

    @isTest  static void getContactByNameTest(){
        System.assertEquals('First1 Last1', ContactManager.getContactByName('First1 Last1', 'Name').Name);
    }

    @isTest  static void getContactByIdTest(){
        Contact c = new Contact();
        c = ContactManager.getContactByName('First1 Last1', 'Name');
        System.assertEquals('First1 Last1', ContactManager.getContactById(c.Id, 'Name').name);

    }

    @isTest  static void getContactsByIdsTest(){
        List<Id> ids = new List<Id>();
        for (Integer i=0;i<5;i++) {
        ids.add(ContactManager.getContactByName('First'+i+ ' Last' +i, 'Id').Id);
        }
        System.assertEquals(5, ContactManager.getContactsByIds(ids,'Name').size());
    }

    @isTest  static void updateContactByIdTest(){
        Contact c = new Contact();
        c = ContactManager.getContactByName('First1 Last1', 'id');

        ContactManager.ContactWrapper contactW = new ContactManager.ContactWrapper(); 
        contactW.firstName = 'FirstName for Updated';
        contactW.lastName = 'Last for Updated';
        contactW.phone = '+375XXXXXXXXX';
        contactW.homePhone = '+375152xxxxxx';
        contactW.email = 'update@contact.by';
        contactW.type = TestDataFactory.CONTACT_TYPE_PROPERTY_OWNER;

        Contact upContact = new Contact();
        upContact = ContactManager.updateContactById(c.Id, ContactW, true);
        System.assertEquals('FirstName for Updated', upContact.FirstName);
    }

    @isTest  static void deleteContactByIdTest(){
        Contact c = new Contact();
        c = ContactManager.getContactByName('First2 Last2', 'Name');

        ContactManager.deleteContactByID(c.id);
        
        List<Contact> cContacts = new List<Contact>();
        cContacts = [SELECT Id FROM Contact WHERE Name =: 'First2 Last2' LIMIT 1];
        System.assertEquals(0, cContacts.size());

    }

    @isTest  static void deleteContactByNameTest(){
        ContactManager.deleteContactByName('First3 Last3');
        List<Contact> cContacts = new List<Contact>();
        cContacts = [SELECT Id FROM Contact WHERE Name =: 'First3 Last3' LIMIT 1];
        System.assertEquals(0, cContacts.size());

    }

}
