 
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
&dA &d@³D* 30. construct_bigslur_element (case,nsize,snum,rise,height,maxlen,bulge)  ³
&dA &d@³                                                                             ³
&dA &d@³    Operation:  This procedure is a replacement for the set of               ³
&dA &d@³                bigslur files used by the dskpage family of programs.        ³
&dA &d@³                Given a case (1 to 4), a notesize (6,14,16,18,21) and        ³
&dA &d@³                a slur number (from the slurpar data), this procedure        ³
&dA &d@³                constructs the requested slur on the fly.  Code for          ³
&dA &d@³                this procedure (and its two satalites) was lifted            ³
&dA &d@³                directly from the create programs                            ³
&dA &d@³                                                                             ³
&dA &d@³    Inputs:     int case:   1 = rising,convex                                ³
&dA &d@³                            2 = falling,convex                               ³
&dA &d@³                            3 = rising,concave                               ³
&dA &d@³                            4 = falling,concave                              ³
&dA &d@³                int nsize   [6,14,16,18,21]                                  ³
&dA &d@³                int snum    1200 < ... < 144000  from slurpars               ³
&dA &d@³                                                                             ³
&dA &d@³    Output:     bstr bt.2500(250)                                            ³
&dA &d@³                                                                             ³
&dA &d@³    There are also the following outputs:                                    ³
&dA &d@³                                                                             ³
&dA &d@³                int rise                                                     ³
&dA &d@³                int height  number of rows of data                           ³
&dA &d@³                int maxlen  actual length of slur generated                  ³
&dA &d@³                int bulge   the amount of left bulge in a vertical           ³
&dA &d@³                              convex rising, or concave falling slur         ³
&dA &d@³                                                                             ³
&dA &d@³    Calling procedure:  &dCprintslur_screen&d@  We need to do this because         ³
&dA &d@³                        there may be a dotted mask, and because that         ³
&dA &d@³                        procudure writes to the postscript dictionary        ³
&dA &d@³                                                                             ³
&dA &d@³    Procedures called:  &dCcircular&d@  and  &dCasymetric&d@                             ³
&dA &d@³                                                               (possible)    ³
&dA &d@³           Lengths                      Length        Rise       Number      ³
&dA &d@³           in dots                    increments   increments   of types     ³
&dA &d@³         ÄÄÄÄÄÄÄÄÄÄ                   ÄÄÄÄÄÄÄÄÄÄ   ÄÄÄÄÄÄÄÄÄÄ   ÄÄÄÄÄÄÄÄ     ³
&dA &d@³&dE  4 to 9  &d@  &dI  8 to 18 &d@  &dA 12 to 27 &d@    &dE1&d@  &dI 2&d@  &dA 3&d@    &dE1&d@   &dI2&d@   &dA2&d@    &dE 6&d@  &dI 6&d@  &dA 6&d@   ³
&dA &d@³&dE 10 to 98 &d@  &dI 20 to 196&d@  &dA 30 to 294&d@    &dE2&d@  &dI 4&d@  &dA 6&d@    &dE1&d@   &dI2&d@   &dA2&d@    &dE12&d@  &dI12&d@  &dA12&d@   ³
&dA &d@³&dE100 to 396&d@  &dI200 to 392&d@  &dA300 to 588&d@    &dE4&d@  &dI 8&d@  &dA12&d@    &dE1&d@   &dI2&d@   &dA2&d@    &dE24&d@  &dI24&d@  &dA24&d@   ³
&dA &d@³            &dI400 to 784&d@                   &dI16&d@            &dI2&d@            &dI48&d@       ³
&dA &d@³                                                                             ³
&dA &d@³                &dE(rise * 2400) + (length * 6)&d@                 &dEmax rise = 58 &d@  ³
&dA &d@³  Slur number = &dI(rise * 1200) + (length * 3)&d@  + type number  &dImax rise = 116&d@  ³
&dA &d@³                &dA(rise * 600) + (length * 2)&d@                  &dAmax rise = 236&d@  ³
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
      procedure construct_bigslur_element (case,nsize,snum,rise,height,maxlen,bulge)
        str out.1000 
        str newout.1000 

        bstr zeros.4500, temp.4500 
        int t1,t2,t3,t4,t5,t6,t7 
        int ii,jj
        int rise,type,length 
        int acc(1200) 
        int version 

        real X,Y,YY 
        real tenX,tenY 

        int xpnt,maxlen 
        int trycnt 
        int toplead(200),toptrail(200) 
        int topdiff(200) 
        str tstr.1000 
        int nsize,snum,case 
        int height,bulge 
        int h2l_ratio 

        table TTT(10000) 

&dA*   I. Set parameters                       

        zeros = zpd(4500) 

        getvalue case,nsize,snum 

        if nsize = 21 
          rise = snum / 1200        /* rem = 0 ... 1199 
          rise *= 2                 /* max is 238 
          if rise = 238 
            rise = 236 
          end 
        else 
          rise = snum / 2400        /* rem = 0 ... 2399  max rise = 59 
          if nsize = 6 
            if rise = 59 
              rise = 58 
            end 
          else 
            rise *= 2               /* max is 118 
            if rise = 118 
              rise = 116 
            end 
          end 
        end 
        snum = rem 
        if nsize = 6 
          length = snum / 6         /* rem = 0 ... 5 
          type = rem 
          if length > 9 
            length = snum / 12      /* rem = 0 ... 11 
            type = rem 
            length *= 2 
            if length > 98 
              length = snum / 24    /* rem = 0 ... 23 
              type = rem 
              length *= 4 
            end 
          end 
        else 
          if nsize < 21 
            length = snum / 6         /* rem = 0 ... 5 
            type = rem 
            length *= 2               /* max = 798 
            if length > 18 
              length = snum / 12      /* rem = 0 ... 11 
              type = rem 
              length *= 4             /* max = 796 
              if length > 196 
                length = snum / 24    /* rem = 0 ... 23 
                type = rem 
                length *= 8           /* max = 792 
                if length > 392 
                  length = snum / 48  /* rem = 0 ... 47 
                  type = rem 
                  length *= 16        /* max = 784 
                end 
              end 
            end 
          else 
            length = snum / 6         /* rem = 0 ... 5 
            type = rem 
            length *= 3               /* max = 597 
            if length > 27 
              length = snum / 12      /* rem = 0 ... 11 
              type = rem 
              length *= 6             /* max = 594 
              if length > 294 
                length = snum / 24    /* rem = 0 ... 23 
                type = rem 
                length *= 12          /* max = 588 
              end 
            end 
          end 
        end 

        if nsize = 6 
          if rise > 31 
            t3 = rise / 2 
            if rem > 0 
              rise += 1 
            end 
          end 
        else 
          if rise > 62 
            t3 = rise / 4 
            if rem > 0 
              rise += 2 
            end 
          end 
        end 
* 

&dA*   III. Beginning of Construction            

        h2l_ratio = rise / length 
        YY = flt(rise) 
        t3 = length - 1 
        X = flt(t3) 

        Y = YY 

  /* Set version and type numbers 

        if nsize = 6 
          if length < 10 
            version = 0              /* circular only 
            if type > 2 
              type -= 2 
            end 
            type += 2                /* type = 2, 3, or 4 
            ++type                   /* &dATemporary "fix"&d@ to accommodate the older slurpar files
          else 
            if length < 60 
              version = 0            /* circular only 
              if type > 5 
                type -= 6 
              end 
              ++type                 /* type = 1, 2, 3, 4, 5, or 6 
              if type < 6 
                ++type               /* &dATemporary "fix"&d@ to accommodate the older slurpar files
              end 
            else 
              if length < 100 
                if type < 6 
                  version = 0          /* circular 
                  ++type               /* type = 1, 2, 3, 4, 5, or 6 
                else 
                  if type < 9 
                    version = 1        /* high right 
                  else 
                    version = 2        /* symmetric 
                  end 
                  t3 = type / 3 
                  if version = 1 
                    rem <<= 1            /* rem = 0, 2, or 4 
                    type = rem + 1       /* type = 2, 4 or 6 
                  else 
                    type = rem + 2       /* type = 2, 3 or 4 
                  end 
                end 
                if type < 6 and version = 0 
                  ++type             /* &dATemporary "fix"&d@ to accommodate the older slurpar files
                end 
              else 
                if length < 200 
                  version = type  / 8  /* version = 0, 1, or 2 
                  type = rem + 1       /* type = 1 -> 8 
                else 
                  if type > 9 
                    type = 9 
                  end 
                  if type < 5 
                    version = 1        /* high right 
                  else 
                    version = 2        /* symmetric 
                  end 
                  t3 = type / 5 
                  type = rem + 2       /* type = 2,3,4,5,6 
                  if type < 6 
                    --type             /* type = 1,2,3,4,6 
                  end 
                end 
                if type < 8 and version = 0 
                  ++type             /* &dATemporary "fix"&d@ to accommodate the older slurpar files
                end 
              end 
            end 
          end 
        else 
          if nsize = 21 
            if length < 30 
              if type > 5              /* only six types 
                type -= 6 
              end 
              version = 0              /* circular only 
              t3 = type / 3 
              type = rem + 2           /* type = 2, 3, 4  (5,6,7) 
              if type > 4 
                type -= 3 
                ++rise 
                Y += 1.0 
              end 
            else 
              if length < 180 
                if type > 5 
                  type -= 6 
                end 
                version = 0            /* circular only 
                t3 = type / 6 
                type = rem + 1         /* type = 1, 2, 3, 4, 5, or 6 
              else 
                if length < 300 
                  if type > 11 
                    type -= 12 
                  end 
                  if type < 6 
                    version = 0          /* circular 
                    t3 = type / 6 
                    type = rem + 1       /* type = 1, 2, 3, 4, 5, or 6 
                  else 
                    if type < 9 
                      version = 1        /* high right 
                    else 
                      version = 2        /* symmetric 
                    end 
                    t3 = type / 3 
                    if version = 1 
                      rem <<= 1            /* rem = 0, 2, or 4 
                      type = rem + 1       /* type = 2, 4 or 6 
                    else 
                      type = rem + 2       /* type = 2, 3 or 4 
                    end 
                  end 
                else 
                  version = type / 8   /* version = 0, 1, or 2 
                  type = rem + 1       /* type = 1 -> 8 
                end 
              end 
            end 
          else 
            if length < 20 
              if type > 5              /* only six types 
                type -= 6 
              end 
              version = 0              /* circular only 
              t3 = type / 3 
              type = rem + 2           /* type = 2, 3, or 4  (5,6,7) 
              if type > 4 
                type -= 3 
                ++rise 
                Y += 1.0 
              end 
              if type < 6 and nsize = 14 
                ++type                 /* &dATemporary "fix"&d@ to accommodate the older slurpar files
              end 
            else 
              if length < 120 
                if type > 5 
                  type -= 6 
                end 
                version = 0            /* circular only 
                t3 = type / 6 
                type = rem + 1         /* type = 1, 2, 3, 4, 5, or 6 
                if type < 6 and nsize = 14 
                  ++type               /* &dATemporary "fix"&d@ to accommodate the older slurpar files
                end 
              else 
                if length < 200 
                  if type > 11 
                    type -= 12 
                  end 
                  if type < 6 
                    version = 0          /* circular 
                    t3 = type / 6 
                    type = rem + 1       /* type = 1, 2, 3, 4, 5, or 6 
                    if type < 6 and nsize = 14 
                      ++type             /* &dATemporary "fix"&d@ to accommodate the older slurpar files
                    end 
                  else 
                    if type < 9 
                      version = 1        /* high right 
                    else 
                      version = 2        /* symmetric 
                    end 
                    t3 = type / 3 
                    if version = 1 
                      rem <<= 1            /* rem = 0, 2, or 4 
                      type = rem + 1       /* type = 2, 4 or 6 
                    else 
                      type = rem + 2       /* type = 2, 3 or 4 
                    end 
                  end 
                else 
                  if length < 400 
                    version = type / 8   /* version = 0, 1, or 2 
                    type = rem + 1       /* type = 1 -> 8 
                  else 
                    if type > 9 
                      type = 9 
                    end 
                    if type < 6 
                      version = 1        /* high right 
                    else 
                      version = 2        /* symmetric 
                    end 
                    t3 = type / 5 
                    type = rem + 2       /* type = 2,3,4,5,6 
                  end 
                  if type < 6 and nsize = 14 and version = 0 
                    ++type               /* &dATemporary "fix"&d@ to accommodate the older slurpar files
                  end 
                end 
              end 
            end 
          end 
        end 
&dA 
&dA &d@   clear slur array 
&dA 
        tenX = X 
        tenY = Y 
        trycnt = 0 
CBE_RETRY: 

        loop for t3 = 1 to 750 
          slmap(t3) = zpd(4500) 
        repeat 

        if version = 0 
          perform circular (tenX,tenY,type,nsize) 
        else 
          perform asymetric (tenX,tenY,type,length,version,nsize)  /* magic 
        end 
&dA 
&dA &d@   determine size of slmap display 
&dA 
        loop for t3 = 1 to 750 
          if slmap(t3) <> zeros 
            goto CBE_CE 
          end 
        repeat 
        pute all Zeros 
        stop 
CBE_CE: 
        y1 = t3 - 1 
        loop for t4 = t3 to 750 
          if slmap(t4) = zeros and slmap(t4+1) = zeros 
            goto CBE_CF 
          end 
        repeat 
CBE_CF: 
        y2 = t4 - 1 
        loop for t4 = 1 to 4500 
          loop for t3 = y1 to y2 
            if slmap(t3){t4} = "1" 
              goto CBE_CH 
            end 
          repeat 
        repeat 
CBE_CH: 
        if nsize = 16 or nsize = 18 
          x1 = t4                      /* try this &dA10-31-04&d@ 
        else 
          x1 = t4 - 1 
        end 
        x2 = 0 
        loop for t3 = y1 to y2 
          temp = trm(slmap(t3)) 
          if x2 < bln(temp) 
            x2 = bln(temp) 
          end 
        repeat 
&dA 
&dA &d@   write slur to screen    (New &dA10-31-04&d@:  writing of slur delayed) 
&dA 
        x2 = x2 - x1 + 3 / 3 * 3        /* x range 
        loop for t3 = y1 to y2 
          slmap(t3) = slmap(t3){x1,x2} 
        repeat 
        t2 = y2 - y1 + 3 / 3 * 3        /* y range 

        t2 = t2 / 3                     /* t2 = number of vert rows 
        t1 = x2 / 3                     /* t1 = number of horiz cols 

        treset [TTT]                    /* New &dA10-31-04&d@ 

        xpnt = 0                        /* New &dA10-31-04&d@ 
        maxlen = 0                      /* New &dA10-31-04&d@ 

        loop for t3 = 1 to t2 
          loop for t5 = 1 to t1 
            acc(t5) = 0                 /* clear accumulators 
          repeat 
          loop for t4 = 1 to 3 
            t7 = 1                      /* t7 = column counter 
            loop for t5 = 1 to t1 
              loop for t6 = 1 to 3 
                if slmap(y1){t7} = "1" 
                  ++acc(t5) 
                end 
                ++t7                    /* advance column 
              repeat 
            repeat 
            ++y1                        /* advance row 
          repeat 
          out = pad(t1) 
          loop for t5 = 1 to t1 
            if acc(t5) > 3 
              out{t5} = "x" 
            end 
          repeat 
          out = trm(out) 

          ii = len(out) 
          if ii > maxlen 
            maxlen = ii 
          end 
&dA 
&dA &d@     New &dA10-31-04&d@:  Slur compaction and writing is delayed 
&dA &d@                    Send output temporarily - TTT table.  
&dA 
          if out = "" and (t3 = 1 or t3 = t2) 
          else 
            newout = out 
            ++xpnt 
            tput [TTT,xpnt] ~newout 
          end 
        repeat 
&dA 
&dA &d@    New Code &dA10-31-04&d@:  If the actual length is different than the requested
&dA &d@                        (planned) length, then adjust tenX and try again.  
&dA 
        if h2l_ratio > 1 
          goto CBE_NO_CHANGE 
        end 

        if trycnt = 0 
          if maxlen > length 
            tenX -= .9 
            --trycnt 
            goto CBE_RETRY 
          end 
          if maxlen < length 
            tenX += .9 
            ++trycnt 
            goto CBE_RETRY 
          end 
        end 
        if trycnt > 0 
          if maxlen < length 
            tenX += .9 
            ++trycnt 
            goto CBE_RETRY 
          end 
        end 
        if trycnt < 0 
          if maxlen > length 
            tenX -= .9 
            if tenX < 0.0 
              tenX = 0.0 
              trycnt = 1000 
            end 
            --trycnt 
            goto CBE_RETRY 
          end 
        end 
&dA 
&dA &d@     New Code &dA10-31-04&d@:  Make adjustments to slur shape (important code) 
&dA 
        if rise > 3 * length / 2 
          goto CBE_NO_CHANGE 
        end 

        loop for t3 = 1 to 200 
          toplead(t3)     = 0 
          toptrail(t3)    = 1000 
        repeat 

        loop for t3 = 1 to xpnt 
          tget [TTT,t3] out 
          tstr = mrt(out) 
          toplead(xpnt - t3 + 1) = len(out) - len(tstr) + 1 
          tstr = trm(out) 
          if t3 = 1 
            t4 = len(tstr) 
          end 
          t5 = len(tstr) 
          if t5 >= t4 
            toptrail(xpnt - t3 + 1) = t5 
          end 
        repeat 
&dA 
&dA &d@   1. Fix top of slur 
&dA 
        if toptrail(xpnt-1) < 1000 
          t4 = toptrail(xpnt) - toplead(xpnt) + 1 
          t5 = toptrail(xpnt-1) - toplead(xpnt-1) + 1 

          loop while t4 <= (2 * t5 / 5) 
            ++toptrail(xpnt) 
            --toplead(xpnt) 
            t4 += 2 
          repeat 
          tget [TTT,1] out 
          out = out // pad(999) 

          t5 = toplead(xpnt) 
          loop while out{t5} = " " 
            out{t5} = "x" 
            ++t5 
          repeat 
          loop while t5 <= toptrail(xpnt) 
            if out{t5} = " " 
              out{t5} = "x" 
            end 
            ++t5 
          repeat 
          out = out{1,length} 
          out = trm(out) 

          tput [TTT,1] ~out 
        end 
&dA 
&dA &d@   2. Fix outside rising part of slur (left side) 
&dA 
        loop for t3 = 1 to xpnt - 1 
          t4 = toplead(t3) 
          t5 = toplead(t3+1) 
          topdiff(t3) = t5 - t4 
        repeat 

        loop for t3 = 1 to xpnt - 4 
          if topdiff(t3) <> topdiff(t3+1) 
            t5 = topdiff(t3) + topdiff(t3+1) 
            t5 = t5 / 2 
            t4 = rem 
            topdiff(t3) = t5 
            topdiff(t3+1) = t5 
            if t4 = 1 
              ++topdiff(t3+1) 
            end 
            if t3 < xpnt - 5 
              ++t3 
            end 
          end 
        repeat 

        loop for t3 = 1 to xpnt - 4 
          if topdiff(t3) > topdiff(t3+1) + 1 
            --topdiff(t3) 
            ++topdiff(t3+1) 
          end 
        repeat 

        loop for t3 = 1 to xpnt - 1 
          toplead(t3+1) = toplead(t3) + topdiff(t3) 
        repeat 
        loop for t3 = 1 to xpnt 
          t4 = xpnt + 1 - t3 
          tget [TTT,t4] out 
          t5 = toplead(t3) 
          if t5 > 1 and t5 <= len(out) 
            out{1,t5-1} = pad(t5-1) 
            loop while out{t5} = " " 
              out{t5} = "x" 
              ++t5 
            repeat 
          end 
          tput [TTT,t4] ~out 
        repeat 
&dA 
&dA &d@   3. Fix outside decending side (right side) 
&dA 
        loop for t3 = 1 to xpnt - 1 
          t4 = toptrail(t3) 
          t5 = toptrail(t3+1) 
          if t5 < 1000 and t4 < 1000 
            topdiff(t3) = t4 - t5 
          else 
            topdiff(t3) = 1000 
          end 
        repeat 

        loop for t3 = 1 to xpnt - 4 
          if topdiff(t3) < 1000 
            if topdiff(t3) <> topdiff(t3+1) 
              t5 = topdiff(t3) + topdiff(t3+1) 
              t5 = t5 / 2 
              t4 = rem 
              topdiff(t3) = t5 
              topdiff(t3+1) = t5 
              if t4 = 1 
                ++topdiff(t3+1) 
              end 
              if t3 < xpnt - 5 
                ++t3 
              end 
            end 
          end 
        repeat 

        loop for t3 = 1 to xpnt - 4 
          if topdiff(t3) < 1000 
            if topdiff(t3) > topdiff(t3+1) + 1 
              --topdiff(t3) 
              ++topdiff(t3+1) 
            end 
          end 
        repeat 

        loop for t3 = xpnt - 1 to 1 step -1 
          if topdiff(t3) < 1000 
            toptrail(t3) = toptrail(t3+1) + topdiff(t3) 
          end 
        repeat 

        loop for t4 = 1 to xpnt 
          tget [TTT,t4] out 
          t5 = toptrail(xpnt + 1 - t4) 
          if t5 < 1000 
            out = out // pad(999) 
            if out{t5} = " " 
              out{t5} = "x" 
              if out{t5-1} = " " 
                out{t5-1} = "x" 
                if out{t5-2} = " " 
                  out{t5-2} = "x" 
                  if out{t5-3} = " " 
                    out{t5-3} = "x" 
                  end 
                end 
              end 
            end 
            if out{t5+1} = "x" 
              out{t5+1} = " " 
            end 
            if out{t5+2} = "x" 
              out{t5+2} = " " 
            end 
            if out{t5+3} = "x" 
              out{t5+3} = " " 
            end 
            out = trm(out) 
          end 

          tput [TTT,t4] ~out 
        repeat 

CBE_NO_CHANGE: 

&dA 
&dA &d@  Here is where the slur is processed 
&dA 
&dA &d@   4. Store slur in bstr bt.2500(250) 
&dA 
        if case < 3 
          jj = 1 
        else 
          jj = xpnt 
        end 
        loop for t4 = 1 to xpnt 
          tget [TTT,t4] out 
          out = out // pad(length) 
          out = out{1,length} 
          if case = 2 or case = 3 
            out = rev(out) 
          end 
          bt(jj) = pak(out) 
          if case < 3 
            ++jj 
          else 
            --jj 
          end 
        repeat 
&dA 
&dA &d@   5. Now display the slur on the screen 
&dA 
        height = xpnt 
        passback rise,height,maxlen,bulge 
      return 
