public class contactlis {

public id accontid;
public list<contact> con{get;set;}
    public contactlis(ApexPages.StandardController controller) {
accontid=apexpages.currentpage().getparameters().get('id');
    system.debug('accontid'+accontid);
con=new list<contact>();
    con=[select id,name,email from contact where accountid=:accontid];
    system.debug('contact list'+con);
    }
    public void contactlist()
    {
    
    }

}