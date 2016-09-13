public class AccountContacts{

  

public boolean errormsg{get; set;} 
public boolean errormsg1{get; set;} 


public AccountContacts() {}
String aid=ApexPages.currentPage().getParameters().get('id');
 /* Variable declarations */
public List<Contact> contactList {get; set;}                              
public Boolean selectAllCheckbox {get; set;}                                  // Stores checkbox data.
  
String userinput1;                                                             // Contact firstname
String userinp;                                                                  // Contact lastname

Public List<Contact> results = new List<Contact>();                            // Contact search results.
Public List<Contact> selectedContactsstep2 = new List<Contact>();
public List<Account_Contacts_Teams__c> act = new List<Account_Contacts_Teams__c>();
/* End of Variable declarations */

/* Getter and setter methods for getting the user input ie. Contact firstname and lastname from the UI */
public String getuserinput1(){return userinput1;}
public void setuserinput1(String userinp){this.userinput1=userinput1;}
public String getuserinp(){return userinp;}
public void setuserinp(String userinp){this.userinp=userinp;}
/*End of Getter and Setter methods */

/* Method to Search the contact database to fetch the query results */
public List<Contact> contactsearch()
{
    contactList=new List<Contact>();
        errormsg=false;
    if((userinput1==null || userinput1=='') && (userinp==null || userinp==''))
    
     errormsg1=true;
    else
        errormsg1=false;
    if(!errormsg1){
          
       if(userinput1!=null){
     for(Contact c : [select Id,FirstName,LastName,Email,Phone,Title from Contact where FirstName like :userinput1+'%' ])
     {    
      //   contactList.add(new Contact(c));
     }
        }
        
       if(userinp!=null){
     for(Contact c : [select Id,FirstName,LastName,Email,Phone,Title from Contact where LastName like :userinp+'%'])
     {    
         //contactList.add(new Contact(c));
     }
        }         
    }  
   
   return null;
}

public List<Contact> getresults() {

return contactList;

}
}