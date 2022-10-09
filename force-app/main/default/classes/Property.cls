public class Property{
    public String sfId;
    public Client owner;
    public LocationWrapper location;

    public Property(String sfId, Client owner, LocationWrapper location){
        this.sfId = sfId;
        this.owner = owner;
        this.location = location;

    }

}
