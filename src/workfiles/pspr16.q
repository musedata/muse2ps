
&dA &d@������������������������������������������������������������������������Ŀ 
&dA &d@�D* 16. setunder (level)                                                 � 
&dA &d@�                                                                        � 
&dA &d@�    Purpose:  Typeset underline                                         � 
&dA &d@�                                                                        � 
&dA &d@�    Inputs: level       = level of text line (usually 1)                � 
&dA &d@�            uxstop(.)   = x-coordinate of end of line                   � 
&dA &d@�            uxstart(.)  = x-coord. of first space beyond last syllable  � 
&dA &d@�                            or location of first hyphon on next line    � 
&dA &d@�            y           = y-coordinate for text line                    � 
&dA &d@�            underflag   = execution flag, currently set for ties and    � 
&dA &d@�                            melismas                                    � 
&dA &d@�            xbyte(.)    = ending punctuation                            � 
&dA &d@�                                                                        � 
&dA &d@�    Internal varibles:  a,b,c,d                                         � 
&dA &d@�������������������������������������������������������������������������� 
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
