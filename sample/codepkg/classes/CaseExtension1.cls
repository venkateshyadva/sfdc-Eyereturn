public class CaseExtension1 {
public list<Case> case1{get;set;}
public list<Case> case2{get;set;}
    public CaseExtension1(ApexPages.StandardController controller) {
     
    }
    public list<Case> getcases()
    {
       case1=[Select Priority,CaseNumber,Accountid,Subject,Contactid,CreatedDate,Ownerid,Status from case where (Ownerid=:UserInfo.getUserId() or Contactid=:UserInfo.getUserId()) and IsClosed=false];  
     return case1;
    }
    public list<Case> getcases1()
    {
     case2=[Select Priority,CaseNumber,Accountid,Subject,Contactid,CreatedDate,Ownerid,Status from case where (Ownerid=:UserInfo.getUserId() or Contactid=:UserInfo.getUserId())  and IsClosed=true];  
     return case2;
    }

}