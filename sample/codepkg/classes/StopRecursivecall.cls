public class StopRecursivecall
 {
                 private static boolean Update_OnBehalfendUserStatus = false;
      public static boolean hasUpdate_OnBehalfendUserStatus() 
                  {
        return Update_OnBehalfendUserStatus;
     }
                 public static void setUpdate_OnBehalfendUserStatus() {
        Update_OnBehalfendUserStatus = true;
    }
 }