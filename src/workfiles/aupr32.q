
&dA &d@�����������������������������������������������������������������Ŀ 
&dA &d@�P* 32. get_topbottom (t1,t2,t3)                                  � 
&dA &d@�                                                                 � 
&dA &d@�    Purpose:  If t1 points to a ts row element which is a note   � 
&dA &d@�              head, then t2 will point to the ts row element     � 
&dA &d@�              which is the top of the chord, and t3 will point   � 
&dA &d@�              to the ts row element which is the bottom of the   � 
&dA &d@�              chord                                              � 
&dA &d@�                                                                 � 
&dA &d@�    Inputs:   t1    = index to ts row element                    � 
&dA &d@�                                                                 � 
&dA &d@�    Outputs:  t2    = index to top of chord                      � 
&dA &d@�              t3    = index to bottom of chord                   � 
&dA &d@�                                                                 � 
&dA &d@�    Note:  Do not call this procedure before GLOBAL_XOFF is set  � 
&dA &d@�                                                                 � 
&dA &d@������������������������������������������������������������������� 
      procedure get_topbottom (t1,t2,t3) 
        int t1,t2,t3,t4 

        getvalue t1 
        t4 = ts(t1,GLOBAL_XOFF) 
        if t4 > INT10000 
          t2 = t4 / INT10000 
          t3 = rem 
        else 
          t4 = ts(t1+1,GLOBAL_XOFF) 
          if t4 > INT10000 
            t2 = t4 / INT10000 
            t3 = rem 
          else 
            t2 = t1 
            t3 = t1 
          end 
        end 
        passback t2,t3 
      return 
