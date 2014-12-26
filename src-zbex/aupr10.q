
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 10. yadjust (operates on an entire chord at once)                ³ 
&dA &d@³                                                                    ³ 
&dA &d@³    Purpose:  to work in conjunction with setperf to adjust         ³ 
&dA &d@³              the y position so that the indication will            ³ 
&dA &d@³              fall on c4/c5 or above/below the staff line,          ³ 
&dA &d@³              whichever is higher/lower.  Procedure also            ³ 
&dA &d@³              determines a new value of the virtual endpoints,      ³ 
&dA &d@³              c4/c5 based on the y position and the vertical        ³ 
&dA &d@³              space parameter, c13, which is passed to the          ³ 
&dA &d@³              procedure.                                            ³ 
&dA &d@³                                                                    ³ 
&dA &d@³    Inputs:   c4 = virtual vertical position of controlling         ³ 
&dA &d@³                       note head                                    ³ 
&dA &d@³              c5 = virtual vertical position of end of stem         ³ 
&dA &d@³              stem = stem direction  0 = up                         ³ 
&dA &d@³                                     1 = down                       ³ 
&dA &d@³              c7 = situation flag    0 = place on note head         ³ 
&dA &d@³                                     1 = place on stem              ³ 
&dA &d@³             c13 = vertical space of next character to set          ³ 
&dA &d@³                                                                    ³ 
&dA &d@³    Outputs:  c4 = updated vertical position of controlling         ³ 
&dA &d@³                       note head                                    ³ 
&dA &d@³              c5 = updataed vertical position of end of stem        ³ 
&dA &d@³              c9 = position flag (1 = place on top of staff)        ³ 
&dA &d@³                                                                    ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
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
