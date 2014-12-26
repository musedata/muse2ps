
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 35. rest_occupy_space (t1,t2)                              ³ 
&dA &d@³                                                              ³ 
&dA &d@³                                                              ³ 
&dA &d@³    Purpose:  For a given location on the staff line and      ³ 
&dA &d@³                a given type of rest, set the gr(.,.) and     ³ 
&dA &d@³                gl(.,.) arrays to reflect the placement       ³ 
&dA &d@³                of the rest in this spot                      ³ 
&dA &d@³                                                              ³ 
&dA &d@³    Inputs:   ntype  = type of rest                           ³ 
&dA &d@³              t1     = position on staff (0 = top line)       ³ 
&dA &d@³                         (i.e.,STAFFLOC)                      ³ 
&dA &d@³              t2     = staff number                           ³ 
&dA &d@³                                                              ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure rest_occupy_space (t1,t2) 
        int t1,t2,t3,t4,t5,t6,t7,t8 

        getvalue t1,t2 
        c16 = t1 + vpar20 * 2 + 1 / vpar(2) - 20 
        t1 = 23 - c16 

        t5 = ntype << 1 - 1 

        t3 = int("1008060402020402030303"{t5,2}) 
        t4 = int("0505050505030301000101"{t5,2}) 

        if ntype > WHOLE 
          t6 = hpar(87) * 4 / 3 
        else 
          if ntype > QUARTER 
            t6 = hpar(87) 
          else 
            if ntype > EIGHTH 
              t6 = hpar(88) 
            else 
              t6 = EIGHTH - ntype * hpar(54) + hpar(88) 
            end 
          end 
        end 
&dA &d@       t6 += hpar(85) 

        t7 = t1 - t4 
        if t7 < 1 
          t7 = 1 
        end 
        t8 = t1 + t3 
        if t8 > 45 
          t8 = 45 
        end 
        loop for t5 = t7 to t8
          gr(t2,t5) = t6 
          gl(t2,t5) = 0 
        repeat 
      return 
