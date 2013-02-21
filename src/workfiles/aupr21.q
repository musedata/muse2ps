
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 21. getspace                                                      ³ 
&dA &d@³                                                                     ³ 
&dA &d@³    Purpose:  Determine space parameter for particular note value    ³ 
&dA &d@³                                                                     ³ 
&dA &d@³    Inputs:    a5 = pointer into set array                           ³ 
&dA &d@³                                                                     ³ 
&dA &d@³    Outputs:   a6 = space parameter                                  ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure getspace   
        int t1,t2,t3,t4 
        int gsp_ntype                 /* new &dA10/15/07&d@ 
        int note_style                /* new &dA01/08/11&d@ 

&dA 
&dA &d@      Determine note style (New &dA01/08/11&d@) 
&dA 
        note_style = ts(a5,SUBFLAG_1) & 0x8000 
        note_style >>= 15 
&dA     
        if ts(a5,CLAVE) = 101 or ts(a5,CLAVE) = 102       /* movable rest (altered &dA01/03/04&d@)
          a6 = hpar(24) + hpar(25) - hpar(37)  
          return 
        end  

        gsp_ntype = ts(a5,NTYPE) & 0xff            /* new &dA10/15/07&d@ 
        a6 = gsp_ntype * 3                         /* new &dA10/15/07&d@ 

        if a6 = 0  
          a6 = 3 
        end  
        --a6
        if ts(a5,DOT) > 0 
          ++a6
        else 
          if (ts(a5,TUPLE) & 0xffff) > 2          /* New &dA11/05/05&d@ 
            --a6
          end  
        end  
        a6 = nsp(a6)   

        t4 = hpar(28) * xmindist / 100 / hpar(4)   /* New &dA01/08/11&d@ 

*  make extra space for up-flags 
        if ts(a5,TYPE) = NOTE and bit(1,ts(a5,STEM_FLAGS)) = UP 
          if ts(a5,BEAM_FLAG) = NO_BEAM and gsp_ntype    < QUARTER     /* new &dA10/15/07
            a6 += t4       
            if note_style = 0                     /* New &dA01/08/11&d@ 
              t3 = hpar(26) + t4 + hpar(82) 
            else 
              t3 = hpar(26) + t4 
            end 

            if a6 < t3 
              loop for t1 = a5+1 to sct 
                if ts(t1,DIV) > ts(a5,DIV) 
                  loop for t2 = t1 to sct 
                    if ts(t2,DIV) = ts(t1,DIV) 
                      if ts(t2,TYPE) <= NOTE_OR_REST 
                        if ts(t2,STAFF_NUM) = ts(a5,STAFF_NUM) 
                          if ts(t2,CLAVE) >= ts(a5,CLAVE) 
                            a6 = t3 
                            t2 = sct 
                          end 
                        end 
                      end 
                    else 
                      t2 = sct 
                    end 
                  repeat 
                  t1 = sct 
                end 
              repeat 
            end 
          end 
        end  
*  allow mininum extra space if next note on staff has stem-down repeaters 


*  make extra space for sixteenth and smaller rests  
        if ts(a5,TYPE) = REST and gsp_ntype    < EIGHTH        /* new &dA10/15/07
          a6 = 6 - gsp_ntype    * hpar(54) + a6                /* new &dA10/15/07
        end 
*  shrink space if cue-size flag is set 
        if bit(16,ts(a5,SUBFLAG_1)) = CUESIZE 
          a6 = a6 * 8 / 10 
        end 
      return 
