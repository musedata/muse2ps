
&dA &d@����������������������������������������������������������������Ŀ 
&dA &d@�P*  2. decodeax (t1,t2)                                         � 
&dA &d@�                                                                � 
&dA &d@�    Input: t1  = pointer into ts array                          � 
&dA &d@�           t2  = index into measax array                        � 
&dA &d@�           bit(18,ts(t1,SUBFLAG_1)) = cautionary accidental flag� 
&dA &d@�            (has effect only when no accidental would           � 
&dA &d@�             otherwise be printed)                              � 
&dA &d@�                                                                � 
&dA &d@�    Output: correct accidental in ts(.,AX)                      � 
&dA &d@�                                                                � 
&dA &d@�             0000 = no accidental                               � 
&dA &d@�             0001 = natural                                     � 
&dA &d@�             0010 = sharp                                       � 
&dA &d@�             0011 = flat                                        � 
&dA &d@�             0110 = natural sharp                               � 
&dA &d@�             0111 = natural flat                                � 
&dA &d@�             1010 = sharp sharp                                 � 
&dA &d@�             1111 = flat flat                                   � 
&dA &d@�                                                                � 
&dA &d@������������������������������������������������������������������ 
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
