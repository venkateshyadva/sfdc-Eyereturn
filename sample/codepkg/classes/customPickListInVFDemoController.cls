public class customPickListInVFDemoController {

 public List<selectoption> Items { get; set; }
 public boolean renderpageblock { get; set; }

public String selectedCompany{get;set;}
public string inputfiled{get;set;}
public list<lead> leadrecords{get;set;}

    public string SelectedItem{get;set;}
    
 public string getSelectedItem(){
        return SelectedItem;
    }
    public void setSelectedItem(String SelectedItem){
        this.SelectedItem = SelectedItem;
    }  
    public customPickListInVFDemoController()
    
    {
    renderpageblock=false;
    Items = new List<SelectOption>();
        Items.add(new SelectOption('','-None-'));
        Items.add(new SelectOption('Microsoft','microsoft'));
        Items.add(new SelectOption('Adobe','Adobe'));
        Items.add(new SelectOption('Oracle','Oracle'));
                Items.add(new SelectOption('test','test'));
                items.add(new selectoption('Infosys','Infosys'));
                                items.add(new selectoption('October','October'));
        
    }
     
     public void validate()
     {
     renderpageblock=true;
     leadrecords=new list<lead>();
     map<string,CustomValidate__c> custom;
     custom=CustomValidate__c.getall();
     if(custom!= null){
      if(custom.get(SelectedItem) != null && custom.get(SelectedItem).Email__c != null){
                             String strEmail = custom.get(SelectedItem).Email__c;
                             if(strEmail == inputfiled)
                             {
                             
                             leadrecords=[select id,name,firstname,email from lead where isConverted = false];
                             system.debug('leadrecords@@@@@@@'+leadrecords);
                             }
                             
                             }
     }else{
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Custom settings not defined');
                    ApexPages.addMessage(myMsg);   
                }
     
     }
   
    
}