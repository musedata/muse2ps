
&dA &d@������������������������������������������������������������������������Ŀ 
&dA &d@�D* 21. putfigcon (t3)                                                   � 
&dA &d@�                                                                        � 
&dA &d@�    Purpose:  Typeset figure continuation line                          � 
&dA &d@�                                                                        � 
&dA &d@�    Inputs:   x1 = horizontal starting point of line                    � 
&dA &d@�              x2 = horizontal stopping point of line                    � 
&dA &d@�              t3 = vertical level of line                               � 
&dA &d@�              y1 = additional vertical displacement from default height � 
&dA &d@�������������������������������������������������������������������������� 
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
