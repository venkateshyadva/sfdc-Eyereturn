trigger SetEngagementOwner on Engagement__c (before insert) {

List<Employee__c> lstl = [select ownerid from Employee__c WHERE ownerId = :UserInfo.getUserId()];

for (Engagement__c a : Trigger.new)
{
if(a.Owner__c==null){
a.Owner__c = lstl[0].id;
}
}
}