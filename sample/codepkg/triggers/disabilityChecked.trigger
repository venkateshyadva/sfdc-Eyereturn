trigger disabilityChecked on Care_Recipient_Information__c (before insert, before update)
{
 
Boolean disability, chronic;
 
for (Care_Recipient_Information__c obj : Trigger.new)
{

if ((obj.DMD__c == true) ||
(obj.DS__c == true))

{
obj.DisabilityNumber__c = 1;
disability = true;
obj.Disability__c = disability;
}
 
else
{
disability = false;
chronic = false;
obj.Disability__c = disability;
//obj.chronic_Illness__c = chronic;
}
 
}//FOR
}//END