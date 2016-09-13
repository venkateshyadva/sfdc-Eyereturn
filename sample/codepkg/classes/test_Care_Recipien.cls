@istest
public class test_Care_Recipien
{
public static testmethod void test_care()
{
Care_Recipient_Information__c cr=new Care_Recipient_Information__c();
cr.DMD__c = true;
cr.DS__c = true;
cr.Disability__c=true;
insert cr;
cr.DMD__c =false;
cr.DS__c = false;
cr.Disability__c=false;
update cr;
}
}