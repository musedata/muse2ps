
&dA &d@���������������������������������������������������������������������Ŀ 
&dA &d@�P* 16. putobj                                                        � 
&dA &d@�                                                                     � 
&dA &d@�    Purpose:  write object and sub-objects to intermediate list      � 
&dA &d@�                                                                     � 
&dA &d@�    Inputs:  jtype = object type (field 2)                           � 
&dA &d@�             jcode = object code (field 3)                           � 
&dA &d@�             obx   = object offset from staff x-position (field 4)   � 
&dA &d@�             oby   = object offset form staff y-position (field 5)   � 
&dA &d@�             pcode = print code (field 6) (or sobl counter)          � 
&dA &d@�             spn   = space node (field 7)                            � 
&dA &d@�             inctype = increment type for next node with a new spn   � 
&dA &d@�             out     = fields 9 --                                   � 
&dA &d@�             temp3   = occationally temp3 is used in place of        � 
&dA &d@�                         sobl(1) when there is only 1 subobject      � 
&dA &d@�             sobl()  = subobject line                                � 
&dA &d@�             c1,c2   = pointer to first and last elements in         � 
&dA &d@�                         ts(.,.) array for this object               � 
&dA &d@�                                                                     � 
&dA &d@�             putobjpar = parameters modifying operation of putobj    � 
&dA &d@�                                                                     � 
&dA &d@�                putobjpar & 0x01 = control    0 = no modifications   � 
&dA &d@�                                                    in this byte     � 
&dA &d@�                                              1 = possible mods in   � 
&dA &d@�                                                    this byte        � 
&dA &d@�                                                                     � 
&dA &d@�                putobjpar & 0x06 = blank flag 0 = no blanking        � 
&dA &d@�                                              2 = blank all sub-obj  � 
&dA &d@�                                              4 = replace all sub-obj�           
&dA &d@�                                                    with one         � 
&dA &d@�                                                    extension dot    � 
&dA &d@�                                                                     � 
&dA &d@�                putobjpar & 0xf0 = (four) various flags              � 
&dA &d@�                  For Notes, Grace Notes, Cue Notes ("NGQ" con jtype)� 
&dA &d@�                                           0x10 = stem present       � 
&dA &d@�                                                   0 = no stem       � 
&dA &d@�                                                   1 = stem          � 
&dA &d@�                                           0x20 = stem direction     � 
&dA &d@�                                                   0 = UP            � 
&dA &d@�                                                   1 = DOWN          � 
&dA &d@�                                           0x40 = note/chord         � 
&dA &d@�                                                   0 = single note   � 
&dA &d@�                                                   1 = chord         � 
&dA &d@�                                                                     � 
&dA &d@�                                                                     � 
&dA &d@�                putobjpar & 0x00ff00   = x position data + 128       � 
&dA &d@�                                          (in tenths of notesize)    � 
&dA &d@�                                         0 = no data                 � 
&dA &d@�                                                                     � 
&dA &d@�                putobjpar & 0xff0000   = y position data + 128       � 
&dA &d@�                                          (in tenths of notesize)    � 
&dA &d@�                                         0 = no data                 � 
&dA &d@�                                                                     � 
&dA &d@�                putobjpar & 0xff000000 = position data flags         � 
&dA &d@�                                                                     � 
&dA &d@�                                  0x01 = data active flag            � 
&dA &d@�                                  0x02 = x data flag                 � 
&dA &d@�                                         1 = x location relative to  � 
&dA &d@�                                             obx                     � 
&dA &d@�                                         0 = modification to         � 
&dA &d@�                                             x location as calculated� 
&dA &d@�                                  0x04 = y data flag                 � 
&dA &d@�                                         1 = y location on staff     � 
&dA &d@�                                         0 = modification to         � 
&dA &d@�                                             y location as calculated� 
&dA &d@�                                                                     � 
&dA &d@�             fix_next_inctype = static variable initialized at BIG,  �  New &dA01/19/04
&dA &d@�                                  set and used only by putobj.       � 
&dA &d@�                                Variable provides a means for putobj � 
&dA &d@�                                to "remember" when it has altered an � 
&dA &d@�                                inctype, and a way to "add back" any � 
&dA &d@�                                amount taken away.                   � 
&dA &d@�                                                                     � 
&dA &d@�    Outputs: sobcnt set to 0                                         � 
&dA &d@�             supcnt set to 0                                         � 
&dA &d@�                                                                     � 
&dA &d@�    Internal variable:  oldspn = spn from previous object            � 
&dA &d@����������������������������������������������������������������������� 
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
