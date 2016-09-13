public with sharing class remotecls {
public transient list<Account> lst{get; set;}
@remoteAction
public static string getData(string recId){

Contact con = [Select id, name from Contact where id=:recId];
system.debug('contact details'+ con.name);

return con.name;

}
}