public class Marketingcampagin {

   
opportunity li=null;
public boolean Bronze{get;set;}
public boolean silver{get;set;}
public  boolean gold{get;set;}
public Id Listingid{get;set;}

public Marketingcampagin(ApexPages.StandardController controller) {
    Listingid=ApexPages.currentPage().getparameters().get('id');
   li=(opportunity)controller.getRecord();
   
   if(li.Campaign_Type__c== 'Bronze')
    {
    system.debug('!!!!!!!');
    Bronze=true;
    system.debug('!!!!!!!'+Bronze);
    silver=false;
    gold=false;
    }
    if(li.Campaign_Type__c == 'Silver')
    {
        system.debug('!!!!!3434!');
    Bronze=true;
    silver=true;
    system.debug('!!!!!3434!'+silver);
    gold=false;
    }
    if(li.Campaign_Type__c == 'Gold')
    {
    Bronze=true;
    silver=true;
    gold=true;
    }
    if(li.Campaign_Type__c == 'Platinum')
    {
    Bronze=true;
    silver=true;
    gold=true;
    }
    if(li.Campaign_Type__c == 'Titanium')
    {
    Bronze=true;
    silver=true;
    gold=true;
    }
     
        if(li.Campaign_Type__c !='Bronze' && li.Campaign_Type__c !='Silver' && li.Campaign_Type__c !='Gold' && li.Campaign_Type__c !='Platinum' && li.Campaign_Type__c !='Titanium')
    {
    Bronze=false;
    silver=false;
    gold=false;
    }
   
   }
   
   public pagereference showmarketingcampagin(){
    //li=[select Campaign_Type__c from Listing__c where id=:Listingid];
    system.debug('@@@@@@@@@@@@@'+li.Campaign_Type__c);
    if(li.Campaign_Type__c == 'Bronze')
    {
    system.debug('!!!!!!!');
    Bronze=true;
    system.debug('!!!!!!!'+Bronze);
    silver=false;
    gold=false;
    }
    if(li.Campaign_Type__c == 'Silver')
    {
        system.debug('!!!!!3434!');
    Bronze=false;
    silver=true;
    system.debug('!!!!!3434!'+silver);
    gold=false;
    }
    if(li.Campaign_Type__c == 'Gold')
    {
    Bronze=true;
    silver=true;
    gold=true;
    }
    if(li.Campaign_Type__c == 'Platinum')
    {
    Bronze=true;
    silver=true;
    gold=true;
    }
    if(li.Campaign_Type__c == 'Titanium')
    {
    Bronze=true;
    silver=true;
    gold=true;
    }
     
        if(li.Campaign_Type__c !='Bronze' && li.Campaign_Type__c !='Silver' && li.Campaign_Type__c !='Gold' && li.Campaign_Type__c !='Platinum' && li.Campaign_Type__c !='Titanium')
    {
    Bronze=false;
    silver=false;
    gold=false;
    }
     
    return null;
    }
public void savemethod()
{
update li;
 
//pagereference page=new pagereference('/'+Listingid);
//page.setredirect(true);
//return page;
}

}