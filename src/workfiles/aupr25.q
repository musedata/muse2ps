
&dA &d@�����������������������������������������������������������������Ŀ 
&dA &d@�P* 25. newnsp                                                    � 
&dA &d@�                                                                 � 
&dA &d@�    Purpose:  Calculate new nsp array                            � 
&dA &d@�                                                                 � 
&dA &d@�    Inputs:    scnt     = next logical record in input table     � 
&dA &d@�               divspq   = number of divisions per quarter note   � 
&dA &d@�               xmindist = minimum distance between notes (x100)  � 
&dA &d@�               mindist  = minimum distance between notes         � 
&dA &d@�                                                                 � 
&dA &d@�    Outputs:   new nsp array for this section                    � 
&dA &d@�                                                                 � 
&dA &d@�    Internal variables:  t1,t2,t3,t4,t5,t6                       � 
&dA &d@�                         mtot                                    � 
&dA &d@�                                                                 � 
&dA &d@�    Strategy:  (1) read through file until the next time         � 
&dA &d@�                      signature change or until the end          � 
&dA &d@�               (2) count number of measures where shortest       � 
&dA &d@�                      duration occurs                            � 
&dA &d@�               (3) if this represents more than xx% of the       � 
&dA &d@�                      outstanding measures, then this is         � 
&dA &d@�                      the shortest note                          � 
&dA &d@�               (4) otherwise, the shortest note is the           � 
&dA &d@�                      next one up; i.e.                          � 
&dA &d@�                         triplets --> regular                    � 
&dA &d@�                          regular --> double regular             � 
&dA &d@�                                                                 � 
&dA &d@�       nsp(35) will be space for longa                           � 
&dA &d@�       nsp(32) will be space for longa                           � 
&dA &d@�       nsp(29) will be space for breve                           � 
&dA &d@�       nsp(26) will be space for whole                           � 
&dA &d@�       ...                                                       � 
&dA &d@�       nsp(5)  will be space for 128th note                      � 
&dA &d@�       nsp(2)  will be space for 256th note                      � 
&dA &d@������������������������������������������������������������������� 
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
