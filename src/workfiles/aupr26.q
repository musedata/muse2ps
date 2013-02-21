
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 26. settime (t1)                             ³ 
&dA &d@³                                                ³ 
&dA &d@³    Purpose:  Set time signature                ³ 
&dA &d@³                                                ³ 
&dA &d@³    Inputs:    tnum = time numerator            ³ 
&dA &d@³               tden = time denominator          ³ 
&dA &d@³                p   = current x position        ³ 
&dA &d@³               oby  = 0 or 1000 (staff 0 or 1)  ³ 
&dA &d@³               spn  = space node (obj field 7)  ³   &dA01/17/04&d@ 
&dA &d@³                                                ³ 
&dA &d@³    Outputs:   p = new x position               ³ 
&dA &d@³               t1 = amount of empty space       ³ 
&dA &d@³                                                ³ 
&dA &d@³    Internal variables:  t2,t3,t4,t5,t6         ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure settime (t1) 
        int t1,t2,t3,t4,t5,t6 
        int t22 
        str mcode.4 
        label MCDS(17) 

        jcode = tnum * 100 + tden 
        putobjpar = 0 

        t2 = 0   
        if tnum = 1 and tden = 1
          t2 = 1   
        end    
        if tden = 0 
          if tnum = 0 
            t2 = 2 
          else 
            t2 = 3 
            mcode = "****" 
            if tnum > 99 
              mcode = " " // chs(tnum) 
            else 
              if tnum > 10 
                mcode = "  " // chs(tnum) 
              end 
            end 
          end 
          t22 = 0 
          if "  11  12  21  22  31  41  51  61  71  81  91 101 102 103 111 112 121" con mcode
            t22 = (mpt - 1) / 4 + 1     /* 1,2, ...,17 
          end 
        end 
*  
        if (Debugg & 0x06) > 0 
          pute Time = ~tnum :~tden 
        end 
*   set time signature 
        jtype = "T"  
        out = "0"  
        if t2 > 0    
          if t2 < 3 
            obx = p 
            oby += vpar(6) 
            pcode = 1 
            t3 = 36 + t2 
            sobl(1) = "K 0 0 " // chs(t3) 
            perform putobj 
            p += hpar(14) 
            t1 = hpar(14) - hpar(92) 
            oby -= vpar(6) 
          else 
            t1 = hpar(14) 
            obx = p 
            oby += vpar(4) 
            if t22 = 0 
              goto MCDS_END 
            end 
            goto MCDS(t22) 
MCDS(1):                     /* circle 
            pcode = 2 
            sobl(1) = "K 0 0 1011" 
            sobl(2) = "K 0 0 1012" 
            perform putobj 
            p += hpar(14) 
            t1 = hpar(14) - vpar(4) - 3 
            goto MCDS_END 
MCDS(2):                     /* circle w/colon 
            pcode = 4 
            sobl(1) = "K 0 0 1011" 
            sobl(2) = "K 0 0 1012" 
            sobl(3) = "K 0 -" // chs(vpar(95)) // " 1015" 
            sobl(4) = "K 0 " // chs(vpar(95)) // " 1015" 
            perform putobj 
            p += hpar(14) 
            t1 = hpar(14) - vpar(4) - 3 
            goto MCDS_END 
MCDS(3):                     /* circle w/dot 
            pcode = 3 
            sobl(1) = "K 0 0 1011" 
            sobl(2) = "K 0 0 1012" 
            sobl(3) = "K 0 0 1015" 
            perform putobj 
            p += hpar(14) 
            t1 = hpar(14) - vpar(4) - 3 
            goto MCDS_END 
MCDS(4):                     /* circle w/three dots(2+1) 
            pcode = 5 
            sobl(1) = "K 0 0 1011" 
            sobl(2) = "K 0 0 1012" 
            sobl(3) = "K -" // chs(hpar(141)) // " -" // chs(vpar(94)) // " 1015"
            sobl(4) = "K " // chs(hpar(141)) // " -" // chs(vpar(94)) // " 1015"
            sobl(5) = "K 0 " // chs(vpar(95)) // " 1015" 
            perform putobj 
            p += hpar(14) 
            t1 = hpar(14) - vpar(4) - 3 
            goto MCDS_END 
MCDS(5):                     /* circle open to the right 
            pcode = 1 
            sobl(1) = "K 0 0 1012" 
            perform putobj 
            p += hpar(14) 
            t1 = hpar(14) - vpar(4) 
            goto MCDS_END 
MCDS(6):                     /* circle open to the right w/dot 
            pcode = 2 
            sobl(1) = "K 0 0 1012" 
            sobl(2) = "K 0 0 1015" 
            perform putobj 
            p += hpar(14) 
            t1 = hpar(14) - vpar(4) 
            goto MCDS_END 
MCDS(7):                     /* circle open to the left 
            pcode = 1 
            sobl(1) = "K 0 0 1011" 
            perform putobj 
            p += hpar(14) 
            t1 = hpar(14) - vpar(4) - 3 
            goto MCDS_END 
MCDS(8):                     /* circle open to the right w/cut 
            pcode = 1 
            sobl(1) = "K 0 0 1013" 
            perform putobj 
            p += hpar(14) 
            t1 = hpar(14) - vpar(4) 
            goto MCDS_END 
MCDS(9):                     /* circle open to the right, followed by "2" 
            pcode = 2 
            sobl(1) = "K 0 0 1012" 
            sobl(2) = "K " // chs(hpar(142)) // " 0 1016" 
            perform putobj 
            p += (hpar(14) + vpar(3)) 
            t1 = hpar(14) - hpar(142) 
            goto MCDS_END 
MCDS(10):                    /* circle, followed by "2" 
            pcode = 3 
            sobl(1) = "K 0 0 1011" 
            sobl(2) = "K 0 0 1012" 
            sobl(3) = "K " // chs(hpar(142)) // " 0 1016" 
            perform putobj 
            p += (hpar(14) + vpar(3)) 
            t1 = hpar(14) - hpar(142) 
            goto MCDS_END 
MCDS(11):                    /* circle w/cut 
            pcode = 2 
            sobl(1) = "K 0 0 1011" 
            sobl(2) = "K 0 0 1013" 
            perform putobj 
            p += hpar(14) 
            t1 = hpar(14) - vpar(4) 
            goto MCDS_END 
MCDS(12):                    /* circle open to the right w/cut, followed by "3"
            pcode = 2 
            sobl(1) = "K 0 0 1013" 
            sobl(2) = "K " // chs(hpar(142)) // " 0 1017" 
            perform putobj 
            p += (hpar(14) + vpar(3)) 
            t1 = hpar(14) - hpar(142) 
            goto MCDS_END 
MCDS(13):                    /* simple "3" 
            pcode = 1 
            sobl(1) = "K 0 0 1017" 
            perform putobj 
            p += hpar(14) 
            t1 = hpar(14) - vpar(3) 
            goto MCDS_END 
MCDS(14):                    /* "3" over "2" 
            pcode = 1 
            sobl(1) = "K 0 0 1018" 
            perform putobj 
            p += hpar(14) 
            t1 = hpar(14) - vpar(3) 
            goto MCDS_END 
MCDS(15):                    /* circle open to the right w/cut, followed by "2"
            pcode = 2 
            sobl(1) = "K 0 0 1013" 
            sobl(2) = "K " // chs(hpar(142)) // " 0 1016" 
            perform putobj 
            p += (hpar(14) + vpar(3)) 
            t1 = hpar(14) - hpar(142) 
            goto MCDS_END 
MCDS(16):                    /* simple "2" 
            pcode = 1 
            sobl(1) = "K 0 0 1016" 
            perform putobj 
            p += hpar(14) 
            t1 = hpar(14) - vpar(3) 
            goto MCDS_END 
MCDS(17):                    /* concentric circles 
            pcode = 1 
            sobl(1) = "K 0 0 1014" 
            perform putobj 
            p += hpar(14) 
            t1 = hpar(14) - vpar(3) 
            goto MCDS_END 
MCDS_END: 
            oby -= vpar(4) 
          end 
        else   
          t6 = p + hpar(16) 
          if tden < 10 and tnum < 10
            t6 = p + hpar(17) 
          end  
*  
          obx = t6 
*  
          y = vpar(4) + oby 
          t3 = tnum 
          t4 = obx 
          perform number (t3,t4) 
          t5 = t4 
          y = vpar(8) + oby 
          t3 = tden 
          t4 = obx 
          perform number (t3,t4) 
          pcode = sobcnt 
          perform putobj 
          if t4 > t5 
            t4 = t5 
          end  
          p = t4 + hpar(18) 
          t1 = hpar(18) 
        end  
        passback t1 
      return
