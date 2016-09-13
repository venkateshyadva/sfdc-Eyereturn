trigger DontAllowModify on User (before update) {

Id profileId=userinfo.getProfileId();
String profileName=[Select Id,Name from Profile where Id=:profileId].Name;
system.debug('ProfileName'+profileName);

if(profileName!='System Administrator')
{
trigger.new[0].addError('You are not authorised to make any changes'); 
}

}