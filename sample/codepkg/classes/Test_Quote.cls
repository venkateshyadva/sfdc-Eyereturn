@isTest()
private class Test_Quote {

    static testMethod void uniTest() {
       
        VAT__c vat = new Vat__c(Name='Test Vate',Vat_Rate__c = 50 );
        insert vat ;
        Quote__c qu = new Quote__c(Name='Test Quote');
        insert qu ;
        
    }   
}