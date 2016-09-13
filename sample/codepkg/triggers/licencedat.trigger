trigger licencedat on Account (before update, before insert) {
Set<ID> accid = new Set<ID>();
for (Account a : Trigger.new)
{
accid.add(a.id);
}
List<account> updatacc=[select id,number__c,Licence_Date__c,LastModifieddate,(select id,number__c,LastModifieddate,Licence_Date__c from contacts) from account where id=:accid];
List<contact> con=new list<contact>();
for(account ac:updatacc)
{
for(contact c:ac.contacts)
{
for(account c2:trigger.new)
{
if(c.number__c == ac.number__c)
{
c2.Licence_Date__c=c.LastModifieddate.date();
c.Licence_Date__c=ac.LastModifieddate.date();
}
}

}
}
}