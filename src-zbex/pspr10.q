
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 10. lineout_length (thline2, tscf, xtot)                    ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose:  Determine the length (in dots) of a line of      ³ 
&dA &d@³              text which has no font changes in it             ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Inputs:   thline2 = line whose length is to be determined  ³ 
&dA &d@³              tscf    = font active at time of call            ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Output:   xtot                                             ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure lineout_length (thline2, tscf, xtot) 
        str thline2.400,out.400 
        int tscf, xtot 
        int xinc 
        int t1,t2,t3 

        getvalue thline2, tscf 

        xtot = 0 
        thline2 = thline2 // "   " 
LLL2: 
        if thline2 con "\" 
          if mpt > 1 
            t1 = mpt 
            out = thline2{1,t1-1} 
            perform string_length (out, tscf, xinc) 
            xtot += xinc 
            thline2 = thline2{t1..} 
            goto LLL2 
          end 
          if thline2{2} = "\" 
            t3 = 92                     /* \ character 
            perform get_xinc (tscf, t3, xinc) 
            xtot += xinc 
            thline2 = thline2{3..} 
            goto LLL2 
          end 
          if "!@#$%^&*(-=" con thline2{2} 
            t1 = mpt 
            if t1 < 10 
              xtot += t1 
            else 
              xtot -= (t1 - 9) 
            end 
            thline2 = thline2{3..} 
            goto LLL2 
          end 
          if thline2{2} = "0" 
            t3 = ors(thline2{3}) + 128 
            if chr(t3) in [160,206,212,224] 
            else 
              perform get_xinc (tscf, t3, xinc) 
              xtot += xinc 
            end 
            thline2 = thline2{4..} 
            goto LLL2 
          end 
          if thline2{2} in ['a'..'z','A'..'Z'] 
            t3 = ors(thline2{2}) 
            if thline2{2,2} = "s2" 
              t3 = 244                                        /* German ss 
              perform get_xinc (tscf, t3, xinc) 
              xtot += xinc 
              thline2 = thline2{4..} 
              goto LLL2 
            else 
              if "12345789" con thline2{3} 
                if ("73" con thline2{3} and "Yy" con thline2{2}) or "AEIOUaeiou" con thline2{2}
                  perform get_xinc (tscf, t3, xinc) 
                  xtot += xinc 
                  thline2 = thline2{4..} 
                  goto LLL2 
                end 
              end 
            end 
          end 
          t3 = 92                     /* \ character 
          perform get_xinc (tscf, t3, xinc) 
          xtot += xinc 
          thline2 = thline2{2..} 
          goto LLL2 
        end 
        out = trm(thline2) 
        if out <> "" 
          perform string_length (out, tscf, xinc) 
          xtot += xinc 
        end 
        passback xtot 
      return 
