
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 15. setrest (t6)                                             ³ 
&dA &d@³                                                                ³ 
&dA &d@³    Purpose:  write object rest                                 ³ 
&dA &d@³                                                                ³ 
&dA &d@³    Inputs:  c1       = pointer into set array for this rest    ³ 
&dA &d@³             obx      = horizontal position of rest             ³ 
&dA &d@³             oby      = vertical position of rest               ³ 
&dA &d@³             c3       = oby offset (for grand staff)            ³ 
&dA &d@³             ntype    = type of note (e.g. sixteenth)           ³ 
&dA &d@³             passsize = rest type (full size, cue size)         ³ 
&dA &d@³             passtype = type of pass (reg,cue,grace,cuegrace)   ³ 
&dA &d@³             passnum  = pass number for this rest               ³ 
&dA &d@³             inctype  = increment type for next node            ³ 
&dA &d@³                          with a new spn (used in putobj)       ³ 
&dA &d@³             opt_rest_flag = put out rest with small r          ³ 
&dA &d@³             color_flag = put out rest in color  (&dA12/21/10&d@)     ³ 
&dA &d@³                                                                ³ 
&dA &d@³    Output:  t6       = amount of space taken up                ³ 
&dA &d@³                                                                ³ 
&dA &d@³    Operation:  In addition to writing the object rest, this    ³ 
&dA &d@³                procedure must also check to see if the rest is ³ 
&dA &d@³                the beginning or end of a tuplet group.  In the ³ 
&dA &d@³                former case, the tuplet array, tuar, must be    ³ 
&dA &d@³                constructed; in the latter case, the tuplet     ³ 
&dA &d@³                super-object must be compiled and written out.  ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure setrest (t6) 
        str temp.100 
        int t1,t2,t3,t4,t5,t6,t7,t8,t9,t10 

        t10 = c3 
        x = obx
        y = oby  
        t1 = 0
        if ntype > QUARTER 
          t6 = hpar(87)                   /* total horizontal space taken 
        else 
          t6 = hpar(88)                   /* total horizontal space taken 
        end 
              
        if ntype > SIXTEENTH
          z = 128 * passsize + 55 - ntype       /* music font 
          if color_flag > 0
            perform subj3 (color_flag)          /* New &dA12/21/10&d@ 
          else 
            perform subj 
          end 
        else 
          y += notesize 
          if ntype < THIRTY_SECOND
            y = 4 - ntype * notesize + y   
          end  
          z = 128 * passsize + 49               /* music font 
          if color_flag > 0
            perform subj3 (color_flag)          /* New &dA12/21/10&d@ 
          else 
            perform subj 
          end 
          ++z
          if passsize = FULLSIZE
            t3 = notesize 
            t4 = hpar(54) 
          else 
            t3 = vpar(65) 
            t4 = hpar(89) 
          end 
          t2 = ntype 
          loop while t2 < EIGHTH
            y -= t3
            x += t4
            t6 += t4                      /* total horizontal space taken 
            ++t1
            if color_flag > 0
              perform subj3 (color_flag)        /* New &dA12/21/10&d@ 
            else 
              perform subj 
            end 
            ++t2 
          repeat 
        end  
        if ts(c1,DOT) > 0  
          t3 = ts(c1,DOT) 
          t8 = t3 & 0x0f                  /* actual DOT code  (modified &dA12-24-96&d@)
          t3 >>= 4                        /* code modified &dA12-24-96&d@ 
          t3 /= INT10000 
          t7 = rem 
          if t7 > (INT10000 >> 1) 
            t7 -= INT10000 
            ++t3 
          end 
          y = oby + t7 
          x += t3 
          t6 = vpar(1) 
          if passsize = CUESIZE
            t6 = t6 * 8 / 10              /* space for dot   
          end 
          t6 += t3 
          z = 128 * passsize + 44               /* music font 
          if color_flag > 0
            perform subj3 (color_flag)          /* New &dA12/21/10&d@ 
          else 
            perform subj                        /* first dot 
          end 
          if t8 & 0x02 = 2 
            t5 = hpar(91) 
            x += t5                       
            if color_flag > 0
              perform subj3 (color_flag)        /* New &dA12/21/10&d@ 
            else 
              perform subj                      /* second dot 
            end 
            t6 += t5 
          end

&dA &d@     code added &dA12-24-96&d@ 

          if t8 & 0x04 = 4 
            t5 = hpar(91) 
            x += t5                       
            if color_flag > 0
              perform subj3 (color_flag)        /* New &dA12/21/10&d@ 
            else 
              perform subj                      /* third dot 
            end 
            t6 += t5 
          end
          if t8 & 0x08 = 8 
            t5 = hpar(91) 
            x += t5                       
            if color_flag > 0
              perform subj3 (color_flag)        /* New &dA12/21/10&d@ 
            else 
              perform subj                      /* fourth dot 
            end 
            t6 += t5 
          end

        end 
SRST1: 
        passback t6                       /* total horizontal space taken 
&dA 
&dA &d@    New &dA10/15/07&d@ 
&dA 
        if opt_rest_flag = 0 
          jtype = "R" 
        else 
          jtype = "r" 
        end 

        jcode = ntype  
        out = "0"  
        if bit(4,ts(c1,SUPER_FLAG)) = 1   /* if begin tuplet
          ++snum
          tuar(passtype,passnum,TU_SNUM) = snum 
          tuar(passtype,passnum,TU_Y1) = y  
          tuar(passtype,passnum,TU_Y2) = y  
          tuar(passtype,passnum,TU_FSTEM) = DOWN   /*  (default)
          t7 = 0 
          if bit(6,ts(c1,SUPER_FLAG)) = 1         /* tuplet has a bracket 
            t7 = ts(c1,SUPER_FLAG) & 0x3c0        /* bits 6,7,8,9 &dA03-21-97&d@ 
            t7 <<= 2 
          end 
          tuar(passtype,passnum,TU_FSTEM) += t7   /* tuplet flags &dA03-21-97&d@ 
          out = "1 " // chs(snum)  
        end  
        if bit(5,ts(c1,SUPER_FLAG)) = 1   /* if end tuplet
          t7 = tuar(passtype,passnum,TU_FSTEM) & 0xff 
          goto TPFF(tpflag+1) 
TPFF(1):                                   /* default tuplet placement 
TPFF(2):                                   /* place tuplet near note heads 
          if t7 = UP 
            goto TPFFA 
          else 
            goto TPFFB 
          end 
TPFF(3):                                   /* place tuplet near stems 
          if t7 = UP 
            goto TPFFB 
          else 
            goto TPFFA 
          end 
TPFF(4):                                   /* place all tuplets above notes 
          goto TPFFB 
TPFF(5):                                   /* place all tuplets below notes 
          goto TPFFA 

TPFFA:
          t3 = tuar(passtype,passnum,TU_Y2) + notesize + vpar(64) 
          t4 = notesize * 6 
          if t7 <> UP 
            t3 += vpar(7) 
          end 
          if t3 < t4 
            t3 = t4 
          end 
          t9 = 4          /* tips up &dA03-21-97&d@ 
          goto TPFFC 
TPFFB: 
          t3 = tuar(passtype,passnum,TU_Y2) - notesize 
          t4 = 0 - vpar(1)         
          if t7 = UP 
            t3 -= vpar(7) 
          end 
          if t3 > t4 
            t3 = t4 
          end 
          t9 = 0          /* tips down &dA03-21-97&d@ 
TPFFC:
          t3 -= tuar(passtype,passnum,TU_Y1) 
          t5 = t4 - oby 
          out = "1 " // chs(tuar(passtype,passnum,TU_SNUM))   
        end  
&dA 
&dA &d@ fermata over rest  
&dA 
        if bit(26,ts(c1,SUBFLAG_1)) = 1        /* New &dA12/18/10&d@ 
          t2 = 15                       /* upright fermata code = 15 
          perform getpxpy (t2,c1) 

          x = obx + px 
          if pyy > 0 
            y = py 
          else 
            y = py - vpar(1) 
          end 
          z = 101                         /* music font
          if color_flag > 4 
            perform subj3 (color_flag)        /* New &dA12/21/10&d@ 
          else 
            perform subj 
          end 
        end  
        if bit(27,ts(c1,SUBFLAG_1)) = 1        /* New &dA12/18/10&d@ 
          t2 = 16                       /* inverted fermata code = 16 
          perform getpxpy (t2,c1) 

          x = obx + px 
          z = 102                         /* music font
          y = vpar(10)                    /* changed &dA05/02/03&d@ 
          if pyy > 0 
            y = py 
          else 
            y += py 
          end 
          if color_flag > 4 
            perform subj3 (color_flag)        /* New &dA12/21/10&d@ 
          else 
            perform subj 
          end 
        end  
        if sobcnt = 1  
          pcode = z  
        else 
          pcode = sobcnt 
        end  
        t7 = inctype 
        if ts(c1,CLAVE) = 101             /* if movable rest
          inctype = 10000  
        end  
&dA 
&dA &d@    New code add 01/03/04 to deal with special case of type 7 whole rests 
&dA 
        if ts(c1,CLAVE) = 102             /* flag whole rest as potentially "removable"
          inctype = 10001 
        end  
        oby += t10 
&dA 
&dA &d@       Now look for print suggestions for this note object 
&dA 
        putobjpar = 0 
        t4 = ts(c1,TSR_POINT) 
        pcontrol = ors(tsr(t4){1})                      /* &dA05/02/03&d@ 
        px = ors(tsr(t4){3}) << 8 
        py = ors(tsr(t4){4}) << 16 
        t1 = ors(tsr(t4){2}) << 24 
        putobjpar = t1 + px + py + pcontrol             /* Note: order of data has been changed

        perform putobj                    
        inctype = t7 
        if bit(5,ts(c1,SUPER_FLAG)) = 1   /* if end tuplet
          t1 = tuar(passtype,passnum,TU_FSTEM) >> 8           /* tuplets flags &dA03-21-97
          if t1 > 0 
            t1 >>= 1                /* remove bracket present flag 
            t1 <<= 5 
            t9 |= t1 
            t9 |= 0x02              /* bracket present flag 
          else 
            t9 = 1 
          end 
          ++outpnt 
&dA 
&dA &d@      New &dA11/05/05&d@  Convert TUPLE to 1000 * n1 + n2 format and get x,y adjustments
&dA 
          t1 = ts(c1,TUPLE) & 0xffff 
          t2 = t1 >> 8 
          t1 &= 0xff 
          t2 *= 1000 
          t1 += t2 

          t6 = ts(c1,TUPLE) & 0xff0000        /* x adjustment 
          t6 >>= 16 
          if t6 > 0 
            t6 = t6 - 128                     /* center to zero 
          else 
            t6 = 0 
          end 

          t4 = ts(c1,TUPLE) & 0xff000000      /* y adjustment 
          t4 >>= 24 
          if t4 > 0 
            t4 = t4 - 128                     /* center to zero 
          else 
            t4 = 0 
          end 
          t3 += t4 
          t5 += t4 
&dA                  

          tput [Y,outpnt] H ~tuar(passtype,passnum,TU_SNUM)  X ~t9  ~t1  ~t6  ~t3  ~t6  ~t5  0
          tuar(passtype,passnum,TU_SNUM) = 0        /* New added from s2ed 
          tpflag = global_tpflag 
        end  
      return 
