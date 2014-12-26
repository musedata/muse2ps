
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P*  2. decodeax (t1,t2)                                         ³ 
&dA &d@³                                                                ³ 
&dA &d@³    Input: t1  = pointer into ts array                          ³ 
&dA &d@³           t2  = index into measax array                        ³ 
&dA &d@³           bit(18,ts(t1,SUBFLAG_1)) = cautionary accidental flag³ 
&dA &d@³            (has effect only when no accidental would           ³ 
&dA &d@³             otherwise be printed)                              ³ 
&dA &d@³                                                                ³ 
&dA &d@³    Output: correct accidental in ts(.,AX)                      ³ 
&dA &d@³                                                                ³ 
&dA &d@³             0000 = no accidental                               ³ 
&dA &d@³             0001 = natural                                     ³ 
&dA &d@³             0010 = sharp                                       ³ 
&dA &d@³             0011 = flat                                        ³ 
&dA &d@³             0110 = natural sharp                               ³ 
&dA &d@³             0111 = natural flat                                ³ 
&dA &d@³             1010 = sharp sharp                                 ³ 
&dA &d@³             1111 = flat flat                                   ³ 
&dA &d@³                                                                ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure decodeax (t1,t2) 
        int t1,t2,t3,t4,ax 
        getvalue t1,t2   

        t3 = ts(t1,CLAVE)     
        if t3 > 99    
          ts(t1,AX) = 0 
          return 
        end
&dA 
&dA &d@   adjust accident to reflect key and measure   
&dA 
        t4 = ts(t1,AX) 
        ax = t4 

        if ax = measax(t2,t3) 
          if bit(18,ts(t1,SUBFLAG_1)) = 0 
            t4 = 0 
          else 
            if t4 = 0  
              t4 = 1        /* natural 
            end  
          end      
        else   
          if ax = 0      
            t4 = 1   
          else   
            if measax(t2,t3) > 7 
              if ax < 4      
                t4 = t4 | 4   
              end  
            end  
          end  
          measax(t2,t3) = ax 
        end  
        ts(t1,AX) = t4 
      return   
