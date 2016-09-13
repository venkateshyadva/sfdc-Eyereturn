@istest
global class Test_Sending_Email_To_Contacts_After_Ev

{
 public static testmethod void Sending_Email_To_Contacts_After_Event() {
Account ac=new account();
ac.Name='venki';
ac.Rating='Hot';
ac.Type='staff';
//ac.Country__c='UK';
//ac.CurrencyIsoCode='EUR-Euro';
insert ac;

Opportunity op=new opportunity();
op.Name='test';
op.accountid=ac.id;
op.StageName='Contracted performance';
op.Event_Date__c=system.today();
//op.Follow_up_date__c=system.today();
op.CloseDate=system.today();
op.LeadSource='other';
//op.Old_close_date__c=system.today();
op.Type='wedding';
insert op;
contact con=new contact();
con.accountid=ac.id;
con.LeadSource='other';
//con.CurrencyIsoCode='USD-U.S.DOLLAR';
con.Lastname='test';
con.Email='abc@gmail.com';
insert con;
OpportunityContactRole opc=new OpportunityContactRole();
opc.ContactId=con.id;
opc.OpportunityId=op.id;
opc.IsPrimary=true;
//opc.
insert opc;
try{
Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
        //mail.setTargetObjectIds(con.id);  // assign the all emails 
      //mail.setReplyTo('exemple@exemple.ex');
      EmailTemplate et= [SELECT id FROM EmailTemplate WHERE developerName = 'Sending_the_email'];
        mail.setSenderDisplayName('Incognito Artists'); // displaying the senders name
        mail.setTemplateId(et.id);  // adding the templete id,here we are taken subject,body.
        Messaging.sendEmail(new Messaging.MassEmailMessage[] { mail });

}catch(Exception e){system.debug('ddd'+e);}
test.starttest();
Sending_Email_To_Contacts_After_Event ose=new Sending_Email_To_Contacts_After_Event();

string sch = '0 45 05 * * ? *';
        system.schedule('ge Job4', sch, ose);

test.stopTest();
}
}