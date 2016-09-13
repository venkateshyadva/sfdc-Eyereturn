public class Actionpollar
{

   
    public Integer Increment { get; set; }
     public Actionpollar()
        {
            Increment =0;
        }
    public void IncrementValue() {
       
       Increment=Increment+1;
    }
    }