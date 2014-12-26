
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 14. settie (tspan,tpost_x,tpost_y,tpost_leng)               ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose:  Typeset typeset tie                              ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Inputs: x1         = x-object coordinate of first note     ³ 
&dA &d@³            y1         = y-object coordinate of first note     ³ 
&dA &d@³                             (+1000 if on virtual staff)       ³ 
&dA &d@³            tspan      = distance spanned by tie               ³ 
&dA &d@³            sitflag    = situation flag                        ³ 
&dA &d@³            f12        = staff number                          ³ 
&dA &d@³            tpost_x    = post adjustment to left x position    ³ 
&dA &d@³            tpost_y    = post adjustment to y position         ³ 
&dA &d@³            tpost_leng = post adjustment to right x position   ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Internal varibles:  d1 = temporary variable                ³ 
&dA &d@³                        d2 = temporary variable                ³ 
&dA &d@³                        tiechar = first tie character          ³ 
&dA &d@³                        textend = tie extention character      ³ 
&dA &d@³                        hd = horizontal displacement           ³ 
&dA &d@³                        vd = vertical displacement             ³ 
&dA &d@³                        out = output string                    ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure settie (tspan,tpost_x,tpost_y,tpost_leng) 
        int tpost_x,tpost_y,tpost_leng 
        int d1,d2,d3,d4,d5 
        int virtoff 
        int hd,vd,tiechar,textend,tspan,tcnt 
        label STL(4) 

        getvalue tspan,tpost_x,tpost_y,tpost_leng 
&dA 
&dA &d@ 1) decode y-object coordinate of first note 
&dA 
        virtoff = 0 
        if y1 > 700 
          y1 -= 1000 
          virtoff = vst(f12) 
        end 
&dA 
&dA &d@ 2) complete sitflag  
&dA 

        d5 = phpar(60) 

        d1 = sitflag - 1 & 0x0c >> 2 + 1 
        goto STL(d1) 
STL(1):                     /* tips down, space 
        if y1 < pvpar(2) 
          ++sitflag 
        else 
          if y1 = pvpar(3) and tspan > d5     /* e.g., C5 
            ++sitflag 
          end 
        end 
        goto STLE 
STL(2):                     /* tips down, line 
        if y1 < pvpar(1) 
          ++sitflag 
        else 
          if y1 = pvpar(2) and tspan > d5 
            ++sitflag 
          end 
        end 
        goto STLE 
STL(3):                     /* tips up, space 
        if y1 > pvpar(6) 
          ++sitflag 
        else 
          if y1 = pvpar(7) and tspan > d5 
            ++sitflag 
          end 
        end 
        goto STLE 
STL(4):                     /* tips up, line 
        if y1 > pvpar(5) 
          ++sitflag 
        else 
          if y1 = pvpar(6) and tspan > d5 
            ++sitflag 
          end 
        end 
STLE: 
&dA 
&dA &d@ 3) from sitflag and tspan, get tiechar, hd and vd  
&dA 
        tspan -= tpost_x         
        tspan += tpost_leng      

        if tspan < phpar(61)    /* minimum length depends on notesize 
          if (Debugg & 0x12) > 0 
            pute Error: Tie too short to print 
            pute SETTIE, x1 = ~x1  y1 = ~y1  tspan = ~tspan  sitf = ~sitflag
          end 
          return 
        end  

        d1 = sitflag + 3 / 4
        d3 = rem * 3 + 1
        d2 = ( TIE_DISTS ) 
        if tspan < ( (TIE_DISTS - 1) * phpar(62) + phpar(61) ) 
          d2 = tspan - phpar(61)  
          if phpar(62) = 3 
            ++d2 
          end 
          d2 = d2 / phpar(62) + 1         /* row number for tie parameters 
        end 

        tiechar = tiearr(sizenum,d1,d2,d3)
        hd = tiearr(sizenum,d1,d2,d3+1) 
        vd = tiearr(sizenum,d1,d2,d3+2) 
        if sitflag > 8 
          vd = 0 - vd  
        end  
&dA 
&dA &d@ 4) typeset tie 
&dA &d@    
        x = x1 + hd + sp + tpost_x                         /* modified &dA04/20/03&d@  etc.  &dIOK
        y = y1 - vd + psq(f12) + virtoff 
        if tpost_y < 1000 
          y += tpost_y 
        else 
          tpost_y -= 10000 
          y = y1 + tpost_y + psq(f12) + virtoff 
        end 

        scf = 300
        scx = x 
        scy = y 
        scb = tiechar 
        perform charout 

        d1 = tiechar & 0x7f 
        if d1 = tiearr(sizenum,1,TIE_DISTS,4)  /* staff free general long glyph
          textend = tiechar + 5 
          ++tiechar 
          goto EXT 
        end 
        if d1 = tiearr(sizenum,1,TIE_DISTS,1)  /* staff constrained general long glphy
          textend = tiechar + 1 
          tiechar += 2 
          goto EXT 
        end 

        if d1 > phpar(63)     /* above glyph phpar(63), tie is compound 
          ++tiechar 
          scb = tiechar 
          perform charout 
        end 
        goto EXTa  
*  
EXT:    vd = sitflag - 1 / 8 
        sitflag = rem + 1  
        hd = tspan   
        vd = hd - expar(sitflag) + 32 / 8        /* was + 8 / 8 

        scb = textend 
        loop for tcnt = 1 to vd  
          perform charout 
        repeat 
        vd = hd - expar(sitflag) + 32 / 8        /* was + 16 / 8 
        vd = 40 - rem                            /* was 16 - rem 
        scx -= vd 
        scb = tiechar 
        perform charout 
*  
EXTa:   
        scf = notesize 
      return 
