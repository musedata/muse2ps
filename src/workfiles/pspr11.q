
&dA &d@�������������������������������������������������������������������Ŀ 
&dA &d@�D* 11. string_length (out, tscf, xtot)                             � 
&dA &d@�                                                                   � 
&dA &d@�    Purpose:  Determine the length (in dots) of a line of          � 
&dA &d@�              text which has no font changes and no "\" character  � 
&dA &d@�                                                                   � 
&dA &d@�    Inputs:   out   = line whose length is to be determined        � 
&dA &d@�              tscf  = font active at time of call                  � 
&dA &d@�                                                                   � 
&dA &d@�    Output:   xtot                                                 � 
&dA &d@��������������������������������������������������������������������� 
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
