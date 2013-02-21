 
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 18. puttuplet (a1)                                          ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose:  Typeset tuplet and/or bracket                    ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Inputs:   x1 = horizontal starting point of tuplet/bracket ³ 
&dA &d@³              x2 = horizontal stopping point of tuplet/bracket ³ 
&dA &d@³              y1 = vertical starting point                     ³ 
&dA &d@³              y2 = vertical stopping point                     ³ 
&dA &d@³              a1 = tuplet number                               ³ 
&dA &d@³         sitflag = situation flag                              ³ 
&dA &d@³                                                               ³ 
&dA &d@³                         bit clear        bit set              ³ 
&dA &d@³                        ÄÄÄÄÄÄÄÄÄÄÄ      ÄÄÄÄÄÄÄÄÄ             ³ 
&dA &d@³               bit 0    no tuplet        tuplet                ³ 
&dA &d@³               bit 1    no bracket       bracket               ³ 
&dA &d@³               bit 2    tips down        tips up               ³ 
&dA &d@³                                                               ³ 
&dA &d@³               bit 5    broken bracket   continuous bracket    ³ 
&dA &d@³               bit 6    number outside   number inside         ³ 
&dA &d@³               bit 7    square bracket   curved bracket        ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Calling variables to internal procedures:  a1,a4,a5        ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure puttuplet (a1) 
        int xav,yav 
        int t1,t2,t3,t4,t5,savex2 
        int a1,a2,a3,a4,a5,a6 

        getvalue a1 
        savex2 = x2 
        x2 += notesize 
        if bit(1,sitflag) = 1 
          x2 = pvpar(2) / 3 + x2 
        end  
        a4 = x2 - x1 
        a4 = y2 - y1 * 60 / a4 
        xav = x1 + x2 / 2 
        yav = xav - x1 * a4 / 60 + y1  
&dA &d@   xav = x at center of tuplet/bracket 
&dA &d@   a4  = slope * 60 
&dA &d@   yav = y at center of tuplet/bracket 
&dA 
&dA &d@   Part I: tuplet present 
&dA 
        if bit(0,sitflag) = 1 
          x = xav 
          y = yav + psq(f12)   
          a3 = x - phpar(45) + (notesize / 3) 
          a6 = x + phpar(45) - (notesize / 7) 
          x = 0 - phpar(45) / 2 + x + sp  
&dA 
&dA &d@   New code (12/01/94) to deal with complex tuples 
&dA 
          t4 = a1 
          t1 = t4 / 1000 
          t2 = rem 

          if t1 > 0 
            t3 = 2 
            if t2 > 9 
              ++t3 
            end 
            if t1 > 9 
              ++t3 
            end 
            t4 = phpar(45) * t3 + 1 >> 1 
            x -= t4                /* create space for colon + double digits 
            a3 -= t4 
            a6 += t4 
          else 
            t3 = 0 
            if t2 > 9 
              ++t3 
            end 
            t4 = phpar(45) * t3 + 1 >> 1 
            x -= t4                /* create space for double digits 
            a3 -= t4 
            a6 += t4 
          end 

          if bit(1,sitflag) = 1             /* bracket present 
            if bit(7,sitflag) = 1             /* curved bracket 
              if bit(2,sitflag) = 0             /* tips down 
                y -= (pvpar(1) + 1 / 2) 
              else                              /* tips up 
                y += (pvpar(1) + 1 / 2) 
              end 
              if bit(5,sitflag) = 0             /* broken bracket 
                y -= (pvpar(3) >> 2) 
              end 
            end 
&dA 
&dA &d@                 &dA03/15/97&d@ numbers below or above  &dIOK&d@ 
&dA 
            if bit(5,sitflag) = 1             /* continuous bracket 
              if bit(7,sitflag) = 1             /* curved bracket 
                if bit(6,sitflag) = 0             /* number outside 
                  if bit(2,sitflag) = 1             /* tips up 
                    y += pvpar(2) 
                  else                              /* tips down 
                    y -= (pvpar(5) + 1 / 2) 
                  end 
                else                              /* number inside 
                  if bit(2,sitflag) = 1             /* tips up 
                    y -= pvpar(3) 
                  else                              /* tips down 
                    y += (pvpar(5) + 1 / 2) 
                  end 
                end 
              else                              /* square bracket 
                if bit(6,sitflag) = 0             /* number outside 
                  if bit(2,sitflag) = 1             /* tips up 
                    y += pvpar(3) 
                  else                              /* tips down 
                    y -= pvpar(2) 
                  end 
                else                              /* number inside 
                  if bit(2,sitflag) = 1             /* tips up 
                    y -= pvpar(2) 
                  else                              /* tips down 
                    y += pvpar(3) 
                  end 
                end 
              end 
              a3 = xav + 2                  /* eliminate space in bracket line
              a6 = xav - 2 
            end 
          end 
          scx = x 
          scy = y 
&dA 
&dA &d@     Put out numerator of tuple 
&dA 
          t3 = t2 / 10 
          t2 = rem 
          if t3 > 0 
            scb = t3 + 221 
            perform charout 
          end 
          scb = t2 + 221 
          perform charout 
&dA 
&dA &d@     Put out denominator of tuple (if present) 
&dA 
          if t1 > 0 
            scb = 249           /* colon 
            perform charout 
            t3 = t1 / 10 
            t1 = rem 
            if t3 > 0 
              scb = t3 + 221 
              perform charout 
            end 
            scb = t1 + 221 
            perform charout 
          end 

        end  
&dA 
&dA &d@   Part II: bracket present 
&dA 
        if bit(1,sitflag) = 1               /* bracket present 
&dA 
&dA &d@     Square brackets 
&dA 
          if bit(7,sitflag) = 0               /* square bracket 
&dA 
&dA &d@   1) compute slope 
&dA 
            a5 = abs(a4) 
            a5 = a5 + 3 / 5 
            if a5 > 6 
              a5 = 6 
            end 
            if a5 = 5 
              a5 = 4 
            end 
            if a5 = 6 
              a5 = 5 
            end 
            if a4 > 0 
              a4 = a5 
            else 
              a4 = 0 - a5 
            end 
            yav -= pvpar(40) 
&dA 
&dA &d@   2) case 1: broken bracket 
&dA 
            if bit(5,sitflag) = 0        
              a1 = a3 - x1 + 2 / 3 * 3 
              x1 = a3 - a1 
              a2 = 6 
              if a4 < 0 
                a2 = -6 
              end 
              y1 = x1 - xav * a4 + 6 / 12 + yav 
              x = x1 + sp 
              y = y1 + psq(f12) 
              perform brackethook 
              perform bracketline (a1,a4,a5) 
              a1 = x2 - a6 + 2 / 3 * 3 
              y1 = a6 - x1 * a4 + a2 / 12 + y1 
              x1 = a6 
              perform bracketline (a1,a4,a5) 
              perform brackethook 
            else 
&dA 
&dA &d@   3) case 2: continuous bracket 
&dA 
              a1 = x2 - x1 + 2 / 3 * 3 
              x1 = 0 - a1 - 1 / 2 + xav 
              y1 = x1 - xav * a4 + 6 / 12 + yav 
              x = x1 + sp 
              y = y1 + psq(f12) 
              perform brackethook 
              perform bracketline (a1,a4,a5) 
              perform brackethook 
            end 
          else 
&dA 
&dA &d@      Curved brackets (slurs)      /* &dA03/15/97&d@  &dIOK&d@ 
&dA 
&dA &d@     Inputs:   (x1,y1)        = starting note head 
&dA &d@               (x2,y2)        = terminating note head 
&dA &d@               slur_edit_flag = flag indicating that y1 and/or y2 have been altered
&dA &d@               postx          = horiz. movement of slur after it has been chosen
&dA &d@               posty          = vert.  movement of slur after it has been chosen
&dA &d@               addcurve (t5)  = flag indicating the curvature should be added 
&dA &d@               sitflag        = situation flag 
&dA &d@  
&dA &d@                      bit clear            bit set 
&dA &d@                    --------------       ------------- 
&dA &d@           bit 0:   full slur            dotted slur 
&dA &d@           bit 1:   stock slur           custom slur 
&dA &d@           bit 2:   first tip down       first tip up  
&dA &d@      (*)  bit 3:   second tip down      second tip up     
&dA &d@      (+)  bit 4:   compute stock slur   hold stock slur 
&dA &d@          
&dA &d@           (*) used on custom slurs only  
&dA &d@           (+) used on stock slurs only 
&dA 
&dA &d@           bit 5:   continuous slur      broken slur             /* &dA03/15/97&d@  &dIOK
&dA &d@    
&dA &d@           bits 8-15:  size of break (0 to 255 dots, centered) 
&dA &d@    
            t1 = sitflag 
            x2 = savex2               /* restore x2 to original 
            if bit(2,t1) = 1          /* tips up 
              sitflag = 12 
              posty = 0 - pvpar(5)     /* reason: y1 and y2 were supplied as endpoints
            else                      /* for square brackets, not the notes themselves
              sitflag = 0             /* this code is a cludge to correct for this
              posty = pvpar(5) / 2     /* approximately.  Rigorous solution would be
            end                       /* to set through the original oby's 
            slur_edit_flag = 1 
            postx = 0 
            t5 = 0 

            if bit(5,t1) = 0          /* broken slur 
              t2 = a6 - a3 << 8 + 0x20 
              sitflag += t2 
            end 
            perform putslur (t5) 
          end 
        end  
      return 
*  
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 18a. brackethook                                            ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose:  Typeset vertical hook for bracket                ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure brackethook  
        if bit(2,sitflag) = 1 
          y = y - notesize + 2 
        end  
        scx = x 
        scy = y 
        scb = 89 
        perform charout 
      return 
