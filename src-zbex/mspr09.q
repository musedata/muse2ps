
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
&dA &d@³M*  9. getcontrol (gbarnum)                                               ³
&dA &d@³                                                                          ³
&dA &d@³    Purpose:  Find the object that generates a proper-node for            ³
&dA &d@³                 the current object being looked at at rec.               ³
&dA &d@³                                                                          ³
&dA &d@³    Inputs:   rec = record number for current object                      ³
&dA &d@³              f12 = part to search                                        ³
&dA &d@³              cjtype = object type from last call to getcontrol           ³
&dA &d@³              csnode = node number from last call to getcontrol           ³
&dA &d@³              gbarnum = barnum                                            ³
&dA &d@³                                                                          ³
&dA &d@³    Outputs:  crec   = record number which generates proper-node          ³
&dA &d@³              cjtype = object type                                        ³
&dA &d@³              cntype = node type                                          ³
&dA &d@³              cdv    = x coordinate                                       ³
&dA &d@³              coby   = y coordinate                                       ³
&dA &d@³              cz     = value of z                                         ³
&dA &d@³              csnode = snode number                                       ³
&dA &d@³                                                                          ³
&dA &d@³    Operation:  if csnode < 6913 and                                      ³
&dA &d@³                  if csnode = snode and                                   ³
&dA &d@³                    if cjtype = B and                                     ³
&dA &d@³                      if jtype = N,R,Q,F,I, current object generates node ³
&dA &d@³                      otherwise next N,R,Q,F,I object generates node      ³
&dA &d@³                    otherwise current proper node is still valid          ³
&dA &d@³                  if csnode < snode and                                   ³
&dA &d@³                    if jtype = N,R,Q,F,I,B, current object generates node ³
&dA &d@³                    otherwise next N,R,Q,F,I,B object generates node      ³
&dA &d@³                  if csnode > snode, I think you have a problem           ³
&dA &d@³                if csnode = 6913                                          ³
&dA &d@³                  if snode = 6913 and                                     ³
&dA &d@³                    if jtype = B,C,K,T, current object generates node     ³
&dA &d@³                    otherwise next C,K,T generates node                   ³
&dA &d@³                  otherwise next N,R,Q,F,I,B object generates node        ³
&dA &d@³                                                                          ³
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
      procedure getcontrol (gbarnum) 
        int gbarnum,t1 
        str local_last_jtype.1                    /* added &dA11/25/06&d@ 

        getvalue gbarnum 

        local_last_jtype = last_jtype             /* added &dA11/25/06&d@ 
        last_jtype = jtype                        /* added &dA11/25/06&d@ 

        if csnode < 6913 
          if csnode = snode  
            if cjtype = "B"  
              crec = rec 
GC1:          perform save4  
              if "NRrQFI" con cjtype              /* New &dA10/15/07&d@ 
                return 
              end  
              ++crec
              goto GC1 
            end  
            return 
          else 
            if csnode < snode  
              crec = rec 
GC2:          perform save4  
              if "NRrQFIB" con cjtype             /* New &dA10/15/07&d@ 
                if mpt < 7 
                  return 
                end  
                if csnode = 6913 
                  return 
                end  
              end  
              ++crec
              goto GC2 
            else 
              if (Debugg & 0x01) > 0 
                pute Error in part ~f12  at ~gbarnum 
                pute This could be caused by durations that don't properly add up.
              end 
              tmess = 64 
              perform dtalk (tmess) 
            end  
          end  
        else 
&dA 
&dA &d@   Code added &dA11/25/06&d@ to try to fix an End-of-measure Bug 
&dA 
          if csnode = snode and local_last_jtype = "M" and jtype <> "B" 
            crec = rec 
GC2A:       perform save4 
            if "B" con cjtype 
              return 
            end 
            if csnode < 6913 
              tmess = 65 
              perform dtalk (tmess) 
            end 
            ++crec 
            goto GC2A 
          end 

&dA                          &d@ End of &dA11/26/06&d@ Addition 

          crec = rec 
GC3:      perform save4  
          if snode = 6913  
            if "BCKT" con cjtype 
              return 
            end  
          else 
            if "NRrQFIB" con cjtype               /* New &dA10/15/07&d@ 
              return 
            end  
          end  
          ++crec
          goto GC3 
        end  
*     return 
