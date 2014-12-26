
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D*  4. printbeam (z1,dv3,@@m)                                  ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose:  Typeset beam                                     ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Inputs:  @@m = slope * phpar(1)                            ³ 
&dA &d@³             x1  = starting point of beam                      ³ 
&dA &d@³             x2  = end point of beam                           ³ 
&dA &d@³             dv3 = y intercept of beam (times phpar(1))        ³ 
&dA &d@³             stem = stem direction                             ³ 
&dA &d@³             z1 = beam character number for this slope         ³ 
&dA &d@³                                                               ³ 
&dA &d@³             @@k = |@@m|                                       ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure printbeam (z1,dv3,@@m) 
        int x3,z1,dv3,@@k,@@m 
        getvalue z1,dv3,@@m 

        @@k = abs(@@m) 
        x = x1 
        if stem = UP 
          x += qwid - phpar(29) 
        end  
        scx = x 
        scf = beamfont 

        x2 = x2 + phpar(29) - phpar(1) 
        y1 = @@m * x1 + dv3 / phpar(1) 
        if x2 < x1 and @@k = 0 
          x2 = phpar(1) - 4 + x2              /* no beam shorter than 4 dots  
          y = y1                            /* put out <n> "overlapping" 4 dot lengths
          if stem = DOWN 
            y = pvpar(2) * 500  - y - bthick 
          else 
            x2 += qwid - phpar(29) 
          end 
PBEAM01: 
          scy = y 
          scb = 88 
          perform charout 

          x += 4          
          if x < x2 
            goto PBEAM01 
          end 
          scx = x2 
          scb = 88 
          perform charout 
          scf = notesize 
          return 
        end  
        z = z1   
        if stem = DOWN 
          z += 128
          z &= 0xff 
        end  
        loop while x1 <= x2  
          y = y1 
          if stem = DOWN 
            y = pvpar(2) * 500  - y - bthick  
          end  
          scy = y 
          scb = z
          perform charout 
          x1 += phpar(1) 
          y1 += @@m 
        repeat 
        y2 = x2 + phpar(1) - x1   
&dA 
&dA &d@  print fraction of beam 
&dA &d@   y2 = extra length needed to complete beam 
&dA 
        if y2 = 0  
          scf = notesize 
          return 
        end  
        y = y1 
        if stem = DOWN 
          y = pvpar(2) * 500  - y - bthick  
        end  
&dA &d@   y = starting point   
        if @@k = 0  
          x = x1 - 30 + y2   
          if stem = UP 
            x += qwid - phpar(29) 
          end  
          scx = x 
          scy = y 
          scb = 33 
          perform charout 
          scf = notesize 
          return 
        end  
        scy = y 

        x3 = @@k - 1 * 29 + y2  
        if x3 < 1 or x3 > 435             /* added &dA11/29/09&d@ 
          return 
        end 

        x2 = beamext(x3,1)
        y1 = 2 
        loop for y2 = 1 to x2  
          z = beamext(x3,y1)
          if @@m > 0  
            z += 128 
            z &= 0xff 
          end  
          if stem = 1  
            z += 128 
            z &= 0xff 
          end  
          scb = z 
          perform charout 
          if y2 < x2 
            ++y1
            x1 = beamext(x3,y1)
            if stem = 1  
              x1 = 0 - x1  
            end  
            if @@m > 0  
              x1 = 0 - x1  
            end  
            y -= x1 
            scy = y 
            ++y1
          end  
        repeat 
        scf = notesize 
      return 
