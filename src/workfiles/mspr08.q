
&dA &d@������������������������������������������������������������������Ŀ 
&dA &d@�M*  8. adjolddist                                                 � 
&dA &d@�                                                                  � 
&dA &d@�    Purpose:  Adjust olddist(.) for parts where f(f12,10) = 0     � 
&dA &d@�                                                                  � 
&dA &d@�������������������������������������������������������������������� 
      procedure adjolddist 
        int t1 

        t1 = 1 
        loop for f12 = 1 to f11  
          if f(f12,10) = 0 
            if tdist(t1,1) = f12  
              olddist(f12) = tdist(t1,2)  
              ++t1 
            else 
              olddist(f12) += marr(marc,PRE_DIST)   
            end  
          end  
        repeat 
      return 
