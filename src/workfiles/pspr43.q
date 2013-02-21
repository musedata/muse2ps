
&dA &d@����������������������������������������������������������������������Ŀ 
&dA &d@�D* 43. hpage_limits (leftt,rightt)                                    � 
&dA &d@�                                                                      � 
&dA &d@�                                                                      � 
&dA &d@�    Purpose: determine left and right page limits for those           � 
&dA &d@�                pages that do not have a system                       � 
&dA &d@�                                                                      � 
&dA &d@�   Inputs:  gstr  The structure of this string was determined         � 
&dA &d@�                  by the instruction  setup gstr,300,3100,3           � 
&dA &d@�                  According to the documentation, the first 20        � 
&dA &d@�                  bytes contain display information.  In particular,  � 
&dA &d@�                  bytes 13-14 contain the top display boundary;       � 
&dA &d@�                  and bytes 17-18 contain the bottom display          � 
&dA &d@�                  boundary.  The top boundary, we can use; but        � 
&dA &d@�                  the bottom boundary includes the bottom             � 
&dA &d@�                  caption, so we must look above this.                � 
&dA &d@�                                                                      � 
&dA &d@�   Output:  int   leftt  = left_limit                                 � 
&dA &d@�            int   rightt = right_limit                                � 
&dA &d@������������������������������������������������������������������������ 
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
