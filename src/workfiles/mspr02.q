
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
&dA &d@³M*  2. setbeam (@k,@m)                                                          ³
&dA &d@³                                                                                ³
&dA &d@³    Purpose:  Determine the first stem length and slope of                      ³
&dA &d@³              the beam.                                                         ³
&dA &d@³                                                                                ³
&dA &d@³    Inputs:   bcount        = number of notes under beam                        ³
&dA &d@³              bdata(.,1)    = x-position of note                                ³
&dA &d@³              bdata(.,2)    = y-position of note                                ³
&dA &d@³              msk_beamcode(.)   = beam code                                     ³
&dA &d@³              f12           = staff number                                      ³
&dA &d@³                                                                                ³
&dA &d@³                   beam code = 6 digit number (string)                          ³
&dA &d@³                                                                                ³
&dA &d@³                      0 = no beam                                               ³
&dA &d@³                      1 = continue beam                                         ³
&dA &d@³                      2 = begin beam                                            ³
&dA &d@³                      3 = end beam                                              ³
&dA &d@³                      4 = forward hook                                          ³
&dA &d@³                      5 = backward hook                                         ³
&dA &d@³                      6 = repeater                                              ³
&dA &d@³                      7 = begin repeated beam                                   ³
&dA &d@³                      8 = end repeated beam                                     ³
&dA &d@³                                                                                ³
&dA &d@³                      100000's digit = eighth level beams                       ³
&dA &d@³                       10000's digit = 16th level beams                         ³
&dA &d@³                        1000's digit = 32nd level beams                         ³
&dA &d@³                         100's digit = 64th level beams                         ³
&dA &d@³                          10's digit = 128th level beams                        ³
&dA &d@³                           1's digit = 256th level beams                        ³
&dA &d@³                                                                                ³
&dA &d@³                                                                                ³
&dA &d@³              @k = stem direction for first note under beam, plus possible      ³
&dA &d@³                     modification to first stem length.  (New &dA05/14/03&d@)         ³
&dA &d@³                                                                                ³
&dA &d@³                     If @k < 100, no modifications present                      ³
&dA &d@³                     If 100 < @k < 10000, @k = @k / 100.                        ³
&dA &d@³                        Lengthen stem length (up or down)                       ³
&dA &d@³                        by @k/10 interline distance (mvpar(2))                  ³
&dA &d@³                     If @k > 10000, @k = @k / 10000.                            ³
&dA &d@³                        Shorten stem length (up or down)                        ³
&dA &d@³                        by @k/10 interline distance (mvpar(2))                  ³
&dA &d@³                                                                                ³
&dA &d@³              @m = stem direction flags for notes under beam                    ³
&dA &d@³                        (or 0 or 1 = all same as @k)                            ³
&dA &d@³              beamfont = font for printing beam                                 ³
&dA &d@³              stemchar = character number for stem                              ³
&dA &d@³              beamh    = height parameter for beams                             ³
&dA &d@³              beamt    = vertical space between beams (normally mvpar(.,32))    ³
&dA &d@³                                                                                ³
&dA &d@³    Outputs:  @k = length of first stem (positive = stem up)                    ³
&dA &d@³              @m = slope of beam                                                ³
&dA &d@³                                                                                ³
&dA &d@³    Internal variables:  @b = y-intercept of beam                               ³
&dA &d@³                         @f = temporary variable                                ³
&dA &d@³                         @g = temporary variable (related to @@g)               ³
&dA &d@³                         @h = temporary variable                                ³
&dA &d@³                         @i = temporary variable                                ³
&dA &d@³                         @j = temporary counter                                 ³
&dA &d@³                         @k = |@m|                                              ³
&dA &d@³                         @n = temporary variable                                ³
&dA &d@³                         @q = temporary counter                                 ³
&dA &d@³                         @s = temporary variable                                ³
&dA &d@³                         @t = temporary variable                                ³
&dA &d@³                         @u = temporary variable                                ³
&dA &d@³                        @@b = vertical range of note set                        ³
&dA &d@³                        @@g = top of staff line                                 ³
&dA &d@³                        @@n = temporary variable                                ³
&dA &d@³                        @@q = temporary variable                                ³
&dA &d@³                    (x1,y1) = temporary coordinates                             ³
&dA &d@³                    (x2,y2) = temporary coordinates                             ³
&dA &d@³                   xbeam(6) = temporary flags concerning whether a secondary    ³
&dA &d@³                                beam is above or below the "backbone"           ³
&dA &d@³                 bstem(.,2) = stem flags for notes under a beam                 ³
&dA &d@³                                1 = stem direction                              ³
&dA &d@³                                2 = mimumum stem length to top of "backbone"    ³
&dA &d@³                                      beam                                      ³
&dA &d@³                 max_pslope = maximum positive slope, based on length           ³
&dA &d@³                 max_nslope = maximum negative slope, based on length           ³
&dA &d@³                                                                                ³
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
      procedure setbeam (@k,@m) 
        int t1,t2,t3
        int @b,@f,@g,@h,@i,@j,@k,@m,@n,@p,@q,@r,@s,@t,@u 
        int @@b,@@g,@@n,@@q,@@t 
        int old@k 
        int m1,m2,tm,fm,sum,minsum,leng,minleng 
        int xminsum,ffm 
        int xbeam(6) 
        int max_pslope,max_nslope 
        int stem_mod 
        int stemchar,beamh,beamt 
        int bstem(MAX_BNOTES,2) 
        int dv3 
        int start_beam(2),stop_beam(2) 

        getvalue @k,@m 

        if beamfont = ors("ffffgghiijjkkllmmnoopprr"{notesize})  /* old "Mbeamfont()"
          stemchar = 59 
          beamh = mvpar(f12,16) 
          beamt = mvpar(f12,32) 
        else 
          stemchar = 187 
          beamh = mvpar(f12,16) * 4 / 5 
          beamt = mvpar(f12,32) * 4 + 3 / 5 
        end 

        t1 = bdata(bcount,1) - bdata(1,1)
        max_pslope = mvpar(f12,3) * hxpar(1) / t1 + 1 
        max_nslope = 0 - max_pslope 

        stem = @k & 0x01                              /* New code &dA05/14/03&d@ 
        stem_mod = @k / INT100 
        if stem_mod > 0 
          if stem_mod >= INT100 
            stem_mod /= INT100 
            stem_mod = stem_mod * mvpar(f12,2) + 5 / 10 
            stem_mod = 0 - stem_mod 
          else 
            stem_mod = stem_mod * mvpar(f12,2) + 5 / 10 
          end 
        end 
&dA 
&dA &d@    Deal with situation where stems go up and down 
&dA &d@    ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA 
        if @m > 1
&dA 
&dA &d@       Get stem directions 
&dA 
          loop for @j = bcount - 1 to 0 step -1 
            @g = bit(@j,@m) 
            if stem = 0 
              ++@g 
              @g &= 0x01 
            end 
            bstem(bcount - @j,1) = @g 
          repeat 
&dA 
&dA &d@       Determine number of "backbone" beams 
&dA 
          @b = 7 
          loop for @j = 1 to bcount 
            if msk_beamcode(@j) con "0" 
              if mpt < @b 
                @b = mpt 
              end 
            end 
          repeat 
          --@b                      /* @b = number of "backbone" beams 
&dA 
&dA &d@       Determine "thickness" of backbone 
&dA 
          @t = 0 
          if @b > 1 
            if @b < 4 
              @t = @b - 1 * mvpar(f12,32) 
            else 
              @t = @b - 1 * mvpar(f12,33) 
            end 
          end 
          @@t = @t + mvpar(f12,31)   /* @@t = thickness of backbone (for mixed stems)
          @t += mvpar(f12,31) >> 1   /* @t = thickness of backbone 
&dA 
&dA &d@       Determine minimum length of stem (to top of backbone) 
&dA 
          loop for @j = 1 to 6 
            if @j <= @b 
              xbeam(@j) = 1 
            else 
              xbeam(@j) = 0 
            end 
          repeat 
          @@b = @b 
          @q = 0 
          @p = 0 
          loop for @j = 1 to bcount 
PT1: 
            if @b < 6 
              if msk_beamcode(@j){@b+1} = "2" or msk_beamcode(@j){@b+1} = "7"
                ++@b 
                if bstem(@j,1) = DOWN 
                  ++@p 
                  xbeam(@b) = 2 
                else 
                  ++@q 
                  xbeam(@b) = 3 
                end 
                goto PT1 
              end 
              if "456" con msk_beamcode(@j){@b+1} 
                ++@b 
                if bstem(@j,1) = DOWN 
                  ++@p 
                  xbeam(@b) = 4 
                else 
                  ++@q 
                  xbeam(@b) = 5 
                end 
                goto PT1 
              end 
            end 
&dA 
&dA &d@        compute minimum "free" length 
&dA 
            if @b < 4 
              bstem(@j,2) = mvpar(f12,10 - @b) / 2 
            else 
              bstem(@j,2) = mvpar(f12,3) 
            end 
&dA 
&dA &d@        add length running thought extra beams 
&dA 
            if bstem(@j,1) = DOWN 
              bstem(@j,2) += @p * mvpar(f12,32) 
            else 
              bstem(@j,2) += @q * mvpar(f12,32) 
              bstem(@j,2) += mvpar(f12,31) >> 1 + @t 
            end 
PT2: 
            if xbeam(@b) = 4                    
              xbeam(@b) = 0 
              --@b 
              --@p 
              goto PT2 
            end 
            if xbeam(@b) = 5                   
              xbeam(@b) = 0 
              --@b 
              --@q 
              goto PT2 
            end 
PT3: 
            if @b > @@b 
              if msk_beamcode(@j){@b} = "3" or msk_beamcode(@j){@b} = "8" 
                if xbeam(@b) = 2 
                  --@b 
                  --@p 
                  goto PT3 
                end 
                if xbeam(@b) = 3 
                  --@b 
                  --@q 
                  goto PT3 
                end 
              end 
            end 
          repeat 
PT4: 

&dA 
&dA &d@     Determine number of staves involved 
&dA 
          @j = 0 
          if f(f12,12) = 2 
            @g = bdata(1,2)
            loop for @j = 2 to bcount 
              if abs(bdata(@j,2) - @g) > 500
                @j = 10000 
              end 
            repeat 
          end 
          if @j = 10000 
&dA 
&dA &d@       Case 1: notes span two staves (grand staff) 
&dA 
            @h = vst(f12) - 1000                  /* correction to bottom staff y-coordinage
            @@g = 0 
            loop for @j = 1 to bcount 
              if bdata(@j,2) > 700
                if bstem(@j,1) = DOWN 
                  if @@g = 0 or @@g = 2 
                    @@g = 2                       /* mixed stems on bottom staff
                  else 
                    @@g = 3 
                  end 
                end 
              else 
                if bstem(@j,1) = UP  
                  if @@g = 0 or @@g = 1 
                    @@g = 1                       /* mixed stems on top staff 
                  else 
                    @@g = 3 
                  end 
                end 
              end 
            repeat 
            if @@g = 0 
              goto TWO_STAFF_NORMAL 
            end 

            if @@g = 3 
              tmess = 56 
              perform dtalk (tmess) 
            end 
            if (Debugg & 0x0a) > 0 
              pute Abnormal case 
              pute Mixed stem directions on a single staff for a beam with notes
              pute two staves.  In this case, we will try to set a horizontal beam.
            end 
&dA &d@                
&dA &d@       Find "level" for backbone 
&dA 
            @s = 100000 
            @u = -100000 
            loop for @j = 1 to bcount 
              if @@g = 2                               /* mixed on bottom staff
                if bdata(@j,2) > 700
                  if bstem(@j,1) = DOWN 
                    if bdata(@j,2) > @u
                      @u = bdata(@j,2)
                    end 
                  else 
                    if bdata(@j,2) < @s
                      @s = bdata(@j,2)
                    end 
                  end 
                end 
              else                                     /* mixed on top staff 
                if bdata(@j,2) < 700
                  if bstem(@j,1) = DOWN 
                    if bdata(@j,2) > @u
                      @u = bdata(@j,2)
                    end 
                  else 
                    if bdata(@j,2) < @s
                      @s = bdata(@j,2)
                    end 
                  end 
                end 
              end 
              if bdata(@j,2) > 700
                bdata(@j,2) = bdata(@j,2) + @h
              end 
            repeat 
            if @@g = 2 
              @s = @s + @h
              @u = @u + @h 
            end 
&dA 
&dA &d@       @s = "highest" note below the beam (stem up) 
&dA &d@       @u = "lowest" note above the beam (stem down) 
&dA 
            @n = @u / mvpar(f12,2) 
            @n = rem 
            @h = mvpar(f12,31) >> 1 
            @i = mvpar(f12,31) - mvpar(f12,41) 

            if @b = 1 
              @j = @s - @u 
              if @j < mvpar(f12,6) 
                tmess = 57 
                perform dtalk (tmess) 
              end 
              if @j = mvpar(f12,6) 
                if @n = 0 
                  @u += mvpar(f12,2) + @i 
                else 
                  @u += mvpar(f12,3) + @h 
                end 
              else 
                if @j = mvpar(f12,7) 
                  if @n = 0 
                    @u += mvpar(f12,4) 
                  else 
                    @u += mvpar(f12,3) + @i 
                  end 
                else 
                  if @j = mvpar(f12,8) and @n <> 0 
                    @u += mvpar(f12,5) 
                  else 
                    @j = @s - @u - @@t 
                    @u += @j >> 1 
                    @u -= mvpar(f12,2) + 3 >> 2 
                    if @@g = 2 
                      @u -= vst(f12) 
                    end 
                    @u = @u + mvpar(f12,8) / mvpar(f12,2) * mvpar(f12,2) - mvpar(f12,6)
                    if @@g = 2 
                      @u += vst(f12) 
                    end 
                    @u += @h 
                  end 
                end 
              end 
            else 
              if @b = 2 
                @j = @s - @u 
                if @j < mvpar(f12,7) 
                  tmess = 57 
                  perform dtalk (tmess) 
                end 
                if @j = mvpar(f12,7) 
                  if @n = 0 
                    @u += mvpar(f12,2) + @i 
                  else 
                    @u += mvpar(f12,3) + @h 
                  end 
                else 
                  if @j = mvpar(f12,8) 
                    if @n = 0 
                      @u += mvpar(f12,2) + @i 
                    else 
                      @u += mvpar(f12,3) + @i 
                    end 
                  else 
                    if @j = mvpar(f12,9) and @n <> 0 
                      @u += mvpar(f12,3) + @i 
                    else 
                      @j = @s - @u - @@t 
                      @u += @j >> 1 
                      @u -= mvpar(f12,2) + 3 >> 2 
                      if @@g = 2 
                        @u -= vst(f12) 
                      end 
                      @u = @u + mvpar(f12,8) / mvpar(f12,2) * mvpar(f12,2) - mvpar(f12,6)
                      if @@g = 2 
                        @u += vst(f12) 
                      end 
                      @u += @h - mvpar(f12,41) 
                    end 
                  end 
                end 
                @u += mvpar(f12,32) 
              else 
                @j = @s - @u - @@t 
                if @j < mvpar(f12,4) 
                  tmess = 57 
                  perform dtalk (tmess) 
                end 
                @u += @j >> 1 
                @u -= mvpar(f12,1) 
                if @@g = 2 
                  @u -= vst(f12) 
                end 
                @u = @u + mvpar(f12,8) / mvpar(f12,2) * mvpar(f12,2) - mvpar(f12,6)
                if @@g = 2 
                  @u += vst(f12) 
                end 
                @u += @@t - mvpar(f12,41) 
              end 
            end 
            leng = bdata(1,2) - @u
            if leng > 0 
              leng += @@t - mvpar(f12,41) 
            end 

            @k = leng 

            if stem_mod <> 0                       /* New code &dA05/14/03&d@ 
              if @k > 0 
                @k += stem_mod 
              else 
                @k -= stem_mod 
              end 
            end 

            @m = 0  
            passback @k,@m 
            return 

TWO_STAFF_NORMAL: 

            loop for @j = 1 to bcount 
              if bdata(@j,2) > 700
                bdata(@j,2) = bdata(@j,2) + @h
              end 
            repeat 
&dA 
&dA &d@       I am going to try a different technique for setting mixed beams.  
&dA &d@       They don't happen very often, so I am going to try "brute force", 
&dA &d@       which will take longer, but should yield more accurate results.  
&dA &d@       Basically, I will test every slope from -8 to +8 and all legal 
&dA &d@       levels.   
&dA 
&dA &d@       1. Determine "highest" pivot point 
&dA 
            @@g = -10000 
            loop for @j = 1 to bcount 
              if bdata(@j,2) > @@g and bstem(@j,1) = DOWN
                @@g = bdata(@j,2)
                @g = @j 
              end 
            repeat 
            @@g += bstem(@g,2) 
            xminsum = 1000000000 
            @h = 10000 
&dA 
&dA &d@       2. For each "vertical" position, try all slopes; find the "best" one 
&dA 
            ffm = LIM1                        /* &dA04/23/03&d@ moved this line north of lable

NEXT_VERT_POS: 

            fm = LIM1   
            minsum = LIM1   
            t1 = max_nslope + 1 
            t2 = max_pslope - 1 
            if t1 < -4 
              t1 = -4 
            end 
            if t2 > 4 
              t2 = 4 
            end 

            if bstem(1,1) = bstem(bcount,1) 
              t1 = 0 
              t2 = 0 
            end 

            if t1 > t2 
              t1 = t2 
            end 

            loop for tm = t1 to t2             /* limiting verticle travel &dA04/23/03
              sum = 0 
              loop for @j = 1 to bcount 
                leng = bdata(@j,1) - bdata(@g,1) * tm / hxpar(1) + @@g - bdata(@j,2)
                leng = abs(leng) 
                if leng < bstem(@j,2) 
                  @j = 10000 
                else 
                  if bstem(@j,1) = DOWN        /* For down stems we are interested
                    leng -= @t                 /* only in length to top of backbone
                  end 

                  if @j = 1 or @j = bcount     /* emphasize end points 
                    sum += leng * leng * 6 
                  else 
                    sum += leng * leng 
                  end 

                end 
              repeat 

              @r = bcount - 1 * tm 
              
              sum = abs(@r) * abs(@r) * abs(tm) / 96 + 120 * sum 
              sum /= 1600 
              if sum < minsum and @j < 10000 
                fm = tm 
                minsum = sum 
              end 
            repeat 

            if minsum = LIM1   
              if ffm = LIM1   
                loop for @j = 1 to bcount 
                  bstem(@j,2) -= mvpar(f12,1) 
                  if bstem(@j,2) < mvpar(f12,2) 
                    tmess = 58 
                    perform dtalk (tmess) 
                  end 
                repeat 
                goto PT4 
              else 
                goto PARS_FOUND 
              end 
            end 
&dA 
&dA &d@       3. Now evaluate the control function for the lengths in this "vertical" position
&dA 
            if minsum < xminsum 
              xminsum = minsum 
              @h = @@g 
              ffm = fm 
            end 

            ++@@g 
            goto NEXT_VERT_POS 
&dA 
&dA &d@       4. Check to see of vertical position has been found 
&dA 
PARS_FOUND: 
            if @h = 10000 
              tmess = 59 
              perform dtalk (tmess) 
            end 
            fm = ffm 
            leng = bdata(1,1) - bdata(@g,1) * fm / hxpar(1) + @h - bdata(1,2)
            if bstem(1,1) = DOWN 
              leng += @t 
            end 
            leng = 0 - leng 
&dA 
&dA &d@        END OF New METHOD 
&dA 
            @k = leng 

            if stem_mod <> 0                       /* New code &dA05/14/03&d@ 
              if @k > 0 
                @k += stem_mod 
              else 
                @k -= stem_mod 
              end 
            end 

            @m = fm 
            passback @k,@m 
            return 

          else 
&dA 
&dA &d@       Case 2: notes are on one stave 
&dA 
            if bdata(1,2) > 700
              loop for @j = 1 to bcount 
                bdata(@j,2) -= 1000
              repeat 
            end 
&dA 
&dA &d@       Check to see if "up-down" distribution of notes allows beam to be drawn
&dA 
            if (Debugg & 0x0a) > 0 
              pute Beam with mixed stem directions on a single staff.  
            end 
&dA 
&dA &d@       I am going to try including the situations: 1-up/many-down and 
&dA &d@       many-up/1-down in the case.  
&dA 
            start_beam(1) = 100000 
            if bcount = 2 
              start_beam(1) = bdata(1,1)
              start_beam(2) = bdata(1,2)
              stop_beam(1)  = bdata(2,1)
              stop_beam(2)  = bdata(2,2)
            else 
              if bstem(1,1) = DOWN 
                t1 = 0 
                t2 = 0 
                t3 = 0 
                loop for @j = 2 to bcount 
                  if bstem(@j,1) = DOWN 
                    t2 = 1
                    if t1 = 1 
                      t1 = 2 
                    end 
                  else 
                    t1 += t2 
                    if t1 = 0 
                      t1 = 1 
                    end 
                  end 
                  t3 += abs(bdata(@j,2) - bdata(@j-1,2))
                repeat 
                if t1 < 2                /* down-up-up...  or ...down-down-up
                  if t3 = mvpar(f12,7) 
                    goto DUAL_MIXED_FLAT 
                  end 
                  goto NOT_DUAL_MIXED 
                end 
              end 

              if bstem(1,1) = UP  
                t1 = 0 
                t2 = 0 
                t3 = 0 
                loop for @j = 2 to bcount 
                  if bstem(@j,1) = UP  
                    t2 = 1
                    if t1 = 1 
                      t1 = 2 
                    end 
                  else 
                    t1 += t2 
                    if t1 = 0 
                      t1 = 1 
                    end 
                  end 
                  t3 += abs(bdata(@j,2) - bdata(@j-1,2))
                repeat 
                if t1 < 2                /* up-down-down...  or ...up-up-down
                  if t3 = mvpar(f12,7) 
                    goto DUAL_MIXED_FLAT 
                  end 
                  goto NOT_DUAL_MIXED 
                end 
              end 
              goto DUAL_MIXED_FLAT 

NOT_DUAL_MIXED: 
              start_beam(1) = bdata(1,1)
              start_beam(2) = bdata(1,2)
              stop_beam(1)  = bdata(bcount,1)
              stop_beam(2)  = bdata(bcount,2)
            end 

            if start_beam(1) <> 100000 
              if stem = UP     
                if start_beam(2) < stop_beam(2) + mvpar(f12,2) 
                  tmess = 60 
                  perform dtalk (tmess) 
                end 
              else 
                if start_beam(2) > stop_beam(2) - mvpar(f12,2) 
                  tmess = 60 
                  perform dtalk (tmess) 
                end 
              end 
              @j = abs(start_beam(2) - stop_beam(2)) / mvpar(f12,1) 
              @h = @b - 1 << 1 
              if @b < 3 
                if stem = UP 
                  if @j + @h > 11                   /* 9 
                    goto DUAL_MIXED_FLAT 
                  end 
                else 
                  if @j + @h > 13                   /* 13 
                    goto DUAL_MIXED_FLAT 
                  end 
                end 
              else 
                if @j + @h > 14                     /* 14 
                  goto DUAL_MIXED_FLAT 
                end 
              end 
              
              @n = stop_beam(1) - start_beam(1) 
              if stem = UP 
                @n -= mhpar(f12,8) 
              else 
                @n += mhpar(f12,8) 
              end  

              @s = mvpar(f12,4) * 30 / @n 
              if @s < 16 and @j + @h < 14                  /* changing 15 to 16
                @j += 2 
                @m = @s 
              else 
                @s = mvpar(f12,2) * 30 / @n                 
                if @s < 20 
                  @u = @s + 1 * @n / 30 
                  if @b < 3 
                    if @u <= mvpar(f12,2) * 12 / 11 
                      ++@s 
                    end 
                  else 
                    if @u <= mvpar(f12,3) 
                      ++@s 
                    end 
                  end 
                  if @s > 15 
                    @s = 15 
                  end 
&dA &d@                 if @s > max_pslope                       /* NOT changed &dA04/23/03
&dA &d@                   @s = max_pslope 
&dA &d@                 end 
                  @m = @s 
                else 
                  goto DUAL_MIXED_FLAT 
                end 
              end 

              @n = start_beam(2) / mvpar(f12,2) 
              @n = rem 

              @p = mvpar(f12,31) >> 1 
              @q = mvpar(f12,31) - mvpar(f12,41) 
              if @b = 1 
                if @n <> 0 
                  if @j < 4 
                    @k = mvpar(f12,3) 
                  else 
                    if @j < 6 
                      @k = mvpar(f12,3) + @p 
                    else 
                      if @j < 8 
                        @k = mvpar(f12,4) 
                        @m >>= 1 
                      else 
                        if @j < 10 
                          @k = mvpar(f12,5) + @p 
                        else 
                          @k = mvpar(f12,6) 
                          @m >>= 1 
                        end 
                      end 
                    end 
                  end 
                else 
                  if @j < 4 
                    @k = mvpar(f12,3) 
                  else 
                    if @j < 6 
                      @m >>= 1 
                      @k = mvpar(f12,3) 
                    else 
                      if @j < 8 
                        @k = mvpar(f12,4) + @p 
                      else 
                        if @j < 10 
                          @k = mvpar(f12,5) 
                          @m >>= 1 
                        else 
                          @k = mvpar(f12,6) + @p 
                        end 
                      end 
                    end 
                  end 
                end 
              else 
                if @b = 2 
                  if @n <> 0 
                    if @j < 4 
                      @k = mvpar(f12,3) + @p 
                    else 
                      if @j < 5 
                        @k = mvpar(f12,3) + @p + mvpar(f12,41) 
                        @m >>= 1 
                      else 
                        if @j < 6 
                          @k = mvpar(f12,5) 
                        else 
                          if @j < 8 
                            @k = mvpar(f12,5) + mvpar(f12,41) 
                          else 
                            @k = mvpar(f12,5) + @p 
                            @m = @m + 1 / 3 
                          end 
                        end 
                      end 
                    end 
                  else 
                    if @j < 4 
                      @k = mvpar(f12,4) 
                    else 
                      if @j < 6 
                        @k = mvpar(f12,4) + @p 
                      else 
                        if @j < 8 
                          @k = mvpar(f12,4) + @p 
                          @m = @m + 1 / 3 
                        else 
                          if @j < 10 
                            @k = mvpar(f12,6) + @p 
                          else 
                            @k = mvpar(f12,6) + @p 
                            @m >>= 1 
                          end 
                        end 
                      end 
                    end 
                  end 
                else 
                  if @b = 3 
                    if @n <> 0 
                      if @j < 5 
                        @k = mvpar(f12,5) 
                      else 
                        if @j < 6 
                          @k = mvpar(f12,5) + @p 
                        else 
                          if @j < 7 
                            @k = mvpar(f12,6) 
                          else 
                            @k = mvpar(f12,7) 
                          end 
                        end 
                      end 
                    else 
                      if @j < 5 
                        @k = mvpar(f12,5) 
                      else 
                        if @j < 6 
                          @k = mvpar(f12,5) + @p 
                        else 
                          if @j < 8 
                            @k = mvpar(f12,6) 
                          else 
                            @k = mvpar(f12,6) + @p 
                          end 
                        end 
                      end 
                    end 
                  else 
                    @k = mvpar(f12,7) 
                  end 
                end 
              end 

              if stem = DOWN 
                @m = 0 - @m 
                @k = 0 - @k 
              end 

              if stem_mod <> 0                     /* New code &dA05/14/03&d@ 
                if @k > 0 
                  @k += stem_mod 
                else 
                  @k -= stem_mod 
                end 
              end 

              passback @k,@m 
              return 

            end 

DUAL_MIXED_FLAT: 
&dA 
&dA &d@       Find "level" for backbone 
&dA 
            @s = 100000 
            @u = -100000 
            loop for @j = 1 to bcount 
              if bstem(@j,1) = DOWN 
                if bdata(@j,2) > @u
                  @u = bdata(@j,2)
                end 
              else 
                if bdata(@j,2) < @s
                  @s = bdata(@j,2)
                end 
              end 
            repeat 
&dA 
&dA &d@       @s = "highest" note below the beam (stem up) 
&dA &d@       @u = "lowest" note above the beam (stem down) 
&dA 
            @n = @u / mvpar(f12,2) 
            @n = rem 
            @h = mvpar(f12,31) >> 1 
            @i = mvpar(f12,31) - mvpar(f12,41) 

            if @b = 1 
              @j = @s - @u 
              if @j < mvpar(f12,6) 
                tmess = 61 
                perform dtalk (tmess) 
              end 

              if @j = mvpar(f12,6) 
                if @n = 0 
                  @u += mvpar(f12,2) + @i 
                else 
                  @u += mvpar(f12,3) + @h 
                end 
              else 
                if @j = mvpar(f12,7) 
                  if @n = 0 
                    @u += mvpar(f12,4) 
                  else 
                    @u += mvpar(f12,3) + @i 
                  end 
                else 
                  if @j = mvpar(f12,8) and @n <> 0 
                    @u += mvpar(f12,5) 
                  else 
                    @j = @s - @u - @@t 
                    @u += @j >> 1 
                    @u -= mvpar(f12,2) + 3 >> 2 
                    @u = @u + mvpar(f12,8) / mvpar(f12,2) * mvpar(f12,2) - mvpar(f12,6)
                    @u += @h 
                  end 
                end 
              end 
            else 
              if @b = 2 
                @j = @s - @u 
                if @j < mvpar(f12,7) 
                  tmess = 61 
                  perform dtalk (tmess) 
                end 

                if @j = mvpar(f12,7) 
                  if @n = 0 
                    @u += mvpar(f12,2) + @i 
                  else 
                    @u += mvpar(f12,3) + @h 
                  end 
                else 
                  if @j = mvpar(f12,8) 
                    if @n = 0 
                      @u += mvpar(f12,2) + @i 
                    else 
                      @u += mvpar(f12,3) + @i 
                    end 
                  else 
                    if @j = mvpar(f12,9) and @n <> 0 
                      @u += mvpar(f12,3) + @i 
                    else 
                      @j = @s - @u - @@t 
                      @u += @j >> 1 
                      @u -= mvpar(f12,2) + 3 >> 2 
                      @u = @u + mvpar(f12,8) / mvpar(f12,2) * mvpar(f12,2) - mvpar(f12,6)
                      @u += @h - mvpar(f12,41) 
                    end 
                  end 
                end 
                @u += mvpar(f12,32) 
              else 
                @j = @s - @u - @@t 
                if @j < mvpar(f12,4) 
                  tmess = 61 
                  perform dtalk (tmess) 
                end 
                @u += @j >> 1 
                @u -= mvpar(f12,1) 
                @u = @u + mvpar(f12,8) / mvpar(f12,2) * mvpar(f12,2) - mvpar(f12,6)
                @u += @@t - mvpar(f12,41) 
              end 
            end 
            leng = bdata(1,2) - @u
            if leng > 0 
              leng += @@t - mvpar(f12,41) 
            end 

            @k = leng 

            if stem_mod <> 0                     /* New code &dA05/14/03&d@ 
              if @k > 0 
                @k += stem_mod 
              else 
                @k -= stem_mod 
              end 
            end 

            @m = 0 
            passback @k,@m 
            return 
          end 
        end 
&dA 
&dA &d@   End of situation where stems go up and down 
&dA 

&dA 
&dA &d@    Check for situation where notes span two staves (grand staff) 
&dA 
        if f(f12,12) = 2 
          @g = bdata(1,2)
          loop for @j = 2 to bcount 
            if abs(bdata(@j,2) - @g) > 500
              @j = 10000 
            end 
          repeat 
&dA 
&dA &d@     If @j = 10000 and stem = 0 (up), then beam will be relative to top staff 
&dA &d@                    if stem = 1 (down), then beam will be relative to bottom staff
&dA 
&dA &d@     Otherwise, beam will be relative to staff that notes are on 
&dA 
          if @j = 10000 
            if stem = 0     /* make no adjustments 
              loop for @j = 1 to bcount 
                if bdata(@j,2) > 700
                  bdata(@j,2) -= 1000
                  bdata(@j,2) += vst(f12)
                end 
              repeat 
            else 
              loop for @j = 1 to bcount 
                if bdata(@j,2) < 700
                  bdata(@j,2) -= vst(f12)
                else 
                  bdata(@j,2) -= 1000
                end 
              repeat 
            end 
          else 
            if bdata(1,2) > 700
              loop for @j = 1 to bcount 
                bdata(@j,2) -= 1000
              repeat 
            end 
          end 
        end 
&dA 
&dA &d@     Reverse if stem down 
&dA 
        @g = 0
        if stem = 1  
          @g = mvpar(f12,2) * 500  - mvpar(f12,8) 
          loop for @j = 1 to bcount  
            bdata(@j,2) = mvpar(f12,2) * 500  - bdata(@j,2)
          repeat 
        end  
        @@g = @g 
* determine slope and pivot of beam  
        @q = 0 
        x1 = 50000 
        y1 = 50000 
        @t = 6 
        @b = 0 
        @h = 0           /* changes in absolute height 
        @f = 0 
        @i = bdata(1,2)
&dA 
&dA &d@  identify:  @q = 6 - smallest note type under beam 
&dA &d@            (x1,y1) = position of note closest to beam  
&dA &d@            (x2,y2) = position of note next closest to beam 
&dA &d@             @b = y coordinate of note furthest from beam 
&dA 
        loop for @j = 1 to bcount  
*  also compute sum of absolute changes in vertical height 
          @n = @i - bdata(@j,2)
          testfor @n < 0 
            if @f = 0  
              @f = -1  
            end  
            if @f = 1  
              @f = 2 
            end  
            @n = 0 - @n  
          else (>) 
            if @f = 0 
              @f = 1 
            end 
            if @f = -1 
              @f = 2 
            end 
          end  
          @i = bdata(@j,2)
          @h += @n 
*  
          @n = 5 
          if msk_beamcode(@j) con "0" 
            @n = mpt - 2         /* number of additional beams on this note 
          end 
          if @n > @q 
            @q = @n              /* max number of additional beams 
          end 
          if @n < @t 
            @t = @n              /* min number of additional beams 
          end 
          @n = bdata(@j,2)
          if @n > @b 
            @b = @n              /* lowest y co-ord of notes in beam set 
          end 
          if @n < y1 
            y2 = y1 
            x2 = x1 
            y1 = @n              /* nearest y co-ord 
            x1 = bdata(@j,1)
          else 
            if @n < y2 
              y2 = @n  
              x2 = bdata(@j,1)
            end  
          end  
        repeat 
&dA 
&dA &d@    Check point one: (x1,y1); (x2,y2); @b  set  
&dA 
        @@b = @b - y1  
&dA 
&dA &d@    Formula for initial stem length 
&dA 
&dA &d@        note     @q      y1-@n  
&dA &d@      ÄÄÄÄÄÄÄ  ÄÄÄÄÄÄ   ÄÄÄÄÄÄÄ 
&dA &d@        8th:      0      beamh  
&dA &d@       16th:      1      beamh + (1 * notesize / 4) 
&dA &d@       32th:      2      beamh + (4 * notesize / 4)   
&dA &d@       64th:      3      beamh + (7 * notesize / 4) 
&dA &d@      128th:      4      beamh + (10 * notesize / 4)  
&dA &d@      256th:      5      beamh + (13 * notesize / 4)  
&dA 
        if @q = 0  
          @n = y1 - beamh  
        else 
          @n = @q * 3 - 2    
          @n = 0 - notesize * @n / 4 - beamh + y1  
        end  
        @b = x1  
*   deal with case of severe up-down pattern   
        if @f = 2  
          @h /= bcount 
          if @h > mvpar(f12,18) 
            @m = 0 
            goto SB1 
          end  
        end  
*  
        @m = y1 - y2 * 2 * hxpar(1) 
        @k = x1 - x2 
        @m /= @k 
&dA 
&dA &d@  Comment: @m is (2*hxpar(1)) times slope between two notes 
&dA &d@                nearest the beam  
&dA 
        @k = bdata(bcount,2) - bdata(1,2) * 2 * hxpar(1)
        @j = bdata(bcount,1) - bdata(1,1)
        if @j < mvpar(f12,5) 
          @j = mvpar(f12,5) 
        end  
        @k /= @j 
&dA 
&dA &d@  Comment: @k is (2*hxpar(1)) times slope between outside notes 
&dA 
&dA &d@  Formula:  slope = (@m + @k) / 6   provided  
&dA 
&dA &d@     |@m| must be equal to or less than |@k|  
&dA 
        @j = abs(@m) - abs(@k) 
        if @j > 0 
          if @m > 0 
            @m -= @j 
          else 
            @m += @j 
          end 
        end 
*  
        @m = @m + @k / 6 

        @j = abs(@m) - max_pslope               /* code added &dA04/23/03&d@ 
        if @j > 0 
          if @m > 0 
            @m -= @j 
          else 
            @m += @j 
          end 
        end 

SB1:    @k = abs(@m)  
        if @k > mvpar(f12,19) 
          @k = mvpar(f12,19) 
        end  
*   Soften slant for thirty-seconds and smaller  
        if @q > 2 and @k > 5 
          @k = 0 - @q / 2 + @k 
        end  
        if @k < 0  
          @k = 0 
        end  
&dA 
&dA &d@  set reduce slant if end note are closer than mvpar(f12,6) 
&dA 
        @h = bdata(bcount,1) - bdata(1,1)
        if @h <= mvpar(f12,6)  and  @k > mvpar(f12,35) 
          @k = mvpar(f12,35) 
        end  
&dA 
&dA &d@  shorten shortest stem, if gradual slope and large vertical range  
&dA &d@                              and relatively high note  
&dA 
&dA &d@       @h = bcount + 1  
&dA &d@       if @h > 5  
&dA &d@         @h = 5 
&dA &d@       end  
        @h = 3 
        if @@b > mvpar(f12,@h) 
          @h = @q * beamt + @n - @@g 
          @h = 0 - @h  
          if @h > mvpar(f12,3) 
            if @k < 6  
              if x1 > bdata(1,1) and x1 < bdata(bcount,1)
                @n += mvpar(f12,17) 
              end  
              if bcount = 2  
                @n += mvpar(f12,17) 
              end  
            end  
          end  
        end  
*  
        if @m < 0  
          @m = 0 - @k  
        else 
          @m = @k  
        end  
&dA 
&dA &d@  @m = hxpar(1) * slope of beam 
&dA &d@  @n = y coordinate of pivot point (on highest note) of first beam  
&dA &d@  @k = absolute value of @m 
&dA &d@  @g = y coordinate of top of staff line  
&dA &d@  (x1,y1) = coordinate of note closest to beam (highest note) 
&dA &d@  (x2,y2) = coordinate of second closest note to beam (2nd highest note)  
&dA &d@  @q = 6 - smallest note type number (number of beams - 1)  
&dA &d@  @t = 6 - largest note type number 
&dA 
        @@n = @n 
        ++@q
        @@q = @q 
&dA 
&dA &d@    Check point two:  @q = number of beams, current slope = @m  
&dA 
&dA &d@   Adjust @m and @n so that beams will fall properly on staff lines 
&dA 
&dA &d@    Case I:   @m = 0  
&dA 
CSI:    if @m = 0  
          @f = @q - 1 * notesize + @n  
          if @f >= @g  
&dA 
&dA &d@    Adjust flat beam height   
&dA 
            @i = @f - @g / notesize  
            if @q = 1  and   rem <= mvpar(f12,20) 
              rem += mvpar(f12,20) 
            end  
            if @q = 2  
              if rem <= mvpar(f12,20) 
                rem += mvpar(f12,34) 
              else 
                rem = rem - notesize + mvpar(f12,20) 
              end  
            end  
            if @q = 3  
              rem += mvpar(f12,34) 
            end  
            if @q = 4  
              if @i = 3  
                beamt = mvpar(f12,33) 
              end  
              if @i < 3  
                @i = rem 
                @i -= mvpar(f12,1) / 2 
                rem = @i   
              end  
            end  
            @n -= rem 
*     (*) extremely low notes  
            if @q = 1  
              @f = mvpar(f12,4) + @@g 
            else 
              @f = 4 - @q * mvpar(f12,2) + @@g 
            end  
            if @n > @f 
              @n = @f  
              if @q > 3  and  stemchar = 59 
                beamt = mvpar(f12,33) 
              end  
            end  
          end  
        else 
&dA 
&dA &d@    Case II:   @m <> 0  
&dA 
          old@k = @k 
CSII:
          @j = bdata(1,1) - x1 * @m / hxpar(1) + @n
          @i = bdata(bcount,1) - bdata(1,1) * @m / hxpar(1) + @j
          @f = @i + @j / 2 
          if @q > 1  
            if @t > 0  
              @f += beamt 
              if @q = 2  
                @f += 2 
              end  
            end  
            @s = mvpar(f12,22) 
          else 
            @s = mvpar(f12,23) 
          end  
&dA &d@  @j = starting point of top beam 
&dA &d@  @i = stopping point of top beam 
&dA &d@  @f = average height of beam (second beam if always 2 or more) 
&dA &d@  @s = fudge factor 
          @g = @@g 
          @h = @g  
          @g -= notesize 
          if @q > 2  
            @g -= notesize 
          end  
          if @f > @g 
&dA 
&dA &d@    Adjust slanted beam height  
&dA 
            if @q > 2  
              if @f > @h 
                beamt = mvpar(f12,33) 
              else 
                @f -= 2 
              end  
            end  
            @h = abs(@i - @j) 
            @i = @f - @g / notesize  
            @i = rem 
&dA &d@  @h = rise/fall of beam  
&dA &d@  @i = amount by which the average beam height lies below a line  
            if @h < mvpar(f12,24) 
              if @i >= @s  
                @i -= notesize 
                if @q = 1  
                  ++@i
                end  
              else 
                if @q = 1  
                  --@i
                end  
              end  
              @n -= @i 
              goto CV  
            end  
            if @h < beamt and old@k <> 10000 
              if @k > 1  
                goto CSJJ  
              end  
              ++@k
              if @k = old@k 
                old@k = 10000   /* to prevent looping 
              end 
              if @m < 0  
                @m = 0 - @k  
              else 
                @m = @k  
              end  
              goto CSII  
            end  
            if @h < mvpar(f12,25) 
              @i += mvpar(f12,1) 
              if @i > @s 
                @i -= notesize 
              end  
              @n -= @i 
              goto CV  
            end  
            if @h > mvpar(f12,26) 
              if @i > @s       
                @i -= notesize 
              end  
              @n -= @i 
              goto CV  
            end  
            if @k = 2  
              @i += mvpar(f12,1) 
              if @i > @s 
                @i -= notesize 
              end  
              @n -= @i 
              goto CV  
            end  
CSJJ:       --@k
            if @k = old@k 
              old@k = 10000     /* to prevent looping 
            end 
            if @m < 0  
              @m = 0 - @k  
            else 
              @m = @k  
            end  
            goto CSII  
          else 
            if @q < 4  
              @n = notesize / 3 + @n 
            end  
          end  
*   Check for extra low notes  
CV:       @h = bdata(1,1) - x1 * @m / hxpar(1) + @n
          @j = bdata(bcount,1) - x1 * @m / hxpar(1) + @n
          @i = 0 
          if @q = 1  
            @f = mvpar(f12,4) + @@g - 2 
          else 
            @f = 4 - @q * notesize + @@g - 2 
          end  
          if @m > 0  
            if @h > @f 
              @i = 1 
              @h = @f + 1  
            end  
          else 
            if @j > @f 
              @i = 1 
              @j = @f + 1  
            end  
          end  
          @f = @f + mvpar(f12,20) + 2 
          if @m > 0  
            if @j > @f 
              @i = 1 
              @j = @f  
            end  
          else 
            if @h > @f 
              @i = 1 
              @h = @f  
            end  
          end  
          if @i = 1  
*    Correction necessary  
            @k = bdata(bcount,1) - bdata(1,1)
            @m = @j - @h * hxpar(1) / @k 
            @n = x1 - bdata(1,1) * @m / hxpar(1) + @h
            @k = abs(@m) 
          end  
&dA 
&dA &d@   Deal with special case of two note beam  
&dA 
&dA &d@     compute sum of stem lengths and increase if too short  
&dA &d@         if bcount = 2  
&dA &d@           @f = @q - 1 * beamt + y1 - @n + y2 - @n - @h 
&dA &d@           if @f < mvpar(f12,27) 
&dA &d@             @n -= mvpar(f12,28) 
&dA &d@           end  
&dA &d@         end  
&dA 
&dA &d@   Adjust so that middle of beam falls on/between staff lines 
&dA 
          @n = 100 - beamfont / 2 + @n 
        end  
*  
CSIII: 
        dv3 = @m * @b 
        dv3 = @n * hxpar(1) - dv3 
&dA 
&dA &d@    Check point three:  beam slope = @m;  
&dA &d@                        y intercept (times hxpar(1)) = dv3 
&dA 
&dA &d@     Post adjustment:  sometimes the stems of sixteenths are too  
&dA &d@       short.  This will be the case when (y2-@n) - ((@q-1)*beamt) < xxx  
&dA &d@       where xxx is some number.  In this case, we should raise the 
&dA &d@       beam by some small amount, yyy.  
&dA 
        --@q
        @j = 0 - @q * beamt + y2 - @n  
        if @j < mvpar(f12,29) 
          dv3 -= mvpar(f12,30) * hxpar(1) 
        end  
&dA 
&dA &d@     In the case where bcount = 4, compare sum of the first two notes   
&dA &d@     verses the last two notes.  If the direction is different from 
&dA &d@     the slope, then the slope should be zero.  
&dA 
        if bcount = 4  
          @f = bdata(1,2) + bdata(2,2)
          @g = bdata(3,2) + bdata(4,2)
          if @f > @g 
            if @m > 0  
              goto SB2 
            end  
          end  
          @f = @f - @g * @m  
          if @f > 0  
            goto SB2 
          end  
          goto SB3 
SB2:      @m = 0 
          @q = @@q 
          @g = @@g 
          @n = @@n 
          goto CSI 
        end  
SB3: 
&dA 
&dA &d@  @m = hxpar(1) * slope of beam 
&dA &d@  dv3 = y-intercept of top of beam (times hxpar(1)) 
&dA 

        y1 = @m * bdata(1,1) + dv3 / hxpar(1)
        y2 = bdata(1,2)
        @k = abs(y2 - y1) 
&dA 
&dA &d@  Now check for beam with excessive "vertical" travel   &dA04/23/03&d@ 
&dA 
        if @m > max_pslope or @m < max_nslope 
          if @m > max_pslope 
            t2 = 10000 
            t3 = 10000 
            loop for t1 = 1 to bcount 
              y1 = @m * bdata(t1,1) + dv3 / hxpar(1)
              y2 = bdata(t1,2)
              @k = abs(y2 - y1)                          /* stem length 
              if @k < t2 
                t2 = @k 
                t3 = t1 
              end 
            repeat 
            y1 = @m * bdata(t3,1) + dv3               /* pivit on this point
            @m = max_pslope                              /* new slope 
            dv3 = y1 - (@m * bdata(t3,1))
          end 
          if @m < max_nslope 
            t2 = 10000 
            t3 = 10000 
            loop for t1 = 1 to bcount 
              y1 = @m * bdata(t1,1) + dv3 / hxpar(1)
              y2 = bdata(t1,2)
              @k = abs(y2 - y1)                          /* stem length 
              if @k < t2 
                t2 = @k 
                t3 = t1 
              end 
            repeat 
            y1 = @m * bdata(t3,1) + dv3               /* pivit on this point
            @m = max_nslope                              /* new slope 
            dv3 = y1 - (@m * bdata(t3,1))
          end 
          y1 = @m * bdata(1,1) + dv3 / hxpar(1)
          y2 = bdata(1,2)
          @k = abs(y2 - y1) 
        end 
&dA 
&dA &d@    End of code added &dA04/23/03&d@ 
&dA 
        if stem = 1 
          @m = 0 - @m         /* reverse slope if stem down 
          @k = 0 - @k 
        end 

        if stem_mod <> 0                         /* New code &dA05/14/03&d@ 
          if @k > 0 
            @k += stem_mod 
          else 
            @k -= stem_mod 
          end 
        end 
        passback @k,@m 
      return 
