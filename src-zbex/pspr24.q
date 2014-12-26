
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 24. putdashes (t1,t2)                                       ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose:  Typeset dashes                                   ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Inputs:   x1 = horizontal starting point of dashes         ³ 
&dA &d@³              x2 = horizontal stopping point of dashes         ³ 
&dA &d@³              y1 = vertical level of dashes                    ³ 
&dA &d@³              t1 = spacing parameter                           ³ 
&dA &d@³              t2 = font designator                             ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure putdashes (t1,t2) 
        int t1,t2 
        int a1,a2,a3,a4,a5 

        getvalue t1,t2 
        a2 = x2 - x1 
        if a2 < 0 
          return 
        end 
        x = x1 + sp + hyphspc(sizenum) 
        y = y1 + psq(f12)   

        scf = t2 
        scx = x 
        scy = y 
        scb = 173 
        perform charout 
        if t1 = 0  
          a1 = hyphspc(sizenum) * 5 
          a3 = a2 / a1 
          if a3 = 0 
            t1 = x2 - x1 
            a3 = 2 
          else 
            if rem > hyphspc(sizenum) * 2 
              ++a3 
            end 
            t1 = a2 / a3              
          end 
          a4 = 1 
        else 
          a1 = t1              
          a3 = a2 / a1 
          a4 = 0 
        end  

        loop for a5 = 1 to a3 - 1 
          x += t1 
          scx = x 
          perform charout 
          if a4 = 1 
            a2 -= t1 
            --a3 
            if a3 > 0 
              t1 = a2 / a3 
            end 
          end 
        repeat 
        scf = notesize 
      return 
