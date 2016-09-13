public with sharing class clone {

    //Construtor
     String id;
    public clone(ApexPages.StandardController controller) {
        id=ApexPages.currentPage().getParameters().get('id');
        
    }
   
    //Method
    
    public pagereference Cloning()
    {
        account varBook=[select id,name from account where id=:id];  
        account varClone=new account();
        varClone.name=varBook.name;
        insert varClone;
        
        List<Contact> varChildClone=[select id,account.name,phone from contact where accountid=:id ];
        for(integer i=0;i<varChildClone.size();i++)
        {
            Contact insvarchild=new Contact();
            insvarchild.accountid=varClone.id;
            insvarchild.phone=varChildClone[i].phone;
            insert insvarchild;
        }
        
        pagereference pagref=new pagereference('/'+varClone.id);
        return pagref;
         
    }

}