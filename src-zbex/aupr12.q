
&dA &d@������������������������������������������������������������������Ŀ 
&dA &d@�P* 12. wideleger                                                  � 
&dA &d@�                                                                  � 
&dA &d@�    Purpose: set wide a leger line for a note head located on,    � 
&dA &d@�                above, or below a leger line                      � 
&dA &d@�                                                                  � 
&dA &d@�    Inputs:  obx = x-position of object                           � 
&dA &d@�             oby = y-position of object                           � 
&dA &d@�               x = x-position of note head                        � 
&dA &d@�               y = y-position of note head                        � 
&dA &d@�        passsize = note size (full size, cue size)                � 
&dA &d@�             c10 = note-on-line flag:  0 = on line, 1 = on space  � 
&dA &d@�      color_flag = put out leger in color  (&dA12/21/10&d@)             � 
&dA &d@�                                                                  � 
&dA &d@�    Internal:  x,y,z  sent to subj                                � 
&dA &d@�                                                                  � 
&dA &d@�������������������������������������������������������������������� 
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
