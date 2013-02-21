
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 24. spacepar (t5)                                          ³ 
&dA &d@³                                                              ³ 
&dA &d@³    Purpose:  Be sure that proper space parameters are loaded ³ 
&dA &d@³                                                              ³ 
&dA &d@³    Inputs:    t5 = font number                               ³ 
&dA &d@³                                                              ³ 
&dA &d@³    Outputs:   valid spc(.) array for this font               ³ 
&dA &d@³               font_base, font_height, zero_height            ³ 
&dA &d@³                 for this font (new &dA02/03/08&d@)                 ³ 
&dA &d@³               valid kernmap(.,.) for this font               ³ 
&dA &d@³               updated value of curfont                       ³ 
&dA &d@³                                                              ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure spacepar (t5) 
        int t1,t2,t3,t4,t5 

        getvalue t5 

        if t5 = curfont 
          return 
        end 

&dA &d@       t5 is a font number between 51 and 140  (90 possibilities) 
&dA &d@       We want three numbers:  font_base font_height zero_height 
&dA &d@       They are permanently contained in a file called fonthite 
&dA &d@       (90 records, three numbers in a record)   This could all 
&dA &d@       be stored in a string which is 270 characters long.  
&dA &d@       We have loaded this data into a string called hitestr.270 

        sizenum = revsizes(notesize) 
        t1 = t5 - 29                        /* 1 <= t1 <= 19 
        t2 = XFonts(sizenum,t1) - 50        /* 1 <= t2 <= 90 (text font) 
        --t2 
        t2 *= 3 
        ++t2 

        font_base   = ors(hitestr{t2})   - 30 
        font_height = ors(hitestr{t2+1}) - 30 
        zero_height = ors(hitestr{t2+2}) - 30 

&dA      

        curfont = t5 

        t1  = t5 - 29                      /* 1 <= t1 <= 19 
        t2  = XFonts(sizenum,t1) - 50      /* 1 <= t2 <= 90 (text font) 
        t2  = (t2 - 1) * 200 + 1 

        loop for t3 = 1 to 31 
          spc(t3) = 0 
        repeat 
        loop for t3 = 32 to 127 
          spc(t3) = ors(fontspac{t2}) 
          ++t2 
        repeat 
        t2 += 4 
        loop for t3 = 128 to 159 
          spc(t3) = 0 
        repeat 
        loop for t3 = 160 to 255 
          spc(t3) = ors(fontspac{t2}) 
          ++t2 
        repeat 

&dA                                                                  

        t1 = t5 - 29                                        /* 1 <= t1 <= 19
        t2 = XFonts(sizenum,t1) - 50                        /* 1 <= t2 <= 90 (text font)

        if t2 < 31 
          loop for t3 = 1 to 26 
            loop for t4 = 1 to 26 
              kernmap(t3,t4) = all_real_kernmaps(t2,t3,t4) 
            repeat 
          repeat 
        else 
          loop for t3 = 1 to 26 
            loop for t4 = 1 to 26 
              kernmap(t3,t4) = 0 
            repeat 
          repeat 
        end 
&dA 
&dA &d@    Note: The higher section of kernmap(.,.) is for the moment 
&dA &d@          permanantly set to zeros (in procedure &dCload_font_stuff&d@) 
&dA 

      return 
