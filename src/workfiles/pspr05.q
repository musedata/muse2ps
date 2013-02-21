
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D*  5. revset                                                  ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose:  Check for reversal of page and correct x y and z ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Inputs:  x1 = horizontal position of note                  ³ 
&dA &d@³             y1 = vertical position of note                    ³ 
&dA &d@³             z3 = character to typeset                         ³ 
&dA &d@³             stem = stem direction                             ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Note: Called only by ps_setbeam                            ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure revset
        int cc                       /* New &dA12/17/10&d@ 

        cc = color_flag              /* New &dA12/17/10&d@ 
        x = x1 
        y = y1 
        z = z3 
        if stem = DOWN 
          if z = 59 or z = 61 or z = 187 or z = 189 
            ++z       
          end  
          y = pvpar(2) * 500  - y   
        end      
        perform setmus 
        color_flag = cc              /* New &dA12/17/10&d@ 
      return 
