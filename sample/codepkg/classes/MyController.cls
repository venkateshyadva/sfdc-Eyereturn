public class MyController
{
public Account obj{get;set;}
public String applicationType{get;set;}

public MyController(ApexPages.StandardController controller)
{
this.obj = (Account)controller.getRecord();
Account tempobj = [SELECt ID,type FROM Account WHERE id = :obj.Id];
applicationType = tempobj.Type;
}
public PageReference setApp()
{
PageReference pf;
if(applicationType == 'ABC')
{
pf = new PageReference('/apex/ABCVFPAGE?id='+obj.Id);
}
else if(applicationType == 'XYZ')
{
pf = new PageReference('/apex/XYZVFPAGE?id='+obj.Id);
}
else{
pf = new PageReference('/apex/XYZVFPAGE?id='+obj.Id);
}
pf.setredirect(true);
return pf;
}
public PageReference getsetApp()
{
return null;
}
}