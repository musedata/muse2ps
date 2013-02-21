
&dA &d@��������������������������������������������������������������Ŀ 
&dA &d@�P* 37. typeset_tuple (t1,t2,t3)                               � 
&dA &d@�                                                              � 
&dA &d@�    Purpose:  Typeset tuple companion to repeater             � 
&dA &d@�                                                              � 
&dA &d@�    Inputs:   t1     = tuple number                           � 
&dA &d@�              t2     = centered x-location to place tuple     � 
&dA &d@�              t3     = y-location to place tuple              � 
&dA &d@�                                                              � 
&dA &d@���������������������������������������������������������������� 
      procedure typeset_tuple (t1,t2,t3) 
        int t1,t2,t3 
        int savex,savey,savez 

        getvalue t1,t2,t3 

        savex = x 
        savey = y 
        savez = z 
        x = t2 
        y = t3 
        if t1 > 9 
          x -= hpar(104) 
          z = t1 / 10 + 221 
          t1 = rem 
          perform subj 
          x += hpar(105) 
          z = t1 + 221 
          perform subj 
        else 
          z = t1 + 221 
          perform subj 
        end 
        x = savex 
        y = savey 
        z = savez 
      return 
