
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 32. asymetric (X,Y,type,length,version,nsize)                        ³ 
&dA &d@³                                                                        ³ 
&dA &d@³    Operation:  Construct a three curve slur of length X and rise Y     ³ 
&dA &d@³                                                                        ³ 
&dA &d@³    Inputs:     real X          length                                  ³ 
&dA &d@³                real Y          rise                                    ³ 
&dA &d@³                int  type       curvature                               ³ 
&dA &d@³                int  length     integer length (for setting height)     ³ 
&dA &d@³                int  version    1 = symmetric, 2 = asymmetric           ³ 
&dA &d@³                int  nsize      [6,14,16,18,21]                         ³ 
&dA &d@³                                                                        ³ 
&dA &d@³    Output:     bstr slmap.4500(750)                                    ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure asymetric (X,Y,type,length,version,nsize) 
        real X,Y 
        real PP, QQ 
        real rtype 
        real treal1
        real delta,alpha,beta,delta2,beta2 
        real x,y,L,H,Cx,Cy,R,D
        real W,Q,P,A,B,Ca,Cb 
        real aa,bb,cc 
        real xx,yy,u,v 
        real inpx,outpx,inpy,outpy,ind,outd 
        real sx(6000),sy(6000) 
        real flpd,flpf 

        int truelen 
        int t1,t2,t3,t4,t5 
        int type,length,version,nsize 
        int pc,pd,pe,pf,pg,ph 
        int scnt 

        getvalue X,Y,type,length,version,nsize 
        if nsize = 6 
          treal1 = 2.0    /*  14 / 7 
        else                            /*  14: 2.0          14 / 7 
          treal1 = 14.0 / flt(nsize)    /*  16: 2.2857       16 / 7 
        end                             /*  21; 3.0          21 / 7 

        X *= treal1               /* &dA04-25-95&d@  all computations done 
        Y *= treal1               /* at original size.  
        truelen = length * 14 / nsize 

        rtype = flt(type) 
        L = flt(truelen)           
        if truelen < 600          
          H = L * .03  + (1.9 * rtype)  + 7.1     /* &dA05-16-95&d@   was + 7.1 (types shifted by 1)
        else 
          H = 25.1  + (1.9 * rtype)               /* &dA05-16-95&d@   was 27.0  (types shifted by 1)
        end 
        rtype -= 1.0 

        L = X * X + (Y * Y) 
        L = sqt(L) 

        aa = rtype / 75.  
        W = L * (.66 - aa)  /* experimental value 
&dA 
&dA &d@   compute R, P, A, B, Cx, Cy, Ca, Cb and check limitations 
&dA 
&dA &d@   1. Q:  
&dA 
        if length > 300 
          Q = 15.0 
        else 
          Q = 13.0 
        end 
CBE_PAA: 

&dA 
&dA &d@   2. R = L*L/Q/8 + Q/2 
&dA &d@                        
        x = L * L / Q / 8.0 
        y = Q / 2.0 
        R = x + y 
&dA 
&dA &d@   3. P = R - (R*R - (W*W/4))^1/2  component of height from 
&dA &d@                                      middle section 
        x = (R * R) - (W * W / 4.0) 
        P = R - sqt(x) 
        y = (L - W) / 2.0 + P 
        if H > y 
          H = y 
        end 
        if H < Q 
          H = dec(Q) + .5 
        end 
&dA 
&dA &d@   4. A = (L - W) / 2  B = H - P   <A,B> = transition point 
&dA 
        A = (L - W) / 2.0 
        B = H - P 
&dA 
&dA &d@   5. Cx = X/2  Cy = R - H       <Cx,Cy> = center of main arc 
&dA 
        Cx = L / 2.0 
        Cy = H - R                  /* a negative number 
&dA 
&dA &d@   6. Compute  <Ca,Cb> = center of starting arc 
&dA 
&dA &d@           [ B*(Cx-A)/(Cy-B) + (A*A + B*B)/2/A - A ] 
&dA &d@      Cb = ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA &d@                   [ B/A + (Cx-A)/(Cy-B) ] 
&dA 
&dA &d@      Ca = (A*A + B*B)/2/A - B*(Cb)/ A 
&dA 
        aa = (Cx - A) / (Cy - B) 
        bb = (A * A) + (B * B) 
        bb = bb / 2.0 / A 

        Cb = (B * aa + bb - A) / (B / A + aa) 

        Ca = bb - (B * Cb / A) 
&dA 
&dA &d@   normalize D-function 
&dA 
        xx = L / 2.0
        D = sqt(xx) / 4.8 
        if D > 1.50 
          D -= .16         /* radical 
          if H / L > .200 
            D -= .10 
          end 
        end 
        if D > 1.70 
          D = D - 1.70 * .2 + 1.70 
        end 
        if D > 1.95 
          D = D - 1.95 * .3 + 1.95 
        end 

&dEÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿&d@ 
&dE³        S W E E P    L O O P   1        ³&d@ 
&dEÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ&d@ 

&dA 
&dA &d@                              º   sqt(A*A + B*B)    º 
&dA &d@   1. compute beta = 2 * sin-1ºÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄº  sweep angle 
&dA &d@                              º 2*sqt(Ca*Ca + Cb*Cb)º 
&dA 
        aa = A * A + (B * B) 
        bb = Ca * Ca + (Cb * Cb) 

        cc = sqt(bb) 
        beta = rtype / 7.5 

        if L >= 400.  
          delta = L * .001                  
        else                                
          delta = L * .006 - 2.00           
        end                                 

        if R / cc > 3.00 - beta + delta 
          Q += .1 
          if Q < H - .5 
            goto CBE_PAA 
          end 
        end 

        cc = sqt(aa/bb) 

        beta = 2.0 * ars(cc/2.0) 
&dA 
&dA &d@   2. compute delta so that sweep hits every one-third dot 
&dA 
        aa = sqt(aa) * 3.0      /* thrice length of arc (approx) 
        delta = beta / aa 
        scnt = 0 
        alpha = 0.0 
&dA 
&dA &d@   3. begin sweep 
&dA 
CBE_SW1A: 
        aa = 1.0 - cos(alpha) 
        bb = sin(alpha) 

        x = Ca * aa - (Cb * bb) 
        y = Ca * bb + (Cb * aa) 
        if x < A 
          ++scnt 
          sx(scnt) = x 
          sy(scnt) = y 
          alpha += delta 
          goto CBE_SW1A 
        end 

&dEÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿&d@ 
&dE³        S W E E P    L O O P   2        ³&d@ 
&dEÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ&d@ 

&dA 
&dA &d@   1. compute beta2 = sin-1{ [(L/2)-A] / R } 
&dA 
        aa = L / 2.0 - A / R 
        beta2 = ars(aa) 
&dA 
&dA &d@   2. compute delta so that sweep hits every one-third dot 
&dA 
        delta2 = beta2 * 2.0 / 3.0 / W 
        alpha = 0.0 - beta2 
&dA 
&dA &d@   3. begin sweep 
&dA 
CBE_SW2A: 
        x = R * sin(alpha) + Cx 
        y = R * cos(alpha) + Cy 
        if x < L - A 
          ++scnt 
          sx(scnt) = x 
          sy(scnt) = y 
          alpha += delta2 
          goto CBE_SW2A 
        end 

&dEÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿&d@ 
&dE³        S W E E P    L O O P   3        ³&d@ 
&dEÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ&d@ 

&dA 
&dA &d@   1. beta and delta already computed 
&dA 
        alpha = beta 
&dA 
&dA &d@   2. begin sweep 
&dA 
CBE_SW3A: 
        aa = 1.0 - cos(alpha) 
        bb = sin(alpha) 

        x = L - (Ca * aa) + (Cb * bb) 
        y = Ca * bb + (Cb * aa) 
        if x < L 
          ++scnt 
          sx(scnt) = x 
          sy(scnt) = y 
          alpha -= delta 
          goto CBE_SW3A 
        end 
        ++scnt 
        sx(scnt) = L 
        sy(scnt) = 0.0 

&dEÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿&d@ 
&dE³  E N D   O F   S W E E P S.    C O N S T R U C T   S L U R   ³&d@ 
&dEÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ&d@ 

&dA 
&dA &d@   1. rotate data to produce rise 
&dA 
        aa = X / L 
        bb = Y / L 
        loop for t1 = 1 to scnt 
          x = sx(t1) * aa - (sy(t1) * bb) 
          y = sx(t1) * bb + (sy(t1) * aa) 
          sx(t1) = x 
          sy(t1) = y 
        repeat 
&dA 
&dA &d@   2. setup thickness parameters 
&dA 
        if length < 200 
          if nsize < 21 
            pc = 12 * scnt / 100         /* left hand side of slur 
            pd = 36 * scnt / 1000        /* extreme left end 
            pe = 88 * scnt / 100         /* right hand side of slur 
            pf = 964 * scnt / 1000       /* extreme right end 
            if version = 1 
              pe = 93 * scnt / 100 
              pf = 979 * scnt / 1000 
            end 
          else 
            pc = 12 * scnt / 100         /* left hand side of slur 
            pd = 80 * scnt / 1000        /* extreme left end 
            pe = 88 * scnt / 100         /* right hand side of slur 
            pf = 930 * scnt / 1000       /* extreme right end 
            if version = 1 
              pe = 93 * scnt / 100 
              pf = 950 * scnt / 1000 
            end 
          end 
        else 
          if nsize < 16 
            t1 = 1000 - length           /* 800 times too big 
            pc = 10 * t1 
            pd = 30 * t1 
            pe = 80000 - pc 
            pf = 800000 - pd 
            pc = pc * scnt / 80000       /* left hand side of slur 
            pd = pd * scnt / 800000      /* extreme left end 
            pe = pe * scnt / 80000       /* right hand side of slur 
            pf = pf * scnt / 800000      /* extreme right end 
            if version = 1 
              pe = 80000 - (6 * t1) 
              pf = 800000 - (18 * t1) 
              pe = pe * scnt / 80000       /* right hand side of slur 
              pf = pf * scnt / 800000      /* extreme right end 
            end 
          else 
            if nsize < 21 
              pc = length * 90 / (length + 600)    /* left hand side of slur
              pd = pc * 3 / 10                     /* extreme left end 
              pe = scnt - pc                       /* right hand side of slur
              pf = scnt - pd                       /* extreme right end 
              if version = 1 
                pe = scnt - (pc * 6 / 10) 
                pf = scnt - (pd * 6 / 10) 
              end 
            else 
              pc = length * 90 / (length + 600)    /* left hand side of slur
              pd = pc * 8 / 10                     /* extreme left end 
              pe = scnt - pc                       /* right hand side of slur
              pf = scnt - pd                       /* extreme right end 
              if version = 1 
                pe = scnt - (pc * 8 / 10) 
                pf = scnt - (pd * 8 / 10) 
              end 
            end 
          end 
        end 
        flpd = flt(pd) 
        flpf = flt(scnt - pf) 

        if version = 1 
          pg = 53 * scnt / 100 
        end 
        if version = 2 
          pg = 50 * scnt / 100         /* make asym left slurs fat in middle 
        end 

        if length < 400 
          ph = 0 
        else 
          ph = (length - 400) * scnt * 4 / 40000 
        end 
&dA 
&dA &d@   3. compute ind, outd 
&dA 
        loop for t1 = 1 to scnt 
          if nsize < 16 
            if t1 < pc                   /* left hand side of slur 
              ind = 0.0 
              if t1 < pd                 /* extreme left end 
                outd = flt(t1) / flt(pc) + .1 
              else 
                outd = .4 
              end 
              goto CBE_PCD 
            end 
            if t1 > pe                   /* right hand side of slur 
              ind = 0.0 
              if t1 >= pf                /* extreme right end 
                t2 = scnt - t1 
                outd = flt(t2) / flt(pc) + .1 
              else 
                outd = 0.4 
              end 
              goto CBE_PCD 
            end 
          else 
            if nsize = 16 
              if t1 < pc                    
                ind = 0.6                  
                if t1 < pd                  
                  outd = .4 * flt(t1) / flpd + .0 
                else 
                  outd = .4 
                end 
                goto CBE_PCD 
              end 
              if t1 > pe                    
                ind = 0.6                  
                if t1 >= pf                 
                  t2 = scnt - t1 
                  outd = 0.4 * flt(t2) / flpf + .0 
                else 
                  outd = 0.4 
                end 
                goto CBE_PCD 
              end 
            else 
              if nsize = 18 
                if t1 < pc                    
                  ind = 0.6                  
                  if t1 < pd                  
                    outd = .4 * flt(t1) / flpd + .3 
                  else 
                    outd = .7 
                  end 
                  goto CBE_PCD 
                end 
                if t1 > pe                    
                  ind = 0.6                  
                  if t1 >= pf                 
                    t2 = scnt - t1 
                    outd = 0.4 * flt(t2) / flpf + .3 
                  else 
                    outd = 0.7 
                  end 
                  goto CBE_PCD 
                end 
              else 
                if t1 < pc                    
                  ind = 0.6                  
                  if t1 < pd                  
                    outd = .3 * flt(t1) / flpd + .0 
                  else 
                    outd = .3 
                  end 
                  outd -= .1 
                  goto CBE_PCD 
                end 
                if t1 > pe                    
                  ind = 0.6                  
                  if t1 >= pf                 
                    t2 = scnt - t1 
                    outd = 0.3 * flt(t2) / flpf + .0 
                  else 
                    outd = 0.3 
                  end 
                  outd -= .1 
                  goto CBE_PCD 
                end 
              end 
            end 
          end 

    /* middle of slur 
          if t1 > pg + ph              /* right side 
            t2 = pe - t1 
            t5 = pe - pg - ph 
          else                         /* left side 
            if t1 < pg - ph 
              t2 = t1 - pc 
              t5 = pg - pc - ph 
            else 
              t5 = 10000 
              t2 = 9999 
            end 
          end 
          bb = flt(t2) * ars(1.0) / flt(t5)  /* max(bb) = sin-1(1) 
          aa = sin(bb) 
          if nsize < 16 
            outd = D - 0.4 * aa + 0.4 
            ind = aa * D 
          else 
            if nsize = 16 
              outd = D - 0.1 * aa + 0.4 
              ind = D - 0.6 * aa + 0.6 
            else 
              if nsize = 18 
                outd = D - 0.7 * aa + 0.7 
                ind = D - 0.6 * aa + 0.6 
              else 
                outd = D - 0.2 * aa + 0.2 
                ind = D - 0.6 * aa + 0.6 
              end 
            end 
          end 
&dA 
&dA &d@   4. compute outside point, inside point 
&dA 
CBE_PCD: 
          if nsize > 10 
            if nsize < 18 
              outd += 0.29000 
              ind  += 0.29000 
            else 
              if nsize = 18 
                outd += 0.69000 
                ind  += 0.79000 
              else 
                outd += 0.45000 
                ind  += 0.59000 
              end 
            end 
          else 
            outd += 0.10000 
            ind  += 0.10000 
          end 
  
          x = sx(t1) 
&dA 
&dA &d@   asymetric weighting for y 
&dA 
          if type < 3 
            cc = flt(scnt-1) 
            if version = 1 
              aa =  .9  * flt(scnt-t1) / cc 
              bb = 1.05 * flt(t1-1) / cc 
              y = sy(t1) * (aa + bb) 
              y = y - (.05 * Y * flt(t1-1) / cc) 
            else 
              y = sy(t1) 
            end 
          else 
            if type < 5          /* types 3 and 4 have reduced asymmetry 
              cc = flt(scnt-1) 
              if version = 1 
                aa =  .92 * flt(scnt-t1) / cc 
                bb = 1.04 * flt(t1-1) / cc 
                y = sy(t1) * (aa + bb) 
                y = y - (.04 * Y * flt(t1-1) / cc) 
              else 
                y = sy(t1) 
              end 
            else 
              if type < 7    /* types 5 and 6 have further reduced asymmetry 
                cc = flt(scnt-1) 
                if version = 1 
                  aa =  .96 * flt(scnt-t1) / cc 
                  bb = 1.02 * flt(t1-1) / cc 
                  y = sy(t1) * (aa + bb) 
                  y = y - (.02 * Y * flt(t1-1) / cc) 
                else 
                  y = sy(t1) 
                end 
              else 
                y = sy(t1)      /* types 7 and 8 are not asymmetric 
              end 
            end 
          end 
&dA 
&dA &d@   give finite width to slur 
&dA 
          if t1 < scnt 
            u = sx(t1+1) 
            v = sy(t1+1) 
          else 
            u = x 
            v = y 
          end 
          if t1 > 1 
            xx = sx(t1-1) 
            yy = sy(t1-1) 
          else 
            xx = x 
            yy = y 
          end 
          u -= xx          /* delta x 
          v -= yy          /* delta y 
          cc = u * u + (v * v) 
          cc = sqt(cc)       /* delta hypotinus 
          aa = outd / cc 
          bb = ind / cc 
          outpx = x - (aa * v) 
          outpy = y + (aa * u) 
          inpx  = x + (bb * v) 
          inpy  = y - (bb * u) 
&dA 
&dA &d@   5. compute box coordinates 
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
          x1 = fix(inpx) 
          x2 = fix(outpx) 
          y1 = fix(inpy) 
          y2 = fix(outpy) 
          if nsize = 6 
            x1 -= 1 
            y2 += 2 
          end 
          if nsize < 16 
            if x2 - x1 < 2 
              ++y2                /* radical 
            end 
          end 
&dA 
&dA &d@   6. set points inside box to 1 (with inverted vertical axis) 
&dA 
&dA &d@     Here is where you scale the size of the slur
&dA 
          if nsize = 6 
            x1 >>= 1 
            x2 >>= 1 
            y1 >>= 1 
            y2 >>= 1 
          end 
          if nsize > 14 
            x1 = x1 * nsize / 14 
            x2 = x2 * nsize / 14 
            y1 = y1 * nsize / 14 
            y2 = y2 * nsize / 14 
          end 
          loop for t2 = y1 to y2 
            t4 = 750 - t2 
            loop for t3 = x1 to x2 
              slmap(t4){t3} = "1" 
            repeat 
          repeat 
        repeat 
      return 
