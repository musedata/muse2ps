
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 21. putfigcon (t3)                                                   ³ 
&dA &d@³                                                                        ³ 
&dA &d@³    Purpose:  Typeset figure continuation line                          ³ 
&dA &d@³                                                                        ³ 
&dA &d@³    Inputs:   x1 = horizontal starting point of line                    ³ 
&dA &d@³              x2 = horizontal stopping point of line                    ³ 
&dA &d@³              t3 = vertical level of line                               ³ 
&dA &d@³              y1 = additional vertical displacement from default height ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure putfigcon (t3) 
        int t1,t3 

        getvalue t3 
        x = x1 + sp  
        --t3 
&dA 
&dA &d@    New code &dA11/06/03&d@ adding figoff(.) and y1 
&dA 
        y = pvpar(37) * t3 + pvpar(36) + psq(f12) + figoff(f12) + y1 
        scx = x 
        scy = y 
        t1 = x2 - phpar(44) 
        scb = 220 
        loop while x1 <= t1 
          perform charout 
          x1 += phpar(44) 
        repeat 
        x = t1 + sp 
        scx = x 
        perform charout 
      return 
