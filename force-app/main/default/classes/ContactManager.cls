public inherited sharing class ContactManager {

    private static final String DEFAULT_TYPE = [SELECT Id FROM RecordType WHERE Name = 'Property Owner' LIMIT 1].Id;
    private static final Id CONTACT_TYPE_PROPERTY_OWNER = [SELECT Id FROM RecordType WHERE Name = 'Property Owner' LIMIT 1].Id;
    private static final Id CONTACT_TYPE_BROKER = [SELECT Id FROM RecordType WHERE Name = 'Broker' LIMIT 1].Id;

    public class ContactWrapper {
        public Id type {get; set;}
        public String firstName {get; set;}   
        public String lastName {get; set;}   
        public String phone {get; set;}   
        public String homePhone {get; set;}   
        public String email {get; set;}   
    }

    public static Contact createContact(ContactWrapper wrapper, Boolean serialize) {
        Contact contact = new Contact();
        contact.RecordTypeId = wrapper.type;
        contact.FirstName = wrapper.firstName;
        contact.LastName = wrapper.lastName;
        contact.Phone = wrapper.phone; //how convert String to Phone?
        contact.HomePhone = wrapper.homePhone;
        contact.Email = wrapper.email;

       if (serialize) insert contact;

       return contact;
    }

    public static Contact getContactById(Id id, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Contact WHERE Id = :id LIMIT 1');
    }   

   public static List<Contact> getContactsByIds(List<Id> ids, String fields) {
       return Database.query('SELECT ' + fields + ' FROM Contact WHERE Id IN :ids');
    }

    public static Contact getContactByName(String name, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Contact WHERE Name = :name LIMIT 1');
    }   

    public static Contact getContactByEmail(String email, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Contact WHERE Email = :email LIMIT 1');
    } 

    public static Contact updateContactByID(Id id, ContactWrapper wrapper, Boolean serialize) {
       Contact contact = Database.query('SELECT Id FROM Contact WHERE Id = :id LIMIT 1');
       contact.RecordTypeId = wrapper.type;
        contact.FirstName = wrapper.firstName;
        contact.LastName = wrapper.lastName;
        contact.Phone = wrapper.phone; //how convert String to Phone?
        contact.HomePhone = wrapper.homePhone;
        contact.Email = wrapper.email;

       if (serialize) update contact; 
    
       return contact;
    }

    public static void deleteContactByID(Id id) {
    delete [SELECT id FROM Contact WHERE Id = :id];
    }
    
    public static void deleteContactByName(String name) {
        delete [SELECT id FROM Contact WHERE Name = :name];
        }  
}