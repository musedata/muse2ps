
&dA &d@⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø 
&dA &d@≥D*  1. my_pspage                                                ≥ 
&dA &d@≥                                                                ≥ 
&dA &d@≥    Input: from source library (at the moment)                  ≥ 
&dA &d@≥                                                                ≥ 
&dA &d@≥    Output: .ps pages to the same source library                ≥ 
&dA &d@≥                                                                ≥ 
&dA &d@¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ 
      procedure my_pspage 
        str file.280
        str temp2.400,temp3.200 
        str tline.480,ttext.480,htype.1,save_jtype.1 
        str quote.1 
        str xystring_out.100 
        str FAdata.610 
        str recon.6400 
        str Beamincstr.255 
        str Wedgincstr.255 
        str Tieincstr.50 

        int saverec,textlen 
        int buxstop(10) 
        int t1,t2,t3,t4,t5,t6,t7,t8 
        int q(12) 
        int a1,a2,a3,a4,a5,a6,a7,a8,a9 
        int c1,c2,c3,c4,c5,c6,c7,c8,c9 
        int f4,f(32,10) 
        int ps_superdata(SUPERMAX,SUPERSIZE),supermap(SUPERMAX),superpnt(SUPERMAX)
        int sysy,sysh,syslen,sysflag,sysnum,sysright 
        int ntext,tlevel 
        int govstaff 
        int savensz 
        int savesub 
        int stave_type 
        int active_font 
        int lastx,lasty 
        int top_limit 
        int bottom_limit 
        int left_limit 
        int right_limit 
        int mpgfile_start(300) 
        int sys_left_limit(300) 
        int sys_right_limit(300) 
        int sys_top_limit(300) 
        int sys_bottom_limit(300) 
        int box_left_limit(300) 
        int box_right_limit(300) 
        int box_top_limit(300) 
        int box_bottom_limit(300) 
        int beambig(5220) 
        int page_cnt 
        int ii 
&dA 
&dA &d@    &dA12/31/08&d@ Initializing the hookbackshift array         
&dA 
        hookbackshift(1)  =  7 
        hookbackshift(2)  =  8 
        hookbackshift(3)  =  8   /* for size 6 regular 
        hookbackshift(4)  = 11 
        hookbackshift(5)  = 12 
        hookbackshift(6)  = 14 
        hookbackshift(7)  = 15 
        hookbackshift(8)  = 17   /* for size 14 regular 
        hookbackshift(9)  = 18 
        hookbackshift(10) = 19   /* for size 18 regular 
        hookbackshift(11) = 21 
        hookbackshift(12) = 22   /* for size 21 regular 
        hookbackshift(13) = 24 
        hookbackshift(14) = 25 

&dA   &d@   End of &dA12/31/08&d@ addition 

        perform not_very_messy 

        notesize = 14 
        sizenum = 8
        mtfont = 31 
&dA 
&dA &d@  get shift parameters for music font 
&dA 
        line = "3/0/102.2.2.2.0/0/0.0!.0(3/0/101/1/2/2/1/0/0A"

        t5 = len(line) 
        t6 = 0 
        loop for t1 = 1 to t5 step 2 
          t2 = ors(line{t1}) - 48 
          t3 = ors(line{t1+1}) 
          loop for t4 = 1 to t3 
            ++t6 
            urpos(t6) = t2 
          repeat 
        repeat 

        perform ps_init_par 

&dA &d@     Outputs:  pvpar(.)
&dA &d@               phpar(.) 
&dA &d@               pvpar20 
&dA &d@               expar(.) 
&dA &d@               revmap(.) 
&dA &d@               sizenum 

        wak(1) = 140 
        wak(2) = 156      /* works for á. but not for Û 
        wak(3) = 131 
        wak(4) = 156 
        wak(5) = 128 
        wak(6) = 140 
        wak(7) = 128 
        wak(8) = 129 
        wak(9) = 130 
 
        quote = chr(34) 
        ttext = "" 

        loop for t3 = 1 to 255 
          music_con(t3) = t3 
        repeat 
        music_con(102) = 110            /* forte 
        music_con(109) = 109            /* mezzo 
        music_con(112) = 108            /* piano 
        music_con(114) = 113            /* r 
        music_con(115) = 111            /* s 
        music_con(122) = 112            /* z 
&dA 
&dA &d@   &dA03/04/05&d@  Need screen fonts for line length code, even when PRINTING 
&dA 
&dA &d@   Get screen fonts 
&dA 
        FAdata = "~CçCê~C´CÆ~C…CÃ~CÁCÍ~CC~C#C&~CöC"
        FAdata = FAdata // "ù~CC~CàCã~CC~C®C´~C[C^CC CÙ"
        FAdata = FAdata // " CˇCˇCˇCˇCˇCC CÙ CˇCˇCˇCˇCˇCC CÙ C"
        FAdata = FAdata // "ˇCˇCˇCˇCˇCC CÙ CˇCˇCˇCˇCˇCC CÙ CˇC"
        FAdata = FAdata // "ˇCˇCˇCˇCC9@C‰@CˇhCˇhCˇhCˇhCˇCC9@C‰@CˇhCˇhC"
        FAdata = FAdata // "ˇhCˇhCˇCC9@C‰@CˇhCˇhCˇhCˇhCˇCCA@C‡@CˇxCˇxCˇxC"
        FAdata = FAdata // "ˇxCˇC(CJ@C‹@CÓªÄCÓªÄCÓªÄCÓªÄCÓªC-CW@C÷@CˇêCˇ"
        FAdata = FAdata // "êCˇêCˇêCˇC-CW@C÷@CˇêCˇêCˇêCˇêCˇ"

        a3 = len(FAdata) 
        loop for a1 = 1 to a3 
          a2 = ors(FAdata{a1}) 
          if a2 = 67 
            a2 = 0 
          end 
          if a2 = 68 
            a2 = 10 
          end 
          if a2 = 69 
            a2 = 11 
          end 
          if a2 = 70 
            a2 = 27 
          end 
          FAdata{a1} = chr(a2) 
        repeat 

        gstr = "" 
        loop for a1 = 1 to a3 step 2 
          a2 = ors(FAdata{a1}) 
          loop for a4 = 1 to a2 
            gstr = gstr // FAdata{a1+1} 
          repeat 
        repeat 

        t4 = 1 
        loop for t3 = 1 to len(gstr) step 4 
          FA(t4) = ors(gstr{t3,4}) 
          ++t4 
        repeat 
&dA 
&dA &d@   Construct increments for beam characters 
&dA 
        Beamincstr = "22222222222222222222222222222222PPPPPPPPPPPPPPPPCCCCCCCCCCCCCCCC"
        Beamincstr = Beamincstr // "ABBBBBBBBBBBCCCC344555566666677777777788888888899999999:::;<2222"
        Beamincstr = Beamincstr // "22222222222222222222222222222222PPPPPPPPPPPPPPPPCCCCCCCCCCCCCCCC"
        Beamincstr = Beamincstr // "ABBBBBBBBBBBBBBB344555566666677777777788888888899999999:::;<222"

        loop for t3 = 1 to 255 
          Beaminc(t3) = ors(Beamincstr{t3}) - 50 
        repeat 
&dA 
&dA &d@   Construct increments for tie characters 
&dA 
        loop for t3 = 1 to 12 
          loop for t4 = 1 to 255 
            Tieinc(t3,t4) = 0 
          repeat 
        repeat 

        Tieincstr = "68:<>@BDFH4" 
        loop for t3 = 1 to 5                          /*    68:<>@BDFH4
          loop for t4 = 1 to 24                       /*                          
            Tieinc(t3,t4+90) = ors(Tieincstr{t4})     /*    91                     114
            Tieinc(t3,t4+218) = ors(Tieincstr{t4})    /*    219                    242
          repeat 
        repeat 

        Tieincstr = "|ÄÑàåêîòú†x" 
        loop for t3 = 6 to 8                          /*    |ÄÑàåêîòú†x
          loop for t4 = 1 to 24                       /*                          
            Tieinc(t3,t4+90) = ors(Tieincstr{t4})     /*    91                     114
            Tieinc(t3,t4+218) = ors(Tieincstr{t4})    /*    219                    242
          repeat 
        repeat 

        Tieincstr = "`einrw{ÄÖâéíóõ†•©Æ≤∑â" 
        loop for t4 = 1 to 44                      /* `einrw{ÄÖâéíóõ†•©Æ≤∑â
          Tieinc(9,t4+80) = ors(Tieincstr{t4})     /*                                           
          Tieinc(9,t4+208) = ors(Tieincstr{t4})    /* 81                                         124
        repeat                                     /* 209                                        252

        Tieincstr = "mrw|ÅÜãëñõ†•™∞µ∫øƒ –õ" 
        loop for t4 = 1 to 44                      /* mrw|ÅÜãëñõ†•™∞µ∫øƒ –õ
          Tieinc(10,t4+80) = ors(Tieincstr{t4})    /*                                           
          Tieinc(10,t4+208) = ors(Tieincstr{t4})   /* 81                                         124
        repeat                                     /* 209                                        252

        Tieincstr = "~Ñäêñú¢®Æ¥∫¿∆Ã“ÿﬁ‰Í¥" 
        loop for t3 = 11 to 12                     /* ~Ñäêñú¢®Æ¥∫¿∆Ã“ÿﬁ‰Í¥
          loop for t4 = 1 to 44                    /*                                           
            Tieinc(t3,t4+80) = ors(Tieincstr{t4})  /* 81                                         124
            Tieinc(t3,t4+208) = ors(Tieincstr{t4}) /* 209                                        252
          repeat 
        repeat 

        loop for t3 = 1 to 12 
          loop for t4 = 1 to 255 
            if Tieinc(t3,t4) = 6 
              Tieinc(t3,t4) = 0 
            end 
          repeat 
        repeat 
&dA 
&dA &d@   Construct increments for wedge characters 
&dA 
        Wedgincstr = "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<xdZTPMKIHGFEDCBA@?>=xdZTPMKIHGFE"
        Wedgincstr = Wedgincstr // "DCBA@?>=xZPKHFEDCBA@?>=<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
        Wedgincstr = Wedgincstr // "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<HEB?HHHHHEEEEEBBBBB?????HHHHHEEE"
        Wedgincstr = Wedgincstr // "EEBBBBB?????<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"

        loop for t3 = 1 to 255 
          Wedginc(t3) = ors(Wedgincstr{t3}) - 60 
        repeat 
&dA 
&dA &d@   &dA12/01/08&d@  Need postscript dictionary generator for POSTSCRIPT
&dA 
        open [8,8] postdict 
        len(gstr) = sze 
        read [8] gstr 
        close [8] 
                
        temp2 = chr(13) // chr(10) 
        a1 = 0 
        a2 = 1 
        loop while gstr{a2..} con temp2 
          ++a1 
          tput [XX,a1] ~gstr{a2..sub-1} 
          a2 = sub + 2 
        repeat 
&dA 
&dA &d@  get spacing parameters for hyphon and underline characters (text font) 
&dA 
        loop for a1 = 1 to 12 
          a2 = mtfont - 29                   /* 1 <= a2 <= 19 
          a3 = XFonts(a1,a2) - 50            /* 1 <= a3 <= 90 (text font) 
          a3 = (a3 - 1) * 200 + 1 

          loop for a4 = 32 to 45 
            hyphspc(a1) = ors(fontspac{a3}) 
            ++a3 
          repeat 
          loop for a4 = 46 to 95 
            underspc(a1) = ors(fontspac{a3}) 
            ++a3 
          repeat 
        repeat 
&dA 
&dA &d@  get beam generation parameters (5220 total) 
&dA 
        out = "1º2º3π4∂5∫1∂2º3ª4º5∏1æ2æ3Ω1ª2ª3º4ª1π2∫3∫4∫5∫1∏2π3π4π5π6π1π2π3º4π5∫1ª2∏3ª4π5∫1ª2∫"
        out = out // "3ª4ª5∂1∫2∫3∫4∫5π1∫2∫3π4∫5∫1π2π3π4π5π6∏1π2ª3∫4π5∫1∫2π3∫4ª5π1∫2∫3∫4∫5πQµSµVµ\µcµkµ"
        out = out // "tµy QµS–Qµ”µ÷µ€µ·µÈµÚµ¯µ{µ|»QµSµWµ]µdµlµuÀQµSµWµ]µdÕQµSµWµ]ŒQµSµVµ\µcÕQµRµTµXµ^µ"
        out = out // "gµpÀQµRµTµYµ_µhµqÀQµRµTµYµ_µhÃQµRµTµYµ_µhÃQµRµTµYµ_ÕQµRµUµZµ`ÕQµRµUµZµfµoÃQµRµUµ"
        out = out // "ZµfµoÃ0º1…0∂1œ0æ1«0ª2 0π2Ã0∏2Õ0π2Ã0ª1 0ª2 0∫2À0∫2À0π2Ã0π2Ã0∫3À0∫3À0ºQµ”µ÷µ€µ·µÈµ"
        out = out // "Úµ¯¬0∂Qµ”µ÷µ€µ·µÈµÚµ¯»0æQµ”µ÷µ€µ·µÈµÚµ¯µ{µ|æ0ªQµ”µ÷µ€µ·µÈµÚƒ0πQµ”µ÷µ€µ·µÈ«0∏Qµ”µ"
        out = out // "÷µ€µ·…0πQµ”µ÷µ€µ·»0ªQµSµWµ]«0ªQµRµTµYµ_µh≈0∫QµRµTµYµ_µh∆0∫QµRµUµZµ`µn∆0πQµRµTµYµ"
        out = out // "_»0πQµRµUµZµfµoµw∆0∫QµRµTµYµ_«0∫QµRµUµZµfµo∆0M1Ω0¬1√0ø1∆0Ω1»0æ1«0ø2∆0¡2ƒ0¿2≈0¿2≈"
        out = out // "0æ2«0¿3≈0ø2∆0¿3≈0ƒQµRµTµXµ^Ω0æQµSµVµ[µbµjµs¡0»Qµ”µ÷µ€µ·µÈµÚµ¯µ{µ0¬Qµ”µ÷µ€µ·µÈµÚµ"
        out = out // "¯º0øQµ”µ÷µ€µ·µÈ¡0ΩQµ”µ÷µ€µ·ƒ0æQµ”µ÷µ€µeµmµvµz¿0øQµRµTµXµ^µgµp¿0¡QµRµTµXµ^µgµpæ0¿"
        out = out // "QµRµTµYµ_µh¿0¿QµRµUµZµ`¡0æQµRµTµYµ_√0¿QµRµUµZµfµo¿0øQµRµUµZµfµo¡0¿QµRµUµZµfµo¿0-"
        out = out // "1¿021ª0≈1¿0¬1√0∆2ø0∆1ø0»2Ω0∆2ø0≈2¿0√2¬0∆3ø0≈3¿0∆3ø0…QµRª0≈Qµ”µ÷µ€µ·µÈµÚµ¯π02Qµ”µ"
        out = out // "÷µ€µ·µÈµÚµ0≈Qµ”µ÷µ€µ·µÈª0¬Qµ”µ÷µ€µ·ø0∆Qµ”µ÷µ€µ·ª0∆QµSµWµ]µdª0»QµRµTµYµ_µhµq∑0∆Qµ"
        out = out // "RµTµYµ_µh∫0≈QµRµUµZµ`µnª0√QµRµTµYµ_æ0∆QµRµTµYµ_ª0≈QµRµUµZµfµoµw∫0∆QµRµUµZµfµo∫0ä"
        out = out // "1∫0«1æ0À1∫0À2∫0œ2∂0Ã2π0À2∫0»2Ω0À2∫0Ã3π0Ã3π0ÀQµSµVµ[µbµjµ0ÕQµSµVµ[µ0PQµ”µ÷µ€µ·µÈµ"
        out = out // "0«Qµ”µ÷µ€µ·∫0ÀQµ”µ÷µ€µeµmµ0ÀQµRµTµYµ_µhµ0œQµRµ0ÃQµRµTµYµ_µ0ÀQµRµUµZµfµoµ0»QµRµTµ"
        out = out // "Yµ_π0ÀQµRµUµZµ`µnµ0ÃQµRµUµZµfµ0ÃQµRµUµZµfµ0®1π0©2∏0ˇQµ”µ÷µ€µ·µ0©QµRµTµYµ0V"

        t5 = 0 
        loop for t1 = 1 to len(out) step 2 
          t2 = ors(out{t1}) 
          if t2 < 80 
            t2 -= 48 
          end 
          t3 = ors(out{t1+1}) 
          if t3 >= 180 and t3 < 220 
            t3 -= 180 
          else 
            ++t3 
          end 
          loop for t4 = 1 to t3 
            ++t5 
            beambig(t5) = t2 
          repeat 
        repeat 

        t1 = 0 
        loop for t7 = 1 to 12 
          loop for t8 = 1 to 435 
            ++t1 
            beamext(t8,t7) = beambig(t1) 
          repeat 
        repeat 
&dA 
&dA &d@   Set parameters for circular slur generation 
&dA 
        slpara(1,1)  =   20.60 
        slpara(1,2)  =   27.00 
        slpara(1,3)  =   33.70 
        slpara(1,4)  =   40.70 
        slpara(1,5)  =   48.10 
        slpara(1,6)  =   55.80 
        slpara(1,7)  =   63.70 
        slpara(1,8)  =   72.40 
        slpara(1,9)  =   81.70 
        slpara(1,10) =   91.90 
        slpara(1,11) =  105.40 
        slpara(1,12) =  122.70 
        slpara(1,13) =  134.70 
        slpara(1,14) =  153.00 
        slpara(1,15) =  173.50 
        slpara(1,16) =  198.00 
        slpara(1,17) =  230.40 
        slpara(1,18) =  259.10 
        slpara(1,19) =  300.00 
        slpara(1,20) =  800.00 
* 
        slpara(2,1)  =   13.90 
        slpara(2,2)  =   19.80 
        slpara(2,3)  =   25.70 
        slpara(2,4)  =   31.80 
        slpara(2,5)  =   38.10 
        slpara(2,6)  =   44.70 
        slpara(2,7)  =   51.40 
        slpara(2,8)  =   58.40 
        slpara(2,9)  =   65.80 
        slpara(2,10) =   73.60 
        slpara(2,11) =   82.00 
        slpara(2,12) =   93.20 
        slpara(2,13) =  107.70 
        slpara(2,14) =  116.00 
        slpara(2,15) =  129.90 
        slpara(2,16) =  145.50 
        slpara(2,17) =  164.40 
        slpara(2,18) =  188.70 
        slpara(2,19) =  206.00 
        slpara(2,20) =  800.00 
        slpara(2,21) =  800.00 
        slpara(2,22) =  800.00 
* 
        slpara(3,1)  =    7.00 
        slpara(3,2)  =   13.20 
        slpara(3,3)  =   18.80 
        slpara(3,4)  =   24.40 
        slpara(3,5)  =   30.20 
        slpara(3,6)  =   36.20 
        slpara(3,7)  =   42.40 
        slpara(3,8)  =   48.80 
        slpara(3,9)  =   55.40 
        slpara(3,10) =   62.40 
        slpara(3,11) =   69.40 
        slpara(3,12) =   77.40 
        slpara(3,13) =   86.20 
        slpara(3,14) =   95.80 
        slpara(3,15) =  106.00 
        slpara(3,16) =  117.20 
        slpara(3,17) =  129.80 
        slpara(3,18) =  144.40 
        slpara(3,19) =  162.20 
        slpara(3,20) =  187.60 
        slpara(3,21) =  225.40 
        slpara(3,22) =  800.00 
        slpara(3,23) =  800.00 
        slpara(3,24) =  800.00 
        slpara(3,25) =  800.00 
        slpara(3,26) =  800.00 
        slpara(3,27) =  800.00 
        slpara(3,28) =  800.00 
* 
        slpara(4,1)  =    7.00 
        slpara(4,2)  =   10.00 
        slpara(4,3)  =   13.20 
        slpara(4,4)  =   18.80 
        slpara(4,5)  =   24.40 
        slpara(4,6)  =   30.20 
        slpara(4,7)  =   36.20 
        slpara(4,8)  =   42.40 
        slpara(4,9)  =   48.80 
        slpara(4,10) =   55.40 
        slpara(4,11) =   62.40 
        slpara(4,12) =   69.40 
        slpara(4,13) =   77.00 
        slpara(4,14) =   84.80 
        slpara(4,15) =   93.20 
        slpara(4,16) =  102.00 
        slpara(4,17) =  111.40 
        slpara(4,18) =  121.60 
        slpara(4,19) =  132.80 
        slpara(4,20) =  145.40 
        slpara(4,21) =  159.80 
        slpara(4,22) =  177.60 
        slpara(4,23) =  202.00 
        slpara(4,24) =  227.80 
        slpara(4,25) =  275.00 
        slpara(4,26) =  375.00 
        slpara(4,27) =  575.00 
        slpara(4,28) =  800.00 
        slpara(4,29) =  800.00 
        slpara(4,30) =  800.00 
        slpara(4,31) =  800.00 
        slpara(4,32) =  800.00 
* 
        slpara(5,1)  =    7.00 
        slpara(5,2)  =    7.00 
        slpara(5,3)  =   10.00 
        slpara(5,4)  =   13.20 
        slpara(5,5)  =   18.80 
        slpara(5,6)  =   24.40 
        slpara(5,7)  =   30.20 
        slpara(5,8)  =   36.20 
        slpara(5,9)  =   42.40 
        slpara(5,10) =   48.80 
        slpara(5,11) =   55.40 
        slpara(5,12) =   62.40 
        slpara(5,13) =   69.40 
        slpara(5,14) =   76.40 
        slpara(5,15) =   83.60 
        slpara(5,16) =   91.00 
        slpara(5,17) =   98.80 
        slpara(5,18) =  107.00 
        slpara(5,19) =  115.60 
        slpara(5,20) =  125.00 
        slpara(5,21) =  135.00 
        slpara(5,22) =  145.80 
        slpara(5,23) =  158.00 
        slpara(5,24) =  171.80 
        slpara(5,25) =  188.60 
        slpara(5,26) =  207.80 
        slpara(5,27) =  228.20 
        slpara(5,28) =  258.40 
        slpara(5,29) =  320.00 
        slpara(5,30) =  440.00 
        slpara(5,31) =  680.00 
        slpara(5,32) =  800.00 
        slpara(5,33) =  800.00 
        slpara(5,34) =  800.00 
        slpara(5,35) =  800.00 
        slpara(5,36) =  800.00 
* 
        slpara(6,1)  =    7.00 
        slpara(6,2)  =    7.00 
        slpara(6,3)  =    7.00 
        slpara(6,4)  =   11.00 
        slpara(6,5)  =   15.00 
        slpara(6,6)  =   18.80 
        slpara(6,7)  =   24.40 
        slpara(6,8)  =   30.20 
        slpara(6,9)  =   36.20 
        slpara(6,10) =   42.40 
        slpara(6,11) =   48.80 
        slpara(6,12) =   55.40 
        slpara(6,13) =   62.40 
        slpara(6,14) =   68.60 
        slpara(6,15) =   74.60 
        slpara(6,16) =   80.80 
        slpara(6,17) =   87.40 
        slpara(6,18) =   94.20 
        slpara(6,19) =  101.20 
        slpara(6,20) =  108.60 
        slpara(6,21) =  116.20 
        slpara(6,22) =  124.40 
        slpara(6,23) =  132.80 
        slpara(6,24) =  142.00 
        slpara(6,25) =  151.80 
        slpara(6,26) =  162.60 
        slpara(6,27) =  174.40 
        slpara(6,28) =  188.00 
        slpara(6,29) =  203.20 
        slpara(6,30) =  217.80 
        slpara(6,31) =  234.80 
        slpara(6,32) =  256.40 
        slpara(6,33) =  291.00 
        slpara(6,34) =  350.00 
        slpara(6,35) =  500.00 
        slpara(6,36) =  800.00 
        slpara(6,37) =  800.00 
        slpara(6,38) =  800.00 
        slpara(6,39) =  800.00 
        slpara(6,40) =  800.00 
        slpara(6,41) =  800.00 
* 
        slpara(7,1)  =    7.00 
        slpara(7,2)  =    7.00 
        slpara(7,3)  =    7.00 
        slpara(7,4)  =    7.00 
        slpara(7,5)  =   11.00 
        slpara(7,6)  =   18.00 
        slpara(7,7)  =   21.00 
        slpara(7,8)  =   24.40 
        slpara(7,9)  =   30.20 
        slpara(7,10) =   36.20 
        slpara(7,11) =   42.40 
        slpara(7,12) =   48.80 
        slpara(7,13) =   55.40 
        slpara(7,14) =   60.60 
        slpara(7,15) =   65.80 
        slpara(7,16) =   71.20 
        slpara(7,17) =   76.60 
        slpara(7,18) =   82.20 
        slpara(7,19) =   88.00 
        slpara(7,20) =   94.00 
        slpara(7,21) =  100.00 
        slpara(7,22) =  106.40 
        slpara(7,23) =  113.00 
        slpara(7,24) =  119.80 
        slpara(7,25) =  126.80 
        slpara(7,26) =  134.20 
        slpara(7,27) =  142.00 
        slpara(7,28) =  150.40 
        slpara(7,29) =  159.00 
        slpara(7,30) =  168.40 
        slpara(7,31) =  178.40 
        slpara(7,32) =  189.60 
        slpara(7,33) =  201.60 
        slpara(7,34) =  212.80 
        slpara(7,35) =  225.00 
        slpara(7,36) =  238.40 
        slpara(7,37) =  256.40 
        slpara(7,38) =  291.00 
        slpara(7,39) =  350.00 
        slpara(7,40) =  500.00 
        slpara(7,41) =  800.00 
        slpara(7,42) =  800.00 
        slpara(7,43) =  800.00 
        slpara(7,44) =  800.00 
        slpara(7,45) =  800.00 
        slpara(7,46) =  800.00 
* 
        slpara(8,1)  =    7.00 
        slpara(8,2)  =    7.00 
        slpara(8,3)  =    7.00 
        slpara(8,4)  =    7.00 
        slpara(8,5)  =    9.00 
        slpara(8,6)  =   16.00 
        slpara(8,7)  =   21.00 
        slpara(8,8)  =   24.00 
        slpara(8,9)  =   27.00 
        slpara(8,10) =   30.20 
        slpara(8,11) =   36.20 
        slpara(8,12) =   42.40 
        slpara(8,13) =   48.80 
        slpara(8,14) =   53.80 
        slpara(8,15) =   58.10 
        slpara(8,16) =   62.80 
        slpara(8,17) =   67.50 
        slpara(8,18) =   72.00 
        slpara(8,19) =   76.80 
        slpara(8,20) =   81.70 
        slpara(8,21) =   86.60 
        slpara(8,22) =   91.60 
        slpara(8,23) =   96.70 
        slpara(8,24) =  101.90 
        slpara(8,25) =  107.00 
        slpara(8,26) =  112.10 
        slpara(8,27) =  117.20 
        slpara(8,28) =  122.50 
        slpara(8,29) =  127.80 
        slpara(8,30) =  135.20 
        slpara(8,31) =  143.10 
        slpara(8,32) =  151.60 
        slpara(8,33) =  161.20 
        slpara(8,34) =  171.40 
        slpara(8,35) =  180.90 
        slpara(8,36) =  191.30 
        slpara(8,37) =  202.60 
        slpara(8,38) =  212.80 
        slpara(8,39) =  224.00 
        slpara(8,40) =  238.40 
        slpara(8,41) =  255.40 
        slpara(8,42) =  280.00 
        slpara(8,43) =  311.00 
        slpara(8,44) =  350.00 
        slpara(8,45) =  500.00 
        slpara(8,46) =  800.00 
        slpara(8,47) =  800.00 
        slpara(8,48) =  800.00 
        slpara(8,49) =  800.00 
        slpara(8,50) =  800.00 
&dA 
&dA &d@ &dE                                        
&dA &d@ &dE  End of Initialization of parameters   
&dA &d@ &dE                                        
&dA 
        if Source_type = 1 
          loop for ii = 1 to 1000000 
            if ii > urcnt 
              goto PEOS 
            end 
            tget [UR,ii] line 
            tput [IF,ii] ~line 
          repeat 
PEOS: 
          if_cnt = ii 
        end 

#if DMUSE 
        putc Output file?  
        getc file 
        file = trm(file) 
        outfile = file 
        line = rev(file) 
        if line{1,3} <> "sp." 
          outfile = outfile // ".ps" 
        end 
#endif 
&dA 
&dA &d@   Setup for display 
&dA 
        setup gstr,300,3100,3 

        treset [SD] 
        treset [Y] 
        treset [ST] 
        treset [CT] 
        treset [CT2]                    /* New &dA12/26/10&d@ 
        treset [CT3]                    /* New &dA01/17/11&d@ 
        treset [CT4]                    /* New &dA01/17/11&d@ 
        treset [SST] 
        treset [PD] 
        treset [PT] 
        treset [PT2] 
        treset [PT3]                    /* New &dA12/26/10&d@ 
        treset [PT4]                    /* New &dA01/17/11&d@ 
        treset [PT5]                    /* New &dA01/17/11&d@ 
        treset [ZZ] 

        ycnt    = 0 

        sd_cnt  = 0 
        st_cnt  = 0 
        ct_cnt  = 0 
        ct_cnt2 = 0                     /* New &dA12/26/10&d@ 
        ct_cnt3 = 0                     /* New &dA01/17/11&d@ 
        ct_cnt4 = 0                     /* New &dA01/17/11&d@ 
        sst_cnt = 0 

        pd_cnt  = 0 
        pt_cnt  = 0 
        pt_cnt2 = 0 
        pt_cnt3 = 0                     /* New &dA12/26/10&d@ 
        pt_cnt4 = 0                     /* New &dA01/17/11&d@ 
        pt_cnt5 = 0                     /* New &dA01/17/11&d@ 
        ppt_cnt = 0 

        active_font = 0 
&dA 
&dA &d@  Transfer source file to X table 
&dA 
        loop for t5 = 1 to 300 
          sys_right_limit(t5)  = 0 
          sys_left_limit(t5)  = 10000 
          sys_top_limit(t5)  = 10000 
          sys_bottom_limit(t5)  = 0 
          box_top_limit(t5)  = 10000 
          box_bottom_limit(t5)  = 0 
        repeat 

        page_cnt = 1 
        a5 = 0 
&dK &d@       open [1,1] file 
        treset [X] 
        mpgfile_start(1) = 1 

        loop for t5 = 1 to if_cnt 
          tget [IF,t5] line 
          line = line // "    " 
&dA     
&dA 
&dA &d@    New code &dA01/05/09&d@ to ascertain the left and right limits of a system 
&dA 
          if line{1} = "S" 
            tput [NC,1] ~line 
            tget [NC,1] .t3 a1 a1 a2 a3 a4 
            if a1 < sys_left_limit(page_cnt) 
              sys_left_limit(page_cnt) = a1 
              box_left_limit(page_cnt) = a1 
            end 
            if a2 < sys_top_limit(page_cnt) 
              sys_top_limit(page_cnt) = a2 
            end 
            if (a2 + a4) > sys_bottom_limit(page_cnt) 
              sys_bottom_limit(page_cnt) = a2 + a4 
            end 
            a3 += a1 
            if a3 > sys_right_limit(page_cnt) 
              sys_right_limit(page_cnt) = a3 
              box_right_limit(page_cnt) = a3 
            end 
            a9 = a1 
          end 
          if a5 = 1 
            if line{1,3} = "J D" 
              tput [NC,1] ~line 
              tget [NC,1] .t5 a1 a2 
              if (a9 + a2) < box_left_limit(page_cnt) 
                box_left_limit(page_cnt) = (a9 + a2) 
              end 
              a5 = 0 
            end 
            if box_left_limit(page_cnt) < 0 
              box_left_limit(page_cnt) = 0 
            end 
          end 
          if line{1} = "L" 
            a5 = 1 
          end 
&dA 
&dA     
          tput [X,t5] ~line 
          if line{1} = "P" 
            line = line // pad(4) 
            if line{3} = " " or line{1,4} = "Page"         /* this is a "page" change
              ++page_cnt 
              mpgfile_start(page_cnt) = t5 + 1 
            end 
          end 
        repeat 
        --page_cnt 

        psfile_header(1) = "%%BoundingBox: (atend)" 
        psfile_header(2) = "%%HiResBoundingBox: (atend)" 
&dA 
&dA &d@    Construct the HiResSystemBox 
&dA 
        a5 = 10000 
        a6 = 0 
        a7 = 10000 
        a8 = 0 
        loop for t5 = 1 to page_cnt 
          if sys_top_limit(t5) < a5 
            a5 = sys_top_limit(t5) 
          end 
          if sys_bottom_limit(t5) > a6 
            a6 = sys_bottom_limit(t5) 
          end 
          if sys_left_limit(t5) < a7 
            a7 = sys_left_limit(t5) 
          end 
          if sys_right_limit(t5) > a8 
            a8 = sys_right_limit(t5) 
          end 
        repeat 

        a7 -= 1 
        a5 -= 1 
        a7 += 50 
        a8 += 50 
        a5 = 3150 - a5 
        a6 = 3150 - a6 

        temp = "" 
        a1 = a7 * 24 
        a2 = a1 / 100 
        a3 = rem 
        temp = temp // chs(a2) // "." 
        if a3 < 10 
          temp = temp // "0" 
        end 
        temp = temp // chs(a3) 

        temp = temp // " " 
        a1 = a6 * 24 
        a2 = a1 / 100 
        a3 = rem 
        temp = temp // chs(a2) // "." 
        if a3 < 10 
          temp = temp // "0" 
        end 
        temp = temp // chs(a3) 

        temp = temp // " " 
        a1 = a8 * 24 
        a2 = a1 / 100 
        a3 = rem 
        temp = temp // chs(a2) // "." 
        if a3 < 10 
          temp = temp // "0" 
        end 
        temp = temp // chs(a3) 

        temp = temp // " " 
        a1 = a5 * 24 
        a2 = a1 / 100 
        a3 = rem 
        temp = temp // chs(a2) // "." 
        if a3 < 10 
          temp = temp // "0" 
        end 
        temp = temp // chs(a3)

        psfile_header(3) = "%%HiResSystemBox: " // temp 
&dA      
        psfile_header(5) = "%%Creator: muse2ps 1.0" 
&dA 
&dA &d@    Get the creation data 
&dA 
        getd temp 
        psfile_header(6) = "%%CreationDate: " // temp 
&dA      
        psfile_header(7) = "%%Orientation: Portrait" 
        psfile_header(8) = "%%Pages: " // chs(page_cnt) 
        psfile_header(9) = "%%PageOrder: Ascend" 
        psfile_header(10) = "%%DocumentPaperSizes: Letter" 

        f4 = if_cnt 
        sysnum = 0 
        rec = 1 
        f12 = 0 
        scf = notesize 
        page_cnt = 1 
TOP2: 
        if rec > f4 
          goto TASK_DONE 
        end 

        tget [X,rec] line 
        ++rec 
        line = line // pad(3) 
        if line{1} = "P" 
          if line{3} = " " or line{1,3} = "Pag"          /* this is a "page" change
            line{1,3} = "Pag" 
          end 
        end 
        if line{1,3} = "Pag" 
&dA 
&dA &d@    Step 0:  We need to compute the coordinates of the high-res 
&dA &d@               system box 
&dA 
          left_limit   = sys_left_limit(page_cnt) 
          right_limit  = sys_right_limit(page_cnt) 
          top_limit    = sys_top_limit(page_cnt) 
          bottom_limit = sys_bottom_limit(page_cnt) 

          left_limit -= 1 
          top_limit  -= 1 

          left_limit += 50 
          right_limit += 50 
          top_limit = 3150 - top_limit 
          bottom_limit = 3150 - bottom_limit 

          temp3 = "" 
          a1 = left_limit * 24 
          a2 = a1 / 100 
          a3 = rem 
          temp3 = temp3 // chs(a2) // "." 
          if a3 < 10 
            temp3 = temp3 // "0" 
          end 
          temp3 = temp3 // chs(a3) // " " 

          a1 = bottom_limit * 24 
          a2 = a1 / 100 
          a3 = rem 
          temp3 = temp3 // chs(a2) // "." 
          if a3 < 10 
            temp3 = temp3 // "0" 
          end 
          temp3 = temp3 // chs(a3) // " " 

          a1 = right_limit * 24 
          a2 = a1 / 100 
          a3 = rem 
          temp3 = temp3 // chs(a2) // "." 
          if a3 < 10 
            temp3 = temp3 // "0" 
          end 
          temp3 = temp3 // chs(a3) // " " 

          a1 = top_limit * 24 
          a2 = a1 / 100 
          a3 = rem 
          temp3 = temp3 // chs(a2) // "." 
          if a3 < 10 
            temp3 = temp3 // "0" 
          end 
          temp3 = temp3 // chs(a3)
&dA 
&dA &d@    Step 1: Put out the bounding box for this page 
&dA 
          if sys_left_limit(page_cnt) < 10000 
            left_limit = box_left_limit(page_cnt) 
            right_limit = box_right_limit(page_cnt) + notesize 
          else 
            perform hpage_limits (left_limit,right_limit) 
          end 
          perform vpage_limits (top_limit,bottom_limit) 
          if box_top_limit(page_cnt) > top_limit 
            box_top_limit(page_cnt) = top_limit 
          end 
          if box_bottom_limit(page_cnt) < bottom_limit 
            box_bottom_limit(page_cnt) = bottom_limit 
          end 
&dA 
&dA &d@       Shift and transform coordinate system based on the 
&dA &d@       notion that: 
&dA 
&dA &d@         The position of a dot in my system is actually the 
&dA &d@         position of the lower-right corner of a dot.  
&dA 
&dA &d@       and that: 
&dA 
&dA &d@         (0,0) -> (12,756) which in dots is (50,3150) 
&dA 
&dA &d@       and that:  the top/bottom system is reversed 
&dA 
          left_limit -= 1 
          top_limit  -= 2 

          left_limit += 50 
          right_limit += 50 
          top_limit = 3150 - top_limit 
          bottom_limit = 3150 - bottom_limit 
&dA 
&dA &d@       Convert dots to points, using 300 dpi 
&dA &d@       Format = llx lly ulx uly 
&dA 
          temp = "" 
          temp2 = "" 
          a1 = left_limit * 24 
          a2 = a1 / 100 
          a3 = rem 
          if rem < 50 
            temp2 = temp2 // chs(a2) // " " 
          else 
            temp2 = temp2 // chs(a2+1) // " " 
          end 
          temp = temp // chs(a2) // "." 
          if a3 < 10 
            temp = temp // "0" 
          end 
          temp = temp // chs(a3) // " " 

          a1 = bottom_limit * 24 
          a2 = a1 / 100 
          a3 = rem 
          if rem < 50 
            temp2 = temp2 // chs(a2) // " " 
          else 
            temp2 = temp2 // chs(a2+1) // " " 
          end 
          temp = temp // chs(a2) // "." 
          if a3 < 10 
            temp = temp // "0" 
          end 
          temp = temp // chs(a3) // " " 

          a1 = right_limit * 24 
          a2 = a1 / 100 
          a3 = rem 
          if rem < 50 
            temp2 = temp2 // chs(a2) // " " 
          else 
            temp2 = temp2 // chs(a2+1) // " " 
          end 
          temp = temp // chs(a2) // "." 
          if a3 < 10 
            temp = temp // "0" 
          end 
          temp = temp // chs(a3) // " " 

          a1 = top_limit * 24 
          a2 = a1 / 100 
          a3 = rem 
          if rem < 50 
            temp2 = temp2 // chs(a2)
          else 
            temp2 = temp2 // chs(a2+1)
          end 
          temp = temp // chs(a2) // "." 
          if a3 < 10 
            temp = temp // "0" 
          end 
          temp = temp // chs(a3)

          ++ppt_cnt 
          tput [PPT,ppt_cnt] %%Page ~page_cnt  ~page_cnt 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] %%BeginPageSetup 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] %%PageBoundingBox: ~temp2 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] %%PageHiResBoundingBox: ~temp 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] %%PageHiResSystemBox: ~temp3 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] %%EndPageSetup 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % 
&dA 
&dA &d@    Step 2: Generate the PT table from the CT table 
&dA &d@            Generate the PT3 table from the CT2 table 
&dA 
          xystring_out = "" 
          ycnt = 0 
          pt_cnt = 0 

          loop for t3 = 1 to ct_cnt 
            tget [CT,t3] out 
&dA &d@            
&dA &d@      Loop for special case of beginning of staff lines 
&dA 
            a1 = 0 
            a2 = len(out) 
            if out{a2-2,3} = " 81" 
              if active_font < 1013    /* music font 
                a3 = len(xystring_out) 
                if a3 > 0 
                  if xystring_out{a3} <> "Q" 
                    a1 = 1             /* new staff lines 
                  end 
                end 
              end 
            end 

            if out con "charout" 
              temp = out{25..} 
              tput [Y,1] ~temp 
              tget [Y,1] t5 
              t5 += 1000 
              if t5 <> active_font or len(xystring_out) > 60 or a1 = 1 
                if len(xystring_out) > 0 
                  xystring_out = xystring_out // ")" 
                  ++pt_cnt 
                  tput [PT,pt_cnt] ~xystring_out 
                  loop for t4 = 2 to ycnt - 1 
                    tget [Y,t4] temp 
                    ++pt_cnt 
                    tput [PT,pt_cnt] ~temp 
                  repeat 
                  tget [Y,ycnt] temp 
                  temp = temp // " 0 0 ] xyshow" 
                  ++pt_cnt 
                  tput [PT,pt_cnt] ~temp 
                  ycnt = 0 
                  xystring_out = "" 
                end 

                if t5 <> active_font 
                  active_font = t5 
                  ++pt_cnt 
                  tput [PT,pt_cnt] /Bitfont~t5  findfont 24 scalefont setfont
                end 

                if out con "loc =" 
                  t1 = mpt 
                  temp = out{t1+7..} 
                end 
                tput [Y,1] ~temp 
                tget [Y,1] t1 t5 
                lastx = t1 
                lasty = t5 

                perform move_to_loc (t1,t5) 
                ++pt_cnt 
                tput [PT,pt_cnt] ~mtloc 

                if t3 = ct_cnt 
                  if out con "char =" 
                    t1 = mpt 
                    temp = out{t1+7..} 
                    t5 = int(temp) 
                    temp = oct(t5) 
                    ++pt_cnt 
                    tput [PT,pt_cnt] (\~temp ) show 
                  end 
                  goto CMP_DONE 
                else 
                  tget [CT,t3+1] temp 
                  if temp con "charout" 
                    temp = temp{25..} 
                    tput [Y,1] ~temp 
                    tget [Y,1] t5 
                    t5 += 1000 
                    if t5 <> active_font 
                      if out con "char =" 
                        t1 = mpt 
                        temp = out{t1+7..} 
                        t5 = int(temp) 
                        temp = oct(t5) 
                        ++pt_cnt 
                        tput [PT,pt_cnt] (\~temp ) show 
                      end 
                      goto NXT_CHAR 
                    end 
                  end 
                end 
&dA 
&dA &d@          At this point, you have called for a new font and/or 
&dA &d@          you are restarting the xystring_out and 
&dA &d@          there is more than one character in this new font.  
&dA &d@          Time to setup the xyshow macro.  
&dA 
                if out con "char =" 
                  t1 = mpt 
                  temp = out{t1+7..} 
                  t5 = int(temp) 
                  if t5 > 31 and t5 < 127 and t5 <> 40 and t5 <> 41 and t5 <> 92
                    xystring_out = "(" // chr(t5) 
                  else 
                    temp = oct(t5) 
                    if len(temp) < 3 
                      temp = "0" // oct(t5) 
                    end 
                    xystring_out = "(\" // temp 
                  end 
                  ycnt = 2 
                  temp = "[ " 
                  tput [Y,ycnt] ~temp 
                end 
&dA 
&dA &d@          Otherwise, you are adding to the xyshow macro 
&dA 
              else 
                if out con "loc =" 
                  t1 = mpt 
                  temp = out{t1+7..} 
                end 
                tput [Y,1] ~temp 
                tget [Y,1] t1 t5 

                perform compute_delta_move (lastx, lasty, t1, t5) 

                lastx = t1 
                lasty = t5 

                if out con "char =" 
                  t1 = mpt 
                  temp = out{t1+7..} 
                  t5 = int(temp) 
                  if t5 > 31 and t5 < 127 and t5 <> 40 and t5 <> 41 and t5 <> 92
                    xystring_out = xystring_out // chr(t5) 
                  else 
                    temp = oct(t5) 
                    if len(temp) < 3 
                      temp = "0" // oct(t5) 
                    end 
                    xystring_out = xystring_out // "\" // temp 
                  end 
                end 
                tget [Y,ycnt] temp 
                temp = temp // " " // mtloc 
                tput [Y,ycnt] ~temp 
                if len(temp) > 60 
                  ++ycnt 
                  temp = "  " 
                  tput [Y,ycnt] ~temp 
                end 

                if t3 = ct_cnt 
                  if len(xystring_out) > 0 
                    xystring_out = xystring_out // ")" 
                    ++pt_cnt 
                    tput [PT,pt_cnt] ~xystring_out 

                    loop for t4 = 2 to ycnt - 1 
                      tget [Y,t4] temp 
                      ++pt_cnt 
                      tput [PT,pt_cnt] ~temp 
                    repeat 
                    tget [Y,ycnt] temp 
                    temp = temp // " 0 0 ] xyshow" 
                    ++pt_cnt 
                    tput [PT,pt_cnt] ~temp 
                    ycnt = 0 
                    xystring_out = "" 
                  end 
                end 
              end 
            end 
NXT_CHAR: 
          repeat 

CMP_DONE: 

&dA                                                
&dA 
&dA &d@    Here is where we deal with RED color (&dA12/26/10&d@) 
&dA 
          xystring_out = "" 
          ycnt = 0 
          pt_cnt3 = 0 
          active_font = 0 

          loop for t3 = 1 to ct_cnt2 
            tget [CT2,t3] out 
&dA &d@            
&dA &d@      Loop for special case of beginning of staff lines 
&dA 
            a1 = 0 
            if out con "charout" 
              temp = out{25..} 
              tput [Y,1] ~temp 
              tget [Y,1] t5 
              t5 += 1000 
              if t5 <> active_font or len(xystring_out) > 60 or a1 = 1 
                if len(xystring_out) > 0 
                  xystring_out = xystring_out // ")" 
                  ++pt_cnt3 
                  tput [PT3,pt_cnt3] ~xystring_out 
                  loop for t4 = 2 to ycnt - 1 
                    tget [Y,t4] temp 
                    ++pt_cnt3 
                    tput [PT3,pt_cnt3] ~temp 
                  repeat 
                  tget [Y,ycnt] temp 
                  temp = temp // " 0 0 ] xyshow" 
                  ++pt_cnt3 
                  tput [PT3,pt_cnt3] ~temp 
                  ycnt = 0 
                  xystring_out = "" 
                end 

                if t5 <> active_font 
                  active_font = t5 
                  ++pt_cnt3 
                  tput [PT3,pt_cnt3] /Bitfont~t5  findfont 24 scalefont setfont
                end 

                if out con "loc =" 
                  t1 = mpt 
                  temp = out{t1+7..} 
                end 
                tput [Y,1] ~temp 
                tget [Y,1] t1 t5 
                lastx = t1 
                lasty = t5 

                perform move_to_loc (t1,t5) 
                ++pt_cnt3 
                tput [PT3,pt_cnt3] ~mtloc 

                if t3 = ct_cnt2 
                  if out con "char =" 
                    t1 = mpt 
                    temp = out{t1+7..} 
                    t5 = int(temp) 
                    temp = oct(t5) 
                    ++pt_cnt3 
                    tput [PT3,pt_cnt3] (\~temp ) show 
                  end 
                  goto CMP_DONE2 
                else 
                  tget [CT2,t3+1] temp 
                  if temp con "charout" 
                    temp = temp{25..} 
                    tput [Y,1] ~temp 
                    tget [Y,1] t5 
                    t5 += 1000 
                    if t5 <> active_font 
                      if out con "char =" 
                        t1 = mpt 
                        temp = out{t1+7..} 
                        t5 = int(temp) 
                        temp = oct(t5) 
                        ++pt_cnt3 
                        tput [PT3,pt_cnt3] (\~temp ) show 
                      end 
                      goto NXT_CHAR2 
                    end 
                  end 
                end 
&dA 
&dA &d@          At this point, you have called for a new font and/or 
&dA &d@          you are restarting the xystring_out and 
&dA &d@          there is more than one character in this new font.  
&dA &d@          Time to setup the xyshow macro.  
&dA 
                if out con "char =" 
                  t1 = mpt 
                  temp = out{t1+7..} 
                  t5 = int(temp) 
                  if t5 > 31 and t5 < 127 and t5 <> 40 and t5 <> 41 and t5 <> 92
                    xystring_out = "(" // chr(t5) 
                  else 
                    temp = oct(t5) 
                    if len(temp) < 3 
                      temp = "0" // oct(t5) 
                    end 
                    xystring_out = "(\" // temp 
                  end 
                  ycnt = 2 
                  temp = "[ " 
                  tput [Y,ycnt] ~temp 
                end 
&dA 
&dA &d@          Otherwise, you are adding to the xyshow macro 
&dA 
              else 
                if out con "loc =" 
                  t1 = mpt 
                  temp = out{t1+7..} 
                end 
                tput [Y,1] ~temp 
                tget [Y,1] t1 t5 

                perform compute_delta_move (lastx, lasty, t1, t5) 

                lastx = t1 
                lasty = t5 

                if out con "char =" 
                  t1 = mpt 
                  temp = out{t1+7..} 
                  t5 = int(temp) 
                  if t5 > 31 and t5 < 127 and t5 <> 40 and t5 <> 41 and t5 <> 92
                    xystring_out = xystring_out // chr(t5) 
                  else 
                    temp = oct(t5) 
                    if len(temp) < 3 
                      temp = "0" // oct(t5) 
                    end 
                    xystring_out = xystring_out // "\" // temp 
                  end 
                end 
                tget [Y,ycnt] temp 
                temp = temp // " " // mtloc 
                tput [Y,ycnt] ~temp 
                if len(temp) > 60 
                  ++ycnt 
                  temp = "  " 
                  tput [Y,ycnt] ~temp 
                end 

                if t3 = ct_cnt2 
                  if len(xystring_out) > 0 
                    xystring_out = xystring_out // ")" 
                    ++pt_cnt3 
                    tput [PT3,pt_cnt3] ~xystring_out 

                    loop for t4 = 2 to ycnt - 1 
                      tget [Y,t4] temp 
                      ++pt_cnt3 
                      tput [PT3,pt_cnt3] ~temp 
                    repeat 
                    tget [Y,ycnt] temp 
                    temp = temp // " 0 0 ] xyshow" 
                    ++pt_cnt3 
                    tput [PT3,pt_cnt3] ~temp 
                    ycnt = 0 
                    xystring_out = "" 
                  end 
                end 
              end 
            end 
NXT_CHAR2: 
          repeat 

&dA &d@    End of RED color &dA12/26/10&d@ 
&dA                                                

CMP_DONE2: 

&dI                                                
&dI 
&dI &d@    Here is where we deal with GREEN color (&dA01/17/11&d@) 
&dI 
          xystring_out = "" 
          ycnt = 0 
          pt_cnt4 = 0 
          active_font = 0 

          loop for t3 = 1 to ct_cnt3 
            tget [CT3,t3] out 
&dA &d@            
&dA &d@      Loop for special case of beginning of staff lines 
&dA 
            a1 = 0 
            if out con "charout" 
              temp = out{25..} 
              tput [Y,1] ~temp 
              tget [Y,1] t5 
              t5 += 1000 
              if t5 <> active_font or len(xystring_out) > 60 or a1 = 1 
                if len(xystring_out) > 0 
                  xystring_out = xystring_out // ")" 
                  ++pt_cnt4 
                  tput [PT4,pt_cnt4] ~xystring_out 
                  loop for t4 = 2 to ycnt - 1 
                    tget [Y,t4] temp 
                    ++pt_cnt4 
                    tput [PT4,pt_cnt4] ~temp 
                  repeat 
                  tget [Y,ycnt] temp 
                  temp = temp // " 0 0 ] xyshow" 
                  ++pt_cnt4 
                  tput [PT4,pt_cnt4] ~temp 
                  ycnt = 0 
                  xystring_out = "" 
                end 

                if t5 <> active_font 
                  active_font = t5 
                  ++pt_cnt4 
                  tput [PT4,pt_cnt4] /Bitfont~t5  findfont 24 scalefont setfont
                end 

                if out con "loc =" 
                  t1 = mpt 
                  temp = out{t1+7..} 
                end 
                tput [Y,1] ~temp 
                tget [Y,1] t1 t5 
                lastx = t1 
                lasty = t5 

                perform move_to_loc (t1,t5) 
                ++pt_cnt4 
                tput [PT4,pt_cnt4] ~mtloc 

                if t3 = ct_cnt3 
                  if out con "char =" 
                    t1 = mpt 
                    temp = out{t1+7..} 
                    t5 = int(temp) 
                    temp = oct(t5) 
                    ++pt_cnt4 
                    tput [PT4,pt_cnt4] (\~temp ) show 
                  end 
                  goto CMP_DONE3 
                else 
                  tget [CT3,t3+1] temp 
                  if temp con "charout" 
                    temp = temp{25..} 
                    tput [Y,1] ~temp 
                    tget [Y,1] t5 
                    t5 += 1000 
                    if t5 <> active_font 
                      if out con "char =" 
                        t1 = mpt 
                        temp = out{t1+7..} 
                        t5 = int(temp) 
                        temp = oct(t5) 
                        ++pt_cnt4 
                        tput [PT4,pt_cnt4] (\~temp ) show 
                      end 
                      goto NXT_CHAR3 
                    end 
                  end 
                end 
&dA 
&dA &d@          At this point, you have called for a new font and/or 
&dA &d@          you are restarting the xystring_out and 
&dA &d@          there is more than one character in this new font.  
&dA &d@          Time to setup the xyshow macro.  
&dA 
                if out con "char =" 
                  t1 = mpt 
                  temp = out{t1+7..} 
                  t5 = int(temp) 
                  if t5 > 31 and t5 < 127 and t5 <> 40 and t5 <> 41 and t5 <> 92
                    xystring_out = "(" // chr(t5) 
                  else 
                    temp = oct(t5) 
                    if len(temp) < 3 
                      temp = "0" // oct(t5) 
                    end 
                    xystring_out = "(\" // temp 
                  end 
                  ycnt = 2 
                  temp = "[ " 
                  tput [Y,ycnt] ~temp 
                end 
&dA 
&dA &d@          Otherwise, you are adding to the xyshow macro 
&dA 
              else 
                if out con "loc =" 
                  t1 = mpt 
                  temp = out{t1+7..} 
                end 
                tput [Y,1] ~temp 
                tget [Y,1] t1 t5 

                perform compute_delta_move (lastx, lasty, t1, t5) 

                lastx = t1 
                lasty = t5 

                if out con "char =" 
                  t1 = mpt 
                  temp = out{t1+7..} 
                  t5 = int(temp) 
                  if t5 > 31 and t5 < 127 and t5 <> 40 and t5 <> 41 and t5 <> 92
                    xystring_out = xystring_out // chr(t5) 
                  else 
                    temp = oct(t5) 
                    if len(temp) < 3 
                      temp = "0" // oct(t5) 
                    end 
                    xystring_out = xystring_out // "\" // temp 
                  end 
                end 
                tget [Y,ycnt] temp 
                temp = temp // " " // mtloc 
                tput [Y,ycnt] ~temp 
                if len(temp) > 60 
                  ++ycnt 
                  temp = "  " 
                  tput [Y,ycnt] ~temp 
                end 

                if t3 = ct_cnt3 
                  if len(xystring_out) > 0 
                    xystring_out = xystring_out // ")" 
                    ++pt_cnt4 
                    tput [PT4,pt_cnt4] ~xystring_out 

                    loop for t4 = 2 to ycnt - 1 
                      tget [Y,t4] temp 
                      ++pt_cnt4 
                      tput [PT4,pt_cnt4] ~temp 
                    repeat 
                    tget [Y,ycnt] temp 
                    temp = temp // " 0 0 ] xyshow" 
                    ++pt_cnt4 
                    tput [PT4,pt_cnt4] ~temp 
                    ycnt = 0 
                    xystring_out = "" 
                  end 
                end 
              end 
            end 
NXT_CHAR3: 
          repeat 

&dI &d@    End of GREEN color (&dA01/17/11&d@) 
&dI                                                

CMP_DONE3: 

&dL                                                
&dL 
&dL &d@    Here is where we deal with BLUE color (&dA01/17/11&d@) 
&dL 
          xystring_out = "" 
          ycnt = 0 
          pt_cnt5 = 0 
          active_font = 0 

          loop for t3 = 1 to ct_cnt4 
            tget [CT4,t3] out 
&dA &d@            
&dA &d@      Loop for special case of beginning of staff lines 
&dA 
            a1 = 0 
            if out con "charout" 
              temp = out{25..} 
              tput [Y,1] ~temp 
              tget [Y,1] t5 
              t5 += 1000 
              if t5 <> active_font or len(xystring_out) > 60 or a1 = 1 
                if len(xystring_out) > 0 
                  xystring_out = xystring_out // ")" 
                  ++pt_cnt5 
                  tput [PT5,pt_cnt5] ~xystring_out 
                  loop for t4 = 2 to ycnt - 1 
                    tget [Y,t4] temp 
                    ++pt_cnt5 
                    tput [PT5,pt_cnt5] ~temp 
                  repeat 
                  tget [Y,ycnt] temp 
                  temp = temp // " 0 0 ] xyshow" 
                  ++pt_cnt5 
                  tput [PT5,pt_cnt5] ~temp 
                  ycnt = 0 
                  xystring_out = "" 
                end 

                if t5 <> active_font 
                  active_font = t5 
                  ++pt_cnt5 
                  tput [PT5,pt_cnt5] /Bitfont~t5  findfont 24 scalefont setfont
                end 

                if out con "loc =" 
                  t1 = mpt 
                  temp = out{t1+7..} 
                end 
                tput [Y,1] ~temp 
                tget [Y,1] t1 t5 
                lastx = t1 
                lasty = t5 

                perform move_to_loc (t1,t5) 
                ++pt_cnt5 
                tput [PT5,pt_cnt5] ~mtloc 

                if t3 = ct_cnt4 
                  if out con "char =" 
                    t1 = mpt 
                    temp = out{t1+7..} 
                    t5 = int(temp) 
                    temp = oct(t5) 
                    ++pt_cnt5 
                    tput [PT5,pt_cnt5] (\~temp ) show 
                  end 
                  goto CMP_DONE4 
                else 
                  tget [CT4,t3+1] temp 
                  if temp con "charout" 
                    temp = temp{25..} 
                    tput [Y,1] ~temp 
                    tget [Y,1] t5 
                    t5 += 1000 
                    if t5 <> active_font 
                      if out con "char =" 
                        t1 = mpt 
                        temp = out{t1+7..} 
                        t5 = int(temp) 
                        temp = oct(t5) 
                        ++pt_cnt5 
                        tput [PT5,pt_cnt5] (\~temp ) show 
                      end 
                      goto NXT_CHAR4 
                    end 
                  end 
                end 
&dA 
&dA &d@          At this point, you have called for a new font and/or 
&dA &d@          you are restarting the xystring_out and 
&dA &d@          there is more than one character in this new font.  
&dA &d@          Time to setup the xyshow macro.  
&dA 
                if out con "char =" 
                  t1 = mpt 
                  temp = out{t1+7..} 
                  t5 = int(temp) 
                  if t5 > 31 and t5 < 127 and t5 <> 40 and t5 <> 41 and t5 <> 92
                    xystring_out = "(" // chr(t5) 
                  else 
                    temp = oct(t5) 
                    if len(temp) < 3 
                      temp = "0" // oct(t5) 
                    end 
                    xystring_out = "(\" // temp 
                  end 
                  ycnt = 2 
                  temp = "[ " 
                  tput [Y,ycnt] ~temp 
                end 
&dA 
&dA &d@          Otherwise, you are adding to the xyshow macro 
&dA 
              else 
                if out con "loc =" 
                  t1 = mpt 
                  temp = out{t1+7..} 
                end 
                tput [Y,1] ~temp 
                tget [Y,1] t1 t5 

                perform compute_delta_move (lastx, lasty, t1, t5) 

                lastx = t1 
                lasty = t5 

                if out con "char =" 
                  t1 = mpt 
                  temp = out{t1+7..} 
                  t5 = int(temp) 
                  if t5 > 31 and t5 < 127 and t5 <> 40 and t5 <> 41 and t5 <> 92
                    xystring_out = xystring_out // chr(t5) 
                  else 
                    temp = oct(t5) 
                    if len(temp) < 3 
                      temp = "0" // oct(t5) 
                    end 
                    xystring_out = xystring_out // "\" // temp 
                  end 
                end 
                tget [Y,ycnt] temp 
                temp = temp // " " // mtloc 
                tput [Y,ycnt] ~temp 
                if len(temp) > 60 
                  ++ycnt 
                  temp = "  " 
                  tput [Y,ycnt] ~temp 
                end 

                if t3 = ct_cnt4 
                  if len(xystring_out) > 0 
                    xystring_out = xystring_out // ")" 
                    ++pt_cnt5 
                    tput [PT5,pt_cnt5] ~xystring_out 

                    loop for t4 = 2 to ycnt - 1 
                      tget [Y,t4] temp 
                      ++pt_cnt5 
                      tput [PT5,pt_cnt5] ~temp 
                    repeat 
                    tget [Y,ycnt] temp 
                    temp = temp // " 0 0 ] xyshow" 
                    ++pt_cnt5 
                    tput [PT5,pt_cnt5] ~temp 
                    ycnt = 0 
                    xystring_out = "" 
                  end 
                end 
              end 
            end 
NXT_CHAR4: 
          repeat 

&dL &d@    End of BLUE color (&dA01/17/11&d@) 
&dL                                                

CMP_DONE4: 

&dE                                                                          
&dE                                                                          

&dA 
&dA &d@    Step 3: Add the regular slur dictionaries to the SD table 
&dA &d@              and generate the PT2 table 
&dA 
          pt_cnt2 = 0 
          t6 = 0 
          a1 = 0 
          a4 = 0                /* stores maximum height 
          a5 = 0                /* stores maximum width 
          loop for t3 = 1 to st_cnt 
            tget [ST,t3] out 
            out = trm(out) 
            if out con "Calling" 
              a6 = 0            /* height counter 
              ++t6 
              if t6 = 193 
                a1 = t3 - 1      /* last ":" in regular dictionary 
                t3 = st_cnt      /* exit loop 
              end 
            else 
              if out{1} <> ":" 
                ++a6            /* increment height 
                a7 = len(out) 
                if a7 > a5 
                  a5 = a7       /* new maximum width 
                end 
              else 
                if a6 = 0       /* this is the first ":" 
                else 
                  if a6 > a4 
                    a4 = a6     /* new maximum height 
                  end 
                  a6 = 0        /* redundant, but safe 
                end 
              end 
            end 
          repeat 

          if a1 = 0 
            a1 = st_cnt 
          else 
            t6 = 192 
          end 
&dA 
&dA &d@      The meaning of a1 is as follows: 
&dA &d@         Normally (almost always) the number of regular slurs on a 
&dA &d@         page will not exceed 192.  In this case, a1 = st_cnt, and 
&dA &d@         all regular slurs will fit into one dictionary.  
&dA &d@         When a1 < st_cnt, this means that there are regular slurs 
&dA &d@         which did not fit into the primary slur dictionary and 
&dA &d@         will need to be included in subsequent dictionaries.  
&dA &d@      The meaning of t6: 
&dA &d@         t6 is the number of slurs in the primary slur dictionary 
&dA 
          a2 = 1 
          a3 = 1 

          if a1 > 0 
            perform build_regular_slur_dict (t6, a2, a1, a4, a5, a3, page_cnt)
          end 
&dA 
&dA &d@      For the moment, this code assumes a maximum of two regular 
&dA &d@        slur dictionaries, and will fail otherwise.  
&dA 
          if a1 < st_cnt 
            t6 = 0 
            a2 = a1 + 1              /* next entry 
            a1 = 0 
            a4 = 0                /* stores maximum height 
            a5 = 0                /* stores maximum width 
            loop for t3 = a2 to st_cnt 
              tget [ST,t3] out 
              if out con "Calling" 
                a6 = 0            /* height counter 
                ++t6 
                if t6 = 193 
                  if (Debugg & 0x12) > 0 
                    pute For the moment, this code assumes a maximum of 
                    pute two regular slur dictionaries.  No provision is 
                    pute made for overflow; extra slurs will be discarded.  
                  end 
                  a1 = t3 - 1      /* last ":" in regular dictionary 
                  t6 = 192 
                  t3 = st_cnt      /* exit loop 
                end 
              else 
                if out{1} <> ":" 
                  ++a6            /* increment height 
                  a7 = len(out) 
                  if a7 > a5 
                    a5 = a7       /* new maximum width 
                  end 
                else 
                  if a6 = 0       /* this is the first ":" 
                  else 
                    if a6 > a4 
                      a4 = a6     /* new maximum height 
                    end 
                    a6 = 0        /* redundant, but safe 
                  end 
                end 
              end 
            repeat 
            if a1 = 0 
              a1 = st_cnt 
            end 
            a3 = 2 
            perform build_regular_slur_dict (t6, a2, a1, a4, a5, a3, page_cnt)
          end 
&dA 
&dA &d@      Build long slur dictionaries 
&dA 
          if sst_cnt > 0 
            a1 = 0 
            a2 = 0 
            a3 = 3 
            loop for t3 = 1 to sst_cnt 
              tget [SST,t3] out 
              out = out // pad(4) 
              if out{1,4} = "Call" 
                a1 = t3 
                ++t3                /* skip ":" 
              else 
                if out{1} = ":" 
                  a2 = t3 
                  perform build_long_slur_dict (a1, a2, a3, page_cnt) 
                  ++a3 
                end 
              end 
            repeat 
          end 
&dA 
&dA &d@    Step 4: Write the PT and PT2 tables for this page to the PPT table 
&dA 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % This is the PT table for page ~page_cnt 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % ==================== 
          loop for t3 = 1 to pt_cnt 
            tget [PT,t3] temp 
            ++ppt_cnt 
            tput [PPT,ppt_cnt] ~temp 
          repeat 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % =========================== 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % This is the PT2 table for page ~page_cnt 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % ===================== 
          loop for t3 = 1 to pt_cnt2 
            tget [PT2,t3] temp 
            ++ppt_cnt 
            tput [PPT,ppt_cnt] ~temp 
          repeat 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % =========================== 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % 
&dA 
&dA &d@      New code &dA12/26/10&d@ and &dA01/17/11&d@ adding "color" highlight 
&dA 
&dA &d@     &dARED&d@ 
&dA 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] gsave            % save current graphics settings
          ++ppt_cnt 
          tput [PPT,ppt_cnt] 1 0 0 setrgbcolor 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % This is the PT3 table for page ~page_cnt 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % ==================== 
          loop for t3 = 1 to pt_cnt3 
            tget [PT3,t3] temp 
            ++ppt_cnt 
            tput [PPT,ppt_cnt] ~temp 
          repeat 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % =========================== 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] grestore         % restore previous graphics settings
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % 
&dI 
&dI &d@     &dIGREEN&d@ 
&dI 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] gsave            % save current graphics settings
          ++ppt_cnt 
          tput [PPT,ppt_cnt] 0 1 0 setrgbcolor 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % This is the PT4 table for page ~page_cnt 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % ==================== 
          loop for t3 = 1 to pt_cnt4 
            tget [PT4,t3] temp 
            ++ppt_cnt 
            tput [PPT,ppt_cnt] ~temp 
          repeat 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % =========================== 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] grestore         % restore previous graphics settings
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % 
&dL 
&dL &d@     &dLBLUE&d@ 
&dL 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] gsave            % save current graphics settings
          ++ppt_cnt 
          tput [PPT,ppt_cnt] 0 0 1 setrgbcolor 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % This is the PT5 table for page ~page_cnt 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % ==================== 
          loop for t3 = 1 to pt_cnt5 
            tget [PT5,t3] temp 
            ++ppt_cnt 
            tput [PPT,ppt_cnt] ~temp 
          repeat 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % =========================== 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] grestore         % restore previous graphics settings
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % 
&dA 
&dA &d@      End of New Code &dA12/26/10&d@ and &dA01/17/11&d@ 
&dA 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] showpage 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] %%PageTrailer 
          if (Addfiles & 0x02) = 0x02 
            ++ppt_cnt 
            tput [PPT,ppt_cnt] %=BeginMPGData: ~page_cnt 
            loop for t3 = mpgfile_start(page_cnt) to 1000000 
              tget [X,t3] line 
              ++ppt_cnt 
              tput [PPT,ppt_cnt] %=~line 
              if line{1} = "P" 
                line = line // pad(4) 
                if line{3} = " " or line{1,4} = "Page"   /* this is a "page" change
                  t3 = 1000000                           /* end of loop 
                end 
              end 
            repeat 
            ++ppt_cnt 
            tput [PPT,ppt_cnt] %=EndMPGData: ~page_cnt 
          end 
          ++ppt_cnt 
          tput [PPT,ppt_cnt] % 
&dA 
&dA &d@    Step 5: Initialize for the next page
&dA 
          setup gstr,300,3100,3 
          ++page_cnt 

          active_font = 0 

          treset [PT] 
          treset [PT2] 
          treset [PT3]               /* New &dA12/26/10&d@ 
          treset [PT4]               /* New &dA01/17/11&d@ 
          treset [PT5]               /* New &dA01/17/11&d@ 
          treset [SST] 
          treset [ST] 
          treset [CT] 
          treset [CT2]               /* New &dA12/26/10&d@ 
          treset [CT3]               /* New &dA01/17/11&d@ 
          treset [CT4]               /* New &dA01/17/11&d@ 

          st_cnt  = 0 
          ct_cnt  = 0 
          ct_cnt2 = 0                /* New &dA12/26/10&d@ 
          ct_cnt3 = 0                /* New &dA01/17/11&d@ 
          ct_cnt4 = 0                /* New &dA01/17/11&d@ 
          sst_cnt = 0 

          pt_cnt  = 0 
          pt_cnt2 = 0 
          pt_cnt3 = 0                /* New &dA12/26/10&d@ 
          pt_cnt4 = 0                /* New &dA01/17/11&d@ 
          pt_cnt5 = 0                /* New &dA01/17/11&d@ 

          sysnum = 0 
          f12 = 0 
          scf = notesize 

          goto TOP2 
        end 
        line = trm(line) 

        if line{1} = "E" 
          line = line // pad(12) 
          loop for t5 = 1 to SUPERMAX 
            if supermap(t5) <> 0 
              if (Debugg & 0x12) > 0 
                pute Outstanding superobject at end of line 
              end 
              return 
            end 
          repeat 
          loop for c8 = 1 to ntext 
            if line{c8+2} <> " " 
              if line{c8+2} <> "*" 
                if line{c8+2} <> xbyte(c8) 
                  if (Debugg & 0x12) > 0 
                    pute Current xbyte different from xbyte at end of line 
                  end 
                  return 
                end 
                y = psq(f12) + f(f12,c8) 
                if xbyte(c8) = "-" 
                  x = sp + syslen 
                  perform sethyph (c8,sysright) 
                end 
                if "_,.;:!?" con xbyte(c8) 
                  uxstop(c8) = sp + syslen - phpar(56) 
                  underflag = 2 
                  perform setunder (c8) 
                end 
                xbyte(c8) = "*" 
              else 
                if "_,.;:!?" con xbyte(c8) 
                  y = psq(f12) + f(f12,c8) 
                  underflag = 1 
                  if uxstop(c8) > sp + syslen - phpar(57) 
                    uxstop(c8) = sp + syslen - phpar(57) 
                  end 
                  perform setunder (c8) 
                end 
              end 
            end 
          repeat 
          goto TOP2 
        end 
        if line{1} = "S" 
&dA 
&dA &d@         S Y S T E M  (recoded &dA05/26/03&d@) &dIOK&d@ 
&dA &d@         ƒƒƒƒƒƒƒƒƒƒƒ  
&dA 
          f12 = 0 
          sysnum  = sysnum + 1 
          sub = 5 
          sp = int(line{sub..}) 

          sysy = int(line{sub..}) 
          syslen = int(line{sub..}) 
          sysright = sysy + syslen              /* added &dA12/31/08&d@ 
          sysh = int(line{sub..}) 
          f11 = int(line{sub..}) 
          line = line // "  " 
          tline = line{sub..} 
          tline = mrt(tline) 
          syscode = tline{2..} 
          if syscode con quote 
            syscode = syscode{1,mpt-1} 
          end 
&dA 
&dA &d@    Code to check number of parts in syscode (modified &dA11/13/03&d@) &dIOK&d@ 
&dA 
          a2 = 0 
          loop for c8 = 1 to len(syscode) 
            if ".:,;" con syscode{c8} 
              ++a2 
            end 
          repeat 
          if a2 <> f11 and syscode <> "" 
            if (Debugg & 0x12) > 0 
#if DMUSE 
              putc &dASyscode Warning&d@: Incorrect number of parts in syscode.  rec = ~(rec - 1)
#else 
              pute Syscode Warning: Incorrect number of parts in syscode.  rec = ~(rec - 1)
#endif 
            end 
          end 
&dA   
          sysflag = 0 
          goto TOP2 
        end 
        if line{1} = "L" or line{1} = "l"        /* New &dA11/11/05&d@ 
&dA 
&dA &d@         L I N E  
&dA &d@         ƒƒƒƒƒƒƒ  
&dA 
          stave_type = 0 
          if line{1} = "l" 
            line{1} = "L" 
            stave_type = 1 
          end 
          loop for c8 = 1 to 10 
            dyoff(c8) = 0 
            uxstart(c8) = 0 
            backloc(c8) = 0 
            ibackloc(c8) = 0 
          repeat 

          line = line // "            " 
          f12 = f12 + 1 
&dA 
&dA &d@    Field 2: y off-set in system  
&dA 
          psq(f12) = int(line{3..}) 
          psq(f12) += sysy 
&dA 
&dA &d@    Field 3: text off-set(s) from line   (separated by |) 
&dA 
          ntext = 0 
NSR1: 
          ++ntext 
          f(f12,ntext) = int(line{sub..}) 
          if line{sub} = "|" 
            ++sub 
            goto NSR1 
          end 
&dA 
&dA &d@    Field 4: dyoff(s)   separated by | 
&dA 
          c8 = 0 
NSR2: 
          ++c8 
          dyoff(c8) = int(line{sub..}) 
          if line{sub} = "|" 
            ++sub 
            goto NSR2 
          end 
&dA 
&dA &d@    Field 5: uxstart(s) separated by | 
&dA 
          c8 = 0 
NSR3: 
          ++c8 
          uxstart(c8) = int(line{sub..}) 
          if line{sub} = "|" 
            ++sub 
            goto NSR3 
          end 
&dA 
&dA &d@    Field 6: backloc(s) separated by | 
&dA 
          c8 = 0 
NSR4: 
          ++c8 
          backloc(c8) = int(line{sub..}) 
          ibackloc(c8) = backloc(c8)            /* New &dA08/26/03&d@ &dIOK&d@ 
          if line{sub} = "|" 
            ++sub 
            goto NSR4 
          end 

          tline = line{sub+1..} 
          tline = mrt(tline) 
&dA 
&dA &d@    Field 7: xbyte(s)   (length of field = number of bytes) 
&dA 
          if tline con " " 
            c8 = mpt - 1 
            if ntext < c8 
              loop for ntext = ntext + 1 to c8 
                f(f12,ntext) = f(f12,ntext-1) + pvpar(41) 
              repeat 
            end 
            loop for c8 = 1 to ntext 
              xbyte(c8) = tline{c8} 
            repeat 
          end 
&dA 
&dA &d@                New &dA08/28/03&d@ &dIOK&d@ 
&dA 
          loop for c8 = 1 to ntext 
            if dyoff(c8) = 0 
              dyoff(c8) = dyoff(1) 
            end 
            if uxstart(c8) = 0 
              uxstart(c8) = uxstart(1) 
            end 
            if backloc(c8) = 0 
              backloc(c8) = backloc(1) 
            end 
            if ibackloc(c8) = 0 
              ibackloc(c8) = ibackloc(1) 
            end 
          repeat 
&dA 
&dA &d@    Field 8: y off-set to virtual staff line (0 = none) 
&dA 
          vst(f12) = 0 
          if tline con " " 
            tline = tline{mpt..} 
            vst(f12) = int(tline) 
            tline = tline // " " 
            tline = tline{sub..} 
          end 
&dA 
&dA &d@    Field 9: notesize (0 = not specified; i.e., no change) 
&dA 
          if tline con " " 
            tline = tline{mpt..} 
            c8 = int(tline) 

            tline = tline // " "            /* New code &dA09/14/03&d@ &dIOK&d@ 
            tline = tline{sub..}            /*  "    "      " 

            if chr(c8) in [6,14,16,18,21]   /* New: notesize 16 added &dA12/31/08&d@ &dNnot OK
              if c8 <> notesize 
                notesize = c8 
                perform ps_init_par 
              end 
            end 
          end 
          nsz(f12) = notesize               /* New code &dA11/13/03&d@ &dIOK&d@ 
&dA 
&dA &d@    Field 10: additional off-set for figured harmony   New &dA09/14/03&d@ &dIOK&d@ 
&dA 
          figoff(f12) = 0 
          if tline con " " 
            tline = tline{mpt..} 
            figoff(f12) = int(tline) 

            tline = tline // " "            /* New code &dA09/14/03&d@ &dIOK&d@ 
            tline = tline{sub..}            /*  "    "      " 
          end 

          y = psq(f12) 
          perform staff (syslen,stave_type) 
          if vst(f12) > 0 
            y = psq(f12) + vst(f12) 
            perform staff (syslen,stave_type) 
          end 
          loop for c8 = 1 to ntext 
            buxstop(c8) = 1000000 
          repeat 
          goto TOP2 
        end 
        if line{1} = "@" 
&dA 
&dA &d@          @ - L I N E 
&dA &d@          ƒƒƒƒƒƒƒƒƒƒƒ 
&dA 
          goto TOP2 
        end 
        if line{1} = "Y" 
&dA 
&dA &d@          Y - L I N E 
&dA &d@          ƒƒƒƒƒƒƒƒƒƒƒ 
&dA 
          sub = 3 
          z = int(line{sub..}) 
          if z = 0                             /* New &dA03/26/05&d@ 
            goto TOP2 
          end 
          x = int(line{sub..}) 
          ttext = " " 
          if line{sub} = "C" or line{sub} = "R" 
            ttext = line{sub} // " " 
            ++sub 
          end 

          y = int(line{sub..}) 
          tline = line{sub..} 
          tline = mrt(tline) 
          line = "X " // chs(z) // " " // chs(x) // ttext // chs(y) // " " 
          if tline <> "" 
            loop for t3 = 1 to len(tline) 
              if tline{t3} = "\" 
                if t3 < len(tline) 
                  if ">]" con tline{t3+1} 
                    ++t3                      /* skip \> and \] 
                  else 
                    if "<[" con tline{t3+1} 
                      loop while t3 < len(tline) and tline{t3} <> "|" 
                        ++t3                  /* skip up to "|" character 
                      repeat 
                    else 
                      line = line // tline{t3} 
                    end 
                  end 
                else 
                  line = line // tline{t3} 
                end 
              else 
                line = line // tline{t3} 
              end 
            repeat 
          end 
        end 

        if line{1} = "X" 
&dA 
&dA &d@          X - L I N E 
&dA &d@          ƒƒƒƒƒƒƒƒƒƒƒ 
&dA 
          lpt = 3 
          tline = txt(line,[' '],lpt) 
          z = int(tline) 
          if lpt > len(line) 
            if z = 6 or z = 14 or z = 21 or z = 18 or z = 16 
              notesize = z 
              perform ps_init_par 
              scf = notesize 
            end 
            goto TOP2 
          end 

          tline = txt(line,[' '],lpt) 
          tline = tline // "  " 
          x = int(tline) 
          ttext = tline{sub} 

          tline = txt(line,[' '],lpt) 
          y = int(tline) 
          if lpt > len(line) 
            line = "" 
          else 
            line = line{lpt+1..} 
            line = trm(line) 
          end 
&dA 
&dA &d@    Code added &dA03/04/05&d@ to deal with "C" and "R" options 
&dA 
          if ttext = "C" or ttext = "R" 
            perform line_length (a1) 
            if ttext = "C" 
              a1 >>= 1 
            end 
            x -= a1 
          end 
          a1 = 0 
          perform setwords (a1) 

          goto TOP2 
        end 
        if line{1} = "J" 
&dA 
&dA &d@         O B J E C T S  
&dA &d@         ƒƒƒƒƒƒƒƒƒƒƒƒƒ 
&dA 
          tget [X,rec-1] line .t3 jtype ntype obx oby z t3 t3 supcnt 
          if jtype = "F" 
            oby += figoff(f12) 
          end 

          save_jtype = jtype 
          if jtype = "N" 
            loop for c8 = 1 to ntext 
              uxstop(c8) = sp + obx + phpar(7) 
              buxstop(c8) = 1000000 
            repeat 
          end 
*  
          if jtype = "D" 
            if ntype = 0 
              goto CZ4 
            end 
            if bit(1,ntype) = 1 
              goto CZ4 
            end 
            if bit(2,ntype) = 1 and f12 = 1 
              goto CZ4 
            end 
            if bit(3,ntype) = 1 and f12 = f11 
              goto CZ4 
            end 

        /* skip over directives 
SKD3: 
            tget [X,rec] line2 
            if line2{1} = "W" 
              ++rec 
              goto SKD3 
            end 

            goto TOP2 
          end 
&dA 
&dA &d@   Collect super-object information 
&dA 
CZ4: 
          if supcnt > 0 
        /*  This was the old strip8 code 
            loop for t3 = 1 to 7 
              if line con " " 
                line{mpt} = "." 
              end 
            repeat 
            if line con " " 
              line = line{mpt+1..} 
            else 
              line = "" 
            end 

            if int(line) <> supcnt       /* TEMP 
              if (Debugg & 0x12) > 0 
                pute Error reading an object record 
              end 
              return 
            end 
            lpt = 0 
            tline = txt(line,[' '],lpt) 
            loop for t3 = 1 to supcnt 
              tline = txt(line,[' '],lpt) 
              t4 = int(tline) 
*     look for previous reference to this superobject  
              loop for t5 = 1 to SUPERMAX 
                if supermap(t5) = t4 
                  goto WD 
                end 
              repeat 
              t1 = 0 
              loop for t5 = 1 to SUPERMAX 
                if supermap(t5) = 0 
                  t1 = t5 
                  t5 = SUPERMAX 
                end 
              repeat 
              if t1 = 0 
                if (Debugg & 0x12) > 0 
                  pute No more superobject capacity 
                end 
                return 
              end 
&dA 
&dA &d@     if not found, then set up reference to this superobject. 
&dA 
              t5 = t1 
              supermap(t5) = t4 
              superpnt(t5) = 1 
*       t5 (value 1 to SUPERMAX) = pointer into ps_superdata for this superobject
WD: 
              t1 = superpnt(t5) 
*       store object information in ps_superdata and increment superpnt 
              superpnt(t5) = t1 + 3       /* New increment in ps_superdata pointer &dA12/21/10
              ps_superdata(t5,t1) = obx 
              ps_superdata(t5,t1+1) = oby 
&dA 
&dA &d@   New code &dA12/21/10&d@.  We need to determine whether there is "color" in this
&dA &d@            object.  If there is, we need to store the "color flag" in 
&dA &d@            ps_superdata(t5,t1+2), a new element of ps_superdata.  The value
&dA &d@            matters only for dskpage and pspage.  
&dA 
              a2 = 0 
              a1 = rec 
              loop 
                tget [X,a1] line2 
                ++a1 
                if line2{1} = "C" 
                  a2 = 1 
                end 
              repeat while line2{1} = "K" or line2{1} = "C" or line2{1} = "T"
              ps_superdata(t5,t1+2) = a2 
            repeat 
          end 
&dA 
&dA &d@     if no sub-objects, then typeset object 
&dA 
          if vst(f12) > 0 and oby > 700 
            oby -= 1000 
            oby += vst(f12) 
          end 

          if z > 32 
            x = sp + obx 
            if jtype <> "B" 
              y = psq(f12) + oby 
              perform setmus 
            end 
          end 
&dA 
&dA &d@   typeset underline (if unset) 
&dA 
          saverec = rec 
          if jtype = "R" 
            loop for c8 = 1 to ntext 
              if "_,.;:!?" con xbyte(c8) 
&dA 
&dA &d@   check next note for new syllable 
&dA 
YR4: 
                tget [X,rec] line 
                ++rec 
                line = line // pad(12) 
                if line{1} = "E" 
                  if line{c8+2} = "*" 
                    goto YR2 
                  end 
                  goto YR3 
                end 
                if line{1,3} = "J N" 
YR1: 
                  tget [X,rec] line 
                  ++rec 
                  if "kKCA" con line{1}        /* Added &dA11-11-93&d@ "C" added &dA01/17/11
                    goto YR1 
                  end 
                  if line{1} = "T" 
                    c9 = int(line{3..}) 
                    c9 = int(line{sub..})     /* text line number 
                    if c8 = c9 
                      goto YR2 
                    end 
                    goto YR1 
                  end 
                  goto YR3 
                end 
                goto YR4 
* 
YR2: 
                y = psq(f12) + f(f12,c8) 
                underflag = 1 
                if mpt > 1 
                  uxstop(c8) -= phpar(20) 
                end 
                if buxstop(c8) < uxstop(c8) 
                  uxstop(c8) = buxstop(c8) 
                end 
                perform setunder (c8) 
                xbyte(c8) = "*" 
                buxstop(c8) = 1000000 
              end 
YR3: 
              rec = saverec 
            repeat 
          end 

          if jtype = "B" 
            oby = 0 
            loop for c8 = 1 to ntext 
              buxstop(c8) = sp + obx - phpar(57) 
            repeat 
          end 
          goto TOP2 
        end 
        if line{1} = "k" 
&dA 
&dA &d@      "Silent" S U B - O B J E C T S 
&dA &d@      ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ 
&dA 
          goto TOP2 
        end 
        if line{1} = "K" or line{1} = "C"     /* "C" added &dA12/17/10&d@ 
&dA 
&dA &d@       S U B - O B J E C T S 
&dA &d@       ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ 
&dA 
          if line{1} = "C"                    /* New &dA12/17/10&d@ and &dA01/17/11&d@ 
            lpt = 3 
            tline = txt(line,[' '],lpt) 
*  line structure = 0xcccccc sobx soby z 
            if tline{1,2} = "0x" 
              tline = tline // pad(8) 
              color_line = tline{1,8} 
              if tline{3,2} >= tline{5,2} 
                if tline{3,2} >= tline{7,2} 
                  color_flag = 1 
                else 
                  color_flag = 3 
                end 
              else 
                if tline{5,2} >= tline{7,2} 
                  color_flag = 2 
                else 
                  color_flag = 3 
                end 
              end 
              tline = txt(line,[' '],lpt) 
              sobx = int(tline) 
              tline = txt(line,[' '],lpt) 
              soby = int(tline) 
              tline = txt(line,[' '],lpt) 
              z = int(tline) 
            else 
              color_flag = 1 
              color_line = "0xff0000" 
              tget [X,rec-1] .t3 sobx soby z 
            end 
          else 
            color_flag = 0 
            tget [X,rec-1] .t3 sobx soby z 
          end 
          x = sp + obx + sobx 
          y = psq(f12) + oby + soby 
          perform setmus 
          if save_jtype = "B" and z = DOT_CHAR 
            y += vst(f12) 
            perform setmus 
          end 
          color_flag = 0 

          goto TOP2 
        end 
        if line{1} = "A"                   /* Added &dA11-11-93&d@ 
&dA 
&dA &d@       A T T R I B U T E S  
&dA &d@       ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ  
&dA 
          goto TOP2 
        end 
        if line{1} = "W" or line{1} = "w"    /* New &dA11/29/09&d@ 
&dA 
&dA &d@       W O R D S 
&dA &d@       ƒƒƒƒƒƒƒƒƒ 
&dA 
          lpt = 3 
          tline = txt(line,[' '],lpt) 
*  line structure = sobx soby font# text 
          sobx = int(tline) 
          tline = txt(line,[' '],lpt) 
          soby = int(tline) 
          tline = txt(line,[' '],lpt) 
          z = int(tline) 
          if len(line) > lpt and z <> 0         /* &dA10/01/03&d@ adding condition z <> 0  &dIOK
            line = line{lpt+1..} 
            x = sp + obx + sobx 
            y = psq(f12) + oby + soby 
            a1 = 0 
            perform setwords (a1) 
          end 
          goto TOP2 
        end 
        if line{1} = "T" 
&dA 
&dA &d@       T E X T 
&dA &d@       ƒƒƒƒƒƒƒ 
&dA 
          line = line // "  " 
*  line structure = sobx tlevel[|soby] ttext xbyte textlen 
          sobx = int(line{3..}) 
          tlevel = int(line{sub..}) 
          if tlevel < 1 or tlevel > 10 
            if (Debugg & 0x12) > 0 
              pute Error: Invalid tlevel in Text record ~(rec - 1) 
            end 
            return    
          end 
          soby = 0 
          if line{sub} = "|" 
            ++sub 
            soby = int(line{sub..}) 
          end 
          line = line{sub..} 
          line = mrt(line)           /* ttext is next in line 
          if line con " " 
            ttext = line{1,mpt-1} 
            line = line{mpt..} 
            line = mrt(line) 
          end 
&dA 
&dA &d@  typeset back hyphons or underlines (if they exist) 
&dA 
          if xbyte(tlevel) = "-" 
            y = psq(f12) + f(f12,tlevel) 
            x = sp + obx + sobx 
            perform sethyph (tlevel,sysright) 
          end 

          if "_,.;:!?" con xbyte(tlevel) 
            x = sp + obx + sobx - phpar(20) 
            if mpt > 1 
              x -= phpar(20) 
            end 
            if uxstop(tlevel) > x 
              uxstop(tlevel) = x 
            end 
            y = psq(f12) + f(f12,tlevel) 
            if ttext = "~" 
              underflag = 2 
            else 
              underflag = 1 
            end 
            perform setunder (tlevel) 
          end 
&dA 
&dA &d@  typeset underline if terminator (~) is found  (Code added &dA02-24-95&d@) 
&dA 
          if ttext = "~" 
            x = sp + obx + sobx + phpar(20) + phpar(20) 
            uxstop(tlevel) = x 
            y = psq(f12) + f(f12,tlevel) 
            underflag = 1 
            perform setunder (tlevel) 
            xbyte(tlevel) = " " 
            goto TOP2 
          end 

          sub = 1 
          loop while ttext con "_" 
            ttext{mpt} = " " 
          repeat 

          textlen = 0 
          xbyte(tlevel) = "*" 
          if line <> "" 
            line = line // " " 
            xbyte(tlevel) = line{1} 
            textlen = int(line{2..}) 
          end 

          x = sp + obx + sobx 
          y = psq(f12) + f(f12,tlevel) + soby 
          backloc(tlevel) = x + textlen 
          uxstart(tlevel) = x + textlen + phpar(19) 
          z = mtfont 
          line = ttext 
          a1 = 1 
          perform setwords (a1) 
          goto TOP2 
        end 
        if line{1} = "P" 
          line = line // pad(3) 
        end 
        if line{1} = "H" or (line{1} = "P" and line{3} <> " ")    /* "P" added &dA12/17/10
&dA 
&dA &d@       S U P E R - O B J E C T S 
&dA &d@       ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ 
&dA 
&dA &d@    Look for color New &dA12/17/10&d@ and &dA01/17/11&d@ 
&dA 
          color_flag = 0                          /* New &dA12/17/10&d@ 
          if line{1} = "P" 
            lpt = 3 
            tline = txt(line,[' '],lpt) 
*  line structure = 0xcccccc supernum htype . . .  
            if tline{1,2} = "0x" 
              tline = tline // pad(8) 
              color_line = tline{1,8} 
              if tline{3,2} >= tline{5,2} 
                if tline{3,2} >= tline{7,2} 
                  color_flag = 1 
                else 
                  color_flag = 3 
                end 
              else 
                if tline{5,2} >= tline{7,2} 
                  color_flag = 2 
                else 
                  color_flag = 3 
                end 
              end 
              tline = txt(line,[' '],lpt) 
            else 
              color_flag = 1 
              color_line = "0xff0000" 
            end 
          else 
*  line structure = supernum htype . . .  
            lpt = 3 
            tline = txt(line,[' '],lpt) 
          end 
&dA     
          supernum = int(tline) 
*  get ps_superdata for this superobject 
          loop for t5 = 1 to SUPERMAX 
            if supermap(t5) = supernum 
              goto WE 
            end 
          repeat 
          if (Debugg & 0x12) > 0 
            pute Error: No refererce to superobject ~supernum  in previous objects
          end    
          return 
&dA 
&dA &d@  t5 = index into ps_superdata.  WE is the continuation point 
&dA 
WE: 
          htype = txt(line,[' '],lpt) 
          if line{1} = "P" 
            if htype = "B" or htype = "T" 
            else 
              color_flag = 0 
            end 
          end 
&dA 
&dA &d@  compensate for out-of-order objects 
&dA 
&dA &d@  Code changes &dA12/21/10&d@: New index for second obx element 
&dA &d@                         Switching 3 superdata elements instead of 2 
&dA 
          if ps_superdata(t5,1) > ps_superdata(t5,4) 
            x1 = ps_superdata(t5,4) 
            y1 = ps_superdata(t5,5) 
            a1 = ps_superdata(t5,6) 
            ps_superdata(t5,4) = ps_superdata(t5,1) 
            ps_superdata(t5,5) = ps_superdata(t5,2) 
            ps_superdata(t5,6) = ps_superdata(t5,3) 
            ps_superdata(t5,1) = x1 
            ps_superdata(t5,2) = y1 
            ps_superdata(t5,3) = a1 
          end 
&dA      
          if htype = "T" 
&dA 
&dA &d@  structure of &dDtie superobject&d@:  4. vertical position of tied note 
&dA &d@                                 5. horiz. displacement from 1st note 
&dA &d@                                 6. horiz. displacement from 2nd note 
&dA &d@                                 7. post adjustment of calculated left x position  &dA04/20/03&d@ &dIOK
&dA &d@                                 8. post adjustment of calculated y position          "
&dA &d@                                 9. post adjustment of calculated right x position    "
&dA &d@                                10. sitflag 
&dA &d@                                11. recalc flag 
&dA 
            tline = txt(line,[' '],lpt) 
            y1 = int(tline) 
            tline = txt(line,[' '],lpt) 
            x1 = int(tline) + ps_superdata(t5,1) 
            tline = txt(line,[' '],lpt) 
            x2 = int(tline) 
            tline = txt(line,[' '],lpt) 
            a2 = int(tline)                          /* tpost_x 
            tline = txt(line,[' '],lpt) 
            a3 = int(tline)                          /* tpost_y 
            tline = txt(line,[' '],lpt) 
            a4 = int(tline)                          /* tpost_leng 
            tline = txt(line,[' '],lpt) 
            sitflag = int(tline) 
            a1 = ps_superdata(t5,4) + x2 - x1        /* New index for second element &dA12/21/10
            perform settie (a1,a2,a3,a4) 
            color_flag = 0                           /* New &dA12/17/10&d@ 
            supermap(t5) = 0 
            goto TOP2 
          end 
          if htype = "B" 
&dA 
&dA &d@  structure of &dDbeam superobject&d@: slope vertoff font# #obs bc(1) ...  
&dA 
            tline = txt(line,[' '],lpt) 
            a1 = int(tline)                         /* @k 
            tline = txt(line,[' '],lpt) 
            a2 = int(tline)                         /* @m 
            tline = txt(line,[' '],lpt) 
            beamfont = int(tline) 
            t3 = ors("ffffgghiijjkkllmmnoopprr"{notesize})    /* old "Mbeamfont()"
            if beamfont = t3 
              stemchar = 59 
              beamt = pvpar(32) 
              qwid = phpar(3) 
            else 
              stemchar = 187 
              beamt = pvpar(32) * 4 + 3 / 5 
              qwid = phpar(5) 
            end 
            tline = txt(line,[' '],lpt) 
            bcount = int(tline) 
            t4 = 1 
            loop for t3 = 1 to bcount 
              ps_beamdata(t3,1) = ps_superdata(t5,t4) + sp 
              ps_beamdata(t3,2) = ps_superdata(t5,t4+1) + psq(f12) 
              ps_beamdata(t3,3) = ps_superdata(t5,t4+2) + psq(f12)   /* New data &dA12/21/10
              temp = txt(line,[' '],lpt) 
              temp = rev(temp) 
              t1 = 6 - len(temp) 
              msk_beamcode(t3) = temp // "00000"{1,t1} 
              t4 += 3                                    /* New increment in superdata &dA12/21/10
            repeat 
*   print beam 
            tbflag = 0 
            if tupldata(1) > 0 and tupldata(5) = supernum 
              tbflag = bit(4,tupldata(1)) 
              ++tbflag 
            end 
            perform ps_setbeam (a1,a2) 
            tupldata(1) = 0 
            supermap(t5) = 0 
            color_flag = 0                                 /* New &dA12/17/10&d@ 
            goto TOP2 
          end 
          if htype = "S" 
&dA 
&dA &d@  structure of &dDslur superobject&d@:  4. sitflag 
&dA &d@                                  5. extra horiz. displ. from obj-1 
&dA &d@                                  6. extra vert. displ. from obj-1 
&dA &d@                                  7. extra horiz. displ. from obj-2 
&dA &d@                                  8. extra vert. displ. from obj-2 
&dA &d@                                  9. extra curvature     (new 6-30-93) 
&dA &d@                                 10. beam flag        
&dA &d@                                 11. post adjustment to x co-ordinate 
&dA &d@                                 12. post adjustment to y co-ordinate 
&dA 
            slur_edit_flag = 0 
            tline = txt(line,[' '],lpt) 
            sitflag = int(tline) 
            tline = txt(line,[' '],lpt) 
            x1 = int(tline) + ps_superdata(t5,1) 
            tline = txt(line,[' '],lpt) 
            y1 = int(tline) 
            if y1 <> 0 
              slur_edit_flag = 1 
            end 
            y1 += ps_superdata(t5,2) 
            tline = txt(line,[' '],lpt) 
            x2 = int(tline) + ps_superdata(t5,4)       /* New index for second obx &dA12/21/10
            tline = txt(line,[' '],lpt) 
            y2 = int(tline) 
            if y2 <> 0 
              slur_edit_flag = 1 
            end 
            y2 += ps_superdata(t5,5)                   /* New index for second oby &dA12/21/10
            if y1 > 700 
              y1 -= 1000 
              y1 += vst(f12) 
            end 
            if y2 > 700 
              y2 -= 1000 
              y2 += vst(f12) 
            end 
            tline = txt(line,[' '],lpt) 
            a1 = int(tline)               /* addcurve 
            tline = txt(line,[' '],lpt) 
            t4 = int(tline) 
            postx = 0 
            posty = 0 
            if lpt < len(line) 
              tline = txt(line,[' '],lpt) 
              postx = int(tline) 
            end 
            if lpt < len(line) 
              tline = txt(line,[' '],lpt) 
              posty = int(tline) 
            end 
            if bit(5,sitflag) = 0           /* This condition added &dA04/26/05
              perform putslur (a1) 
            end 
            supermap(t5) = 0 
            goto TOP2 
          end 
          if htype = "F" 
&dA 
&dA &d@  structure of &dDfigcon super-object&d@:  4. figure level 
&dA &d@                                     5. horiz. disp. from obj1 
&dA &d@                                     6. horiz. disp. from obj2 
&dA &d@                                     7. (optional) additional vert. disp.  &dANew 11/06/03
&dA &d@                                          from default height 
&dA 
            tline = txt(line,[' '],lpt) 
            a3 = int(tline) 
            tline = txt(line,[' '],lpt) 
            x1 = int(tline) + ps_superdata(t5,1) 
            tline = txt(line,[' '],lpt) 
            x2 = int(tline) + ps_superdata(t5,4)      /* New index for second obx &dA12/21/10
            y1 = 0 
            if lpt < len(line) 
              tline = txt(line,[' '],lpt) 
              y1 = int(tline) 
            end 
            perform putfigcon (a3) 
            supermap(t5) = 0 
            goto TOP2 
          end 
          if htype = "X" 
&dA 
&dA &d@  structure of &dDtuplet super-object&d@:  4. situation flag 
&dA &d@                                     5. tuplet number 
&dA &d@                                     6. horiz. disp. from obj1 
&dA &d@                                     7. vert. disp. from obj1 
&dA &d@                                     8. horiz. disp. from obj2 
&dA &d@                                     9. vert. disp. from obj2 
&dA &d@                                    10. associated beam super-number 
&dA 
            tline = txt(line,[' '],lpt) 
            sitflag = int(tline) 
            tline = txt(line,[' '],lpt) 
            a1 = int(tline) 
            tline = txt(line,[' '],lpt) 
            x1 = int(tline) 
            tline = txt(line,[' '],lpt) 
            y1 = int(tline) 
            tline = txt(line,[' '],lpt) 
            x2 = int(tline) 
            tline = txt(line,[' '],lpt) 
            y2 = int(tline) 
            tline = txt(line,[' '],lpt) 
            a2 = int(tline) 
            if bit(3,sitflag) = 1 
              tupldata(1) = sitflag 
              tupldata(2) = a1 
              tupldata(3) = x1 
              tupldata(4) = x2 
              tupldata(5) = a2 
              tupldata(6) = y1 
              tupldata(7) = y2 
            else 
              x1 += ps_superdata(t5,1) 
              y1 += ps_superdata(t5,2) 
              x2 += ps_superdata(t5,4)         /* New index for second obx &dA12/21/10
              y2 += ps_superdata(t5,5)         /* New index for second oby &dA12/21/10
              if y1 > 700 
                y1 -= 1000 
                y1 += vst(f12) 
              end 
              if y2 > 700 
                y2 -= 1000 
                y2 += vst(f12) 
              end 
              perform puttuplet (a1) 
            end 
            supermap(t5) = 0 
            goto TOP2 
          end 
          if htype = "V" 
&dA 
&dA &d@  structure of &dDtransp super-object&d@:  4. situation: 0=8av up, 1=8av down 
&dA &d@                                     5. horiz. disp. from obj1  
&dA &d@                                     6. horiz. disp. from obj2  
&dA &d@                                     7. vert. disp. from obj1 
&dA &d@                                     8. length of right vertical hook 
&dA 
            tline = txt(line,[' '],lpt) 
            a3 = int(tline) 
            tline = txt(line,[' '],lpt) 
            x1 = int(tline) + ps_superdata(t5,1) 
            tline = txt(line,[' '],lpt) 
            x2 = int(tline) + ps_superdata(t5,4)    /* New index for second obx &dA12/21/10
            tline = txt(line,[' '],lpt) 
            y1 = int(tline)                    /*   + ps_superdata(t5,2) 
            if y1 > 700 
              y1 -= 1000 
              y1 += vst(f12) 
            end 
            tline = txt(line,[' '],lpt) 
            a1 = int(tline) 
            perform puttrans (a1,a3) 
            supermap(t5) = 0 
            goto TOP2 
          end 
          if htype = "E" 
&dA 
&dA &d@  structure of &dDending super-object&d@:  4. ending number (0 = none)  
&dA &d@                                     5. horiz. disp. from obj1  
&dA &d@                                     6. horiz. disp. from obj2  
&dA &d@                                     7. vert. disp. from staff lines  
&dA &d@                                     8. length of left vertical hook  
&dA &d@                                     9. length of right vertical hook 
&dA 
            tline = txt(line,[' '],lpt) 
            a3 = int(tline) 
            tline = txt(line,[' '],lpt) 
            x1 = int(tline) + ps_superdata(t5,1) 
            tline = txt(line,[' '],lpt) 
            x2 = int(tline) + ps_superdata(t5,4)    /* New index for second obx &dA12/21/10
            tline = txt(line,[' '],lpt) 
            y1 = int(tline) 
            tline = txt(line,[' '],lpt) 
            a1 = int(tline) 
            tline = txt(line,[' '],lpt) 
            a2 = int(tline) 
            perform putending (a1,a2,a3) 
            supermap(t5) = 0 
            goto TOP2 
          end 
          if htype = "D" 
&dA 
&dA &d@  structure of &dDdashes super-object&d@:  4. horiz. disp. from obj1  
&dA &d@                                     5. horiz. disp. from obj2  
&dA &d@                                     6. vert. disp. from staff lines  
&dA &d@                                     7. spacing parameter 
&dA &d@                                     8. font designator 
&dA 
            tline = txt(line,[' '],lpt) 
            x1 = int(tline) + ps_superdata(t5,1) 
            tline = txt(line,[' '],lpt) 
            x2 = int(tline) + ps_superdata(t5,4)    /* New index for second obx &dA12/21/10
            tline = txt(line,[' '],lpt) 
            y1 = ps_superdata(t5,2) 
            if y1 > 700 
              y1 = vst(f12) 
            else 
              y1 = 0 
            end 
            y1 += int(tline) 
            tline = txt(line,[' '],lpt) 
            a1 = int(tline) 
            tline = txt(line,[' '],lpt) 
            a2 = int(tline) 
            perform putdashes (a1,a2) 
            supermap(t5) = 0 
            goto TOP2 
          end 
          if htype = "R" 
&dA 
&dA &d@  structure of &dDtrill super-object&d@:  4. situation: 1 = no trill, only ~~~~ 
&dA &d@                                                  2 = trill with ~~~~ 
&dA &d@                                                  3 = tr ~~~~ with sharp above
&dA &d@                                                  4 = tr ~~~~ with natural above
&dA &d@                                                  5 = tr ~~~~ with flat above
&dA &d@                                    5. horiz. disp. from object 1 
&dA &d@                                    6. horiz. disp. from object 2 
&dA &d@                                    7. vert. disp. from object 1 
&dA 
            tline = txt(line,[' '],lpt) 
            a1 = int(tline) 
            tline = txt(line,[' '],lpt) 
            x1 = int(tline) + ps_superdata(t5,1) 
            tline = txt(line,[' '],lpt) 
            x2 = int(tline) + ps_superdata(t5,4)    /* New index for second obx &dA12/21/10
            tline = txt(line,[' '],lpt) 
            y1 = int(tline) + ps_superdata(t5,2) 
            if y1 > 700 
              y1 -= 1000 
              y1 += vst(f12) 
            end 
            perform puttrill (a1) 
            supermap(t5) = 0 
            goto TOP2 
          end 
          if htype = "W" 
&dA 
&dA &d@  structure of &dDwedge super-object&d@:  4. left spread  
&dA &d@                                    5. right spread 
&dA &d@                                    6. horiz. disp. from obj1 
&dA &d@                                    7. beg. vert. disp. from staff  
&dA &d@                                    8. horiz. disp. from obj2 
&dA &d@                                    9. end. vert. disp. from staff  
&dA 
            tline = txt(line,[' '],lpt) 
            c1 = int(tline) 
            tline = txt(line,[' '],lpt) 
            c2 = int(tline) 
            tline = txt(line,[' '],lpt) 
            x1 = int(tline) + ps_superdata(t5,1) 
            tline = txt(line,[' '],lpt) 
            c3 = ps_superdata(t5,2) 
            if c3 > 700 
              c3 = vst(f12) 
            else 
              c3 = 0 
            end 
            y1 = int(tline) + c3 
            tline = txt(line,[' '],lpt) 
            x2 = int(tline) + ps_superdata(t5,4)    /* New index for second obx &dA12/21/10
            a1 = x2 - x1 
            if a1 < phpar(39) 
              x2 = x1 + phpar(39) 
            end 
            tline = txt(line,[' '],lpt) 
            y2 = int(tline) + c3 
            perform putwedge (c1,c2) 
            supermap(t5) = 0 
            goto TOP2 
          end 
          if htype = "N" 
            supermap(t5) = 0 
            goto TOP2 
          end 
        end 
        if line{1} = "B" 
&dA 
&dA &d@       B A R    L I N E  (section recoded &dA05/26/03&d@)  &dIOK&d@ 
&dA &d@       ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ 
&dA 
          sub = 3 
          a7 = int(line{sub..}) 
          if a7 = 99 
            if sysflag = 0 
              sysflag = 1 
            end 
            goto TOP2 
          end 
&dA 
&dA &d@    First make sure that the system line is printed.  
&dA &d@    (this code moved here and revised &dA11/13/03&d@) &dIOK&d@ 
&dA 
          savesub = sub 
          savensz = notesize 
          if sysflag = 0 
&dA 
&dA &d@    Code added here &dA11/13/03&d@ to set govstaff for printing sysline, etc. &dIOK&d@ 
&dA 
            govstaff = 0 
            a2 = 0 
            loop for c8 = 1 to len(syscode) 
              if ".:,;" con syscode{c8} 
                ++a2 
                if mpt > 2 
                  if govstaff = 0 
                    govstaff = a2 
                  else 
                    if nsz(a2) > nsz(govstaff) 
                      govstaff = a2 
                    end 
                  end 
                end 
              end 
            repeat 
            if govstaff = 0 
              govstaff = f11                   /* default for govstaff 
            end 

            a2 = nsz(govstaff) 
            if a2 <> notesize 
              notesize = a2 
              perform ps_init_par 
            end 

            perform sysline 
            sysflag = 1 
          end 
          sub = savesub 
&dA    
          a8 = a7 & 0x0f 
          x = int(line{sub..}) 
          brkcnt = int(line{sub..}) 
          loop for t3 = 1 to brkcnt 
            a6 = int(line{sub..}) 
            barbreak(t3,1) = a6 + sysy 
            a6 = int(line{sub..}) 
            barbreak(t3,2) = a6 + sysy 
          repeat 
*    sort breaks in ascending order of offset  
          if brkcnt > 1 
            c5 = brkcnt - 1 
            loop for c1 = 1 to c5 
              c6 = c1 + 1 
              loop for c2 = c6 to brkcnt 
                if barbreak(c2,1) < barbreak(c1,1) 
                  c3 = barbreak(c1,1) 
                  c4 = barbreak(c1,2) 
                  barbreak(c1,1) = barbreak(c2,1) 
                  barbreak(c1,2) = barbreak(c2,2) 
                  barbreak(c2,1) = c3 
                  barbreak(c2,2) = c4 
                end 
              repeat 
            repeat 
          end 
* 
          x = x + sp 
          if a8 < 2 
            z = 82 
            perform barline 
          end 
          if a8 = 2 
            x = x - phpar(33)     /* phpar(33) = heavy - light + 1 
            z = 84 
            perform barline 
          end 
          if a8 = 3 
            z = 86 
            perform barline 
          end 
          if a8 = 5 
            z = 82 
            perform barline 
            x = x - phpar(48)     /* phpar(48) = light + delta-light (auto hpar(44))
            perform barline 
          end 
          if a8 = 6 
            z = 84 
            x = x - phpar(33) 
            perform barline 
            z = 82 
            x = x - phpar(34)     /* phpar(34) = light + delta-heavy (auto hpar(45))
            perform barline 
          end 
          if a8 = 9 
            z = 84 
            perform barline 
            z = 82 
            x = x + phpar(33) + phpar(34) - 1 
            perform barline 
            if a7 > 15 
              x = x + phpar(36) 
              loop for f12 = 1 to f11 
                y = psq(f12) + pvpar(3) 
                z = 44 
                perform setmus 
                y = y + pvpar(2) 
                perform setmus 
&dA 
&dA &d@        Adding code &dA05/26/03&d@ for print second set of dots in case of grandstaff   &dIOK
&dA &d@ 
                if vst(f12) > 0 
                  y = y - pvpar(2) + vst(f12) 
                  z = 44 
                  perform setmus 
                  y = y + pvpar(2) 
                  perform setmus 
                end 

              repeat 
            end 
          end 
          if a8 = 10 
            z = 84 
            perform barline 
            x = x - phpar(33) - phpar(34) + 1 
            perform barline 
          end 
&dA 
&dA &d@    Code added &dA11/13/03&d@ to reset notesize to local value &dIOK&d@ 
&dA 
          if notesize <> savensz 
            notesize = savensz 
            perform ps_init_par 
          end 
&dA   
          goto TOP2 
        end 
        goto TOP2 

TASK_DONE: 

        --page_cnt 
        zpnt = 0 
        loop for t3 = 1 to 140 
          t5 = 0 
          loop for t4 = 1 to 256 
            if glyph_record(t3,t4) > 0 
              if t5 = 0 
                ++zpnt 
                tput [ZZ,zpnt] font .w4 ~t3 
                ++zpnt 
                tput [ZZ,zpnt] ============== 
                t5 = 1 
              end 
              ++zpnt 
              tput [ZZ,zpnt] .t4 char .w4 ~t4 
            end 
          repeat 
        repeat 
        ++zpnt 
        tput [ZZ,zpnt] $ 

        perform build_page_pdict 

        a5 = 10000 
        a6 = 0 
        a7 = 10000 
        a8 = 0 
        loop for t5 = 1 to page_cnt 
          if box_top_limit(t5) < a5 
            a5 = box_top_limit(t5) 
          end 
          if box_bottom_limit(t5) > a6 
            a6 = box_bottom_limit(t5) 
          end 
          if box_left_limit(t5) < a7 
            a7 = box_left_limit(t5) 
          end 
          if box_right_limit(t5) > a8 
            a8 = box_right_limit(t5) 
          end 
        repeat 
&dA 
&dA &d@    Now construct the global box limits 
&dA 
&dA 
        left_limit = a7 
        right_limit = a8 
        top_limit = a5 
        bottom_limit = a6 

        left_limit -= 1 
        top_limit  -= 1 

        left_limit += 50 
        right_limit += 50 
        top_limit = 3150 - top_limit 
        bottom_limit = 3150 - bottom_limit 
&dA 
&dA &d@       Convert dots to points, using 300 dpi 
&dA &d@       Format = llx lly ulx uly 
&dA 
        temp3 = "" 
        temp2 = "" 
        a1 = left_limit * 24 
        a2 = a1 / 100 
        a3 = rem 
        if rem < 50 
          temp2 = temp2 // chs(a2) // " " 
        else 
          temp2 = temp2 // chs(a2+1) // " " 
        end 
        temp3 = temp3 // chs(a2) // "." 
        if a3 < 10 
          temp3 = temp3 // "0" 
        end 
        temp3 = temp3 // chs(a3) // " " 

        a1 = bottom_limit * 24 
        a2 = a1 / 100 
        a3 = rem 
        if rem < 50 
          temp2 = temp2 // chs(a2) // " " 
        else 
          temp2 = temp2 // chs(a2+1) // " " 
        end 
        temp3 = temp3 // chs(a2) // "." 
        if a3 < 10 
          temp3 = temp3 // "0" 
        end 
        temp3 = temp3 // chs(a3) // " " 

        a1 = right_limit * 24 
        a2 = a1 / 100 
        a3 = rem 
        if rem < 50 
          temp2 = temp2 // chs(a2) // " " 
        else 
          temp2 = temp2 // chs(a2+1) // " " 
        end 
        temp3 = temp3 // chs(a2) // "." 
        if a3 < 10 
          temp3 = temp3 // "0" 
        end 
        temp3 = temp3 // chs(a3) // " " 

        a1 = top_limit * 24 
        a2 = a1 / 100 
        a3 = rem 
        if rem < 50 
          temp2 = temp2 // chs(a2) 
        else 
          temp2 = temp2 // chs(a2+1) 
        end 
        temp3 = temp3 // chs(a2) // "." 
        if a3 < 10 
          temp3 = temp3 // "0" 
        end 
        temp3 = temp3 // chs(a3)
&dA 
&dA            

&dK &d@       putc %!PS 
&dK &d@       putc 
&dK &d@       putc % This is the PD dictionary 
&dK &d@       putc % ========================= 
&dK &d@       loop for t3 = 1 to pd_cnt 
&dK &d@         tget [PD,t3] temp 
&dK &d@         putc ~temp 
&dK &d@       repeat 
&dK &d@       putc % =========================== 
&dK &d@       putc 
&dK &d@       putc % This is the SD dictionary 
&dK &d@       putc % ========================= 
&dK &d@       loop for t3 = 1 to sd_cnt 
&dK &d@         tget [SD,t3] temp 
&dK &d@         putc ~temp 
&dK &d@       repeat 
&dK &d@       putc % =========================== 
&dK &d@       putc 
&dK &d@       putc % This is the PT table 
&dK &d@       putc % ==================== 
&dK &d@       loop for t3 = 1 to pt_cnt 
&dK &d@         tget [PT,t3] temp 
&dK &d@         putc ~temp 
&dK &d@       repeat 
&dK &d@       putc % =========================== 
&dK &d@       putc 
&dK &d@       putc % This is the PT2 table 
&dK &d@       putc % ===================== 
&dK &d@       loop for t3 = 1 to pt_cnt2 
&dK &d@         tget [PT2,t3] temp 
&dK &d@         putc ~temp 
&dK &d@       repeat 
&dK &d@       putc % =========================== 
&dK &d@       putc 
&dK &d@       putc showpage 

#if DMUSE 
        open [2,2] outfile 

        putf [2] %!PS-Adobe-3.0 
        loop for t1 = 1 to 10 
          putf [2] ~psfile_header(t1) 
        repeat 
        loop for t1 = 1 to finums
          putf [2] %=~time_stamps(t1) 
        repeat 
        putf [2] %%EndComments 
        putf [2] 
        putf [2] %%BeginProlog 
        putf [2] %%EndProlog 
        putf [2] 
        putf [2] %%BeginSetup 
        putf [2] 
        putf [2] % This is the PD dictionary 
        putf [2] % ========================= 
        loop for t3 = 1 to pd_cnt 
          tget [PD,t3] temp 
          putf [2] ~temp 
        repeat 
        putf [2] % =========================== 
        putf [2] 
        putf [2] % This is the SD dictionary 
        putf [2] % ========================= 
        loop for t3 = 1 to sd_cnt 
          tget [SD,t3] temp 
          putf [2] ~temp 
        repeat 
        putf [2] % =========================== 
        putf [2] 
        putf [2] %%EndSetup 
        putf [2] 
        loop for t3 = 1 to ppt_cnt 
          tget [PPT,t3] temp 
          putf [2] ~temp 
        repeat 
        putf [2] 
        putf [2] %%Trailer 
        putf [2] %%BoundingBox: ~temp2 
        putf [2] %%HiResBoundingBox: ~temp3 
        putf [2] 
        if (Addfiles & 0x01) = 0x01 
          loop for t1 = 1 to finums 
            loop for t2 = 1 to finums 
              if part_order(t2) = t1 
                t3 = t2 
                t2 = finums 
              end 
            repeat 
            t4 = fioffs(t3) - 4 
            putf [2] %=BeginMuseData: ~t1 
            loop for t5 = 1 to 100000 
              tget [FI,t4] line 
              ++t4 
              line = line // pad(4) 
              if line = "/END" 
                t5 = 100000 
              end 
              line = trm(line) 
              putf [2] %=~line 
            repeat 
            putf [2] %=EndMuseData: ~t1 
          repeat 
        end 
        putf [2] 
        putf [2] %%EOF
        putf [2] 

        close [2] 
#else 
        putc %!PS-Adobe-3.0 
        loop for t1 = 1 to 10 
          putc ~psfile_header(t1) 
        repeat 
        loop for t1 = 1 to finums   
          putc %=~time_stamps(t1) 
        repeat 
        putc %%EndComments 
        putc 
        putc %%BeginProlog 
        putc %%EndProlog 
        putc 
        putc %%BeginSetup 
        putc 
        putc % This is the PD dictionary 
        putc % ========================= 
        loop for t3 = 1 to pd_cnt 
          tget [PD,t3] temp 
          putc ~temp 
        repeat 
        putc % =========================== 
        putc 
        putc % This is the SD dictionary 
        putc % ========================= 
        loop for t3 = 1 to sd_cnt 
          tget [SD,t3] temp 
          putc ~temp 
        repeat 
        putc % =========================== 
        putc 
        putc %%EndSetup 
        putc 
        loop for t3 = 1 to ppt_cnt 
          tget [PPT,t3] temp 
          putc ~temp 
        repeat 
        putc 
        putc %%Trailer 
        putc %%BoundingBox: ~temp2 
        putc %%HiResBoundingBox: ~temp3 
        putc 
        if (Addfiles & 0x01) = 0x01 
          loop for t1 = 1 to finums 
            loop for t2 = 1 to finums 
              if part_order(t2) = t1 
                t3 = t2 
                t2 = finums 
              end 
            repeat 
            t4 = fioffs(t3) - 4 
            putc %=BeginMuseData: ~t1 
            loop for t5 = 1 to 100000 
              tget [FI,t4] line 
              ++t4 
              line = line // pad(4) 
              if line = "/END" 
                t5 = 100000 
              end 
              line = trm(line) 
              putc %=~line 
            repeat 
            putc %=EndMuseData: ~t1 
          repeat 
        end 
        putc 
        putc %%EOF 
        putc 
#endif 
      return 
&dA 
&dA &d@   End of processing music data 
&dA 
