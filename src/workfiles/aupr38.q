
&dA &d@����������������������������������������������������������������Ŀ 
&dA &d@�P* 38. setarpeggio  (New &dA01/13/06&d@)                              � 
&dA &d@�                                                                � 
&dA &d@�    Purpose:  write object arpeggio                             � 
&dA &d@�                                                                � 
&dA &d@�    Inputs:  c1           = pointer into set array for arpeggio � 
&dA &d@�             obx          = horizontal position of arpeggio     � 
&dA &d@�             ntype        = ARPEGGIO                            � 
&dA &d@�             passnum      = pass number for this arpeggio       � 
&dA &d@�             inctype      = increment type for next node        � 
&dA &d@�                              with a new spn (used in putobj)   � 
&dA &d@�                                                                � 
&dA &d@������������������������������������������������������������������ 
      procedure setarpeggio  
        int arpeg_flag 
        int arpeg_top 
        int arpeg_bottom 
        int t1,t2,t3,t4

        arpeg_flag   = ts(c1,ARPEG_FLAG) 
        arpeg_top    = ts(c1,ARPEG_TOP) 
        arpeg_bottom = ts(c1,ARPEG_BOTTOM) 

        t3 = ts(c1,STAFF_NUM) * 1000 
        oby = arpeg_top * 2 - 1 * vpar(2) / 2 
        sobcnt = 0 

        x = obx  
        y = oby  

        t1 = arpeg_bottom * 2 - 1 * vpar(2) / 2 
        if arpeg_flag > 0 
          t1 += arpeg_flag 
        end 

        z = 120                                 /* music font for arpeggio 
        perform subj 

        t2 = t1 - vpar(4) 
        loop while y <= t2 
          perform subj 
          y += vpar(4) 
        repeat 
        y -= vpar(2) 
        if y <= t2 
          perform subj 
        end 

        jtype = "G"  
        jcode = EIGHTH 
        out = "0"  
&dA 
&dA &d@    Duration attribute of arpeggio 
&dA 
        ++sobcnt
        sobl(sobcnt) = "A D 1 8"

        pcode = sobcnt 
        oby += t3 
        putobjpar = 0 

        t4 = ts(c1,TSR_POINT) 
        pcontrol = ors(tsr(t4){1})                      /* &dA05/02/03&d@ 
        px = ors(tsr(t4){3}) << 8 
        py = ors(tsr(t4){4}) << 16 
        t1 = ors(tsr(t4){2}) << 24 
        putobjpar = t1 + px + py + pcontrol             /* Note: order of data has been changed

        perform putobj                    
        oby -= t3 
      return 
