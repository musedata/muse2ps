
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P*  8. setart (operates on an entire chord at once)               ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Purpose:  create sub-objects for dots, spiccato and legato.   ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Inputs:  obx = x-position of object                           ³ 
&dA &d@³             oby = y-position of object                           ³ 
&dA &d@³              c1 = pointer to top note of chord                   ³ 
&dA &d@³              c2 = pointer to bottom note of chord                ³ 
&dA &d@³            stem = stem direction (UP or DOWN)                    ³ 
&dA &d@³      color_flag = put out articulations in color  (&dA12/21/10&d@)     ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Outputs:  Program may modify virtual endpoints in the ts      ³ 
&dA &d@³                array.                                            ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Operation:  There are two rules that can be followed          ³ 
&dA &d@³             Rule 1: (chord = single note, or dot on middle note  ³ 
&dA &d@³                         of chord, or more than one dot)          ³ 
&dA &d@³               If there is a slur, and slur starts (ends) near    ³ 
&dA &d@³                   the dot, put dot under (over) slur;            ³ 
&dA &d@³                 otherwise, if multi-track > 0, put dot on stem;  ³ 
&dA &d@³                   otherwise put dot on note head.                ³ 
&dA &d@³                                                                  ³ 
&dA &d@³             Rule 2: (all other situations)                       ³ 
&dA &d@³               If dot on note at stem end, put dot on stem;       ³ 
&dA &d@³                 otherwise, put dot at head end of chord.         ³ 
&dA &d@³                                                                  ³ 
&dA &d@³             If there is a slur into or out of this chord, then   ³ 
&dA &d@³             information on the placement of dot/legato or        ³ 
&dA &d@³             spiccato has already been compiled and is stored     ³ 
&dA &d@³             in the SLUR_X ROW element.  Otherwise, the place-    ³ 
&dA &d@³             ment needs to be computed here.                      ³ 
&dA &d@³                                                                  ³ 
&dA &d@³             Virtual endpoints are modified in all cases.         ³ 
&dA &d@³                                                                  ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure setart   
        int t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13 
        int dot_xshift                                      /* New &dA05/14/05&d@ 

        t2 = 0 
        t9 = 0 
        loop for t1 = c1 to c2 
          t10 = ts(t1,SUBFLAG_2) & 0x3c    /* &dA05/17/03&d@ Editorial arts not yet supported
          if t10 > 0 
            ++t2      
            t3 = t1 
            t9 |= t10                 /* composite flag for chord 
          end 
&dA 
&dA &d@     Using grace dot to typeset editorial staccato &dA02/06/04&d@ 
&dA 
          t10 = ts(t1,ED_SUBFLAG_2) & 0x0c      /* editorial staccato & spiccato
          if t10 > 0 
            t10 <<= 8                           /* put this in higher order byte
            ++t2      
            t3 = t1 
            t9 |= t10                 
          end 
&dA   
        repeat 
        if t2 = 0 
          return 
        end 
&dA 
&dA &d@   Step 1: determine starting position for dot/legatos or spiccatos 
&dA 
        t13 = 0       /* &dA03/24/97&d@  potential modification to x position of articulation

        if c1 = c2 or (t3 <> c1 and t3 <> c2) or t2 > 1   /* follow rule 1 
          t4 = ts(c1,SLUR_X) 
          if t4 > 0 and ts(t4,6) > 0     /* there is a slur effecting dot 
            y = ts(t4,5) 
            t5 = ts(t4,6)             /* above/below flag 
            t8 = 0                    /* no adjustment to virtual end points 
          else 
            t10 = ts(c1,MULTI_TRACK) >> 2 
            if t10 > 0                      /* &dACHANGED&d@ from = 3  on &dA03/24/97
              if ts(c1,PASSNUM) = 1 and stem = DOWN 
                t10 = 0 
              end 
              if ts(c1,PASSNUM) = 2 and stem = UP  
                t10 = 0 
              end 
            end 
&dA 
&dA &d@     Code added &dA03/24/97&d@ to check for print suggestions for articulations 
&dA 
            t12 = 1                        /* articulation code = 1 
            if t9 & 0x04 > 0               /* spiccato code = 2         &dA05/02/03
              ++t12 
            end 

            perform getpxpy (t12,c1) 
            if pcontrol & 0x03 = 0x03      /* major location change flag 
              if bit(2,pcontrol) = 1       /* place below 
                t5 = BELOW 
                if stem = UP 
                  y = ts(c1,VIRT_NOTE) 
                  t8 = notesize 
                else 
                  y = ts(c1,VIRT_STEM) 
                  t8 = vpar(1) 
                  if ts(c1,BEAM_FLAG) > NO_BEAM 
                    t8 = vpar(2) 
                  end 
                end 
              else 
                t5 = ABOVE 
                if stem = UP 
                  y = ts(c1,VIRT_STEM) 
                  t8 = vpar(1) 
                  if ts(c1,BEAM_FLAG) > NO_BEAM 
                    t8 = vpar(2) 
                  end 
                else 
                  y = ts(c1,VIRT_NOTE) 
                  t8 = notesize 
                end 
              end 
            else 
&dA 
&dA &d@     End of &dA03/24/97&d@ addition 
&dA 
              if t10 > 0 
                y = ts(c1,VIRT_STEM) 
                if stem = UP 
                  t5 = ABOVE 
                else 
                  t5 = BELOW 
                end 
                t8 = vpar(1) 
                if ts(c1,BEAM_FLAG) > NO_BEAM 
                  t8 = vpar(2) 
                end 
              else 
                y = ts(c1,VIRT_NOTE) 
                if stem = UP 
                  t5 = BELOW 
                else 
                  t5 = ABOVE 
                end 
                t8 = notesize 
              end 
&dA 
&dA &d@      New &dA11/10/07&d@   We need some code here which disables the interference section
&dA &d@                     below when there is a y-position modifier, 
&dA 
              if pcontrol & 0x01 > 0 
                if (py = 0 and pyy = 0) or pyy = 1 
                  t8 = 0  
                end 
              end 
&dA         
            end 

            if pyy > 0 
              y = py 
            else 
              y += py 
            end 
            t13 = px 

          end 
        else                                              /* follow rule 2 
&dA 
&dA &d@     Code added &dA03/24/97&d@ to check for print suggestions for articulations 
&dA 
          t12 = 1                        /* articulation code = 1 
          if t9 & 0x04 > 0               /* spiccato code = 2         &dA05/02/03
            ++t12 
          end 

          perform getpxpy (t12,c1) 
          if pcontrol & 0x03 = 0x03      /* major location change flag 
            if bit(2,pcontrol) = 1       /* place below 
              t5 = BELOW 
              if stem = UP 
                y = ts(c1,VIRT_NOTE) 
                t8 = notesize 
              else 
                y = ts(c1,VIRT_STEM) 
                t8 = vpar(1) 
              end 
            else 
              t5 = ABOVE 
              if stem = UP 
                y = ts(c1,VIRT_STEM) 
                t8 = vpar(1) 
              else 
                y = ts(c1,VIRT_NOTE) 
                t8 = notesize 
              end 
            end 
          else 
&dA 
&dA &d@     End of &dA03/24/97&d@ addition 
&dA 
            if stem = UP 
              if t3 = c1                                    /* top note 
                t5 = ABOVE 
                y = ts(c1,VIRT_STEM) 
                t8 = vpar(1) 
              else 
                t5 = BELOW 
                y = ts(c1,VIRT_NOTE) 
                t8 = notesize 
              end 
            else 
              if t3 = c1                                    /* top note 
                t5 = ABOVE 
                y = ts(c1,VIRT_NOTE) 
                t8 = notesize 
              else 
                t5 = BELOW 
                y = ts(c1,VIRT_STEM) 
                t8 = vpar(1) 
              end 
            end 
&dA 
&dA &d@      New &dA11/10/07&d@   We need some code here which disables the interference section
&dA &d@                     below when there is a y-position modifier, 
&dA 
            if pcontrol & 0x01 > 0 
              if (py = 0 and pyy = 0) or pyy = 1 
                t8 = 0 
              end 
            end 
&dA         
          end 

          if pyy > 0 
            y = py 
          else 
            y += py 
          end 
          t13 = px 

        end 
&dA 
&dA &d@     New (&dA05/14/05&d@) code to set value of dot_xshift for staccato over (under) stem
&dA 
        dot_xshift = 0                                      
        if t5 = ABOVE 
          if stem = UP 
            dot_xshift = hpar(19)                           
            if ts(c1,BEAM_FLAG) <= NO_BEAM 
              y -= vpar(1) 
            end 
          end 
        else 
          if stem = DOWN 
            dot_xshift = 0 - hpar(19)
            if ts(c1,BEAM_FLAG) <= NO_BEAM 
              y += vpar(1) 
            end 
          end 
        end 
&dA         

&dA 
&dA &d@     check for interference in cases where y is based on VIRT_ 
&dA 
        if t8 <> 0 
          if (stem = DOWN and t5 = ABOVE) or (stem = UP and t5 = BELOW) 
            t11 = HEAD 
          else 
            t11 = TAIL 
          end 
          if (t9 & 0x04 > 0) or (t9 & 0x400 > 0)     /* spiccato is special case (&dA02/06/04&d@)
            if stem = DOWN 
              if t5 = ABOVE         /* note 
                if y > vpar(1) 
                  y = vpar(1) 
                end 
                y -= 5 * notesize / 4 
              else 
                if y < vpar(8) 
                  y = vpar(8) 
                end 
                y += vpar(1) + vpar(50)      /* OK 4-22-95 
              end 
            else                /* UP 
              if t5 = ABOVE 
                if y > 0 
                  y = 0 
                end 
                y -= vpar(1) 
                c16 = y * 2 / vpar(2) 
                if rem <> 0 
                  --y 
                end 

              else                  /* note 
                if y < vpar(7) 
                  y = vpar(7) 
                end 
                y += 5 * notesize / 4 + vpar(50) 
              end 
            end 
          else 
            t6 = 1 
            if t5 = ABOVE 
              y -= t8 
              if y >= 0 
                t6 = y / notesize 
                t6 = rem 
              else 
                y = 0 - notesize / 4 + y 
              end 
              t7 = -1 
            else 
              y += t8 
              if y <= vpar(8) 
                t6 = y / notesize 
                t6 = rem 
              else 
                y = notesize / 4 + y 
              end 
              t7 = 1 
            end 
&dA 
&dA &d@     adjust for interference with staff 
&dA 
            if t6 = 0 
              c16 = t7 + 20 * vpar(2) / 2 - vpar20 
              y += c16 

            end 
          end 
        end 
&dA 
&dA &d@   Step 2: write out articulations 
&dA 

&dA 
&dA &d@    Code addition &dA01/06/06&d@: If art_flag = 48, then please set all staccatos and/or
&dA &d@                            legatos above the note and above the staff lines.
&dA 
        if art_flag = 48 
          if t9 & 0x38 > 0 
            if y > (0 - vpar(1)) 
              y = 0 - vpar(1) 
            end 
          end 
        end 
&dA      
        x = obx + t13 
        if t9 & 0x18 > 0                  /* staccato 
          z = 96                          /* music font 
          x += dot_xshift                 /* New &dA05/14/05&d@ 
          if color_flag > 4 
            perform subj3 (color_flag)    /* New &dA12/21/10&d@ 
          else 
            perform subj 
          end 
          x -= dot_xshift                 /* New &dA05/14/05&d@ 
          y = notesize * t7 + y 
        end 
        if t9 & 0x30 > 0                  /* legato 
          z = 99                          /* music font 
          x += dot_xshift                 /* New &dA05/14/05&d@ 
          if color_flag > 4 
            perform subj3 (color_flag)    /* New &dA12/21/10&d@ 
          else 
            perform subj 
          end 
          x -= dot_xshift                 /* New &dA05/14/05&d@ 
          y = notesize * t7 + y 
        end 
&dA 
&dA &d@   Using grace dot to typeset editorial staccato &dA02/06/04&d@ 
&dA 
        if t9 & 0x800 > 0 
          z = 172                         /* grace dot used as editorial staccato
          x += vpar(1) / 2 
          x += dot_xshift / 2             /* New &dA05/14/05&d@ and &dA09/22/05&d@ 
          perform subj 
          x -= dot_xshift / 2             /* New &dA05/14/05&d@ and &dA09/22/05&d@ 
          x -= vpar(1) / 2 
          y = notesize * t7 + y 
        end 
&dA 
&dA &d@   Using ordinary spiccato for the moment to typeset editorial spiccato &dA02/06/04
&dA 
        if t9 & 0x400 > 0                 /* spiccato 
          z = 98                          /* music font 
          if t5 = ABOVE 
            --z                           /* music font 
          end 
          x += dot_xshift                 /* New &dA05/14/05&d@ 
&dA 
&dA &d@      Code added &dA05/26/05&d@ to implement arbitrary placement of editorial spiccatos
&dA 
          if bit(2,art_flag) = 1 
            t13 = y 
            if stem = UP 
              y = oby + vpar(4) 
            else 
              y = oby - (vpar(5) / 2) 
            end 
            perform subj 
            y = t13 
          else 
            perform subj 
          end 
&dA       
          x -= dot_xshift                 /* New &dA05/14/05&d@ 
          if t5 = BELOW 
            y -= vpar(50) 
          end 
          if y >= 0  
            y = y * 2 + 1 / vpar(2) 
          else 
            y = y * 2 - 1 / vpar(2) 
          end 
          y = y * vpar(2) / 2   
        else 
&dA   
          if t9 & 0x04 > 0                /* spiccato 
            z = 98                        /* music font 
            if t5 = ABOVE 
              --z                         /* music font 
            end 
            x += dot_xshift               /* New &dA05/14/05&d@ 
&dA 
&dA &d@      Code added &dA05/26/05&d@ to implement arbitrary placement of spiccatos 
&dA 
            if bit(2,art_flag) = 1 
              t13 = y 
              if stem = UP 
                y = oby + vpar(4) 
              else 
                y = oby - (vpar(5) / 2) 
              end 
              if color_flag > 4 
                perform subj3 (color_flag)    /* New &dA12/21/10&d@ 
              else 
                perform subj 
              end 
              y = t13 
            else 
              if color_flag > 4 
                perform subj3 (color_flag)    /* New &dA12/21/10&d@ 
              else 
                perform subj 
              end 
            end 
&dA       
            x -= dot_xshift               /* New &dA05/14/05&d@ 
            if t5 = BELOW 
              y -= vpar(50) 
            end 
            if y >= 0 
              y = y * 2 + 1 / vpar(2) 
            else 
              y = y * 2 - 1 / vpar(2) 
            end 
            y = y * vpar(2) / 2 

          else 
            y -= notesize * t7 
          end 
        end 
&dA 
&dA &d@   Step 3: adjust virtual end points 
&dA 
        if t8 <> 0 
          if t11 = HEAD 
            loop for t8 = c1 to c2 
              ts(t8,VIRT_NOTE) = y 
            repeat 
          else 
            loop for t8 = c1 to c2 
              ts(t8,VIRT_STEM) = y 
            repeat 
          end 
        end 
      return 
