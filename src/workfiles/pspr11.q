
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 11. string_length (out, tscf, xtot)                             ³ 
&dA &d@³                                                                   ³ 
&dA &d@³    Purpose:  Determine the length (in dots) of a line of          ³ 
&dA &d@³              text which has no font changes and no "\" character  ³ 
&dA &d@³                                                                   ³ 
&dA &d@³    Inputs:   out   = line whose length is to be determined        ³ 
&dA &d@³              tscf  = font active at time of call                  ³ 
&dA &d@³                                                                   ³ 
&dA &d@³    Output:   xtot                                                 ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure string_length (out, tscf, xtot) 
        str out.500 
        int t1,t2 
        int xinc,xtot,tscf 
        getvalue out, tscf 

        xtot = 0 
        loop for t1 = 1 to len(out) 
          t2 = ors(out{t1}) 
          if tscf = notesize 
            t2 = music_con(t2) 
          end 
          perform get_xinc (tscf, t2, xinc) 
          xtot += xinc 
        repeat 
        passback xtot 
      return 
