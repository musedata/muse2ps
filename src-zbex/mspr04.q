
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³M*  4. clefkey                                                       ³ 
&dA &d@³                                                                     ³ 
&dA &d@³    Purpose:  Create object entries for clef, key and time signature ³ 
&dA &d@³                                                                     ³ 
&dA &d@³    Operation: Also typeset measure number.                          ³ 
&dA &d@³               Also typeset a mark object object for an ending       ³ 
&dA &d@³                 superobject, if the ending starts at the beginning  ³ 
&dA &d@³                 of the line.  The flag for this is the variable     ³ 
&dA &d@³                 supernum.  If this is positive, then this is the    ³ 
&dA &d@³                 superobject number of the ending superobject.       ³ 
&dA &d@³                                                     New &dA05/06/08&d@    ³ 
&dA &d@³                                                                     ³ 
&dA &d@³    Inputs:    Staff locations: (sp,sq(.))                           ³ 
&dA &d@³               Clef code:  mclef(.,.)                                ³ 
&dA &d@³               Key code:   mkey(.)                                   ³ 
&dA &d@³               Time code:  savtcode(.)                               ³ 
&dA &d@³                                                                     ³ 
&dA &d@³    Internal variables: t1 ... t9                                    ³ 
&dA &d@³                                                                     ³ 
&dA &d@³      Clef is defined as a two dimensional array,                    ³ 
&dA &d@³      and if f(f12,12) = 2 then the clef, key, and                   ³ 
&dA &d@³      maybe the time signature need to be duplicated                 ³ 
&dA &d@³      on the auxiliary staff.                                        ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure clefkey  
        str tline.180 
        str line2.80 
        int t1,t2,t3,t4,t5,t6,t7,t8,t9 
        int tenor 
        int clef_obx                /* New &dA10/08/08&d@ 

        obx = hxpar(10) 
&dA 
&dA &d@    1) clef 
&dA 
        if lbyte = "l"              /* New condition &dA12/18/05&d@ 
          goto NO_CLEF 
        end 

        t1 = 0 
        loop for t2 = 1 to 2        /* &dLmax 2 staves at this time&d@ 
          a1 = mclef(f12,t2) / 10 
          a2 = rem 
          t6 = a1 / 3 
          t7 = rem 
          if t7 = 0 
            z = 33 
          else 
            z = 34 + t7 
          end 
          oby = a2 - 1 * notesize + t1 

          clef_obx = obx            /* New &dA10/08/08&d@ 

          if t7 = 0 
            t8 = 2 
            if t6 = 1 
              t8 = 3 
            end 
            if justflag < 2 
              ++mainyp 
              tput [Y,mainyp] J C ~mclef(f12,t2)  ~obx  ~oby  ~t8  6913 0 0 
              ++mainyp 
              tput [Y,mainyp] K 0 0 33 
              ++mainyp 
              tput [Y,mainyp] K 0 0 34 
              if t6 = 1 
                ++mainyp 
                tput [Y,mainyp] K ~mhpar(f12,5)  ~mvpar(f12,15)  234 
              end 
            end 
          else 
            if justflag < 2 
              ++mainyp 
              tput [Y,mainyp] J C ~mclef(f12,t2)  ~obx  ~oby  ~z  6913 0 0 
            end 
          end 
          if f(f12,12) <> 2 
            t2 = 100 
          else 
            t1 = vst(f12) 
          end 
        repeat 
NO_CLEF: 
        obx = obx + mhpar(f12,15) 
&dA 
&dA &d@    2) key signature  
&dA 
        t9 = obx   
        t6 = abs(mkey(f12))  
        t1 = 0 
        loop for t2 = 1 to 2        /* &dLmax 2 staves at this time&d@ 
          tenor = 0 
          if mclef(f12,t2) = 12 
            tenor = 1 
          end 

          if justflag < 2 
            ++mainyp 
            tput [Y,mainyp] J K ~mkey(f12)  ~obx  ~t1  ~t6  6913 0 0 
          end 
          if t6 > 0 
            a1 = mclef(f12,t2) / 10 
            t3 = rem - 1 * 2          /* t3 (vertical position) measured in line numbers
            a1 /= 3 
            a2 = 2 - rem * 3      
            t3 -= a2 
            x = 0 
&dA &d@   sharps 
            if mkey(f12) > 0 
              loop for t5 = 1 to t6 
                if tenor = 0 or t3 >= 0 
                  y = t3 + 20 * notesize / 2 - mvpar20(f12) 
                else 
                  y = t3 + 27 * notesize / 2 - mvpar20(f12)   /* exception for tenor clef
                end 
                if justflag < 2 
                  ++mainyp 
                  tput [Y,mainyp] K ~x  ~y  63 
                end 
                t3 += zak(1,t5) 
                x += mhpar(f12,6) 
              repeat 
            end 
&dA &d@   flats  
            if mkey(f12) < 0 
              t3 += 4 
              loop for t5 = 1 to t6 
                y = t3 + 20 * notesize / 2 - mvpar20(f12) 
                if justflag < 2 
                  ++mainyp 
                  tput [Y,mainyp] K ~x  ~y  65 
                end 
                t3 += zak(2,t5) 
                x += mhpar(f12,7) 
              repeat 
            end 
          end 
          if f(f12,12) <> 2 
            t2 = 100 
          else 
            t1 = vst(f12) 
          end 
        repeat 
&dA &d@      
&dA &d@    3) write time change  
&dA 
        obx = tplace 
        t8 = obx   
&dA 
&dA &d@  deal with time directive or segno thrown to new line  
&dA 
        if dxoff(f12) < 10000 
          rec = drec(f12) 
          perform save3                 /* oby not used here 
          if jtype <> "D" 
            tmess = 62 
            perform dtalk (tmess) 
          end 
          if z < 33 
            if f12 = 1 
              if justflag < 2 
                ++mainyp 
                tput [Y,mainyp] J D 0 ~obx  0 1 6913 0 0 
              end 
              ++rec 
              tget [Z,rec] line 
              lpt = 3 
              tline = txt(line,[' '],lpt) 
              x = int(tline) + dxoff(f12) 
              tline = txt(line,[' '],lpt) 
              y = int(tline) + dyoff(f12) 
              line = line{lpt+1..} 
              if justflag < 2 
                ++mainyp 
                tput [Y,mainyp] W ~x  ~y  ~line 
              end 
            end 
          else 
            if justflag < 2 
              if bit(2,ntype) = 1 and f12 = 1 
                x = t9 + dxoff(f12) 
                y = dyoff(f12) 
                ++mainyp 
                tput [Y,mainyp] J D 0 ~x  ~y  ~z  6913 0 0 
              end  
              if bit(3,ntype) = 1 and f12 = f11 
                x = t9 + dxoff(f12) 
                y = dyoff(f12) 
                ++mainyp 
                tput [Y,mainyp] J D 0 ~x  ~y  ~z  6913 0 0 
              end  
            end 
          end  
          dxoff(f12) = 10000 
        end  
&dA 
&dA &d@  write time change, if present 
&dA 
        if savtcode(f12) < 10000   
          a1 = savtcode(f12) / 100   
          a2 = rem 
          t6 = 0   
          if a1 = 1 and a2 = 1 
            t6 = 1 
          end 
          if a1 = 0 and a2 = 0 
            t6 = 2 
          end 
          if t6 > 0 
            obx = obx + mhpar(f12,13) 
            y = mvpar(f12,6) 
            z = 36 + t6 
            if justflag < 2 
              ++mainyp 
              tput [Y,mainyp] J T ~savtcode(f12)  ~obx  ~y  ~z  6913 0 0 
            end 
            if f(f12,12) = 2 
              y += vst(f12) 
              if justflag < 2 
                ++mainyp 
                tput [Y,mainyp] J T ~savtcode(f12)  ~obx  ~y  ~z  6913 0 0 
              end 
            end 
          else 
            obx = t8 + mhpar(f12,21)  
            t6 = 4 
            if a2 < 10   
              t6 = 3 
              if a1 < 10   
                obx = t8 + mhpar(f12,22)  
              end  
            end  
            if a1 < 10 
              --t6 
            end  
            if justflag < 2 
              ++mainyp 
              tput [Y,mainyp] J T ~savtcode(f12)  ~obx  0 ~t6  6913 0 0 
            end 
            y = mvpar(f12,4) 
            perform msk_number (a1) 
            y = mvpar(f12,8) 
            perform msk_number (a2) 

            if f(f12,12) = 2 
              if justflag < 2 
                ++mainyp 
                tput [Y,mainyp] J T ~savtcode(f12)  ~obx  ~vst(f12)  ~t6  6913 0 0
              end 
              y = mvpar(f12,4) 
              perform msk_number (a1) 
              y = mvpar(f12,8) 
              perform msk_number (a2) 
            end 

          end  
          obx = obx + mhpar(f12,19) 
        end  
&dA 
&dA &d@    4) write measure number   
&dA &d@      
        if f12 = 1 or f12 > 0            /* f12 > 0 added &dA01/06/04&d@ (dummy boolean TRUE) 
          t2 = M_NUM_FONT                /* font number moved to #define &dA01/06/04
          perform spacepar (t2) 
          if f12 > 1                     /* this also added &dA01/06/04&d@; creates dummy
            t2 = 0                       /*   measure numbers, which "come to life" only
          end                            /*   when top staff line(s) is/are removed.
          ++sys_count 
          mnum = oldbarnum               /* measure number for first measure in this system
          line = chs(oldbarnum)  
          line2 = "" 
          loop for t4 = 1 to len(line)  
            line2 = line2 // "\0" // line{t4} 
          repeat 
          t1 = spc(48+128)               /* space for small numbers 
          t1 = len(line) - 1 * t1 
          x = clef_obx - t1              /* New &dA10/08/08&d@ 
          y = 0 - mvpar(f12,2) 
          if justflag < 2 
            ++mainyp 
            tput [Y,mainyp] J D 0 ~x  ~y  1 6913 0 0 
            ++mainyp 
            tput [Y,mainyp] W 0 0 ~t2  ~line2 
          end 
        end  
&dA 
&dA &d@    5) put down mark for ending superobject, if supernum > 0  New &dA05/06/08&d@ 
&dA 
        t8 = hxpar(8) - sp - mvpar(f12,3) 
        if supernum > 0 
          if justflag < 2 
            ++mainyp 
            tput [Y,mainyp] J D 0 ~t8  0 0 6913 0 1 ~supernum 
          end 
        end 
        supernum = 0 

      return 
