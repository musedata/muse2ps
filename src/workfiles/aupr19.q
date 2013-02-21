
&dA &d@����������������������������������������������������������������Ŀ 
&dA &d@�P* 19. cancelsig (t4,t2,t1,klave)                               � 
&dA &d@�                                                                � 
&dA &d@�    Purpose:  Write out cancellation of sharps or flats         � 
&dA &d@�                                                                � 
&dA &d@�    Inputs:   obx = object location                             � 
&dA &d@�              oby =   "       "                                 � 
&dA &d@�              x  = x starting point                             � 
&dA &d@�              t1 = number of sharps or flats to cancel          � 
&dA &d@�              t2 = one less than starting point in zak(.,.)     � 
&dA &d@�              t4 = selection   1 = sharps                       � 
&dA &d@�                               2 = flats                        � 
&dA &d@�                               3 = sharps (clef = tenor)        � 
&dA &d@�              klave = line on which to start calcellations      � 
&dA &d@�                        (from which y is computed)              � 
&dA &d@������������������������������������������������������������������ 
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
