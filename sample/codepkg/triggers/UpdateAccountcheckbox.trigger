trigger UpdateAccountcheckbox on Account(before update) {

//Creates variable accountIds
Set<Id> accountIds = new Set<Id>();

//Selects all of the accounts that were newly created/updated
for (Account a : Trigger.new)

//Assigns the newly created/updated account IDs to the variable
accountIds.add(a.Id);

//Creates a map of the Accounts that were newly created and selects contacts where checkbox is true
Map<Id, Account> accounts = new Map<Id, Account>( [ Select a.Id, (Select contact_check_box__c From Contacts Where contact_check_box__c= True) from Account a where a.ID in :accountIds] );

//Moves through the newly created/update accounts one by one
for (Account a : Trigger.new) {

    //Gets the account and sets it to variable
    Account accFromMap = accounts.get(a.Id);
    
    //If the contact exists on the contact, set the value to TRUE, else FALSE
    if (accFromMap.Contacts.size() > 0) {
        
        a.account_check_box__c = true;
    }
     else {
        
        a.account_check_box__c = false;
    }

}
}