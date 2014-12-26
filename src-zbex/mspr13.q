
&dA &d@⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø 
&dA &d@≥M* 13. procedure parameter_init                                   ≥ 
&dA &d@≥                                                                  ≥ 
&dA &d@≥    Purpose:  Initialize parameters for mskpage module            ≥ 
&dA &d@≥                                                                  ≥ 
&dA &d@¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ 
      procedure parameter_init 
        str mhparstr.23(5),mvparstr.27(5) 
        int sz,aa,bb,t1 

        aa = 0 
        bb = 0 

        mhparstr(1) = "9;%,)*(*,3*(%29&'(,'.*$" 
        mhparstr(2) = "W['712048I4.(FW)*/8->3%" 
        mhparstr(3) = "_c':3428;O70)K_*+1=0B6%" 
        mhparstr(4) = "fk(=553:>T91)Pf*,2?1E8%" 
        mhparstr(5) = "qw)A886<B\=4*Wq+.5C3K;&" 

        mvparstr(1) = ";5&.2%'%&%+->(1#'((#%M*+)&$" 
        mvparstr(2) = "[M*=2'-(*)6:b0D%+./$'Ö451+$" 
        mvparstr(3) = "cS+A2'/),*9>k2I%,01$(ì783,$" 
        mvparstr(4) = "kY,D2(0)-*;At3M%-13$)°9;5-%" 
        mvparstr(5) = "wb-J2)2*.,?FÅ6T&/45%*∂=?8/&" 

        loop for f12 = 1 to f11 
          if f(f12,14) = 0 
            tmess = 67 
            perform dtalk (tmess) 
          end 
          if f(f12,14) <> aa 
            if aa <> 0 and f(f12,14) <> 0 
              bb = 1 
            end 
            if f(f12,14) > aa 
              aa = f(f12,14) 
            end 
          end 
        repeat 

        maxnotesize = aa 
&dA 
&dA &d@    Initializing horizontal parameters 
&dA &d@         
&dA &d@      1. Fixed horizontal parameters 
&dA 
        hxpar(1) = 30 
        hxpar(2) =  0 
        if maxnotesize = 14 
          hxpar(3)  =  200 
          hxpar(4)  = 2250 
          hxpar(6)  =  175 
          hxpar(9)  =  300 
          hxpar(16) =    6 
          hxpar(17) =    7 
          hxpar(19) =   21 
          hxpar(20) =   10 
        end 
        if maxnotesize = 21 
          hxpar(3)  =  200 
          hxpar(4)  = 2250 
          hxpar(6)  =  250 
          hxpar(9)  =  300 
          hxpar(16) =    9 
          hxpar(17) =   11 
          hxpar(19) =   32 
          hxpar(20) =   16 
        end 
        if maxnotesize = 6 
          hxpar(3)  =   85 
          hxpar(4)  =  970                   /* &dA12-04-00&d@ changed from 1050 
          hxpar(6)  =   75 
          hxpar(9)  =  130 
          hxpar(16) =    3 
          hxpar(17) =    4 
          hxpar(19) =    9 
          hxpar(20) =    4 
        end 
        if maxnotesize = 18                        /* New size-18  &dA12/18/04&d@ 
          hxpar(3)  =  200 
          hxpar(4)  = 2250 
          hxpar(6)  =  225    /*    75   175   250 
          hxpar(9)  =  300    /*   130   300   300 
          hxpar(16) =    7    /*     3     6     9 
          hxpar(17) =    9    /*     4     7    11 
          hxpar(19) =   28    /*     9    21    32 
          hxpar(20) =   14    /*     4    10    16 
        end 
        if maxnotesize = 16                        /* New size-16  &dA01/01/09&d@ 
          hxpar(3)  =  200 
          hxpar(4)  = 2250 
          hxpar(6)  =  200    /*    75   175   &dC200&d@   225   250 
          hxpar(9)  =  300    /*   130   300   &dC300&d@   300   300 
          hxpar(16) =    7    /*     3     6   &dC  7&d@     7     9 
          hxpar(17) =    9    /*     4     7   &dC  9&d@     9    11 
          hxpar(19) =   26    /*     9    21   &dC 26&d@    28    32 
          hxpar(20) =   13    /*     4    10   &dC 13&d@    14    16 
        end 

        hxpar(5)  = 26 * maxnotesize / 16 
        hxpar(7)  = 24 * maxnotesize / 16 
        hxpar(10) =  6 * maxnotesize / 16 
        hxpar(11) = 20 * maxnotesize / 16 
        hxpar(12) =  4 * maxnotesize / 16 
        hxpar(13) = 18 * maxnotesize / 16 
        hxpar(14) =  5 * maxnotesize / 16 
        hxpar(15) = 60 * maxnotesize / 16 
        hxpar(18) = 14 * maxnotesize / 16 
        hxpar(21) = 31 * maxnotesize / 16 
        hxpar(22) = 19 * maxnotesize / 16 

        if f11 = 1                                 /* for parts 
          hxpar(9) /= 3 
        end 
&dA 
&dA &d@    Variable Horizontal parameters 
&dA &d@    ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ 
&dA 
        loop for f12 = 1 to f11 
          t1 = f(f12,14) + 96        /*   6, 14, 16, 18, 21    which one?  
          if "fnpru" con chr(t1)     /*   f   n   p   r   u 
            sz = mpt 
          end 
          loop for t1 = 1 to 23 
            mhpar(f12,t1) = ors(mhparstr(sz){t1}) 
            mhpar(f12,t1) -= 35 
          repeat 
        repeat 
&dA 
&dA &d@    Variable Vertical parameters 
&dA &d@    ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ 
&dA 
        loop for f12 = 1 to f11 
          notesize = f(f12,14) 
          loop for t1 = 1 to 10 
            mvpar(f12,t1) = notesize * t1 / 2 
          repeat 
          mvpar(f12,11) = 200 * notesize / 16 
          mvpar(f12,12) = 4 * notesize / 16 
          mvpar(f12,13) = 0                    /* not used, formerly 8 
          mvpar(f12,14) = 160 * notesize / 16 
          mvpar20(f12) = 10 * notesize 
        repeat 

        loop for f12 = 1 to f11 
          t1 = f(f12,14) + 96        /*   6, 14, 16, 18, 21    which one?  
          if "fnpru" con chr(t1)     /*   f   n   p   r   u 
            sz = mpt 
          end 
          loop for t1 = 15 to 41 
            mvpar(f12,t1) = ors(mvparstr(sz){t1-14}) 
            mvpar(f12,t1) -= 35 
          repeat 
        repeat 
&dA 
&dA &d@    Other parameters and variables 
&dA &d@    ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ 
&dA 
        aa = 4 
        bb = 3 

        zak(1,1) = bb 
        zak(1,2) = 0 - aa 
        zak(1,3) = bb 
        zak(1,4) = bb 
        zak(1,5) = 0 - aa 
        zak(1,6) = bb 
        zak(2,1) = 0 - bb 
        zak(2,2) = aa 
        zak(2,3) = 0 - bb 
        zak(2,4) = aa 
        zak(2,5) = 0 - bb 
        zak(2,6) = aa 

        ttext = "" 
        curfont = 0 
&dA 
&dA &d@ &dE                                        
&dA &d@ &dE  End of Initialization of parameters   
&dA &d@ &dE                                        
&dA 
      return 
