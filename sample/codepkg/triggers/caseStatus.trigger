trigger caseStatus on Case (before update) {
list<case> lstupd=new list<Case>();
    QueueSobject que = [Select Id, SobjectType, QueueId, Queue.Name from QueueSobject where SobjectType = 'Case' AND Queue.developername = 'case']; 

for(case c:trigger.new)
{
if(c.ownerId=='00G90000002UkCu')
{
//c.status='venky';
//lstupd.add(c);
}
}
 
 Set<String> groupNames = new Set<String>();
   for (GroupMember gm : [select UserOrGroupId,
                             group.name,
                             group.DeveloperName,
                             group.OwnerId 
                          from GroupMember 
                          where UserOrGroupId = :UserInfo.getUserId()]) {
       groupNames.add(gm.UserOrGroupId );
   }
   system.debug('@###@@@@ groupNames '+groupNames );
   for(case ca:trigger.new)
   {
   system.debug('@###@ca.OwnerId '+ca.OwnerId);
   if (groupNames.contains(ca.OwnerId)) {
   ca.status='venky';
   }
   }
 
}