
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³M*  6. endcheck (endf)                                            ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Purpose:  Check status of end of part flags.                  ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Inputs: f(.,8)                                                ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
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
