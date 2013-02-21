
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P*  5. setstem                                                        ³ 
&dA &d@³                                                                      ³ 
&dA &d@³    Purpose:  Generate subobjects for note stem, or construct         ³ 
&dA &d@³              beamdata parameters for setting beam.  When beam        ³ 
&dA &d@³              is complete, this procedure will call guessbeam.        ³ 
&dA &d@³                                                                      ³ 
&dA &d@³    Inputs:      stem = stem direction  (0=UP, 1=DOWN)                ³ 
&dA &d@³                ntype = type of note                                  ³ 
&dA &d@³             passtype = type of pass (reg,cue,grace,cuegrace)         ³ 
&dA &d@³             passsize = size of notes (full size vs. cue-size)        ³ 
&dA &d@³              passnum = pass number                                   ³ 
&dA &d@³                  obx = x co-ordinate of object                       ³ 
&dA &d@³                  oby = y co-ordinate of object                       ³ 
&dA &d@³                   c1 = pointer to top note head in array             ³ 
&dA &d@³                   c2 = pointer to bottom note head in array          ³ 
&dA &d@³                   c3 = pointer to note head at top of stem           ³ 
&dA &d@³           super_flag = composite of SUPER_FLAGs for this chord       ³ 
&dA &d@³           color_flag = put out stems in color  (&dA12/21/10&d@)            ³ 
&dA &d@³                                                                      ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure setstem  
        str temp.80 
        int t2,t3,t4,t5,t11,t12,t13,t14,t15 
        int bcount,note_style 
&dA 
&dA &d@      Determine note style (New &dA01/08/11&d@) 
&dA 
        note_style = ts(c1,SUBFLAG_1) & 0x8000 
        note_style >>= 15 
&dA 
&dA &d@      Determine number of repeaters in "single note" case 
&dA 
        t11 = 0 
        if ts(c1,BEAM_FLAG) = NO_BEAM and ts(c1,BEAM_CODE) > 0 
          t12 = ts(c1,BEAM_CODE) 
          loop 
            t12 /= 10 
            ++t11 
          repeat while t12 > 0 
        end 

        if ntype >= WHOLE 
          if t11 > 0 
            y = ts(c1,STAFFLOC) - vpar(3) 
            z = 127 
            loop for t12 = 1 to t11 
              if color_flag > 0 
                perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
              else 
                perform subj 
              end 
              y -= vpar(2) 
            repeat 
          end 
          if ntype > BREVE 
            z = 60 
            y = oby 
            if ntype = LONGA 
              x = obx + hpar(143) 
            else 
              x = obx + hpar(144) 
            end 
            if stem = 1 
              if color_flag > 0
                perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
              else 
                perform subj 
              end 
              y += vpar(2) 
              if color_flag > 0
                perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
              else 
                perform subj 
              end 
            else 
              y -= vpar(4) 
              if color_flag > 0
                perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
              else 
                perform subj 
              end 
              y -= vpar(2) 
              if color_flag > 0
                perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
              else 
                perform subj 
              end 
            end 
          end 
        else               
          x = obx  
          if note_style = 0               /* New &dA01/08/11&d@ 
            z = 59 + stem                 /* music font 
            if passsize = CUESIZE 
              z += 128                    /* music font 
            end 
          else 
            z = 1009                      /* music font 
          end 
&dA 
&dA &d@  Connect notes of chord 
&dA 
          if c1 <> c2 
            if stem = UP 
              y = ts(c2,STAFFLOC) 
              loop while y > ts(c1,STAFFLOC) 
                if color_flag > 4 
                  perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                else 
                  perform subj 
                end 
                y -= vpar(4) 
              repeat 
            else 
              y = ts(c1,STAFFLOC) 
              loop while y < ts(c2,STAFFLOC) 
                if color_flag > 4 
                  perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                else 
                  perform subj 
                end 
                y += vpar(4) 
              repeat 
            end  
          end 
          y = ts(c3,STAFFLOC)  
          if ntype > EIGHTH
&dA 
&dA &d@  Quarter notes and larger  
&dA 
&dA &d@      First deal with square/diamond notation   &dA01/08/11&d@ 
&dA 
            if note_style = 1 
              y = oby - vpar(1) 
              z = 1009 
              if color_flag > 4 
                perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
              else 
                perform subj 
              end 
              return 
            end 
&dA      
            if ts(c1,BEAM_FLAG) = NO_BEAM

              c16 = y + vpar20 * 2 + 1 / vpar(2) - 20 
              t3 = c16 + 2 

              if stem = UP 
                if t11 = 0 
                  t2 = 8 
                  if t3 <= 0 
                    t2 = t3 - 3 
                  else 
                    if t3 < 7 
                      t2 = t3 - 4 
                    else 
                      if t3 < 13 
                        t2 = t3 - 5 
                      end 
                    end 
                    if passsize = CUESIZE 
                      ++t2 
                    end 
                  end 
                  t2 = t2 + 20 * vpar(2) / 2 - vpar20 

                else 
                  t13 = y / notesize 
                  t14 = rem 
                  if t14 = 0 
                    t15 = 3                       /* tricky code 
                  else 
                    t15 = 2 
                  end 
                  t2 = y - vpar(t15) - vpar(79) 
                  loop for t13 = t15 to t11 
                    t2 -= vpar(2) 
                  repeat 
                  t12 = vpar(77) + vpar(6) 
                  if t2 > t12 
                    t2 = t12 
                  end 
                  if t14 <> 0 and t11 = 1 
                    t14 = y 
                    y = t2 - vpar(80) 
                    if color_flag > 4 
                      perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                    else 
                      perform subj 
                    end 
                    y = t14 
                  end 
                end 
&dA    
&dA &d@          Raise bottom of stem if percussion note head  &dA02/19/06&d@ 
&dA 
                t13 = ts(c1,SUBFLAG_1) & 0xf00000 
                if t13 > 0 
                  t13 >>= 20 
                  if t13 = 1 
                    y -= (vpar(1) - 1) 
                  end 
                end 
&dA    
                loop while y > t2 
                  if color_flag > 4 
                    perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                  else 
                    perform subj 
                  end 
                  y -= vpar(4) 
                repeat 
                y = t2 
                if color_flag > 4 
                  perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                else 
                  perform subj 
                end 
                if t11 > 0 
                  y -= vpar(81) 
                  if ts(c1,TUPLE) > 0 
&dA 
&dA &d@            New &dA11/05/05&d@  Convert tuple to 1000 * n1 + n2 
&dA 
                    t13 = ts(c1,TUPLE) & 0xffff 
                    t14 = t13 >> 8 
                    t13 &= 0xff 
                    t14 *= 1000 
                    t13 += t14 
&dA         
                    t14 = x + hpar(102) 
                    t15 = y - vpar(82) 
                    perform typeset_tuple (t13,t14,t15) 
                  end 
                  z = 125                       /* music font (repeater quarters)
                  loop for t2 = 1 to t11 
                    if color_flag > 4 
                      perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                    else 
                      perform subj 
                    end 
                    y += vpar(2) 
                  repeat 
                end 
              else 
                if t11 = 0 
                  t2 = 0 
                  if t3 > 11 
                    t2 = t3 - 1 
                  else 
                    if t3 > 6 
                      t2 = t3 
                    else 
                      if t3 >= 0 
                        t2 = t3 + 1 
                      end 
                    end 
                    if passsize = CUESIZE 
                      --t2 
                    end 
                  end 
                  t2 = t2 * notesize / 2 
                else 
                  t13 = y / notesize 
                  t14 = rem 
                  if t14 = 0 
                    t15 = 3                       /* tricky code 
                  else 
                    t15 = 2 
                  end 
                  t2 = y + vpar(t15) + vpar(79) 
                  loop for t13 = t15 to t11 
                    t2 += vpar(2) 
                  repeat 
                  t12 = vpar(78) - vpar(4) 
                  if t2 < t12 
                    t2 = t12 
                  end 
                  if t14 <> 0 and t11 = 1 
                    t14 = y 
                    y = t2 + vpar(80) 
                    if color_flag > 4 
                      perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                    else 
                      perform subj 
                    end 
                    y = t14 
                  end 
                end 
&dA 
&dA &d@     Adding code (&dA12/10/03&d@) to decrease down stem for music with text for notes
&dA &d@       where note is on middle line of staff or one step above that.  
&dA 
                t15 = ts(c3,TEXT_INDEX) 
                if t15 > 0 
                  temp = trm(tsdata(t15)) 
                  if temp <> "" 
                    t13 = ts(c3,STAFFLOC) 
                    t14 = notesize << 1 
                    t15 = notesize + 1 
                    if t13 <= t14 and t13 > t15 
                      t2 -= (notesize >> 1) 
                    end 
                  end 
                end 
&dA   

&dA    
&dA &d@          Lower top of stem if percussion note head  &dA02/19/06&d@ 
&dA 
                t13 = ts(c1,SUBFLAG_1) & 0xf00000 
                if t13 > 0 
                  t13 >>= 20 
                  if t13 = 1 
                    y += (vpar(1) - 1) 
                  end 
                end 
&dA    
                loop while y < t2 
                  if color_flag > 4 
                    perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                  else 
                    perform subj 
                  end 
                  y += vpar(4) 
                repeat 
                y = t2 
                if color_flag > 4 
                  perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                else 
                  perform subj 
                end 
                if t11 > 0 
                  if ts(c1,TUPLE) > 0 
&dA 
&dA &d@            New &dA11/05/05&d@  Convert tuple to 1000 * n1 + n2 
&dA 
                    t13 = ts(c1,TUPLE) & 0xffff 
                    t14 = t13 >> 8 
                    t13 &= 0xff 
                    t14 *= 1000 
                    t13 += t14 
&dA         
                    t14 = x + hpar(103) 
                    t15 = ts(c1,STAFFLOC) - vpar(82) 
                    perform typeset_tuple (t13,t14,t15) 
                  end 
                  y += vpar(81) 
                  z = 125                       /* music font (repeater quarters)
                  x -= hpar(101) 
                  loop for t2 = 1 to t11 
                    if color_flag > 4 
                      perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                    else 
                      perform subj 
                    end 
                    y -= vpar(2) 
                  repeat 
                  x += hpar(101) 
                end 
              end 
            else 
*   2) Beams 
              if ts(c1,BEAM_FLAG) = START_BEAM
                bcount = 1 
                ++snum
                beampar(passtype,passnum,BM_SNUM) = snum 
                if bit(4,super_flag) = 1 
                  beampar(passtype,passnum,BM_TUPLE) = 1 + stem 
                end  
                beampar(passtype,passnum,BM_STEM) = stem 
                beampar(passtype,passnum,BM_SIZE) = passsize 

                t2 = ts(c1,TSR_POINT)               /* New code &dA05/14/03&d@ 
                t3 = 28                             /* 28 = code for beam suggestion
                ++t3 
                t3 <<= 2                            /* 116 
                py = ors(tsr(t2){t3-2}) 
                t4 = 0 
                if py > 0 
                  py = py - 128
                  if py > 0 
                    t4 = INT100 * py 
                  else 
                    py = 0 - py 
                    t4 = INT100 * INT100 * py 
                  end 
                end                                               
                beampar(passtype,passnum,BM_SUGG) = t4   /* End new code &dA05/14/03

              else 
                bcount = beampar(passtype,passnum,BM_CNT) + 1 
                beampar(passtype,passnum,BM_STEM) <<= 1 
                beampar(passtype,passnum,BM_STEM) += stem 
                if passsize < beampar(passtype,passnum,BM_SIZE) 
                  beampar(passtype,passnum,BM_SIZE) = passsize 
                end 
              end  
              beamdata(passtype,passnum,bcount) = ts(c1,BEAM_CODE)  
              beampar(passtype,passnum,BM_CNT) = bcount 
              if ts(c1,BEAM_FLAG) = END_BEAM
                beampar(passtype,passnum,BM_READY) = bcount 
              end  
              beampar(passtype,passnum,BM_COLOR) |= color_flag    /* New &dA12/21/10
            end  
          else 
&dA 
&dA &d@  Eighth notes or smaller 
&dA 
            if ts(c1,BEAM_FLAG) = NO_BEAM
*   1) Flags   
&dA 
&dA &d@      First deal with square/diamond notation   &dA01/08/11&d@ 
&dA 
              if note_style = 1 
                z = 1010 
                if ntype = EIGHTH 
                  y = oby - vpar(1) 
                  if color_flag > 4 
                    perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                  else 
                    perform subj 
                  end 
                  return 
                end 
                if ntype = SIXTEENTH 
                  t3 = vpar(1) * 3 / 7 
                  y = oby - t3      
                  if color_flag > 4 
                    perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                  else 
                    perform subj 
                  end 
                  t3 = vpar(1) * 10 / 7 
                  y = oby - t3      
                  if color_flag > 4 
                    perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                  else 
                    perform subj 
                  end 
                  return 
                end 
              end 
&dA      
              if passtype = GRACE and ntype = SLASH8 
                if stem = UP 
                  z = 179                   /* music font 
                else 
                  z = 180                   /* music font 
                end 
                y = ts(c3,STAFFLOC) 
                if color_flag > 4 
                  perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                else 
                  perform subj 
                end 
              else 
                if stem = UP 
                  if ntype = EIGHTH 
                    t3 = 53                 /* music font (eighth flag) 
                    if y <= vpar(4) and passtype = REG and t11 = 0 
                      t3 = 51             /* music font (shortened eighth flag)
                    end 
                    t2 = 10 * notesize / 2 
                  else 
                    t3 = 55                 /* music font (sixteenth flag) 
                    t2 = 0 - ntype * 2 + 20 * notesize / 2 
                  end 
                  z = 59                    /* music font (standard up stem) 
                  t4 = notesize 
                  t5 = 57                   /* music font (extra flag: 32nds, etc)
                  if passsize = CUESIZE 
                    t2 -= vpar(1) 
                    t3 += 128               /* music font 
                    z += 128                /* music font 
                    t4 = vpar(36) 
                    t5 += 128               /* music font 
                  end 
                  loop while y > t2 
                    if color_flag > 4 
                      perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                    else 
                      perform subj 
                    end 
                    y -= vpar(4) 
                  repeat 
                  c16 = t2 * 2 / vpar(2) 
                  if rem <> 0 
                    ++t2 
                  end 
                  t2 += vpar(1) 

                  y = ts(c3,STAFFLOC) 
                  if t11 = 0                /* no repeaters 
                    z = t3                  /* music font (flag character) 
                    if y > t2 
                      y = t2 
                    end 
                    if color_flag > 4 
                      perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                    else 
                      perform subj 
                    end 
                    if ntype < 5 
                      z = t5                  /* music font (extra flag) 
                      loop for t3 = 1 to 5-ntype 
                        y -= t4 
                        if color_flag > 4 
                          perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                        else 
                          perform subj 
                        end 
                      repeat 
                    end 
                  else 
                    t12 = y / notesize 
                    t2 += t11 - 1 * notesize 
                    if y > t2 or rem <> 0       /* note on space 
                      t13 = t11 - 1 * notesize + vpar(67)             
                      t14 = vpar(69)   
                    else                        /* note on line 
                      t13 = t11 - 1 * notesize + vpar(68)            
                      t14 = vpar(70)   
                    end 
&dA 
&dA &d@       t13 = amount to "lengthen" stem 
&dA &d@       t14 = location of first repeater 
&dA 
                    if y > t2 
                      y = t2 
                    end 
                    t15 = y 
                    loop 
                      if color_flag > 4 
                        perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                      else 
                        perform subj 
                      end 
                      y -= vpar(4) 
                    repeat while y > t15 - t13 
                    y = t15 - t13 
                    z = t3 
                    if color_flag > 4 
                      perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                    else 
                      perform subj 
                    end 
                    if ntype < 5 
                      z = t5                  /* music font (extra flag) 
                      loop for t3 = 1 to 5-ntype 
                        y -= t4 
                        if color_flag > 4 
                          perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                        else 
                          perform subj 
                        end 
                      repeat 
                    end 
                    y = t15 - t14 
                    z = 126                   /* music font (repeater for eights)
                    x = x - hpar(99)   
                    loop for t12 = 1 to t11 
                      if color_flag > 4 
                        perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                      else 
                        perform subj 
                      end 
                      y -= notesize 
                    repeat 
                    x = x + hpar(99)  
                    if ts(c1,TUPLE) > 0 
&dA 
&dA &d@              New &dA11/05/05&d@  Convert tuple to 1000 * n1 + n2 
&dA 
                      t13 = ts(c1,TUPLE) & 0xffff 
                      t14 = t13 >> 8 
                      t13 &= 0xff 
                      t14 *= 1000 
                      t13 += t14 
&dA         
                      t14 = x + hpar(102)  
                      t15 = y - vpar(83) 
                      perform typeset_tuple (t13,t14,t15) 
                    end 
                  end 
                else 
                  if ntype = EIGHTH 
                    t3 = 54                 /* music font (eighth flag) 
                    if y >= vpar(5) and passtype = REG and t11 = 0 
                      t3 = 52               /* music font (shortened eighth flag)
                    end 
                    t2 = 0 - 2 * notesize / 2 
                  else 
                    t3 = 56                 /* music font (sixteenth flag) 
                    t2 = 2 * ntype - 12 * notesize / 2 
                  end 
                  z = 60                    /* music font (standard down stem) 
                  t4 = notesize 
                  t5 = 58                   /* music font (extra flag) 
                  if passsize = CUESIZE 
                    t2 += vpar(1) 
                    t3 += 128               /* music font 
                    z += 128                /* music font 
                    t4 = vpar(36) 
                    t5 += 128               /* music font 
                  end 
                  loop while y < t2 
                    if color_flag > 4 
                      perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                    else 
                      perform subj 
                    end 
                    y += vpar(4) 
                  repeat 
                  t2 -= vpar(1) 
                  c16 = t2 * 2 / vpar(2) 
                  if rem <> 0 
                    --t2 
                  end 

                  y = ts(c3,STAFFLOC) 
                  if t11 = 0 
                    z = t3                    /* music font (flag character) 
                    if y < t2 
                      y = t2 
                    end 
                    if color_flag > 4 
                      perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                    else 
                      perform subj 
                    end 
                    if ntype < 5 
                      z = t5                  /* music font 
                      loop for t3 = 1 to 5-ntype 
                        y += t4 
                        if color_flag > 4 
                          perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                        else 
                          perform subj 
                        end 
                      repeat 
                    end 
                  else 
                    t12 = y / notesize 
                    t2 -= t11 - 1 * notesize 
                    if y < t2 or rem <> 0     /* note on space 
                      if t11 = 2 
                        t13 = notesize - vpar(71)
                      else 
                        t13 = t11 - 1 * notesize - vpar(72)
                      end 
                      t14 = vpar(75)
                    else                      /* note on line 
                      if t11 = 2 
                        t13 = notesize - vpar(73)
                      else 
                        t13 = t11 - 1 * notesize - vpar(74)
                      end 
                      t14 = vpar(76)
                    end 
&dA 
&dA &d@       t13 = amount to "lengthen" stem 
&dA &d@       t14 = location of first repeater 
&dA 
                    if y < t2 
                      y = t2 
                    end 
                    t15 = y 
                    loop 
                      if color_flag > 4 
                        perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                      else 
                        perform subj 
                      end 
                      y += vpar(4) 
                    repeat while y < t15 + t13 
                    y = t15 + t13 
                    z = t3 
                    if color_flag > 4 
                      perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                    else 
                      perform subj 
                    end 
                    if ntype < 5 
                      z = t5                  /* music font (extra flag) 
                      loop for t3 = 1 to 5-ntype 
                        y += t4 
                        if color_flag > 4 
                          perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                        else 
                          perform subj 
                        end 
                      repeat 
                    end 
                    y = t15 + t14 
                    z = 126                   /* music font (repeater for eights)
                    x = x - hpar(100) 
                    loop for t12 = 1 to t11 
                      if color_flag > 4 
                        perform subj3 (color_flag)     /* New &dA12/21/10&d@ 
                      else 
                        perform subj 
                      end 
                      y += notesize 
                    repeat 
                    x = x + hpar(100) 
                    if ts(c1,TUPLE) > 0 
&dA 
&dA &d@              New &dA11/05/05&d@  Convert tuple to 1000 * n1 + n2 
&dA 
                      t13 = ts(c1,TUPLE) & 0xffff 
                      t14 = t13 >> 8 
                      t13 &= 0xff 
                      t14 *= 1000 
                      t13 += t14 
&dA         
                      t14 = x + hpar(103)  
                      t15 = ts(c1,STAFFLOC) - vpar(82)
                      perform typeset_tuple (t13,t14,t15) 
                    end 
                  end 
                end 
              end 
            else 
*   2) Beams 
              if ts(c1,BEAM_FLAG) = START_BEAM
                bcount = 1 
                ++snum
                beampar(passtype,passnum,BM_SNUM) = snum 
                if bit(4,super_flag) = 1 
                  beampar(passtype,passnum,BM_TUPLE) = 1 + stem 
                end  
                beampar(passtype,passnum,BM_STEM) = stem 
                beampar(passtype,passnum,BM_SIZE) = passsize 

                t2 = ts(c1,TSR_POINT)               /* New code &dA05/14/03&d@ 
                t3 = 28                             /* 28 = code for beam suggestion
                ++t3 
                t3 <<= 2                            /* 116 
                py = ors(tsr(t2){t3-2}) 
                t4 = 0 
                if py > 0 
                  py = py - 128
                  if py > 0 
                    t4 = INT100 * py 
                  else 
                    py = 0 - py 
                    t4 = INT100 * INT100 * py 
                  end 
                end                                               
                beampar(passtype,passnum,BM_SUGG) = t4   /* End new code &dA05/14/03

              else 
                bcount = beampar(passtype,passnum,BM_CNT) + 1 
                beampar(passtype,passnum,BM_STEM) <<= 1 
                beampar(passtype,passnum,BM_STEM) += stem 
                if passsize < beampar(passtype,passnum,BM_SIZE) 
                  beampar(passtype,passnum,BM_SIZE) = passsize 
                end 
              end  
              beamdata(passtype,passnum,bcount) = ts(c1,BEAM_CODE)  
              beampar(passtype,passnum,BM_CNT) = bcount 
              if ts(c1,BEAM_FLAG) = END_BEAM
                beampar(passtype,passnum,BM_READY) = bcount 
              end  
              beampar(passtype,passnum,BM_COLOR) |= color_flag    /* New &dA12/21/10
            end  
          end  
        end  
      return 
