global class documentExcelParser1 implements Schedulable
{

 public string nameFile{get;set;}
    public Blob contentFile{get;set;}
    String[] filelines = new String[]{};
    List<Account> accstoupload;

      
    
global void execute(SchedulableContext ctx)
{
date dt =system.today().addDays(-1);
List <Document> docs1 = [select id, Body from Document where createddate >= today];
system.debug('@#@##@@@@@@@@@ docs'+docs1);

 try{
 for(Document d:docs1)
 {
 contentFile=d.body;
 
                //Convert the uploaded file which is in BLOB format into a string
                nameFile =blobToString( contentFile,'ISO-8859-1');
                system.debug('@#@##@@@@@@@@@ nameFile '+nameFile );
                //Now sepatate every row of the excel file
                filelines = nameFile.split('\n');
                
                //Iterate through every line and create a Account record for each row
                accstoupload = new List<Account>();
                for (Integer i=1;i<filelines.size();i++)
                {
                    String[] inputvalues = new String[]{};
                    inputvalues = filelines[i].split(',');
                    
                    Account a = new Account();
                    a.Name = inputvalues[0];
                    a.ShippingStreet = inputvalues[1];       
                    a.ShippingCity = inputvalues[2];
                    a.ShippingState = inputvalues[3];
                    a.ShippingPostalCode = inputvalues[4];
                    a.ShippingCountry = inputvalues[5];
        
                    accstoupload.add(a);
                }
         }
         }
         catch(Exception e){
               //  ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured reading the CSV file'+e.getMessage());
               // ApexPages.addMessage(errormsg);
         }       
        //Finally, insert the collected records
        try{
          //  Databse.insert accstoupload;
            Database.SaveResult[] srList = Database.insert(accstoupload, false);//Database method to insert the records in List
 system.debug('@@@@@@@@@@ srList  $$$$$$$'+srList );
        }
        
        catch (Exception e)
        {
           // ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured inserting the records'+e.getMessage());
           // ApexPages.addMessage(errormsg);
        } 

}

  public static String blobToString(Blob input, String inCharset){
        String hex = EncodingUtil.convertToHex(input);
        System.assertEquals(0, hex.length() & 1);
        final Integer bytesCount = hex.length() >> 1;
        String[] bytes = new String[bytesCount];
        for(Integer i = 0; i < bytesCount; ++i)
            bytes[i] =  hex.mid(i << 1, 2);
        return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), inCharset);
    }  
}