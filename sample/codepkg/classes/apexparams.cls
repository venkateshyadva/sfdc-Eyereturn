public class apexparams{

    


   // public String idsAccount { get; set; }

    public String Enteredname { get; set; }
    List<Account> Varacc;
    public void getids() {
         Varacc=[select id,name from Account where name=:Enteredname];
    }
    public List<Account> getidsAccount()
    {
        return Varacc;
    }
    public PageReference OpenAccoutid() {
    
        String IdValue=ApexPages.currentPage().getParameters().get('txt');
        system.debug('<--------------->'+IdValue);
        PageReference varpagref=new PageReference('/'+IdValue);
        return varpagref;
    }

    
}