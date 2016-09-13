public class Sample {  
    public List<Opportunity> OpptyList {get;set;}
   
    public Sample() {
        OpptyList = [SELECT Name,Amount_formula__c, Amount FROM Opportunity];
    }           
}