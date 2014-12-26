
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D*  7. setwords (t1)                                           ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose:  Typeset words                                    ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Inputs:  t1   = flag: 0 = regular setwords call            ³ 
&dA &d@³                          1 = setwords called from TEXT sub-obj³ 
&dA &d@³             x    = horizontal position of words               ³ 
&dA &d@³             y    = vertical position of words                 ³ 
&dA &d@³             z    = font number for words                      ³ 
&dA &d@³             line = words to set                               ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure setwords (t1) 
        str textline.300 
        int t1,t2 
        int d1 

        getvalue t1 
        if t1 = 1 and line = "&" 
          return 
        end 

        if x < 0 
          if (Debugg & 0x12) > 0 
#if DMUSE 
            putc &dAWARNING&d@:  Attempting to typeset a word with a (net) negative x position
#else 
            pute WARNING:  Attempting to typeset a word with a (net) negative x position
#endif 
          end 
          x = 0
        end 

        scx = x 
        scy = y 

        if z = 1 
          scf = notesize 
        else 
          scf = z 
        end 
        textline = line // "  " 

A11:    if textline con "\" 
          if mpt > 1   
            t2 = mpt 
            line2  = textline{1,mpt-1}   
            perform lineout 
            textline = textline{t2..} 
            goto A11 
          end  
          if textline{2} = "\" 
            line2 = "\" 
            perform lineout 
            textline = textline{3..} 
            goto A11 
          end 
&dA 
&dA &d@     This coded added &dA03/05/04&d@ to implement "in-line" space commands 
&dA 
          if "!@#$%^&*(-=" con textline{2}              
            textline = chr(130+mpt) // textline{3..} 
            goto A11 
          end 
&dA 
&dA &d@     This coded added &dA02/02/09&d@ to implement in-line "space" character 
&dA 
          if textline{2} = "+" 
            textline = " " // textline{3..} 
            goto A11 
          end 
&dA   
          if textline{2} = "0" 
            t2 = ors(textline{3}) + 128 
            if chr(t2) in [160,206,212,224] 
            else 
              line2 = chr(t2) 
              perform lineout 
            end 
            textline = textline{4..} 
            goto A11 
          end 
               
          if textline{2} in ['a'..'z','A'..'Z'] 
            d1 = ors(textline{2}) 
            if textline{3} = "1" 
              if "ANOano" con textline{2} 
                t2 = d1 + 140                                 /* 140 = wak(1)
              else 
                if textline{2} in ['A'..'Z'] 
                  t2 = 205 
                else 
                  t2 = 237 
                end 
              end 
              line2 = chr(t2) // textline{2} 
            else 
              if textline{3} = "5" 
                if textline{2} in ['A'..'Z'] 
                  t2 = 211                                    /* 211 = wak(5)(=128) + 83(S)
                else 
                  t2 = 243 
                end 
                line2 = chr(t2) // textline{2} 
              else 
                if textline{3} = "2" 
                  if "CcOos" con textline{2} 
                    if mpt < 3 
                      line2 = chr(d1+156) // textline{2}      /* 156 = wak(2)
                    else 
                      if mpt < 5 
                        line2 = chr(d1+143) // textline{2}    /* 79(O) + 143 = 222  etc.
                      else 
                        line2 = chr(244)                      /* German ss 
                      end 
                    end 
                  else 
                    line2 = textline{2} 
                  end 
                else 
                  if textline{3} = "4" 
                    if "Aa" con textline{2} 
                      line2 = chr(d1+156) // textline{2}      /* 156 = wak(4)
                    else 
                      line2 = textline{2} 
                    end 
                  else 
                    if "7893" con textline{3} 
                      t2 = mpt + 127                          /* wak(3,7,8,9)
                      if ("73" con textline{3} and "Yy" con textline{2}) or "AEIOUaeiou" con textline{2}
                        if textline{2} = "i" 
                          line2 = chr(d1+t2) // chr(238)      /* 238 = dotless i
                        else 
                          line2 = chr(d1+t2) // textline{2} 
                        end 
                      else 
                        line2 = textline{2} 
                      end 
                    else 
                      line2 = "\"              
                      perform lineout 
                      textline = textline{2..} 
                      goto A11 
                    end 
                  end 
                end 
              end 
            end 
            perform lineout 
            textline = textline{4..} 
            goto A11 
          else 
            line2 = "\" 
            perform lineout 
            textline = textline{2..} 
            goto A11 
          end 
        else 
          t2 = len(textline) - 2 
          if t2 > 0 
            line2 = textline{1,t2} 
            perform lineout 
          end 
        end    

        scf = notesize 
      return 
