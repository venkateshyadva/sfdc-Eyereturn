trigger update_dates on Task (after insert,after update) {
List<Task> t=new List<Task>();
t=[select id,YOR_Activity_Status__c from task where id in :Trigger.newMap.keySet()];
List<Account> ac=new List<Account>();

set<id> accounid=new set<id>();

for(task td:trigger.new)
{
accounid.add(td.WhatId);
}
ac=[select id,YOR_Date__c from account where id in: accounid];
for(task tk1:trigger.new)
{
if(tk1.YOR_Activity_Status__c=='completed')
{
for(Account a:ac)
{
a.Number_to_word__c=tk1.status;
}
}
}
update ac;
}