
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 25. newnsp                                                    ³ 
&dA &d@³                                                                 ³ 
&dA &d@³    Purpose:  Calculate new nsp array                            ³ 
&dA &d@³                                                                 ³ 
&dA &d@³    Inputs:    scnt     = next logical record in input table     ³ 
&dA &d@³               divspq   = number of divisions per quarter note   ³ 
&dA &d@³               xmindist = minimum distance between notes (x100)  ³ 
&dA &d@³               mindist  = minimum distance between notes         ³ 
&dA &d@³                                                                 ³ 
&dA &d@³    Outputs:   new nsp array for this section                    ³ 
&dA &d@³                                                                 ³ 
&dA &d@³    Internal variables:  t1,t2,t3,t4,t5,t6                       ³ 
&dA &d@³                         mtot                                    ³ 
&dA &d@³                                                                 ³ 
&dA &d@³    Strategy:  (1) read through file until the next time         ³ 
&dA &d@³                      signature change or until the end          ³ 
&dA &d@³               (2) count number of measures where shortest       ³ 
&dA &d@³                      duration occurs                            ³ 
&dA &d@³               (3) if this represents more than xx% of the       ³ 
&dA &d@³                      outstanding measures, then this is         ³ 
&dA &d@³                      the shortest note                          ³ 
&dA &d@³               (4) otherwise, the shortest note is the           ³ 
&dA &d@³                      next one up; i.e.                          ³ 
&dA &d@³                         triplets --> regular                    ³ 
&dA &d@³                          regular --> double regular             ³ 
&dA &d@³                                                                 ³ 
&dA &d@³       nsp(35) will be space for longa                           ³ 
&dA &d@³       nsp(32) will be space for longa                           ³ 
&dA &d@³       nsp(29) will be space for breve                           ³ 
&dA &d@³       nsp(26) will be space for whole                           ³ 
&dA &d@³       ...                                                       ³ 
&dA &d@³       nsp(5)  will be space for 128th note                      ³ 
&dA &d@³       nsp(2)  will be space for 256th note                      ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure newnsp 
        int t1,t2,t3,t4,t5,t6,t7 
        int mtot
        str line.120 

        t6  = scnt                 /* temporary counter in input 
        loop for t1 = 1 to 36 
          nsp(t1) = xmindist       /* New &dA12/16/03&d@ 
        repeat 
        if minshort <> 0 
          t1 = minshort * 4 
          rem = 0                  /* sloppy code 
          goto NOCALC 
        end 

        t2 = 100   
        mtot = 0 
        t7 = 0                     /* "durations found" flag (initialize at 0) 
        loop 
          t1 = 0   
          tget [X,t6] line .t6 t1 
          ++t6                     /* increment temporary counter 
          line = line // pad(4)  
          if line{1,4} = "/END" or line{1,4} = "/FIN" 
            goto NW1 
          end  
          if line{1} = "$" and line con "T:" and t7 = 1 
            goto NW1 
          end 
          if t6 > 9990 
            tmess = 38 
            perform dtalk (tmess) 
          end 
          if line{1,3} = "mea" 
            ++mtot
            t4 = 0   
          end  
*
          if line{1} in ['A'..'G','r'] and t1 > 0  /* positive dur
            t7 = 1 
            if t1 < t2 
              t2 = t1                   /* new shortest note
              t3 = 0   
              t4 = 0   
            end  
            if t1 = t2 and t4 = 0
              t4 = 1   
              ++t3                      /* inc number of measures 
            end  
          end    
        repeat 
&dA 
&dA &d@  t2 = shortest note value  
&dA &d@  t3 = number of measures where this note occurs    
&dA 
NW1:
        if t7 = 0           /* No durations found (unusual case) 
          mtot = 1 
          t2 = 1 
          t3 = 1 
        end 

        t5 = divspq * 16 / t2  
        if t5 > 96   
          t4 = 0            /* case 1: always double shortest note
        else 
          if t5 > 48   
            t4 = 5          /* case 2: double if less than 16%
          else 
            if t5 > 24 
              t4 = 8        /* case 3: double if less than 11%
            else 
              t4 = 10       /* case 4: double if less than 9%
            end  
          end  
        end  
*  
        t1 = mtot / t3 
        if t1 > t4   
          t1 = divspq / 3  
          if rem = 0 
            t1 = t2 / 2  
            if rem = 0 
              t2 = t1 * 3  
            else 
              t2 *= 2 
            end  
          else 
            t2 *= 2 
          end  
        end  
*  
        t1 = divspq * 16 / t2  
&dA &d@  if t1 = 1, shortest note is longa   
&dA &d@  if t1 = 2, shortest note is breve   
&dA &d@  if t1 = 4, shortest note is whole   
&dA &d@  if t1 = 8, shortest note is half, etc   
        t2 = t1 / 3  
        if rem = 0 
          t1 = t2 * 2  
        end  
 
NOCALC: 
        t5 = 32          /* 32 = code for longa 
        t4 = 160   
*
        t1 >>= 1 
        loop while t1 > 0           /* i.e., if t1 started as 16th (t1 = 64), loop 6 times
          t5 -= 3 
          t4 -= 20 
          t1 >>= 1 
        repeat
*
        if rem = 0                             /* sloppy code.  See up 100 lines for expl.
          nsp(t5) = xmindist * 10 / 9        /* New &dA12/16/03&d@ 
        end  
        if t4 > 100  
          nsp(t5) = nsp(t5) * t4 / 100   
        end  
        nsp(t5+1) = nsp(t5) * 12 / 10  
        t1 = 13  
*
        loop while t5 < 34 
          t4 = t5 + 3  
          nsp(t4) = nsp(t5) * t1 / 10    
          ++t1 
          t5 = t4  
          nsp(t5-1) = nsp(t5) * 9 / 10 
          nsp(t5+1) = 2 * nsp(t5) - nsp(t5-3)
        repeat   
&dA 
&dA &d@    Now reduce all nsp(.) numbers by factor of 100  (&dA12/16/03&d@) 
&dA 
        loop for t1 = 1 to 36 
          nsp(t1) = nsp(t1) + 50 / 100 
        repeat 
&dA   
      return 
