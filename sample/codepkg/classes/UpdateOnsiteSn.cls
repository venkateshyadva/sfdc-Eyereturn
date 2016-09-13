global class UpdateOnsiteSn Implements Schedulable{
public list<Onsite_Event__c> one;
global void execute(SchedulableContext sc) {

one=new list<Onsite_Event__c>();


 one= [Select Id, Course_Version__c from Onsite_Event__c];
for(Onsite_Event__c oe:one)
{
oe.Course_Version__c= 'Jim';

}
update one;
}
}