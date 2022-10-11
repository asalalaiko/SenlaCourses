public class InfoByBatchEndLease {


public class Info {
    public Datetime createDate {get; set;}
    public Date rentStartDate {get; set;}
    public Date rentEndDate {get; set;}
    public Client client {get; set;}
    public Property property {get; set;}

    public Info (Deal__c deal) {
        this.createDate = deal.CreatedDate;
        this.rentStartDate = deal.Start_lease__c;
        this.rentEndDate = deal.Finish_lease__c;
        this.client = new Client(deal.Contact__r);
        this.property = new Property(deal.Property__r);
    }

}

public class Client {
    public String sfId {get; set;}
    public String firstName {get; set;}
    public String lastName {get; set;}
    public String email {get; set;}

    public Client(Contact client) {
        this.sfId = client.Id;
        this.firstName = client.FirstName;
        this.lastName = client.LastName;
        this.email = client.Email;
    }
}

public class Property{
    public String sfId {get; set;}
    public Client owner {get; set;}
    public LocationWrapper location {get; set;}

    public Property(Property__c property) {
        this.sfId = property.Id;
        this.owner = new Client(property.Contact__r);
        this.location = new LocationWrapper(property);
    }

}

public class LocationWrapper {
    public String country {get; set;}
    public String city {get; set;}
    public String address {get; set;}
    public String latitude   {get; set;}
    public String longitude {get; set;}

    public LocationWrapper(Property__c property) {
        this.country = property.Country__c;
        this.city = property.City__c;
        this.address = property.Address__c;
        this.latitude = property.Latitude__c;
        this.longitude = property.Longitude__c;
    }
}



}

     