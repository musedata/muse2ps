
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 26. sysline                                                 ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose:  Typeset left-hand system line                    ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Inputs:   f11 = number of parts                            ³ 
&dA &d@³              psq(1) = y coordinate of first part              ³ 
&dA &d@³              psq(f11) = y coordinate of last part             ³ 
&dA &d@³              sp = x-coordinate of beginning of line           ³ 
&dA &d@³              syscode = format for brace/bracket               ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure sysline  
        int a1,a2,a3,a4,a5,a6,a7 
        int a8,a9,a10,a11,a12             /* added &dA03/11/06&d@ 

        if syscode = ""  
          return 
        end  
&dA 
&dA &d@  1. typeset left-hand bar  
&dA 
        x = sp 
        z = 82 
        y1 = psq(1) 
&dA 
&dA &d@     Adding code &dA11/13/03&d@ to deal with mixed staff sizes &dIOK&d@ 
&dA 
        a4 = notesize 
        a3 = nsz(f11)                /* notesize of staff for this termination
        a5 = a4 - a3 * 4             /* length correction 
        if notesize <> a3 
          notesize = a3              /* set font size for computing pvpar(44)
          perform ps_init_par 
        end 
        y2 = psq(f11) + pvpar(44)      /* line thickness added &dA04-25-95&d@ 
        y2 -= a5 

        if notesize <> a4 
          notesize = a4              /* return to original font size 
          perform ps_init_par 
        end 
&dA   
        brkcnt = 0 
        if f11 > 1 or vst(1) > 0 
          perform putbar (f11)
        end 
&dA 
&dA &d@  2. typeset braces 
&dA 
        a2 = 0 
        loop for a1 = 1 to len(syscode)  
          if syscode{a1} = "[" 
            x = sp - phpar(46)  
            y1 = psq(a2+1)  
          end  
          if syscode{a1} = "]" 
            y2 = psq(a2) 
&dA 
&dA &d@     Adding code &dA11/13/03&d@ to deal with mixed staff sizes  &dIOK&d@ 
&dA 
            a4 = notesize 
            a3 = nsz(a2)             /* notesize of staff for this termination
            a5 = a4 - a3 * 4         /* length correction 
            y2 -= a5 
&dA   
            z = 84 
            brkcnt = 0 
            perform putbar (a2)
            y = y1 
            z = 87 
            perform setmus 
            y = y2 + pvpar(8) + vst(a2) 
            z = 88 
            perform setmus 
          end  
          if ".:,;" con syscode{a1}            /* changed &dA11/13/03&d@  &dIOK&d@ 
            ++a2
          end  
        repeat 
&dA 
&dA &d@  3. typeset brackets 
&dA 
        x1 = x - phpar(47)
        a2 = 0 
        loop for a1 = 1 to len(syscode)  
          if syscode{a1} = "{" 
            y1 = psq(a2+1)  
          end  
          if syscode{a1} = "}" 
            x = x1 
            y2 = psq(a2) + pvpar(8) + vst(a2) 
&dA 
&dA &d@     Adding code &dA11/13/03&d@ to deal with mixed staff sizes  &dIOK&d@ 
&dA 
            a4 = notesize 
            a3 = nsz(a2)             /* notesize of staff for this termination
            a5 = a4 - a3 * 4         /* length correction 
            y2 -= a5 
&dA   
            if notesize < 10 
              a7  = 66 
              a8  = 100 
              a9  = 3 
              a10 = 6 
              a11 = 96 
            else 
              a7  = 132 
              a8  = 201 
              a9  = 6 
              a10 = 12 
              a11 = 192 
            end 
            a3 = y2 - y1   
&dA 
&dA &d@      There are three cases:         a3 <= 201 (one glyph)    granularity = 6 
&dA &d@                              202 <= a3 <= 402 (two glyphs)   granularity = 12
&dA &d@                              403 <= a3 <= 570 (three glyphs) granularity = 12
&dA 
            if a3 <= a8                     /*                 New &dA03/11/06&d@ 
              a4 = a3 + 2 / a9 * a9         /* actual length   New &dA03/11/06&d@ 
              a5 = a4 - a3 / 2              /* delta / 2 
              y  = y1 - a5                  /* corrected value of y 
              a5 = a4 / a9 + 20             /* font number     New &dA03/11/06&d@ 
              scx = x 
              scy = y 
              scb = a5 
              if scb < 33 
                if (Debugg & 0x12) > 0 
#if DMUSE 
                  putc &dAWARNING&d@: You are trying to typeset a bracket which is too short.
                  putc          This is sometimes the result of a faulty system code.
                  putc          If other problems occur as well, check system code first.
#else 
                  pute WARNING: You are trying to typeset a bracket which is too short.
                  pute          This is sometimes the result of a faulty system code.
                  pute          If other problems occur as well, check system code first.
#endif 
                end 
                scb = 33 
              end 

              scf = 320 
              perform charout 
              scf = notesize 
            else 
              if a3 <= (a8 * 2)             /*                 New &dA03/11/06&d@ 
                a4 = a3 + 5 / a10 * a10     /* actual length   New &dA03/11/06&d@ 
                a5 = a4 - a3 / 2            /* delta / 2 
                y  = y1 - a5                /* corrected value of y 
                a5 = a4 / a10 + 10 * 2      /* font number     New &dA03/11/06&d@ 
                a6 = a4 / 2                 /* y increment to second glyph 
                scx = x 
                scy = y 
                scb = a5 
                scf = 320 
                perform charout 
                scy += a6 
                ++scb 
                perform charout 
                scf = notesize       
              else 
                a4 = a3 + 5 / a10 * a10     /* actual length   New &dA03/11/06&d@ 
                a5 = a4 - a3 / 2            /* delta / 2 
                y  = y1 - a5                /* corrected value of y 
                a5 = a4 / a10 - 5 * 3 + 1   /* font number     New &dA03/11/06&d@ 
                a6 = a4 - (a11 * 2)         /* y increment to third glyph    New &dA03/11/06
                scx = x 
                scy = y 
&dA 
&dA &d@           New code &dA01/31/10&d@ to enable display of extra-tall brackets.  
&dA &d@             Code uses new glyph 124 in the bracket font.  
&dA 
                if a5 > 121 
                  a5 = 115 
                   
                  scb = 115 
                  scf = 320 
                  perform charout                          /*  New &dA03/11/06&d@ 
                  scy += a11 
                  a12 = scy + (a6 - a7 / 2 )
                  scb = 124 
                  loop 
                    perform charout 
                    scy += 6 
                  repeat while scy < a12 
                  scy = a12 
                  scb = 116 
                  perform charout 
                  a12 = scy + a6 - (a6 - a7 / 2 ) 
                  scb = 124 
                  scy += a7 
                  loop 
                    perform charout 
                    scy += 6 
                  repeat while scy < a12 
                  scy = a12 
                  scb = 117 
                  perform charout 
                  scf = notesize 
               else 
                  scb = a5 
                  scf = 320 
                  perform charout 
                  scy += a11                               /*  New &dA03/11/06&d@ 
                  ++scb 
                  perform charout 
                  scy += a6 
                  ++scb 
                  perform charout 
                  scf = notesize 
                end 
              end 
            end 
          end  
          if ".:,;" con syscode{a1}            
            ++a2
          end  
        repeat 
      return 
