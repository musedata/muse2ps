
&dA &d@���������������������������������������������������������������Ŀ 
&dA &d@�D* 25. puttrill (t1)                                           � 
&dA &d@�                                                               � 
&dA &d@�    Purpose:  Typeset long trill                               � 
&dA &d@�                                                               � 
&dA &d@�    Inputs:   x1 = horizontal starting point of trill          � 
&dA &d@�              x2 = horizontal stopping point of trill          � 
&dA &d@�              y1 = vertical level of trill                     � 
&dA &d@�              t1 = situation  1 = no trill                     � 
&dA &d@�                              2 = trill with no accidental     � 
&dA &d@�                              3 = trill with sharp             � 
&dA &d@�                              4 = trill with natural           � 
&dA &d@�                              5 = trill with flat              � 
&dA &d@�                              6 = trill with sharp following   � 
&dA &d@�                              7 = trill with natural following � 
&dA &d@�                              8 = trill with flat following    � 
&dA &d@����������������������������������������������������������������� 
      procedure puttrill (t1) 
        int hh,k1                                      /* k1 is new &dA11/05/05
        int t1 

        getvalue t1 
        x = x1 + sp  
        y = y1 + psq(f12)   
        k1 = x1                 /* localize x1            /* New &dA11/05/05&d@ 
        hh  = k1                                          /* New &dA11/05/05&d@ 
        scx = x 
        scy = y 
        if t1 > 1 
          if t1 > 2 and t1 < 6 
            scb = int("..389"{t1}) + 210     /* music font 
            scy = y - pvpar(45) 
            perform charout 
            scy = y 
          end 
          x += phpar(41) 
          scb = 236 
          perform charout 
          scx = x 
&dA 
&dA &d@      New code added to implement accidentals following a trill sign  &dA11/05/05
&dA 
          if t1 > 5 and t1 < 9 
            x -= pvpar(1) 

            k1 += pvpar(2) 
            scx = x         
            scy = y - pvpar(2) 
            scb = t1 + 185                   /* music font (cue size) 
            perform charout 
            x += pvpar(3)                      
            scx = x 
            scy = y 
          end 
&dA 
&dA        &d@    End of &dA11/05/05&d@ New Code 

          hh = k1 + phpar(41)                              /* k1 replaces x1  &dA11/05/05
        end  
        scb = 237 
        loop while hh < x2 
          perform charout 
          hh += phpar(40) 
        repeat 
      return 
