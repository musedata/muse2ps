
&dA &d@����������������������������������������������������������������������Ŀ 
&dA &d@�P*  4. getpxpy (code,index)     &dA04-08-97&d@ added index variable         � 
&dA &d@�                                                                      � 
&dA &d@�    Purpose:  Save space; get values of px, py, pxx, pyy for          �          
&dA &d@�              position modification                                   � 
&dA &d@�                                                                      � 
&dA &d@�    Inputs:      code = type of subobject referred to                 � 
&dA &d@�                 index = index into ts array                          � 
&dA &d@�                                                                      � 
&dA &d@�    Outputs:     pcontrol                                             � 
&dA &d@�                 px                                                   � 
&dA &d@�                 py                                                   � 
&dA &d@�                 pxx  (1 = absolute, 0 = relative)                    �           
&dA &d@�                 pyy  (1 = absolute, 0 = relative)                    � 
&dA &d@�                                                                      � 
&dA &d@������������������������������������������������������������������������ 
      procedure getpxpy (code,index) 
        int t2,t3 
        int code,index 

        getvalue code,index 

        ++code                                      /* all New code &dA05/02/03
        code <<= 2 
        px = 0 
        py = 0 
        pxx = 0 
        pyy = 0                                     
        t2 = ts(index,TSR_POINT) 
        pcontrol = ors(tsr(t2){code-3}) 
        t3 = ors(tsr(t2){code-2}) 

        if bit(0,t3) = 1 
          px = ors(tsr(t2){code-1}) 
          if px > 0 
            px = px - 128 * notesize / 10 
            pxx = t3 & 0x02 >> 1 
          end 
          py = ors(tsr(t2){code}) 
          if py > 0 
            py = py - 128 * notesize / 10 
            pyy = t3 & 0x04 >> 2 
          end 
        end 
      return 
