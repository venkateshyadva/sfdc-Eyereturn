global class documentExcelParser implements Schedulable
{



global void execute(SchedulableContext ctx)
{
date d = system.today();
system.debug('^^^^^^^^^^^^^^^$$$ d '+d );
Document[] docs = [select Body from Document where createdDate = :d];
system.debug('@#@##@@@@@@@@@ docs'+docs);

}

}