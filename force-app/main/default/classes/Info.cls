public class Info {
    public Datetime createDate;
    public Date rentStartDate;
    public Date rentEndDate;
    public Client client;
    public Property property; 

    public Info(Datetime createDate, Date rentStartDate, Date rentEndDate, Client client, Property property) {
        this.createDate = createDate;
        this.rentStartDate = rentStartDate;
        this.rentEndDate = rentEndDate;
        this.client = client;
        this.property = property;

    }
}

     