
&dA &d@����������������������������������������������������Ŀ 
&dA &d@�P* 23. kernttext     NEW &dA04/22/04&d@                   � 
&dA &d@�                                                    � 
&dA &d@�    Purpose:  Apply kerning to ttext                � 
&dA &d@�                                                    � 
&dA &d@�    Inputs:    ttext   = word                       � 
&dA &d@�               c5      = current font               � 
&dA &d@�                                                    � 
&dA &d@�    Outputs:   revised ttext                        � 
&dA &d@�                                                    � 
&dA &d@������������������������������������������������������ 
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
