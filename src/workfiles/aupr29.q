
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 29. zjcline (staff)                                              ³ 
&dA &d@³                                                                    ³ 
&dA &d@³    Purpose:  Compute values of z, clef_vpos and cline from clef    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³    Inputs:   staff     = staff number (1 or 2)                     ³ 
&dA &d@³              clef(.)   = clef flag                                 ³ 
&dA &d@³                                                                    ³ 
&dA &d@³    Outputs:  z         = clef font                                 ³ 
&dA &d@³              clef_vpos = vertical postion of clef                  ³ 
&dA &d@³              cline(.)  = location of middle C                      ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure zjcline (staff) 
        int t1,t2,t3,t4,t5 
        int staff 

        getvalue staff 
        t3 = clef(staff) / 10  
        clef_vpos = 6 - rem 
        t4 = t3 / 3  
        t2 = rem  
        if rem = 0 
          z = 33 
        else 
          z = 34 + t2   
        end  
        t5 = clef_vpos * 2 + 20 
        t1 = 0  
        if t4 > 0 
          if t4 = 1 
            t1 = 7  
          else 
            t1 = -7 
          end  
        end  
        cline(staff) = t2 - 1 * 4 + t5 + t1 
      return 
