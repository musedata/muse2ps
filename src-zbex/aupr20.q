
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 20. setmrest (mrest, wrest)                                  ³ 
&dA &d@³                                                                ³ 
&dA &d@³    Purpose:  Set multiple rests and terminating bar line       ³ 
&dA &d@³                                                                ³ 
&dA &d@³    Inputs:     p = horizontal starting point                   ³ 
&dA &d@³            mrest = number of rests to set                      ³ 
&dA &d@³          measnum = measure number for terminating bar line     ³ 
&dA &d@³            wrest = optional type 7 whole rest flag (&dA01/03/04&d@)  ³ 
&dA &d@³how_much_mrest(2) = divspq, divspm                              ³ 
&dA &d@³                                                                ³ 
&dA &d@³    Outputs:    p = new horizontal point                        ³ 
&dA &d@³                                                                ³ 
&dA &d@³    Operation: For multiple rests we need to communicate        ³ 
&dA &d@³                 P7 = rest's rhythmic duration                  ³ 
&dA &d@³                                                                ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure setmrest (mrest, wrest) 
        str temp.80 
        int t1,t2,t3,t4,t5,t6 
        int mrest,wrest 

        getvalue mrest,wrest 

        putobjpar = 0 
        if mrest > 1   
          p += hpar(22) 
          obx = p  
          oby = vpar(3)  
          x = obx  
          y = oby  
          z = 62 
          perform subj 
          y = oby + vpar(11) 
          perform subj 
          z = 92 
          x = obx  
          y = vpar(4)  
          loop for t1 = 1 to 3  
            perform subj 
            x += 30 
            p += 30 
          repeat 
          y = oby  
          z = 62 
          perform subj 
          y = oby + vpar(11) 
          perform subj 
          t6 = p - 45 
          t5 = mrest  

&dA          &d@ Slight code modification &dA11/18/08&d@ 
&dA 
&dA &d@     In the case of musical parts, for notesize 21 anyway, I think 
&dA &d@     the number above a multiple rest is easier to read if it is 2 dots 
&dA &d@     above the middle line.  Admittedly, this is a magic number at the 
&dA &d@     moment.  
&dA 
          if notesize = 21 
            y = vpar(4) - 2 
          else 
            y = vpar(4) 
          end 
&dA 
&dA          

          perform number (t5,t6)   /* t6 is returned, but is not needed here
          jtype = "S"  
          jcode = 4    
          out = "0"  
          pcode = sobcnt 
          spn = mrest  

          perform putobj 
          p += hpar(23) 

          t1 = 1                /* New &dA10/29/08&d@: 1 was the old value for J B (field 8)

        else   
          obx = p + hpar(24) 
          oby = vpar(4)  
          ++outpnt 
          if wrest = 1 
            tput [Y,outpnt] J R 9 ~obx  ~oby  46 1 10001 0 
          else 
            tput [Y,outpnt] J R 9 ~obx  ~oby  46 1 10000 0 
          end 
          p += hpar(25) 

&dA                  &d@  New &dA10/29/08&d@ 
&dA 
&dA &d@       We need to try to compute a J B (field 8) value that mirrors 
&dA &d@       the expected distance increment flag in a normal measure.  
&dA &d@       We will use the data in: how_much_mrest(2) = divspq, divspm 
&dA 
          t1 = 576 * how_much_mrest(2) / how_much_mrest(1) 
&dA 
&dA                  

        end  
        obx = p + hpar(36) 
&dA 
&dA &d@     &dA03/07/06&d@    Adding capability of setmrest to set "mdotted", "mdouble",
&dA &d@                 "mheavy2", "mheavy3", in addition to "measure".  No repeat dots,
&dA &d@                 endings, or other signs are allowed here.  
&dA 
        if mrest_line{2,6} = "easure" 
          ++outpnt                                       
          tput [Y,outpnt] J B ~measnum  ~obx  1 82 6913 ~t1  0
          p = obx + hpar(37) 
        end 
        if mrest_line{2,6} = "dotted" 
          ++outpnt 
          tput [Y,outpnt] J B ~measnum  ~obx  3 86 6913 ~t1  0
          p = obx + hpar(37) 
        end 
&dA 
&dA &d@     hpar(44) = actual white space between two light lines 
&dA &d@     hpar(45) = actual white space between heavy/light, light/heavy and heavy/heavy combinations
&dA &d@     hpar(79) = thickness of light line 
&dA &d@     hpar(81) = thickness of heavy line 
&dA 
        if mrest_line{2,6} = "double" 
          t2 = hpar(44) + hpar(79) 
          t4 = obx + t2 
          ++outpnt 
          tput [Y,outpnt] J B ~measnum  ~t4  5 2 6913 ~t1  0
          ++outpnt 
          tput [Y,outpnt] K -~t2  0 82 
          ++outpnt 
          tput [Y,outpnt] K 0 0 82 
          p = t4 + hpar(37)
        end 
        if mrest_line{2,6} = "heavy3" 
          t2 = hpar(45) + hpar(81) 
          ++outpnt 
          tput [Y,outpnt] J B ~measnum  ~obx  9 2 6913 ~t1  0
          ++outpnt 
          tput [Y,outpnt] K 0 0 84 
          ++outpnt 
          tput [Y,outpnt] K ~t2  0 82 
          p = obx + hpar(37) + t2 
        end 
        if mrest_line{2,6} = "heavy2" 
          t2 = hpar(45) + hpar(81) + hpar(79) - 1 
          t3 = hpar(81) - 1 
          t4 = obx + t2 
          ++outpnt 
          tput [Y,outpnt] J B ~measnum  ~t4  6 2 6913 ~t1  0
          ++outpnt 
          tput [Y,outpnt] K -~t2  0 82 
          ++outpnt 
          tput [Y,outpnt] K -~t3  0 84 
          p = t4 + hpar(37)
        end 

        loop for t5 = 1 to MAX_STAFF 
          loop for t6 = 1 to 45 
            emptyspace(t5,t6) = hpar(37) 
          repeat 
        repeat 
      return 
