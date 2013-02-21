
&dA &d@���������������������������������������������������������������Ŀ 
&dA &d@�D* 38. compute_delta_move (lastx,lasty,hh,kk)                  � 
&dA &d@�                                                               � 
&dA &d@�    Purpose: construct a Postscript delta move entry from      � 
&dA &d@�                PCL coordinates                                � 
&dA &d@�                                                               � 
&dA &d@�   Input:  lastx  former  x location                           � 
&dA &d@�           lasty  former  y location                           � 
&dA &d@�           hh     current x location                           � 
&dA &d@�           kk     current y location                           � 
&dA &d@�                                                               � 
&dA &d@�   Output  string mtloc                                        � 
&dA &d@����������������������������������������������������������������� 
      procedure compute_delta_move (lastx,lasty,hh,kk) 
        int hh,kk,lastx,lasty 
        int t1,t2,t3,t4 

        getvalue lastx,lasty,hh,kk 

        hh = hh - lastx 
        kk = lasty - kk 

        mtloc = "" 

        if hh < 0 
          hh = 0 - hh 
          mtloc = mtloc // "-" 
        end 
        t1 = hh * 10 * 24          /* in thousands of Postscript units 

        if t1 = 0 
          mtloc = mtloc // "0" 
        else 
          t4 = t1 / 1000 
          t3 = rem 
          if t4 > 0 
            mtloc = mtloc // chs(t4) // "." 
            if t3 < 100 
              mtloc = mtloc // "0" 
            end 
            if t3 < 10 
              mtloc = mtloc // "0" 
            end 
            mtloc = mtloc // chs(t3) 
          else 
            mtloc = mtloc // "0." 
            if t1 < 100 
              mtloc = mtloc // "0" 
            end 
            if t1 < 10 
              mtloc = mtloc // "0" 
            end 
            mtloc = mtloc // chs(t1) 
          end 
        end 

        mtloc = mtloc // " " 

        if kk < 0 
          kk = 0 - kk 
          mtloc = mtloc // "-" 
        end 
        t2 = kk * 10 * 24          /* in thousands of Postscript units 

        if t2 = 0 
          mtloc = mtloc // "0" 
        else 
          t4 = t2 / 1000 
          t3 = rem 
          if t4 > 0 
            mtloc = mtloc // chs(t4) // "." 
            if t3 < 100 
              mtloc = mtloc // "0" 
            end 
            if t3 < 10 
              mtloc = mtloc // "0" 
            end 
            mtloc = mtloc // chs(t3) 
          else 
            mtloc = mtloc // "0." 
            if t2 < 100 
              mtloc = mtloc // "0" 
            end 
            if t2 < 10 
              mtloc = mtloc // "0" 
            end 
            mtloc = mtloc // chs(t2) 
          end 
        end 

      return 
