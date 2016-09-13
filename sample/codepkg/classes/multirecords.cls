public class multirecords {

public Account A {get; set;}
Public Contact C {get; set;}
Public Deal__c O {get; set;}
Public Account_Qualification__c AQ{get;set;}
public Task t{get;set;}
public multirecords()
{
A = new account();
C = new contact();
O = new Deal__c();
AQ = new Account_Qualification__c();
t = new Task();
}

public PageReference Save()
{
insert A;

C.Accountid = A.id;


AQ.Account__c=A.Id;
if(A.Check__c== true)
{
insert AQ;
}
O.Account__c = A.id;

If (O.name != NULL || C.lastname != NULL || AQ.Check_the_section__c == true )
{
insert O;
insert C;
}
if(O.Check_the_section__c == true)
{
t.WhoId=C.id;
t.WhatId=O.id;
insert t;
}
return new PageReference('/'+A.id);
}
}