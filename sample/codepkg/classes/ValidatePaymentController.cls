public class ValidatePaymentController {
    private string accountId                  {get;set;}
    private string accountName                {get;set;} 
    private string customerName               {get;set;}
    private string address1                   {get;set;}
    private string address2                   {get;set;}
    private string city                       {get;set;}
    private string state                      {get;set;}
    private string country                    {get;set;}
    private string zipCode    {get;set;}
    
    public string errorDescription           {get;set;} 
    public string paymentMessage             {get;set;} 
    public string paymentDeclinedMessage     {get;set;}
    public string paymentAuthorization       {get;set;}
    boolean hasWarningOrError;
    
    public boolean showAuthCode              {get;set;}
    public boolean showDeclined             {get;set;}
    public boolean pageMessage               {get;set;} 

    public boolean displayMsgOnly                {get; set;}
        public boolean hidepageblocksection {get; set;}

    public boolean displayPage               {get;set;}
    public String transactionId;
    public String formattedPaymentDate;
    
    // public List<PaymentDetail> paymentDetails {get;set;}
    public List<String> lstBiilingAccts {get;set;}
    public Map<String,List<PaymentDetail>> paymentsByAcct {get;set;}
    public Map<String,String> paymentMap {get;set;}
    public String paramAcctId {get;set;}
    public Integer paramIndex {get;set;}
    public Integer totalPayCount {get;set;}
    
    public List<SelectOption> getcountries()
    {
        List<SelectOption> options = new List<SelectOption>();
        //options.add(new SelectOption('','--- None ---'));
        options.add(new SelectOption('US','USA'));
        options.add(new SelectOption('CN','CAN'));
        
        return options;
    } 
    
    
    /**************************************************************************
     Purpose : Constructor Method to initialize the variables with default values
    **************************************************************************/
    public ValidatePaymentController(ApexPages.StandardController controller){
        displayPage = true;
        showAuthCode=true;
        lstBiilingAccts=new List<String>();
        paymentsByAcct=new Map<String,List<PaymentDetail>>();
        paymentMap=new Map<String,String>();
        totalPayCount=0;
        
        accountId = ApexPages.currentPage().getParameters().get('id');
        String billingAccountIdParam = ApexPages.currentPage().getParameters().get('billingaccountId');
      //  List<String> billingAccountIdList =billingAccountIdParam.split(',');
        
        List<Account> accountList = [SELECT Name, Account_Address_City__c, Account_Address_State__c, Account_Address_Street__c, Account_Address_Zip_Postal_Code__c FROM Account WHERE Id=:accountId];
        List<Contact> contactList = [SELECT Name FROM Contact WHERE AccountId=:accountId ];
        if(!accountList.isEmpty()){
            for(Account accountObj : accountList){
                
                accountName = accountObj.Name;
                city = accountObj.Account_Address_City__c;
                state = accountObj.Account_Address_State__c;
                address1 = accountObj.Account_Address_Street__c;
                address2 = '';
                zipCode = accountObj.Account_Address_Zip_Postal_Code__c;
            }
        }
        if(!contactList.isEmpty()){
            for(Contact contactObj : contactList){
                customerName = contactObj.Name;
            }
        }
   /*     for(String reqParamsPair:billingAccountIdList){
            System.debug('reqParamsPair===='+reqParamsPair);
            String[] billingAcctParam=reqParamsPair.split('\\^');
            String billingACctId=billingAcctParam[0];
            String ArBal = billingAcctParam[0].replace('$', '');
            lstBiilingAccts.add(billingACctId);
            PaymentDetail oPayment=this.initPayment(billingACctId,ArBal,0);
            List<PaymentDetail> paymentDetail=new List<PaymentDetail>();
            paymentDetail.add(oPayment);
            paymentsByAcct.put(billingACctId,paymentDetail);
            paymentMap.put(billingACctId,ArBal);
            totalPayCount++;
        }    */
    }
    
    private PaymentDetail initPayment(String billingAcctId,String balance,Integer index){
            PaymentDetail oPayment=new PaymentDetail();
            oPayment.billingAccountId=billingAcctId;
            String ArBal = balance;
            oPayment.paymentAmount = double.valueof(ArBal) ;
            oPayment.bankChkNumber = 0;
            oPayment.bankRoutNumber = '0';
            oPayment.bankAcctNumber = '0';
            oPayment.bankAcctType = '0';
            oPayment.creditCardNumber = '0';
            oPayment.creditCardType = '0';
            oPayment.creditCardExpDate = '0';
            oPayment.creditCardSecCode = '0';
            oPayment.cvvCid = '0'; 
            
            oPayment.accountName = accountName;
            oPayment.city=city;
            oPayment.state=state;
            oPayment.address1=address1;
            oPayment.address2=address2;
            oPayment.zipCode=zipCode;
            oPayment.accountId=accountId;
            oPayment.customerName=customerName;
            oPayment.displayMsgOnly = false;
            oPayment.showAuthCode = true;
            oPayment.pageMessage = false;
            oPayment.showDeclined = false;
            oPayment.paymentMessage = 'Payment is Successful.';
            oPayment.transactionId = 'Validate Payment';
            oPayment.index=index;
            return oPayment; 
    }
    
    public PageReference addPayment(){
        List<PaymentDetail> lsDetails=paymentsByAcct.get(paramAcctId);
        //if(totalPayCount<10){
            String balance=paymentMap.get(paramAcctId);
            lsDetails.add(initPayment(paramAcctId,balance,lsDetails.size()));
            totalPayCount++;
            paramAcctId='';
            hidepageblocksection =false;
        /*}else{
         ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Max limit for total no payments is 10.'));
         if(lsDetails!=null && lsDetails.size()>0) lsDetails.get(0).pageMessage=true;
        }*/
        return null;
    }
    
    
    public PageReference deletePayment(){
        Integer srchIndex=-1;
        List<PaymentDetail> lsDetails=paymentsByAcct.get(paramAcctId);
        for(PaymentDetail oPay:lsDetails){
         srchIndex++;
         if(oPay.index==paramIndex)
             break;
        }
        if(srchIndex>-1){
            lsDetails.remove(srchIndex);
            totalPayCount--;
        }
        if(lsDetails.size()==0){
          String balance=paymentMap.get(paramAcctId);
          lsDetails.add(initPayment(paramAcctId,balance,lsDetails.size()));
          totalPayCount++;
        }
        paramAcctId='';
        paramIndex=0;
        return null;
    }
    
    /**************************************************************************
     Purpose : Method which invokes the Validate Payment Webservice
               and captures the Response or error Messages returned by the
               Validate Payment Webservice
    **************************************************************************/
        public class PaymentDetail{
        public string paymentType                {get;set;}
        public string accountId                  {get;set;}
        public String billingAccountId           {get;set;}
        public string accountName                {get;set;} 
        public string customerName               {get;set;}
        public string bankAcctNumber             {get;set;}
        public string bankAcctType               {get;set;}
        public Double bankChkNumber              {get;set;}
        public string bankRoutNumber             {get;set;}
        public string address1                   {get;set;}
        public string address2                   {get;set;}
        public string city                       {get;set;}
        public string state                      {get;set;}
        public string country                    {get;set;}
        public string zipCode                    {get;set;}
        public string creditCardNumber           {get;set;}
        public string creditCardType             {get;set;}
        public string month                      {get;set;}
        public string year                       {get;set;}
        public string creditCardExpDate          {get;set;}
        public string creditCardSecCode          {get;set;}
        public string cvvCid                     {get;set;}
        public Double paymentAmount              {get;set;}
        public string paymentDate                {get;set;}
        public string paymentMethod              {get;set;}
        public boolean recurringPayment          {get;set;}
        public string recurringInd;
        public Integer index {get;set;}
        
        public transient string errorDescription           {get;set;} 
        public string paymentMessage             {get;set;} 
        public string paymentDeclinedMessage     {get;set;}
        public string paymentAuthorization       {get;set;}
        boolean hasWarningOrError;
        public boolean displayPage               {get;set;}
        public boolean showAuthCode              {get;set;}
        public boolean showDeclined             {get;set;}
        public boolean pageMessage               {get;set;} 
        public boolean displayMsgOnly      {get; set;}
        public String transactionId;
        public String formattedPaymentDate;
        
        public List<SelectOption> getStates()
        {
        List<SelectOption> options = new List<SelectOption>();
        system.debug('Country' +country);
        if(country == 'US')
        {       
            options.add(new SelectOption('','--- None ---'));
            options.add(new SelectOption('GU','Guam'));
            options.add(new SelectOption('AK','Alaska'));
            options.add(new SelectOption('AL','Alabama'));
            options.add(new SelectOption('AR','Arkansas'));
            options.add(new SelectOption('AZ','Arizona'));
            options.add(new SelectOption('CA','California'));
            options.add(new SelectOption('CO','Colorado'));
            options.add(new SelectOption('CT','Connecticut'));
            options.add(new SelectOption('DC','District Of Columbia'));
            options.add(new SelectOption('DE','Delaware'));
            options.add(new SelectOption('FL','Florida'));
            options.add(new SelectOption('GA','Georgia'));
            options.add(new SelectOption('HI','Hawaii'));
            options.add(new SelectOption('IA','Iowa'));
            options.add(new SelectOption('ID','Idaho'));
            options.add(new SelectOption('IL','Illinois'));
            options.add(new SelectOption('IN','Indiana'));
            options.add(new SelectOption('KS','Kansas'));
            options.add(new SelectOption('KY','Kentucky'));
            options.add(new SelectOption('LA','Louisiana'));
            options.add(new SelectOption('MA','Massachusetts'));
            options.add(new SelectOption('MD','Maryland'));
            options.add(new SelectOption('ME','Maine'));
            options.add(new SelectOption('MI','Michigan'));
            options.add(new SelectOption('MN','Minnesota'));
            options.add(new SelectOption('MO','Missouri'));
            options.add(new SelectOption('MS','Mississippi'));
            options.add(new SelectOption('MT','Montana'));
            options.add(new SelectOption('NC','North Carolina'));
            options.add(new SelectOption('ND','North Dakota'));
            options.add(new SelectOption('NE','Nebraska'));
            options.add(new SelectOption('NH','New Hampshire'));
            options.add(new SelectOption('NJ','New Jersey'));
            options.add(new SelectOption('NM','New Mexico'));
            options.add(new SelectOption('NV','Nevada'));
            options.add(new SelectOption('NY','New York'));
            options.add(new SelectOption('OH','Ohio'));
            options.add(new SelectOption('OK','Oklahoma'));
            options.add(new SelectOption('OR','Oregon'));
            options.add(new SelectOption('PA','Pennsylvania'));
            options.add(new SelectOption('PI','Pacific Islands'));
            options.add(new SelectOption('PR','Puerto Rico'));
            options.add(new SelectOption('RI','Rhode Island'));
            options.add(new SelectOption('SC','South Carolina'));
            options.add(new SelectOption('SD','South Dakota'));
            options.add(new SelectOption('TN','Tennessee'));
            options.add(new SelectOption('TX','Texas'));
            options.add(new SelectOption('UT','Utah'));
            options.add(new SelectOption('VA','Virginia'));
            options.add(new SelectOption('VT','Vermont'));
            options.add(new SelectOption('WA','Washington'));
            options.add(new SelectOption('WI','Wisconsin'));
            options.add(new SelectOption('WV','West Virginia'));
            options.add(new SelectOption('WY','Wyoming'));
            options.add(new SelectOption('AA','Armed Forces America'));
            options.add(new SelectOption('AE','Armed Forces Europe'));
            options.add(new SelectOption('AP','Armed Forces Pacific'));
            
            
             
            system.debug('US Options' + options);
        }
        else if(country == 'CN')
        {       
            options.add(new SelectOption('AB','Alberta'));
            options.add(new SelectOption('ON','Ontario'));
            options.add(new SelectOption('MB','Manitoba'));
            options.add(new SelectOption('NB','New Brunswick'));
            options.add(new SelectOption('NF','New Foundland'));
            options.add(new SelectOption('NS','Nova Scotia'));
            options.add(new SelectOption('NT','Northwest Teritory'));
            options.add(new SelectOption('PE','Prince Edward Island'));
            options.add(new SelectOption('SK','Saskatchewan'));
            options.add(new SelectOption('BC','British Columbia'));
            options.add(new SelectOption('QC','Quebec'));
            options.add(new SelectOption('YT','Yukon'));
            options.add(new SelectOption('LB','Labrador'));
            options.add(new SelectOption('BH','British Virgin Islan'));
            system.debug('CN Options' + options);
        }
        else
        {
            options.add(new SelectOption('','--- None ---'));
            options.add(new SelectOption('GU','Guam'));
            options.add(new SelectOption('AK','Alaska'));
            options.add(new SelectOption('AL','Alabama'));
            options.add(new SelectOption('AR','Arkansas'));
            options.add(new SelectOption('AZ','Arizona'));
            options.add(new SelectOption('CA','California'));
            options.add(new SelectOption('CO','Colorado'));
            options.add(new SelectOption('CT','Connecticut'));
            options.add(new SelectOption('DC','District Of Columbia'));
            options.add(new SelectOption('DE','Delaware'));
            options.add(new SelectOption('FL','Florida'));
            options.add(new SelectOption('GA','Georgia'));
            options.add(new SelectOption('HI','Hawaii'));
            options.add(new SelectOption('IA','Iowa'));
            options.add(new SelectOption('ID','Idaho'));
            options.add(new SelectOption('IL','Illinois'));
            options.add(new SelectOption('IN','Indiana'));
            options.add(new SelectOption('KS','Kansas'));
            options.add(new SelectOption('KY','Kentucky'));
            options.add(new SelectOption('LA','Louisiana'));
            options.add(new SelectOption('MA','Massachusetts'));
            options.add(new SelectOption('MD','Maryland'));
            options.add(new SelectOption('ME','Maine'));
            options.add(new SelectOption('MI','Michigan'));
            options.add(new SelectOption('MN','Minnesota'));
            options.add(new SelectOption('MO','Missouri'));
            options.add(new SelectOption('MS','Mississippi'));
            options.add(new SelectOption('MT','Montana'));
            options.add(new SelectOption('NC','North Carolina'));
            options.add(new SelectOption('ND','North Dakota'));
            options.add(new SelectOption('NE','Nebraska'));
            options.add(new SelectOption('NH','New Hampshire'));
            options.add(new SelectOption('NJ','New Jersey'));
            options.add(new SelectOption('NM','New Mexico'));
            options.add(new SelectOption('NV','Nevada'));
            options.add(new SelectOption('NY','New York'));
            options.add(new SelectOption('OH','Ohio'));
            options.add(new SelectOption('OK','Oklahoma'));
            options.add(new SelectOption('OR','Oregon'));
            options.add(new SelectOption('PA','Pennsylvania'));
            options.add(new SelectOption('PI','Pacific Islands'));
            options.add(new SelectOption('PR','Puerto Rico'));
            options.add(new SelectOption('RI','Rhode Island'));
            options.add(new SelectOption('SC','South Carolina'));
            options.add(new SelectOption('SD','South Dakota'));
            options.add(new SelectOption('TN','Tennessee'));
            options.add(new SelectOption('TX','Texas'));
            options.add(new SelectOption('UT','Utah'));
            options.add(new SelectOption('VA','Virginia'));
            options.add(new SelectOption('VT','Vermont'));
            options.add(new SelectOption('WA','Washington'));
            options.add(new SelectOption('WI','Wisconsin'));
            options.add(new SelectOption('WV','West Virginia'));
            options.add(new SelectOption('WY','Wyoming'));
        }      
        system.debug('Options' + options);
        return options;
        
    } 
   }
}