global class CreateTaskEmailExample implements Messaging.InboundEmailHandler {
 
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, 
                                                       Messaging.InboundEnvelope env){
 
    // Create an InboundEmailResult object for returning the result of the 
    // Apex Email Service
    Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
  
    String myPlainText= '';
    
    // Add the email plain text into the local variable 
    myPlainText = email.plainTextBody;
   
    // New Task object to be created
    Task[] newTask = new Task[0];
   
    // Try to look up any contacts based on the email from address
    // If there is more than one contact with the same email address,
    // an exception will be thrown and the catch statement will be called.
    try {
       String customID;
    
    Pattern p = Pattern.compile('^(.*)(ai\\=\\d+)(.*)$');
    Matcher pm = p.matcher( email.subject);
    if( pm.matches() ){
         customID = pm.group(2);
         system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+customID);
    }
    
      Contact vCon = [SELECT Id, Name, Email,auto_number__c FROM Contact WHERE auto_number__c=:customID LIMIT 1];
      
      // Add a new Task to the contact record we just found above.
      newTask.add(new Task(Description =  myPlainText,
           Priority = 'Normal',
           Status = 'inbound emial',
           Subject = email.subject,
           IsReminderSet = true,
           ReminderDateTime = System.now()+1,
           WhoId =  vCon.Id));
     
     // Insert the new Task 
     insert newTask;    
     
     System.debug('New Task Object: ' + newTask );   
    }
    // If an exception occurs when the query accesses 
    // the contact record, a QueryException is called.
    // The exception is written to the Apex debug log.
   catch (QueryException e) {
       System.debug('Query Issue: ' + e);
   }
   
   // Set the result to true. No need to send an email back to the user 
   // with an error message
   result.success = true;
   
   // Return the result for the Apex Email Service
   return result;
  }
}