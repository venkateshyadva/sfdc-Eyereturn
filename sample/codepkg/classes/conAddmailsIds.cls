public class conAddmailsIds{

public String [] emailToAdd{get;set;}
public String [] toList{get;set;}
public String [] ccList{get;set;}

public Pagereference conAddEmailsIds(){
system.debug('@@@@@@ in add'+toList);
PageReference p = new PageReference('/_ui/core/email/author/EmailAuthor?p24='+toList+'&p4='+ccList);
p.setRedirect(true);
return p;
}
public Pagereference addToList(){
system.debug('@@@@@@ in to list'+emailToAdd);
toList = emailToAdd;
return null;
}
public Pagereference addCCList(){
ccList = emailToAdd;
return null;
}
}