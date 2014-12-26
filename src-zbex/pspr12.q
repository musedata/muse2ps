
&dA &d@���������������������������������������������������������������Ŀ 
&dA &d@�D* 12. get_xinc (z,kk,xinc)                                    � 
&dA &d@�                                                               � 
&dA &d@�    Purpose:  Determine the x increment to printing a glyph    � 
&dA &d@�              from a particular font.                          � 
&dA &d@�                                                               � 
&dA &d@�    Inputs:   z    = font active (not the "real" font)         � 
&dA &d@�              kk   = glyph number                              � 
&dA &d@�                                                               � 
&dA &d@�    Output:   xinc = increment                                 � 
&dA &d@�                                                               � 
&dA &d@�    Note:  This is not the code contained in pspage.z          � 
&dA &d@�           That code is precise; this code is a cluge.         � 
&dA &d@�           The difference is that for music glyphs,            � 
&dA &d@�           xinc is only an estimate.                           � 
&dA &d@����������������������������������������������������������������� 
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
