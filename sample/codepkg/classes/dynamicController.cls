public with sharing class dynamicController {
Public list<Account> carmodellist;
    public dynamicController(ApexPages.StandardController controller) {

    }


    public void AddRecord() {
        
       //Assign your own data to do this. for testing I just placed the dummy data.
       
       //Test Data
        MyWrapper oWrapp = new MyWrapper();
        oWrapp.vehiclebrand = getBrands();
        oWrapp.vechmodel = '';
        oWrapp.vechquanty = '';
        lstWrapper.add(oWrapp);
    
       // return null;
    }


     public list<MyWrapper> lstWrapper {get;set;} 
      
      public list<MyWrapper> mysendwrapper()
      {
     
      return null;
      }
     public dynamicController(){
        this.lstWrapper = new list<MyWrapper>();  
        MyWrapper oWrapp = new MyWrapper();
         oWrapp.vehiclebrand = getBrands();
        oWrapp.vechmodel = '';
        oWrapp.vechquanty = '';
        lstWrapper.add(oWrapp);
              
     } 
      public class MyWrapper{
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