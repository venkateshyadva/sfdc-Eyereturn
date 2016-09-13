trigger updateparentobject on Case (after update) {
set<id> accId= new set<id> (); // fetching unique account
List<case> cs=new list<case>();
List<account> a=new list<account>();
List<account> updateaccount=new list<account>();
for(case c:trigger.new)
{
accId.add(c.accountid);//here we will fetch account id
}
cs=[select id,status,Description,Accountid from case where Accountid=:accid and status='Closed'];//query for geeting case that are closed for perticular account

a=[select id,name,Number_to_word__c,SLASerialNumber__c from account where id=:accid];//query for getting accounts filed to update case field data

for(case ca:cs)
{
for(account acc:a)
{
acc.SLASerialNumber__c=ca.Description;//assigning case field to account field
acc.Number_to_word__c=ca.status;//assigning case field to account field
updateaccount.add(acc);// adding all account fields list account to update
}
}
update updateaccount;//updating list fields
}