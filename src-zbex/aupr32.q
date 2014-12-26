
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 32. get_topbottom (t1,t2,t3)                                  ³ 
&dA &d@³                                                                 ³ 
&dA &d@³    Purpose:  If t1 points to a ts row element which is a note   ³ 
&dA &d@³              head, then t2 will point to the ts row element     ³ 
&dA &d@³              which is the top of the chord, and t3 will point   ³ 
&dA &d@³              to the ts row element which is the bottom of the   ³ 
&dA &d@³              chord                                              ³ 
&dA &d@³                                                                 ³ 
&dA &d@³    Inputs:   t1    = index to ts row element                    ³ 
&dA &d@³                                                                 ³ 
&dA &d@³    Outputs:  t2    = index to top of chord                      ³ 
&dA &d@³              t3    = index to bottom of chord                   ³ 
&dA &d@³                                                                 ³ 
&dA &d@³    Note:  Do not call this procedure before GLOBAL_XOFF is set  ³ 
&dA &d@³                                                                 ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
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
