
&dA &d@���������������������������������������������������������������Ŀ 
&dA &d@�D*  3. hook                                                    � 
&dA &d@�                                                               � 
&dA &d@�    Purpose:  Typeset hook beam                                � 
&dA &d@�                                                               � 
&dA &d@�             x1       = horizontal position of note            � 
&dA &d@�             y        = vertical position of hook attachment   � 
&dA &d@�             stem     = stem direction                         � 
&dA &d@�             z        = hook character                         � 
&dA &d@�             beamfont = type of font for beam                  � 
&dA &d@����������������������������������������������������������������� 
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
