
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 12. wideleger                                                  ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Purpose: set wide a leger line for a note head located on,    ³ 
&dA &d@³                above, or below a leger line                      ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Inputs:  obx = x-position of object                           ³ 
&dA &d@³             oby = y-position of object                           ³ 
&dA &d@³               x = x-position of note head                        ³ 
&dA &d@³               y = y-position of note head                        ³ 
&dA &d@³        passsize = note size (full size, cue size)                ³ 
&dA &d@³             c10 = note-on-line flag:  0 = on line, 1 = on space  ³ 
&dA &d@³      color_flag = put out leger in color  (&dA12/21/10&d@)             ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Internal:  x,y,z  sent to subj                                ³ 
&dA &d@³                                                                  ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure wideleger  
        int t1 

        z = passsize * 128 + 45                 /* music font 
        t1 = x 
        if c10 = 0   
          --x
        end  
        if color_flag > 4 
          perform subj3 (color_flag)            /* New &dA12/21/10&d@ 
        else 
          perform subj 
        end 
        if c10 = 0   
          x += hpar(106) 
        else   
          x += hpar(107) 
        end  
        if color_flag > 4 
          perform subj3 (color_flag)            /* New &dA12/21/10&d@ 
        else 
          perform subj 
        end 
        x = t1 
      return 
