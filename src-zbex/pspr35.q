
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 35. charout                                                 ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Operation:  Put out a character (to the ps output table)   ³ 
&dA &d@³                Advance the scx pointer, which would normally  ³ 
&dA &d@³                be done by the setb instruction.  setb here    ³ 
&dA &d@³                simply puts out a dummy character for the      ³ 
&dA &d@³                sake of constructing the bounding box (later). ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure charout 
        int font,kk 
        font = revmap(scf) 
        int scx2 
        scx2 = scx 
&dA 
&dA &d@    Here, color_flag is important.  &dA12/26/10&d@ and &dA01/17/11&d@ 
&dA 
        if color_flag = 0 
          ++ct_cnt 
          tput [CT,ct_cnt] Calling charout: font = ~font   loc = <~scx ,~scy >  char = ~scb
        else 
          if color_flag = 1 
            ++ct_cnt2 
            tput [CT2,ct_cnt2] Calling charout: font = ~font   loc = <~scx ,~scy >  char = ~scb
          else 
            if color_flag = 2 
              ++ct_cnt3 
              tput [CT3,ct_cnt3] Calling charout: font = ~font   loc = <~scx ,~scy >  char = ~scb
            else 
              ++ct_cnt4 
              tput [CT4,ct_cnt4] Calling charout: font = ~font   loc = <~scx ,~scy >  char = ~scb
            end 
          end 
        end 
&dA      
        ++glyph_record(font,scb) 

        if font < 13 
          scx += Mfontinc(font,scb) 
        end 
        if font > 12 and font < 26    /* Beams 
          scx += Beaminc(scb) 
        end 
        if font > 25 and font < 38    /* Ties 
          kk = Tieinc(font-25,scb) 
          scx += kk 
        end 
        if font > 37 and font < 42    /* Wedges 
          scx += Wedginc(scb) 
        end 
        if font > 50 
          perform get_xinc (scf,scb,kk) 
          scx += kk 
        end 

        font = revmap(notesize) 
        font = font - 1 * 33 
        kk = 33 + font 
         
        setb gstr,FA,scx2,scy,kk,1 
      return 
