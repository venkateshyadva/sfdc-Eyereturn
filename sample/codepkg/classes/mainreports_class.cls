public class mainreports_class {
list<selectoption> v=new list<selectoption>();
public list<selectoption>getGetvalues() {
v.add(new selectoption('Select','--Select Rport--'));
v.add(new selectoption('FR Performance report based on Month','FR Performance report based on Month'));
v.add(new selectoption('MD Order Report','MD Order Report'));
v.add(new selectoption('Region Performance based on CBF','Region Performance based on CBF'));
v.add(new selectoption('Retailer Performance based on Month','Retailer Performance based on Month'));
return v;
}
public String selectedvalue { get; set; }
public String url{ get; set; }
User usr = [Select id,Alias,lastname,ContactId,Profile.name from User where id=:UserInfo.getUserId() Limit 1];
string prof=usr.Profile.name;
User usr1 = [Select id,Alias,lastname,ContactId,Profile.name from User where id=:UserInfo.getUserId() Limit 1];
string prof1=usr1.Profile.name;
User usr3 = [Select id,Alias,lastname,ContactId,Profile.name from User where id=:UserInfo.getUserId() Limit 1];
string prof3=usr3.Profile.name;
User usr4 = [Select id,Alias,lastname,ContactId,Profile.name from User where id=:UserInfo.getUserId() Limit 1];
string prof4=usr4.Profile.name;
User usr5 = [Select id,Alias,lastname,ContactId,Profile.name from User where id=:UserInfo.getUserId() Limit 1];
string prof5=usr5.Profile.name;
public void rpid() {
if(prof=='CMM East Profile')
{
if(selectedvalue =='FR Performance report based on Month')
{
url='/00Oa0000007nvM7?pv0=East&isdtp=nv';
}else
if(selectedvalue =='MD Order Report')
{
url='/00Oa0000007nvMb?pv0=East&isdtp=nv';
}else
if(selectedvalue =='Region Performance based on CBF')
{
url='/00Oa0000007nvMS?pv0=East&isdtp=nv';
}else
if(selectedvalue =='Retailer Performance based on Month')
{
url='/00Oa0000007nvMH?pv0=East&isdtp=nv';
}

}else if(prof1=='CMM South Profile'){
if(selectedvalue =='FR Performance report based on Month')
{
url='/00Oa0000007nvM7?pv0=South&isdtp=nv';
}else
if(selectedvalue =='MD Order Report')
{
url='/00Oa0000007nvMb?pv0=South&isdtp=nv';
}else
if(selectedvalue =='Region Performance based on CBF')
{
url='/00Oa0000007nvMS?pv0=South&isdtp=nv';
}else
if(selectedvalue =='Retailer Performance based on Month')
{
url='/00Oa0000007nvMH?pv0=South&isdtp=nv';
}
}else if(prof5=='CMM North Profile'){
if(selectedvalue =='FR Performance report based on Month')
{
url='/00Oa0000007nvM7?pv0=North&isdtp=nv';
}else
if(selectedvalue =='MD Order Report')
{
url='/00Oa0000007nvMb?pv0=North&isdtp=nv';
}else
if(selectedvalue =='Region Performance based on CBF')
{
url='/00Oa0000007nvMS?pv0=North&isdtp=nv';
}else
if(selectedvalue =='Retailer Performance based on Month')
{
url='/00Oa0000007nvMH?pv0=North&isdtp=nv';
}

}
else if(prof3=='CMM West Profile')
{
if(selectedvalue =='FR Performance report based on Month')
{
url='/00Oa0000007nvM7?pv0=West&isdtp=nv';
}else
if(selectedvalue =='MD Order Report')
{
url='/00Oa0000007nvMb?pv0=West&isdtp=nv';
}else
if(selectedvalue =='Region Performance based on CBF')
{
url='/00Oa0000007nvMS?pv0=West&isdtp=nv';
}else
if(selectedvalue =='Retailer Performance based on Month')
{
url='/00Oa0000007nvMH?pv0=West&isdtp=nv';
}

}


}
public static testmethod void test1()
{
mainreports_class c=new mainreports_class();

c.getGetvalues();

c.prof='CMM East Profile';
c.selectedvalue ='FR Performance report based on Month';
c.rpid();
c.prof='CMM South Profile';
c.selectedvalue ='MD Order Report';
c.rpid();
c.prof='CMM North Profile';
c.selectedvalue ='Region Performance based on CBF';
c.rpid();
c.prof='CMM West Profile';
c.selectedvalue ='Retailer Performance based on Month';
c.rpid();

//Like this do for all. Using so many if conditions is not a good coding standard.

} 

}