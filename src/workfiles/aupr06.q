
&dA &d@���������������������������������������������������������������Ŀ 
&dA &d@�P*  6. setax                                                   � 
&dA &d@�                                                               � 
&dA &d@�    Purpose:  Set accidental                                   � 
&dA &d@�                                                               � 
&dA &d@�    Inputs:  c3 = index into ts array                          �       
&dA &d@�             c4 = accident flag                                � 
&dA &d@�       passsize = note size (full, cue-size)                   � 
&dA &d@�            obx = x co-ordinate of object                      � 
&dA &d@�            oby = y co-ordinate of object                      � 
&dA &d@�              y = y co-ordinate of note head                   � 
&dA &d@�     color_flag = put out accidental in color  (&dA12/21/10&d@)      � 
&dA &d@�                                                               � 
&dA &d@�    Internal: x,y,z sent to subj                               � 
&dA &d@�                                                               � 
&dA &d@�                                                               � 
&dA &d@����������������������������������������������������������������� 
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
