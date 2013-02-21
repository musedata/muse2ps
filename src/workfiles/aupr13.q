
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 13. number (na,dva)                              ³ 
&dA &d@³                                                    ³ 
&dA &d@³    Purpose:  Create subobject for number           ³ 
&dA &d@³                                                    ³ 
&dA &d@³    Inputs:  na = number                            ³ 
&dA &d@³             dva = center position for number       ³ 
&dA &d@³                                                    ³ 
&dA &d@³    Outputs: dva = right boundary of number         ³ 
&dA &d@³                                                    ³ 
&dA &d@³             x,z sent to subj                       ³ 
&dA &d@³                                                    ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure number (na,dva) 
        int na,dva 

        getvalue na,dva 
        x = dva - hpar(21) 
        if na > 99    
          x = dva + hpar(21) 
        else   
          if na > 9   
            x = dva    
          end  
        end  
        dva = x + hpar(20) 
NU1:    na /= 10 
        z = rem + 71                      /* music font
        perform subj 
        if na = 0   
          passback dva 
          return   
        end  
        x -= hpar(20) 
        goto NU1   
      return 
