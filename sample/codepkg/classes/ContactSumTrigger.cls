@isTest(SeeAllData=true)
Public class ContactSumTrigger 
{
static testMethod void testprimary()
{
 
Account acc = new Account(Name='ABC');
insert acc;
 
Contact con = new Contact(LastName='Test',AccountId=acc.id);
insert con;
delete con;
 
}
}