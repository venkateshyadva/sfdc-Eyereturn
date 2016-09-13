Global class accountcreation
{

webservice static string sayhell(String Name,String Email,String AccountNumber,String Type,String id)
{

List<Account> Insertacc;
List<Account> Listacc=[select id,email__c,name,AccountNumber,Type from account where id=:id];

if(Listacc.size()>0)
{
Account acc1=new account();
acc1.Name=Name;
acc1.Email__c=Email;
acc1.AccountNumber=AccountNumber;
acc1.Type=Type;
Insertacc.add(acc1);

}
Insert Insertacc;

return null;
}



}