trigger ActivityHistorytrigger on Task (after insert) {

List<ActivityHistory> ev=new List<ActivityHistory>();

for(Task t:trigger.new)
{


}




}