global class Schecudlertestaccount22  implements Schedulable  {
   
    global void execute(SchedulableContext ctx) {
        // Schecudlertestaccount22  c = new Schecudlertestaccount22();
        //String sch = '0 6 12 * * ? ';
        //String sch = '0 0 0 3 9 ? 2022';
        //system.schedule('Schecudlertestaccount', sch, c);
        
        Account acct= new Account();
        //acct.Type
        acct=[SELECT id, Type from Account where Type='Other'];
        acct.Site='www.abc.com';
        update acct;
    }

}