trigger addresspopulate on Account (before insert,before update)//,before update
 {
for(account ac:trigger.new)
{

if(ac.address_checkbox__c==true)
{
ac.address_to_populate__c=ac.ShippingCity +' '+ac.ShippingCountry +' ' +ac.ShippingState +' ' +ac.ShippingStreet +' ' +ac.ShippingPostalCode;
}

}
}