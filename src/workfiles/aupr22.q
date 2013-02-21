
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 22. wordspace                                    ³ 
&dA &d@³                                                    ³ 
&dA &d@³    Purpose:  Calculate length of word              ³ 
&dA &d@³                                                    ³ 
&dA &d@³    Inputs:    ttext   = word                       ³ 
&dA &d@³                  c5   = font number                ³ 
&dA &d@³               curfont = currently active font      ³ 
&dA &d@³                                                    ³ 
&dA &d@³    Outputs:   a5 = space taken up by word          ³ 
&dA &d@³                                                    ³ 
&dA &d@³               curfont possibly modified            ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure wordspace  
        int t1,t2,d1 

        a5 = 0 
*   get new spacing parameters, if needed  
        perform spacepar (c5) 

&dA                                            
&dA 
&dA &d@    Rewriting this section &dA04/22/04&d@ 
&dA 
        loop for t2 = 1 to len(ttext) 
          if ttext{t2} = "\" 
            if t2 = len(ttext) 
              tmess = 5 
              perform dtalk (tmess) 
            end 
            if "!@#$%^&*(-=" con ttext{t2+1} 
              if mpt < 10 
                ++t2 
                a5 += mpt 
                goto NXC 
              else 
                ++t2 
                a5 -= (mpt - 9) 
                goto NXC 
              end 
            end 
&dA 
&dA &d@       New &dA02/02/09&d@ 
&dA 
            if ttext{t2+1} = "+"  
              ++t2 
              a5 += spc(32) 
              goto NXC 
            end 
&dA     
            if t2 + 1 = len(ttext) 
              tmess = 5 
              perform dtalk (tmess) 
            end 
            ++t2 
            if ttext{t2} = "0" 
              t1 = ors(ttext{t2+1}) + 128 
              if chr(t1) in [160,206,212,224] 
                tmess = 5 
                perform dtalk (tmess) 
              end 
              ++t2 
              a5 += spc(t1) 
              goto NXC 
            end 
            if ttext{t2} = "\" 
              t1 = ors(ttext{t2}) 
              a5 += spc(t1) 
              goto NXC 
            end 
            if ttext{t2} in ['a'..'z','A'..'Z'] 
              d1 = ors(ttext{t2}) 
              if "1345789" con ttext{t2+1} 
                t1 = ors(ttext{t2}) 
              else 
                if ttext{t2+1} = "2" 
                  if ttext{t2} = "s" 
                    t1 = 244                                /* German ss 
                  else 
                    t1 = ors(ttext{t2}) 
                  end 
                else 
                  tmess = 5 
                  perform dtalk (tmess) 
                end 
              end 
              ++t2 
            else 
              --t2 
              t1 = ors(ttext{t2}) 
            end 
          else 
            t1 = ors(ttext{t2})  
          end  
          a5 += spc(t1) 
NXC: 
        repeat 
&dA 
&dA &d@    End of &dA04/22/04&d@ rewrite 
&dA 
&dA                                      

      return 
