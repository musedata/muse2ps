
&dA &d@���������������������������������������������������������������Ŀ 
&dA &d@�D*  6. setmus                                                  � 
&dA &d@�                                                               � 
&dA &d@�    Purpose:  Typeset character                                � 
&dA &d@�                                                               � 
&dA &d@�    Inputs:  x = horizontal position of note                   � 
&dA &d@�             y = vertical position of note                     � 
&dA &d@�             z = character to typeset                          � 
&dA &d@�       sizenum = current scale size (1 to 12)                  � 
&dA &d@����������������������������������������������������������������� 
      procedure setmus     
        int sy,pz 

        if z = 0 
          return  
        end 
&dA 
&dA &d@    Implementing back ties as a character   &dA04/22/08&d@ 
&dA 
        if z > 1999 
          if z < 2032                
            return 
          end 
          if z > 2090 and z < 2160 
            return 
          end 
          if z > 2218 
            return 
          end 
          z -= 2000                 /* z is now a legal single tie character

          scf = 300 
          scx = x 
          scy = y 
          scb = z          
          perform charout 
          scf = notesize 

          return 
        end 
&dA 
&dA &d@    Implementing extended music font  &dA02/19/06&d@ 
&dA 
        if z > 999 

          pz = ors("000011112222"{sizenum})     /* old "dummy()" 
          sy = y 

          z += ors(" P�� P�� P��"{sizenum})     /* old "extendoff()" 
          z -= 1001 

          scx = x 
          scy = sy 
          scb = z 
          scf = pz + 50      /* scf is index into revmap producing fonts 48,49,50
          perform charout 
          scf = notesize 

          return 
        end 
&dA 
&dA      &d@   End of &dA02/19/06&d@ addition 

        sy = y - pos(z-32) 
        scx = x 
        scy = sy 
        scb = z 
        perform charout 
      return   
