@Istest
public class updateAccountNumberTest
{
public static testmethod void  TestupdateAccountNumber()
{
account a=new account();
a.name='test';
a.Region__c='Americas';
//a.AccountNumber='10000';
insert a;
a.Region__c='International';
//a.AccountNumber='20000';
update a;
opportunity op=new opportunity();
op.name='test opp';
op.CloseDate=system.today();
op.StageName='Negotiation/Review';
op.Event_Date__c=system.today()+1;
op.accountid=a.id;
insert op;
}
public static testmethod void  TestupdateAccountNumberElsepart()
{
account a=new account();
a.name='test';
a.Region__c='Americas';
a.AccountNumber='123';
insert a;
 
opportunity op=new opportunity();
op.name='test opp';
op.CloseDate=system.today();
op.StageName='Negotiation/Review';
op.Event_Date__c=system.today()+1;
op.accountid=a.id;
insert op;
a.Region__c='International';
    update a;
}
public static testmethod void  TestupdateAccountNumber1()
{
account a=new account();
a.name='test';
a.Region__c='Americas';
//a.AccountNumber='10000';
insert a;

opportunity op=new opportunity();
op.name='test opp';
op.CloseDate=system.today();
op.StageName='Negotiation/Review';
op.Event_Date__c=system.today()+1;
op.accountid=a.id;
insert op;
a.Region__c='International';
a.AccountNumber='20000';
update a;
}
}