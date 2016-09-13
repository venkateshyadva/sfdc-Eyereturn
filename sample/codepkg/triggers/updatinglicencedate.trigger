trigger updatinglicencedate on Contact (before insert,after update) {

List<Account> ac=new List<Account>();
Set<Id> accountIds = new Set<Id>();
for (contact a: Trigger.new)
{
accountIds.add(a.accountId);
}
//ac=[select id,number__c,Licence_Date__c from account where id=:accountIds];
List<contact> con=new list<contact>();
con=[select id, number__c,Licence_Date__c from contact where accountid=:accountIds];
for(contact c:con)
{
if(c.number__c ==0)
{}
}
}