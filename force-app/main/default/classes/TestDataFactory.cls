@IsTest
public class TestDataFactory{
   
    //Users Profiles    
    public static final Id MANAGER_PROFILE_ID = [SELECT Id FROM Profile WHERE Name = 'Manager' LIMIT 1].Id;
    public static final Id REP_PROFILE_ID = [SELECT Id FROM Profile WHERE Name = 'Rep' LIMIT 1].Id;
    //Users Roles
    public static final Id EU_REGIONAL_MANAGER_ROLE = [SELECT Id FROM UserRole WHERE DeveloperName = 'EU_Regional_Manager' LIMIT 1].Id;
    public static final Id EU_EAST_MANAGER_ROLE = [SELECT Id FROM UserRole WHERE DeveloperName = 'EU_East_Manager' LIMIT 1].Id;
    public static final Id EU_EAST_REP_ROLE = [SELECT Id FROM UserRole WHERE DeveloperName = 'EU_East_Rep' LIMIT 1].Id;
    public static final Id EU_WEST_MANAGER_ROLE = [SELECT Id FROM UserRole WHERE DeveloperName = 'EU_West_Manager' LIMIT 1].Id;
    public static final Id EU_WEST_REP_ROLE = [SELECT Id FROM UserRole WHERE DeveloperName = 'EU_West_Rep' LIMIT 1].Id;

    public static final Id US_REGIONAL_MANAGER_ROLE = [SELECT Id FROM UserRole WHERE DeveloperName = 'US_Regional_Manager' LIMIT 1].Id;
    public static final Id US_EAST_MANAGER_ROLE = [SELECT Id FROM UserRole WHERE DeveloperName = 'US_East_Manager' LIMIT 1].Id;
    public static final Id US_EAST_REP_ROLE = [SELECT Id FROM UserRole WHERE DeveloperName = 'US_East_Rep' LIMIT 1].Id;
    public static final Id US_WEST_MANAGER_ROLE = [SELECT Id FROM UserRole WHERE DeveloperName = 'US_West_Manager' LIMIT 1].Id;
    public static final Id US_WEST_REP_ROLE = [SELECT Id FROM UserRole WHERE DeveloperName = 'US_West_Rep' LIMIT 1].Id;
    //Contacts type
    public static final Id CONTACT_TYPE_PROPERTY_OWNER = [SELECT Id FROM RecordType WHERE Name = 'Property Owner' LIMIT 1].Id;
    public static final Id CONTACT_TYPE_BROKER = [SELECT Id FROM RecordType WHERE Name = 'Broker' LIMIT 1].Id;
    //Deals type
    public static final Id DEAL_TYPE_SALE = [SELECT Id FROM RecordType WHERE Name = 'Sale' LIMIT 1].Id;
    public static final Id DEAL_TYPE_LEASE = [SELECT Id FROM RecordType WHERE Name = 'Lease' LIMIT 1].Id;
    //Deals status
    public static final String DEAL_STATUS_CLOSED  = 'Closed';
    public static final String DEAL_STATUS_OPEN  = 'Open';
    public static final String DEAL_STATUS_CLOSED_WON  = 'Closed Won';
    public static final String DEAL_STATUS_CLOSED_LOST  = 'Closed Lost';
    //Propertyes type
    public static final Id PROPERTY_TYPE_OFFICE = [SELECT Id FROM RecordType WHERE Name = 'Office' LIMIT 1].Id;
    public static final Id PROPERTY_TYPE_INDUSTRIAL = [SELECT Id FROM RecordType WHERE Name = 'Industrial' LIMIT 1].Id;
    public static final Id PROPERTY_TYPE_SPACE = [SELECT Id FROM RecordType WHERE Name = 'Space' LIMIT 1].Id;
    

    public static User createManagerUser(String name, String language) {
        User user = new User(LastName = name, LanguageLocaleKey = language, Username = name + '@username.com',
                Email = name + '@test.com', Alias = name, TimeZoneSidKey = 'America/Chicago',
                LocaleSidKey = language, EmailEncodingKey = 'UTF-8', ProfileId = MANAGER_PROFILE_ID,
                UserRoleId = US_EAST_MANAGER_ROLE);
        insert user;
        return user;
    }
    
    public static User createRepUser(String name, String language) {
        User user = new User(LastName = name, LanguageLocaleKey = language, Username = name + '@username.com',
                Email = name + '@test.com', Alias = name, TimeZoneSidKey = 'Europe/Moscow',
                LocaleSidKey = language, EmailEncodingKey = 'UTF-8', ProfileId = REP_PROFILE_ID,
                UserRoleId = EU_WEST_REP_ROLE);
        insert user;
        return user;
    }
    

    public static Contact createContactPropertyOwner(String name, String phone, String homePhone) {
        Contact contact = new Contact(FirstName = 'First' + name, LastName = 'Last' + name, Phone = phone, HomePhone = homePhone,
                                    Email = name + '@test.com', RecordTypeId = CONTACT_TYPE_PROPERTY_OWNER );
        insert contact;
        return contact;
    }

    public static Contact createContactBroker(String name, String phone, String homePhone) {
        Contact contact = new Contact(FirstName = 'First' + name, LastName = 'Last' + name, Phone = phone, HomePhone = homePhone,
                                    Email = name + '@test.com', RecordTypeId = CONTACT_TYPE_BROKER );
        insert contact;
        return contact;
    }

    public static Property__c createPropertyIndustrial(Contact owner, String address, Decimal costSale, Decimal costRent) {
        Property__c property = new Property__c(RecordTypeId = PROPERTY_TYPE_INDUSTRIAL, Address__c = address, Selling_price__c = costSale,
                                            Rent_price__c = costRent, Contact__c = owner.id );
        insert property;
        return property;
    }

    public static Property__c createPropertyOffice(Contact owner, String address, Decimal costSale, Decimal costRent) {
        Property__c property = new Property__c(RecordTypeId = PROPERTY_TYPE_OFFICE, Address__c = address, Selling_price__c = costSale,
                                            Rent_price__c = costRent, Contact__c = owner.id );
        insert property;
        return property;
    }

    public static Property__c createPropertySpace(Contact owner, String address, Decimal costSale, Decimal costRent) {
        Property__c property = new Property__c(RecordTypeId = PROPERTY_TYPE_SPACE, Address__c = address, Selling_price__c = costSale,
                                            Rent_price__c = costRent, Contact__c = owner.id );
        insert property;
        return property;
    }

    public static Deal__c createDealSale(Contact seller, Contact buyer, Property__c property) {
        Deal__c deal = new Deal__c(Contact__c = seller.id, Contact_buyer__c = buyer.id, Property__c = property.id, 
                                RecordTypeId = DEAL_TYPE_SALE);
        insert deal;
        return deal;
    }

    public static Deal__c createDealOpenSale(Contact seller, Contact buyer, Property__c property) {
        Deal__c deal = new Deal__c(Contact__c = seller.id, Contact_buyer__c = buyer.id, Property__c = property.id, 
                                RecordTypeId = DEAL_TYPE_SALE, Status__c = DEAL_STATUS_OPEN);
        insert deal;
        return deal;
    }

    public static Deal__c createDealCloseSale(Contact seller, Contact buyer, Property__c property) {
        Deal__c deal = new Deal__c(Contact__c = seller.id, Contact_buyer__c = buyer.id, Property__c = property.id, 
                                RecordTypeId = DEAL_TYPE_SALE, Status__c = DEAL_STATUS_CLOSED);
        insert deal;
        return deal;
    }

    public static Deal__c createDealCloseWonSale(Contact seller, Contact buyer, Property__c property) {
        Deal__c deal = new Deal__c(Contact__c = seller.id, Contact_buyer__c = buyer.id, Property__c = property.id, 
                                RecordTypeId = DEAL_TYPE_SALE, Status__c = DEAL_STATUS_CLOSED_WON);
        insert deal;
        return deal;
    }

    
    public static Deal__c createDealCloseLostSale(Contact seller, Contact buyer, Property__c property) {
        Deal__c deal = new Deal__c(Contact__c = seller.id, Contact_buyer__c = buyer.id, Property__c = property.id, 
                                RecordTypeId = DEAL_TYPE_SALE, Status__c = DEAL_STATUS_CLOSED_LOST);
        insert deal;
        return deal;
    }

    public static Deal__c createDealLease(Contact seller, Contact buyer, Property__c property) {
        Date today = Date.today();
        Date nextWeek = today.addDays(7);         
        Deal__c deal = new Deal__c(RecordTypeId = DEAL_TYPE_LEASE, Property__c = property.id, Contact_buyer__c = buyer.id,
                                Contact__c = seller.id, Start_lease__c = today, Finish_lease__c = nextWeek);
        insert deal;
        return deal;
    }

    public static Deal__c createDealLeaseFinishLeaseTomorrow(Contact seller, Contact buyer, Property__c property) {
        Date today = Date.today();
        Date tomorrow = today.addDays(1);         
        Deal__c deal = new Deal__c(RecordTypeId = DEAL_TYPE_LEASE, Property__c = property.id, Contact_buyer__c = buyer.id,
                                Contact__c = seller.id, Start_lease__c = today, Finish_lease__c = tomorrow);
        insert deal;
        return deal;
    }

    public static Log__c createLog(String name, String message) {
        Log__c log = new Log__c(Name = name, Message__c = message);
        insert log;
        return log;
    }

    public static List<Log__c> createLogs(Integer count) {
        List<Log__c> logs = new List<Log__c>(count);
        
        for (Integer i = 0; i < count; i++) {
            logs[i] = new Log__c(Name='TestLog' + i, Message__c = 'Message for TestLog' + i );
        }
        insert logs;
        
        return logs;
    }
    
}
