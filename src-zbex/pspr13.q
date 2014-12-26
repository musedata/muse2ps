
&dA &d@���������������������������������������������������������������Ŀ 
&dA &d@�D* 13. staff (syslength,stv_type)                              � 
&dA &d@�                                                               � 
&dA &d@�    Purpose:  Typeset staff                                    � 
&dA &d@�                                                               � 
&dA &d@�    Inputs:  y          = absolute vertical location           � 
&dA &d@�             sp         = starting point of staff lines        � 
&dA &d@�             syslength  = length of staff lines                � 
&dA &d@�             stv_type   = type of staff   0 = 5-line           � 
&dA &d@�                                          1 = single line      � 
&dA &d@����������������������������������������������������������������� 
      procedure staff (syslength,stv_type) 
        int slen,syslength,stv_type 
        int d2 
        getvalue syslength,stv_type 

        if notesize >= 10 
          slen = 64 
        else 
          slen = 32 
        end 
&dA 
&dA &d@     New &dA11/11/05&d@:  Single line stave 
&dA 
        if stv_type = 1 
          y += pvpar(4) 
          d2 = sp + syslength - phpar(1) 
          z = 90 
          loop for x = sp to d2 step phpar(1) 
            perform setmus 
          repeat 
          x = d2 
          perform setmus 
          y -= pvpar(4) 
          return 
        end 
&dA 
&dA       &d@   End of &dA11/11/05&d@ addition 

        if notesize >= 18           /* Added &dA11/18/03&d@ to fill holes in lines &dIOK
          d2 = sp + syslength - slen 
          z = 81 
          loop for x = sp to d2 step slen - 1 
            perform setmus 
            ++x 
          repeat 
          x = d2 
          perform setmus 
        else 
          d2 = sp + syslength - slen 
          z = 81 
          loop for x = sp to d2 step slen 
            perform setmus 
          repeat 
          x = d2 
          perform setmus 
        end 
      return 
