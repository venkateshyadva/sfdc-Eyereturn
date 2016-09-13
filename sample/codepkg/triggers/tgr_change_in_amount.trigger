/* 
trigger tgr_change_in_amount on Opportunity (after insert,after update,before delete) {
List<Account>lstAccount = new List<Account>();
 for (Opportunity opp: Trigger.new) {
                    if(opp.accountid != null){
                                                       
                            Integer amt;
                            AggregateResult[] groupedResults  = [SELECT SUM(Amount)aver FROM Opportunity where accountid =:opp.accountid];
                            for (AggregateResult ar : groupedResults) { 
                               amt =  Integer.valueOf(ar.get('aver'));
                            }
                           
                            
                            lstAccount = [select Total_Amt_of_Open_Opportunities__c from Account where id=:opp.accountid];
                            lstAccount[0].Total_Amt_of_Open_Opportunities__c = amt;
                           
                           
                    }
            }
 update lstAccount;
} */


trigger tgr_change_in_amount on Opportunity (after insert,after update,before delete) {
    Set<id> accIds = new Set<Id>();
    Map<Id,Integer> accAmount = new Map<Id,Integer>();
    List<Account> lstAccount = new List<Account>();
    for (Opportunity opp: Trigger.new) 
    {
        if(opp.accountid != null)
        {
            accIds.add(opp.accountid);
        }
    }
    
    AggregateResult[] groupedResults  = [SELECT SUM(Amount)aver FROM Opportunity where accountid In :accIds];
    for (AggregateResult ar : groupedResults) 
    { 
        accAmount.put(ar.Id,Integer.valueOf(ar.get('aver')));
    }
    
    for(Account a :[select id, Total_Amt_of_Open_Opportunities__c from Account where id IN :accIds])
    {
        a.Total_Amt_of_Open_Opportunities__c = accAmount.get(a.Id);
        lstAccount.add(a);
    }
    
    update lstAccount;

}