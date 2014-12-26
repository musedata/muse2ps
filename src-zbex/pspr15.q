
&dA &d@�����������������������������������������������������������������������Ŀ 
&dA &d@�D* 15. sethyph (level,syshit)                                          � 
&dA &d@�                                                                       � 
&dA &d@�    Purpose:  Typeset hyphons                                          � 
&dA &d@�                                                                       � 
&dA &d@�    Inputs: level        = level of text line (usually 1)              � 
&dA &d@�            x            = absolute coordinate of terminating syllable � 
&dA &d@�            y            = absolute coordinate text line               � 
&dA &d@�            backloc(.)   = location first space beyond last syllable   � 
&dA &d@�                            or location of first hyphon on next line   � 
&dA &d@�            syshit       = value of sysright                           � 
&dA &d@�                                                                       � 
&dA &d@�    Internal varibles:  a,b,c,d                                        � 
&dA &d@������������������������������������������������������������������������� 
      procedure sethyph (level,syshit) 
        int level,syshit 
        int t1,t2,t3,t4                        
        getvalue level,syshit 

        scy = y 
        scf = mtfont 

        t1 = x - backloc(level)              /*  t1 = distance over which to set hyphons
        t2 = 3 * phpar(6)  
        if t1 < t2 
          if t1 >= phpar(17) 
            if backloc(level) = ibackloc(level)      
              scx = backloc(level) 
              scb = ors("-") 
              perform charout 
              if t1 < phpar(6) 
                goto CM  
              end  
            end  
            t2 /= 2 
            if t1 > t2 
              t2 = t1 - phpar(17) + 3 * 2 / 5 
              t1 = t2 + backloc(level) 
              scx = t1 
              scb = ors("-") 
              perform charout 
              t1 += t2 
            else 
              t1 = t1 - phpar(17) + 3 / 2 + backloc(level) 
            end  
            scx = t1 
            scb = ors("-") 
            perform charout 
          else 
            if x = syshit       /* sysright (from i-file) replaces phpar(9) &dA12/31/08
              scx = backloc(level) 
              scb = ors("-") 
              perform charout 
              goto CM  
            end  
          end  
        else 
          if backloc(level) = ibackloc(level)     
            t2 = 2 * t1 / phpar(6) + 1  
            t3 = t1 / t2 
            backloc(level) -= t3 
            t1 += t3 
          end  
          t2 = t1 / phpar(6)  
          t3 = t1 / t2 
          --t2 
          backloc(level) += t3 / 2 
          scx = backloc(level) 
          scb = ors("-") 
          perform charout 
          loop for t4 = 1 to t2 
            backloc(level) += t3 
            scx = backloc(level) 
            scb = ors("-") 
            perform charout 
          repeat 
        end  
CM: 
        scf = notesize 
      return 
