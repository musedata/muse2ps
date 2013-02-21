
&dA &d@���������������������������������������������������������������Ŀ 
&dA &d@�D*  5. revset                                                  � 
&dA &d@�                                                               � 
&dA &d@�    Purpose:  Check for reversal of page and correct x y and z � 
&dA &d@�                                                               � 
&dA &d@�    Inputs:  x1 = horizontal position of note                  � 
&dA &d@�             y1 = vertical position of note                    � 
&dA &d@�             z3 = character to typeset                         � 
&dA &d@�             stem = stem direction                             � 
&dA &d@�                                                               � 
&dA &d@�    Note: Called only by ps_setbeam                            � 
&dA &d@����������������������������������������������������������������� 
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
