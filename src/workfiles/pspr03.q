
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D*  3. hook                                                    ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose:  Typeset hook beam                                ³ 
&dA &d@³                                                               ³ 
&dA &d@³             x1       = horizontal position of note            ³ 
&dA &d@³             y        = vertical position of hook attachment   ³ 
&dA &d@³             stem     = stem direction                         ³ 
&dA &d@³             z        = hook character                         ³ 
&dA &d@³             beamfont = type of font for beam                  ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure hook 
        x = x1 
        if stem = 1  
          y = pvpar(2) * 500  - y - bthick  
          z += 128 
          z &= 0xff 
        else 
          x += qwid - phpar(29) 
        end  
        scf = beamfont 
        scx = x 
        scy = y 
        scb = z 
        perform charout 
        scf = notesize 
      return 
