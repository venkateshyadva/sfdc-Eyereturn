trigger trgInventoryRequestAfter on Inventory_Request__c (after update) {
List<JDRF_Location__c> JDRFLocation = new List<JDRF_Location__c>();

List<JDRF_Location__c> updateJDRFLocation = new List<JDRF_Location__c>();
set<id> inventoryRequest =new set<id>();
for(Inventory_Request__c vInr:trigger.new)
{
if(vInr.Request_Status__c == 'Approved' && vInr.Inventory_Type__c == 'Bag of Hope')
{
inventoryRequest .add(vInr.id);
}
}

system.debug('inventoryId'+inventoryRequest );


JDRFLocation = [select id,name, Current_boh_Inventory__c,Inventory_Request__c from JDRF_Location__c where Inventory_Request__c=:inventoryRequest ];
system.debug('@@@@@@@@'+JDRFLocation);
for(JDRF_Location__c JDRF:JDRFLocation){
for( Inventory_Request__c IR:trigger.new){
JDRF.Current_boh_Inventory__c=JDRF.Current_boh_Inventory__c+ IR.Units_Requested__c ;
updateJDRFLocation.add(JDRF);
}
}

update updateJDRFLocation;
system.debug('updateJDRFLocation@@@@@@@@'+updateJDRFLocation);
}