@istest
Public class multirecordtest
{
public static testmethod void multirecords()
{
try{
Account ac=new account();
ac.Name='venki';
ac.Check__c=false;
insert ac;

Contact con=new contact();
con.lastname='venki';
con.accountid=ac.id;
insert con;
Deal__c d=new Deal__c();
d.Check_the_section__c=true;
d.Account__c=ac.id;
insert d;
Account_Qualification__c aq=new Account_Qualification__c();
aq.Check_the_section__c=true;
aq.Account__c=ac.id;
insert aq;

Task t =new Task(Status='In Progress',WhoId = Con.id,WhatId = d.Id,ActivityDate=System.Today());
multirecords m=new multirecords();
m.save();
Account ac1=new account();
ac1.Name='venki';
ac1.Check__c=false;
insert ac1;
Contact con1=new contact();
con1.lastname='venki';
con1.accountid=ac1.id;
insert con1;
}catch(Exception e){system.debug('!!!!'+e);}
}

}