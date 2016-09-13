global class AccountCreationController {
    
    
    //constructor
    global AccountCreationController(){
    
       
    }
    global List<selectOption> getCounties(){
        List<selectOption> optionList = new List<selectOption>();
     system.debug('***Check State Value------'+account.Name);
         return optionList;
    }
    
    @RemoteAction
    global static boolean validCaptcha(string challenge, string response)
    {
      boolean correctResponse = false;
      string secret = '6LctrN0SAAAAAAnpL5tZWAC-ZoN--mlIXnE0yAca';
      string publicKey = '6LctrN0SAAAAAEYD1-RMaqTQotm2DTPMBNbxtVq5';
      //string publicKey = pubkey;
      //string publicKey = publicKey__c;
      
      string baseUrl = 'http://www.google.com/recaptcha/api/verify';

      string body ='privatekey='+ secret +  '&remoteip=' + remoteHost() + '&challenge=' + challenge + '&response=' + response + '&error=incorrect-captcha-sol';
      
      HttpRequest req = new HttpRequest();   
      req.setEndpoint( baseUrl );
      req.setMethod('POST');
      req.setBody ( body);
      try
      {
        Http http = new Http();
        HttpResponse captchaResponse = http.send(req);
        System.debug('response: '+ captchaResponse);
        System.debug('body: '+ captchaResponse.getBody());
        if ( captchaResponse != null )
        {  
            correctResponse = ( captchaResponse.getBody().contains('true') );
        }          
       
      }
      catch( System.Exception e)
      {
         System.debug('ERROR: '+ e);
      }                             
      return correctResponse;
    }

    global static string remoteHost()
    {
        string ret = '127.0.0.1';
        // also could use x-original-remote-host
        try
        {
            map<string , string> hdrs = ApexPages.currentPage().getHeaders();
            if ( hdrs.get('x-original-remote-addr') != null)
            {
                ret =  hdrs.get('x-original-remote-addr');
            }
            else if ( hdrs.get('X-Salesforce-SIP') != null)
            {   
                ret =  hdrs.get('X-Salesforce-SIP');
            }
        }
        catch(exception e)
        {
        
        }
        return ret;
    }
    
    
  /*-----------------------------------------------------------*/  
    Account account;
    
    public String Err { get; set; }
    public Account getAccount(){
        if(account == null){
            account = new Account();
        }
        return account;
    }
     
  public PageReference cancel() {
        
        PageReference accPage = new Pagereference ('http://www.google.com');
        accPage.setRedirect(true);
        return accPage;
        
    }
     public PageReference save() {
        
      
       
       account.Type='Prospect';
       insert account;
        
        PageReference accDetailPage = new Pagereference ('http://test-developer-edition.ap1.force.com/TestingPage');
        accDetailPage.setRedirect(true);
        return accDetailPage;
       
       return null;
     }   
     
     @RemoteAction
     public Static Account getEmail(String Email){
         system.debug('**************'+Email);
         Account acc = [select Id,Name From Account where Email__c =: Email];
         return acc;
     } 
     
    
     @isTest
    private static void testController() {
        Account acc = new Account(Name='Test1');
        Account acc1 = new Account(Name='Test2');
       acc1.Email__c='test@gmail.com';
        insert acc;
        insert acc1;
        update acc1;
        AccountCreationController ctrl = new AccountCreationController();
        ctrl.account = new Account();
        ctrl.account = new Account(Name = 'Test3');
        ctrl.account.Type = 'Prospect';
        ctrl.getAccount();
        ctrl.getCounties();
        ctrl.save();
        ctrl.cancel();
        ctrl.Err='';
   Account acccc=AccountCreationController.getEmail('test@gmail.com');
        //boolean blean = AccountCreationController.validCaptcha('test','test');
        //System.assert('There should be two contacts named Smith here.');
        Boolean blean = AccountCreationController.validCaptcha('test','test');
    }
    
    
    
}