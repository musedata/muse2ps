
&dA &d@������������������������������������������������������������������Ŀ 
&dA &d@�M* 10. msk_number (t1)                                            � 
&dA &d@�                                                                  � 
&dA &d@�    Purpose:  Typeset a number                                    � 
&dA &d@�                                                                  � 
&dA &d@�    Inputs:  t1 = number                                          � 
&dA &d@�             y = vertical location of number                      � 
&dA &d@�                                                                  � 
&dA &d@�������������������������������������������������������������������� 
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
