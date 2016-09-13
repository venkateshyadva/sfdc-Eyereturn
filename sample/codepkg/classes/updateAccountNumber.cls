public class updateAccountNumber

{
//List<Opportunity> oppor = new List<Opportunity>();
//List<Opportunity> Listopp = new List<Opportunity>();
 //List<account> accnumber= new List<account>();
public static void TriggerupdateAccountNumber(List<Opportunity> oppprtunity)
{
List<account> accnumber= new List<account>();
List<Opportunity> Listopp = new List<Opportunity>();
List<Opportunity> oppor = new List<Opportunity>();
  set<Id> accIds = new set<Id>();
oppor=[select id,name,Probability,AccountId from Opportunity];
system.debug('@@@@@@@ opportunity records'+oppor);

    for(Opportunity opp:oppor)
    {
        if(opp.AccountId!=null)
        {
            accIds.add(opp.AccountId);
        }
    }
    system.debug('@@@@@@@ account id '+accIds);
Listopp=[select id,name,Probability,AccountId from Opportunity where accountid=:accids];
system.debug('@@@@@@@ Lis of opp '+accIds);
    Map<Id,Account> accMap = new Map<Id,Account>([select id,Region__c,AccountNumber from Account where id=:accIds ]);
        system.debug('@@@@@@@ account map key set '+accmap.keyset());
        system.debug('@@@@@@@ account map values '+accmap.values());
    for(Opportunity opp :Listopp)
    {
        if(!accMap.IsEmpty())
        {
        system.debug('@@@@@@@ Probability '+opp.Probability);
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
           // accnumber.add(accmap.values());
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
             accnumber.add(accmap.values());
        }
        else
        {
        
        }
        
        }
        update accnumber;
        system.debug('@@@@@@@ aupdated account records '+accnumber);
    }
    //return accnumber;
    
}

}