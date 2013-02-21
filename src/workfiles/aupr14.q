
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 14. setdots                                                ³ 
&dA &d@³                                                              ³ 
&dA &d@³    Purpose:  typeset sub-object dot(s)                       ³ 
&dA &d@³                                                              ³ 
&dA &d@³    Inputs:  c3 = pointer into set array for this note        ³ 
&dA &d@³            obx = horizontal position of object               ³ 
&dA &d@³            oby = vertical position of object                 ³ 
&dA &d@³       passsize = note size (full size, cue size)             ³ 
&dA &d@³     color_flag = put out dots in color  (&dA12/21/10&d@)           ³ 
&dA &d@³                                                              ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure setdots     
        int t1,t2,t3,t4,t6 

        t4 = ts(c3,DOT) 
        if t4 > 0 
          t1 = t4 >> 4                          /* code modified &dA12-24-96&d@ 
          t1 /= INT10000 
          t2 = rem 
          if t2 > (INT10000 >> 1) 
            t2 -= INT10000 
            ++t1 
          end 
          
          t6 = 18                               /* New code &dA05/02/03&d@ extension dot code = 18
          perform getpxpy (t6,c3) 

          if pxx = 1 
            x = obx + px 
          else 
            x = obx + t1 + px 
          end 
          if pyy = 1 
            y = oby + py 
          else 
            y = oby + t2 + py 
          end 
                                                /* end New code 

          z = 128 * passsize + 44               /* music font 
          if color_flag > 0
            perform subj3 (color_flag)          /* New &dA12/21/10&d@ 
          else 
            perform subj                        /* first dot 
          end 
          if t4 & 0x03 = 3 
            t3 = hpar(91) 
            if passsize = CUESIZE
              t3 = t3 * 8 / 10 
            end 
            x += t3                       
            if color_flag > 0
              perform subj3 (color_flag)        /* New &dA12/21/10&d@ 
            else 
              perform subj                      /* second dot 
            end 
          end

&dA &d@    added code  &dA12-24-96&d@ 

          if t4 & 0x04 = 4 
            t3 = hpar(91) 
            if passsize = CUESIZE
              t3 = t3 * 8 / 10 
            end 
            x += t3                       
            if color_flag > 0
              perform subj3 (color_flag)        /* New &dA12/21/10&d@ 
            else 
              perform subj                      /* third dot 
            end 
          end
          if t4 & 0x08 = 8 
            t3 = hpar(91) 
            if passsize = CUESIZE
              t3 = t3 * 8 / 10 
            end 
            x += t3                       
            if color_flag > 0
              perform subj3 (color_flag)        /* New &dA12/21/10&d@ 
            else 
              perform subj                      /* fourth dot 
            end 
          end
        end  
      return   
