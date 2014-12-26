
&dA &d@�����������������������������������������������������������������Ŀ 
&dA &d@�P* 31. rotate_array (t1,t2)                                      � 
&dA &d@�                                                                 � 
&dA &d@�    Purpose:  Move ts array elements at t2 to t1 position.       � 
&dA &d@�              Rotate all other elements down one                 � 
&dA &d@�                                                                 � 
&dA &d@�    Inputs:   t1    = top of rotation                            � 
&dA &d@�              t2    = bottom of rotation (t2 > t1)               � 
&dA &d@�                                                                 � 
&dA &d@������������������������������������������������������������������� 
      procedure rotate_array (t1,t2) 
        int temp(TS_SIZE) 
        int t1,t2,t3,t4 

        getvalue t1,t2 
        if t2 = t1 
          return 
        end 
        loop for t3 = 1 to TS_SIZE 
          temp(t3) = ts(t2,t3)          /* create hole at the bottom (save bottom)
        repeat 
        loop for t4 = t2 to t1+1 step -1    /* loop in backwards order 
          loop for t3 = 1 to TS_SIZE 
            ts(t4,t3) = ts(t4-1,t3)     /* copy each row from the one above it 
          repeat 
        repeat 
        loop for t3 = 1 to TS_SIZE 
          ts(t1,t3) = temp(t3)          /* store bottem piece at top 
        repeat 
      return 
