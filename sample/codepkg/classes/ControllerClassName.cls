public class ControllerClassName
{
    public List<String> strList { get;set; }
    
    public void autoRun() 
    {
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get('contact').getDescribe().fields.getMap();

        strList = new List<String>(objectFields.keySet());

    }
}