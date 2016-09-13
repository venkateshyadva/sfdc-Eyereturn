public with sharing class Accteam {

public Accteam(ApexPages.StandardSetController controller) {

}

public PageReference forward()

{

String lastName = UserInfo.getLastName();

String firstName = UserInfo.getFirstName();

PageReference ContPage;


if(lastName=='Smith' && firstName =='John')

{

ContPage = new PageReference('/00O40000003347l');

}

//ContPage.getParameters().put('nooverride','1');

return ContPage;

}

 

}