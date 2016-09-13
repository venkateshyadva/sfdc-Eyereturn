//trigger for updating the account fileds counting the all the child contacts records

trigger countnumberofContacts on Account (before update) {
    for(account a:trigger.new)
        a.Count__c= 0;
    for(aggregateresult ar:[select accountid accountid, count(id) contactcount from contact where accountid in :trigger.newmap.keyset() group by accountid])
        trigger.newmap.get((id)ar.get('accountid')).Count__c= (decimal)ar.get('contactcount');
}