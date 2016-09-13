public with sharing class AccountChartController
{
    private static List<String> months=new List<String>
           {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'};
               
    private Account acc;
 
    public AccountChartController(ApexPages.StandardController std)
    {
        acc=(Account) std.getRecord();
    }
     
    public List<Data> getChartData()
    {
        Map<Integer, Data> dataByMonth = new Map<Integer, Data>();
        List<Data> chartData=new List<Data>();
         
        DateTime startDT=DateTime.newInstance(Date.today().addYears(-1).toStartOfMonth(), Time.newInstance(0, 0, 0, 0));
        DateTime endDT=DateTime.newInstance(Date.today().toStartOfMonth(), Time.newInstance(23, 59, 59, 999));
         
        Integer startMonth=startDT.date().month()-1;
        for (Integer idx=0; idx<12; idx++)
        {
            Integer monthNo=Math.mod(startMonth+idx, 12);
            Data theData=new Data(months.get(monthNo));
            dataByMonth.put(monthNo, theData);
            chartData.add(theData);
        }
         
        for (Event ev : [select id , EndDateTime
                        from Event
                        where WhatId=:acc.id
                        and EndDateTime>=:startDT
                        and EndDateTime<=:endDT])
        {
            Data cand=dataByMonth.get(ev.EndDateTime.date().month()-1);
            cand.activities++;
        }
                             
        for (Task ts : [select id, ActivityDate
                        from Task
                        where WhatId=:acc.id
                        and ActivityDate>=:startDT.date()
                        and ActivityDate<=:endDT.date()])
        {
            Data cand=dataByMonth.get(ts.ActivityDate.month()-1);
            cand.activities++;
        }
                             
        for (Opportunity opp : [select id, CloseDate, Amount
                                from Opportunity
                                where AccountId=:acc.id
                                and IsClosed = true
                                and IsWon = true
                                and CloseDate>=:startDT.date()
                                and CloseDate<=:endDT.date()])
        {
            Data cand=dataByMonth.get(opp.CloseDate.month()-1);
            cand.oppTotal+=opp.Amount;
        }
                             
        return chartData;
    }
     
    // Wrapper class to contain the chart data
    public class Data
    {
        public String name { get; set; }
        public Integer activities { get; set; }
        public Decimal oppTotal { get; set; }
         
        public Data(String name)
        {
            this.name = name;
            this.activities = 0;
            this.oppTotal = 0.0;
        }
    }
}