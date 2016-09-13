public class UserLookupResultController {
  
  private String assignmentType = ApexPages.currentPage().getParameters().get('type');
  
  public UserLookupResultController(){
    setProperties();
  }
  
  public List<UserInfo> userInfos { get; set; }
  
  private void setProperties(){
    
    List<User> users = getUsers();
    
    Set<String> userIds = new Set<String>();
    for(User user : users){
      userIds.add(user.Id);
    }
    
    Map<String, Integer> qcCountForUser = getQcCount(userIds);
    
    userInfos = new List<UserInfo>();
    for(user user : users){
      Integer qcCount = qcCountForUser.get(user.Id);
      qcCount = qcCount == null ? 0 : qcCount;
      userInfos.add(new UserInfo(user, qcCount));
    }
  }
  
  private List<User> getUsers(){
    List<User> result = new List<User>();
    if(assignmentType == 'assignment'){
      result = [select Id, Name, UserRole.Name from User where Profile.Name = 'CAC SSI QC'];
    }
    else if(assignmentType == 'recall'){
      result = [select Id, Name, UserRole.Name from User where Profile.Name = 'CAC SSI SV' or Profile.Name = 'CAC SSI TL'];
    }
    return result;
  }
  
  private Map<String, Integer> getQcCount(Set<String> userIds){
    Map<String, Integer> qcCountMap = new Map<String, Integer>();
    //for(AggregateResult result : [select OwnerId, COUNT(Id) qcSize from QC__c where RecordTypeId = '01290000000rXmW'and Status__c = 'New'
   //                 and Status__c = 'In Progress' and OwnerId in :userIds group by OwnerId]){
   //   qcCountMap.put((String)result.get('OwnerId'), (Integer)result.get('qcSize'));
   // }
    return qcCountMap;
  }
  
  
  public class UserInfo{
    public UserInfo(User user, Integer qcCount){
      this.user = user;
      this.qcCount = qcCount;
    }
    
    public User user { get; set; }
    public Integer qcCount { get; set; }
  }
}