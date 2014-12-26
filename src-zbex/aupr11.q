
&dA &d@��������������������������������������������������������Ŀ 
&dA &d@�P* 11. setleger                                         � 
&dA &d@�                                                        � 
&dA &d@�    Purpose, set leger lines for a chord (object)       � 
&dA &d@�                                                        � 
&dA &d@�    Inputs:  obx = x-position of object                 � 
&dA &d@�        passsize = note size (full, cue-size)           � 
&dA &d@�              c7 = pointer to lowest note in chord      � 
&dA &d@�              c8 = pointer to highest note in chord     � 
&dA &d@�              c9 = extra width of leger lines           � 
&dA &d@�            stem = stem direction   0 = up, 1 = down    � 
&dA &d@�      color_flag = put out leger in color  (&dA12/21/10&d@)   � 
&dA &d@�                                                        � 
&dA &d@�    Internal: x,y,z  sent to subj                       � 
&dA &d@�                                                        � 
&dA &d@���������������������������������������������������������� 
      procedure setleger 
        z = passsize * 128 + 45                 /* music font 
        x = obx  
        if stem = UP 
          ++x
        end  
        if ts(c8,STAFFLOC) < 0 
          y = 0 - notesize 
          loop while y >= ts(c8,STAFFLOC)  
            if color_flag > 4 
              perform subj3 (color_flag)        /* New &dA12/21/10&d@ 
            else 
              perform subj 
            end 
            if c9 > 0  
              x += c9 
              if color_flag > 4 
                perform subj3 (color_flag)      /* New &dA12/21/10&d@ 
              else 
                perform subj 
              end 
              x -= c9 
            end  
            y -= notesize 
          repeat 
        end  
        if ts(c7,STAFFLOC) > vpar(9) 
          y = vpar(10) 
          loop while y <= ts(c7,STAFFLOC)  
            if color_flag > 4 
              perform subj3 (color_flag)        /* New &dA12/21/10&d@ 
            else 
              perform subj 
            end 
            if c9 > 0  
              x += c9 
              if color_flag > 4 
                perform subj3 (color_flag)      /* New &dA12/21/10&d@ 
              else 
                perform subj 
              end 
              x -= c9 
            end  
            y += notesize 
          repeat 
        end  
      return 
