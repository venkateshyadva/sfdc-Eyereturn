@IsTest
Public class Schecudlertestaccount22Test
{
public static testmethod void TestSchecudlertestaccount22()
{

Account acct= new Account();
acct.name='Test';
acct.type='Other';
//test.startTest();
insert acct;
//test.stopTest();

Account acctquery= new Account();
acctquery=[select id,name,type from account where id=:acct.id];

Schecudlertestaccount22   schedule=new Schecudlertestaccount22();
String sch = '0 0 0 3 9 ? 2022';
system.schedule('Schecudlertestaccount', sch, schedule);


system.assert(acct!=null);
system.assertequals(acct.id,acctquery.id,'this is correct');

}
}