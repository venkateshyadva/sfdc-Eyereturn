trigger Noduplicateaccounts on Account (before update) 
{
List<Account> oldAccount=new List<Account>();
oldAccount=[select id,name from account];

//if(trigger.isupdate)
//{


system.debug('inside for loop');
for(account acc:oldAccount)
{
system.debug('@@@@op'+acc.name);
for(account a:trigger.old)
{
system.debug('@@@@op'+a.name);

if(a.name !=acc.name)
{

system.debug('inside if loop');

a.adderror('you cant change account name');

}
}
}
//}
}