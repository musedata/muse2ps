
&dA &d@��������������������������������������������������������������������Ŀ 
&dA &d@�P* 10. yadjust (operates on an entire chord at once)                � 
&dA &d@�                                                                    � 
&dA &d@�    Purpose:  to work in conjunction with setperf to adjust         � 
&dA &d@�              the y position so that the indication will            � 
&dA &d@�              fall on c4/c5 or above/below the staff line,          � 
&dA &d@�              whichever is higher/lower.  Procedure also            � 
&dA &d@�              determines a new value of the virtual endpoints,      � 
&dA &d@�              c4/c5 based on the y position and the vertical        � 
&dA &d@�              space parameter, c13, which is passed to the          � 
&dA &d@�              procedure.                                            � 
&dA &d@�                                                                    � 
&dA &d@�    Inputs:   c4 = virtual vertical position of controlling         � 
&dA &d@�                       note head                                    � 
&dA &d@�              c5 = virtual vertical position of end of stem         � 
&dA &d@�              stem = stem direction  0 = up                         � 
&dA &d@�                                     1 = down                       � 
&dA &d@�              c7 = situation flag    0 = place on note head         � 
&dA &d@�                                     1 = place on stem              � 
&dA &d@�             c13 = vertical space of next character to set          � 
&dA &d@�                                                                    � 
&dA &d@�    Outputs:  c4 = updated vertical position of controlling         � 
&dA &d@�                       note head                                    � 
&dA &d@�              c5 = updataed vertical position of end of stem        � 
&dA &d@�              c9 = position flag (1 = place on top of staff)        � 
&dA &d@�                                                                    � 
&dA &d@���������������������������������������������������������������������� 
      procedure yadjust 
        int t1 

        if c7 = 0  
          if stem = DOWN
            if c4 > vpar(1)  
              c4 = vpar(1) 
            end  
          else   
            if c4 < vpar(7)  
              c4 = vpar(7) 
            end  
          end  
        else 
          if stem = DOWN
            if c5 < vpar(8)  
              c5 = vpar(8) 
            end  
          else 
            if c5 > 0  
              c5 = 0 
            end  
          end  
        end  
*   determine y location 
        c9 = stem + c7 
        t1 = 1 
        if c9 = 1  
          t1 = -1 
        end  
        if c7 = 0  
          y = 5 * notesize / 4 * t1 + c4 
          if stem = UP 
            y += c13 
          end  
        else 
          y = vpar(2) * t1 + c5        /* &dAwas vpar(1)&d@ 
          if stem = DOWN
            y += c13 
          end  
        end  
*    compute new vertual endpoints   
        if c7 = 1  
          c5 += c13 * t1 
        else 
          c4 += c13 * t1 
        end  
      return 
