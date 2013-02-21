
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 36. ps_init_par                                                    ³ 
&dA &d@³                                                                      ³ 
&dA &d@³                                                                      ³ 
&dA &d@³    Purpose:  Initialize Vertical and Horizontal Parameters           ³ 
&dA &d@³                also expar(.) parameters                              ³ 
&dA &d@³                                                                      ³ 
&dA &d@³    Inputs:   notesize                                                ³ 
&dA &d@³                                                                      ³ 
&dA &d@³    Outputs:  pvpar(.)                                                ³ 
&dA &d@³              phpar(.)                                                ³ 
&dA &d@³              pvpar20                                                 ³ 
&dA &d@³              expar(.)                                                ³ 
&dA &d@³              revmap(.)                                               ³ 
&dA &d@³              sizenum                                                 ³ 
&dA &d@³                                                                      ³ 
&dA &d@³     Other operations: In all cases, if scf = old notesize, then      ³ 
&dA &d@³                         scf reset to new notesize                    ³ 
&dA &d@³                       In the case of PRINT, changes the active font  ³ 
&dA &d@³                         to match the new size.                       ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure ps_init_par 
        int pz                            /* added &dA03/15/04&d@ 
        int t1 
        bstr cycle.200 

        sizenum = revsizes(notesize)       /* New &dA02/19/06&d@ 
&dA 
&dA &d@    Vertical parameters 
&dA &d@    ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA 
        if notesize = 14 
          pvpar(13) = 8 
          pvpar(42) = 4 
          pvpar(43) = 240 
          pvpar(44) = 1 
        end 
        if notesize = 6 
          pvpar(13) = 3                  /* Changed from 4 to 3 &dA01/30/05&d@ 
          pvpar(42) = 2 
          pvpar(43) = 80 
          pvpar(44) = 1 
        end 
        if notesize = 21 
          pvpar(13) = 12 
          pvpar(42) = 6 
          pvpar(43) = 240 
          pvpar(44) = 3 
        end 
        if notesize = 18                /* New size-18  &dA12/18/04&d@ 
          pvpar(13) = 10 
          pvpar(42) = 5 
          pvpar(43) = 240 
          pvpar(44) = 2 
        end 
        if notesize = 16                /* New size-16  &dA12/31/08&d@ 
          pvpar(13) = 9 
          pvpar(42) = 4 
          pvpar(43) = 240 
          pvpar(44) = 1 
        end 

        loop for t1 = 1 to 10 
          pvpar(t1) = notesize * t1 / 2 
        repeat 

        pvpar(11) = 200 * notesize / 16 
        pvpar(12) = 4 * notesize / 16 

        pvpar(14) = 160 * notesize / 16 
        pvpar(15) = 64 * notesize / 16 
        pvpar(16) = 3 * notesize 
        pvpar(17) = notesize / 2 
        pvpar(18) = 30 * notesize / 16 
        pvpar(19) = 15 
        pvpar(20) = notesize + 3 / 4 
        pvpar(21) = notesize - pvpar(20) 
        pvpar(22) = 6 * notesize / 16 
        pvpar(23) = 9 * notesize / 16 
        pvpar(24) = 7 * notesize / 16 
        pvpar(25) = 22 * notesize / 16 
        pvpar(26) = 27 * notesize / 16 
        pvpar(27) = 72 * notesize / 16 
        pvpar(28) = 15 * notesize / 16 
        pvpar(29) = 38 * notesize / 16 
        pvpar(30) = 3 * notesize - 8 / 16 
        pvpar(31) = notesize / 2 + 1 
        pvpar(32) = notesize * 8 + 4 / 10 
        pvpar(33) = notesize * 12 + 10 / 14 
        pvpar(34) = notesize - 3 / 9 
        pvpar(35) = notesize / 3 
        pvpar(36) = 7 * notesize 
        pvpar(37) = 5 * notesize / 4 
        pvpar(38) = 4 * notesize / 3 
        pvpar(39) = notesize 
        pvpar(40) = 3 * notesize / 5 
        pvpar(41) = pvpar(5) 
        pvpar(45) = 2 * notesize     
        pvpar20   = notesize * 10 
&dA 
&dA &d@    Horizontal parameters 
&dA &d@    ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA 
        if notesize = 14 
          phpar(2) =   15 
          phpar(3) =   19 
          phpar(5) =   13 
          phpar(6) =   80 
          phpar(7) =   56             /* &dA01/20/05&d@ made explicit 
          phpar(12) =  80 
          phpar(17) =  14 
          phpar(19) =   4 
          phpar(20) =  20 
          phpar(29) =   2 
          phpar(30) =  17 
          phpar(33) =   6 
          phpar(34) =   7 
          phpar(43) =  40 
          phpar(48) =   8 
          phpar(58) =  30 
          phpar(60) = 254 
          phpar(61) =  20 
          phpar(62) =   2 
          phpar(63) =  90 
        end 
        if notesize = 6 
          phpar(2) =    7 
          phpar(3) =    8 
          phpar(5) =    6 
          phpar(6) =   34 
          phpar(7) =   18             /* &dA01/20/05&d@ changed from 24 to 18 and made explicit
          phpar(12) =  35 
          phpar(17) =   7 
          phpar(19) =   2 
          phpar(20) =   9 
          phpar(29) =   1 
          phpar(30) =   8 
          phpar(33) =   3 
          phpar(34) =   4 
          phpar(43) =  30 
          phpar(48) =   4 
          phpar(58) =  10 
          phpar(60) = 110 
          phpar(61) =  10 
          phpar(62) =   1 
          phpar(63) =  90 
        end 
        if notesize = 21 
          phpar(2) =   19 
          phpar(3) =   28 
          phpar(5) =   18             /* &dA12/18/04&d@ changed from 19 to 18 
          phpar(6) =  110 
          phpar(7) =   88             /* &dA01/20/05&d@ made explicit 
          phpar(12) = 100 
          phpar(17) =  21 
          phpar(19) =   6 
          phpar(20) =  30 
          phpar(29) =   3 
          phpar(30) =  22 
          phpar(33) =   8             /* &dA12/18/04&d@ changed from 9 to 8 
          phpar(34) =  11 
          phpar(43) =  30 
          phpar(48) =  13 
          phpar(58) =  30 
          phpar(60) = 381 
          phpar(61) =  30 
          phpar(62) =   3 
          phpar(63) =  80 
        end 
&dA 
&dA &d@    New &dA12/31/08&d@   notesize 16 parameters added 
&dA 
        if notesize = 16 
          phpar(2) =   16 
          phpar(3) =   22 
          phpar(5) =   15 
          phpar(6) =   90 
          phpar(7) =   64 
          phpar(12) =  80 
          phpar(17) =  16 
          phpar(19) =   4 
          phpar(20) =  23 
          phpar(29) =   2 
          phpar(30) =  18 
          phpar(33) =   6 
          phpar(34) =   9 
          phpar(43) =  30 
          phpar(48) =   9 
          phpar(58) =  30 
          phpar(60) = 280 
          phpar(61) =  22 
          phpar(62) =   2 
          phpar(63) =  80 
          ++phpar(3) 

        end 
&dA 
&dA &d@    New &dA12/18/04&d@   notesize 18 parameters added 
&dA 
        if notesize = 18 
          phpar(2) =   17 
          phpar(3) =   26 
          phpar(5) =   17 
          phpar(6) =  100 
          phpar(7) =   72             /* &dA01/20/05&d@ made explicit 
          phpar(12) =  90 
          phpar(17) =  18 
          phpar(19) =   5 
          phpar(20) =  26 
          phpar(29) =   3 
          phpar(30) =  20 
          phpar(33) =   7 
          phpar(34) =   9 
          phpar(43) =  30 
          phpar(48) =  10 
          phpar(58) =  30 
          phpar(60) = 326 
          phpar(61) =  26 
          phpar(62) =   2 
          phpar(63) =  80 
        end 

        phpar(1) = 30 
&dA &d@       phpar(2) = 18 * notesize / 16 
&dA &d@       phpar(3) = 19 * notesize + 8 / 16 
&dA &d@       phpar(4) = 3 
&dA &d@       phpar(5) = 13 * notesize + 2 / 16 
&dA &d@       phpar(6) = 80 
&dA &d@       phpar(7) = 4 * notesize             /* &dA01/20/05&d@ made explicit 
&dA &d@       phpar(8) = 200 
&dA &d@       phpar(9) = 2250 
        phpar(10) = 26 * notesize / 16 
        phpar(11) = 200 * notesize / 16 
&dA &d@       phpar(12) = 80 
        phpar(14) = 40 * notesize / 16 
        phpar(16) = 24 * notesize / 16 
&dA &d@       phpar(17) = 14 
        phpar(18) = 2 * notesize 
&dA &d@       phpar(19) = 4 
&dA &d@       phpar(20) = 20 
&dA &d@       phpar(21) = 300 
&dA &d@       phpar(22) = 6 * notesize / 16       (not used) 
&dA &d@       phpar(23) = 60 * notesize / 16      (not used) 
&dA &d@       phpar(24) = 7 * notesize + 2 / 7    (not used) 
&dA &d@       phpar(25) = notesize + 1            (not used) 
&dA &d@       phpar(26) = 15 * notesize / 16      (not used) 
&dA &d@       phpar(27) = 0                       (not used) 
&dA &d@       phpar(28) = 0 - 32 * notesize / 16  (not used) 
&dA &d@       phpar(29) = 2 * notesize + 8 / 16 
&dA &d@       phpar(30) += phpar(29) 
        phpar(31) = 24 * notesize / 16 
        phpar(32) = 44 * notesize / 16 
&dA &d@       phpar(33) = 6 * notesize / 16 
&dA &d@       phpar(34) = 8 * notesize / 16 
        phpar(35) = 14 * notesize / 16 
        phpar(36) = 8 * notesize / 16 
        phpar(37) = 20 * notesize / 16 
        phpar(38) = 20 * notesize / 16 
        phpar(39) = 50 * notesize / 16 
        phpar(40) = 15 * notesize + 4 / 16 
        phpar(41) = pvpar(5) 
        phpar(42) = notesize * 4 
&dA &d@       phpar(43) = 40 
        phpar(44) = notesize 
        phpar(45) = notesize 
        phpar(46) = 13 * notesize / 16 
        phpar(47) = 2 * notesize / 5 
&dA &d@       phpar(48) = 10 * notesize / 16 
&dA &d@       phpar(49) = 24 * notesize / 16 
&dA &d@       phpar(50) = 12 * notesize / 16 
        phpar(51) = 31 * notesize / 16 
        phpar(52) = 19 * notesize / 16 
        phpar(53) = 4 * notesize / 16 
        phpar(54) = 18 * notesize / 16 
        phpar(55) = 6 * notesize / 16 
        phpar(56) = 12 * notesize / 16 
        phpar(57) = 2 * notesize 
        phpar(59) = 3 * notesize / 5 
&dA 
&dA &d@    New &dA12/31/08&d@ parameters added for notesize 16 
&dA 
        if notesize = 16 
          phpar(42) =  56 
        end 

&dA 
&dA &d@    New &dA12/18/04&d@ parameters added for notesize 18 
&dA 
        if notesize = 18 
          phpar(11) = 225 
          phpar(39) =  50 
          phpar(42) =  67 
        end 

        if notesize = 21 
          phpar(11) = 250 
          phpar(39) =  50 
          phpar(42) =  76 
        end 
&dA 
&dA &d@    Other parameters and variables 
&dA &d@    ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA 
        if notesize = 14 
          expar(1) = 240 
          expar(2) = 324 
          expar(3) = 254 
          expar(4) = 324 
          expar(5) = 256 
          expar(6) = 324 
          expar(7) = 260 
          expar(8) = 324 
        end 
        if notesize = 6 
          expar(1) = 102 
          expar(2) = 139 
          expar(3) = 106 
          expar(4) = 146 
          expar(5) = 107 
          expar(6) = 144 
          expar(7) = 109 
          expar(8) = 148 
        end 
        if notesize = 21 
          expar(1) = 360 
          expar(2) = 486 
          expar(3) = 381 
          expar(4) = 498 
          expar(5) = 386 
          expar(6) = 486 
          expar(7) = 390 
          expar(8) = 498 
        end 
&dA 
&dA &d@   notesize 16 added &dA12/31/08 
&dA 
        if notesize = 16 
          expar(1) = 278 
          expar(2) = 362 
          expar(3) = 290 
          expar(4) = 372 
          expar(5) = 296 
          expar(6) = 368 
          expar(7) = 298 
          expar(8) = 376 
        end 
&dA 
&dA &d@   notesize 18 added &dA12/18/04 
&dA 
        if notesize = 18 
          expar(1) = 308 
          expar(2) = 424 
          expar(3) = 326 
          expar(4) = 428 
          expar(5) = 330 
          expar(6) = 422 
          expar(7) = 334 
          expar(8) = 432 
        end 

        loop for t1 = 1 to 223 
          pos(t1) = urpos(t1) * notesize 
        repeat 
&dA 
&dA &d@   Dotted mask   (modified &dA10/23/03&d@)  &dIOK&d@ 
&dA 
        if notesize = 14 
          gapsize = 5 
          cycle = dup("1",7) // dup("0",3) 
        end 
        if notesize = 6 
          gapsize = 3 
          cycle = dup("1",4) // dup("0",2) 
        end 
        if notesize = 21 
          gapsize = 12 
          cycle = dup("1",15) // dup("0",9) 
        end 
        if notesize = 16                       /* New size-16 mask &dA12/31/08&d@ &dNnot OK
          gapsize = 9 
          cycle = dup("1",11) // dup("0",7) 
        end 
        if notesize = 18                       /* New size-18 mask &dA12/18/04&d@ &dIOK
          gapsize = 10 
          cycle = dup("1",12) // dup("0",8) 
        end 

        dotted = "" 
        t1 = 2500 - (2 * gapsize) 
        loop 
          dotted = dotted // cycle 
        repeat while len(dotted) < t1 
&dA 
&dA &d@   scf can be 
&dA &d@     (1) old notesize (4 to 24)   (requires change in scf) 
&dA &d@     (2) beamfont  (101 to 114)   (independent of notesize) 
&dA &d@     (3) text font (31 to 48)     (actual font depends on notesize) 
&dA &d@     (4) 300 (ties)                             " 
&dA &d@     (5) 320 (brackets)                         " 
&dA &d@     (6) 400 (wedges)                           " 
&dA &d@     (7) 30 (variable pitch screen fonts, display only) 
&dA &d@     (8) 200 (fixed pitch screen font, display only) 
&dA 

        if scf > 0 and scf < 25 
          scf = notesize 
        end 

        pz = revsizes(notesize) 
        loop for t1 = 30 to 48 
          revmap(t1) = XFonts(pz,t1-29) 
        repeat 
                    
        revmap(200) = ors(",,,,----....////////////"{notesize})   /* former scfont()
        revmap(300) = pz + TIE_OFFSET 
        if notesize < 10 
          revmap(320) = SMALL_BRACK 
        else 
          revmap(320) = LARGE_BRACK 
        end 
        revmap(400) = ors("&&&&&&&&''''''((((()))))"{notesize})   /* former wedgefont()

      return 
