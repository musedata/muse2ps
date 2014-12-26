
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D*  9. line_length (xtot)                                      ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose:  Determine the length (in dots) of a line of      ³ 
&dA &d@³              text before it is typeset.                       ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Inputs:   line = line whose length is to be determined     ³ 
&dA &d@³              z    = font active at time of call               ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure line_length (xtot) 
        str textline.400 
        str ngline2.400 
        int xtot,xinc 
        int tscf 
        int t1,t2,t3 

        xtot = 0 

        if z = 1
          tscf = notesize 
        else 
          tscf = z 
        end 
        textline = line // "   " 
LLL1: 
        if textline con "!" 
          t1 = mpt 
          if t1 > 1 
            ngline2 = textline{1,t1-1} 
            perform lineout_length (ngline2, tscf, xinc) 
            xtot += xinc 
            textline = textline{t1..} 
            goto LLL1 
          end 
          if "0123456789" con textline{2} 
            t1 = int(textline{2..}) 
            t2 = sub 
            if textline{t2} = "|" 
              ++t2 
            end 

            if t1 = 1 
              tscf = notesize 
            else 
              tscf = t1 
            end 

            textline = textline{t2..} 
            goto LLL1 
          end 
          t3 = 33                     /* ! character 
          perform get_xinc (tscf, t3, xinc) 
          xtot += xinc 
          textline = textline{2..} 
          goto LLL1 
        end 
        ngline2 = trm(textline) 
        if ngline2 <> "" 
          perform lineout_length (ngline2, tscf, xinc) 
          xtot += xinc 
        end 
        passback xtot 
      return 
