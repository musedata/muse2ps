
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
&dA &d@³P* 39. load_font_stuff                                                        ³
&dA &d@³                                                                              ³
&dA &d@³    Operation:  This procedure runs only once in this program.                ³
&dA &d@³                It loads the fontspac string from data provided               ³
&dA &d@³                It loads the kernfile string from data provided               ³
&dA &d@³                                                                              ³
&dA &d@³    Inputs:     provided inside the procedure                                 ³
&dA &d@³                                                                              ³
&dA &d@³    Output:     18000 byte fontspac string                                    ³
&dA &d@³                                                                              ³
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
      procedure load_font_stuff 
        str newXFstr.19(12) 
        str ks.4000 

        str temp.800 
        str blanks.32 
        int gg,hh,ii,jj,kk 
        int ksleng 
        int font 
        int t1,t2 
        int a1 
&dA 
&dA &d@    Step 1: Do fontspac and mfontspac 
&dA 
        open [8,8] gfontspac 
        len(fontspac) = sze 
        read [8] fontspac 
        close [8] 
        open [8,8] gmfontspac 
        len(mfontspac) = sze 
        read [8] mfontspac 
        close [8] 
        loop for gg = 1 to 12 
          jj = 32 
          loop for hh = 1 to 196 
            ii = (gg - 1) * 200 + hh 
            Mfontinc(gg,jj) = ors(mfontspac{ii}) 
            ++jj 
            if jj = 132 
              jj = 160 
            end                   
          repeat 
        repeat 
&dA 
&dA &d@    Step 2: Do kernmaps 
&dA 
        open [8,8] gkernspac 
        len(ks) = sze 
        read [8] ks 
        close [8] 

        ksleng = len(ks) 
        blanks = "                                " 

        loop for font = 1 to 30 
          gg = (font - 1) * 4 + 1 
          temp = ks{gg,4} 
          gg = int(temp) 
          gg += 121             /* jump over the offset section 

          temp = "" 
LF_B: 
          hh = ors(ks{gg}) 
          if bit(6,hh) = 1 
            jj = hh & 0x1f 
            if bit(5,hh) = 1 
              temp = temp // blanks{1,jj} // "1" 
            else 
              temp = temp // blanks{1,jj} // "0" 
            end 
          else 
            temp = temp // blanks{1,31} 
          end 
          if len(temp) < 676 and gg < ksleng 
            ++gg 
            goto LF_B 
          end 
          temp = temp // pad(700) 
          temp = temp{1,676} 

          gg = 0 
          loop for t1 = 1 to 26 
            loop for t2 = 1 to 26 
              ++gg 
              if temp{gg} = " " 
                all_real_kernmaps(font,t1,t2) = 0 
              end 
              if temp{gg} = "0" 
                all_real_kernmaps(font,t1,t2) = 1 
              end 
              if temp{gg} = "1" 
                all_real_kernmaps(font,t1,t2) = -1 
              end 
            repeat 
          repeat 
        repeat 

        loop for t1 = 27 to 52 
          loop for t2 = 1 to 26 
            kernmap(t1,t2) = 0 
          repeat 
        repeat 
&dA 
&dA &d@    Step 3: Load the hitestr stuff 
&dA 
        hitestr = "$&#(,&*.'+/(,1).3*/5+06,29.4</5=07?19B2<F4>I6AL7BL8FQ:GS;HU=IV>LZ@N]ATdFYkK]pM]qObwSp‰\p‰\"
        hitestr = hitestr // "+/(+/(+/(+/(.4).4*/5+16,18-4:.5</7=08?1;C3>F5?J6AL7DO9EQ:HS<HV=LX?M\AQaEUgHZjK]nMbuQl…Zl…Z"
        hitestr = hitestr // ",0(,0(,0(,0(-2).4*/5+18,4;.5=/7?08A19B2<G4?J6@L8AL9DP;FS<GT>JY?M]AN]BScFYmJ[lL^tNcwRp‰\p‰\"
&dA 
&dA &d@    Step 4: Do newfont_init stuff 
&dA 
        revsizes(1)  = 1 
        revsizes(2)  = 1 
        revsizes(3)  = 1 
        revsizes(4)  = 1 
        revsizes(5)  = 2 
        revsizes(6)  = 3 
        revsizes(7)  = 4 
        revsizes(8)  = 5 
        revsizes(9)  = 6 
        revsizes(10) = 6 
        revsizes(11) = 7 
        revsizes(12) = 7 
        revsizes(13) = 8 
        revsizes(14) = 8 
        revsizes(15) = 9 
        revsizes(16) = 9 
        revsizes(17) = 10 
        revsizes(18) = 10 
        revsizes(19) = 10 
        revsizes(20) = 11 
        revsizes(21) = 11 
        revsizes(22) = 11 
        revsizes(23) = 12 
        revsizes(24) = 12 

        newXFstr(1)  = "33Qo3Qo4Rp5Sq6Tr8Vt"   /* "  51  51  81 111  51  81 111  52  82 112  53  83 113  54  84 114  56  86 116"
        newXFstr(2)  = "34Rp5Sq6Tr7Us8Vt:Xv"   /* "  51  52  82 112  53  83 113  54  84 114  55  85 115  56  86 116  58  88 118"
        newXFstr(3)  = "36Tr7Us8Vt9Wu:Xv<Zx"   /* "  51  54  84 114  55  85 115  56  86 116  57  87 117  58  88 118  60  90 120"
        newXFstr(4)  = "47Us9Wu:Xv;Yw<Zx?]{"   /* "  52  55  85 115  57  87 117  58  88 118  59  89 119  60  90 120  63  93 123"
        newXFstr(5)  = "59Wu:Xv;Yw=[y>\z@^|"   /* "  53  57  87 117  58  88 118  59  89 119  61  91 121  62  92 122  64  94 124"
        newXFstr(6)  = "7;Yw=[y?]{@^|A_}Db€"   /* "  55  59  89 119  61  91 121  63  93 123  64  94 124  65  95 125  68  98 128"
        newXFstr(7)  = "9>\z@^|A_}CaEcHf„"   /* "  57  62  92 122  64  94 124  65  95 125  67  97 127  69  99 129  72 102 132"
        newXFstr(8)  = ":@^|B`~Db€Fd‚Hf„Jh†"   /* "  58  64  94 124  66  96 126  68  98 128  70 100 130  72 102 132  74 104 134"
        newXFstr(9)  = "<CaEcGeƒIg…Jh†Ljˆ"   /* "  60  67  97 127  69  99 129  71 101 131  73 103 133  74 104 134  76 106 136"
        newXFstr(10) = "=EcGeƒIg…Jh†Ki‡NlŠ"   /* "  61  69  99 129  71 101 131  73 103 133  74 104 134  75 105 135  78 108 138"
        newXFstr(11) = "@Hf„Jh†Ki‡Mk‰NlŠOm‹"   /* "  64  72 102 132  74 104 134  75 105 135  77 107 137  78 108 138  79 109 139"
        newXFstr(12) = "AJh†Ki‡Mk‰NlŠOm‹PnŒ"   /* "  65  74 104 134  75 105 135  77 107 137  78 108 138  79 109 139  80 110 140"

        loop for t1 = 1 to 12 
          loop for t2 = 1 to 19 
            XFonts(t1,t2) = ors(newXFstr(t1){t2}) 
          repeat 
        repeat 

        loop for a1 = 1 to 24 
          revmap(a1) = revsizes(a1) 
        repeat 
        loop for a1 = 1 to 12 
          revmap(100+a1) = a1 + BEAM_OFFSET 
        repeat 
        revmap(114)     = 13 + BEAM_OFFSET 

        revmap(98) = 48 
        revmap(99) = 49 
        revmap(100) = 50 
      return 
