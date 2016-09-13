global class CustomIterableBatchForAccountsch implements Schedulable
{

            public string nameFile{get;set;}
            public Blob contentFile{get;set;}
            
            global void execute(SchedulableContext ctx)
            {
            date dt =system.today().addDays(-1);
                List <Document> docs1 = [select id, Body from Document where createddate >= today];
                system.debug('@#@##@@@@@@@@@ docs'+docs1);
                for(Document d:docs1)
                {
                contentFile=d.Body;
                }
                 nameFile =blobToString( contentFile,'ISO-8859-1');
                System.debug('%^%^%^%%%%^%^%^^%^%contentFile'+contentFile);
              CustomIterableBatchForAccount ob=new CustomIterableBatchForAccount(nameFile);
            Database.executeBatch(ob);
            
                
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