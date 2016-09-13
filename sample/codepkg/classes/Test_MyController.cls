@istest
public class Test_MyController
{
public static testmethod void Controller()

{
Account a=new account();
a.name='test';
a.type='prospect';
insert a;
ApexPages.CurrentPage().getparameters().put('id', a.id);
    ApexPages.StandardController sc = new ApexPages.standardController(a);
  //  myClass sic = new myClass(sc);
MyController c=new MyController(sc);
c.setApp();
c.getsetApp();
}
}