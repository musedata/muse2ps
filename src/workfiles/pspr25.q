
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 25. puttrill (t1)                                           ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose:  Typeset long trill                               ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Inputs:   x1 = horizontal starting point of trill          ³ 
&dA &d@³              x2 = horizontal stopping point of trill          ³ 
&dA &d@³              y1 = vertical level of trill                     ³ 
&dA &d@³              t1 = situation  1 = no trill                     ³ 
&dA &d@³                              2 = trill with no accidental     ³ 
&dA &d@³                              3 = trill with sharp             ³ 
&dA &d@³                              4 = trill with natural           ³ 
&dA &d@³                              5 = trill with flat              ³ 
&dA &d@³                              6 = trill with sharp following   ³ 
&dA &d@³                              7 = trill with natural following ³ 
&dA &d@³                              8 = trill with flat following    ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
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
