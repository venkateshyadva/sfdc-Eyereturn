Public class constNumtoLetter
  {
    
      Public String[] unitdo = new String[]{'', ' One', ' Two', ' Three', ' Four', ' Five',
         ' Six', ' Seven', ' Eight', ' Nine', ' Ten', ' Eleven', ' Twelve',
         ' Thirteen', ' Fourteen', ' Fifteen',  ' Sixteen', ' Seventeen', 
         ' Eighteen', ' Nineteen'};
      Public String[] tens = new String[]{'', 'Ten', ' Twenty', ' Thirty', ' Forty', ' Fifty',
         ' Sixty', ' Seventy', ' Eighty',' Ninety'};
      Public String[] digit = new String[] {'', ' Hundred', ' Thousand', ' Lakh', ' Crore'};
      
      
      /*List<String> unitdo = new List<String>();
       unitdo.add('');
       unitdo.add(' One');
       unitdo.add(' Two');
       unitdo.add(' Three');
       unitdo.add(' Four');
       unitdo.add(' Five');
       unitdo.add(' Six');
       unitdo.add(' Seven');
       unitdo.add(' Eight');
       unitdo.add(' Nine');
       unitdo.add(' Ten');
       unitdo.add(' Eleven');
       unitdo.add(' Twelve');
       unitdo.add(' Thirteen');
       unitdo.add(' Fourteen');
       unitdo.add(' Fifteen');
       unitdo.add(' Sixteen');
       unitdo.add(' Seventeen');
       unitdo.add(' Eighteen');
       unitdo.add(' Nineteen');
     
     List<String> tens = new List<String>();
        
        tens.add('');
        tens.add(' Ten');
        tens.add(' Twenty');
        tens.add(' Thirty');
        tens.add(' Forty');
        tens.add(' Fifty');
        tens.add(' Sixty');
        tens.add(' Seventy');
        tens.add(' Eighty');
        tens.add(' Ninety');
        
    List<String> digit = new List<String>();
        
        digit.add('');
        digit.add(' Hundred');
        digit.add(' Thousand');
        digit.add(' Lakh');
        digit.add(' Crore');
        */
         
      
      Public integer r;
      

        integer cnt;
    
    
    public  String convertNunber(integer num){
        
          integer len, q=0, r=0;
          String ltr = '';
          String Str = '';
          len = numberCount(num);
        while (len>0)
         {

             
             if(len == 1){
                Str = Str + unitdo[num];
                num=0;
             }else if( len == 2){
                ltr = twonum(num);
                Str = Str + ltr;
                num=0;
            }else if(len == 3){
                r = num;
                ltr = threenum(r);
                Str = Str + ltr;
                num = 0;    
            }else if(len == 4){
                q=num/1000;
                r=math.mod(num,1000);
                ltr = twonum(q);
                Str= Str+ltr+digit[2];
                num = r;    
             }else if(len == 6){
                                   q=num/1000;
                                   r=math.mod(num,1000);
                                   ltr = threenum(q);
                                   Str= Str+ltr+digit[2];
                                   num = r;
                
                     }else if(len == 8){
                                  q=num/10000000;
                                  r=math.mod(num,10000000);
                                  ltr = threenum(q); 
                                  Str = Str+ltr+digit[4];
                                  num = r;
                                
                     }
                
                                 if (num==0)
                                  System.debug('....................'+Str);
            
            len--;
         }
         return str;
    }
    
    
    
      //Count the number of digits in the input number
      public integer numberCount(integer num)
      {
          integer cnt=0;

          while (num>0)
          {
            r = math.mod(num,10);
            cnt++;
            num = num / 10;
          }

            return cnt;
      }


      //Function for Conversion of two digit

      public String twonum(integer numq)
      {
           integer numr, nq;
           String ltr='';

           nq = numq / 10;
           numr = math.mod(numq,10);

           if (numq>19)
             {
           ltr=ltr+tens[nq]+unitdo[numr];
           //ltr=ltr+tens[nq];
             }
           else
             {
           ltr = ltr+unitdo[numq];
             }

           return ltr;
      }

      //Function for Conversion of three digit

      public String threenum(integer numq)
      {
             integer numr, nq;
             String ltr = '';

             nq = numq / 100;
             numr = math.mod(numq,100);

             if (numr == 0)
              {
              ltr = ltr + unitdo[nq]+digit[1];
              //ltr = ltr + unitdo[nq];
               }
             else
              {
              //ltr = ltr +unitdo[nq]+digit[1]+' and'+twonum(numr);
             ltr = ltr +unitdo[nq]+twonum(numr);
              }
             return ltr;

      }

}