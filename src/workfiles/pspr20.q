
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 20. putwedge (t1,t2)                                        ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose:  Typeset wedge                                    ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Inputs:   x1 = horizontal starting point of wedge          ³ 
&dA &d@³              x2 = horizontal stopping point of wedge          ³ 
&dA &d@³              y1 = vertical starting point                     ³ 
&dA &d@³              y2 = vertical stopping point                     ³ 
&dA &d@³              t1 = starting spread of wedge                    ³ 
&dA &d@³              t2 = stopping spread of wedge                    ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure putwedge (t1,t2) 
        int t1,t2,t3 
        int leng,slope,z1,clen,fullcnt 
        int nex

        getvalue t1,t2 
        y1 -= pvpar(1) 
        y2 -= pvpar(1) 
        leng = x2 - x1   
        x = x1 + sp  

        scx = x 
        scf = 400 
*   compute slope  
        slope = t2 - t1 * 240 / leng 
        slope = abs(slope) 
        if slope < 8 
          slope = 8 
        end  
        if t2 > t1 
          slope = slope + 2 / 4 
        else 
          slope = slope + 3 / 4 
        end  
        if slope > 20 
          slope = 20 
        end  
        z1 = slope 
        if t2 < t1 
          slope = 0 - slope 
        end  
*   compute character  
        if z1 > 12 
          z1 = z1 - 13 / 2 + 13  
        end  
*   compute length of character  
        if z1 < 11 
          clen = 120 / z1 
        else 
          clen = 128 / z1 
        end  
*   compute number of full characters  
        fullcnt = leng / clen 
*   compute extension set  
        nex = 0 
        t3 = rem - 30 
        if t3 > 0 
          ++nex 
          tarr(nex) = 74 
          rem = t3 
        end  
        t3 = rem - 20 
        if t3 > 0 
          ++nex 
          tarr(nex) = 75 
          rem = t3 
        end  
        t3 = rem - 10 
        if t3 > 0 
          ++nex 
          tarr(nex) = 78 
          rem = t3 
        end  
        if rem > 0 
          ++nex 
          tarr(nex) = 88 - rem 
        end  
*   write out wedge . . .  
        if slope > 0                    /* cresc.  
          t3 = t1 / 2 
          y2 += t3 
          y1 -= t3 
          z = z1 + 31  
*   -- top 
          y = y1 + psq(f12)   
          loop for t3 = 1 to fullcnt 
            scy = y 
            scb = z 
            perform charout 
            --y
          repeat 
          loop for t3 = 1 to nex 
            z = tarr(t3) 
            scy = y 
            scb = z 
            perform charout 
          repeat 
*   -- bottom  
          scx = x 
          z = z1 + 51  
          y = y2 + psq(f12)   
          loop for t3 = 1 to fullcnt 
            scy = y 
            scb = z 
            perform charout 
            ++y
          repeat 
          loop for t3 = 1 to nex 
            z = tarr(t3) 
            scy = y 
            scb = z 
            perform charout 
          repeat 
        else                            /* decresc.  
          t3 = t2 / 2 
          y1 = y1 - t3 - fullcnt 
          y2 = y2 + t3 + fullcnt 
*   -- top 
          y = y1 + psq(f12)   
          loop for t3 = 1 to nex 
            z = tarr(t3) 
            scy = y 
            scb = z 
            perform charout 
          repeat 
          z = z1 + 51  
          loop for t3 = 1 to fullcnt 
            scy = y 
            scb = z 
            perform charout 
            ++y
          repeat 
          scx = x 
*   -- bottom  
          y = y2 + psq(f12)   
          loop for t3 = 1 to nex 
            z = tarr(t3) 
            scy = y 
            scb = z 
            perform charout 
          repeat 
          z = z1 + 31  
          loop for t3 = 1 to fullcnt 
            scy = y 
            scb = z 
            perform charout 
            --y 
          repeat 
        end  
        scf = notesize 
      return 
