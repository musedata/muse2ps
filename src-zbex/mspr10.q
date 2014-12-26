
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³M* 10. msk_number (t1)                                            ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Purpose:  Typeset a number                                    ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Inputs:  t1 = number                                          ³ 
&dA &d@³             y = vertical location of number                      ³ 
&dA &d@³                                                                  ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure msk_number (t1) 
        int t1 
        getvalue t1 

        x = 0 - mhpar(f12,20) 
        if t1 > 99    
          x = 0 + mhpar(f12,20) 
        else   
          if t1 > 9   
            x = 0                                 /* Fixing bug &dA11/05/05&d@ (was x = b)
          end  
        end  
MNU1:   t1 = t1 / 10 
        z = rem + 71   
        if justflag < 2 
          ++mainyp 
          tput [Y,mainyp] K ~x  ~y  ~z 
        end 
        if t1 = 0   
          return   
        end  
        x -= mhpar(f12,19) 
        goto MNU1 
*     return 
