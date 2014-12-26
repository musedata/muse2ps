
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D*  8. lineout                                                 ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose:  Send a line of text to output device             ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Inputs:  line2                                             ³ 
&dA &d@³             z = font number for words                         ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Side effects: value of z   may be changed                  ³ 
&dA &d@³                  value of scf may be changed                  ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure lineout    
        int t1,t2,t3 
        str textline.300 

AAA111: if line2 con "!" 
          t1 = mpt 
          if t1 > 1 
            if z <> notesize and z <> 1           /* z <> 1 added &dA01/13/04&d@ 
              textline = line2{1,t1-1} 
            else 
              textline = "" 
              loop for t2 = 1 to t1 - 1 
                t3 = ors(line2{t2}) 
                t3 = music_con(t3) 
                textline = textline // chr(t3) 
              repeat 
            end 
            perform stringout (textline) 

            line2 = line2{t1..} 
          end 
          if len(line2) > 1     
            if "0123456789" con line2{2} 
              z = int(line2{2..}) 
              if z = 1                       /* added &dA03/15/04&d@ 
                scf = notesize 
              else 
                scf = z 
              end 

              if sub <= len(line2) 
                line2 = line2{sub..} 
&dA 
&dA &d@       Code added &dA01/17/04&d@ to remove terminator to font designation field 
&dA 
                if line2{1} = "|" 
                  if len(line2) = 1 
                    return 
                  end 
                  line2 = line2{2..} 
                end 
&dA   
                goto AAA111 
              else 
                return 
              end 
            else 
              if z <> notesize and z <> 1         /* z <> 1 added &dA01/13/04&d@ 
                textline = "!"
              else 
                t3 = ors("!") 
                t3 = music_con(t3) 
                textline = chr(t3) 
              end 
              perform stringout (textline) 

              line2 = line2{2..} 
              goto AAA111 
            end 
          end 
        end  
        if z <> notesize and z <> 1               /* z <> 1 added &dA01/13/04&d@ &dIOK
          textline = line2 
        else 
          textline = "" 
          loop for t2 = 1 to len(line2)
            t3 = ors(line2{t2}) 
            t3 = music_con(t3) 
            textline = textline // chr(t3) 
          repeat 
        end 
        perform stringout (textline) 
      return 
