@istest
public class testconvetnumberotwords
{

public static testmethod void  testtestconvetnumberotwords()
{
account a=new account();
a.name='test';
a.NumberOfEmployees=22;
a.number_field__c=22;
a.custom_text__c='twenty two';
insert a;
a.number_field__c=3;
a.custom_text__c='three';
}
}