trigger Update_CurrentMonth_Field on Merchandise__c (after Update,after insert) {

List<Merchandise__c> updateMR=new List<Merchandise__c>();
decimal num=0.00;
List<Merchandise__c> insertMR=new List<Merchandise__c>();
  if(trigger.isinsert)
  {
  for (Merchandise__c bs : Trigger.new) {
  if (bs.Month_Check__c== false)
  {
  if(bs.Cummulative_Spent__c ==null)
  {
   
   Merchandise__c  ourB = new Merchandise__c(Id = bs.Id,Cummulative_Spent__c=num+bs.Line_Item_Per_Month__c);
  insertMR.add(ourB);
  } 
  }
  }
  }
  update insertMR;
//if checkbox is checked, run the script
 if(trigger.isupdate)
 {
  for (Merchandise__c bs : Trigger.new) {
  
    if (bs.Month_Check__c== true) {
      //run whatever APEX code you want
     /* bs.Monthly_Date__c=system.today();
      bs.Month_Check__c=false;
      bs.Cummulative_Spent__c=num+bs.Line_Item_Per_Month__c;  */
      num=bs.Cummulative_Spent__c+num;
      Merchandise__c  ourBS = new Merchandise__c(
        Id = bs.Id,        
        Month_Check__c=false,
        Monthly_Date__c=system.today().addMonths(1),
        Cummulative_Spent__c=num+bs.Line_Item_Per_Month__c   
      );
      updateMR.add(ourBS);
    
}
   } 
  }
  update updateMR;

}