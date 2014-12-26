
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³M*  5. getsmall (t1,t2,t3,df)                                     ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Purpose:  Identify and count the smallest duration in line    ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Inputs:   a1 = number of nodes in larr to look at             ³ 
&dA &d@³              a2 = purpose flag (0 = condensation, 1 = expansion) ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Outputs: t2 =  code for smallest note/rest on line (not       ³ 
&dA &d@³                      including syncopated nodes)                 ³ 
&dA &d@³             t1 =  smallest internote distance (not including     ³ 
&dA &d@³                      syncopated distances)                       ³ 
&dA &d@³             t3 =  difference between e and next smallest         ³ 
&dA &d@³                     distance                                     ³ 
&dA &d@³             df =  proper duration flag for shortest note         ³ 
&dA &d@³              scnt = number of nodes preceded by distance e       ³ 
&dA &d@³              small(.) = node numbers of duration df, where       ³ 
&dA &d@³                            distance adjustment can take place    ³ 
&dA &d@³                                                                  ³ 
&dA &d@³              scnt2 = number of nodes for which adj_space = YES   ³ 
&dA &d@³              small2(.) = node numbers of duration df, where      ³ 
&dA &d@³                             distance adjustment can take place   ³ 
&dA &d@³                             and adj_space = YES                  ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Internal variables:  t4,t5,t6,t7,t8,t9,t10                    ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure getsmall (t1,t2,t3,df) 
        int df2,first,df 
        int t1,t2,t3,t4,t5,t6,t7,t8,t9,t10 

        t2 = 11 
        t1 = 1000 
        df2 = 100000 
        scnt = 0 
        scnt2 = 0                                      /* New &dA05/25/03&d@ 
        t3 = 0                                         /* New &dA10/14/07&d@ 

        loop for t10 = 2 to a1 
          t6 = larr(t10,TIME_NUM)                      /* New &dA05/25/03&d@ 
          if t6 > 0 
            if larr(t10,MNODE_TYPE) <> 18 or t1 = 1000 /* New &dA05/25/03&d@ 
              t7 = larr(t10-1,MNODE_TYPE)              /*  "     " 
              if t7 > 0 
&dA 
&dA &d@  Case: node is preceded by variable distance (t6 > 0); node is not a bar 
&dA &d@        line (larr(t10,MNODE_TYPE) <> 18); previous node type is t7; we     New &dA05/25/03
&dA &d@        are not including syncopated nodes in our preliminary search 
&dA &d@        for the smallest node type on the line.  
&dA 
                if t7 <= t2 
                  if t7 < t2 
                    t8 = 0 
                  end 
                  t2 = t7 
&dA 
&dA &d@   df2 = 64, t8 = 0 --> previous duration is quarter note, etc.  
&dA &d@   df2 = 64, t8 = 1 --> previous duration is a quarter note triplet, etc.  
&dA 
                  df = t6 / 9 
                  if rem = 0 
                    if df < df2 
                      df2 = df 
                    end 
                  else 
                    df = t6 / 6 
                    if rem = 0 
                      t8 = 1 
                      if df < df2 
                        df2 = df 
                      end 
                    end 
                  end 
&dA 
&dA &d@     We need to change the code here (&dA01/24/04&d@) to deal with the situation 
&dA &d@     that occurs in Baroque music, where (for example) the quarter/eighth 
&dA &d@     combination in triplet is represented by a dotted eighth and sixteenth.
&dA &d@     The problem is that in this situation, the MNODE_TYPE type "under-represents"
&dA &d@     what is really there.  In this example, the dotted eighth (MNODE_TYPE = 6)
&dA &d@     is really a triplet quarter (MNODE_TYPE = 7); and the sixteenth (MNODE_TYPE = 5)
&dA &d@     is really a triplet eighth (MNODE_TYPE = 6).  Because of this, the code
&dA &d@     above thinks these intervals are syncopations.  The trick here will be
&dA &d@     to write some code that will capture this situation, without letting 
&dA &d@     through the syncopated case.  By increasing the value of MNODE_TYPE by
&dA &d@     one, we are increasing the value of t7 by one, which means we are 
&dA &d@     looking at the next larger bit of df2.  The value of df2 is valid; 
&dA &d@     we don't propose to change that.  We need to consider the effect of 
&dA &d@     looking at the next larger bit.  Let us suppose that df2 has the 
&dA &d@     following value: xxy&dE0&d@xx..., where the &dE0&d@ corresponds to the bit read 
&dA &d@     above.  If the value of y is 0, then either this node is very short 
&dA &d@     relative to the note-type represented and is definitely syncopated, 
&dA &d@     or the node is at least four times longer than the note-type 
&dA &d@     represented, which is a logical error.  If the value of y is 1, the 
&dA &d@     node is at least twice as long as the note-type represented, which 
&dA &d@     is also a logical error.  
&dA 
&dA &d@     Based on this analysis, I think the fix is actually very simple.  
&dA &d@     The basic rule is that the node type should NEVER exceed the value 
&dA &d@     of the note-type represented.  If the note-type represented is 
&dA &d@     too small, as happens in the triplet case, the above code fails 
&dA &d@     for the wrong reason.  What we really should be asking is: 
&dA 
&dA &d@                 if df2 >= (0x01 << (t7-1))   /* i.e. not including syncopations
&dA 
&dA &d@     The "=" part of this statement encompasses the normal situation; i.e.,
&dA &d@     the node type is identical to the note-type represented.  The "less than"
&dA &d@     condition is where this statement fails, and this is the syncopated case.
&dA &d@     The "greater than" condition is logically impossible, but now accepts 
&dA &d@     the case where the size of the note-type was under-represented, as 
&dA &d@     happens in the triplet case.  
&dA 
                  if df2 >= (0x01 << (t7-1))   /* i.e. not including syncopations
                    t4 = larr(t10,PRE_DIST)            /* New &dA05/25/03&d@ 
                    if t4 < t1 
                      t3 = t1 - t4             /* New &dA10/14/07&d@ 
                      t1 = t4 
                    end 
                    if t1 + t3 > t4 
                      t3 = t4 - t1             /* New &dA10/14/07&d@ 
                    end 
                  end 
&dA   
                end 
              end 
            end 
          end 
        repeat 
        if df2 = 100000                 /* no valid "smallest" notes 
          passback t1,t2,t3,df 
          return 
        end 
        df = df2    
        if t8 = 0 
          df *= 9
        else 
          df *= 6 
        end 
&dA 
&dA &d@    t2 =  code for smallest note/rest on line 
&dA &d@    t1 =  smallest internote distance 
&dA &d@    df =  proper duration flag for shortest note in search set 
&dA 
&dA &d@   Determine quantity and location of smallest distances 
&dA 
        first = 0 
GSM2: 
        t5 = 0 
        t7 = 0 
        t9 = 0 
        t8 = t1 + hxpar(14)             /* fudge factor for "shortest distance" 
        loop for t10 = 2 to a1 
          if larr(t10,TIME_NUM) > 0                    /* New &dA05/25/03&d@ 
            t5 += larr(t10,TIME_NUM)                   /*  "     " 
            if larr(t10,MNODE_TYPE) = 18               /*  "     " 
              if a2 = 0 
                t7 = t5 / df 
                goto GSM1 
              end 
              if first = 0 
                t7 = t5 / df 
                goto GSM1 
              end 
            end 

            t6 = t5 / df 
            if rem = 0 
&dA 
&dA &d@  Case: node is preceded by variable distance (larr(t10,TIME_NUM) > 0);    (&dA05/25/03&d@)
&dA &d@        node is not a bar line (larr(t10,MNODE_TYPE) <> 18);                       
&dA &d@        node aligns with a multiple of the minimum duration; 
&dA &d@        t6 = cumulative number of minimum durations to this node; 
&dA &d@        t7 = previous cumulative number of minimum durations.  
&dA 
              t4 = t6 - t7 
              if t4 = 1 
                t9 += larr(t10,PRE_DIST)               /* New &dA05/25/03&d@ 
&dA 
&dA &d@   Condensation:  t9 (effective distance) must be within hxpar(14) of  t1 
&dA 
                if a2 = 0 
                  if t9 < t8 
                    ++scnt 
                    small(scnt) = t10 

                    if larr(t10,M_ADJ) = YES          /* New Code &dA05/25/03&d@ 
                      ++scnt2 
                      small2(scnt2) = t10 
                    end 

                  end 
                else 
                  ++scnt 
                  small(scnt) = t10 

                  if larr(t10,M_ADJ) = YES            /* New Code &dA05/25/03&d@ 
                    ++scnt2 
                    small2(scnt2) = t10 
                  end 

                end 
              end 
              t7 = t6 
              t9 = 0 
            else 
              t9 = larr(t10,PRE_DIST)                 /* New &dA05/25/03&d@ 
            end 
          end 
GSM1: 
        repeat 
        if scnt <= 4 and first = 0 
          first = 1 
          scnt = 0 
          scnt2 = 0                                   /* New &dA05/25/03&d@ 
          goto GSM2 
        end 
        passback t1,t2,t3,df 
      return 
