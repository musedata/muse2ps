
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 37. move_to_loc (hh,kk)                                     ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose: construct a Postscript moveto entry from          ³ 
&dA &d@³                PCL coordinates                                ³ 
&dA &d@³                                                               ³ 
&dA &d@³   Input:  hh     x location                                   ³ 
&dA &d@³           kk     y location                                   ³ 
&dA &d@³                                                               ³ 
&dA &d@³   Output  string mtloc                                        ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure move_to_loc (hh,kk)                          
        int t1,t2,t3,t4 
        int hh,kk 

        getvalue hh,kk 

        hh += 50                  /* magic number 
        t1 = hh * 10 * 24         /* in thousands of Postscript units 

        t3 = 3150 - kk            /* also a magic number 
        t2 = t3 * 10 * 24 

        mtloc = "" 
        if t1 < 0 
          mtloc = mtloc // "-" 
          t1 = 0 - t1 
        end 
        t4 = t1 / 1000 
        t3 = rem 
        mtloc = mtloc // chs(t4) // "." 
        if t3 < 100 
          mtloc = mtloc // "0" 
        end 
        if t3 < 10 
          mtloc = mtloc // "0" 
        end 
        mtloc = mtloc // chs(t3) 

        mtloc = mtloc // " " 

        if t2 < 0 
          mtloc = mtloc // "-" 
          t2 = 0 - t2 
        end 
        t4 = t2 / 1000 
        t3 = rem 
        mtloc = mtloc // chs(t4) // "." 
        if t3 < 100 
          mtloc = mtloc // "0" 
        end 
        if t3 < 10 
          mtloc = mtloc // "0" 
        end 
        mtloc = mtloc // chs(t3) 

        mtloc = mtloc // " moveto" 

      return 
