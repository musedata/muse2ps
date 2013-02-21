
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 11. setleger                                         ³ 
&dA &d@³                                                        ³ 
&dA &d@³    Purpose, set leger lines for a chord (object)       ³ 
&dA &d@³                                                        ³ 
&dA &d@³    Inputs:  obx = x-position of object                 ³ 
&dA &d@³        passsize = note size (full, cue-size)           ³ 
&dA &d@³              c7 = pointer to lowest note in chord      ³ 
&dA &d@³              c8 = pointer to highest note in chord     ³ 
&dA &d@³              c9 = extra width of leger lines           ³ 
&dA &d@³            stem = stem direction   0 = up, 1 = down    ³ 
&dA &d@³      color_flag = put out leger in color  (&dA12/21/10&d@)   ³ 
&dA &d@³                                                        ³ 
&dA &d@³    Internal: x,y,z  sent to subj                       ³ 
&dA &d@³                                                        ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
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
