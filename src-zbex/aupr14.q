
&dA &d@��������������������������������������������������������������Ŀ 
&dA &d@�P* 14. setdots                                                � 
&dA &d@�                                                              � 
&dA &d@�    Purpose:  typeset sub-object dot(s)                       � 
&dA &d@�                                                              � 
&dA &d@�    Inputs:  c3 = pointer into set array for this note        � 
&dA &d@�            obx = horizontal position of object               � 
&dA &d@�            oby = vertical position of object                 � 
&dA &d@�       passsize = note size (full size, cue size)             � 
&dA &d@�     color_flag = put out dots in color  (&dA12/21/10&d@)           � 
&dA &d@�                                                              � 
&dA &d@���������������������������������������������������������������� 
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
