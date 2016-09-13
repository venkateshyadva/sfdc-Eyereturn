trigger updateAccountNumber on Opportunity(before insert,before update)
{
    List<Id>accIds = new List<Id>();
    
    for(Opportunity opp:trigger.new)
    {
        if(opp.AccountId!=null)
        {
            accIds.add(opp.AccountId);
        }
    }
    
    Map<Id,Account>accMap = new Map<Id,Account>([select id,Region__c,AccountNumber from Account where id in:accIds]);
    
    for(Opportunity opp :trigger.new)
    {
        if(!accMap.IsEmpty())
        {
        if((opp.Probability>=85) && (accMap.get(opp.AccountId).AccountNumber==null))
        {
            if(accMap.get(opp.AccountId).Region__c=='Americas')
            {
            accMap.get(opp.AccountId).AccountNumber = '10000';
            }
            else if(accMap.get(opp.AccountId).Region__c=='International')
            {
                accMap.get(opp.AccountId).AccountNumber = '20000';
            }
        }
        else if((opp.Probability>=85) && (accMap.get(opp.AccountId).AccountNumber!=null))
        {
            if(accMap.get(opp.AccountId).Region__c=='Americas')
            {
            accMap.get(opp.AccountId).AccountNumber = String.ValueOf(Integer.Valueof(accMap.get(opp.AccountId).AccountNumber) + 1);
            }
            else if(accMap.get(opp.AccountId).Region__c=='International')
            {
                accMap.get(opp.AccountId).AccountNumber = String.ValueOf(Integer.Valueof(accMap.get(opp.AccountId).AccountNumber) + 1);
            }
        }
        else
        {
        
        }
        
        }
    }
    
}