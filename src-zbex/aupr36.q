
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 36. place_accidental (t1,t2,t3,t4)                                  ³ 
&dA &d@³                                                                       ³ 
&dA &d@³                                                                       ³ 
&dA &d@³    Purpose:  Determine the absolute x-location of an                  ³ 
&dA &d@³                accidental, given gl(.,.) and the imputs:              ³ 
&dA &d@³                                                                       ³ 
&dA &d@³    Inputs:   t1     = staff number                                    ³ 
&dA &d@³              t2     = position on staff (23 = top line)               ³ 
&dA &d@³              t3     = accidental code                                 ³ 
&dA &d@³              t4     = note size (full size vs. cue size)              ³ 
&dA &d@³                                                                       ³ 
&dA &d@³    Output:   t4     = absolute x location                             ³ 
&dA &d@³                                                                       ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure place_accidental (t1,t2,t3,t4) 
        int t1,t2,t3,t4,t5,t6,t7,t8,t9,savet3,savet4,t14 

        getvalue t1, t2, t3, t4 
        t14 = t4 

        if t2 > 42 or t2 < 3 or t3 = 10    /* use old system 
          t5 = t2 - int("221002200100001"{t3})  /* lower limit 
          t6 = t2 + int("333003300200003"{t3})  /* upper limit 
          t8 = 200 
          loop for t7 = t5 to t6 
            if t7 > 0 and t7 <= 45 
              if gl(t1,t7) < t8 
                t8 = gl(t1,t7) 
              end 
            end 
          repeat 
          t9 = hpar(t3) 
          if t14 = CUESIZE 
            t9 = t9 * 8 / 10    /* cue or grace size 
          end 
          t4 = t8 - t9          /* absolute x position 
          loop for t7 = t5 to t6 
            if t7 > 0 and t7 <= 45 
              gl(t1,t7) = t4   /* new global left boundary 
            end 
          repeat 
          passback t4 
          return 
        end 

&dA &d@ hpar(1)  =  shift following accidental natural 
&dA &d@ hpar(2)  =  shift following accidental sharp 
&dA &d@ hpar(3)  =  shift following accidental flat 
&dA &d@ hpar(6)  =  shift following accidental natural-sharp 
&dA &d@ hpar(7)  =  shift following accidental natural-flat 
&dA &d@ hpar(10) =  shift following accidental double sharp 
&dA &d@ hpar(15) =  shift following accidental double flat 

&dA 
&dA &d@    (1) determine absolute x location 
&dA 
        if chr(t3) in [3,7,15] 
          t5 = hpar(3) * 7 / 10 
          t6 = gl(t1,t2+3) + t5 
          loop for t7 = t2 - 1 to t2 + 2 
            if gl(t1,t7) < t6 
              t6 = gl(t1,t7) 
            end 
          repeat 
          if t3 = 7 and gl(t1,t2-2) + hpar(3) < t6 
            t6 = gl(t1,t2-2) + hpar(3) 
          end 
        else 
          if chr(t3) in [2,6] 
            t5 = hpar(2) * 2 / 10 
            t6 = gl(t1,t2+3) + t5 
            loop for t7 = t2 - 1 to t2 + 2 
              if gl(t1,t7) < t6 
                t6 = gl(t1,t7) 
              end 
            repeat 
            if t6 > gl(t1,t2-2) + t5 
              t6 = gl(t1,t2-2) + t5 
            end 
          else 
            t5 = hpar(3) * 6 / 10 
            t6 = gl(t1,t2+3) + t5 
            loop for t7 = t2 - 2 to t2 + 2 
              if gl(t1,t7) < t6 
                t6 = gl(t1,t7) 
              end 
            repeat 
          end 
        end 
        t5 = hpar(t3) 
        if t14 = CUESIZE 
          t5 = t5 * 8 / 10    /* cue or grace size 
        end 
        t4 = t6 - t5                        /* absolute x position 
        passback t4 
&dA 
&dA &d@    (2) determine new values for gl(.,.) 
&dA 
        if chr(t3) in [1,6,7] 
          loop for t7 = t2 - 1 to t2 + 3 
            gl(t1,t7) = t4                  /* new global left boundary 
          repeat 
          gl(t1,t2-2) = hpar(1) / 2 + t4 
        else 
          if chr(t3) in [3,15] 
            loop for t7 = t2 - 1 to t2 + 3 
              gl(t1,t7) = t4                /* new global left boundary 
            repeat 
          else 
            t5 = hpar(2) / 10 
            gl(t1,t2+3) = t4 + t5 
            loop for t7 = t2 - 1 to t2 + 2 
              gl(t1,t7) = t4                /* new global left boundary 
            repeat 
            gl(t1,t2-2) = t4 + t5 
          end 
        end 
      return 
