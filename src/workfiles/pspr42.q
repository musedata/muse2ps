
&dA &d@����������������������������������������������������������������������Ŀ 
&dA &d@�D* 42. vpage_limits (topp,bottomm)                                    � 
&dA &d@�                                                                      � 
&dA &d@�                                                                      � 
&dA &d@�    Purpose: determine top and bottom page limits                     � 
&dA &d@�                ignoring the caption at the bottom                    � 
&dA &d@�                                                                      � 
&dA &d@�   Inputs:  gstr  The struction of this string was determined         � 
&dA &d@�                  by the instruction  setup gstr,300,3100,3           � 
&dA &d@�                  According to the documentation, the first 20        � 
&dA &d@�                  bytes contain display information.  In particular,  � 
&dA &d@�                  bytes 13-14 contain the top display boundary;       � 
&dA &d@�                  and bytes 17-18 contain the bottom display          � 
&dA &d@�                  boundary.  The top boundary, we can use; but        � 
&dA &d@�                  the bottom boundary includes the bottom             � 
&dA &d@�                  caption, so we must look above this.                � 
&dA &d@�                                                                      � 
&dA &d@�   Output:  int   topp    =  top_limit                                � 
&dA &d@�            int   bottomm =  bottom_limit                             � 
&dA &d@������������������������������������������������������������������������ 
      procedure vpage_limits (topp,bottomm) 
        int topp,bottomm 
        int a1,a2,a3,a4,a5 
&dA 
&dA &d@    Get top limit 
&dA 
        topp = 10000 
        a3 = 20 
        loop for a1 = 1 to 3099 
          loop for a2 = 1 to 300 
            ++a3 
            if gstr{a3} <> chr(0) 
              topp = a1 
              goto BBB 
            end 
          repeat 
        repeat 
BBB: 
&dA 
&dA &d@    Get bottom limit 
&dA 
        a5 = 0 
        loop for a1 = 3050 to 1 step -1 
          loop for a2 = 1 to 300 
            a3 = a1 * 300 + a2 + 20 
            if gstr{a3} <> chr(0) 
              a5 = a1 
              goto BBB1 
            end 
          repeat 
        repeat 
BBB1: 
        bottomm = a5 

        passback topp,bottomm 
      return 
