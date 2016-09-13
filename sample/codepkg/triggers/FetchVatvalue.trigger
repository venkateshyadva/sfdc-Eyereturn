trigger FetchVatvalue on Quote__c (before insert,before update) 
{
    //create reference table for lookup value
    
    Map<String, Decimal> vatMap = new Map<String, Decimal>();
    
    //build reference table for VAT rates
    
    for (VAT__c vat : [SELECT Name,Vat_Rate__c FROM VAT__c])
        vatMap.put(vat.Name, vat.Vat_Rate__c);
        
    //update Quote__c with VAT rate
    for (Quote__c q : trigger.new)
    {
       // Decimal vatRate = vatMap.get(q.Country_Code__c);
        q.VAT_Rate__c = q.Country_Code__c;
    }
}