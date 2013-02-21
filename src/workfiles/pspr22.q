
&dA &d@���������������������������������������������������������������Ŀ 
&dA &d@�D* 22. puttrans (t1,t2)                                        � 
&dA &d@�                                                               � 
&dA &d@�    Purpose:  Typeset octave transposition                     � 
&dA &d@�                                                               � 
&dA &d@�    Inputs:   x1 = horizontal starting point of transposition  � 
&dA &d@�              x2 = horizontal stopping point of transposition  � 
&dA &d@�              y1 = vertical level of transposition             � 
&dA &d@�              t1 = length of ending hook                       � 
&dA &d@�              t2 = situation, 0 = 8av up, 1 = 8av down         � 
&dA &d@����������������������������������������������������������������� 
      procedure puttrans (t1,t2) 
        int a1,a2,a3 
        int t1,t2 

        getvalue t1,t2 
        x = x1 + sp  
        y = y1 + psq(f12)   
        scx = x 
        scy = y 
        scb = 233 
        perform charout 
        x += phpar(42) 
        scx = x 
        x1 += phpar(42) 
        a2 = x2 - (phpar(43) >> 1) 
        a3 = 0 
        scb = 91 
        loop while x1 <= a2 
          a3 = 1 
          perform charout 
          x1 += phpar(43) 
        repeat 
        a1 = phpar(43) >> 1 
        x1 -= a1 
        if a3 = 1 
          if x1 <= a2 
            scx -= a1 
            perform charout 
          end  
          if t1 > 0  
            a2 = phpar(43) >> 2      
            scx -= a2 
            if t1 < notesize 
              t1 = notesize 
            end 
            if t2 = 1 
              a3 = t1 - 2 
              scy -= a3 
            end  
            loop while t1 > notesize 
              scb = 89 
              perform charout 
              scy += notesize 
              t1 -= notesize 
            repeat 
            a3 = notesize - t1 
            scy -= a3 
            scb = 89 
            perform charout 
          end  
        end  
      return 
