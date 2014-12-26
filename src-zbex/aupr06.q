
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P*  6. setax                                                   ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose:  Set accidental                                   ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Inputs:  c3 = index into ts array                          ³       
&dA &d@³             c4 = accident flag                                ³ 
&dA &d@³       passsize = note size (full, cue-size)                   ³ 
&dA &d@³            obx = x co-ordinate of object                      ³ 
&dA &d@³            oby = y co-ordinate of object                      ³ 
&dA &d@³              y = y co-ordinate of note head                   ³ 
&dA &d@³     color_flag = put out accidental in color  (&dA12/21/10&d@)      ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Internal: x,y,z sent to subj                               ³ 
&dA &d@³                                                               ³ 
&dA &d@³                                                               ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure setax  
        int t1,t2,t4 
                                          /* &dA02/25/97&d@ shift changed from 4 to 8
        t2 = c4 >> 8                      /* x-offset (to the left) 
        t1 = c4 & 0x0f                    /* accidental only 

        t4 = 19                           /* New code &dA05/02/03&d@   accidentals code = 19
        perform getpxpy (t4,c3) 

        if pxx = 1 
          x = obx + px 
        else 
          x = obx - t2 + px 
        end 
                                                /* end New code 
        if bit(2,t1) = 1                  /* case: flat-flat or natural-(flat/sharp)
          z = bit(3,t1) + 64              /* flat or natural 
          t2 = hpar(40)  
          if passsize = CUESIZE 
            z += 128                      /* cue size 
            t2 = t2 * 8 / 10 
          end  
          if color_flag > 0
            perform subj3 (color_flag)          /* New &dA12/21/10&d@ 
          else 
            perform subj 
          end 
          x += t2 
        end  
        if t1 & 0x03 = 2 
          if bit(3,t1) = 1  
            z = 66                        /* double sharp 
          else 
            z = 63                        /* regular sharp 
          end  
        else 
          z = bit(1,t1) + 64              /* flat or natural 
        end  
        if passsize = CUESIZE 
          z += 128                        /* cue size  
        end  
        if bit(4,c4) = 0 
          if color_flag > 0
            perform subj3 (color_flag)          /* New &dA12/21/10&d@ 
          else 
            perform subj 
          end 
        else
          perform subj2                   /* Addition to Code &dA02/25/97&d@ 
        end                               
      return 
