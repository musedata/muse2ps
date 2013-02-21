
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 27. process_section (f4)                           ³ 
&dA &d@³                                                      ³ 
&dA &d@³    Purpose:  Set parameters for new section          ³ 
&dA &d@³                                                      ³ 
&dA &d@³    Inputs:  divspq   = divisions per quarter         ³ 
&dA &d@³                 tnum = time numerator                ³ 
&dA &d@³                 tden = time denominator              ³ 
&dA &d@³                 @n   = set array counter (for        ³ 
&dA &d@³                         changes within measure)      ³ 
&dA &d@³                 line = "$" control code line         ³ 
&dA &d@³                                                      ³ 
&dA &d@³    Outputs:    p = new x position                    ³ 
&dA &d@³               f4                                     ³ 
&dA &d@³                                                      ³ 
&dA &d@³    Internal variables:  @spn                         ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure process_section (f4) 
        str line2.180 
        int t1,t2,t3,t4,t5,t6,t7 
        int f4 
        int @spn                                     /* New &dA01/17/04&d@ 

        getvalue f4 

&dA &d@ &dAÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿&d@ 
&dA &d@ &dA³  BEGINNING OF SECTION PROCESSING        ³&d@ 
&dA &d@ &dAÀÄÄ-ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ&d@ 

&dA 
&dA &d@      New code for single line staff    &dA12/18/05&d@ 
&dA 
        if line con "C:0" 
          single_line = 1 
        end 
&dA     
        if @n > 0 or outslurs <> "00000000" 
          if @n = 0 
            @spn = 6913 
          else 
            @spn = 0                      /* code for "don't use this information"
          end         
          if line con "I:" 
            vflag = int(line{mpt+2..}) 
            if vflag < 1 
              vflag = 1 
            end 
            if vflag > 3 
              vflag = 3 
            end 
          end 
          if line con "S:" 
            nstaves = int(line{mpt+2..}) 
            if nstaves < 1 
              nstaves = 1 
            end 
            if nstaves > 2 
              nstaves = 2 
            end 
          end 
          if line con "C:" or line con "C1:"               
            ++@n 
            tv1(@n) = CLEF_CHG 
            if line{mpt+2} = ":" 
              ++mpt 
            end 
            tv2(@n) = int(line{mpt+2..}) 
            tv3(@n) = 0                     /* staff number 
            if line con "D:" or line con "D1:" or large_clef_flag > 0  /* New &dA02/02/09
              tcode(@n) = "0"               /* music font 
            else 
              tcode(@n) = "128"             /* music font 
            end 
            tv5(@n) = @spn                  /* added &dA01/17/04&d@ 
          end 
          if line con "C2:" 
            ++@n 
            tv1(@n) = CLEF_CHG 
            tv2(@n) = int(line{mpt+3..}) 
            tv3(@n) = 1                     /* staff number 
            if line con "D2:" or large_clef_flag > 0                   /* New &dA02/02/09
              tcode(@n) = "0"               /* music font 
            else 
              tcode(@n) = "128"             /* music font 
            end 
            nstaves = 2 
            tv5(@n) = @spn                  /* added &dA01/17/04&d@ 
          end 
          if line con "D:" or line con "D1:" 
            ++@n 
            tv1(@n) = DESIGNATION 
            tv2(@n) = 0 
            tv3(@n) = 0                     /* staff number 
            tcode(@n) = "" 
            if line{mpt+1} <> ":" 
              ++mpt 
            end 
            line2 = trm(line{mpt+2..}) 
            tdata(@n,1) = mrt(line2) 
            tv5(@n) = @spn                  /* added &dA01/17/04&d@ 
          end 
          if line con "D2:" 
            ++@n 
            tv1(@n) = DESIGNATION 
            tv2(@n) = 0 
            tv3(@n) = 1                     /* staff number 
            tcode(@n) = "" 
            line2 = trm(line{mpt+3..}) 
            tdata(@n,1) = mrt(line2) 
            nstaves = 2 
            tv5(@n) = @spn                  /* added &dA01/17/04&d@ 
          end 
&dA 
&dA &d@     Another change on &dA05/29/05&d@.  In this case, I am moving the keychange "K:"
&dA &d@     code from below the "Q:" code to above the time "T:" code.  This conforms 
&dA &d@     with the normal way sections are introduced.  What I don't know, however,
&dA &d@     is whether this conflicts with some other convention, or whether the program
&dA &d@     code depended in some way on the old order.  Again, we must watch this
&dA &d@     and see if it produces strange results in the future.  
&dA 
          if line con "K:" 
            ++@n 
            tv1(@n) = AX_CHG 
            tv2(@n) = int(line{mpt+2..}) 
            tv3(@n) = nstaves 
            tcode(@n) = "" 
            tv5(@n) = @spn                  /* added &dA01/17/04&d@ 
          end 
&dA        
          if line con "T:" 
            ++@n 
            tv1(@n) = METER_CHG 
            tnum = int(line{mpt+2..}) 
            if line con "/" 
              tden = int(line{mpt+1..}) 
            else 
              tmess = 6 
              perform dtalk (tmess) 
            end 
            tv2(@n) = 100 * tnum + tden 
            tv3(@n) = nstaves 
            tcode(@n) = "" 
            tv5(@n) = @spn                  /* added &dA01/17/04&d@ 
          end 
          if line con "Q:" 
            ++@n 
            tv1(@n) = DIV_CHG 
            tv2(@n) = int(line{mpt+2..}) 
            tv3(@n) = 0           
            tcode(@n) = "" 
            tv5(@n) = @spn                  /* added &dA01/17/04&d@ 
          end 
          return  
        end 
*
        spn = 6913 
        if line con "I:" 
          vflag = int(line{mpt+2..}) 
          if vflag < 1 
            vflag = 1 
          end 
          if vflag > 3 
            vflag = 3 
          end 
        end 
        if line con "S:" 
          nstaves = int(line{mpt+2..}) 
          if nstaves < 1 
            nstaves = 1 
          end 
          if nstaves > 2 
            nstaves = 2 
          end 
        end 
        if line con "D2:" 
          nstaves = 2 
        end 
&dA 
&dA &d@   (1) clef 
&dA 
        if line con "C:" or line con "C1:" or line con "C2:" 
          t2 = 0 
          t1 = 0 
          if line con "C:" or line con "C1:" 
            if line{mpt+1} = ":" 
              t2 = mpt + 2 
            else 
              t2 = mpt + 3 
            end 
          end 
          if line con "C2:" 
            t1 = mpt + 3 
            nstaves = 2 
          end 
          if (t2 * t1) = 0      /* Case1: only one clef designator 
            if t2 > 0 
              t3 = 1 
            else 
              t2 = t1 
              t3 = 2 
            end 
            clef(t3) = int(line{t2..}) 
&dA 
&dA &d@      Special code for single line instruments &dA12/18/05&d@ 
&dA 
            if single_line = 1 
              clef(1) = 4 
            end 
&dA     
            perform zjcline (t3) 
            if p > 0 
              p -= hpar(37) 
            end 
            p += hpar(5) 
*   print clef 
            obx = p 
            oby = 5 - clef_vpos * notesize 
            oby = (t3 - 1) * 1000 + oby 
            if single_line = 0                   /* New condition &dA12/18/05&d@ 
              perform putclef (t3) 
            end 
          else            /* Case2: two clef designators 
            t3 = 1 
            clef(t3) = int(line{t2..}) 
            perform zjcline (t3) 
            if p > 0 
              p -= hpar(37) 
            end 
            p += hpar(5) 
*   print clef on staff 1  
            obx = p 
            oby = 5 - clef_vpos * notesize 
            perform putclef (t3) 
            t3 = 2 
            clef(t3) = int(line{t1..}) 
            perform zjcline (t3) 
*   print clef on staff 2 
            obx = p 
            oby = 5 - clef_vpos * notesize 
            oby += 1000
            perform putclef (t3) 
          end 
*   advance horizontal pointer 
          p += hpar(8) 
          t6 = hpar(8) - hpar(86) 
          loop for t1 = 1 to MAX_STAFF 
            loop for t5 = 1 to 45 
              emptyspace(t1,t5) = t6 
            repeat 
          repeat 
        end 
&dA 
&dA &d@   (2) key signature  
&dA 
        if line con "K:" 
          t4 = int(line{mpt+2..}) 
          if line{sub} = "("                  /* new code &dA08/23/06&d@ 
            if line{sub+1} = "+" 
              t1 = int(line{sub+2..}) 
            else 
              t1 = int(line{sub+1..}) 
            end 
          else 
            t1 = 0 
          end 
          t5 = 1 
          perform key_change (t4, key, nstaves, t5, t1)    /* fifth variable added &dA08/23/06

          /* this sets key = t4 and resets claveax(.), emptyspace(.,.)  etc.  

        end 
&dA 
&dA &d@   (3) divisions per quarter 
&dA 
        if line con "Q:" 
          olddivspq = int(line{mpt+2..}) 
        end 
&dA 
&dA &d@   (4) time word 
&dA 
        if line con "D:" or line con "D1:" or line con "D2:" 
          a1 = 6913 
          if line not_con "T:" 
            a1 = 1 
&dA 
&dA &d@    f4 is set when a directive is placed with spn = 1.  This 
&dA &d@    directive takes its position from the next controlling 
&dA &d@    object in the part.  Therefore, it must not be followed 
&dA &d@    by a multiple rest.  
&dA 
            f4 = 1 
            passback f4 
          end 
          if line con "D:" 
            temp3 = trm(line{mpt+2..}) 
            temp3 = mrt(temp3) 
            oby = 0 - tword_height * vpar(1) 
            ++outpnt 
            tput [Y,outpnt] J D 5 ~p  ~oby  1 ~a1  0 0 
            ++outpnt 
            tput [Y,outpnt] W 0 0 ~dtivfont  ~temp3 
          end 
          if line con "D1:" 
            temp3 = trm(line{mpt+2..}) 
            temp3 = mrt(temp3) 
            oby = 0 - tword_height * vpar(1) 
            ++outpnt 
            tput [Y,outpnt] J D 5 ~p  ~oby  1 ~a1  0 0 
            ++outpnt 
            tput [Y,outpnt] W 0 0 ~dtivfont  ~temp3 
          end 
          if line con "D2:" 
            temp3 = trm(line{mpt+2..}) 
            temp3 = mrt(temp3) 
            oby = 0 - tword_height * vpar(1) 
            oby += 1000 
            ++outpnt 
            tput [Y,outpnt] J D 5 ~p  ~oby  1 ~a1  0 0 
            ++outpnt 
            tput [Y,outpnt] W 0 0 ~dtivfont  ~temp3 
          end 
        end 
&dA 
&dA &d@   (5) time signature (also new note spacing calculations) 
&dA 
        if line con "T:" 
          tnum = int(line{mpt+2..}) 
          if line con "/" 
            tden = int(line{mpt+1..}) 
          else 
            tmess = 6 
            perform dtalk (tmess) 
          end 
          oby = 0 
          t6 = p 
          loop for t5 = 1 to nstaves 
            p = t6 
            perform settime (t1) 
&dA 
&dA &d@       Actually, we will set emptyspace to hpar(29), the mimimum space 
&dA &d@       space allowed before an accidental.  This way, no note-type 
&dA &d@       objects will be able to crowd the time signature.  If this 
&dA &d@       works, we can remove the code that returns the value (t1) from 
&dA &d@       settime.  (We actually shouldn't be interested in this value 
&dA &d@       anyway, because we do NOT want to get too close to the time 
&dA &d@       signature.) 
&dA 
            loop for t7 = 1 to 45 
              emptyspace(t5,t7) = min_space            /* replaces hpar(29)   &dA11/19/07
            repeat 
            oby += 1000 
          repeat 
          if tnum = 1 and tden = 1 
            tnum = 4 
            tden = 4 
          end 
          if tnum = 0 and tden = 0 
            tnum = 2     
            tden = 2 
          end 
&dA 
&dA &d@   determine note spacing 
&dA &d@   ---------------------- 
&dA 
          divspq = olddivspq 
          perform newnsp 
        end 
      return 

&dA &d@ &dAÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿&d@ 
&dA &d@ &dA³  END OF SECTION PROCESSING    ³&d@ 
&dA &d@ &dAÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ&d@ 
