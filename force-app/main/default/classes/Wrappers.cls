public class Wrappers {
    //Deals type
    public static final Id DEAL_TYPE_SALE = [SELECT Id FROM RecordType WHERE Name = 'Sale' LIMIT 1].Id;
    public static final Id DEAL_TYPE_LEASE = [SELECT Id FROM RecordType WHERE Name = 'Lease' LIMIT 1].Id;


    public class InfoDealsFromPeriodByProperty {
        public Date startDate {get; set;}
        public Date endDate {get; set;}
        public String totalRevenue {get; set;}
        public List<DealWrapper> deals {get; set;}
        
        public InfoDealsFromPeriodByProperty (Date startDate, Date endDate, List<Deal__c> deals) {
            this.startDate = startDate;
            this.endDate = endDate;
            this.deals = new List<DealWrapper>();
            Decimal revenue = 0;
            for (Deal__c deal : deals) {
                this.deals.add(new DealWrapper(deal));
                if(deal.RecordTypeId.equals(DEAL_TYPE_LEASE)) revenue += deal.Transaction_amount__c;
            }

            this.totalRevenue = String.valueOf(revenue);
        }
    }

    public class DealWrapper{
        public String sfId {get; set;}
        public String dealType {get; set;}
        public Client realtor {get; set;}
        public String revenue {get; set;}
        public String clientId {get; set;}
        public String propertyId {get; set;}
        
        public DealWrapper(Deal__c deal){
            this.sfId = deal.Id;
            this.dealType = deal.RecordType.DeveloperName;
            this.realtor = new Client(deal.Contact__r.Id, deal.Contact__r.firstName, deal.Contact__r.lastName, deal.Contact__r.email);
            this.revenue = String.valueOf(deal.Transaction_amount__c);
            this.clientId = deal.Contact_buyer__c;
            this.propertyId = deal.Property__c;        
       }
    }

    public class Client{
        public String sfId {get; set;}
        public String firstName {get; set;}
        public String lastName {get; set;}
        public String email {get; set;}

        public Client(){
            
        }

        public Client(String sfId, String firstName, String lastName, String email){
            this.sfId = sfId;
            this.firstName = firstName;
            this.lastName = lastName;
            this.email = email;
        }
    }

    public class PropertyPostWrapper {
        public String type {get; set;}
        public String country {get; set;}
        public String city {get; set;}
        public String address {get; set;}
        public String ownerID {get; set;}
        public String rentalPrice  {get; set;}
        public String sellingPrice  {get; set;}
        
        public PropertyPostWrapper(){
            
        }

        public PropertyPostWrapper (String type, String country, String city, String address, String ownerID, String rentalPrice, String sellingPrice){
            this.type = type;
            this.country = country;
            this.city = city;
            this.address = address;
            this.ownerID = ownerID;
            this.rentalPrice = rentalPrice;
            this.sellingPrice = sellingPrice;

        }
    }

    public class PropertyPutWrapper {
        public String propertyId {get; set;}
        public Client newOwner {get; set;}
    
        public PropertyPutWrapper (){

        }

        public PropertyPutWrapper (String propertyId, Client client){
            this.propertyId = propertyId;
            this.newOwner = client;

        }
    }


}
