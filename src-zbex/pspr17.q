
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
&dA &d@³D* 17. putslur (addcurve)                                                           ³
&dA &d@³                                                                                    ³
&dA &d@³                                                                                    ³
&dA &d@³    Purpose:  Typeset slur                                                          ³
&dA &d@³                                                                                    ³
&dA &d@³    Inputs:   (x1,y1)        = starting note head                                   ³
&dA &d@³              (x2,y2)        = terminating note head                                ³
&dA &d@³              slur_edit_flag = flag indicating that y1 and/or y2 have been altered  ³
&dA &d@³              postx          = horiz. movement of slur after it has been chosen     ³
&dA &d@³              posty          = vert.  movement of slur after it has been chosen     ³
&dA &d@³              addcurve       = flag indicating the curvature should be added        ³
&dA &d@³              sitflag        = situation flag                                       ³
&dA &d@³                                                                                    ³
&dA &d@³                     bit clear            bit set                                   ³
&dA &d@³                   --------------       -------------                               ³
&dA &d@³          bit 0:   full slur            dotted slur                                 ³
&dA &d@³          bit 1:   stock slur           custom slur                                 ³
&dA &d@³          bit 2:   first tip down       first tip up                                ³
&dA &d@³     (*)  bit 3:   second tip down      second tip up                               ³
&dA &d@³     (+)  bit 4:   compute stock slur   hold stock slur                             ³
&dA &d@³                                                                                    ³
&dA &d@³          (*) used on custom slurs only                                             ³
&dA &d@³          (+) used on stock slurs only                                              ³
&dA &d@³                                                                                    ³
&dA &d@³          bit 5:   continuous slur      broken slur                                 ³
&dA &d@³                                                                                    ³
&dA &d@³          bits 8-15:  size of break (0 to 255 dots, centered)                       ³
&dA &d@³                                                                                    ³
&dA &d@³                                                                                    ³
&dA &d@³    Internal variables:  a1,a3,a5,a6,a7,a8,a9,a10,a11,a12                           ³
&dA &d@³                         c1,c2,c3,c4,c5,c6,c7                                       ³
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
      procedure putslur (addcurve) 
        str sbt1.2500 
        str sbt2.2500 
        str temp.600(3) 
        str ptline2.480 

        bstr tbt.2500                  /* added &dA01/26/05&d@ 
        bstr tbt2.2500                 /* added &dA01/26/05&d@ 

        int t1,t2,t3,t4,t5,t6,t7,t8,t9 
        int c1,c2,c3,c4,c5,c6,c7 
        int a1,a3,a5,a6,a7,a8,a9,a10,a11,a12 
        int aa(3),cc(3),dd(3) 
        int save_y1,save_y2 
        int save_x1,save_x2 
        int addcurve 

        getvalue addcurve 

        save_y1 = y1                  /* added &dA01/03/05&d@, etc.  
        save_y2 = y2 
        save_x1 = x1 
        save_x2 = x2 
&dA 
&dA &d@  determine case  
&dA 
        a9 = bit(2,sitflag) 
        a1 = a9 * 2 + 1          /* 1,1,3,3 
        if y1 < y2 
          ++a1                   /* 1,2,3,4 = tips down rising, tips down falling, etc.
        end  
&dA 
&dA &d@  determine method of dealing with slurs   stock vs. custom 
&dA 
        if notesize = 14 
          a5 = 800               /* changed from 801 on &dA9-12-97&d@ 
        end 
        if notesize = 6                    
          a5 = 400               /* changed from 801 on &dA9-12-97&d@ 
        end 
        if notesize = 21 
          a5 = 600               /* changed from 601 on &dA9-12-97&d@ 
        end 

        if notesize = 18 
          a5 = 800 
        end 

        if notesize = 16 
          a5 = 800               
        end 
        if x2 - x1 < a5   /* stock slurs 
SR5:       
          a5 = pvpar(10) + pvpar20 - y1 * 2 + 1 / pvpar(2) - 20 
          a6 = pvpar(10) + pvpar20 - y2 * 2 + 1 / pvpar(2) - 20 
          a7 = abs(a5-a6) 
&dA 
&dA &d@  determine whether to use the parametric method of slur placement 
&dA 
          if a7 < 11 or (x2 - x1 < 100 and slur_edit_flag = 0)    /* protopar file specific

            if a7 > 10 
              a7 -= 10 
              a7 = a7 + 20 * pvpar(2) / 2 - pvpar20 
              if a1 = 1 
                y1 -= a7 
              else 
                if a1 = 2 
                  y2 -= a7 
                else 
                  if a1 = 3 
                    y2 += a7 
                  else              /* a1 = 4 
                    y1 += a7 
                  end 
                end 
              end 
              goto SR5 
            end 
            if a5 < 1 or a6 < 1 
              goto SR1 
            end 
            if a5 > 11 or a6 > 11 
              goto SR2 
            end 
            goto SR3 
*                            adjust parameters upward 
SR1:        a10 = a5 
            a11 = a6 
            if a6 < a5 
              a10 = a6 
              a11 = a5 
            end 
            a10 = 1 - a10        /* minimum amount to raise pars 
            if a7 < 10 
              a12 = a10 / 2 
              if a9 = 0          /* convex slur 
                a10 += rem 
              else 
                if a11 + a10 > 3 
                  a10 += rem 
                end 
              end 
            end 
            a5 += a10 
            a6 += a10 
            goto SR3 
*                              adjust parameters downward
SR2:        a10 = a5 
            a11 = a6 
            if a6 > a5 
              a10 = a6 
              a11 = a5 
            end 
            a10 -= 11            /* minimum amount to lower pars 
            if a7 < 10 
              a12 = a10 / 2 
              if a9 = 1          /* concave slur 
                a10 += rem 
              else 
                if a11 - a10 < 9 
                  a10 += rem 
                end 
              end 
            end 
            a5 -= a10 
            a6 -= a10 
SR3: 
&dA 
&dA &d@  get stock slur number and location  
&dA 
SR4:        a7 = x2 - x1 
            if notesize = 14 or notesize = 18 or notesize = 16   /* Modified (size-16) &dA12/31/08&d@ &dNnot OK
              if a7 < 10 
                --x1 
                ++x2 
                goto SR4 
              end 
            end 
            if notesize = 21      
              if a7 < 15 
                --x1 
                ++x2 
                goto SR4 
              end 
            end 
            if notesize = 6 
              if a7 < 5 
                --x1 
                ++x2 
                goto SR4 
              end 
            end 

            if notesize = 14 or notesize = 18 or notesize = 16   /* Modified (size-16) &dA12/31/08&d@ &dNnot OK
              a7 = x2 - x1 / 2 - 2         /* a7 should be less than 399 
            end 
            if notesize = 21 
              a7 = x2 - x1 + 1 / 3 - 2     /* a7 should be less than 199 
            end 
            if notesize = 6 
              a7 = x2 - x1 - 2             /* a7 should be less than 399 
            end 

            if notesize = 6 
              if a1 < 3 
                temp(1) = slurpar06(a5,a6,1) 
                temp(2) = slurpar06(a5,a6,2) 
                temp(3) = slurpar06(a5,a6,3) 
              else 
                temp(1) = slurpar06(a5,a6,4) 
                temp(2) = slurpar06(a5,a6,5) 
                temp(3) = slurpar06(a5,a6,6) 
              end 
            end 
            if notesize = 14 
              if a1 < 3 
                temp(1) = slurpar14(a5,a6,1) 
                temp(2) = slurpar14(a5,a6,2) 
                temp(3) = slurpar14(a5,a6,3) 
              else 
                temp(1) = slurpar14(a5,a6,4) 
                temp(2) = slurpar14(a5,a6,5) 
                temp(3) = slurpar14(a5,a6,6) 
              end 
            end 
            if notesize = 16 
              if a1 < 3 
                temp(1) = slurpar16(a5,a6,1) 
                temp(2) = slurpar16(a5,a6,2) 
                temp(3) = slurpar16(a5,a6,3) 
              else 
                temp(1) = slurpar16(a5,a6,4) 
                temp(2) = slurpar16(a5,a6,5) 
                temp(3) = slurpar16(a5,a6,6) 
              end 
            end 
            if notesize = 18 
              if a1 < 3 
                temp(1) = slurpar18(a5,a6,1) 
                temp(2) = slurpar18(a5,a6,2) 
                temp(3) = slurpar18(a5,a6,3) 
              else 
                temp(1) = slurpar18(a5,a6,4) 
                temp(2) = slurpar18(a5,a6,5) 
                temp(3) = slurpar18(a5,a6,6) 
              end 
            end 
            if notesize = 21 
              if a1 < 3 
                temp(1) = slurpar21(a5,a6,1) 
                temp(2) = slurpar21(a5,a6,2) 
                temp(3) = slurpar21(a5,a6,3) 
              else 
                temp(1) = slurpar21(a5,a6,4) 
                temp(2) = slurpar21(a5,a6,5) 
                temp(3) = slurpar21(a5,a6,6) 
              end 
            end 
            loop for t5 = 1 to 3 
              cc(t5) = 0 
              dd(t5) = 1 
            repeat 
            loop for t4 = 1 to (a7-2) 
              loop for t5 = 1 to 3 
                t6 = dd(t5) 
                if "zyxwvutsrqponmlkjihgfedcba@ABCDEFGHIJKLMNOPQRSTUVWXYZ" con temp(t5){t6}
                  aa(t5) = mpt - 27 
                  ++t6 
                else 
                  if temp(t5){t6} <> "+" and temp(t5){t6} <> "-" 
                    if (Debugg & 0x12) > 0 
                      pute Slur Coding Error 
                    end 
                  end 
                  if temp(t5){t6} = "+" 
                    t7 = 1 
                  else 
                    t7 = -1 
                  end 
                  ++t6 
                  t8 = 0 
SR6: 
                  if "0123456789" con temp(t5){t6} 
                    --mpt 
                    t8 *= 10 
                    t8 += mpt 
                    ++t6 
                    goto SR6 
                  end 
                  aa(t5) = t8 * t7 
                end 
                cc(t5) += aa(t5) 
                dd(t5) = t6 
              repeat 
            repeat 

            if a1 < 3 
              x1 += cc(1) 
              y1 -= cc(2) 
              a3 =  cc(3) 
            else 
              x1 += cc(1) 
              y1 += cc(2) 
              a3 =  cc(3) 
            end 
            x = x1 + sp 
            y = y1 + psq(f12) 
          else                    /* we don't use parametric method 
            if a1 < 3          /* tips down 
              c1 = y1 / pvpar(2) 
              if y1 > pvpar(1) and rem = 0 
                y1 = (c1 - 1) * pvpar(2) + pvpar(1) 
              end 
              c1 = y2 / pvpar(2) 
              if y2 > pvpar(1) and rem = 0 
                y2 = (c1 - 1) * pvpar(2) + pvpar(1) 
              end 
              a3 = abs(y1 - y2)        /* rise 
              y1 -= pvpar(2) 
            else 
              c1 = y1 / pvpar(2) 
              if y1 < pvpar(8) and rem = 0 
                y1 += pvpar(1)              /* OK 04-24-95 
              end 
              c1 = y2 / pvpar(2) 
              if y2 < pvpar(8) and rem = 0 
                y2 += pvpar(1)              /* OK 04-24-95 
              end 
              a3 = abs(y1 - y2)        /* rise 
              y1 += pvpar(2) 
            end 
            x = x1 + sp + pvpar(2) 
            y = y1 + psq(f12) 
            a7 = x2 - x1 - pvpar(1)        /* length 

            if notesize = 14 or notesize = 18 or notesize = 16   /* Modified (size-16) &dA12/31/08&d@ &dNnot OK
&dA 
&dA &d@      For 14-dot slurs, the distribution of length for stock slurs is a follows
&dA 
&dA &d@            Lengths        Length        Rise       Number 
&dA &d@            in dots      increments   increments   of types (possible)
&dA &d@          ÄÄÄÄÄÄÄÄÄÄ     ÄÄÄÄÄÄÄÄÄÄ   ÄÄÄÄÄÄÄÄÄÄ   ÄÄÄÄÄÄÄÄ 
&dA &d@            8 to 18           2            2           6 
&dA &d@           20 to 196          4            2          12 
&dA &d@          200 to 392          8            2          24 
&dA &d@          400 to 784         16            2          48 
&dA 
              if a7 < 8 
                a7 = 8 
              end 
              if a7 < 20 
                c1 = a7 / 2 
                if rem > 0          /* Fixing error: was &dEif rem > 1&d@  &dA12/18/04&d@ &dIOK
                  ++a7 
                end 
              else 
                if a7 < 200 
                  c1 = a7 / 4 
                  if rem > 1 
                    ++x 
                  end 
                  a7 -= rem 
                else 
                  if a7 < 400 
                    c1 = a7 / 8 
                    x += (rem >> 1) 
                    a7 -= rem 
                  else 
                    c1 = a7 / 16 
                    x += (rem >> 1) 
                    a7 -= rem 
                    if rem > 11 
                      x -= 8 
                      a7 += 16 
                    end 
                    if a7 >= 784 
                      a7 = 784 
                    end 
                  end 
                end 
              end 
&dA 
&dA &d@      For 14-dot slurs, 16-dot slurs and 18-dot slurs,  (Comment modified (size-16) &dA12/31/08&d@) &dNnot OK
&dA 
&dA &d@          Slur number = (rise * 1200) + (length * 3) + type number 
&dA &d@              number ranges from 8 to 143999 
&dA 
              c1 = a3 / 4 
              a3 -= rem 
              if a1 > 2 
                y += rem 
              end 
              a3 = a3 * 1200 + (a7 * 3) + 1 
            end 

            if notesize = 21 
&dA 
&dA &d@      For 21-dot slurs, the distribution of length for stock slurs is a follows
&dA 
&dA &d@            Lengths        Length        Rise       Number 
&dA &d@            in dots      increments   increments   of types (possible)
&dA &d@          ÄÄÄÄÄÄÄÄÄÄ     ÄÄÄÄÄÄÄÄÄÄ   ÄÄÄÄÄÄÄÄÄÄ   ÄÄÄÄÄÄÄÄ 
&dA &d@           12 to 27           3            2           6 
&dA &d@           30 to 294          6            2          12 
&dA &d@          300 to 600         12            2          24 
&dA 
              if a7 < 12 
                a7 = 12 
              end 
              if a7 < 30 
                a7 = a7 + 1 / 3 * 3 
              else 
                if a7 < 300 
                  a7 = a7 + 1 / 6 * 6 
                  rem >>= 1 
                  x += rem 
                else 
                  if a7 < 600 
                    a7 = a7 + 3 / 12 * 12 
                    rem >>= 1 
                    x += rem 
                  else 
                    a7 = 600 
                  end 
                end 
              end 
&dA 
&dA &d@      For 21-dot slurs,
&dA 
&dA &d@          Slur number = (rise * 600) + (length * 2) + type number 
&dA &d@              number ranges from 8 to 143999 
&dA 
              c1 = a3 / 4 
              a3 -= rem 
              if a1 > 2 
                y += rem 
              end 
              a3 = a3 * 600 + (a7 * 2) + 1 
            end 

            if notesize = 6 
&dA 
&dA &d@      For 6-dot slurs, the distribution of length for stock slurs is a follows
&dA 
&dA &d@            Lengths        Length        Rise       Number 
&dA &d@            in dots      increments   increments   of types (possible)
&dA &d@          ÄÄÄÄÄÄÄÄÄÄ     ÄÄÄÄÄÄÄÄÄÄ   ÄÄÄÄÄÄÄÄÄÄ   ÄÄÄÄÄÄÄÄ 
&dA &d@            4 to 9            1            1           6 
&dA &d@           10 to 98           2            1          12 
&dA &d@          100 to 396          4            1          24 
&dA 
              if a7 < 4 
                a7 = 4 
              end 
              if a7 > 9 
                if a7 < 100 
                  c1 = a7 / 2 
                  a7 -= rem 
                else 
                  if a7 < 396 
                    c1 = a7 / 4 
                    x += (rem >> 1) 
                    a7 -= rem 
                  else 
                    a7 = 396 
                  end 
                end 
              end 
&dA 
&dA &d@      For 6-dot slurs, 
&dA 
&dA &d@          Slur number = (rise * 2400) + (length * 6) + type number 
&dA &d@              number ranges from 8 to 143999 
&dA 
              c1 = a3 / 2 
              a3 -= rem 
              y += rem 
              a3 = a3 * 2400 + (a7 * 6) + 1 
            end 
          end 
          x += postx 
          y += posty 
          a3 += addcurve    /* new 6-30-93 

          if notesize = 14 
            if a3 > 120000                       /* max rise = 96 
              goto NOSTOCK 
            end 
          end 
          if notesize = 16 
            if a3 > 120000                       /* max rise = 96 &dA12/31/08&d@ &dNnot OK
              goto NOSTOCK 
            end 
          end 
          if notesize = 18                       /* New (size-18) &dA12/18/04&d@ &dIOK
            if a3 > 115200                       /* max rise = 92 
              goto NOSTOCK 
            end 
          end 
          if notesize = 21 
            if a3 > 70000 
              goto NOSTOCK 
            end 
          end 
&dA 
&dA &d@   a1 = case number   
&dA &d@   a3 = stock slur number   
&dA &d@   x = horizontal position    
&dA &d@   y = vertical position    
&dA 
&dA &d@   Enter new code for acquiring and printing slur 
&dA 
          a5 = 1 
          perform printslur_screen (a1, a3, x, y, a5, sitflag) 
          if a3 = 1000000 
            goto NOSTOCK 
          end 
          return 
        end 

NOSTOCK:                /* long slurs 

        y1 = save_y1                       /* added &dA01/03/05&d@, etc.  
        y2 = save_y2 
        x1 = save_x1 
        x2 = save_x2 

        if a1 < 3          /* tips down 
          c1 = y1 / pvpar(2) 
          if y1 > pvpar(1) and rem = 0 
            y1 = (c1 - 1) * pvpar(2) + pvpar(1) 
          end 
          c1 = y2 / pvpar(2) 
          if y2 > pvpar(1) and rem = 0 
            y2 = (c1 - 1) * pvpar(2) + pvpar(1) 
          end 
          a3 = abs(y1 - y2)        /* rise 
          y1 -= pvpar(2) 
        else 
          c1 = y1 / pvpar(2) 
          if y1 < pvpar(8) and rem = 0 
            y1 += pvpar(1)                /* OK 04-24-95 
          end 
          c1 = y2 / pvpar(2) 
          if y2 < pvpar(8) and rem = 0 
            y2 += pvpar(1)                /* OK 04-24-95 
          end 
          a3 = abs(y1 - y2)        /* rise 
          y1 += pvpar(2) 
        end 
        x = x1 + sp + pvpar(2) + postx 
        y = y1 + psq(f12) + posty 
        a7 = x2 - x1 - pvpar(1)        /* length 

        perform make_longslur (a7,a3,a1)     /* length,rise,smode 
                                             /* return: a7 = offset, a3 = height
        y = y - a7 
&dA 
&dA &d@    Code added &dA01/26/05&d@ to implement dotted slurs in NOSTOCK situation 
&dA &d@      1) Determine a5 = maximum length of slur 
&dA &d@      2) Construct tbt = dotted mask for this slur 
&dA 
        if sitflag = 1 
          a5 = 0 
          loop for t3 = 1 to a3 
            tbt = cbi(longslur(t3)) 
            a6 = bln(tbt) 
            if a6 > a5 
              a5 = a6 
            end 
          repeat 
          if a5 = 0 
            a5 = 100 
          end 
          a6 = a5 / gapsize 
          if bit(0,a6) = 0 
            --a6 
          end 
&dA 
&dA &d@           xxxxxxxxxxx....xxxx....xxxx....xxxx....xxxx....xxxxxxxxxxx 
&dA &d@                  |               odd number                 | 
&dA &d@          a6 = largest odd number of intervals that will fit inside a5   
&dA 
          a6 *= gapsize 
          a7 = a5 - a6 
          a7 >>= 1             /* initial correction 
          tbt = dup("1",a7) // dotted{1,a6} // dup("1",a7+10)   /* mask 
        end 
&dA                  &d@ End of this &dA01/26/05&d@ addition 

        scx = x 
        scy = y 

        c2 = 0 
        loop for t3 = 1 to a3 
&dA 
&dA &d@    Code added &dA01/26/05&d@ to implement dotted slurs in NOSTOCK situation 
&dA 
          if sitflag = 1 
            tbt2 = cbi(longslur(t3))      /* bit equivalent of longslur(t3) 
            tbt2 = bnd(tbt2,tbt)          /* &dEand&d@ this with mask 
            tbt2 = trm(tbt2)              /* and trm to length 
            longslur(t3) = cby(tbt2)      /* put this back in longslur(t3) 
          end 
&dA                  &d@ End of this &dA01/26/05&d@ addition 

          bt(t3) = cbi(longslur(t3)) 
          c1 = bln(bt(t3)) 
          if c1 > c2 
            c2 = c1 
          end 
        repeat 
*  
        ++sst_cnt 
        tput [SST,sst_cnt] Calling longslur at location <~scx ,~scy > 
        ++sst_cnt 
        tput [SST,sst_cnt] : 

        t1 = c2 + 7 / 8 * 8 

        loop for t3 = 1 to a3 
          sbt1 = upk(bt(t3)) 
          sbt1 = sbt1 // pad(t1) 
                         
          sbt2 = "" 
          t4 = 0 
          loop for t5 = 1 to t1 
            if t4 = 0 
              t4 = 0x04 
              if sbt1{t5} = "x" 
                t2 = 0x08 
              else 
                t2 = 0 
              end 
            else 
              if sbt1{t5} = "x" 
                t2 += t4 
              end 
              t4 >>= 1 
              if t4 = 0 
                if t2 < 10 
                  sbt2 = sbt2 // chs(t2) 
                else 
                  sbt2 = sbt2 // chr(55 + t2) 
                end 
              end 
            end 
          repeat 
          ++sst_cnt 
          tput [SST,sst_cnt] ~sbt2 
        repeat 
        ++sst_cnt 
        tput [SST,sst_cnt] : 
&dA 
&dA &d@     display slur contained in bt(a3) 
&dA 
        setb gstr,bt,scx,scy,a3,c2,1,3 
      return 
