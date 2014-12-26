
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 27. putbar (t1)                                             ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose:  Typeset bar line                                 ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Inputs:   t1 = staff number of last line                   ³ 
&dA &d@³              y1 = coordinate of top of line                   ³ 
&dA &d@³              y2 = coordinate of last bar character            ³ 
&dA &d@³              brkcnt = number of breaks in bar                 ³ 
&dA &d@³              barbreak(.,1) = y coordinate of top of break     ³ 
&dA &d@³              barbreak(.,2) = y coordinage of bottom of break  ³ 
&dA &d@³              x = x-coordinat of line                          ³ 
&dA &d@³              z = font character                               ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure putbar (t1)
        int t1,t2 
        int c1,c3,c4 
        getvalue t1

        if brkcnt = 0  
          t2 = y2 + vst(t1) 
          loop for y = y1 to t2 step pvpar(8) 
            perform setmus 
          repeat 
          y = t2 
          perform setmus 
          return 
        end  
        c3 = y1  
        loop for c1 = 1 to brkcnt  
          c4 = barbreak(c1,1) - pvpar(8)  
          if c4 > c3 
            if c4 < y2   
              loop for y = c3 to c4 step pvpar(8) 
                perform setmus 
              repeat 
              y = c4 
              perform setmus 
              c3 = barbreak(c1,2)  
            end  
          end  
        repeat 
        c4 = y2 + vst(t1) 
        if c4 >= c3  
          loop for y = c3 to c4 step pvpar(8) 
            perform setmus 
          repeat 
          y = c4 
          perform setmus 
        end  
      return 
