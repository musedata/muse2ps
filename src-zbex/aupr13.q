
&dA &d@����������������������������������������������������Ŀ 
&dA &d@�P* 13. number (na,dva)                              � 
&dA &d@�                                                    � 
&dA &d@�    Purpose:  Create subobject for number           � 
&dA &d@�                                                    � 
&dA &d@�    Inputs:  na = number                            � 
&dA &d@�             dva = center position for number       � 
&dA &d@�                                                    � 
&dA &d@�    Outputs: dva = right boundary of number         � 
&dA &d@�                                                    � 
&dA &d@�             x,z sent to subj                       � 
&dA &d@�                                                    � 
&dA &d@������������������������������������������������������ 
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
