
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 19. bracketline (t1,t2,t3)                                  ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose:  typeset bracket line                             ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Inputs:   t1 = length                                      ³ 
&dA &d@³              t2 = slope                                       ³ 
&dA &d@³              t3 = slope type  0,1,2,3,4,5                     ³ 
&dA &d@³              x1 = x starting point                            ³ 
&dA &d@³              y1 = y starting point                            ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Outputs:  x = x coordinate of end of line                  ³ 
&dA &d@³              y = y coordinate of end of line                  ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure bracketline (t1,t2,t3) 
        int a1,a2,a3 
        int t1,t2,t3 

        getvalue t1,t2,t3 
        if t1 = 0  
          return 
        end  
        x = x1 + sp  
        y = y1 + psq(f12)   
        scx = x 
        scy = y 
        scf = 400 

        if t2 > 0  
          z = 184 + t3   
        end  
        if t2 < 0  
          z = 164 + t3   
        end  
        if t2 = 0  
          z = 161  
        end  
        a1 = t1 / 12 
        a3 = rem 
        if t2 = 0 
          loop for a2 = 1 to a1 
            x += 12 
            scb = z 
            perform charout 
          repeat 
        else 
          loop for a2 = 1 to a1 
            scb = z 
            perform charout 
            if t2 > 0 
              scy += t2 
            else 
              a1 = 0 - t2 
              scy -= a1 
            end 
            x += 12 
            y += t2 
          repeat 
        end 
        if a3 > 0 
          if a3 = 9 
            if t2 < 0  
              a1 = t2 - 1 * 2 / 3 
              z += 5 
            end  
            if t2 > 0  
              a1 = t2 + 1 * 2 / 3 
              z += 5 
            end  
            if t2 = 0  
              a1 = 0 
              ++z
            end  
          end  
          if a3 = 6 
            if t2 < 0  
              a1 = t2 - 1 / 2 
              z += 10 
            end  
            if t2 > 0  
              a1 = t2 + 1 / 2 
              z += 10 
            end  
            if t2 = 0  
              a1 = 0 
              z += 2 
            end  
          end  
          if a3 = 3 
            if t2 < 0  
              a1 = t2 - 1 / 3 
              z += 15 
            end  
            if t2 > 0  
              a1 = t2 + 1 / 3 
              z += 15 
            end  
            if t2 = 0  
              a1 = 0 
              z += 3 
            end  
          end  
          scb = z 
          perform charout 
          x += a3 
          y += a1 
        end  
        scf = notesize 
      return 
