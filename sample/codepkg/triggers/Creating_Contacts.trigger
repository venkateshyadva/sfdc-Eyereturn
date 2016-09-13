trigger Creating_Contacts on Account (after insert) {
List<contact> c=new List<contact>();
List<Opportunity> opp=new List<Opportunity>();

for(account a:trigger.new)
{
if(a.YOR_Activity_Status__c=='completed')
{
c.add(new contact(accountid=a.id,lastname=a.name));
opp.add(new Opportunity(accountid=a.id,name=a.name,Event_Date__c=system.today(),CloseDate=system.today()+2,StageName='Prospecting'));
}

}
 //if(Test.isRunningTest())
 
  System.enqueueJob(new AsyncExecutionExample());
 // AsyncExecutionExample.tetemethod('venky');
//insert c;
//insert opp;

}