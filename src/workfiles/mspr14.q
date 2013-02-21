
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³M* 14. procedure pageform_init                                    ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Purpose:  Get parameters for page layout.                     ³ 
&dA &d@³                                                                  ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure pageform_init 
        str savesyscode.80 
        int t1,t2,t3,t4,t5 

        toplim = Top_of_page 
        lowerlim = toplim + Length_of_page 
        psq(1) = toplim

        tacetline = "" 

        justflag = Just_flag * 2 
        hxpar(3) = Marg_left 
        hxpar(4) = hxpar(3) + Sys_width 
&dA 
&dA &d@    Check the format of syscode 
&dA 
        syscode = Syscode 

        t1 = 0 
        t2 = 0 
        loop for t4 = 1 to len(syscode) 
          if "[](){}" con syscode{t4} 
            t3 = mpt + 1 >> 1 
            ++tarr(t3) 
            ++t1 
            if bit(0,tarr(t3)) <> bit(0,mpt) 
              tmess = 68 
              perform dtalk (tmess) 
            end 
          end 
          if "x:" con syscode{t4} 
            f(t2+1,12) = mpt 
            syscode{t4} = "." 
          else 
            f(t2+1,12) = 0 
          end 
          if syscode{t4} = "." 
            ++t2 
            loop for t3 = 1 to 3 
              if bit(0,tarr(t3)) <> 0 
                goto SQ11 
              end 
            repeat 
            tmess = 68 
            perform dtalk (tmess) 
          end 
SQ11:   repeat 
        if t2 <> f11 
          tmess = 68 
          perform dtalk (tmess) 
        end 
        if bit(0,t1) = 1 
          tmess = 68 
          perform dtalk (tmess) 
        end 
&dA 
&dA &d@    Get and check spacings 
&dA 
        if W(1) = 0 
&dA 
&dA &d@    Construct default spacings 
&dA 
          t2 = 0 
          t3 = 0 
          loop for t1 = 1 to Nparts 
            w(t1) = 0 
          repeat 
          loop for t1 = 1 to len(Syscode) 
            if ".:" con Syscode{t1} 
              if t2 = 0 
                t2 = 1 
              else 
                ++t3 
                w(t3) += 10 
              end 
            else 
              if t1 < len(Syscode) 
                if ")]" con Syscode{t1} 
                  w(t3+1) += 2 
                end 
              end 
            end 
          repeat 
          ++t3 
          if t3 = Nparts 
            w(t3) = 15 
          else 
            w(t3) = 10 
          end 
          loop for t4 = 1 to Nparts 
            W(t4) = w(t4) * notesize 
          repeat 
        end 
        loop for t4 = 1 to Nparts 
          w(t4) = W(t4) 
        repeat 

        loop for t4 = 2 to f11 
          if w(1) = 0 
            if f(t4-1,9) = 0 
              psq(t4) = psq(t4-1) + mvpar(t4-1,14) 
            else 
              psq(t4) = psq(t4-1) + mvpar(t4-1,11) 
            end 
          else 
            psq(t4) = psq(t4-1) + w(t4-1) 
          end 
          if f(t4-1,12) = 2 
            if vst(t4-1) = 0 
              vst(t4-1) = mvpar(t4-1,14) 
            end 
            psq(t4) += vst(t4-1) 
          else 
            vst(t4-1) = 0 
          end 
        repeat 
        if f(f11,12) = 2 
          if vst(f11) = 0 
            vst(f11) = mvpar(f11,14) 
          end 
        end 
      
        no_action = 0 
        psysnum = 0 
        start_look = 1 
        pn_left = 0 
&dA 
&dA &d@   This code added &dA12/24/03&d@ to set new variables intersys and firstsys 
&dA 
        if w(1) = 0 
          intersys = mvpar(f11,14) * 3 / 2 
        else 
          intersys = w(f11) 
        end 
        firstsys = TRUE 
      return 
