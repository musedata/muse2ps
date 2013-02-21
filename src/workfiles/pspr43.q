
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 43. hpage_limits (leftt,rightt)                                    ³ 
&dA &d@³                                                                      ³ 
&dA &d@³                                                                      ³ 
&dA &d@³    Purpose: determine left and right page limits for those           ³ 
&dA &d@³                pages that do not have a system                       ³ 
&dA &d@³                                                                      ³ 
&dA &d@³   Inputs:  gstr  The structure of this string was determined         ³ 
&dA &d@³                  by the instruction  setup gstr,300,3100,3           ³ 
&dA &d@³                  According to the documentation, the first 20        ³ 
&dA &d@³                  bytes contain display information.  In particular,  ³ 
&dA &d@³                  bytes 13-14 contain the top display boundary;       ³ 
&dA &d@³                  and bytes 17-18 contain the bottom display          ³ 
&dA &d@³                  boundary.  The top boundary, we can use; but        ³ 
&dA &d@³                  the bottom boundary includes the bottom             ³ 
&dA &d@³                  caption, so we must look above this.                ³ 
&dA &d@³                                                                      ³ 
&dA &d@³   Output:  int   leftt  = left_limit                                 ³ 
&dA &d@³            int   rightt = right_limit                                ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure hpage_limits (leftt,rightt) 
        str line.300 
        bstr bline.2400,bline2.2400 
        int a1,a2,a3 
        int leftt,rightt 
&dA 
&dA &d@    Get limits 
&dA 
        leftt = 10000 
        rightt = 10000 

        loop for a1 = 1 to 3090 
          a2 = (a1 - 1) * 300 + 21 
          line = gstr{a2,300} 
          bline = cbi(line) 
          bline = bline // zpd(2400) 
          bline2 = rev(bline) 
          if bline con "1" 
            a3 = mpt 
            if a3 < leftt 
              leftt = a3 
            end 
          end 
          if bline2 con "1" 
            a3 = mpt 
            if a3 < rightt 
              rightt = a3 
            end 
          end 
        repeat 

        if leftt = 10000 
          leftt = 1200 
          rightt = 1200 
        else 
          rightt = 2401 - rightt 
        end 
        passback leftt,rightt 

      return 
