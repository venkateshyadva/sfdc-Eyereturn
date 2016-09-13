public class Test
{
public List<Integer> counterId{get;set;}
List<SelectOption> options{get;set;}
public Test(ApexPages.StandardController controller)
{}
public Test()
{
options = new List<SelectOption>();
options.add(new SelectOption('Audi','Audi'));
counterId = new List<Integer>();
counterId.add(1);
}
public PageReference addFilter()
{
counterId.add(1);
return null;
}
public List<SelectOption> getCars()
{

return options;
}
}