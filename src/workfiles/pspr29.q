
&dA &d@���������������������������������������������������������������Ŀ 
&dA &d@�D* 29. barline                                                 � 
&dA &d@�                                                               � 
&dA &d@�    Purpose:  Typeset bar line                                 � 
&dA &d@�                                                               � 
&dA &d@�    Inputs:   f11 = number of parts                            � 
&dA &d@�              psq(1) = y coordinate of first part              � 
&dA &d@�              psq(f11) = y coordinate of last part             � 
&dA &d@�              x = x-coordinate of line                         � 
&dA &d@�              z = bar character                                � 
&dA &d@�              syscode = format for bar                         � 
&dA &d@�              nsz(.)  = notesizes for each staff in the system � 
&dA &d@����������������������������������������������������������������� 
      procedure barline  
        int a1,a2,a3,a4,a5   

        if z = 86                          /* Case: dotted bar line cannot connect staff lines
          loop for a1 = 1 to f11 
            y = psq(a1) 
            a4 = nsz(a1) 
            if notesize <> a4 
              notesize = a4                /* set font size for segment 
              perform ps_init_par 
            end 
            perform setmus 
          repeat 
        else 
          a2 = 0 
          loop for a1 = 1 to len(syscode) 
            if "[(" con syscode{a1} 
              a4 = 0                       /* this will become the font size for this segment
              y1 = psq(a2+1) 
            end 
            if "])" con syscode{a1} 
&dA 
&dA &d@    If a4 is not determined at this point, set it to the default 
&dA 
              if a4 = 0 
                a4 = nsz(a2)               /* font size of bottom staff in this segment
              end 
              a3 = nsz(a2)                 /* notesize of staff for this termination
              a5 = a4 - a3 * 4             /* length correction 
              if notesize <> a3 
                notesize = a3              /* set font size for computing pvpar(44)
                perform ps_init_par 
              end 
              y2 = psq(a2) + pvpar(44)       /* line thickness added &dA04-25-95
              y2 -= a5 

              if notesize <> a4 
                notesize = a4              /* set font size for segment 
                perform ps_init_par 
              end 

              perform putbar (a2)
            end 
            if ".:,;" con syscode{a1}        
              ++a2
              if mpt > 2 
                if a4 = 0 
                  a4 = nsz(a2) 
                else 
                  if nsz(a2) > a4 
                    a4 = nsz(a2) 
                  end 
                end 
              end 
            end  
          repeat 
        end  
      return 
