
&dA &d@旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커 
&dA &d@쿘*  6. endcheck (endf)                                            � 
&dA &d@�                                                                  � 
&dA &d@�    Purpose:  Check status of end of part flags.                  � 
&dA &d@�                                                                  � 
&dA &d@�    Inputs: f(.,8)                                                � 
&dA &d@읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 
      procedure endcheck (endf) 
        int endf,t1 

        endf = f(1,8) 
        loop for f12 = 2 to f11  
          if f(f12,8) <> endf   
            tmess = 63 
            perform dtalk (tmess) 
          end  
        repeat 
        passback endf 
      return 
