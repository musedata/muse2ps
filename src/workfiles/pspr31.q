
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 31. circular (X,Y,type,nsize)                                        ³ 
&dA &d@³                                                                        ³ 
&dA &d@³    Operation:  Construct a circular type slur of length X and rise Y   ³ 
&dA &d@³                                                                        ³ 
&dA &d@³    Inputs:     real X          length                                  ³ 
&dA &d@³                real Y          rise                                    ³ 
&dA &d@³                int  type       curvature                               ³ 
&dA &d@³                int  nsize      [6,14,16,18,21]                         ³ 
&dA &d@³                                                                        ³ 
&dA &d@³    Output:     bstr slmap.4500(750)                                    ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure circular (X,Y,type,nsize) 
        real X,Y 
        real treal1,treal2
        int cir_leng 
        int t1,t2,t3,t4,t5 
        int type,nsize 
        int pc,pd,pe,pf,pg
        int scnt 
        real delta,alpha,beta
        real x,y,L,H,Cx,Cy,R,D
        real z,aa,bb,cc 
        real xx 
        real inpx,outpx,inpy,outpy,ind,outd 
        real sx(6000),sy(6000) 
        real flpd,flpc 

        getvalue X,Y,type,nsize 
&dA 
&dA &d@   compute R,L,H,Cx,Cy,beta 
&dA 
&dA &d@   1. L = (X*X + Y*Y)^1/2 
&dA 
        x = X * X 
        y = Y * Y 
        xx = x + y 
        L = sqt(xx) 
        cir_leng = fix(L) 
&dA 
&dA &d@   2. H:  Find smallest t1 such that L < slpara(type,t1+1).   H = flt(t1) 
&dA 
        if nsize = 6 
          treal1 = 2.33   /*  14 / 6 
          treal2 = 1.0 
        else                            /*  14: 2.0          14 / 7 
          treal1 = 14.0 / flt(nsize)    /*  16: 2.2857       16 / 7 
          treal2 = flt(nsize) / 7.0     /*  18: 2.5714       18 / 7 
        end                             /*  21; 3.0          21 / 7 

        loop for t1 = 1 to 55 
          if slpara(type,t1) > L * treal1    /* Factors added for different sizes
            if t1 = 1 
              H = 1.0 
            else 
              if t1 = 2 
                x = 1.0 
                y = 1.8 
              else 
                x = flt(t1-1) 
                x -= .2 
                y = x + 1.0 
              end 
              aa = L * treal1 - slpara(type,t1-1) 
              bb = slpara(type,t1) - (L * treal1)      /* Factor added
              cc = slpara(type,t1) - slpara(type,t1-1) 
              aa /= cc 
              bb /= cc 
              H = (x * bb) + (y * aa) 

              H /= treal1        /* Factor added.  Now correct H 
              if H < 1.0 
                H = 1.0 
              end 

            end 
            goto CBE_CAA 
          end 
        repeat 
&dA 
&dA &d@   3. R = L*L/H/8 + H/2 
&dA 
CBE_CAA: 
        x = xx / H / 8.0 
        y = H / 2.0 
        R = x + y 
&dA 
&dA &d@   4. Cx = X/2 + Y*(R - H)/L 
&dA 
        z = R - H / L 
        y = Y * z 
        Cx = X / 2.0 + y 
&dA 
&dA &d@   5. Cy = Y/2 - X*(R - H)/L 
&dA 
        x = X * z 
        Cy = Y / 2.0 - x 
&dA 
&dA &d@   6. beta = 2 * sin-1(L/2/R) 
&dA 
        x = L / 2.0 / R 
        beta = 2.0 * ars(x) 
&dA 
&dA &d@   normalize D-function 
&dA 
        xx = L / treal2       /* &dA04-25-95&d@   changed from L / 2.0 
        D = sqt(xx) / 4.8 
        if D > 1.50 
          D -= .16         /* radical 
          if H / L > .200     /* &dA10-28-94&d@   This is a ratio; no change.  
            D -= .10 
          end 
        end 
        if D > 1.70 
          D = D - 1.70 * .2 + 1.70 
        end 
        if D > 1.95 
          D = D - 1.95 * .3 + 1.95 
        end 
        D /= treal1           /* &dA04-25-95&d@    Correction to D 

        if nsize > 14 
          if D > 2.0 
            D = D - 2.00 * .5 + 2.00  /* &dA05-16-95&d@    added to thin out the circular slurs
          end 
          if D < .9 
            D = .9 
          end 
        else 
          if nsize < 14 
            if D < .4 
              D = .4 
            end 
          end 
        end 

&dEÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿&d@ 
&dE³        S W E E P    L O O P            ³&d@ 
&dEÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ&d@ 

        delta = beta / 4.0 / L         /* four samples per dot 
        alpha = 0.0 
        scnt = 0 

        loop while alpha < beta 
          ++scnt 
&dA 
&dA &d@   1. compute bb = sin(alpha), aa = 1 - cos(alpha) 
&dA 
          bb = sin(alpha) 
          aa = 1.0 - cos(alpha) 
&dA 
&dA &d@   2. compute (x,y) 
&dA 
          cc = Cy * bb 
          sx(scnt) = Cx * aa - cc 
          cc = Cx * bb 
          sy(scnt) = Cy * aa + cc 
&dA 
&dA &d@   3. increment alpha 
&dA 
          alpha += delta 
        repeat
        ++scnt 
        sx(scnt) = X 
        sy(scnt) = Y 

&dEÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿&d@ 
&dE³  E N D   O F   S W E E P.    C O N S T R U C T   S L U R     ³&d@ 
&dEÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ&d@ 

        if cir_leng < 200 
          if nsize < 16 
            pc = 14 * scnt / 100         /* left hand side of slur 
            pd = 42 * scnt / 1000        /* extreme left end 
            pe = 86 * scnt / 100         /* right hand side of slur 
            pf = 958 * scnt / 1000       /* extreme right end 
          else 
            if nsize < 21 
              pc = 11 * scnt / 100       /* left hand side of slur 
              pd = 33 * scnt / 1000      /* extreme left end 
              pe = 89 * scnt / 100       /* right hand side of slur 
              pf = 967 * scnt / 1000     /* extreme right end 
            else 
              pc = 12 * scnt / 100       /* left hand side of slur 
              pd = 100 * scnt / 1000     /* extreme left end 
              pe = 88 * scnt / 100       /* right hand side of slur 
              pf = 900 * scnt / 1000     /* extreme right end 
            end 
          end 
        else 
          if nsize < 16 
            t1 = 1000 - cir_leng         /* 800 times too big 
            pc = 14 * t1 
            pd = 42 * t1 
            pe = 80000 - pc 
            pf = 800000 - pd 
            pc = pc * scnt / 80000       /* left hand side of slur 
            pd = pd * scnt / 800000      /* extreme left end 
            pe = pe * scnt / 80000       /* right hand side of slur 
            pf = pf * scnt / 800000      /* extreme right end 
          else 
            pc = cir_leng * 100 / (cir_leng + 600) /* left hand side of slur
            pd = pc * 3 / 10                       /* extreme left end 
            pe = scnt - pc                         /* right hand side of slur
            pf = scnt - pd                         /* extreme right end 
          end 
        end 
        flpd = flt(pd) 
        flpc = flt(pc) 

        loop for t1 = 1 to scnt 
          x = sx(t1) 
          y = sy(t1) 
&dA 
&dA &d@   1. compute ind, outd 
&dA 
          if nsize < 16 
            if t1 < pc                   /* left hand side of slur 
              ind = 0.0 
              if t1 < pd                 /* extreme left end 
                if flpc = 0.0 
                  outd = .4                        /* &dEwas .1&d@ 
                else 
                  outd = flt(t1) / flpc + .4       /* &dEwas .1&d@ 
                end 
              else 
                outd = .4 
              end 
              goto CBE_CCD 
            end 
            if t1 > pe                   /* right hand side of slur 
              ind = 0.0 
              if t1 >= pf                /* extreme right end 
                t2 = scnt - t1 
                if flpc = 0.0 
                  outd = .4                        /* &dEwas .1&d@ 
                else 
                  outd = flt(t2) / flpc + .4       /* &dEwas .1&d@ 
                end 
              else 
                outd = 0.4 
              end 
              goto CBE_CCD 
            end 
          else 
            if nsize = 16 
              if t1 < pc                   /* left hand side of slur 
                ind = 0.7                  /* &dA05-13-95&d@  changed from 1.3 
                if t1 < pd                 /* extreme left end 
                  outd = .2 * flt(t1) / flpd + .0 
                else 
                  outd = .2 
                end 
                goto CBE_CCD 
              end 
              if t1 > pe                   /* right hand side of slur 
                ind = 0.7                  /* &dA05-13-95&d@  changed from 1.3 
                if t1 >= pf                /* extreme right end 
                  t2 = scnt - t1 
                  if flpd > 0.0 
                    outd = 0.2 * flt(t2) / flpd + .0 
                  else 
                    outd = 0.2 
                  end 
                else 
                  outd = 0.2 
                end 
                goto CBE_CCD 
              end 
            else 
              if nsize = 18 
                if t1 < pc                   /* left hand side of slur 
                  ind = 0.7                  /* &dA05-13-95&d@  changed from 1.3 
                  if t1 < pd                 /* extreme left end 
                    outd = .4 * flt(t1) / flpd + .3 
                  else 
                    outd = .7 
                  end 
                  goto CBE_CCD 
                end 
                if t1 > pe                   /* right hand side of slur 
                  ind = 0.7                  /* &dA05-13-95&d@  changed from 1.3 
                  if t1 >= pf                /* extreme right end 
                    t2 = scnt - t1 
                    if flpd > 0.0 
                      outd = 0.4 * flt(t2) / flpd + .3 
                    else 
                      outd = 0.7 
                    end 
                  else 
                    outd = 0.7 
                  end 
                  goto CBE_CCD 
                end 
              else 
                if t1 < pc                   /* left hand side of slur 
                  ind = 0.7                  /* &dA05-13-95&d@  changed from 1.3 
                  if t1 < pd                 /* extreme left end 
                    outd = .3 * flt(t1) / flpd + .0 
                  else 
                    outd = .3 
                  end 
                  outd -= .1 
                  goto CBE_CCD 
                end 
                if t1 > pe                   /* right hand side of slur 
                  ind = 0.7                  /* &dA05-13-95&d@  changed from 1.3 
                  if t1 >= pf                /* extreme right end 
                    t2 = scnt - t1 
                    outd = 0.3 * flt(t2) / flpd + .0 
                  else 
                    outd = 0.3 
                  end 
                  outd -= .1 
                  goto CBE_CCD 
                end 
              end 
            end 
          end 

    /* middle of slur 
          if t1 > scnt / 2             /* right side 
            t2 = pe - t1 
          else                         /* left side 
            t2 = t1 - pc 
          end 
          t5 = scnt / 2 - pc 
          bb = flt(t2) * ars(1.0) / flt(t5)  /* max(bb) = sin-1(1) 
          aa = sin(bb) 
          if nsize < 16 
            outd = D - 0.4 * aa + 0.4     
            ind = aa * D 
          else 
            if nsize = 16 
              outd = D - 0.1 * aa + 0.2 
            else 
              if nsize = 18 
                outd = D - 0.7 * aa + 0.7 
              else 
                outd = D - 0.2 * aa + 0.2 
              end 
            end 
            ind = D - 0.7 * aa + 0.7 
          end 
&dA 
&dA &d@   2. compute outside point, inside point 
&dA 
CBE_CCD: 
          if nsize > 10 
            if nsize < 15 
              outd += .49000            /* &dEwas .29000&d@ 
              ind  += .49000            /* &dEwas .29000&d@ 
            else 
              if nsize = 16 
                outd += 0.50000 
                ind  += 0.30000 
              else 
                if nsize = 18 
                  outd += 0.90000 
                  ind  += 0.90000 
                else 
                  outd += 0.99000 
                  ind  += 0.99000 
                end 
              end 
            end 
          else 
            outd += .19000 
            ind  += .19000 
          end 

          aa = x - Cx * outd / R 
          bb = y - Cy * outd / R 
          outpx = x + aa 
          outpy = y + bb 
          aa = x - Cx * ind / R 
          bb = y - Cy * ind / R 
          inpx = x - aa 
          inpy = y - bb 
&dA 
&dA &d@   3. compute box coordinates 
&dA 
          if outpx < inpx 
            aa = outpx 
            outpx = inpx 
            inpx = aa 
          end 
          if outpy < inpy 
            aa = outpy 
            outpy = inpy 
            inpy = aa 
          end 
          outpx = outpx + 30.0 * 3. - .5 
          inpx  = inpx  + 30.0 * 3. - .5 
          outpy = outpy + 20.0 * 3. - .5 
          inpy  = inpy  + 20.0 * 3. - .5 
          if nsize < 16 
            inpx -= .5 
            outpx -= .5 
          end 
          x1 = fix(inpx) 
          x2 = fix(outpx) 
          y1 = fix(inpy) 
          y2 = fix(outpy) 
          if x2 - x1 < 2 
            ++y2                  /* radical 
          end 
&dA 
&dA &d@   4. set points inside box to 1 (with inverted vertical axis) 
&dA 
          if x1 < 1                    /* New code &dA10-31-04&d@ 
            x1 = 1                     /* New code &dA10-31-04&d@ 
          end                          /* New code &dA10-31-04&d@ 
          loop for t2 = y1 to y2 
            t4 = 750 - t2 
            loop for t3 = x1 to x2 
              slmap(t4){t3} = "1" 
            repeat 
          repeat 
        repeat 

      return 
