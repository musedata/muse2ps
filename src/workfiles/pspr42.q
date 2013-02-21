
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 42. vpage_limits (topp,bottomm)                                    ³ 
&dA &d@³                                                                      ³ 
&dA &d@³                                                                      ³ 
&dA &d@³    Purpose: determine top and bottom page limits                     ³ 
&dA &d@³                ignoring the caption at the bottom                    ³ 
&dA &d@³                                                                      ³ 
&dA &d@³   Inputs:  gstr  The struction of this string was determined         ³ 
&dA &d@³                  by the instruction  setup gstr,300,3100,3           ³ 
&dA &d@³                  According to the documentation, the first 20        ³ 
&dA &d@³                  bytes contain display information.  In particular,  ³ 
&dA &d@³                  bytes 13-14 contain the top display boundary;       ³ 
&dA &d@³                  and bytes 17-18 contain the bottom display          ³ 
&dA &d@³                  boundary.  The top boundary, we can use; but        ³ 
&dA &d@³                  the bottom boundary includes the bottom             ³ 
&dA &d@³                  caption, so we must look above this.                ³ 
&dA &d@³                                                                      ³ 
&dA &d@³   Output:  int   topp    =  top_limit                                ³ 
&dA &d@³            int   bottomm =  bottom_limit                             ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
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
