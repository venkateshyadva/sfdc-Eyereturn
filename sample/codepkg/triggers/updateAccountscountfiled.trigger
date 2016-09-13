////trigger for updating the account fileds counting the all the child contacts records

trigger updateAccountscountfiled on Contact(after insert, after update, after delete, after undelete) {
    Set<id> accounts = new Set<Id>();//getting the account ids
    if(trigger.old != null)
        for(contact c:trigger.old)
            accounts.add(c.accountid);
    if(trigger.new != null)
        for(contact c:trigger.new)
            accounts.add(c.accountid);
    update [select id from account where id in :accounts];
}