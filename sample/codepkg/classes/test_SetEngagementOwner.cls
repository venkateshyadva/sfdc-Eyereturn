@istest
public class test_SetEngagementOwner 
{
public static testmethod void test_SetEngagement()
{
Engagement__c a=new Engagement__c();
a.Owner__c='text';
insert a;

}

}