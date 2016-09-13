public class nestedqueryexample
{

    public String getAccount() {
        return null;
    }

  public List<Account> getaccsandtmember()
  {
      List<Account> accounts = [Select Id ,Name, BillingCountry from Account];
      return accounts;
  }
}