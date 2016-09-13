public class wrapperClassController {

    public PageReference processSelected() {
        return null;
    }


    //Our collection of the class/wrapper objects cContact 
    public List<cContact> contactList {get; set;}
    
    //This method uses a simple SOQL query to return a List of Contacts
    public List<cContact> getContacts(){
        if(contactList == null){
            contactList = new List<cContact>();
            
            for(Contact c : [select Id, Name, Email, Phone from Contact limit 10]){
                String style = getStyle(c);
                contactList.add(new cContact(c,style));
            }
        }
        return contactList;
    }
    
    public String getStyle(Contact con){
        String style = 'green';
        if(con.Email.contains('.gov')){
            style = 'red';
        }
                return style;
    }
   
    public class cContact{
        public Contact con {get; set;}
        public String style {get; set;}
       
        public cContact(Contact c, String style){
            this.con = c;
            this.style = style;
        }
    }
}