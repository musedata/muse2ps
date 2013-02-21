
&dA &d@���������������������������������������������������������������������������������Ŀ
&dA &d@�D*  2. ps_setbeam (@k,@m)                                                        �
&dA &d@�                                                                                 �
&dA &d@�    Purpose:  Typeset beams and accompanying notes and                           �
&dA &d@�              stems.  Also typeset accompanying tuplet, if present               �
&dA &d@�                                                                                 �
&dA &d@�    Inputs:   bcount        = number of notes under beam                         �
&dA &d@�              ps_beamdata(.,1) = x-position of note                              �
&dA &d@�              ps_beamdata(.,2) = y-position of note                              �
&dA &d@�              ps_beamdata(.,3) = color_flag                                      �
&dA &d@�              msk_beamcode(.)   = beam code                                      �
&dA &d@�                                                                                 �
&dA &d@�                  beam code = 6 digit number (string)                            �
&dA &d@�                                                                                 �
&dA &d@�                          0 = no beam                                            �
&dA &d@�                          1 = continue beam                                      �
&dA &d@�                          2 = begin beam                                         �
&dA &d@�                          3 = end beam                                           �
&dA &d@�                          4 = forward hook                                       �
&dA &d@�                          5 = backward hook                                      �
&dA &d@�                          6 = single stem repeater                               �
&dA &d@�                          7 = begin repeated beam                                �
&dA &d@�                          8 = end repeated beam                                  �
&dA &d@�                                                                                 �
&dA &d@�                      100000's digit = eighth level beams                        �
&dA &d@�                       10000's digit = 16th level beams                          �
&dA &d@�                        1000's digit = 32nd level beams                          �
&dA &d@�                         100's digit = 64th level beams                          �
&dA &d@�                          10's digit = 128th level beams                         �
&dA &d@�                           1's digit = 256th level beams                         �
&dA &d@�                                                                                 �
&dA &d@�                                                                                 �
&dA &d@�                       @k   = distance from first object (oby of                 �
&dA &d@�                              note group) to top of top beam (for                �
&dA &d@�                              stems up) or bottom of bottom beam                 �
&dA &d@�                              (for stems down).  @k > 0 means                    �
&dA &d@�                              stem up.                                           �
&dA &d@�                       @m   = number of dots the beam falls                      �
&dA &d@�                              (rises = negative) in a distance                   �
&dA &d@�                              of 30 horizontal dots.  (i.e.                      �
&dA &d@�                              slope * 30)                                        �
&dA &d@�                 beamfont   = font for printing beam                             �
&dA &d@�                 stemchar   = character number for stem                          �
&dA &d@�                    beamt   = vertical space between beams (normally pvpar(32))  �
&dA &d@�                     qwid   = width of quarter note (normally phpar(3))          �
&dA &d@�              tupldata(1)   = tuplet situation flag                              �
&dA &d@�              tupldata(2)   = tuplet number                                      �
&dA &d@�              tupldata(3)   = x1 offset                                          �
&dA &d@�              tupldata(4)   = x2 offset                                          �
&dA &d@�              tupldata(6)   = y1 offset   / For case where tuple goes over       �
&dA &d@�              tupldata(7)   = y2 offset   \ note heads &dAand&d@ there are chords.     �
&dA &d@�                   tbflag   = print tuplet flag                                  �
&dA &d@�                                                                                 �
&dA &d@�    Outputs:  prints out beams, stems and notes by means of                      �
&dA &d@�              procedures, printbeam, hook and revset.                            �
&dA &d@�                                                                                 �
&dA &d@�    Internal variables:                                                          �
&dA &d@�                         @b = y-intercept of beam                                �
&dA &d@�                         @f = temporary variable                                 �
&dA &d@�                         @g = temporary variable (related to @@g)                �
&dA &d@�                         @h = temporary variable                                 �
&dA &d@�                         @i = temporary variable                                 �
&dA &d@�                         @j = temporary counter                                  �
&dA &d@�                         @k = |@m|                                               �
&dA &d@�                         @n = temporary variable                                 �
&dA &d@�                         @q = temporary counter                                  �
&dA &d@�                         @s = temporary variable                                 �
&dA &d@�                         @t = temporary variable                                 �
&dA &d@�                        @@b = vertical range of note set                         �
&dA &d@�                        @@g = top of staff line                                  �
&dA &d@�                        @@n = temporary variable                                 �
&dA &d@�                        @@q = temporary variable                                 �
&dA &d@�                     bthick = thickness of beam - 1                              �
&dA &d@�                    (x1,y1) = temporary coordinates                              �
&dA &d@�                    (x2,y2) = temporary coordinates                              �
&dA &d@�                      z1,z2 = temporary character numbers                        �
&dA &d@�                stemdir(80) = stem directions for mixed direction case           �
&dA &d@�               stemends(80) = stem endpoints for mixed direction case            �
&dA &d@�                 beampos(8) = position of beam (mixed stem dir)                  �
&dA &d@�                  beamlevel = index into beampos(for each note belonging to beam)�
&dA &d@�                                                                                 �
&dA &d@�    Global variables used to communicate                                         �
&dA &d@�                                                                                 �
&dA &d@�                         z3 = character number for revset                        �
&dA &d@�����������������������������������������������������������������������������������
      procedure ps_setbeam (@k,@m) 
        int @b,@f,@g,@h,@i,@j,@k,@m,@n,@q,@s,@t 
        int @@b,@@g,@@n,@@q 
        int z1,z2,mixflag 
        int stemends(80),stemdir(80),beampos(8),beamlevel(MAX_BNOTES) 
        int savex1 
        int staff_height 
        int t1,t2,t3                   /* NEW 
        int a4 
        int bshflg 
        int cc,color_flag2             /* New &dA12/21/10&d@ 
        int dv3 
        int a1 
        getvalue @k,@m 
&dA 
&dA &d@  check for errors in beam repeaters 
&dA 
&dA &d@  And &dA12/21/10&d@, determine the finel color for the beam 
&dA 
        color_flag2 = color_flag           /* New &dA12/21/10&d@ 
        cc = color_flag                    /* New &dA12/21/10&d@ 
        t1 = 0                             /* New &dA12/21/10&d@ 
        loop for @j = 1 to bcount 
          if ps_beamdata(@j,3) = 0         /* New &dA12/21/10&d@ 
            ++t1 
            if t1 > (bcount / 2) 
              cc = 0 
            end 
          end 
          if msk_beamcode(@j) con "7" or msk_beamcode(@j) con "8" 
            if bcount <> 2 
              if (Debugg & 0x12) > 0 
                pute Improper use of beam repeaters 
              end 
              goto BERR 
            end 
            loop for @j = 1 to 6 
              if "270" con msk_beamcode(1){@j} 
                if msk_beamcode(1){@j} = "2" 
                  if msk_beamcode(2){@j} <> "3" 
                    if (Debugg & 0x12) > 0 
                      pute Mismatching beamcodes 
                    end 
                    goto BERR 
                  end 
                end 
                if msk_beamcode(1){@j} = "7" 
                  if msk_beamcode(2){@j} <> "8" 
                    if (Debugg & 0x12) > 0 
                      pute Mismatching beamcodes 
                    end 
                    goto BERR 
                  end 
                end 
                if msk_beamcode(1){@j} = "0" 
                  if msk_beamcode(2){@j} <> "0" 
                    if (Debugg & 0x12) > 0 
                      pute Mismatching beamcodes 
                    end 
                    goto BERR 
                  end 
                end 
              else 
                if (Debugg & 0x12) > 0 
                  pute Improper use of beam repeaters 
                end 
                goto BERR 
              end 
            repeat 
            @j = 10000 
          end 
        repeat 

        if @k > 0 
          stem = UP 
        else 
          stem = DOWN 
        end 
&dA 
&dA &d@    Check for situation where notes span two staves (grand staff) 
&dA 
        staff_height = 0 

        if vst(f12) > 0 
          @g = ps_beamdata(1,2) 
          loop for @j = 2 to bcount 
            if abs(ps_beamdata(@j,2) - @g) > 500 
              staff_height = 10000 
              @j = 10000 
            end 
          repeat 
        end 
&dA 
&dA &d@    Adjust all y coordinates be relative to the top staff 
&dA 
        loop for @j = 1 to bcount 
          if ps_beamdata(@j,2) - psq(f12) > 700 
            ps_beamdata(@j,2) -= 1000 
            ps_beamdata(@j,2) += vst(f12) 
            if staff_height <> 10000 
              staff_height = vst(f12) 
            end 
          end 
        repeat 
&dA 
&dA &d@    Check for mixed stem directions 
&dA 
        mixflag = 0 
        loop for @j = 2 to bcount 
          @h = ps_beamdata(@j,1) - ps_beamdata(1,1) * @m / 30 
          @h = @h + ps_beamdata(1,2) - @k - ps_beamdata(@j,2) 
          if @h < 0 
            if stem = DOWN 
              mixflag = 1 
              @j = 10000 
            end 
          else 
            if stem = UP 
              mixflag = 1 
              @j = 10000 
            end 
          end 
        repeat 
&dA 
&dA &d@    Deal with tuplets attached to &dAnote heads&d@ 
&dA 
        if tbflag = 1  
          @f = ps_beamdata(bcount,1) - ps_beamdata(1,1) 
          @g = ps_beamdata(bcount,2) - ps_beamdata(1,2) * 30 
          @t = @g / @f 
          @s = 0 
          @n = bcount - 1  
          loop for @i = 2 to @n  
            @h = ps_beamdata(@i,1) - ps_beamdata(1,1) * @t / 30 + ps_beamdata(1,2)
            @q = ps_beamdata(@i,2) - @h 
            if stem = DOWN
              @q = 0 - @q  
            end  
            if @q > @s 
              @s = @q  
            end  
          repeat 

          if stem = DOWN 
            @j = pvpar(39) + @s + psq(f12)     
            y1 = ps_beamdata(1,2) - @j 
            y2 = ps_beamdata(bcount,2) - @j 
          else 
            @j = pvpar(39) + pvpar(38) + @s - psq(f12)    
            y1 = ps_beamdata(1,2) + @j 
            y2 = ps_beamdata(bcount,2) + @j 
          end  
&dA 
&dA &d@    Adding code &dA05/09/03&d@ to make space for numbers inside brackets  &dIOK&d@ 
&dA 
          sitflag = tupldata(1)  
          @s = pvpar(1) 
          if bit(0,sitflag) = 1               /* number present 
            if bit(1,sitflag) = 1               /* bracket present 
              if bit(4,sitflag) = 0               /* number near note head 
                if bit(5,sitflag) = 1               /* continuous bracket     
                  if bit(6,sitflag) = 1               /* number inside        
                    if bit(2,sitflag) = 0               /* tips down       
                      y1 -= pvpar(2)                       /* raise bracket 
                      y2 -= pvpar(2) 
                      @s = pvpar(3) 
                    else                                /* tips up 
                      y1 += pvpar(2)                       /* lower bracket 
                      y2 += pvpar(2) 
                      @s = pvpar(2) 
                    end 
                  end 
                end 
              end 
            end 
          end 

          if stem = DOWN 
            if staff_height <> 10000 
              @h = 0 - notesize * 2 / 3 + staff_height      
              if (y1 + tupldata(6)) > @h 
                y1 = @h - tupldata(6) 
              end 
              if (y2 + tupldata(6)) > @h 
                y2 = @h - tupldata(6) 
              end 
            end 
          else 
            if staff_height <> 10000 
              @h = 11 * notesize / 2 + staff_height 
              if (y1 + tupldata(6)) < @h 
                y1 = @h - tupldata(6) 
              end 
              if (y2 + tupldata(6)) < @h 
                y2 = @h - tupldata(6) 
              end 
            end 
          end  
          a1 = tupldata(2) 
          x1 = tupldata(3) + ps_beamdata(1,1) - sp 
          x2 = tupldata(4) + ps_beamdata(bcount,1) - sp 
          y1 += tupldata(6) 
          y2 += tupldata(7) 
          perform puttuplet (a1) 
        end  

        bthick = beamfont - 101  
&dA 
&dA &d@    Reverse all y co-ordinates if first stem is down 
&dA 
        @g = psq(f12)   
        if stem = DOWN 
          @g = pvpar(2) * 500  - pvpar(8) - @g 
          loop for @j = 1 to bcount  
            ps_beamdata(@j,2) = pvpar(2) * 500  - ps_beamdata(@j,2) 
          repeat 
        end  
        @@g = @g 

        if stem = 1 
          @m = 0 - @m 
          @k = 0 - @k 
        end 
        dv3 = @m * ps_beamdata(1,1) 
        dv3 = ps_beamdata(1,2) - @k * phpar(1) - dv3 
        @k = abs(@m) 
        @@q = 0 
        loop for @j = 1 to bcount 
          @n = 5 
          if msk_beamcode(@j) con "0" 
            @n = mpt - 2       /* number of additional beams on this note 
          end 
          if @n > @@q 
            @@q = @n           /* max number of additional beams 
          end 
        repeat 
        ++@@q 
        if @@q > 3 
          beamt = pvpar(33) 
        end 

&dA                                                            
&dA &d@                                                          &dA 
&dA &d@    This is the printout portion of the procedure         &dA 
&dA &d@    ���������������������������������������������         &dA 
&dA &d@       @m = phpar(1) * slope of beam                      &dA 
&dA &d@       @k = |@m|                                          &dA 
&dA &d@       dv3 = y-intercept of top of beam (times phpar(1))  &dA 
&dA &d@                                                          &dA 
&dA                                                            

&dA 
&dA &d@  identify beam characters  
&dA 
        z1 = @k + 33 
        if @m > 0  
          z1 += 128 
        end  
        z2 = @k + 49   
        if @m > 0  
          z2 += 128 
        end  
&dA 
&dA &d@  check for tuplet over beam 
&dA 
        if tbflag = 2  
          sitflag = tupldata(1)  
          if bit(7,sitflag) = 1             /* curved bracket &dA03/15/97&d@  &dIOK&d@ 
            a4 = 0 - 2 * qwid / 3 
            if stem = UP 
              a4 = qwid / 3 
            end 
          else 
            a4 = 0 - qwid / 3 
            if stem = UP 
              a4 = 2 * qwid / 3 
            end 
          end 

          a1 = tupldata(2) 
          x1 = ps_beamdata(1,1) + a4 - sp                 + tupldata(3) 
          x2 = ps_beamdata(bcount,1) + a4 - sp            + tupldata(4) 
          y1 = @m * ps_beamdata(1,1) + dv3 / phpar(1) 
          y2 = @m * ps_beamdata(bcount,1) + dv3 / phpar(1) 
          if stem = DOWN 
            y1 = pvpar(2) * 500  - y1 - bthick - psq(f12) + pvpar(39) + pvpar(38)
            y2 = pvpar(2) * 500  - y2 - bthick - psq(f12) + pvpar(39) + pvpar(38)
          else 
            y1 = y1 - pvpar(39) - psq(f12)     
            y2 = y2 - pvpar(39) - psq(f12)     
          end  
          y1 += tupldata(6) 
          y2 += tupldata(7) 
          perform puttuplet (a1) 
        end  
&dA 
&dA &d@   Here the situation diverges 
&dA 
&dA &d@     Case I:  all stems go in the same direction 
&dA &d@     Case II: stem directions are mixed 
&dA 
        if mixflag = 0     /*  Case I: all stems go in the same direction 
&dA 
&dA &d@  put in first beam 
&dA 
          x1 = ps_beamdata(1,1) 
          x2 = ps_beamdata(bcount,1) 
          if msk_beamcode(1){1} = "7" 
            x1 += phpar(59) 
            x2 -= phpar(59) 
          end 
          color_flag = cc                      /* New &dA12/21/10&d@ 
          perform printbeam (z1,dv3,@m) 
          color_flag = color_flag2             /* New &dA12/21/10&d@ 
&dA 
&dA &d@  put in vertical stems 
&dA 
          loop for @j = 1 to bcount 
            if ps_beamdata(@j,3) = 0           /* New &dA12/21/10&d@ 
              color_flag = 0     
            end 
            x1 = ps_beamdata(@j,1) 
            y1 = @m * x1 + dv3 / phpar(1) + pvpar(42) 
            y1 += pvpar(4) 
            y2 = ps_beamdata(@j,2) 
            z3 = stemchar 
            if y1 >= y2 
              z3 += 2 
              y1 -= pvpar(2) 
              loop while y1 < y2 
                perform revset 
                y1 += pvpar(2) 
              repeat 
            else 
              loop while y1 < y2 
                perform revset 
                y1 += pvpar(4) 
              repeat 
            end 
            y1 = y2 
            perform revset 
            color_flag = color_flag2           /* New &dA12/21/10&d@ 
          repeat 
&dA &d@    
&dA &d@  put in other beams  
&dA 
          loop for @q = 2 to @@q 
            if msk_beamcode(1){@q} = "7" 
              dv3 = (pvpar(2) + beamt) * phpar(1) / 2 + dv3 
            else 
              if msk_beamcode(1){@q} = "6" 
                dv3 = pvpar(2) * phpar(1) + dv3 
              else 
                dv3 = beamt * phpar(1) + dv3 
              end 
            end 
            bshflg = 0 
            loop for @j = 1 to bcount 
              if "123456780" con msk_beamcode(@j){@q} 
                if mpt = 2 
                  @i = @j 
BB1:              ++@j 
                  if @j > bcount 
                    if (Debugg & 0x12) > 0 
                      pute @j (~@j ) exceeds bcount (~bcount ) 
                    end 
                    goto BERR 
                  end 
                  if "1234560" con msk_beamcode(@j){@q} 
                    if mpt = 1 
                      goto BB1 
                    else 
                      if mpt = 3 
                        if @i > 1 and bshflg = 0 
                          dv3 += (3 * phpar(1) / 8) 
                          bshflg = 1 
                        end 
                        x1 = ps_beamdata(@i,1) 
                        x2 = ps_beamdata(@j,1) 
                        color_flag = cc                      /* New &dA12/21/10
                        perform printbeam (z1,dv3,@m) 
                        color_flag = color_flag2             /* New &dA12/21/10
                        goto BBR 
                      else 
                        if (Debugg & 0x12) > 0 
                          pute expecting a "1" or a "3" here (got a ~msk_beamcode(@j){@q} )
                          pute msk_beamcode(~@j ) = ~msk_beamcode(@j) 
                        end 
                        goto BERR 
                      end 
                    end 
                  end 
                end 
                if mpt = 7 
                  x1 = ps_beamdata(1,1) + phpar(59) 
                  x2 = ps_beamdata(2,1) - phpar(59) 
                  color_flag = cc                      /* New &dA12/21/10&d@ 
                  perform printbeam (z1,dv3,@m) 
                  color_flag = color_flag2             /* New &dA12/21/10&d@ 
                  goto BBR 
                end 
                if mpt = 1 
                  if (Debugg & 0x12) > 0 
                    pute "1" not allowed in this position 
                  end 
                  goto BERR 
                end 
                if mpt = 3 
                  if (Debugg & 0x12) > 0 
                    pute "3" not allowed in this position 
                  end 
                  goto BERR 
                end 
                t1 = phpar(1) >> 1 
                if mpt = 4                               /* print forward hook
                  x1 = ps_beamdata(@j,1) + phpar(29) 
                  y  = @m * x1 + dv3 + t1 / phpar(1) 
                  z  = z2 + 16 
                  color_flag = cc                      /* New &dA12/21/10&d@ 
                  perform hook 
                  color_flag = color_flag2             /* New &dA12/21/10&d@ 
                end 
                if mpt = 5                               /* print backward hook
                  x1 = ps_beamdata(@j,1) 
                  y  = @m * x1 + dv3 + t1 / phpar(1) 
                  x1 -= hookbackshift(beamfont-100)      /* New &dA12/31/08&d@ 
                  z = z2 
                  color_flag = cc                      /* New &dA12/21/10&d@ 
                  perform hook 
                  color_flag = color_flag2             /* New &dA12/21/10&d@ 
                end 
                if mpt = 6                               /* make cross piece
                  x1 = ps_beamdata(@j,1) 
                  t3 = int("0001122344567"{beamfont-100})  /* magic number 
                  t3 += 3 
                  x1 -= t3 
                  y1 = @m * x1 + dv3 + t1 / phpar(1) 
                  y  = y1 
                  z  = z2 + 16 
                  color_flag = cc                      /* New &dA12/21/10&d@ 
                  perform hook 
                  color_flag = color_flag2             /* New &dA12/21/10&d@ 
                end 
              end 
BBR:        repeat 
          repeat 

        else          /*  Case II: stem directions are mixed 
&dA 
&dA &d@    1. Determine definitive stem directions and end points 
&dA &d@         on main staff.  
&dA 
          loop for @j = 1 to bcount 
            x1 = ps_beamdata(@j,1) 
            y1 = @m * x1 + dv3 / phpar(1) + 4   /* middle of main beam 
            y2 = ps_beamdata(@j,2)                /* oby of note 
            if y1 < y2 
              stemdir(@j) = UP 
            else 
              stemdir(@j) = DOWN               /* different x intersection 
              if stem = UP                     /* direction of &dAfirst&d@ stem 
                x1 -= qwid - phpar(29) 
              else 
                x1 += qwid - phpar(29) 
              end 
              y1 = @m * x1 + dv3 / phpar(1) + 4 
            end 
            stemends(@j) = y1 
          repeat 
&dA 
&dA &d@    2. Put in first beam 
&dA 
          x1 = ps_beamdata(1,1)         /* stemdir(1) is always UP 
          x2 = ps_beamdata(bcount,1) 
          if stemdir(bcount) = DOWN 
            if stem = UP 
              x2 -= qwid - phpar(29) 
            else 
              x2 += qwid - phpar(29) 
            end 
          end 
          color_flag = cc                      /* New &dA12/21/10&d@ 
          perform printbeam (z1,dv3,@m) 
          color_flag = color_flag2             /* New &dA12/21/10&d@ 
          beampos(1) = dv3 
&dA 
&dA &d@    2a. Set beamlevel = 1 for all notes.  beamlevel for notes will change 
&dA &d@        as we move through the beam.  Basically, if notes A and B start 
&dA &d@        and end a beam respectively, then beamlevel will be given the 
&dA &d@        same value for all of these notes and any that might be in between.  
&dA &d@        If another beam extends between notes C and B, then beamlevel 
&dA &d@        for these notes will be increased.  In the end, beamlevel for each 
&dA &d@        note will be the number of beams connecting or going through the 
&dA &d@        stem for that note.  
&dA 
          loop for @j = 1 to bcount 
            beamlevel(@j) = 1 
          repeat 
&dA 
&dA &d@     NEW &dA05/19/03&d@  I am going to attempt a rewrite of this section.  The problem
&dA &d@     with the old code was that it sometimes didn't give asthetically pleasing 
&dA &d@     solutions.  In particular, the problem arises when a secondary beam is
&dA &d@     to be drawn between endpoints whose stems are in different directions.
&dA &d@     The old code made the arbitrary decision to draw the secondary beam according
&dA &d@     to the direction of the stem of the initial note.  This had the additional
&dA &d@     advantage that stems could be drawn as notes were processed, i.e., we would
&dA &d@     not have to go back and "lengthen" a stem because a secondary beam was 
&dA &d@     drawn on the other side of the primary.  
&dA 
&dA &d@     With this rewrite, I must change this, i.e., stems cannot be drawn until 
&dA &d@     all beams are set.  Secondly, I need to come up with a set of rules as to
&dA &d@     how to deal with the situation where the endpoints of a secondary connect
&dA &d@     to stems of different directions.  I propose to generate these rules from
&dA &d@     experience, and by trial and error.  As we encounter situations where the
&dA &d@     result seems to violate common sense, then we can consider adding a new 
&dA &d@     rule.  It should be pointed out that at the moment &dEthere is no provision
&dA &d@     &dEmade for editing the decision made by this program&d@ as regards the placing
&dA &d@     of secondary beams.  To add this feature, we would need to expand the 
&dA &d@     contents of the beam super-object record.  
&dA 
&dA &d@     As of this date &dA05/19/03&d@, I have only one rule to propose for cases where  
&dA &d@     the endpoints have stems that go in different directions.  
&dA &d@                              
&dA &d@        1. If there is a stem that follows the terminating stem, then use 
&dA &d@           use this stem direction to "arbitrate" between the directions of  
&dA &d@           the endpoint stems.  If no stem follows, then the stem direction
&dA &d@           of the initial note wins.  
&dA 

&dA 
&dA &d@    3. Loop through notes, one at a time 
&dA 
          loop for @j = 1 to bcount 
            x1 = ps_beamdata(@j,1) 
            if stemdir(@j) = DOWN 
              if stem = UP 
                x1 -= qwid - phpar(29) 
              else 
                x1 += qwid - phpar(29) 
              end 
            end 
            savex1 = x1 
&dA 
&dA &d@      a. add &dAall&d@ extra beams starting at this note (and increase beamlevel accordingly)
&dA 
            loop for @h = beamlevel(@j) + 1 to 6 
              if msk_beamcode(@j){@h} = "2"          /* begin beam 
                ++beamlevel(@j)                  /* increment beamlevel for starting point
                loop for @g = @j + 1 to bcount 
                  if msk_beamcode(@g){@h} = "3"      /* end beam 
                    x1 = savex1                  /* x1 needs to be reset for each beam
                    x2 = ps_beamdata(@g,1) 
                    if stemdir(@g) = DOWN        
                      if stem = UP 
                        x2 -= qwid - phpar(29) 
                      else 
                        x2 += qwid - phpar(29) 
                      end 
                    end 
                    dv3 = beampos(1) 
&dA 
&dA &d@       Here is where the rules take effect.  
&dA 
&dA &d@         Case I: Use stem direction of first note to determine secondary beam position
&dA 
&dA &d@                cases:  1) Normal:  stemdir(@g) = stemdir(@j) 
&dA 
&dA &d@                        2) stemdir(@g) <> stemdir(@j) but 
&dA &d@                            either  @g = bcount 
&dA &d@                            or  stemdir(@g+1) = stemdir(@j) 
&dA 
                    t2 = 0 
                    if stemdir(@g) <> stemdir(@j) 
                      if @g < bcount 
                        if stemdir(@g+1) <> stemdir(@j) 
                          t2 = 1 
                        end 
                      end 
                    end 

                    if t2 = 0
                      loop for @f = 1 to beamlevel(@g) 
                        if stemdir(@j) = UP 
                          if beampos(@f) > dv3 
                            dv3 = beampos(@f) 
                          end 
                        else 
                          if beampos(@f) < dv3 
                            dv3 = beampos(@f) 
                          end 
                        end 
                      repeat 
                      ++beamlevel(@g)           /* increment beamlevel for endpoint
                      if stemdir(@j) = UP              
                        dv3 += (beamt * phpar(1)) 
                      else 
                        dv3 -= (beamt * phpar(1)) 
                      end 
                      beampos(beamlevel(@g)) = dv3 
                       
                      color_flag = cc                      /* New &dA12/21/10&d@ 
                      perform printbeam (z1,dv3,@m) 
                      color_flag = color_flag2             /* New &dA12/21/10&d@ 
&dA 
&dA &d@      b. adjust stem ends for notes under (over) this beam 
&dA 
                      loop for @f = @j + 1 to @g 
                        if stemdir(@j) = UP 
                          if stemdir(@f) = DOWN 
                            stemends(@f) += beamt 
                          end 
                        else 
                          if stemdir(@f) = UP 
                            stemends(@f) -= beamt 
                          end 
                        end 
                      repeat 
                    else  
&dA 
&dA &d@         Case II: Use stem direction of last note to determine secondary beam position
&dA 
&dA &d@                cases:  1) stemdir(@g) <> stemdir(@j), and 
&dA &d@                            @g < bcount, and 
&dA &d@                            stemdir(@g+1) = stemdir(@g) 
&dA 
                      loop for @f = 1 to beamlevel(@g) 
                        if stemdir(@g) = UP                 /* changing @j to @g
                          if beampos(@f) > dv3 
                            dv3 = beampos(@f) 
                          end 
                        else 
                          if beampos(@f) < dv3 
                            dv3 = beampos(@f) 
                          end 
                        end 
                      repeat 
                      ++beamlevel(@g)           /* increment beamlevel for endpoint
                      if stemdir(@g) = UP                   /* changing @j to @g
                        dv3 += (beamt * phpar(1)) 
                      else 
                        dv3 -= (beamt * phpar(1)) 
                      end 
                      beampos(beamlevel(@g)) = dv3 

                      color_flag = cc                      /* New &dA12/21/10&d@ 
                      perform printbeam (z1,dv3,@m) 
                      color_flag = color_flag2             /* New &dA12/21/10&d@ 
&dA 
&dA &d@      b. adjust stem ends for notes under (over) this beam 
&dA 
                      loop for @f = @j to @g 
                        if stemdir(@g) = UP                 /* changing @j to @g
                          if stemdir(@f) = DOWN 
                            stemends(@f) += beamt 
                          end 
                        else 
                          if stemdir(@f) = UP 
                            stemends(@f) -= beamt 
                          end 
                        end 
                      repeat 
                    end 

                    @g = 10000 
                  else 
&dA 
&dA &d@                   Increment beamlevel for all notes between endpoints of this beam
&dA 
                    ++beamlevel(@g)                                           
                  end 
                repeat 
                if @g <> 10000 
                  if (Debugg & 0x12) > 0 
                    pute No termination found for beam 
                  end 
                  goto BERR 
                end 
              else 
                @h = 6 
              end 
            repeat 
&dA 
&dA &d@      c. put in any hooks that might go with this note 
&dA 
            loop for @h = beamlevel(@j) + 1 to 6 
              if "456" con msk_beamcode(@j){@h}         /* begin beam 
                @g = mpt 
                loop for @f = 1 to beamlevel(@j) 
                  if stemdir(@j) = UP 
                    if beampos(@f) > dv3 
                      dv3 = beampos(@f) 
                    end 
                  else 
                    if beampos(@f) < dv3 
                      dv3 = beampos(@f) 
                    end 
                  end 
                repeat 
                if @g = 3 
                  t1 = pvpar(2) * phpar(1) 
                else 
                  t1 = beamt * phpar(1) 
                end 
                if stemdir(@j) = UP 
                  dv3 += t1
                else 
                  dv3 -= t1
                end 
                t1 = phpar(1) >> 1 
                if @g = 1                                /* print forward hook
                  x1 = savex1 + phpar(29) 
                  y  = @m * x1 + dv3 + t1 / phpar(1) 
                  z  = z2 + 16 
                  color_flag = cc                      /* New &dA12/21/10&d@ 
                  perform hook 
                  color_flag = color_flag2             /* New &dA12/21/10&d@ 
                end 
                if @g = 2                                /* print backward hook
                  x1 = savex1          
                  y  = @m * x1 + dv3 + t1 / phpar(1) 
                  x1 -= hookbackshift(beamfont-100)      /* New &dA12/31/08&d@ 
                  z = z2 
                  color_flag = cc                      /* New &dA12/21/10&d@ 
                  perform hook 
                  color_flag = color_flag2             /* New &dA12/21/10&d@ 
                end 
                if @g = 3                                /* make cross piece
                  x1 = savex1 
                  y1 = @m * x1 + dv3 + t1 / phpar(1) 
                  x1 -= 5 
                  y  = y1 
                  if @m > 0 
                    y -= int("111111222222233"{@m}) 
                  end 
                  if @m < 0 
                    y += int("111111222222233"{0-@m}) 
                  end 
                  z  = z2 + 16 
                  color_flag = cc                      /* New &dA12/21/10&d@ 
                  perform hook 
                  color_flag = color_flag2             /* New &dA12/21/10&d@ 
                  x1 -= phpar(30) - phpar(29) - 10  /* = 7 
                  y  = y1 
                  if @m > 0 
                    y += int("000111111222222"{@m}) 
                  end 
                  if @m < 0 
                    y -= int("000111111222222"{0-@m}) 
                  end 
                  z = z2 
                  color_flag = cc                      /* New &dA12/21/10&d@ 
                  perform hook 
                  color_flag = color_flag2             /* New &dA12/21/10&d@ 
                end 
              else 
                @h = 6 
              end 
            repeat 
          repeat 
&dA 
&dA &d@    4. Loop again through notes, one at a time, and now draw the stems (&dA05/19/03&d@)
&dA 
          loop for @j = 1 to bcount 
&dA 
&dA &d@      a. put in stem 
&dA 
            if ps_beamdata(@j,3) = 0           /* New &dA12/21/10&d@ 
              color_flag = 0     
            end 
            x1 = ps_beamdata(@j,1) 
            if stemdir(@j) = DOWN 
              if stem = UP 
                x1 -= qwid - phpar(29) 
              else 
                x1 += qwid - phpar(29) 
              end 
            end 
            savex1 = x1 
            if stemdir(@j) = UP 
              y1 = stemends(@j) 
              y2 = ps_beamdata(@j,2) 
            else 
              y2 = stemends(@j) 
              y1 = ps_beamdata(@j,2) + 2          /* I think this is needed 
            end 
            y1 += pvpar(4) 
            z3 = stemchar 
            if y1 >= y2 
              z3 += 2 
              y1 -= pvpar(2) 
              loop while y1 < y2 
                perform revset 
                y1 += pvpar(2) 
              repeat 
            else 
              loop while y1 < y2 
                perform revset 
                y1 += pvpar(4) 
              repeat 
            end 
            y1 = y2 
            perform revset 
            color_flag = color_flag2           /* New &dA12/21/10&d@ 
          repeat 
&dA 
&dA &d@    End of &dA05/19/03&d@ rewrite &dIOK&d@ 
&dA 
        end 

        return 
BERR: 
        if (Debugg & 0x12) > 0 
          pute Beam format error, printbeam aborted 
        end 
      return 
