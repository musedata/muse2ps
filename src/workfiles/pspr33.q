
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 33. make_longslur (length,rise,smode)                                ³ 
&dA &d@³                                                                        ³ 
&dA &d@³    Operation:  Construct a three curve longslur                        ³ 
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

#define MAPZ        2500 

      procedure make_longslur (length,rise,smode) 
        str out.MAPZ 
        str map.MAPZ(250),zeros.MAPZ 
        bstr temp.MAPZ 

        int t1,t2,t3,t4,t5
        int x1,x2,y1,y2 
        int length,rise,smode 
        int pc,pd,pe,pf,pg,ph 
        int scnt 

        real delta,alpha,beta,delta2,beta2 
        real X,x,Y,y,z,Cx,Cy,R,L,H,D,W,Q,P,A,B,Ca,Cb 
        real aa,bb,cc 
        real xx,yy,u,v 
        real inpx,outpx,inpy,outpy,ind,outd 
        real sx(8000),sy(8000) 
        real PP,QQ 
        real SCALE 
        real rtype 

        zeros = zpd(MAPZ) 

&dA*   I.  Determine scaling factor              

        if notesize = 14 
          SCALE = 1.0 
        else 
          SCALE = flt(notesize) / 14.0 
        end 

&dA*   II. Get rise and length limits            

        getvalue length,rise,smode 
        t1 = length - 1 
        X = flt(t1) 
        Y = flt(rise) 

        X = X / SCALE                  /* &dA05-12-95&d@  all computations done 
        Y = Y / SCALE                  /* at original size.  

        length = length * 14 / notesize 

  /* clear slur array 

        loop for t1 = 1 to 250 
          map(t1) = pad(MAPZ) 
        repeat 
&dA 
&dA &d@    &dEBeginning of slur generation&d@ 
&dA 
&dAÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿&d@ 
&dA³       P A R A M E T R I C    M A G I C         ³&d@ 
&dAÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ&d@ 

        rtype = 2.0        

        if X < 600.0 
          H = X * .03 + 9.0 + (1.9 * rtype) 
        else 
          H = 27.0  + (1.9 * rtype) 
        end 

        if X > 1200.0 
          H = H + (X - 1200.0 / 200.0) 
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
        if X > 300.0 
          Q = 15.0 
        else 
          Q = 13.0 
        end 

LS_PAA: 

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
        if D > 2.25 
          D = D - 2.25 * .4 + 2.25 
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
            goto LS_PAA 
          end 
        end 

        cc = sqt(aa/bb) 

        beta = 2.0 * ars(cc/2.0) 
&dA 
&dA &d@   2. compute delta so that sweep hits every dot 
&dA 
        aa = sqt(aa)          /* length of arc (approx)  
        delta = beta / aa / 2.0  
        scnt = 0 
        alpha = 0.0 
&dA 
&dA &d@   3. begin sweep 
&dA 
LS_SW1A: 
        aa = 1.0 - cos(alpha) 
        bb = sin(alpha) 

        x = Ca * aa - (Cb * bb) 
        y = Ca * bb + (Cb * aa) 
        if x < A 
          ++scnt 
          sx(scnt) = x 
          sy(scnt) = y 
          alpha += delta 
          goto LS_SW1A 
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
&dA &d@   2. compute delta so that sweep hits every dot 
&dA 
        delta2 = beta2 * 2.0 / W / 2.0    
        alpha = 0.0 - beta2 
&dA 
&dA &d@   3. begin sweep 
&dA 
LS_SW2A: 
        x = R * sin(alpha) + Cx 
        y = R * cos(alpha) + Cy 
        if x < L - A and scnt < 7999         /* added &dA11/29/09&d@ 
          ++scnt 
          sx(scnt) = x 
          sy(scnt) = y 
          alpha += delta2 
          goto LS_SW2A 
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
LS_SW3A: 
        aa = 1.0 - cos(alpha) 
        bb = sin(alpha) 

        x = L - (Ca * aa) + (Cb * bb) 
        y = Ca * bb + (Cb * aa) 
        if x < L and scnt < 7999             /* added &dA11/29/09&d@ 
          ++scnt 
          sx(scnt) = x 
          sy(scnt) = y 
          alpha -= delta 
          goto LS_SW3A 
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
        pc = length * 60 / (length + 400)   /* carefully worked out formula &dA05/13/95
        pd = pc * 3 / 10 

        pe = scnt - pc 
        pf = scnt - pd 

        if notesize = 21                    /* disable this feature for notesize = 21 &dA12/03/08
          pc = 1 
          pe = scnt 
        end 

        pg = 50 * scnt / 100         

        if length < 400 
          ph = 0 
        else 
          ph = (length - 400) * scnt * 4 / 40000 
        end 
&dA 
&dA &d@   3. compute ind, outd 
&dA 
        loop for t1 = 1 to scnt 
          if t1 < pc                   /* left hand side of slur 
            ind = 0.6 
            if notesize = 21 
              ind = 1.3 
            end 
            if t1 < pd                 /* extreme left end 
              if notesize = 16         /* New size-16  &dA12/31/08&d@ 
                outd = .4 * flt(t1) / flt(pc) 
              else 
                outd = flt(t1) / flt(pc) + .1 
              end 
            else 
              outd = 0.4 
            end 
            if notesize = 14 
              outd += .4 
            end 
            if notesize = 16           /* New size-16  &dA12/31/08&d@ 
              outd += .3 
            end 
            if notesize = 18           /* New size-18  &dA12/18/04&d@ 
              outd += .3 
            end 
            if notesize = 21 
              outd += .3 
            end 
            goto LS_PCD 
          end 
          if t1 > pe                   /* right hand side of slur 
            ind = 0.6 
            if t1 >= pf                /* extreme right end 
              t2 = scnt - t1 
              if notesize = 16         /* New size-16  &dA12/31/08&d@ 
                outd = 0.4 * flt(t2) / flt(pc) 
              else 
                outd = flt(t2) / flt(pc) + .1 
              end 
            else 
              outd = 0.4 
            end 
            if notesize = 14 
              outd += .4 
            end 
            if notesize = 16           /* New size-16  &dA12/31/08&d@ 
              outd += .3 
            end 
            if notesize = 18           /* New size-18  &dA12/18/04&d@ 
              outd += .3 
            end 
            goto LS_PCD 
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
          if notesize = 14 
            outd = D - .8 * aa + .8 
            ind = D - .6 * aa + .6 
          end 
&dA 
&dA &d@    New &dA12/31/08&d@ parameters for notesize 16 (based on create16.z) 
&dA 
          if notesize = 16 
            outd = D - 0.1 * aa + 0.4 
            ind = D - 0.6 * aa + 0.6    
            outd += .29000 
            ind  += .29000 
          end 
&dA 
&dA &d@    New &dA12/18/04&d@ parameters for notesize 18 (based on create18.z) 
&dA 
          if notesize = 18 
            outd = D - 0.7 * aa + 0.7 
            ind = D - 0.6 * aa + 0.6    
            outd += .69000 
            ind  += .79000 
          end 
&dA 
&dA &d@    &dA01/26/06&d@ parameters added for notesize 6
&dA 
          if notesize = 6 
            outd = D - 0.8 * aa + 0.8 
            ind = D - 0.6 * aa + 0.6    
            outd += .39000 
            ind  += .49000 
          end 
&dA 
&dA &d@    &dA12/03/08&d@ parameters changed for notesize 21 
&dA 
          if notesize = 21 
            outd = D - 0.6 * aa + 0.6 
            ind = D - 1.0 * aa + 1.0    
            outd += .29000 
            ind  += .89000 
          end 
&dA 
&dA &d@   4. compute outside point, inside point 
&dA 
LS_PCD: 
          x = sx(t1) 
          y = sy(t1) 
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
          outpx = outpx + 30.0           /*  - .5 
          inpx  = inpx  + 30.0           /*  - .5 
          outpy = outpy + 20.0 - 1.0 
          inpy  = inpy  + 20.0 + .5 
&dA 
&dA &d@    For notesize = 21, it appears that scaling here is better 
&dA 
          if notesize = 21 
            inpx = inpx * SCALE 
            outpx = outpx * SCALE 
            inpy = inpy * SCALE 
            outpy = outpy * SCALE 
          end 

          x1 = fix(inpx) 
          x2 = fix(outpx) 
          y1 = fix(inpy) 
          y2 = fix(outpy) 
          if x2 - x1 < 2 
            ++y2                  /* radical 
          end 
&dA 
&dA &d@   6. set points inside box to 1 (with inverted vertical axis) 
&dA 
&dA &d@     Here is where you scale the slur back to its original size    
&dA 
          if notesize <> 21 
            x1 = x1 * notesize / 14 
            x2 = x2 * notesize + 7 / 14 
            y1 = y1 * notesize / 14 
            y2 = y2 * notesize + 7 / 14 
          end 

          if y2 > 249 
            y2 = 249 
          end 

          if x2 > 2500                        /* added &dA11/29/09&d@ 
            x2 = 2500      
          end 

          loop for t2 = y1 to y2 
            t4 = 250 - t2 
            loop for t3 = x1 to x2 
              map(t4){t3} = "x" 
            repeat 
          repeat 

        repeat 
&dA 
&dA &d@    &dEEnd of slur generation&d@ 
&dA 

/* determine size of map display 

        loop for t1 = 1 to 250 
          map(t1) = trm(map(t1)) 
          if map(t1) <> "" 
            goto LS_CE 
          end 
        repeat 
LS_CE: 
        y1 = t1 
        loop for t2 = t1 to 249 
          map(t2+1) = trm(map(t2+1)) 
          if map(t2) = "" and map(t2+1) = "" 
            goto LS_CF 
          end 
        repeat 
LS_CF: 
        y2 = t2 - 1 
        loop for t2 = 1 to MAPZ 
          loop for t1 = y1 to y2 
            if map(t1){t2} = "x" 
              goto LS_CH 
            end 
          repeat 
        repeat 
LS_CH: 
        x1 = t2 
        x2 = 0 
        loop for t1 = y1 to y2 
          if x2 < len(map(t1)) 
            x2 = len(map(t1)) 
          end 
        repeat 

    /* write slur to longslur(.) 

        x2 = x2 - x1                /* x range 
        t2 = 0 
        if smode < 3 
          loop for t1 = y1 to y2 
            map(t1) = map(t1) // pad(MAPZ) 
            out = map(t1){x1,x2} 
            if smode = 2 
              out = rev(out) 
            end 
            out = trm(out) 

            if out = "" and (t1 = y1 or t1 = y2) 
            else 
              ++t2 
              temp = pak(out) 
              longslur(t2) = cby(temp) 
            end 
          repeat 
        else 
          loop for t1 = y2 to y1 step -1 
            map(t1) = map(t1) // pad(MAPZ) 
            out = map(t1){x1,x2} 
            if smode = 3 
              out = rev(out) 
            end 
            out = trm(out) 

            if out = "" and (t1 = y1 or t1 = y2) 
            else 
              ++t2 
              temp = pak(out) 
              longslur(t2) = cby(temp) 
            end 
          repeat 
        end 
        if smode = 1 
          length = t2 - 1 
        else 
          if smode = 2 
            length = t2 - 1 - rise 
          else 
            if smode = 3 
              length = rise 
            else 
              length = 0 
            end 
          end 
        end 

        rise = t2 
        passback length,rise          /* length = initial offset; rise = number of rows
      return 
