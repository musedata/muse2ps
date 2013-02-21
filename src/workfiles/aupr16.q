
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 16. putobj                                                        ³ 
&dA &d@³                                                                     ³ 
&dA &d@³    Purpose:  write object and sub-objects to intermediate list      ³ 
&dA &d@³                                                                     ³ 
&dA &d@³    Inputs:  jtype = object type (field 2)                           ³ 
&dA &d@³             jcode = object code (field 3)                           ³ 
&dA &d@³             obx   = object offset from staff x-position (field 4)   ³ 
&dA &d@³             oby   = object offset form staff y-position (field 5)   ³ 
&dA &d@³             pcode = print code (field 6) (or sobl counter)          ³ 
&dA &d@³             spn   = space node (field 7)                            ³ 
&dA &d@³             inctype = increment type for next node with a new spn   ³ 
&dA &d@³             out     = fields 9 --                                   ³ 
&dA &d@³             temp3   = occationally temp3 is used in place of        ³ 
&dA &d@³                         sobl(1) when there is only 1 subobject      ³ 
&dA &d@³             sobl()  = subobject line                                ³ 
&dA &d@³             c1,c2   = pointer to first and last elements in         ³ 
&dA &d@³                         ts(.,.) array for this object               ³ 
&dA &d@³                                                                     ³ 
&dA &d@³             putobjpar = parameters modifying operation of putobj    ³ 
&dA &d@³                                                                     ³ 
&dA &d@³                putobjpar & 0x01 = control    0 = no modifications   ³ 
&dA &d@³                                                    in this byte     ³ 
&dA &d@³                                              1 = possible mods in   ³ 
&dA &d@³                                                    this byte        ³ 
&dA &d@³                                                                     ³ 
&dA &d@³                putobjpar & 0x06 = blank flag 0 = no blanking        ³ 
&dA &d@³                                              2 = blank all sub-obj  ³ 
&dA &d@³                                              4 = replace all sub-obj³           
&dA &d@³                                                    with one         ³ 
&dA &d@³                                                    extension dot    ³ 
&dA &d@³                                                                     ³ 
&dA &d@³                putobjpar & 0xf0 = (four) various flags              ³ 
&dA &d@³                  For Notes, Grace Notes, Cue Notes ("NGQ" con jtype)³ 
&dA &d@³                                           0x10 = stem present       ³ 
&dA &d@³                                                   0 = no stem       ³ 
&dA &d@³                                                   1 = stem          ³ 
&dA &d@³                                           0x20 = stem direction     ³ 
&dA &d@³                                                   0 = UP            ³ 
&dA &d@³                                                   1 = DOWN          ³ 
&dA &d@³                                           0x40 = note/chord         ³ 
&dA &d@³                                                   0 = single note   ³ 
&dA &d@³                                                   1 = chord         ³ 
&dA &d@³                                                                     ³ 
&dA &d@³                                                                     ³ 
&dA &d@³                putobjpar & 0x00ff00   = x position data + 128       ³ 
&dA &d@³                                          (in tenths of notesize)    ³ 
&dA &d@³                                         0 = no data                 ³ 
&dA &d@³                                                                     ³ 
&dA &d@³                putobjpar & 0xff0000   = y position data + 128       ³ 
&dA &d@³                                          (in tenths of notesize)    ³ 
&dA &d@³                                         0 = no data                 ³ 
&dA &d@³                                                                     ³ 
&dA &d@³                putobjpar & 0xff000000 = position data flags         ³ 
&dA &d@³                                                                     ³ 
&dA &d@³                                  0x01 = data active flag            ³ 
&dA &d@³                                  0x02 = x data flag                 ³ 
&dA &d@³                                         1 = x location relative to  ³ 
&dA &d@³                                             obx                     ³ 
&dA &d@³                                         0 = modification to         ³ 
&dA &d@³                                             x location as calculated³ 
&dA &d@³                                  0x04 = y data flag                 ³ 
&dA &d@³                                         1 = y location on staff     ³ 
&dA &d@³                                         0 = modification to         ³ 
&dA &d@³                                             y location as calculated³ 
&dA &d@³                                                                     ³ 
&dA &d@³             fix_next_inctype = static variable initialized at BIG,  ³  New &dA01/19/04
&dA &d@³                                  set and used only by putobj.       ³ 
&dA &d@³                                Variable provides a means for putobj ³ 
&dA &d@³                                to "remember" when it has altered an ³ 
&dA &d@³                                inctype, and a way to "add back" any ³ 
&dA &d@³                                amount taken away.                   ³ 
&dA &d@³                                                                     ³ 
&dA &d@³    Outputs: sobcnt set to 0                                         ³ 
&dA &d@³             supcnt set to 0                                         ³ 
&dA &d@³                                                                     ³ 
&dA &d@³    Internal variable:  oldspn = spn from previous object            ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure putobj 
        str temp.180,super.180 
        str params.30(20) 
        int oldspn,t 
        int t1,t2,t3,t4,t5,t6,t8,t9 
        int s1,s2,s3,s4,s5,s6,s7,s8,s9 
        int stem,chord 
        int high,low,highpoint,lowpoint 
        int highstem,lowstem,stemlength 
        int nflags,slash,pcnt 
        int grflag 
&dA 
&dA &d@    This code added &dA01/19/04&d@ to fix the accumulation of inctypes 
&dA 
        if fix_next_inctype > 0 and inctype > 0          
          if (Debugg & 0x06) > 0 
            pute Program Warning: 
            pute     Attempting to adjust the next Inctype from ~inctype  ...
          end 
          inctype -= fix_next_inctype 
          if inctype < 0 
            inctype = 0 
          end 
          if (Debugg & 0x06) > 0 
            pute to ~inctype 
          end 
          fix_next_inctype = 0 
        end 
&dA   

&dA 
&dA &d@       New Code &dA09/14/03&d@ 
&dA &d@       ----------------- 
&dA &d@       If jtype = "I", then inctype may need to be recalculated from the ts(.) array
&dA 
        if jtype = "I" and a1 > 1 
          t3 = 10000 
          loop for t1 = a1 - 1 to 1 step -1 
            t2 = ts(t1,DIV) 
            if t2 < ts(a1,DIV) 
              t3 = ts(a1,DIV) - t2 * 576 / divspq 
              t1 = 1 
            end 
          repeat 

          if t3 <> 10000 and t3 <> inctype 
            if (Debugg & 0x06) > 0 
              pute Program Caution:  Inctype for "I" type object changed from ~inctype  to  ~t3
            end 
            fix_next_inctype = t3 - inctype      /* fix_next_inctype set &dA01/19/04
            inctype = t3 
          end 
        end 

        t = inctype 
        if t <> 10000 and t <> 10001             /* 10001 added &dA01/03/04&d@ 
          if spn = oldspn 
            t = 0 
          end 
          if spn = 1 
            t = 0 
          end 
        end 
        stem = 0 
        if "NGQ" con jtype and jcode < WHOLE 
          stem = putobjpar & 0xf0 
          stem >>= 4 
          putobjpar &= 0xffffff0f                /* strip stem codes from putobjpar
        end 
&dA 
&dA &d@    Determine: t1 = final obx   as modified by print suggestions 
&dA &d@               t2 = final oby                                       &dA05/02/03
&dA 
        px = putobjpar >> 8   & 0xff 
        py = putobjpar >> 16  & 0xff 
        if px > 0 
          px = px - 128 * notesize / 10 
        end 
        t1 = obx + px 
        if py > 0 
          py = py - 128 * notesize / 10 
          t4 = putobjpar >> 24  & 0xff 
          if bit(2,t4) = 1 
            t2 = py 
            if oby > 700 
              t2 += 1000 
            end 
          else 
            t2 = oby + py 
          end 
        else 
          t2 = oby 
        end 
&dA 
&dA &d@    If putobjpar & 0x01 = 1, then we are dealing with certain rennaisance notation
&dA &d@      which allows a note duration to extend beyond a bar line.  In this case,
&dA &d@      the note beyond the barline may be blanked entirely (putobjpar & 0x02 = 1),
&dA &d@      or it may be replaced with an extension dot (putobjpar & 0x04 = 1).  
&dA 
        if (bit(0,putobjpar)) = 1 
          putobjpar &= 0xff 
          t3 = pcode 
          t4 = putobjpar >> 1 
          if t4 = 1 or t4 = 2 
            if t3 > 0 and t3 < 32 
              if sobl(1) = "" 
                t3 = 0 
              else 
                t6 = 0 
                if t4 = 2 
                  ++t6 
                  t8 = t2 / vpar(2) 
                  if rem = 0 
                    t8 = vpar(1) - notesize 
                  else 
                    t8 = 0 
                  end 

                  t9 = DOT_CHAR 
                  sobl(t6) = "K 0 " // chs(t8) // " " // chs(t9) 
                end 
                loop for t5 = 1 to t3 
                  if sobl(t5){1} = "A" 
                    ++t6 
                    sobl(t6) = sobl(t5) 
                  end 
                repeat 
                t3 = t6 
              end 
            end 
          end 
        else 
          t3 = pcode 
        end 

        ++outpnt 
&dA 
&dA &d@     &dA11/20/06&d@  This code added for special case of a slur terminating 
&dA &d@               on a non-printed note.  
&dA 
        if jtype = "N" and jcode = 0 
          t3 = 0 
        end 
&dA                 &d@ End of &dA11/20/06&d@ addition 

        tput [Y,outpnt] J ~jtype  ~jcode  ~t1  ~t2  ~t3  ~spn  ~t  ~out 
&dA 
&dA &d@    Look for marks that could be incorporated with this object 
&dA 
        super = "" 
        if jtype = "N" 
          tget [Y,outpnt-1] temp .t5 s1 s2 s3 s4 s5 s6 s7 s8 
          if temp{1} = "H" 
            super = temp 
            tget [Y,outpnt-2] temp .t5 s1 s2 s3 s4 s5 s6 s7 s8 
          end 
          if temp{1,3} = "J M" and s2 = t1 and s5 = spn and s7 = 1 
            if super = "" 
              --outpnt 
            else 
              outpnt -= 2 
            end 
            out = trm(out) 
            out = out // " " 
            s9 = int(out) 
            ++s9 
            out = chs(s9) // out{sub..} // chs(s8) 
            t = s6 
            tput [Y,outpnt] J ~jtype  ~jcode  ~t1  ~t2  ~t3  ~spn  ~t  ~out 
          else 
            super = "" 
          end 
        end 

        oldspn = spn 
        if t3 > 0 and t3 < 32 
          if sobl(1) = "" 
            ++outpnt 
            tput [Y,outpnt] ~temp3 
          else 
            loop for sobcnt = 1 to t3 
              ++outpnt 
              tput [Y,outpnt] ~sobl(sobcnt) 
            repeat 
          end 
        end 
        sobcnt = 0 
        supcnt = 0 
        if super <> "" 
          ++outpnt 
          tput [Y,outpnt] ~super 
        end 
      return 
