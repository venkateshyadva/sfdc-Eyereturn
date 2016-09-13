public class AccountSize
{

    public String Data { get; set; }
    public  Integer Varint;
    public Integer getSize() {
        return Varint;
    }
    
    public void sizeofAccount() {
        List<Account> Varsize=[select id,name from Account where name=:Data];
        Varint=Varsize.size();
    }
   
    
}