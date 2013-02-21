
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 30. putclef (staff)                                 ³ 
&dA &d@³                                                       ³ 
&dA &d@³    Purpose:  write clef sign to intermediate file     ³ 
&dA &d@³                                                       ³ 
&dA &d@³    Inputs:   staff   = staff number (1 or 2)          ³ 
&dA &d@³              clef(.) = clef code                      ³ 
&dA &d@³              obx     = x offset                       ³ 
&dA &d@³              oby     = y offset                       ³ 
&dA &d@³              z       = clef font                      ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
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
