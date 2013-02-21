
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 19. cancelsig (t4,t2,t1,klave)                               ³ 
&dA &d@³                                                                ³ 
&dA &d@³    Purpose:  Write out cancellation of sharps or flats         ³ 
&dA &d@³                                                                ³ 
&dA &d@³    Inputs:   obx = object location                             ³ 
&dA &d@³              oby =   "       "                                 ³ 
&dA &d@³              x  = x starting point                             ³ 
&dA &d@³              t1 = number of sharps or flats to cancel          ³ 
&dA &d@³              t2 = one less than starting point in zak(.,.)     ³ 
&dA &d@³              t4 = selection   1 = sharps                       ³ 
&dA &d@³                               2 = flats                        ³ 
&dA &d@³                               3 = sharps (clef = tenor)        ³ 
&dA &d@³              klave = line on which to start calcellations      ³ 
&dA &d@³                        (from which y is computed)              ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure cancelsig  (t4,t2,t1,klave) 
        int t1,t2,t3,t4 
        int klave,tenor 

        getvalue t4,t2,t1,klave 

        tenor = 0 
        if t4 = 3 
          t4 = 1 
          tenor = 1     /* exception for sharps in the tenor cler 
        end 

        z = 64 
        loop for t3 = 1 to t1 
          if tenor = 0 or klave >= 0 
            y = klave + 20 * notesize / 2 - vpar20 
          else 
            y = klave + 27 * notesize / 2 - vpar20 
          end 
          perform subj 
          ++t2 
          klave += zak(t4,t2) 
          x += hpar(11) 
        repeat 

        passback klave 
      return 
