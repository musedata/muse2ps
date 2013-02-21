
&dA &d@�������������������������������������������������������Ŀ 
&dA &d@�P* 30. putclef (staff)                                 � 
&dA &d@�                                                       � 
&dA &d@�    Purpose:  write clef sign to intermediate file     � 
&dA &d@�                                                       � 
&dA &d@�    Inputs:   staff   = staff number (1 or 2)          � 
&dA &d@�              clef(.) = clef code                      � 
&dA &d@�              obx     = x offset                       � 
&dA &d@�              oby     = y offset                       � 
&dA &d@�              z       = clef font                      � 
&dA &d@��������������������������������������������������������� 
      procedure putclef (staff) 
        int t1,t2,t3 
        int staff 

        getvalue staff 
        t2 = clef(staff) / 10  
        t3 = t2 / 3  
        t1 = rem  
        jtype = "C"  
        jcode = clef(staff) 
        out = "0"  
        if t1 = 0 
          x = obx  
          y = oby  
          perform subj 
          ++z
          perform subj 
          if t3 = 1 
            x = obx + hpar(52) 
            y = oby + vpar(23) 
            z = 234  
            perform subj 
          end  
          pcode = sobcnt 
        else 
          pcode = z  
        end  
        putobjpar = 0 
        perform putobj 
      return 
