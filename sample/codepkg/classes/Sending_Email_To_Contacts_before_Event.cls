global class Sending_Email_To_Contacts_before_Event implements Schedulable
{
public List<Opportunity> Opp=new List<Opportunity> (); 
//public List<Opportunity> opport=new List<Opportunity> ();
public Opportunity opport;
public List<contact> con=new List<contact>();
public List<OpportunityContactRole> ocr = new List<OpportunityContactRole>();

public set<id> ids=new set<id>();
public List<id> ocrids=new List<id>();
public boolean email; 
//system.debug('#####');
global void execute(SchedulableContext ctx)
{
//try
//{
system.debug('$$$$$$$$$$#');
opport=new Opportunity();
system.debug('$');
//date d=date.today();

//Date d=system.today();
//date d1= DATE.VALUEof(d.addHours(25));
//if(Event_Date__c='1/12/2013')StageName='Contracted Performance' 
//if((opport.StageName=='Closed Won') && (opport.Event_Date__c==system.today()))
//{
system.debug('@@@@@@@@@');
// getting the list of all opportunity where stage name is contracted performance
Opp=[select id,Name,StageName,Accountid,Event_Date__c from Opportunity];
//Opp=[select id,Name,StageName,Accountid,Event_Date__c from Opportunity where StageName='Closed Won' and Event_Date__c=:(d.adddays(-1))];
Opp=[select id,Name,StageName,Accountid,Event_Date__c from Opportunity where StageName='Closed Won' and Event_Date__c=today];
system.debug('#####'+opp);

for(Opportunity op:opp)
{
ids.add(op.id); //adding all the list opportunity in a set to get the ids 
}
//if(ids.Event_Date_check_box__c ==false)
//{
// getting the contract role where primary key is checked for all opprotunity
ocr=[select ContactId,Id,OpportunityId,IsPrimary from OpportunityContactRole where IsPrimary=true and OpportunityId in :ids];
system.debug('@@@@@@@@@@@'+ocr);
for(OpportunityContactRole oc:ocr)
{
system.debug('*********@@@@@@@');
ocrids.add(oc.ContactId);   // getting the all contacts of emails,where the primary key is true 
system.debug('*********@@@@@@@'+ocrids);
}
        Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
        mail.setTargetObjectIds(ocrids);  // assign the all emails 
      //mail.setReplyTo('exemple@exemple.ex');
      EmailTemplate et= [SELECT id FROM EmailTemplate WHERE developerName = 'sending_the_email'];
        mail.setSenderDisplayName('Incognito Artists'); // displaying the senders name
        mail.setTemplateId(et.id);  // adding the templete id,here we are taken subject,body.
        Messaging.sendEmail(new Messaging.MassEmailMessage[] { mail });
 //} 
// }catch(Exception e){system.debug('!@#$%'+e);}  
email=true;
 } 
 
}