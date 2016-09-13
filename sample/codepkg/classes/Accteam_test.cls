@IsTest
public class Accteam_test{
   
    static testmethod void MyUnitTest(){
    PageReference pageRef = Page.Accteam;
    Test.setCurrentPage(pageRef);
   
    Account acc = new Account(Name='ABC');
    insert acc;
   
    //ApexPages.StandardController sc = new ApexPages.standardController(acc);
//Accteam  ctrl = new Accteam();
    // create an instance of the controller
   // Accteam  acct = new Accteam(sc);
   // ctrl .forward();
   
    }
}