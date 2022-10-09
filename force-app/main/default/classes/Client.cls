public class Client{
    public String sfId;
    public String firstName;
    public String lastName;
    public String email;

    public Client(String sfId, String email){
        this.sfId = sfId;
        this.email = email;
    }

    public Client(String sfId, String firstName, String lastName, String email){
        this.sfId = sfId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
    }
    
} 