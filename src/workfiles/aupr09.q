
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P*  9. setperf (operates on an entire chord at once)                ³ 
&dA &d@³                                                                    ³ 
&dA &d@³    Purpose:  create sub-objects for turns, trills, shakes,         ³ 
&dA &d@³              mordents, horizontal accents, thumb positions,        ³ 
&dA &d@³              open string, numbers, harmonics, down-bows,           ³ 
&dA &d@³              up-bows, fermatas. (and tremulos as of &dA01/07/06&d@)      ³ 
&dA &d@³                                                                    ³ 
&dA &d@³    Inputs:    obx = x-position of object                           ³ 
&dA &d@³               oby = y-position of object                           ³ 
&dA &d@³                c1 = pointer to top of chord                        ³ 
&dA &d@³                c2 = pointer bottom of chord                        ³ 
&dA &d@³                c4 = virtual vertical position of controlling       ³ 
&dA &d@³                         note head                                  ³ 
&dA &d@³                c5 = virtual vertical position of end of stem       ³ 
&dA &d@³                c8 = slur present flag                              ³ 
&dA &d@³                                     0 = not present (usually)      ³ 
&dA &d@³                                     1 = present at head            ³ 
&dA &d@³                                     2 = present at stem            ³ 
&dA &d@³              stem = stem direction  0 = up                         ³ 
&dA &d@³                                     1 = down                       ³ 
&dA &d@³        super_flag = composite of SUPER_FLAGs for this chord        ³ 
&dA &d@³        color_flag = put out articulations in color  (&dA12/21/10&d@)     ³ 
&dA &d@³                                                                    ³ 
&dA &d@³    Operation:  If multi-track > 0, put indications at the stem     ³ 
&dA &d@³                  end of the chord;                                 ³ 
&dA &d@³                else, put indications above the chord               ³ 
&dA &d@³                                                                    ³ 
&dA &d@³    Internal: c4,c5,c7,c9,c13 used to communicate with yadjust      ³ 
&dA &d@³                                                                    ³ 
&dA &d@³    &dA04-08-97&d@ Modification.                                          ³ 
&dA &d@³                                                                    ³ 
&dA &d@³    It turns out that for turns, trill, shakes, and mordents,       ³ 
&dA &d@³                 and tremulos, as of &dA01/07/06&d@,                      ³ 
&dA &d@³    we want to allow multiple ornaments on a chord.  Therefore,     ³ 
&dA &d@³    these ornaments need to be processed individually, and not      ³ 
&dA &d@³    grouped, as are accents, numbers, up and down bows, fermatas,   ³ 
&dA &d@³    etc.                                                            ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                                                                    ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure setperf  
        str temp.100                             /* &dA04/24/03&d@ 
        bstr bs.600,bt.600 
        int t1,t2,t3,t4,t5,t7,t8,t9,t10 
        int subflag_1,subflag_2 
        int ed_subflag_1,ed_subflag_2            /* New variables &dA05/17/03&d@ 
        int merged_subflag_1,merged_subflag_2 
        int lsqx,rsqx,sqy,glyph,sq_glyph 
        int sugg_flg3(MAX_OBJECTS)                         /* New &dA12/21/10&d@ 
&dA 
&dA &d@   1. Determine placement: c7 = situation flag: 0 = place on note head 
&dA &d@                                                1 = place on stem 
&dA 
        if ts(c1,MULTI_TRACK) >> 2 > 0 
          c7 = 1 
        else 
          c7 = 1 - stem 
        end 
&dA 
&dA &d@   2. Long trill 
&dA 
        if super_flag & 0x06 > 0          /* if begin ~~~~~ 
          subflag_1 = 0 
          loop for t8 = c1 to c2            /* loop added &dA11/05/05&d@ to accomodate all ornaments
            subflag_1 = subflag_1 | ts(t8,SUBFLAG_1)           /* on notes of a chord
          repeat 

          t5 = ts(c1,PASSNUM) 
          ++snum
          pre_tsnum(t5) = snum 
          ++supcnt 
          supnums(supcnt) = snum 
          c13 = vpar(53) 
          pre_ctrarrf(t5) = bit(2,super_flag)     /* tr. trill 
          if pre_ctrarrf(t5) = 0 
            c13 = vpar(51) 
          end 

          if pre_ctrarrf(t5) = 1         /* tr. present 
            t3 = subflag_1 & 0x70 >> 4   /* t3 = 0 to 7 (&dA05/17/03&d@ editorial not supported yet)
            t3 = int("01312311"{t3+1}) 
            pre_ctrarrf(t5) += t3 
            if subflag_1 & 0x80000 > 0   /* bit 19 is set &dA11/05/05&d@ 
              pre_ctrarrf(t5) += 3       /* add 3 to R super-object parameter 4
            end 
          end 

          ++pre_ctrarrf(t5) 
          perform yadjust 
          pre_try(t5) = y - oby 
                                  /* Code added &dA02/24/97&d@ 
          t2 = 4                        /* ornament code = 4 
          perform getpxpy (t2,c1) 
          
          if pyy > 0 
            pre_try(t5) = py 
          else 
            pre_try(t5) += py 
          end 
                                  /* End of &dA02/24/97&d@ addition 
        else 
&dA 
&dA &d@   3. Back ties (sub-objects)  New code &dA04/22/08&d@ 
&dA 
&dA &d@      Note: Back ties are handled like ornaments.  This means that a note with
&dA &d@            a back tie can have at most one ornament attached to it.  Limitation??
&dA 
          loop for t8 = c1 to c2            /* New code &dA12/21/10&d@ 
            sugg_flg3(t8) = 0 
          repeat 

          loop for t8 = c1 to c2            /* loop accomodates back ties on all chord notes
            subflag_1 = ts(t8,SUBFLAG_1)
            t5 = subflag_1 & 0x03000000     /*  000000&dE11&d@ 00000000 00000000 00000000
            if t5 > 0                       
              t2 = 4 + sugg_flg3(t8)        /* ornament code = 4  New variable &dA12/21/10
              if sugg_flg3(t8) = 0          /* New code &dA12/21/10&d@ 
                ++sugg_flg3(t8) 
              end 

              x = obx - vpar(4) 
              t5 >>= 24 
              if t5 = 1                     /* overhand back tie 
                y = 0 - vpar(2) 
                z = 2036                    /* overhand tie character 
              else 
                y = vpar(2) 
                z = 2164                    /* underhand tie charachter 
              end 
              y += oby 

              perform getpxpy (t2,t8) 

              x += px 
              if pyy > 0 
                py -= y 
                pyy = 0 
              end 
              y += py 
              perform subj                  /* this feature not implemented in autoscr yet
            end 
          repeat 
&dA 
&dA &d@   4+5. Ornaments and their accidentals need to be handled together 
&dA 
&dA &d@      New code rewrite &dA05/17/03&d@ to accommodate editorial ornaments and their accidentals
&dA 
          loop for t8 = c1 to c2            /* loop added &dA04-08-97&d@ to accomodate all ornaments
            subflag_1 = ts(t8,SUBFLAG_1)                       /* on notes of a chord
            subflag_2 = ts(t8,SUBFLAG_2) 
            ed_subflag_1 = ts(t8,ED_SUBFLAG_1)
            ed_subflag_2 = ts(t8,ED_SUBFLAG_2) 
            merged_subflag_1 = subflag_1 | ed_subflag_1 
            merged_subflag_2 = subflag_2 | ed_subflag_2 

            t5 = merged_subflag_1 & 0x0f             /* turn,tr,shake,mordent, etc.
            if t5 > 0 and t5 < 7                     /* &dA6 ornaments&d@ as of &dA01/07/06
&dA 
&dA &d@      Raise (lower) turn, if slur and turn are present on note head 
&dA 
              color_flag = subflag_1 >> 28 
              if c7 = 0 and c8 = 1 
                if t5 = 1                   /* turn 
                  if stem = UP 
                    c16 = c4 * 2 / vpar(2) 
                    if rem <> 0 
                      ++c4 
                    end 
                    c4 += vpar(1) 
                  else 
                    c4 -= vpar(1) 
                    c16 = c4 * 2 / vpar(2) 
                    if rem <> 0 
                      --c4 
                    end 
                  end 
                end 
              end 
&dA 
&dA &d@     a. We must know definitively whether ornament goes above or below notes, 
&dA &d@          and we must determine whether there is an "intervening" accidental.  
&dA 
              t7 = c7                       /* save c7 
              t2 = 4 + sugg_flg3(t8)        /* ornament code = 4   New variable &dA12/21/10
              if sugg_flg3(t8) = 0          /* New code &dA12/21/10&d@ 
                ++sugg_flg3(t8) 
              end 
              perform getpxpy (t2,t8) 

              if bit(0,pcontrol) = 1 
                if bit(1,pcontrol) = 1 
                  if bit(2,pcontrol) = 0 
                    c7 = 1 - stem 
                  else 
                    c7 = stem 
                  end 
                end 
              end 
              t1 = c7 + stem                /* t1 = 1 means ornament goes above

              t2 = 0 
              t3 = merged_subflag_1 & 0x3f0 >> 4 
              t9 = ed_subflag_1 & 0x3f0 >> 4 
              t10 = 0                       /* 0 will mean actual, as opposed to editorial
              if t3 > 0 
                if t1 = 1 
                  if t3 > 7                 /* ax under on ornament above 
                    t2 = 1 
                    if t9 > 7 
                      t10 = 1               /* and this is editorial 
                    end 
                  end 
                else 
                  if t3 & 0x07 > 0          /* ax over on ornament below 
                    t2 = 2 
                    if t9 & 0x07 > 0 
                      t10 = 1               /* and this is editorial 
                    end 
                  end 
                end 
              end 
              if t2 > 0                     /* put accidental first 
                if t2 = 1 
                  t4 = t3 >> 3 
                else 
                  t4 = t3 & 0x07 
                end 
                c13 = vpar(56) 
                perform yadjust 
                if c9 <> 1 
                  y -= vpar(1) 
                  c16 = y * 2 / vpar(2) 
                  if rem <> 0 
                    --y 
                  end 
                end 
                x = obx 
                if t2 = 1 and (t5 = 1 or t5 = 5) 
                  x += hpar(70) 
                end 
                x += px 
                if pyy > 0 
                  py -= y 
                  pyy = 0 
                end 
                y += py 
&dA 
&dA &d@           Deal with case where ornament is real, but accidental is editorial
&dA 
                if subflag_1 & 0x0f > 0 and t10 = 1 
                  x -= hpar(124) 
                  y -= vpar(86) 
                  z = 244                         /* open square bracket 
                  perform subj 
                  x += hpar(124) 
                  y += vpar(86) 
                end 
&dA 
&dA &d@           Put out "first" accidental 
&dA 
                z = int("39389"{t4})              /* music font 
                z += 210                          /* music font 
                if color_flag > 4 
                  perform subj3 (color_flag)    /* New &dA12/21/10&d@ 
                else 
                  perform subj 
                end 
                if t4 < 3 
                  z = int("39"{t4})                 /* music font 
                  x += hpar(z+67)                   /* hpar(70) or hpar(76) 
                  z += 210                          /* music font 
                  if t2 = 1 and (t5 = 1 or t5 = 5) 
                    x += hpar(70) 
                  end 
                  if color_flag > 4 
                    perform subj3 (color_flag)    /* New &dA12/21/10&d@ 
                  else 
                    perform subj 
                  end 
                end 
&dA 
&dA &d@           Deal with case where ornament is real, but accidental is editorial
&dA 
                if subflag_1 & 0x0f > 0 and t10 = 1 
                  x += hpar(125) 
                  y -= vpar(86) 
                  z = 245                         /* close square bracket 
                  perform subj 
                end 
              end 
&dA 
&dA &d@     b. Now put out turn, tr., shake, mordent, delayed turn 
&dA &d@           tremulo added &dA01/07/06&d@ (primary only) 
&dA 
              t3 = t5 
              if c3 = 5 
                c3 = 1 
              end 
              c13 = 51 + t3 
              c13 = vpar(c13) 
&dA &d@                                   &dA01/07/06&d@ for tremulos 
              if t3 = 6 
                c13 = vpar(4) 
              end 
&dA    
              perform yadjust 
              if c9 <> 1 
                y -= vpar(1) 
                c16 = y * 2 / vpar(2) 
                if rem <> 0 
                  --y 
                end 
              end 
              x = obx 
              x += px 
              if pyy > 0 
                py -= y 
                pyy = 0 
              end 
              y += py 
&dA 
&dA &d@           Deal with case where ornament is editorial 
&dA 
              if ed_subflag_1 & 0x0f > 0 
                if t3 = 1 or t3 = 5          /* turn and delayed turn 
                  lsqx  = hpar(126) 
                  rsqx  = hpar(127) 
                  sqy   = vpar(87) 
                  glyph = 242                /* turn ornament 
                  sq_glyph = 244             /* small square bracket 
                else 
                  if t3 = 2                  /* tr. trill 
&dA 
&dA &d@      Conditional code added &dA02/04/04&d@ to implement Roman editorial trills 
&dA 
#if ROMAN_EDIT 
                    ++sobcnt 
                    sobx = x - obx 
                    soby = y - oby 
                    sobl(sobcnt) = "W " // chs(sobx) // " " // chs(soby) // " "
                    sobl(sobcnt) = sobl(sobcnt) // "31 tr" 
                    goto SETP01 
&dA   
#else 
                    lsqx  = hpar(122) 
                    rsqx  = hpar(123) 
                    sqy   = vpar(85) 
                    glyph = 254              /* editorial trill ornament 
                    sq_glyph = 195           /* cue square bracket 
#endif 
                  else 
                    if t3 = 3                /* shake 
                      lsqx  = hpar(128) 
                      rsqx  = hpar(129) 
                      sqy   = vpar(88) 
                      glyph = 239            /* shake ornament              
                      sq_glyph = 244         /* small square bracket 
                    else                     /* mordant 
                      lsqx  = hpar(130) 
                      rsqx  = hpar(131) 
                      sqy   = vpar(89) 
                      glyph = 238            /* mordant ornament 
                      sq_glyph = 244         /* small square bracket 
                    end 
                  end 
                end 
                x -= lsqx 
                y -= sqy 
                z = sq_glyph                      /* open square bracket 
                perform subj 
                x += lsqx 
                y += sqy 
                z = glyph 
                perform subj 
                x += rsqx 
                y -= sqy 
                z = sq_glyph + 1                  /* close square bracket 
                perform subj 
              else 
&dA 
&dA &d@           Deal with case where ornament is primary  
&dA 
&dA &d@           &dA01/07/06&d@  Adding code to deal with tremulo ornament (T) 
&dA 
                if t3 < 6 
                  z = int("71437"{t3})       /* music font 
                  z += 235                   /* music font 
                  if color_flag > 4 
                    perform subj3 (color_flag)    /* New &dA12/21/10&d@ 
                  else 
                    perform subj 
                  end 
                else 
                  c16 = y 
                  z = 127 
                  if color_flag > 4 
                    perform subj3 (color_flag)    /* New &dA12/21/10&d@ 
                  else 
                    perform subj 
                  end 
                  y -= vpar(3) / 2 
                  if color_flag > 4 
                    perform subj3 (color_flag)    /* New &dA12/21/10&d@ 
                  else 
                    perform subj 
                  end 
                  y -= vpar(3) / 2 
                  if color_flag > 4 
                    perform subj3 (color_flag)    /* New &dA12/21/10&d@ 
                  else 
                    perform subj 
                  end 
                  y = c16 
                end 
              end 
&dA 
&dA &d@     c. Put out remaining accidentals above or below notes.  
&dA 
SETP01: 
                                          /* t1 = 1 means ornament goes above 
              t2 = 0 
              t3 = merged_subflag_1 & 0x3f0 >> 4 
              t9 = ed_subflag_1 & 0x3f0 >> 4 
              t10 = 0                       /* 0 will mean actual, as opposed to editorial
              if t3 > 0 
                if t1 = 1 
                  if t3 & 0x07 > 0          /* ax over on ornament above 
                    t2 = 1 
                    if t9 & 0x07 > 0 
                      t10 = 1               /* and this is editorial 
                    end 
                  end 
                else 
                  if t3 > 7                 /* ax under on ornament below 
                    t2 = 2 
                    if t9 > 7 
                      t10 = 1               /* and this is editorial 
                    end 
                  end 
                end 
              end 
              if t2 > 0                     /* put accidental 
                if t2 = 1 
                  t4 = t3 & 0x07 
                else 
                  t4 = t3 >> 3 
                end 
                c13 = vpar(56) 
                perform yadjust 
                if c9 <> 1 
                  y -= vpar(1) 
                  c16 = y * 2 / vpar(2) 
                  if rem <> 0 
                    --y 
                  end 
                end 
                x = obx 
                if t2 = 2 and (t5 = 1 or t5 = 5) 
                  x += hpar(70) 
                end 
                x += px 
                if pyy > 0 
                  py -= y 
                  pyy = 0 
                end 
                y += py 
&dA 
&dA &d@           Deal with case where ornament is real, but accidental is editorial
&dA 
                if subflag_1 & 0x0f > 0 and t10 = 1 
                  x -= hpar(124) 
                  y -= vpar(86) 
                  z = 195                         /* open square bracket 
                  perform subj 
                  x += hpar(124) 
                  y += vpar(86) 
                end 
&dA 
&dA &d@           Put out "second" accidental 
&dA 
                z = int("39389"{t4})              /* music font 
                z += 210                          /* music font 
                if color_flag > 4 
                  perform subj3 (color_flag)      /* New &dA12/21/10&d@ 
                else 
                  perform subj 
                end 
                if t4 < 3 
                  z = int("39"{t4})                 /* music font 
                  x += hpar(z+67)                   /* hpar(70) or hpar(76) 
                  z += 210                          /* music font 
                  if t2 = 2 and (t5 = 1 or t5 = 5) 
                    x += hpar(70) 
                  end 
                  if color_flag > 4 
                    perform subj3 (color_flag)      /* New &dA12/21/10&d@ 
                  else 
                    perform subj 
                  end 
                end 
&dA 
&dA &d@           Deal with case where ornament is real, but accidental is editorial
&dA 
                if subflag_1 & 0x0f > 0 and t10 = 1 
                  x += hpar(125) 
                  y -= vpar(86) 
                  z = 196                         /* close square bracket 
                  perform subj 
                end 
              end 
              c7 = t7                               /* restore "real" c7 
            end 
          repeat 
        end 
&dA 
&dA &d@      End of code rewrite for editorial ornaments and their accidentals 
&dA 
&dA &d@   6. Construct composite subflag_1 and subflag_2, ed_subflag_1 and ed_subflag_2
&dA 
&dA &d@      New code rewrite &dA05/17/03&d@ to accommodate other editorial marks 
&dA 
        subflag_1 = ts(c1,SUBFLAG_1) 
        subflag_2 = ts(c1,SUBFLAG_2) 
        ed_subflag_1 = ts(c1,ED_SUBFLAG_1) 
        ed_subflag_2 = ts(c1,ED_SUBFLAG_2) 
        if c2 > c1 
          t5 = ts(c1,TSR_POINT) 
          bs = cbi(tsr(t5){5..68})                  /* &dA04/24/03&d@  merge only subobj suggs.
          loop for t3 = c1+1 to c2 
            subflag_1 |= ts(t3,SUBFLAG_1) 
            subflag_2 |= ts(t3,SUBFLAG_2) 
            ed_subflag_1 |= ts(t3,ED_SUBFLAG_1) 
            ed_subflag_2 |= ts(t3,ED_SUBFLAG_2) 
            t4 = ts(t3,TSR_POINT) 
            bt = cbi(tsr(t4){5..68})                /* &dA04/24/03&d@  merge only subobj suggs.
            bs = bor(bs,bt) 
          repeat 
          temp = cby(bs) 
          t3 = TSR_LENG 
          tsr(t5) = tsr(t5){1,4} // temp // tsr(t5){69..t3}    /* &dA05/02/03&d@     
        end    
        merged_subflag_1 = subflag_1 | ed_subflag_1 
        merged_subflag_2 = subflag_2 | ed_subflag_2 
&dA 
&dA &d@   7. Horizontal and vertical accents 
&dA 
        if merged_subflag_2 & 0x01c0 > 0 
&dA 
&dA &d@      Lower (raise) horizontal accent, if it and slur are present on note head
&dA 
          if c7 = 0 and c8 = 1 
            if bit(6,merged_subflag_2) = 1   /* horizontal accent 
              if stem = UP 
                c4 -= vpar(1) 
                c16 = c4 * 2 / vpar(2) 
                if rem <> 0 
                  --c4 
                end 
              else 
                c16 = c4 * 2 / vpar(2) 
                if rem <> 0 
                  ++c4 
                end 
                c4 += vpar(1) 
              end 
            end 
          end 
          t7 = c7 
          t2 = 3                        /* accent code = 3 
          perform getpxpy (t2,c1) 

          if bit(0,pcontrol) = 1 
            if bit(1,pcontrol) = 1 
              if bit(2,pcontrol) = 0 
                c7 = 1 - stem 
              else 
                c7 = stem 
              end 
            end 
          end 
          x = obx + px 
          if bit(6,merged_subflag_2) = 1    /* &dA01/26/08&d@  Fixing a small bug 
            c13 = vpar(57) 
            glyph    = 93                   /* horizontal accent 
            lsqx     = hpar(132) 
            rsqx     = hpar(133) 
            sqy      = vpar(90) 
            sq_glyph = 195                  /* cue square bracket 
          end 
          if bit(7,merged_subflag_2) = 1    /* &dA01/26/08&d@  Fixing a small bug 
            c13 = vpar(58) 
            glyph = 94                      /* vertical accent--point up 
            lsqx  = hpar(134) 
            rsqx  = hpar(135) 
            sqy   = vpar(91) 
            sq_glyph = 244                  /* small square bracket 
          end 
          if bit(8,merged_subflag_2) = 1    /* &dA01/26/08&d@  Fixing a small bug 
            c13 = vpar(58) 
            glyph = 95                      /* vertical accent--point down 
            lsqx  = hpar(134) 
            rsqx  = hpar(135) 
            sqy   = vpar(91) 
            sq_glyph = 244                  /* small square bracket 
          end 
          perform yadjust 
          if c9 <> 1 
            y -= vpar(1) 
            c16 = y * 2 / vpar(2) 
            if rem <> 0 
              --y 
            end 
          end 
          if pyy > 0 
            y = py 
          else 
            y += py 
          end 
          if ed_subflag_2 & 0x01c0 > 0 
            x -= lsqx 
            y -= sqy 
            z = sq_glyph                          /* open square bracket 
            perform subj 
            x += lsqx 
            y += sqy 
          end 
          z = glyph 
          if color_flag > 4 
            perform subj3 (color_flag)            /* New &dA12/21/10&d@ (this may be an error)
          else 
            perform subj 
          end 
          if ed_subflag_2 & 0x01c0 > 0 
            x += rsqx 
            y -= sqy 
            z = sq_glyph + 1                      /* close square bracket 
            perform subj 
          end 
          c7 = t7 
        end 
&dA 
&dA &d@   8. harmonics
&dA 
        if merged_subflag_2 & 0x0200 > 0 
          t2 = 7                        /* harmonics code = 7 
          perform getpxpy (t2,c1) 

          x = obx + px 
          z = 123                     /* music font 
          c13 = vpar(59) 
          t7 = c7 
          if stem = 0 
            c7 = 1 
          else 
            c7 = 0 
          end 
          perform yadjust             /* c9 set by yadjust 
          c7 = t7 
          if pyy > 0 
            y = py 
          else 
            y += py 
          end 
          perform subj 
        end  
&dA 
&dA &d@   9. thumb positions, open string 
&dA 
        c9 = merged_subflag_2 & 0x0c00 
        if c9 > 0  
          t2 = 8                        /* thumb-open code = 8 
          perform getpxpy (t2,c1) 

          x = obx + px 
          if bit(10,merged_subflag_2) = 1 
            z = 124                   /* music font 
            c13 = vpar(60) 
          else 
            z = 199                   /* music font 
            c13 = vpar(48) 
          end 
          t7 = c7 
          if stem = 0 
            c7 = 1 
          else 
            c7 = 0 
          end 
          perform yadjust             /* c9 set by yadjust 
          c7 = t7 
          if pyy > 0 
            y = py 
          else 
            y += py 
          end 
          perform subj 
        end  
&dA 
&dA &d@  10. fingerings (above staff for the moment)   Note: suggestions for fingerings 
&dA &d@                                                not yet implemented here.    
&dA 
        c9 = merged_subflag_2 >> 12
        if c9 > 0 
&dA 
&dA &d@    If above the staff, reverse the flags 
&dA 
          t4 = 0 
VVV2: 
          t1 = 0x0f 
          t3 = 4 
VVV1: 
          t2 = c9 & t1 
          if t2 > t1 >> 1 
            t1 = t1 << 4 + t1 
            t3 += 4 
            goto VVV1 
          end 
          t4 <<= t3 
          t4 += t2 
          c9 >>= t3 
          if c9 > 0 
            goto VVV2 
          end 
          t5 = t4 


VVV4: 
          t1 = 0x0f 
          t3 = 4 
VVV3: 
          t2 = t5 & t1 
          if t2 > t1 >> 1 
            t1 = t1 << 4 + t1 
            t3 += 4 
            goto VVV3 
          end 
&dA 
&dA &d@     Typeset t2 
&dA 
          c13 = vpar(48) 
          perform yadjust             /* c9 set by yadjust 
          t4 = t3 - 1 >> 2 * (hpar(73) / 2) 
          x = obx - t4 
VVV5: 
          t4 = t2 & 0x0f 
          z = t4 & 0x07 + 199             /* music font 
          perform subj 
          if t4 > 7 
            x += hpar(73) 
            t2 >>= 4 
            goto VVV5 
          end 

          t5 >>= t3 
          if t5 > 0 
            goto VVV4 
          end 
        end 
&dA 
&dA &d@  11. up-bows, down-bows                 
&dA 
        if merged_subflag_2 & 0x03 > 0 
          t2 = 6                        /* bowing code = 6 
          perform getpxpy (t2,c1) 

          x = obx + px 
          if bit(0,merged_subflag_2) = 1 
            c13 = vpar(61) 
            z = 117                       /* music font
          else   
            c13 = vpar(62) 
            z = 116                       /* music font 
          end  
          t7 = c7 
          if stem = 0 
            c7 = 1 
          else 
            c7 = 0 
          end 
          perform yadjust 
          c7 = t7 
          if c9 <> 1 
            y -= vpar(1) 
            c16 = y * 2 / vpar(2) 
            if rem <> 0 
              --y 
            end 
          end 
          if pyy > 0 
            y = py 
          else 
            y += py 
          end 
          perform subj 
        end  
&dA 
&dA &d@   12. fermatas (&dA12/21/10&d@ rewrite) 
&dA 
        loop for c3 = c1 to c2 
          color_flag = ts(c3,SUBFLAG_1) >> 28 
          if bit(26, ts(c3,SUBFLAG_1)) = 1 or bit(26, ts(c3,ED_SUBFLAG_1)) = 1
            t2 = 15                       /* upright fermata code = 15 
            perform getpxpy (t2,c1) 

            x = obx + px 
            c13 = vpar(63) 
            z = 101                         /* music font 
            perform yadjust 
            if pyy > 0 
              y = py 
            else 
              y += py 
            end 
            if color_flag > 4 
              perform subj3 (color_flag)           /* New &dA12/21/10&d@ 
            else 
              perform subj 
            end 
          end 
          if bit(27, ts(c3,SUBFLAG_1)) = 1 or bit(27, ts(c3,ED_SUBFLAG_1)) = 1
            t2 = 16                       /* inverted fermata code = 16 
            perform getpxpy (t2,c1) 

            x = obx + px 
            c13 = vpar(63) 
            z = 102                         /* music font 
            t7 = c7 
            if stem = 0 
              c7 = 0 
            else 
              c7 = 1 
            end 
            perform yadjust 
            c7 = t7 
            y -= vpar(63) 
            if pyy > 0 
              y = py 
            else 
              y += py 
            end 
            if color_flag > 4 
              perform subj3 (color_flag)           /* New &dA12/21/10&d@ 
            else 
              perform subj 
            end 
          end 
        repeat 
      return 
