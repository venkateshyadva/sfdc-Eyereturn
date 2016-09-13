@istest
public class Test_DontAllowModify{

public static testmethod void T_DontAllowModify()
{
Id profileId=userinfo.getProfileId();
String profileName=[Select Id,Name from Profile where Id=:profileId].Name;
system.debug('ProfileName'+profileName);

    User testUser = new User();
    testUser.alias = 'u11';
    testUser.email='u1@testorg.com';
            testUser.emailencodingkey='UTF-8';
             testUser.lastname='Testing1';
              testUser.languagelocalekey='en_US';
              testUser.localesidkey='en_US';
               testUser.profileid = profileId;
                 testUser.country='United States';
                  testUser.CommunityNickname = 'u1';
                  
            testUser.timezonesidkey='America/Los_Angeles';
            testUser.username='u1@testorg.com';
  insert testUser;
                 testUser.country='india';
            update testUser;
            
            }
            }