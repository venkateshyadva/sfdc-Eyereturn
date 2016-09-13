public class CLS_SendEmail {

    /*
        This class sends an email to specified toadress, ccaddress, bccaddress with attachments. After sending an email, task will be created
        with subject as Sending an Email
    */
    
    public Lead__c Lead {get; set;}
    public String EmailBody {get; set;}
    public String To {get; set;}                          // To address is specified Lead's email address 
    public String RelatedTo {get; set;}
    public String AdditionalTo{get; set;}
    public String CC {get; set;}
    public String BCC {get; set;}
    public String Subject{get; set;}
    public String Body{get; set;}
    public String FromAddress{get; set;}                  // From address is logged in user's email address
    public List<String> toAddress;                        // List containing more than one toaddress seperated by comma (,)
    public List<String> AdditionaltoAddress ;             // List containing more than one additional toaddress seperated by comma (,)
    public List<String> CcAddress;                        // List containing more than one ccaddress seperated by comma (,)
    public List<String> BccAddress;                       // List containing more than one bccaddress seperated by comma (,)
    public ID aid;                                        // Lead Id specified in URL
    public String Description;                            // To set comment field of Task descriobing mail address, body, subject, attachments name
    public string nameFile{get;set;}                      // Name of attachment uploaded by user
    Transient public Blob contentFile{get;set;}           // Body of attachment uploaded by user  
    public integer filesize{get;set;}                     // File size of attachment uploaded by user                        
    public Boolean ShowFileUpload {get;set;}              // Flag to render List of attachments section
    public Boolean ShowUploadFlag {get;set;}              // Flag to render Upload file section
    public Attachment attachment;                         
    public List<ID> emailattachId = new List<ID>();       // List of attachment Ids uploaded by User
    public List<Attachment> emailattachments;             // List of attachment uploaded by User to assign as Email file attachments
    public List<Attachment> Taskattachments;              // List of Task attachments from EmailAttachments
    public String EmailAttach;                            // To set list of attachment name in Description field                                        
    public String plainTextBody;
    public List<String> ListOFattachments {get;set;}      // To display list of attachment section in Page. 
    
    public CLS_SendEmail() {
        emailattachments = new List<Attachment>();
        Taskattachments = new List<Attachment>();
        ListOFattachments = new List<String>();
        Description='';
        EmailAttach = '';
        plainTextBody = '';
        ShowFileUpload  = false;
        ShowUploadFlag = false;
        
        // Set From address as Logged in user's address.
        
        String UserId = UserInfo.getUserID();
        User u = [Select Email, Name, Title from User where ID = :UserId limit 1];
        FromAddress = u.Email;
        
        // Set To address as Lead's email address
        
        aid = ApexPages.currentPage().getParameters().get('id'); 
        if(aid != null){
            Lead = [Select Name, Email__c from Lead__c where ID =: aid];
            To = Lead.email__c;
            RelatedTo = Lead.Name;
        }else{
            Lead = new Lead__c ();
        }
        
        EmailBody = '<BR /><BR /><BR /><BR /><BR />' + u.Name;
        
        if(u.Title != NULL)
            EmailBody += '<BR />' + u.Title ;
        
    }

    public PageReference SendEmail1(){
        if(to == ''&& AdditionalTo == ''){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please provide To Address'));
            return null;
        }
        if(Subject == ''){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please provide Subject'));
            return null;
        }
        if(EmailBody == ''){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please provide Email Body'));
            return null;
        }
        
        toAddress = new List<String>();
        CcAddress = new List<String>();
        BccAddress = new List<String>();
        AdditionaltoAddress = new List<String>();
        
        // Add list of To, CC and BCC address seperated by comma in respected lists.
        
        if(To != '')
        toaddress = To.split(',',-1);
        if(AdditionalTo != '')
        AdditionaltoAddress = AdditionalTo.split(',',-1);
        if(cc != '')
        Ccaddress = CC.split(',',-1);
        if(bcc != '')
        Bccaddress = BCC.split(',',-1);
        
        // Add additional to address list in Toaddress list.
        
        if(AdditionaltoAddress.size() > 0){
            for(String s : AdditionaltoAddress ){
                toaddress.add(s);
            }
        }
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(toaddress);   // Set To address
        if(ccAddress.size() > 0 && ccAddress != null)
            mail.setCcAddresses(ccaddress);  // Set CC address
        if(bccAddress.size() > 0  && ccAddress != null)
        mail.setBccAddresses(bccaddress);  // Set BCC address
        mail.setsubject(subject);          // Set Subject 
        mail.setHTMLBody(EmailBody);       // Set Body
        mail.setSenderDisplayName(FromAddress);     // Set From Address only for displaying email address
        
        List<Messaging.EmailFileAttachment> allAttachments = new List<Messaging.EmailFileAttachment>();  // List of attachments related to mail
        
        // List of attachments uploaded by user.
        emailattachments = [Select Body, Name, contentType from Attachment where ID IN :emailattachId];
        System.debug('emailattachments ===='+emailattachments );
        
        if(emailattachments.size()>0){
             for(Attachment a : emailattachments){
                 Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                 efa.setBody(a.Body);
                 efa.setFileName(a.Name);
                 EmailAttach += a.Name + ', ';
                 allAttachments.add(efa);            
             }
             system.debug('allAttachments===='+allAttachments);
             mail.setFileAttachments(allAttachments); // Set list of attachments with mail object to send mail
        }
        try{
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });  // Method for sending email with attachments.
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        
        // Set Comment field of Task with additional to, cc, BCC address, subject, body and attachment name.
        
        Description = 'Additional To : '+To +' '+AdditionalTo;
        Description += '\n CC : '+Cc;
        Description += '\n BCC : '+Bcc;
        Description += '\n Attachment : ';
        if(EmailAttach != null)
            Description += EmailAttach ;
        Description += '\n\n Subject : '+Subject;
        plainTextBody = EmailBody.replace('<br/>','');
        plainTextBody = plainTextBody.replace('<br />','');
        plainTextBody = plainTextBody.replace('&#39;','\'');
        plainTextBody = plainTextBody.replace('&amp;','&');
        plainTextBody = plainTextBody.replace('&quot;','"');
        plainTextBody = plainTextBody.replace('&lt;','<');
        plainTextBody = plainTextBody.replace('&gt;','>');
        plainTextBody = plainTextBody.replace('&nbsp;','');
        plainTextBody = plainTextBody.replace('<div>','');
        plainTextBody = plainTextBody.replace('</div>','');
        Description += '\n Body : '+'\n'+plainTextBody;
        
        // Create task for storing email and set Activity value = 2 from Type of Activity value as an Activity History
        
        Task t = new Task();
        t.WhatId = aid;
        t.Subject = 'Email : '+Subject;
     //   t.Type_Of_Activity__c = 'Sent an Email';
     //   t.ATP_JKI__c = 'ATP';
        t.Status = 'Completed';
        t.Description = Description;
        t.ActivityDate = System.Today();
        try{
            insert t;
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        
        // Set attachments with Task which is storing email as an Activity History
        
        if(emailattachments.size()>0){
             for(Attachment a : emailattachments){
                  Attachment taskAtt = new Attachment ();
                  taskAtt.Name = a.Name;
                  taskAtt.body = a.body;
                  taskAtt.ParentID = t.ID;
                  taskAttachments.add(taskAtt);
             }
             if(taskAttachments.size() > 0){
                 try{
                     insert taskAttachments;
                 }Catch(Exception e){
                     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
                 }
             }
             try{
                 delete emailattachments;  // Delete Attachments which were created when user has uploaded attachments
             }Catch(Exception e){
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
             }
        }
        
        PageReference page = new PageReference ('/'+aid);  // Return to lead detail page after sending email
        page.setRedirect(true);
        return page;
    }
    
    public void AttachFile(){
        ShowUploadFlag = true;
    }
    
    public void UploadFile(){
        ShowUploadFlag = false;
        
        // Create attachment record when user will upload attachment. because after creating attachment records, it will be used to set 
        // email file attachments and Task attachments.
        
        if(NameFile!=NULL && ContentFile!=NULL){
             //if(NameFile.endswith('doc') == true || NameFile.endswith('docx')== true || NameFile.endswith('xls') == true || NameFile.endswith('xlsx')== true  || NameFile.endswith('pdf')== true){ 
                 try{
                     Attachment myAttachment = new Attachment();             
                     myAttachment.Body = ContentFile;              
                     myAttachment.Name = NameFile;              
                     myAttachment.ParentId = aid;
                     insert myAttachment;  
                     emailattachID.add(myAttachment.ID); 
                     ListOFattachments.add(NameFile); 
                     ShowFileUpload = true;
                 }catch(Exception e){
                     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
                 }
             //}else{
                 // ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please upload the document of Word, Excel or PDF type'));
             //}
        }
    }
    
    public PageReference Cancel(){
        emailattachments = [Select Body, Name from Attachment where ID IN :emailattachId];
        if(emailattachments.size() > 0){
        try{
             delete emailattachments;  // Delete Attachments which were created when user has uploaded attachments
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        }
        PageReference page = new PageReference ('/'+aid);
        page.setRedirect(true);
        return page;
        
    }
}