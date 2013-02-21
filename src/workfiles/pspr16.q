
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 16. setunder (level)                                                 ³ 
&dA &d@³                                                                        ³ 
&dA &d@³    Purpose:  Typeset underline                                         ³ 
&dA &d@³                                                                        ³ 
&dA &d@³    Inputs: level       = level of text line (usually 1)                ³ 
&dA &d@³            uxstop(.)   = x-coordinate of end of line                   ³ 
&dA &d@³            uxstart(.)  = x-coord. of first space beyond last syllable  ³ 
&dA &d@³                            or location of first hyphon on next line    ³ 
&dA &d@³            y           = y-coordinate for text line                    ³ 
&dA &d@³            underflag   = execution flag, currently set for ties and    ³ 
&dA &d@³                            melismas                                    ³ 
&dA &d@³            xbyte(.)    = ending punctuation                            ³ 
&dA &d@³                                                                        ³ 
&dA &d@³    Internal varibles:  a,b,c,d                                         ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure setunder (level) 
        int t1,t2,t3,t4                   
        int level 

        getvalue level 

        if underflag = 0 
          return 
        end  
        x = uxstart(level) - phpar(19) 
        scx = x 
        scy = y 
        scf = mtfont 

        t1 = uxstop(level) - uxstart(level)    /*  t1 = distance over which to set hyphons
        if t1 >= phpar(18) 
          y -= pvpar(13) 
          scx = uxstart(level) 
          scy = y 
          scb = ors("_") 
          t2 = uxstop(level) - underspc(sizenum) 
          t4 = underspc(sizenum) 
          loop for t3 = uxstart(level) to t2 step t4 
            perform charout 
          repeat 
          scx = t2     
          perform charout 
          scx += 5 
          scy += pvpar(13) 
        end  
        if underflag = 1 and xbyte(level) <> "_" 
          scb = ors(xbyte(level)) 
          perform charout 
        end  

        scf = notesize 
      return 
