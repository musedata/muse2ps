
&dA &d@���������������������������������������������������������������Ŀ 
&dA &d@�D* 34. stringout (out)                                         � 
&dA &d@�                                                               � 
&dA &d@�    Operation:  Put out a string of characters                 � 
&dA &d@����������������������������������������������������������������� 
      procedure stringout (out) 
        str out.500 
        int font,kk 
        int t1 
        getvalue out 
        int scx2                    /* added &dA11/29/09&d@ 

        loop for t1 = 1 to len(out) 
          kk = ors(out{t1}) 
          if kk > 130 and kk < 142 
            if kk < 140 
              scx += (kk - 130) 
            else 
              scx -= (kk - 139) 
            end 
          else 
            scb = kk 
            perform charout 
          end 
        repeat 
      return 
