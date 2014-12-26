
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 12. get_xinc (z,kk,xinc)                                    ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose:  Determine the x increment to printing a glyph    ³ 
&dA &d@³              from a particular font.                          ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Inputs:   z    = font active (not the "real" font)         ³ 
&dA &d@³              kk   = glyph number                              ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Output:   xinc = increment                                 ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Note:  This is not the code contained in pspage.z          ³ 
&dA &d@³           That code is precise; this code is a cluge.         ³ 
&dA &d@³           The difference is that for music glyphs,            ³ 
&dA &d@³           xinc is only an estimate.                           ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure get_xinc (z,kk,xinc) 
        int z,kk,xinc 
        int font 
        int t1

        getvalue z,kk 

        z = revmap(z)              /*   get "real" font number 
        if z < 51                  /*   1,3,4,4,5 -> 51..80 (1..30) + 50 
          z = notesize / 4 * 5     /*   5,15,20,20,25 
          if z > 25 
            z = 25 
          end 
          z += 50 
          kk = 65                  /*   The letter "A" takes space of music note
        end 
        font = z 
        t1 = font - 50                     /* 1 <= t1 <= 90 (text font) 
        t1 = (t1 - 1) * 200 + 1 

        if kk > 128 
          t1 += 100 
          kk -= 128 
        end 
        kk -= 32 
        xinc = ors(fontspac{t1+kk}) 

        passback xinc 
      return 
