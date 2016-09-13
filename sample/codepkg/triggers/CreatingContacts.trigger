trigger CreatingContacts on Account (after insert,after update) {
List<Contact> con=new List<Contact>();
List<Contact> con1=new List<Contact>();
for(Account ac:trigger.new)
{
if(ac.YOR_Activity_Status__c=='Completed')
{
con.add(new contact(Lastname=ac.name,accountid=ac.id));
con1.add(new contact(Lastname=ac.name,accountid=ac.id)); 
}
}
insert con;
insert con1;
}