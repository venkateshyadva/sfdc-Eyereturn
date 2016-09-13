public class GetAccountid {

   // public String idsAccount { get; set; }

    public String Enteredname { get; set; }
    List<Account> Varacc;
    public boolean hidepageblock{get;set;}
    
    //Method
    
    public void getids() {
         Varacc=[select id,name from Account where name=:Enteredname];
         hidepageblock=true;
    }
    public List<Account> getidsAccount()
    {
    hidepageblock=true;
        return Varacc;
    }

    
}