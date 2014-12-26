
&dA &d@��������������������������������������������������������������������Ŀ 
&dA &d@�P* 29. zjcline (staff)                                              � 
&dA &d@�                                                                    � 
&dA &d@�    Purpose:  Compute values of z, clef_vpos and cline from clef    � 
&dA &d@�                                                                    � 
&dA &d@�    Inputs:   staff     = staff number (1 or 2)                     � 
&dA &d@�              clef(.)   = clef flag                                 � 
&dA &d@�                                                                    � 
&dA &d@�    Outputs:  z         = clef font                                 � 
&dA &d@�              clef_vpos = vertical postion of clef                  � 
&dA &d@�              cline(.)  = location of middle C                      � 
&dA &d@���������������������������������������������������������������������� 
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
