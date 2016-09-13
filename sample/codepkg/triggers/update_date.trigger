trigger update_date on Account (before insert,before update) {
List<Account> ac=new list<Account>();
ac=[select id,YOR_Activity_Status__c,YOR_Date__c from account where id=:trigger.new];
for(Account acc:trigger.new)
{
if(acc.YOR_Activity_Status__c=='Completed')
{
acc.YOR_Date__c=system.today();
}
}

}