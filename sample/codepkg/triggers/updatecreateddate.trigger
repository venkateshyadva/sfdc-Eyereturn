trigger updatecreateddate on Opportunity(after insert) {

 List<Opportunity> op=new List<Opportunity>();
set<id> opportunityid=new set<id>();
for(Opportunity opp:trigger.new)
{
opportunityid.add(opp.id);
}
op=[select id,name,createdDate from opportunity where id=:opportunityid];

for(Opportunity opp1:op)
{
datetime d=opp1.createddate;
String hourDt =  String.valueOf(d.hourGmt());
system.debug('************* houtDt    :  ' +  hourDt);
}
}