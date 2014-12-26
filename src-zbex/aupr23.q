
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 23. kernttext     NEW &dA04/22/04&d@                   ³ 
&dA &d@³                                                    ³ 
&dA &d@³    Purpose:  Apply kerning to ttext                ³ 
&dA &d@³                                                    ³ 
&dA &d@³    Inputs:    ttext   = word                       ³ 
&dA &d@³               c5      = current font               ³ 
&dA &d@³                                                    ³ 
&dA &d@³    Outputs:   revised ttext                        ³ 
&dA &d@³                                                    ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure kernttext 
        str tline.300 
        int t1,t2,t3

        if ttext = "" 
          return 
        end 

        ttext = ttext // " " 
        tline = "" 
        loop for t1 = 1 to len(ttext) 
          if "abcdefghijklmnopqrstuvwxyz" con ttext{t1} 
            t2 = mpt 
            if "abcdefghijklmnopqrstuvwxyz" con ttext{t1+1} 
              t3 = mpt 
              if kernmap(t2,t3) = 0 
                tline = tline // ttext{t1} 
              else 
                if kernmap(t2,t3) = -1 
                  tline = tline // ttext{t1} // "\-" 
                else 
                  if kernmap(t2,t3) = 1 
                    tline = tline // ttext{t1} // "\!" 
                  end 
                end 
              end 
            else 
              tline = tline // ttext{t1} 
            end 
          else 
            if "ABCDEFGHIJKLMNOPQRSTUVWXYZ" con ttext{t1} 
              t2 = mpt + 26 
              if "abcdefghijklmnopqrstuvwxyz" con ttext{t1+1} 
                t3 = mpt 
                if kernmap(t2,t3) = 0 
                  tline = tline // ttext{t1} 
                else 
                  if kernmap(t2,t3) = -1 
                    tline = tline // ttext{t1} // "\-" 
                  else 
                    if kernmap(t2,t3) = -2 
                      tline = tline // ttext{t1} // "\=" 
                    end 
                  end 
                end 
              else 
                tline = tline // ttext{t1} 
              end 
            else 
              tline = tline // ttext{t1} 
            end 
          end 
        repeat 
        t1 = len(tline) - 1 
        ttext = tline{1,t1} 
      return 
