
&dA &d@���������������������������������������������������������������Ŀ 
&dA &d@�D* 23. putending (t1,t2,t3)                                    � 
&dA &d@�                                                               � 
&dA &d@�    Purpose:  Typeset ending                                   � 
&dA &d@�                                                               � 
&dA &d@�    Inputs:   x1 = horizontal starting point of ending         � 
&dA &d@�              x2 = horizontal stopping point of ending         � 
&dA &d@�              y1 = vertical level of ending                    � 
&dA &d@�              t1 = length of start hook                        � 
&dA &d@�              t2 = length of ending hook                       � 
&dA &d@�              t3 = ending number, 0 = none                     � 
&dA &d@����������������������������������������������������������������� 
      procedure putending (t1,t2,t3) 
        int a1,a2 
        int t1,t2,t3 

        getvalue t1,t2,t3 
        if f12 > 1 
          if t3 > 9                       /* New condition &dA04/25/09&d@ 
            t3 -= 10 
          else 
            return 
          end 
        end  
        x = x1 + sp  
        y = y1 + psq(f12)   
        scx = x 
        scy = y 
        if t1 > 0  
          if t1 < notesize 
            t1 = notesize 
          end 
          loop while t1 > notesize 
            scb = 89 
            perform charout 
            scy += notesize 
            t1 -= notesize 
          repeat 
          a2 = notesize - t1 
          scy -= a2 
          scb = 89 
          perform charout 
        end  
        if t3 > 0  
          scx = x + pvpar(1) 
          scy = y + pvpar(4) 
          scf = mtfont 
          out = chs(t3) 
          perform stringout (out) 
          scb = 46 
          perform charout 
          scf = notesize 
        end  
        scx = x 
        scy = y 
        a1 = x2 - phpar(1) 
        scb = 90 
        loop while x1 <= a1 
          perform charout 
          x1 += phpar(1) 
        repeat 
        x = a1 + sp 
        scx = x 
        perform charout 
        if t2 > 0  
          if t2 < notesize 
            t2 = notesize 
          end 
          loop while t2 > notesize 
            scb = 89 
            perform charout 
            scy += notesize 
            t2 -= notesize 
          repeat 
          a2 = notesize - t2 
          scy -= a2 
          scb = 89 
          perform charout 
        end  
      return 
