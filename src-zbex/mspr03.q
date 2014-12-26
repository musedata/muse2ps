
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³M*  3. clefkeyspace (t2)                                          ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Purpose:  Compute space for new clef and key                  ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Operation: Create entry for global double bar, if t2 is set.  ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Inputs:    Staff locations: (sp,sq(.))                        ³ 
&dA &d@³               Clef code:  mclef(.,.)                             ³ 
&dA &d@³               Key code:   mkey(.)                                ³ 
&dA &d@³               Time code:  mtcode(.)                              ³ 
&dA &d@³               t2:         double bar flag                        ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Outputs:   ldist,gbarflag,gbar(if t2 is set),mtcode,savtcode  ³ 
&dA &d@³               tplace                                             ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Internal variables: a1,a2                                     ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure clefkeyspace (t2) 
        int t1,t2,t3,t4,t5 
        getvalue t2 

        gbarflag = 0   
        ldist = sp + hxpar(10) 
&dA 
&dA &d@    1) clef 
&dA 
        ldist = ldist + hxpar(15) 
&dA 
&dA &d@    2) key signature  
&dA 
        t5 = ldist 
        loop for f12 = 1 to f11  
          notesize = f(f12,14) 
          x = ldist  
&dA &d@   sharps 
          if mkey(f12) > 0    
            x = mhpar(f12,6) * mkey(f12) + x 
          end  
&dA &d@   flats  
          if mkey(f12) < 0    
            x = 0 - mkey(f12) * mhpar(f12,7) + x 
          end  
          if mkey(f12) = 0    
            t4 = x   
          else 
            t4 = x + hxpar(2)     
          end  
          if t4 > t5 
            t5 = t4  
          end  
        repeat 
        if t5 > ldist  
          ldist = t5 
        end  
        tplace = ldist - sp  
&dA &d@      
&dA &d@    3) time change  
&dA 
        t5 = ldist 
        loop for f12 = 1 to f11  
          notesize = f(f12,14) 
          savtcode(f12) = mtcode(f12) 
          if mtcode(f12) < 10000  
            a1 = mtcode(f12) / 100  
            a2 = rem 
            t3 = 0   
            if a1 = 1 and a2 = 1 
              t3 = 1 
            end    
            if a1 = 0 and a2 = 0 
              t3 = 2 
            end  
&dA 
            if t3 > 0 
              t5 = ldist + hxpar(12) 
            else 
              t1 = ldist + hxpar(21) + hxpar(19) 
              if a2 < 10 and a1 < 10 
                t1 = ldist + hxpar(22) + hxpar(20) 
              end 
              t5 = t1 - hxpar(13) 
            end  
            if bit(1,t2) = 1 
              t5 += hxpar(11)     /* &dA05-27-94&d@ I'm not sure why this is necessary, but it is.
            end 
          end  
          mtcode(f12) = 10000 
        repeat 
        if ldist < t5  
          ldist = t5 
        end  
&dA 
&dA &d@    4) store info for double bar if left over from last line  
&dA 
        if bit(1,t2) = 1 
          gbarflag = 1   
          gbar(1) = ldist + hxpar(11) - sp 
          gbar(2) = 9  
          ldist = ldist + hxpar(11) + hxpar(16) + hxpar(17) 
          if bit(0,t2) = 1 
            gbar(2) += 16 
            ldist += hxpar(18) 
          end  
        else 
          ldist += hxpar(5) 
        end  
      return 
