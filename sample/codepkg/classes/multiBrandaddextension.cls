public with sharing class multiBrandaddextension 
{
Public list<Account> carmodellist;
 public list<wrappermultibrandclass> lstWrapper {get;set;} 
 
  public PageReference AddRecord() {
        system.debug('@@@@@@@@@@@@@@@');
       //Assign your own data to do this. for testing I just placed the dummy data.
       
       //Test Data
        wrappermultibrandclass wrapperlist = new wrappermultibrandclass();
         wrapperlist.vehiclebrand = getBrands();
        wrapperlist.vechmodel = '';
        wrapperlist.vechquanty = '';
        lstWrapper.add(wrapperlist);
    
        return null;
    }
    
 public multiBrandaddextension(ApexPages.StandardController controller)
    {
    this.lstWrapper = new list<wrappermultibrandclass>();  
        wrappermultibrandclass wrapperlist = new wrappermultibrandclass();
         wrapperlist.vehiclebrand = getBrands();
        wrapperlist.vechmodel = '';
        wrapperlist.vechquanty = '';
        lstWrapper.add(wrapperlist);
    }
    
    public class wrappermultibrandclass
    {
        public list<SelectOption> vehiclebrand{get; set;}
        public string vechmodel{get; set;}
        public string vechquanty{get; set;}
        public List<SelectOption> brands{get; set;}
    }
        
    public List<SelectOption> getbrands()
    {
        carmodellist = [select name from Account];
        List<SelectOption> options = new List<SelectOption>();
        for(Account carmod :carmodellist)
        {
            options.add(new selectoption(carmod.Name,carmod.Name));
        }
        return options;
    }
    
         
   
}