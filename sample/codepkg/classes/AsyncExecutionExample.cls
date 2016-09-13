public class AsyncExecutionExample implements Queueable 
{
    public void execute(QueueableContext context) {
     System.debug('execute method @@@@@@@@@');  
        Account a = new Account(Name='Acme',Phone='(415) 555-1212');
        insert a;   
          
        ID jobID = System.enqueueJob(new AsyncExecutionExample());
        AsyncApexJob jobInfo = [SELECT Status,NumberOfErrors FROM AsyncApexJob WHERE Id=:jobID];
        
    }
   /* public static void tetemethod(String str)
    {
    System.debug('tetemethod execute method @@@@@@@@@');    
    }*/
}