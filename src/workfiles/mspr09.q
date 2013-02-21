
&dA &d@��������������������������������������������������������������������������Ŀ
&dA &d@�M*  9. getcontrol (gbarnum)                                               �
&dA &d@�                                                                          �
&dA &d@�    Purpose:  Find the object that generates a proper-node for            �
&dA &d@�                 the current object being looked at at rec.               �
&dA &d@�                                                                          �
&dA &d@�    Inputs:   rec = record number for current object                      �
&dA &d@�              f12 = part to search                                        �
&dA &d@�              cjtype = object type from last call to getcontrol           �
&dA &d@�              csnode = node number from last call to getcontrol           �
&dA &d@�              gbarnum = barnum                                            �
&dA &d@�                                                                          �
&dA &d@�    Outputs:  crec   = record number which generates proper-node          �
&dA &d@�              cjtype = object type                                        �
&dA &d@�              cntype = node type                                          �
&dA &d@�              cdv    = x coordinate                                       �
&dA &d@�              coby   = y coordinate                                       �
&dA &d@�              cz     = value of z                                         �
&dA &d@�              csnode = snode number                                       �
&dA &d@�                                                                          �
&dA &d@�    Operation:  if csnode < 6913 and                                      �
&dA &d@�                  if csnode = snode and                                   �
&dA &d@�                    if cjtype = B and                                     �
&dA &d@�                      if jtype = N,R,Q,F,I, current object generates node �
&dA &d@�                      otherwise next N,R,Q,F,I object generates node      �
&dA &d@�                    otherwise current proper node is still valid          �
&dA &d@�                  if csnode < snode and                                   �
&dA &d@�                    if jtype = N,R,Q,F,I,B, current object generates node �
&dA &d@�                    otherwise next N,R,Q,F,I,B object generates node      �
&dA &d@�                  if csnode > snode, I think you have a problem           �
&dA &d@�                if csnode = 6913                                          �
&dA &d@�                  if snode = 6913 and                                     �
&dA &d@�                    if jtype = B,C,K,T, current object generates node     �
&dA &d@�                    otherwise next C,K,T generates node                   �
&dA &d@�                  otherwise next N,R,Q,F,I,B object generates node        �
&dA &d@�                                                                          �
&dA &d@����������������������������������������������������������������������������
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
