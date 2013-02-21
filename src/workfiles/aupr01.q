
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P*  1. my_autoset                                               ³ 
&dA &d@³                                                                ³ 
&dA &d@³    Input: from source file                                     ³ 
&dA &d@³                                                                ³ 
&dA &d@³    Output: QQ table -> my_mskpage                              ³ 
&dA &d@³                                                                ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure my_autoset 
        str pgroup.12 
        str temp5.20 
        str mname.60,wname.80,partname.80 
        str zparxx.120(25)
        str temp_time_stamp.80 
        str trecords.120(20) 

        int time_stamp_loc 
        int g,m 
        int rc 
        int t1,t2,t3,t4,t5,t6
        int kk,ii 
        int f1,f2,f3,f4 
        int aa3,aa4,aa5,aa6,aa7,aa8,aa10 
        int sugg_flg,sugg_flg2 
        int mrest 
        int repeater_flag 
        int font_changes(10,2),changecnt 
        int fize,ficnt,read_state 
        int restplace 
        int cfactor 
        int wrest 
        int restoff 
        int text_flag 
        int text_loc 
        str LL.1 
        int irest_flag 
        int mreport_flag 
        int barnum2 

        int sys_data(32,4) 
&dA 
&dA &d@  initialization of parameters 
&dA &d@  ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ 
&dA 
        notesize = Notesize 
        mtfont = 31 
        tword_height = 6 
        twfont = 34 
        cfactor = Cfactor 
        sizenum = revsizes(notesize) 

        bvpar(16) = 3 * notesize 
        bvpar(17) = notesize / 2 
        bvpar(18) = 30 * notesize / 16 
        bvpar(20) = notesize / 2 + 1 / 2 
        bvpar(22) = 6 * notesize / 16 
        bvpar(23) = 9 * notesize / 16 
        bvpar(24) = 7 * notesize / 16 
        bvpar(25) = 22 * notesize / 16 
        bvpar(26) = 27 * notesize / 16 
        bvpar(29) = 38 * notesize / 16 
        bvpar(30) = 3 * notesize - 8 / 16 
        bvpar(31) = notesize / 2 + 1 
        bvpar(32) = notesize * 8 + 4 / 10 
        bvpar(33) = notesize * 12 + 10 / 14 
        bvpar(34) = notesize - 3 / 9 
        bvpar(35) = notesize / 3 

        curfont = 0
        zcnt = 0 
&dA 
&dA &d@  initialization 
&dA &d@  ÍÍÍÍÍÍÍÍÍÍÍÍÍÍ 
&dA 
&dA &d@    Vertical and horizontal parameters 
&dA &d@    ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
&dA &d@   for notesize = 6 
        zparxx(1)  = "-0369<?BEH+,9,5.,-,24+B9******/*4**.*I/<3399ZBf3T003633233333763.f-,32+*-,3124+*218,..-,----,,-*****"
        zparxx(2)  = "V***************************************************************************************************"
        zparxx(3)  = "0116,87@03/1+>73.6-3.-55S..+-7374*:+30H0-2.--1/5+*10/,*H+1*452/101004/5431./32+--246-:61++05++,-3/*2"
        zparxx(4)  = "1.+.1,+231///../---**/3.0-6-6/6.4.3-1/11,938********************************************************"
        zparxx(5)  = "ªÆ­¹©¶ª«¬-&--&-'.'.'." 

&dA &d@   for notesize = 14 
        zparxx(6)  = "18?FMT[bip-0N0D5/10=A-bM******6*A**4,s7T??MMšb¶?Œ88?F??<?????IF?5¶2/?<,+0/?;=B,+=;K/220/1101-./*****"
        zparxx(7)  = "***************************************************************************************************"
        zparxx(8)  = "8<9G/KH^9?7:-ZH?3F1?42DDŠ54.1I?JC+P.?9p82=40/;6D.*:85.*H-:*AC=6<9977@5@@>845?<,01=BF0PE9-,7C,..1?5+<"
        zparxx(9)  = ";4,3;-+<?9466225001**5?271G2E4E3A3?1949;/H?I********************************************************"
        zparxx(10) = "ªÆ­¹©¶ª«¬-&--&-'.'.'." 

&dA &d@   for notesize = 16 
        zparxx(11) = "2:BJRZbjrz.1T1H7031@E.jR******8*D**6,~9ZBBRRªjÊBš::BJBB?BBBBBNJB7Ê30B?,+10B>@E,+@>O033101112-/0*****"
        zparxx(12) = "ž***************************************************************************************************"
        zparxx(13) = ";><H0PMf:B9=.aMC5K2B64HH˜76/3NBOG,V0C<z;4@610>8H/*<:7.*H-<*DG@8>;;99D7DCB;46B?-12@EJ1UI;.,9F-/.2A6+?"
        zparxx(14) = ">5,4>.+?B<6:9337112**6B392K3I6I5D5B2;5;=/LCN********************************************************"
        zparxx(15) = "ªÆ­¹©¶ª«¬-&--&-'.'.'." 

&dA &d@   for notesize = 18 
        zparxx(16) = "3<ENW`ir{„.1Y1K8041BH.rW******:*H**7,ˆ:`EEWWºrÞE¨<<ENEEBEEEEERNE8Þ41EA,+21E@BI,+B@U144212223.01*****"
        zparxx(17) = "­***************************************************************************************************"
        zparxx(18) = "=@>J0TQm<E:?.gQF6O3E75KK¥87/4RESJ,[2F>„=5B710@9K/*><8/*H.>*GKD9@>=::F9FFD=58EB.24DJP2[M>.-;J.//4C8,B"
        zparxx(19) = "A7-6@/,AE=8;:449223**8E4;3O4M7M6H6E3=6=@0QEQ********************************************************"
        zparxx(20) = "ªÆ­¹©¶ª«¬-&--&-'.'.'." 

&dA &d@   for notesize = 21 
        zparxx(21) = "4?IT^is~ˆ“/3a3Q;153FM/~^******<*M**:-˜=iII^^Ò~üI½??ITIIFIIIIIYTI9ü62JE-,32JDGN-,GD\266324435/12*****"
        zparxx(22) = "Á***************************************************************************************************"
        zparxx(23) = "@CAM1[Wx?I=B/rWJ8U4I97QQº;905YIZP,c0JA“@7F931D<Q0*B?;0*H/B*LQH<CB@<<K<KKH@7;IF.36GMU3cSA.->O.006F;,E"
        zparxx(24) = "D9-8D1,EI@9<<66;334**;I6>5U6R9R8M8J4@8@C1YJY********************************************************"
        zparxx(25) = "ªÆ­¹©¶ª«¬-&--&-'.'.'." 

        if notesize = 6 
          line = "06" 
        else 
          line = chs(notesize) 
        end 
        if "   06   14   16   18   21" con line 
          t3 = mpt - 4      /* 0,5,10,15,20 
        end 
        g = 0                          /* index into vpar and hpar 
        loop for t1 = 1 to 2 
          t5 = t1 + t3                  /* index into vpar strings 
          t2 = t1 + t3 + 2              /* index into hpar strings 
          loop for t4 = 1 to 100 
            ++g 
            t6 = ors(zparxx(t5){t4}) 
            vpar(g) = t6 - 42 
            t6 = ors(zparxx(t2){t4}) 
            hpar(g) = t6 - 42 
          repeat 
        repeat 

        vpar20 = 2 * vpar(10) 

#if CUSTOM_PAR 
        if notesize = 14 
          vpar(101) = 111 
        end 
        if notesize = 16 
          vpar(101) = 126 
        end 
        if notesize = 18            /* size-18 added &dA12/18/04&d@ 
          vpar(101) = 141 
        end 
        if notesize = 21 
          vpar(101) = 171 
        end 
#endif 

&dA 
&dA &d@    Other parameters and variables 
&dA &d@    ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA 
        t3 += 5                    /* t3 -> last relevant string 
        g = 0 
        loop for t1 = 1 to 9 
          ++g 
          t6 = ors(zparxx(t3){g}) 
          wak(t1) = t6 - 42 
        repeat 
        loop for t1 = 1 to 2 
          loop for t2 = 1 to 6 
            ++g 
            t6 = ors(zparxx(t3){g}) 
            zak(t1,t2) = t6 - 42 
          repeat 
        repeat 

        slurstr = "FpmFjoiOlpmFooiOphpFokoiffnFggnHFfFFIgGJcceBdddQBaAPEdQQcbeedddM"
        slurstr = slurstr // "KaNKddNMBaAAECCDlpmFIGGOlpmFOGOOphpFoiGHffnFggNH"
        slurstr = slurstr // "FfFFIgGJcceBECQQcdeAECQQcbeeddLMKaNKMdNMAaAAECCD"
        slurunder = "FHHFIGOOFHHFIGOOFNFFINGGFFNFIGNHFFFFIGGJBBBBECCQ" 
        slurunder = slurunder // "BBBBECCQKCKKQNLMKKNKMLNMBKAAECCD" 
        slurover  = "lpppjoiolpppjoiophppokoiffnrggngffsngggncceedddd" 
        slurover  = slurover  // "cceeddddcbeeddddcanaddndcaendddn" 
&dA 
&dA &d@   Meaning of curvedata:  Curvedata is meant to describe the  
&dA &d@   approximate shape of slurs for various situations.  The slurs 
&dA &d@   begin described are (flat) tips down.  The end points are         
&dA &d@   assumed to be 0 and are therefore not included.  A slur between 
&dA &d@   two notes need not be described, so that the first relevant 
&dA &d@   description is a slur between three notes.     
&dA 
&dA &d@   The first dimension of curvedata contains the number of notes  
&dA &d@   under the slur (not counting the end points).  The second 
&dA &d@   dimension contains a number representing the curvature of the 
&dA &d@   slur (from 1 to 4).  The third dimension contains the specific 
&dA &d@   note number for the height data.  This number will range from 
&dA &d@   1 to the number of notes under the slur (not counting the end 
&dA &d@   points).  
&dA 


&dA 
&dA &d@   Curvedata for notesize = 14 
&dA 
        curvedata(1,1,1) = 10 
        curvedata(1,2,1) = 14 
        curvedata(1,3,1) = 18 
        curvedata(1,4,1) = 22 

        curvedata(2,1,1) =  8 
        curvedata(2,2,1) = 12 
        curvedata(2,3,1) = 16 
        curvedata(2,4,1) = 20 

        curvedata(3,1,1) = 10 
        curvedata(3,1,2) = 12 
        curvedata(3,2,1) = 12 
        curvedata(3,2,2) = 16 
        curvedata(3,3,1) = 14 
        curvedata(3,3,2) = 20 
        curvedata(3,4,1) = 17 
        curvedata(3,4,2) = 24 

        curvedata(4,1,1) =  9 
        curvedata(4,1,2) = 12 
        curvedata(4,2,1) = 11 
        curvedata(4,2,2) = 16 
        curvedata(4,3,1) = 13 
        curvedata(4,3,2) = 20 
        curvedata(4,4,1) = 16 
        curvedata(4,4,2) = 24 

        curvedata(5,1,1) =  8 
        curvedata(5,1,2) = 13 
        curvedata(5,1,3) = 14 
        curvedata(5,2,1) = 11 
        curvedata(5,2,2) = 16 
        curvedata(5,2,3) = 18 
        curvedata(5,3,1) = 13 
        curvedata(5,3,2) = 19 
        curvedata(5,3,3) = 21 
        curvedata(5,4,1) = 16 
        curvedata(5,4,2) = 24 
        curvedata(5,4,3) = 25 

        curvedata(6,1,1) =  8 
        curvedata(6,1,2) = 12 
        curvedata(6,1,3) = 14 
        curvedata(6,2,1) = 11 
        curvedata(6,2,2) = 16 
        curvedata(6,2,3) = 18 
        curvedata(6,3,1) = 13 
        curvedata(6,3,2) = 20 
        curvedata(6,3,3) = 22 
        curvedata(6,4,1) = 16 
        curvedata(6,4,2) = 24 
        curvedata(6,4,3) = 25 

        curvedata(7,1,1) =  7 
        curvedata(7,1,2) = 11 
        curvedata(7,1,3) = 14 
        curvedata(7,1,4) = 15 
        curvedata(7,2,1) = 11 
        curvedata(7,2,2) = 16 
        curvedata(7,2,3) = 18 
        curvedata(7,2,4) = 19 
        curvedata(7,3,1) = 14 
        curvedata(7,3,2) = 20 
        curvedata(7,3,3) = 22 
        curvedata(7,3,4) = 23 
        curvedata(7,4,1) = 16 
        curvedata(7,4,2) = 24 
        curvedata(7,4,3) = 26 
        curvedata(7,4,4) = 27 

        curvedata(8,1,1) =  7 
        curvedata(8,1,2) = 11 
        curvedata(8,1,3) = 14 
        curvedata(8,1,4) = 15 
        curvedata(8,2,1) = 11 
        curvedata(8,2,2) = 16 
        curvedata(8,2,3) = 18 
        curvedata(8,2,4) = 19 
        curvedata(8,3,1) = 14 
        curvedata(8,3,2) = 20 
        curvedata(8,3,3) = 22 
        curvedata(8,3,4) = 23 
        curvedata(8,4,1) = 16 
        curvedata(8,4,2) = 24 
        curvedata(8,4,3) = 26 
        curvedata(8,4,4) = 27 

        loop for c1 = 2 to 8 
          loop for c2 = 1 to 4 
            c4 = c1 + 1 / 2 + 1 
            c5 = 1 
            loop for c3 = c1 to c4 step -1 
              curvedata(c1,c2,c3) = curvedata(c1,c2,c5) 
              ++c5 
            repeat 
          repeat 
        repeat 
&dA 
&dA &d@   Scale for notesize = 6 
&dA 
        if notesize = 6 
          loop for c1 = 1 to 8 
            loop for c2 = 1 to 4 
              loop for c3 = 1 to 8 
                curvedata(c1,c2,c3) = curvedata(c1,c2,c3) * 3 + 3 / 7 
              repeat 
            repeat 
          repeat 
        end 
&dA 
&dA &d@   Scale for notesize = 21 
&dA 
        if notesize = 21 
          loop for c1 = 1 to 8 
            loop for c2 = 1 to 4 
              loop for c3 = 1 to 8 
                curvedata(c1,c2,c3) = curvedata(c1,c2,c3) * 21 + 7 / 14 
              repeat 
            repeat 
          repeat 
        end 
&dA 
&dA &d@   Scale for notesize = 18        &dA12/18/04&d@ 
&dA 
        if notesize = 18 
          loop for c1 = 1 to 8 
            loop for c2 = 1 to 4 
              loop for c3 = 1 to 8 
                curvedata(c1,c2,c3) = curvedata(c1,c2,c3) * 18 + 7 / 14 
              repeat 
            repeat 
          repeat 
        end 
&dA 
&dA &d@   Scale for notesize = 16        &dA12/31/08&d@ 
&dA 
        if notesize = 16 
          loop for c1 = 1 to 8 
            loop for c2 = 1 to 4 
              loop for c3 = 1 to 8 
                curvedata(c1,c2,c3) = curvedata(c1,c2,c3) * 16 + 7 / 14 
              repeat 
            repeat 
          repeat 
        end 

&dA*   End of Initialization of parameters     
        psfile_header(4) = "" 
        pgroup = "" 
        read_state = 0 
        ficnt = 0 
        finums = 0 
        t3 = 0         /* t3 contains the valid part counter 
        ii = 0         /* ii is the counter in the source 

NEXT_FTEST: 
&dA 
&dA &d@    You are (supposedly) at the top of a MuseData file 
&dA 
&dA &d@    Step 1: Determine (1) Are the first 11 lines in the proper format?  
&dA &d@                      (2) To how many groups does this file belong?  
&dA &d@                      (3) Does this file belong to the target group "Group"?
&dA 
        t1 = 1         /* This is the counter for trecords 
        ++ii 
        if ii > urcnt 
          goto EOS 
        end 
        tget [UR,ii] line 
        line = line // pad(2) 

        if line{1} = "&" 
          t1 = 0 
          loop 
            ++ii 
            if ii > urcnt 
              goto EOS 
            end 
            tget [UR,ii] line 
            line = line // pad(2) 
          repeat while line{1} <> "&" 
          t1 = 1 
          ++ii 
          if ii > urcnt 
            goto EOS 
          end 
          tget [UR,ii] line 
          line = line // pad(2) 
        end 
        if line{1,2} = "//" 
          goto EOS 
        end 
        if line{1} = "/" 
          tmess = 13 
          pute Top record = ~line 
          perform dtalk (tmess) 
        end 
        line = trm(line) 
        if line <> "" 
          if psfile_header(4) = "" 
            line = line // pad(100) 
            line = line{1,100} 
            line = trm(line) 
            psfile_header(4) = "%%Copyright: " // line 
          end 
        end 
        trecords(t1) = line 
&dA 
&dA &d@    Now read records 2 to 11 
&dA 
        loop for t1 = 2 to 11 
          ++ii 
          if ii > urcnt 
            tmess = 13 
            perform dtalk (tmess) 
          end 
          tget [UR,ii] line 
          line = line // pad(2) 
          if line{1} = "/" 
            tmess = 13 
            perform dtalk (tmess) 
          end 
          if t1 = 3 
            if line{1,6} = "TIMEST" 
              line = line // pad(80) 
              line = line{1,80} 
              temp_time_stamp = trm(line) 
            end 
          end 
          if t1 = 5 
            if line{1,3} <> "WK#" 
              pute Record 5 should, but does not, begin with "WK#" 
              pute Record 5 = ~line 
              tmess = 13 
              perform dtalk (tmess) 
            end 
          end 
          if t1 = 11 
            if line{1,18} = "Group memberships:" 
              line = line{19..} 
              line = mrt(line) 
              line = trm(line) 
              line = lcs(line) 
              line = line // " " 
&dA &d@              
&dA &d@       Determine here the number of groups (t5) 
&dA &d@              
              t4 = 1                          /* pointer into "line" 
              t5 = 0                          /* this will be the number of groups
              loop 
                t2 = t4                       /* this serves as just a local pointer
                loop while line{t4} in ['a'..'z'] 
                  ++t4 
                repeat 
                if t4 > t2 
                  ++t5                        /* increment the number of groups
                end 
                ++t4 
              repeat while t4 < len(line) 
              if line con Group 
                pgroup = Group 
                ++t3                          /* increment the valid part counter
              else 
&dA 
&dA &d@        Go wild.  Get all records until you reach 
&dA &d@          "/END" or "/eof", depending on the flag 
&dA 
                read_state = 1 
                loop 
                  ++ii 
                  if ii > urcnt 
                    goto EOS 
                  end 
                  tget [UR,ii] line 
                  line = line // pad(4) 
                  if line{1} = "/" 
                    if eof_flag = 0 
                      if line{1,4} = "/eof" 
                        read_state = 0 
                        goto NEXT_FTEST 
                      end 
                    else 
                      if line{1,4} = "/END" 
                        read_state = 0 
                        goto NEXT_FTEST 
                      end 
                    end 
                  end 
                repeat 
              end 
            else 
              pute Record 11 should, but does not, begin with "Group memberships:"
              pute Record 11 = ~line 
              tmess = 13 
              perform dtalk (tmess) 
            end 
          end 
          trecords(t1) = line 
        repeat 
&dA 
&dA &d@    Your data has passed the first test 
&dA 
&dA &d@    Step 2: Begin build (adding onto) the source table 
&dA 
        loop for t1 = 1 to 4 
          ++ficnt 
          tput [FI,ficnt] ~trecords(t1) 
        repeat 
        fioffs(t3) = ficnt + 1 
        loop for t1 = 5 to 10 
          ++ficnt 
          tput [FI,ficnt] ~trecords(t1) 
        repeat 
        ++ficnt 
        tput [FI,ficnt] Group memberships: ~pgroup 

        read_state = 2
        loop for t4 = 1 to t5 
          ++ii 
          if ii > urcnt 
            goto EOS 
          end 
          tget [UR,ii] line 
          if line con ":" 
            if line{1,mpt-1} = pgroup 
              ++ficnt 
              tput [FI,ficnt] ~line 
              line = line{mpt..}         /* need this because of group name "parts"
              if line con "part" 
                line = line{mpt+5..} 
                part_order(t3) = int(line) 
                if line con "of" 
                  line = line{mpt+3..} 
                  t6 = int(line) 
                  if finums = 0 
                    finums = t6 
                  else 
                    if finums <> t6 
                      tmess = 17 
                      perform dtalk (tmess) 
                    end 
                  end 
                else 
                  tmess = 17 
                  perform dtalk (tmess) 
                end 
                time_stamp_loc = part_order(t3) 
                if temp_time_stamp <> "" 
                  time_stamps(time_stamp_loc) = temp_time_stamp 
                else 
                  time_stamps(time_stamp_loc) = "TIMESTAMP: <none>" 
                end 
              else 
                tmess = 15 
                perform dtalk (tmess) 
              end 
            end 
          else 
            tmess = 15 
            perform dtalk (tmess) 
          end 
        repeat 

        read_state = 3 
        loop 
          ++ii 
          if ii > urcnt 
            goto EOS 
          end 
          tget [UR,ii] line 
          ++ficnt 
          tput [FI,ficnt] ~line 

          if line{1} = "/" 
            if eof_flag = 0 
              if line{1,4} = "/eof" 
                read_state = 0 
                goto NEXT_FTEST 
              end 
            else 
              if line{1,4} = "/END" 
                read_state = 0 
                goto NEXT_FTEST 
              end 
            end 
          end 
        repeat 
EOS: 
        if read_state = 0 
          if t1 <> 1 
&dA 
&dA &d@      This is an error, because you ran out of records 
&dA &d@      while reading the 11 header records of a MuseData file 
&dA 
            putc Last record = ~line 
            tmess = 13 
            perform dtalk (tmess) 
          end 
        end 

        if read_state = 1 
&dA 
&dA &d@      This is an error, because you ran out of records 
&dA &d@      while reading a non-group file 
&dA 
          tmess = 14 
          perform dtalk (tmess) 
        end 

        if read_state = 2 
&dA 
&dA &d@      This is an error, because the group part records 
&dA &d@      doesn't match the group membership set 
&dA 
          tmess = 15 
          perform dtalk (tmess) 
        end 

        if read_state = 3 
&dA 
&dA &d@      This is an error, because you ran out of records 
&dA &d@      before finding a MuseDate module termination record 
&dA 
          tmess = 16 
          perform dtalk (tmess) 
        end 

        fize = ficnt 
        if t3 <> finums 
          tmess = 17 
          perform dtalk (tmess) 
        end 
&dA 
&dA &d@   Set job_type for selective print suggestions 
&dA 
        if "sound^short^parts^score^skore^data^" con pgroup 
          t4 = mpt / 6 + 1 
          job_type = ".tpskd"{t4}    /* &dA03/10/09&d@ Expanding job_type to include
        end                          /*          k = skore (conductor's score)

        if job_type = "p"            /* setting multirest_flag  &dA03/04/06&d@ 
          multirest_flag = 1 
        else 
          multirest_flag = 0 
        end 

        f1 = 1 
        f2 = finums 
        f3 = f1 
        Nparts = finums 
&dA 
&dA &d@   Check for a complete set of tracks 
&dA 
        t3 = 0 
        loop for t1 = f1 to f2 
          if part_order(t1) > t3 
            t3 = part_order(t1) 
          end 
        repeat 
        if t3 <> f2 
          if t3 < f2 
            tmess = 18 
            perform dtalk (tmess) 
          else 
            tmess = 19 
            perform dtalk (tmess)
          end 
        end 
BIG:  
        m_number = 0 
        tuflag = 0 
        loop for t1 = 1 to MAX_STAFF 
          c8flag(t1) = 0 
          transflag(t1) = 0 
        repeat 

        loop for t1 = 1 to MAX_PASS     /* ctrflag(.) is an array as of &dA12/08/07
          ctrflag(t1) = 0 
        repeat 

        loop for t1 = 1 to 4 
          loop for t2 = 1 to MAX_PASS 
            loop for t3 = 1 to BM_SZ    /* New size parameter &dA05/14/03&d@ 
              beampar(t1,t2,t3) = 0 
            repeat 
          repeat 
        repeat 
        outslurs = "00000000"          /* clear all pending slur flags 
        snum = 0 
        esnum = 0 
        loop for t2 = 1 to MAX_PASS 
          tsnum(t2) = 0 
          pre_tsnum(t2) = 0 
        repeat 
        measnum = 0 
        sct = 0                 /* necessary so that ts(.,.) will be completely cleared
        maxsct = 0 
        oldsct = 0 
        supcnt = 0 
        inctype = 0 
        vflag = 1 
        granddist = Granddist * notesize + 5 / 10 
        global_tpflag = 0 
        tpflag = 0 
        textconflag = OFF 
        restplace = 0 
        fix_next_inctype = 0 
        mdirfont = DEFAULT_MDIRFONT 
        dtivfont = DEFAULT_DTIVFONT 
&dA 
&dA &d@       Code added &dA09/22/03&d@ for more complete initialization of variables 
&dA 
        key = 0 
        loop for t1 = 1 to 50 
          claveax(t1) = 0 
          loop for t2 = 1 to 4          /* &dA06/04/08&d@ was 3 
            measax(t2,t1) = claveax(t1) 
          repeat 
        repeat 

        restoff = 0 
        text_flag = 0 
        text_loc = vpar(101) 
        art_flag = 0 
        single_line = 0 
        stem_change_flag = 0 
        dot_difference_flag = 0 
        irest_flag = 0 
        mreport_flag = 0 
        key_reprint_flag = 0 
        mixed_note_head_flag = 0 
        suppress_key     = 0 
        min_space = hpar(29) * Min_space / 100 
        slur_adjust = 0 
        in_line_edslur = 0 
        large_clef_flag = 0 
        rest_collapse = TRUE 

*********** Transfer file to Data Table ***********
 
        t3 = 0 
        loop for t1 = 1 to finums 
          if part_order(t1) = f3 
            t3 = t1 
            t1 = finums 
          end 
        repeat 
        if t3 = 0 
          if (Debugg & 0x01) > 0 
            pute Unable to locate part ~f3  in the data set 
          end 
          tmess = 11 
          perform dtalk (tmess) 
        end 

        kk = fioffs(t3)      

&dK &d@       putc 
&dK &d@       putc &dEListing for part ~t3  
&dK &d@       putc 
&dK 
&dK &d@       t2 = 0 
&dK &d@       loop for t1 = kk to 1000000 
&dK &d@         tget [FI,t1] line 
&dK &d@         putc .w6 ~t1   ~line 
&dK &d@         ++t2 
&dK &d@         if t2 = 20 
&dK &d@           t1 = 1000000 
&dK &d@         end 
&dK &d@         if line{1} = "/" 
&dK &d@           getc 
&dK &d@           if eof_flag = 0 
&dK &d@             if line{1,4} = "/eof" 
&dK &d@               goto STTT 
&dK &d@             end 
&dK &d@           else 
&dK &d@             if line{1,4} = "/END" 
&dK &d@               goto STTT 
&dK &d@             end 
&dK &d@           end 
&dK &d@         end 
&dK &d@       repeat 
&dKS&d@TTT: 
&dK &d@       getc 
&dK &d@       ++f3 
&dK &d@       if f3 > f2 
&dK &d@         stop 
&dK &d@       end 
&dK &d@       goto BIG 
                 
&dA 
&dA &d@   Put in first "relevant" six lines; then skip two lines 
&dA 
        loop for t1 = 1 to 6 
          tget [FI,kk] line 
          ++kk 
          tput [X,t1] ~line 
        repeat 
        kk += 2                               /* Skip group membership information

        loop 
          tget [FI,kk] line 
          ++kk 
          line = line // pad(6) 
          loop while line{1} = "&"            /* skipping comments bracketed by & records
            loop 
              tget [FI,kk] line 
              ++kk 
              line = line // pad(1) 
            repeat while line{1} <> "&" 
            tget [FI,kk] line 
            ++kk 
            line = line // pad(4) 
          repeat 
          if "Std" not_con line{1}          /* skipping Sound records, deleted records, and tags
            if line{1} = "a"                /* continuation records 
              if len(line) > 15 
                temp = line{16..} 
                tget [X,t1] line 
                line = line // temp 
                tput [X,t1] ~line 
              end 
            else 
              if line{1,2} = "Px" or line{1,2} = "Pv" 
                if line{3,3} con "m" 
                  mreport_flag = 1 
                end 
              else 
                ++t1 
                tput [X,t1] ~line 
              end 
            end 
          end 
          if line{1} = "/" 
            line = line // pad(5) 
            if line{1,5} = "/FINE" 
              loop 
                tget [FI,kk] line 
                ++kk 
                line = line // pad(4) 
              repeat while line{1,4} <> "/END" and kk <= fize 
            end 
            if line{1,4} = "/END" 
              goto LOADED 
            end 
            tmess = 20 
            perform dtalk (tmess) 
          end 
        repeat while kk <= fize 
        tmess = 21 
        perform dtalk (tmess) 

&dAÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿&d@ 
&dA³           Start Processing Data               ³&d@ 
&dAÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ&d@ 

LOADED:

        barnum2 = 1 
        ttext = "" 
        firstoff = 0 
        sigflag = 0 
        key = 0 
        loop for t1 = 1 to 50 
          claveax(t1) = 0 
        repeat 
        repeater_flag = 0 

        nstaves = 1 
* 
        tget [X,1] line 
        line = trm(line) // " " 
        if line con "MV#:" 
          temp = trm(line{mpt+4..}) 
          line = line{1,mpt-1} 
        end 
        if line con "WK#:" 
          line = trm(line{mpt+4..}) 
        end 
        tget [X,3] wname 
        tget [X,4] mname 
        tget [X,5] partname 

        if (Debugg & 0x06) > 0 
          pute Work #: ~line     .t30 Work name: ~wname 
          pute Movement: ~temp   .t30 Movement name: ~mname 
          pute Part name: ~partname 
        end 
 
        tget [X,6] out 
        out = trm(out) 
        t5 = 0 
        loop for t1 = 1 to len(out) 
          if "SATB" con out{t1} 
            t5 = text_loc                      /* New &dA01/30/05&d@ 
            text_flag = 1                      /* New &dA01/30/05&d@ 
          end 
        repeat 

        scnt = 7 
        p = 0 

        tput [Y,1] ~t5 
        tput [Y,2] J D 4 500 -120 1 6913 0 0 
        tput [Y,3] W 0 0 44 ~mname 
        outpnt = 3 

&dA                                                                              
&dA 
&dA &d@   Special case code added &dA01/06/04&d@.  Look for print suggestion tags 
&dA &d@   placed at the beginning of the file.  This &dEmust&d@ be done here for 
&dA &d@   the case of tag Y U 1.  The others follow along, but are not critical.  
&dA 
&dA &d@   Please note: &dEThis is &dANOT&dE the top of the stage2 data processing loop.&d@  
&dA 
        aa10 = scnt 
PRA: 
        tget [X,aa10] line 
        ++aa10 
        line = line // pad(80) 
        if line{1} = "P" 
          if line{2} = " " 
            sub = 2 
            goto MORE_SUGG_A 
          end 
          if line con " " 
            aa4 = sub 
            temp4 = line{2..sub} 
&dA 
&dA &d@      This notesize filter removes all P suggestions 
&dA &d@        that do not meet notesize restrictions 
&dA 
            loop for t1 = 1 to len(temp4) 
              if temp4{t1} = "#" 
                if temp4{t1,2} = "#<" 
                  a1 = int(temp4{t1+2..})      /* sets sub 
                  if notesize >= a1 
                    goto PRA                  /* This suggestion does not apply
                  end 
                  t1 = sub - 1                /* prepare t1 for next code 
                else 
                  if temp4{t1,2} = "#>" 
                    a1 = int(temp4{t1+2..})   /* sets sub 
                    if notesize <= a1 
                      goto PRA                /* This suggestion does not apply
                    end 
                    t1 = sub - 1              /* prepare t1 for next code 
                  else 
                    a1 = int(temp4{t1+1..})   /* sets sub 
                    if notesize <> a1 
                      goto PRA                /* This suggestion does not apply
                    end 
                    t1 = sub - 1              /* prepare t1 for next code 
                  end 
                end 
              end 
            repeat 

            if temp4 con job_type 
              sub = aa4 
              goto MORE_SUGG_A 
            end 
            if temp4 con "a" 
              sub = aa4 
              goto MORE_SUGG_A 
            end 
          end 
          goto PRA 

MORE_SUGG_A: 
          if line{sub..} con "C" 
            ++sub 
            rc = int(line{sub..})          /* column number 
            if line{sub} = ":" 
              ++sub                        /* skip ":" 
              g = sub 
            else 
              temp5 = "" 
              loop while line{sub} <> ":" and sub < len(line) 
                temp5 = temp5 // line{sub} 
                ++sub 
              repeat 
              if line{sub} <> ":" 
                if (Debugg & 0x01) > 0 
                  pute Incomplete print suggestion 
                  pute line = ~line 
                end 
                tmess = 11 
                perform dtalk (tmess) 
              end 
              ++sub                        /* skip ":" 
              g = sub 
              temp5 = temp5 // " " 
&dA 
&dA &d@      This notesize filter removes all P suggestions 
&dA &d@        that do not meet notesize restrictions 
&dA 
              loop for t1 = 1 to len(temp5) 
                if temp5{t1} = "#" 
                  if temp5{t1,2} = "#<" 
                    a1 = int(temp5{t1+2..})     /* sets sub 
                    if notesize >= a1 
                      loop while line{g} <> " " and g < len(line) 
                        ++g 
                      repeat 
                      sub = g                   /* skipping this suggestion 
                      goto MORE_SUGG_A 
                    end 
                    t1 = sub - 1                /* prepare t1 for next code 
                  else 
                    if temp5{t1,2} = "#>" 
                      a1 = int(temp5{t1+2..})   /* sets sub 
                      if notesize <= a1 
                        loop while line{g} <> " " and g < len(line) 
                          ++g 
                        repeat 
                        sub = g                 /* skipping this suggestion 
                        goto MORE_SUGG_A 
                      end 
                      t1 = sub - 1              /* prepare t1 for next code 
                    else 
                      a1 = int(temp5{t1+1..})   /* sets sub 
                      if notesize <> a1 
                        loop while line{g} <> " " and g < len(line) 
                          ++g 
                        repeat 
                        sub = g                 /* skipping this suggestion 
                        goto MORE_SUGG_A 
                      end 
                      t1 = sub - 1              /* prepare t1 for next code 
                    end 
                  end 
                end 
              repeat 

              if temp5 con job_type or temp5 con "a" 
              else 
                loop while line{g} <> " " and g < len(line) 
                  ++g 
                repeat 
                sub = g 
                goto MORE_SUGG_A 
              end 
            end 
&dA 
&dA &d@       Column 0: general suggestions                               
&dA 
            if rc = 0                    /* general suggestion 
              temp = "" 
              loop for a2 = g to len(line) 
                temp = temp // line{g} 
                ++g 
              repeat while line{g} <> " " 
              temp = temp // " " 
              if temp con "y" 
                a2 = mpt + 1 
                if temp{a2} in ['0'..'9'] 
                  aa3 = int(temp{a2..}) 
                  ++outpnt 
                  tput [Y,outpnt] Y U ~aa3 
                end 
              end 
            else 
              loop for a2 = g to len(line) 
                ++g 
              repeat while line{g} <> " " 
            end 
            sub = g 
            goto MORE_SUGG_A 
          end 
          goto PRA 
        end 
        if line{1} = "$" 
          goto PRA 
        end 
&dA 
&dA &d@   End of special case code &dA01/06/04&d@ 
&dA &d@   
&dA                                                             

&dA 
&dA &d@   Set movement word (if present) 
&dA 
        out = mname
        partname = trm(partname) 
&dA 
&dA &d@    New code to implement // feature in partnames &dA12/21/05&d@ 
&dA 
        if partname con "//" 
          temp3 = partname{mpt+2..} 
          partname = partname{1,mpt-1} // pad(17) 
          partname = partname // temp3 
        end 

        if partname <> "" 
          out = out // ":  " // partname 
        end 
        if out <> "" 
          oby = 0 - vpar(33) - notesize 
          obx = p + hpar(39) + hpar(5) 
          ++outpnt 
          tput [Y,outpnt] J D 1 ~obx  ~oby  1 6913 0 0 
          spn = 6913 
          ++outpnt 
          tput [Y,outpnt] W 0 -~vpar(8)  44 ~out 
        end 
        mrest = 0 
        wrest = 0 
        @n = 0 
        old@n = 0 
        xmindist = hpar(4) * cfactor                 /* New &dA12/16/03&d@ 
        mindist  = xmindist / 100                    /* New &dA12/16/03&d@ 
        minshort = Minshort 
        goto PR 

&dA                                                                       
&dA &d@                                                                     &dA 
&dA &d@                 &dAÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿&d@                   &dA 
&dA &d@                 &dA³    Process the data file      ³&d@                   &dA 
&dA &d@                 &dAÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ&d@                   &dA 
&dA &d@                                                                     &dA 
&dA                                                                       

PR: 
        tget [X,scnt] line 
        ++scnt 
        line = line // pad(80) 
        if line{1} = "@" 
          goto PR 
        end 
        rc = int(line{6,3})          /* possible duration 
        g = int(line{9,4})           /* possible measure number 
        if line{1} = "$" 
          if mrest > 0               /* this code &dAadded 1-27-93&d@ 
            perform setmrest (mrest, wrest) 
            mrest = 0 
          end 
          perform process_section (f4) 
          goto PR 
        end 

#if NO_EDIT 
        if " ABCDEFGgcri" con line{1} 
          if line{32..43} con "&" 
            temp = line{44..} 
            line = line{1..sub-1} // pad(43) 
            line = line // temp 
          end 
        end 
#endif 

&dA                                                                  
&dA  
&dA  &d@    MAIN CODE FOR PRINT SUGGESTIONS  (ends around line 4800) 
&dA  &d@  =================================== 
&dA  

        if line{1} = "P" 
&dA 
&dA &d@   Re-coding this section &dA12/16/03&d@ to add notesize select feature 
&dA &d@     and to fix the problem of consecutive suggestion records 
&dA &d@ 
          sugg_flg = 0                               /* &dA05/02/03&d@ 
          sugg_flg2 = 0                              /* &dA05/02/03&d@ 

          a1 = 1 
          loop while a1 < 10 
            ++a1 
            tget [X,scnt-a1] temp3 
          repeat while temp3{1} = "P" 

                                     /* This code added &dA02/23/97&d@ 
          if line{2} = " " 
            sub = 2 
            goto MORE_SUGG 
          end 
          if line con " " 
            aa4 = sub 
            temp4 = line{2..sub} 
&dA 
&dA &d@      This notesize filter removes all P suggestions 
&dA &d@        that do not meet notesize restrictions 
&dA 
            loop for t1 = 1 to len(temp4) 
              if temp4{t1} = "#" 
                if temp4{t1,2} = "#<" 
                  a1 = int(temp4{t1+2..})     /* sets sub 
                  if notesize >= a1 
                    goto PR                   /* This suggestion does not apply
                  end 
                  t1 = sub - 1                /* prepare t1 for next code 
                else 
                  if temp4{t1,2} = "#>" 
                    a1 = int(temp4{t1+2..})   /* sets sub 
                    if notesize <= a1 
                      goto PR                 /* This suggestion does not apply
                    end 
                    t1 = sub - 1              /* prepare t1 for next code 
                  else 
                    a1 = int(temp4{t1+1..})   /* sets sub 
                    if notesize <> a1 
                      goto PR                 /* This suggestion does not apply
                    end 
                    t1 = sub - 1              /* prepare t1 for next code 
                  end 
                end 
              end 
            repeat 

            if temp4 con job_type 
              sub = aa4 
              goto MORE_SUGG 
            end 
            if temp4 con "a" 
              sub = aa4 
              goto MORE_SUGG 
            end 
          end 
          goto PR                    /* end of &dA02/23/97&d@ addition 
&dA    


MORE_SUGG: 
          if line{sub..} con "C" 
            ++sub
            rc = int(line{sub..})        /* column number 
&dA 
&dA &d@     Code added &dA11/04/03&d@ to allow for job-specific print suggestions to 
&dA &d@     be specified by column number.  
&dA 
            if line{sub} = ":" 
              ++sub                        /* skip ":" 
              g = sub 
            else 
              temp5 = "" 
              g = sub 
              loop while line{sub} <> ":" and sub < len(line) and sub < g + 20
                temp5 = temp5 // line{sub} 
                ++sub 
              repeat 
              if line{sub} <> ":" 
                if (Debugg & 0x01) > 0 
                  pute Incomplete print suggestion.  This fault should be fixed.
                  pute index = ~(scnt+5)   line = ~line 
                end 
                tmess = 11 
                perform dtalk (tmess) 
              end 
              ++sub                        /* skip ":" 
              g = sub 
&dA 
&dA &d@   Re-coding this section &dA12/16/03&d@ to add notesize select feature 
&dA &d@ 
              temp5 = temp5 // " " 
&dA 
&dA &d@      This notesize filter removes all P suggestions 
&dA &d@        that do not meet notesize restrictions 
&dA 
              loop for t1 = 1 to len(temp5) 
                if temp5{t1} = "#" 
                  if temp5{t1,2} = "#<" 
                    a1 = int(temp5{t1+2..})     /* sets sub 
                    if notesize >= a1 
                      loop while line{g} <> " " and g < len(line) 
                        ++g 
                      repeat 
                      sub = g                   /* skipping this suggestion 
                      goto MORE_SUGG 
                    end 
                    t1 = sub - 1                /* prepare t1 for next code 
                  else 
                    if temp5{t1,2} = "#>" 
                      a1 = int(temp5{t1+2..})   /* sets sub 
                      if notesize <= a1 
                        loop while line{g} <> " " and g < len(line) 
                          ++g 
                        repeat 
                        sub = g                 /* skipping this suggestion 
                        goto MORE_SUGG 
                      end 
                      t1 = sub - 1              /* prepare t1 for next code 
                    else 
                      a1 = int(temp5{t1+1..})   /* sets sub 
                      if notesize <> a1 
                        loop while line{g} <> " " and g < len(line) 
                          ++g 
                        repeat 
                        sub = g                 /* skipping this suggestion 
                        goto MORE_SUGG 
                      end 
                      t1 = sub - 1              /* prepare t1 for next code 
                    end 
                  end 
                end 
              repeat 

              if temp5 con job_type or temp5 con "a" 
              else 
                loop while line{g} <> " " and g < len(line) 
                  ++g 
                repeat 
                sub = g 
                goto MORE_SUGG 
              end 
            end 

&dA 
&dA &d@       Column 0: general suggestions                               
&dA 
            if rc = 0                    /* general suggestion 
PQST: 
              if "acdFfghjkmnpqrstvxyz" con line{g} 
                goto PSUG(mpt) 

PSUG(1):                                               /* line{g} = "a"  (New &dA05/26/05&d@)
                art_flag = int(line{g+1..}) 
                g = sub 
                goto PQST 
PSUG(2):                                               /* line{g} = "c"  (New &dA05/12/04&d@)
                restoff = int(line{g+1..}) 
                g = sub 
                if restoff <> 0 
                  restoff = 1 
                end 
                goto PQST 
PSUG(3):                                               /* line{g} = "d"  (Modified &dA01/06/06&d@)
                aa6 = int(line{g+1..}) 
                tword_height = aa6 
                vpar(40) = vpar(2) * aa6 / 2            /* New &dA01/06/06&d@ 
                g = sub 
                goto PQST 
PSUG(4):                                               /* line{g} = "F" 
                dtivfont = int(line{g+1..}) 
                g = sub 
                goto PQST 
PSUG(5):                                               /* line{g} = "f" 
                mdirfont = int(line{g+1..}) 
                g = sub 
                goto PQST 
PSUG(6):                                               /* line{g} = "g"  (New &dA05/01/08&d@)
                slur_adjust = int(line{g+1..}) 
                g = sub 
                goto PQST 
PSUG(7):                                               /* line{g} = "h"  (New &dA11/19/07&d@)
                aa6 = int(line{g+1..}) 
                min_space = hpar(29) * aa6 / 100 
                g = sub 
                goto PQST 
PSUG(8):                                               /* line{g} = "j"  (New &dA12/20/05&d@)
                stem_change_flag = int(line{g+1..}) 
                g = sub 
                goto PQST 
PSUG(9):                                               /* line{g} = "k"  (New &dA12/24/05&d@)
                aa6 = int(line{g+1..}) 
                dot_difference_flag   = aa6 & 0x01 
                key_reprint_flag      = aa6 & 0x02      /* added &dA11/26/06&d@ 
                mixed_note_head_flag  = aa6 & 0x04      /* added &dA11/26/06&d@ 
                suppress_key          = aa6 & 0x08      /* added &dA11/02/07&d@ 
                in_line_edslur        = aa6 & 0x10      /* added &dA01/12/09&d@ 
                large_clef_flag       = aa6 & 0x20      /* added &dA02/02/09&d@ 
                g = sub 
                goto PQST 
PSUG(10):                                              /* line{g} = "m"  (New &dA03/04/06&d@)
                aa6 = int(line{g+1..}) 
                if aa6 = 1 
                  multirest_flag = 1 
                else 
                  multirest_flag = 0 
                end 
                g = sub 
                goto PQST 
PSUG(11):                                              /* line{g} = "n" 
                m_number = int(line{g+1..}) 
                g = sub 
                goto PQST 
PSUG(12):                                              /* line{g} = "p" 
                xmindist = int(line{g+1..}) * hpar(4) * cfactor / 100      /* New &dA12/16/03
                mindist  = xmindist / 100                                  /* New &dA12/16/03
                g = sub 
                perform newnsp 
                goto PQST 
PSUG(13):                                              /* line{g} = "q" 
                minshort = int(line{g+1..}) 
                g = sub 
                perform newnsp 
                goto PQST 
PSUG(14):                                              /* line{g} = "r" (New treatment &dA03/15/09&d@)
                aa6 = int(line{g+1..}) 
                restplace = aa6 & 0x01 
                irest_flag = (aa6 & 0x02) >> 1 
                rest_collapse = (aa6 & 0x04) >> 2       /* New &dA03/15/09&d@: 0 = TRUE; 1 = FALSE
                g = sub 
                goto PQST 
PSUG(15):                                              /* line{g} = "s" 
                granddist = int(line{g+1..}) 
                g = sub 
                granddist = granddist * vpar(2) + 5 / 10 
                goto PQST 
PSUG(16):                                              /* line{g} = "t" 
                global_tpflag = int(line{g+1..}) 
                g = sub 
                if global_tpflag > 4 
                  global_tpflag = 4 
                end 
                if global_tpflag < 0 
                  global_tpflag = 0 
                end 
                tpflag = global_tpflag 
                goto PQST 
&dA 
&dA &d@     This option added &dA01/30/05
&dA 
PSUG(17):                                            /* line{g} = "v" 
                aa6 = int(line{g+1..}) 
                g = sub 
                text_loc = aa6 * notesize / 20 
                tget [Y,1] temp4 
                aa6 = int(temp4) 
                temp4 = temp4 // "  " 
                temp4 = temp4{sub..} 
                temp4 = mrt(temp4) 
                tput [Y,1] ~text_loc  ~temp4 
                goto PQST 
&dA 
&dA &d@     This option added &dA01/03/04&d@; modified &dA01/06/04&d@ 
&dA 
PSUG(18):                                            /* line{g} = "x" 
                aa6 = int(line{g+1..}) 
                if (Defeat_flag & 0x01) = 0 
                  if aa6 = 1 and mrest > 0 
                    perform setmrest (mrest, wrest) 
                    mrest = 0 
                  end 
                  wrest = aa6 
                  if wrest <> 1 
                    wrest = 0 
                  end 
                end 
                g = sub 
                goto PQST 
&dA   

&dA 
&dA &d@     These options added &dA01/06/04&d@ 
&dA 
PSUG(19):                                            /* line{g} = "y" 
                aa6 = int(line{g+1..}) 
                if (Defeat_flag & 0x02) = 0 
                  ++outpnt 
                  tput [Y,outpnt] Y U ~aa6 
                end 
                g = sub 
                goto PQST 
PSUG(20):                                              /* line{g} = "z" 
                aa6 = int(line{g+1..}) 
                ++outpnt 
                if aa6 = 0 
                  tput [Y,outpnt] Y P 0 
                  g = sub 
                else 
                  g = sub 
                  temp = "" 
                  loop while line{g} <> " " and g < 80 
                    temp = temp // line{g} 
                    ++g 
                  repeat 
                  tput [Y,outpnt] Y P ~aa6  ~temp 
                end 
                goto PQST 
&dA   
              end 
              sub = g 
              goto MORE_SUGG 
            end 
&dA 
&dA &d@     Deal with record that contains: notes, grace notes, cue notes, rests, figures
&dA 
            if " ABCDEFGgcrif" con temp3{1}    /* &dA04/24/03&d@ allowing print sugg for chords
              aa3 = mpt 
&dA 
&dA &d@       Column 1: The Object itself.  NOTES, GRACE NOTES, CUE NOTES, RESTS, FIGURES
&dA 
              if rc = 1 
                if "spxXyY" con line{g}        /* "X" added &dA05/02/03&d@   "s" added &dA02/19/06
                  ++@n 
                  tcode(@n) = zpd(4) 
                  tcode(@n){1} = chr(1) 
                  tv1(@n) = P_SUGGESTION 
                  tv2(@n) = 0x0300 
                end 
ABCL: 
                if line{g} = "p" 
                  t1 = int(line{g+1..}) 
                  g = sub 
                  if t1 < 0 
                    t1 = 0 
                  end 
                  if t1 > 7 
                    t1 = 7 
                  end 
                  if t1 > 0 
                    t1 = t1 << 1 + 1 
                  end 
                  tcode(@n){1} = chr(t1) 
                  goto ABCL 
                end 
&dA 
&dA &d@        This code added &dA02/19/06&d@ to implement different shapes of note heads
&dA 
                if line{g} = "s" 
                  t1 = int(line{g+1..}) 
                  g = sub 
                  if t1 < 0 
                    t1 = 0 
                  end 
                  if t1 > 15 
                    t1 = 15 
                  end 
                  t1 <<= 4                          /* use upper part of first byte
                  aa3 = ors(tcode(@n){1}) 
                  aa3 |= t1                         /* add to what is already there
                  aa3 |= 0x01                       /* turn on "active" bit 
                  tcode(@n){1} = chr(aa3) 
                  goto ABCL 
                end 
&dA 
&dA       &d@  End of &dA02/19/06&d@ addition 

                if "xXyY" con line{g}                          /* &dA05/02/03&d@ code revised
                  aa3 = mpt 
                  if line{g+1} = "+" 
                    ++g 
                  end 
                  a2 = int(line{g+1..}) 
                  g = sub 
                  a2 += 128 
                  if a2 <= 0 
                    a2 = 1 
                  end 
                  if a2 > 255 
                    a2 = 255 
                  end 
                  aa4 = ors(tcode(@n){2})                      /* &dA05/02/03&d@ code revised
                  if aa3 < 3 
                    tcode(@n){3} = chr(a2) 
                    if aa3 = 1 
                      aa4 |= 0x01                              /* set position as "relative"
                    else 
                      aa4 |= 0x03                              /* set position as "absolute"
                    end 
                  else 
                    tcode(@n){4} = chr(a2) 
                    if aa3 = 3 
                      aa4 |= 0x01                              /* set position as "relative"
                    else 
                      aa4 |= 0x05                              /* set position as "absolute"
                    end 
                  end 
                  tcode(@n){2} = chr(aa4) 
                  goto ABCL 
                end 
                sub = g 
                goto MORE_SUGG 
              end 
&dA 
&dA &d@       Columns 18 and 19: dots and accidentals on NOTES, GRACE NOTES, CUE NOTES, and RESTS
&dA 
              if (rc = 18 or rc = 19) and aa3 < 12              /* &dA05/02/03&d@ 
                t1 = rc                         /* 18 = dots, 19 = accs 
                if "xXyY" con line{g} 
                  aa3 = mpt 
                  ++@n 
                  tcode(@n) = zpd(4) 
                  tv1(@n) = P_SUGGESTION 
                  tv2(@n) = 0x0200 + t1              /* t1 is index into position string
NXYP2: 
                  if line{g+1} = "+" 
                    ++g 
                  end 
                  a2 = int(line{g+1..}) 
                  g = sub 
                  a2 += 128 
                  if a2 <= 0 
                    a2 = 1 
                  end 
                  if a2 > 255 
                    a2 = 255 
                  end 
                  aa4 = ors(tcode(@n){2}) 
                  if aa3 < 3 
                    tcode(@n){3} = chr(a2) 
                    if aa3 = 1 
                      aa4 |= 0x01                              /* set position as "relative"
                    else 
                      aa4 |= 0x03                              /* set position as "absolute"
                    end 
                  else 
                    tcode(@n){4} = chr(a2) 
                    if aa3 = 3 
                      aa4 |= 0x01                              /* set position as "relative"
                    else 
                      aa4 |= 0x05                              /* set position as "absolute"
                    end 
                  end 
                  tcode(@n){2} = chr(aa4) 
                  if "xXyY" con line{g} 
                    aa3 = mpt 
                    goto NXYP2 
                  end 
                end 
                sub = g 
                goto MORE_SUGG 
              end 
&dA 
&dA &d@       Columns 26 to 30: beams 
&dA &d@                         
              if (rc = 26 or rc = 27) and aa3 < 11 
                if "baAc" con line{g}                  /* "c" option added &dA01/01/08
                  repeater_flag = mpt - 1 
                  if rc = 27 and repeater_flag > 0 
                    repeater_flag += 4 
                  end 
                  sub = g 
                  goto MORE_SUGG 
                end 

                if rc = 26                             /* New code &dA05/14/03&d@ 
                  t1 = 28                              /* 28 = beam stem length code
                  if line{g} = "y" 
                    ++@n 
                    tcode(@n) = zpd(4) 
                    tv1(@n) = P_SUGGESTION 
                    tv2(@n) = 0x0200 + t1              /* t1 is index into position string

                    ++g 
                    sub = g 
                    if line{sub} = "+" 
                      ++sub 
                    end 
                    a2 = int(line{sub..}) 
                    g = sub 
                    a2 += 128 
                    if a2 < 1 
                      a2 = 1 
                    end 
                    if a2 > 255 
                      a2 = 255 
                    end 
                    tcode(@n){2} = chr(a2) 
                  end 
                end 

                sub = g 
                goto MORE_SUGG 
              end 
&dA 
&dA &d@       Columns 32 to 43: ties, articulations, ornaments, dynamics, 
&dA &d@                           fermatas, technical suggestions (fingerings, etc.)
&dA 
              if rc >= 32 and rc <= 43 and aa3 < 12             /* &dA04/24/03&d@ 11 changed to 12
&dA 
&dA &d@       Slur suggestions.  Additions and modifications to code on &dA05/06/03&d@ 
&dA 
                if "([{z" con temp3{rc}                        /* start slur 1,2,3,4
                  aa5 = mpt 
                  if "ou" con line{g}    /* this is a forced slur suggestion
                    t1 = aa5 - 1 << 1 - 1 + mpt 
                    ++@n 
                    tv1(@n) = P_SUGGESTION 
                    tv2(@n) = t1 
                    sub = g 
                    goto MORE_SUGG 
                  end 
                  t1 = aa5 + 19           /* 20, 21, 22, 23 
&dA 
&dA &d@    New code &dA04/26/05&d@ for print suggestion suppressing the printing of a slur
&dA 
                  if line{g} = "*" 
                    ++@n 
                    tcode(@n) = ch4(-1)                /* 0xffffffff = suppress slur
                    tv1(@n) = P_SUGGESTION 
                    tv2(@n) = 0x0200 + t1              /* t1 is index into position string
                    sub = g 
                    goto MORE_SUGG 
                  end 
&dA         
                  if "xyXY" con line{g} 
                    aa3 = mpt 
                    ++@n 
                    tcode(@n) = zpd(4) 
                    tv1(@n) = P_SUGGESTION 
                    tv2(@n) = 0x0200 + t1              /* t1 is index into position string
NXYH: 
                    ++g 
                    sub = g 
                    if line{sub} = "+" 
                      ++sub 
                    end 
                    a2 = int(line{sub..}) 
                    g = sub 
                    a2 += 128 
                    if a2 < 1 
                      a2 = 1 
                    end 
                    if a2 > 255 
                      a2 = 255 
                    end 
                    tcode(@n){aa3} = chr(a2) 

                    if "xyXY" con line{g} 
                      aa3 = mpt 
                      goto NXYH 
                    end 
                  end 
                  sub = g 
                  goto MORE_SUGG 
                end 
&dA 
&dA &d@       More slur suggestions 
&dA 
                if ")]}x" con temp3{rc}                        /* end slur 1,2,3,4
                  t1 = mpt + 23          /* 24, 25, 26, 27 
                  if "xyh" con line{g} 
                    aa3 = mpt 
                    ++@n 
                    tcode(@n) = zpd(4) 
                    tv1(@n) = P_SUGGESTION 
                    tv2(@n) = 0x0200 + t1              /* t1 is index into position string
NXYH2: 
                    ++g 
                    sub = g 
                    if line{sub} = "+" 
                      ++sub 
                    end 
                    a2 = int(line{sub..}) 
                    g = sub 
                    a2 += 128 
                    if a2 < 1 
                      a2 = 1 
                    end 
                    if a2 > 255 
                      a2 = 255 
                    end 
                    tcode(@n){aa3} = chr(a2) 

                    if "xyh" con line{g} 
                      aa3 = mpt 
                      goto NXYH2 
                    end 
                  end 
                  sub = g 
                  goto MORE_SUGG 
                end 
&dA 
&dA &d@       End of &dA05/06/03&d@ Addition 
&dA 
                if temp3{rc} = "-" 
                  if "ou" con line{g}    /* this is a specified tie 
                    ++@n 
                    tv1(@n) = P_SUGGESTION 
                    tv2(@n) = mpt + 7 
                  end 
                end 
                if "_.=i>VArt~wMkTJKvnoQ012345mpfZRFE-" con temp3{rc}  /* Back ties added &dA04/22/08
                  t1 = mpt - 1 << 1 + 1 
                  t1 = int("01010102030303040404040404040404060607080809090909091414141414151617"{t1,2})
&dA 
&dA &d@   Explanation: We need to have a code which indicates the type of element to which
&dA &d@                the suggestions is applied.  So for, we have the following codes:
&dA 
&dA &d@                1 = legato, staccato, or legato-staccate &dEarticulation&d@ 
&dA &d@                2 = spiccato &dEarticulation&d@ 
&dA &d@                3 = horizontal, vertical, or inverted vertical &dEaccent&d@ 
&dA &d@                4 = turn, trill, wavy line, shake, mordant, or delayed turn &dEornament
&dA &d@                                               tremulo added &dA01/07/06&d@ 
&dA &d@                                               back ties added &dA04/22/08&d@ 
&dA &d@                5 = (same thing, I think) 
&dA &d@                6 = up bow, or down bow &dEbowing&d@ 
&dA &d@                7 = &dEharmonic&d@ 
&dA &d@                8 = open string, or thumb position 
&dA &d@             9-13 = &dEfingering&d@ (five suggestions possible) 
&dA &d@               14 = &dEdynamics&d@ 
&dA &d@               15 = upright &dEfermata&d@ 
&dA &d@               16 = inverted &dEfermata&d@ 
&dA &d@               17 = &dEtie&d@ 
&dA &d@               18 = &dEdots&d@ 
&dA &d@               19 = &dEaccidentals&d@ 
&dA &d@           (20-23 = start slur) 
&dA &d@           (24-27 = stop slur) 
&dA 
                  if t1 = 4                            /* ornament 
                    if sugg_flg2 < 2 
                      ++sugg_flg2 
                      t1 = sugg_flg2 + 3 
                    end 
                  end 
                  if t1 = 9                            /* fingering 
                    if rc > 32 and temp3{rc-1} = ":" 
                      t1 = 1000                        /* t1 = 1000 means "do nothing"
                    else 
                      if sugg_flg < 5 
                        ++sugg_flg 
                        t1 = sugg_flg + 8 
                      end 
                    end 
                  end 
                  if line{g} = "L" and t1 <> 17        /* &dA05/02/03&d@ "L" applies only to ties
                    t1 = 1000 
                  end 

                  if t1 < 1000 and "xXyYabL" con line{g}  /* modifications to code &dA05/02/03
                    aa3 = mpt 
                    ++@n 
                    tcode(@n) = zpd(4) 
                    tv1(@n) = P_SUGGESTION 
                    tv2(@n) = 0x0200 + t1              /* t1 is index into position string
NXYP: 
                    if aa3 < 5 
                      ++g 
                      sub = g 
                      if line{sub} = "+" 
                        ++sub 
                      end 
                      a2 = int(line{sub..}) 
                      g = sub 
                      a2 += 128 
                      if a2 < 1 
                        a2 = 1 
                      end 
                      if a2 > 255 
                        a2 = 255 
                      end 
                      aa4 = ors(tcode(@n){2}) 
                      if aa3 < 3 
                        tcode(@n){3} = chr(a2) 
                        if aa3 = 1 
                          aa4 |= 0x01                          /* set position as "relative"
                        else 
                          aa4 |= 0x03                          /* set position as "absolute"
                        end 
                      else 
                        tcode(@n){4} = chr(a2) 
                        if aa3 = 3 
                          aa4 |= 0x01                          /* set position as "relative"
                        else 
                          aa4 |= 0x05                          /* set position as "absolute"
                        end 
                      end 
                      tcode(@n){2} = chr(aa4) 
                      if t1 <> 17 
                        a2 = ors(tcode(@n){1}) | 0x01          /* added &dA11/10/07&d@   Major oversight, check results
                        tcode(@n){1} = chr(a2) 
                      end 
                    end 

                    if aa3 = 5 or aa3 = 6 
                      aa4 = aa3 - 5 * 4 + 3           /* 5 -> 3,  6 -> 7 
                      a2 = ors(tcode(@n){1}) | aa4 
                      tcode(@n){1} = chr(a2) 
                      ++g 
                    end 

                    if aa3 = 7                          /* &dA05/02/03&d@ "L" changes length of tie
                      ++g 
                      sub = g 
                      if line{sub} = "+" 
                        ++sub 
                      end 
                      a2 = int(line{sub..}) 
                      g = sub 
                      a2 += 128 
                      if a2 < 1 
                        a2 = 1 
                      end 
                      if a2 > 255 
                        a2 = 255 
                      end 
                      tcode(@n){1} = chr(a2) 
                    end 

                    if "xXyYabL" con line{g} 
                      aa3 = mpt 
                      if aa3 < 7 or t1 = 17             /* &dA05/02/03&d@ "L" applies only to ties
                        goto NXYP 
                      end 
                    end 
                  end 
                  sub = g 
                  goto MORE_SUGG 
                end 
&dA 
&dA &d@        Suggestions for tuples 
&dA 
                if temp3{rc} = "*"               /* &dA03-21-97&d@ 
                  if "[(:;i" con line{g} 
                    aa3 = mpt 
                    ++@n 
                    tv1(@n) = P_SUGGESTION 
                    tv2(@n) = 0x10               /* tuplet suggestion 
MOTUP: 
                    if aa3 = 2 or aa3 = 4 
                      tv2(@n) |= 0x01            /* round tuplet 
                    end 
                    if aa3 = 1 or aa3 = 2 or aa3 = 5 
                      tv2(@n) |= 0x02            /* continuous tuplet 
                    end 
                    if aa3 = 3 
                      tv2(@n) = 0x10             /* square, broken tuplet (default)
                    end 
                    if aa3 = 5 
                      tv2(@n) |= 0x04            /* tuplet number inside bracket
                    end 
                    if "[(:;i" con line{g+1} 
                      ++g 
                      aa3 = mpt 
                      goto MOTUP 
                    end 
                  end 
                end 
                if temp3{rc} = "!"               /* &dA11/05/05&d@ 
&dA 
&dA &d@         New code &dA11/05/05&d@ implementing post adjustment to tuple position 
&dA 
MOTUP2: 
                  if line{g} = "x" 
                    a2 = int(line{g+1..}) 
                    a2 *= vpar(2) 
                    a2 /= 10 
                    g = sub 
                    if abs(a2) < 128 
                      ++@n 
                      tv1(@n) = P_SUGGESTION 
                      tv2(@n) = 0x500            /* x adjustment to tuplet 
                      a2 += 128 
                      tv2(@n) += a2 
                    end 
                    goto MOTUP2 
                  end 
                  if line{g} = "y" 
                    a2 = int(line{g+1..}) 
                    a2 *= vpar(2) 
                    a2 /= 10 
                    g = sub 
                    if abs(a2) < 128 
                      ++@n 
                      tv1(@n) = P_SUGGESTION 
                      tv2(@n) = 0x600            /* x adjustment to tuplet 
                      a2 += 128 
                      tv2(@n) += a2 
                    end 
                    goto MOTUP2 
                  end 
                end 
&dA                      &d@ End of &dA11/05/05&d@ addition 

                sub = g  
                goto MORE_SUGG 
              end 
            end 
&dA 
&dA &d@      Print suggestions applied to musical directions  (not modified as of &dA05/02/03&d@)
&dA 
            if temp3{1} = "*" 
              if rc >= 17 and rc <= 18 
                if "fxypY" con line{g} 
                  ++@n 
                  tcode(@n) = zpd(4) 
                  tv1(@n) = P_SUGGESTION 
                  if "ABCDGPQR" con temp3{rc}      /* New &dA02/03/08&d@ 
                    tv2(@n) = 0x0100 
                  else 
                    tv2(@n) = 0x0101 
                  end 
                end 
NXFP: 
                if line{g} = "f" 
                  t1 = int(line{g+1..}) 
                  g = sub 
                  if "ABCDGR" con temp3{rc} /* this is a designated font number  New &dA02/03/08
                    tcode(@n){1} = chr(t1) 
                  end 
                  goto NXFP 
                end 

                if "xyYp" con line{g} 
                  aa3 = mpt + 1 
                  if aa3 = 5 
                    aa3 -= 2 
                  end 
                  if line{g+1} = "+" 
                    ++g 
                  end 
                  t1 = int(line{g+1..}) 
                  t1 += 0x80 
                  if t1 <= 0 
                    t1 = 1 
                  end 
                  if t1 > 255 
                    t1 = 255 
                  end 
                  g = sub 
                  if "ABCDEFGHPQRUV" con temp3{rc} /* this is a position shift  New &dA02/03/08
                    tcode(@n){aa3} = chr(t1) 
                  end 
                  goto NXFP 
                end 
                sub = g 
                goto MORE_SUGG 
              end 
              if rc >= 25 and line{g} = "f" and temp3{17,2} con ['B'..'D','R']  /* New &dA02/03/08
                t1 = int(line{g+1..}) 
                g = sub 
                temp3 = temp3 // pad(100) 
&dA 
&dA &d@         De-construct temp3 into ASCII and font changes 
&dA 
                loop for a1 = 1 to 10 
                  font_changes(a1,1) = 0 
                  font_changes(a1,2) = 0 
                repeat 
                changecnt = 0 
                sub = 25 
NXFNUM: 
                if temp3{sub..} con "!" and temp3{sub+1} in ['0'..'9'] 
                  a1 = sub 
                  a2 = int(temp3{a1+1..}) 
                  ++changecnt 
                  font_changes(changecnt,1) = a1 
                  font_changes(changecnt,2) = a2 
&dA 
&dA &d@       Code change &dA01/17/04&d@ to keep font changes from interferring with the text
&dA 
                  if temp3{sub} = "|" 
                    ++sub 
                  end 
&dA   
                  temp3 = temp3{1,a1-1} // temp3{sub..} 
                  sub = a1 
                  goto NXFNUM 
                end 
&dA 
&dA &d@         Add new font change and re-order in ascending order of location 
&dA 
                ++changecnt 
                font_changes(changecnt,1) = rc 
                font_changes(changecnt,2) = t1 
                loop for a1 = changecnt to 2 step -1 
                  a2 = a1 - 1 
                  if font_changes(a1,1) < font_changes(a2,1) 
                    aa3 = font_changes(a1,1) 
                    font_changes(a1,1) = font_changes(a2,1) 
                    font_changes(a2,1) = aa3 
                    aa3 = font_changes(a1,2) 
                    font_changes(a1,2) = font_changes(a2,2) 
                    font_changes(a2,2) = aa3 
                  end 
                repeat 
&dA 
&dA &d@         Merge ASCII and font changes into new temp3 
&dA 
                temp4 = temp3{1,24} 
                a2 = 25 
                loop for a1 = 1 to changecnt 
                  aa3 = font_changes(a1,1) 
                  if aa3 > a2 
                    temp4 = temp4 // temp3{a2..aa3-1} 
                  end 
                  a2 = aa3 
                  temp4 = temp4 // "!" // chs(font_changes(a1,2)) // "|" 
                repeat 
                temp4 = temp4 // temp3{a2..} 
                temp3 = temp4 
                loop for a1 = @n to 1 step -1 
                  if tv1(a1) = MUSICAL_DIR 
                    tdata(a1,1) = temp3{17..96} 
                    a1 = 0 
                  end 
                repeat 
                sub = g 
                goto MORE_SUGG 
              end 
            end 
&dA 
&dA &d@      Print suggestions applied to measures and barlines: New code &dA05/25/03
&dA 
            if temp3{1} = "m" 
              if rc = 1 

&dA          &d@  
&dA 
&dA &d@       New suggestion &dA10/24/08&d@ to breakup a multi-rest measure (for parts) 
&dA 
                if line{g} = "f" and mrest > 0 
                  perform setmrest (mrest, wrest) 
                  mrest = 0 
                end 
&dA 
&dA          

                if line{g} = "n" 
                  ++@n 
                  tcode(@n) = zpd(4) 
                  tv1(@n) = P_SUGGESTION 
                  tv2(@n) = 0x0400 
                end 
&dA 
&dA &d@       New suggestion &dA05/28/05&d@ to implement &dEmid-movement&d@ right justification
&dA 
&dA &d@       NOTE: This code contains a giant cludge.  If the print suggestion follows
&dA &d@             directly after a measure record, and "]" is the only suggestion, then 
&dA &d@             this code reaches directly into the output and changes it.  
&dA &d@                                                                       
                if line{g} = "]" 
                  if @n = 0 
                    loop for t1 = outpnt to (outpnt - 10) step -1 
                      tget [Y,t1] temp4 
                      if len(temp4) > 5 and temp4{1,3} = "J B" 
                        sub = 5 
                        aa6 = int(temp4{sub..}) 
                        aa7 = int(temp4{sub..}) 
                        aa8 = int(temp4{sub..}) 
                        aa8 += 10000000 
                        temp4 = "J B " // chs(aa6) // " " // chs(aa7) // " " // chs(aa8) // temp4{sub..}
                        tput [Y,t1] ~temp4 
                        goto PR 
                      end 
                    repeat 
                  end 
                  ++@n 
                  tcode(@n) = zpd(4) 
                  tv1(@n) = P_SUGGESTION 
                  tv2(@n) = 0x0401 
                end 
                sub = g 
                goto MORE_SUGG 
              end 
            end 

            sub = g 
            goto MORE_SUGG 
          end 
          goto PR 
        end 
&dA  
&dA  &d@    END OF MAIN CODE FOR PRINT SUGGESTIONS 
&dA  &d@  ========================================== 
&dA  
&dA                                                                  


        if line{8} = " " 
          rc = 0 
        end 
        if mrest > 0 
          out = trm(line) 
          if len(out) > 15       /* this is a normal stage2 data line 
            perform setmrest (mrest, wrest) 
            mrest = 0 
          else 
&dA 
&dA &d@    &dA03/07/06&d@ allowing only mheavy4 of all measure codes 
&dA &d@               to slip through here.  
&dA 
            if "mrib" not_con line{1} or line{1,7} = "mheavy4" 
              perform setmrest (mrest, wrest) 
              mrest = 0 
            end 
          end 
        end 
        if "ABCDEFGri" con line{1} 
          ++@n 
          t1 = NOTE 
          if line{1} = "r" 
            t1 = REST 
          end 
          if line{1} = "i" 
            t1 = IREST 
          end 
          tv1(@n) = t1 
          tv2(@n) = rc 
          if " 123" con line{24}               /* staff number goes in tv3(.) & 0x0000000f
            if mpt = 1 
              tv3(@n) = 0 
            else 
              tv3(@n) = mpt - 2 
            end 
          else 
            if (Debugg & 0x01) > 0 
              pute Illegal character in staff number column (col. 24).  Please fix.
              pute Record = ~line 
            end 
            tmess = 11 
            perform dtalk (tmess) 
          end 
&dA 
&dA &d@       Code added &dA01/30/05&d@ for text under notes 
&dA 
          temp4 = trm(line) 
          if len(temp4) > 43 
            text_flag = 1 
          end 
&dA                                

          if " 123456789" con line{15}         /* track number goes in tv3(.) & 0x000000f0
            if mpt = 1                         /* track number = 0 means no information
            else 
              --mpt 
              a1 = mpt << 4 
              tv3(@n) += a1 
            end 
          else 
            if (Debugg & 0x01) > 0 
              pute Illegal character in track number column (col. 15).  Please fix.
              pute Record = ~line 
            end 
            tmess = 11 
            perform dtalk (tmess) 
          end 
&dA 
&dA &d@       Code added &dA01/30/05&d@ for text under notes 
&dA 
          temp4 = trm(line) 
          if len(temp4) > 43 
            text_flag = 1 
          end 
&dA                                

          if line{1} = "i" 
            tcode(@n) = "ires"                 /* redundant, but do it to be on the safe side
          else 
            tcode(@n) = line{1,4} 
          end 
          tdata(@n,1) = line{17..80} 
&dA 
&dA &d@    Code added &dA01/03/04&d@ to deal with optional rests (whole and otherwise) 
&dA 
          if "WHQESTXYZ " con line{17} 
            a1 = mpt 
            if line{1} = "r" and wrest = 1 
              if line{17} = " " 
                tdata(@n,1){1} = "o" 
              else 
                tdata(@n,1){1} = line{17} 
              end 
&dK &d@           else                           /* remove this &dA01/08/11&d@ to implement square notes
&dK &d@             tdata(@n,1){1} = "whqestxyz "{a1} 
            end 
          end 

          if "ri" con line{1}                  /* restplace flag goes in tv3(.) & 0x0000ff00
            if mpt = 1 
              tv3(@n) += restplace << 8 
            end 
          else 
            if repeater_flag > 0               /* repeater flag goes in tv3(.) & 0x0000ff00
              tv3(@n) += repeater_flag << 8 
              if bit(0,repeater_flag) = 1 and line{26} = "]" 
                repeater_flag = 0 
              end 
            end 
          end 
&dA 
&dA &d@   Code added &dA12/20/10&d@ to implement "color" to noteheads, etc.  
&dA 
          if "rgb RGB" con line{14} 
            if mpt <> 4 
              tv3(@n) += mpt << 16             /* color flag goes in tv3(.) & 0x000f0000
            end 
          end 
&dA 
&dA &d@   Code added &dA05/12/04&d@ to implement global suggestion to turn off 
&dA &d@   the printing of rests (used for blank continuo parts).  Note that 
&dA &d@   no other print suggestions for rest can be inforce when this 
&dA &d@   feature is used.  
&dA 
          if restoff = 1 or (irest_flag = 1 and tv1(@n) = IREST) 
            ++@n 
            tcode(@n) = zpd(4) 
            tv1(@n) = P_SUGGESTION 
            tv2(@n) = 0x0300 
            tcode(@n){1} = chr(3) 
          end 
&dA     

&dA 
&dA &d@   Code added &dA01/10/06&d@  to expand the operation of art_flag 
&dA 
          if art_flag >= 16 and "ri" not_con line{1} 
            a2 = art_flag >> 4 
            if a2 = 1 or a2 = 3 or a2 = 4 or a2 = 8 
              ++@n 
              tcode(@n) = zpd(4) 
              tcode(@n){1} = chr(1) 
              tv1(@n) = P_SUGGESTION 
              if a2 < 4 
                tv2(@n) = 0x0201 
              else 
                if a2 = 4 
                  tv2(@n) = 0x0202 
                else 
                  if a2 = 8 
                    tv2(@n) = 0x0203 
                  end 
                end 
              end 
              tcode(@n){1} = chr(3) 
            end 
          end 
&dA     
          goto PR 
        end 
        if line{1} = "/" 
          perform action 
          ++outpnt 
          tput [Y,outpnt] J M 0 ~obx  0 0 10000 0 0 
          if (Debugg & 0x06) > 0 
            pute END 
          end 
          goto NEXT 
        end 
        if " cgf*b" con line{1} 
          a2 = mpt 
          t6 = int(line{8}) 
          if line{8} in ['A'..'E','X']                    /* Implementing arpeggios &dA01/13/06
            t6 = ors(line{8}) - 55       /* A = 10, etc.       X = 33 (ARPEGGIO)
          end 
&dA 
&dA &d@     New code 01/13/06 implementing arpeggios; delete extraneous data 
&dA 
          if t6 = ARPEGGIO 
            line = line{1,24} 
            line = line // pad(80) 
          end 
&dA    
          ++@n 
          tdata(@n,1) = line{17..80} 
          if line{1} = "f" 
            tv3(@n) = 0 
          else 
            if " 123" con line{24}             /* staff number goes in tv3(.) & 0x0000000f
              if mpt = 1 
                tv3(@n) = 0 
              else 
                tv3(@n) = mpt - 2 
              end 
            else 
              if (Debugg & 0x01) > 0 
                pute Illegal character in staff number column (col. 24).  Please fix.
                pute Record = ~line 
              end 
              tmess = 11 
              perform dtalk (tmess) 
            end 
            if a2 < 4         /* chords, grace, and cue notes 
              if " 123456789" con line{15}     /* track number goes in tv3(.) & 0x000000f0
                if mpt = 1                     /* track number = 0 means no information
                else 
                  --mpt 
                  a1 = mpt << 4 
                  tv3(@n) += a1 
                end 
              else 
                if (Debugg & 0x01) > 0 
                  pute Illegal character in track number column (col. 15).  Please fix.
                  pute Record = ~line 
                end 
                tmess = 11 
                perform dtalk (tmess) 
              end 
            end 
          end 
          goto TT(a2)                    /* a2 = mpt from ~20 lines above 
TT(1):
          tv1(@n) = XNOTE 
          tv2(@n) = 0 
          tcode(@n) = line{2,4} 
          goto PR 
TT(2):
          t1 = CUE_NOTE 
          if line{2} = " " 
            t1 = XCUE_NOTE 
            tcode(@n) = line{3,4} 
            t6 = 0 
          else 
            tcode(@n) = line{2,4} 
          end 
          if line{2} = "r" 
            t1 = CUE_REST 
          end 
          tv1(@n) = t1 
          tv2(@n) = t6 
          if line{2} = "r"                     /* restplace flag goes in tv3(.) & 0x0000ff00
            tv3(@n) += restplace << 8 
          else 
            if repeater_flag > 0               /* repeater flag goes in tv3(.) & 0x0000ff00
              tv3(@n) += repeater_flag << 8 
              if bit(0,repeater_flag) = 1 and line{26} = "]" 
                repeater_flag = 0 
              end 
            end 
          end 
          goto PR 
TT(3):
          t1 = GR_NOTE 
          if line{2} = " " 
            t1 = XGR_NOTE 
            tcode(@n) = line{3,4} 
            t6 = 0 
          else 
            tcode(@n) = line{2,4} 
          end 
          tv1(@n) = t1 
          tv2(@n) = t6 
          if repeater_flag > 0                 /* repeater flag goes in tv3(.) & 0x0000ff00
            tv3(@n) += repeater_flag << 8 
            if bit(0,repeater_flag) = 1 and line{26} = "]" 
              repeater_flag = 0 
            end 
          end 
          goto PR 
TT(4):
          tv1(@n) = FIGURES 
          tv2(@n) = rc 
          tv3(@n) = 0 
          tcode(@n) = line{2,4} 
          goto PR 
TT(5): 
          tv1(@n) = MUSICAL_DIR 
          if "12345" con line{15} 
            tv2(@n) = mpt 
          else 
            tv2(@n) = 1 
          end 
          if rc > 0 
            tv3(@n) += rc << 8 
          end 

          tcode(@n) = line{17,4} 
&dA 
&dA &d@    Code added &dA01/07/06&d@ to give format warning 
&dA 
          if line{17,2} = "  " 
            if (Debugg & 0x01) > 0 
              temp4 = trm(line) 
              pute WARNING: Bad format in a musical direction record 
              pute    Rec #~(scnt+5)  -> ~temp4 
            end 
          end 
&dA     
          goto PR 
TT(6): 
          tv1(@n) = BACKSPACE 
          tv2(@n) = rc 
          tv3(@n) = 0 
          tcode(@n) = line{1,4} 
          goto PR 
        end 
        if line{1} = "m" 

          ++barnum2 

          if f4 = 0 and line{2,6} <> "heavy4" 
&dA 
&dA &d@    &dA03/07/06&d@  Allowing other measure types (except "mheavy4") here, but 
&dA &d@                clearing mrest below for all cases other than "measure" 
&dA 
            out = trm(line) 
&dA 
&dA &d@    New &dA03/13/06&d@ Don't process for "multi-rests" unless multirest_flag = 1 
&dA &d@                 Normally, this will apply to Parts only.  
&dA 
            if len(out) < 16 and multirest_flag = 1 
              if @n = 1 
                if "ir" con tcode(1){1} 
                  out = trm(tdata(1,1)) 
                  if out = "" 
                    ++mrest 
                    if mrest = 1 
                      how_much_mrest(1) = divspq 
                      how_much_mrest(2) = tv2(1) 
                    else 
                      if tv2(1) <> how_much_mrest(2) 
                        if (Debugg & 0x01) > 0 
                          pute Stage 2 file format error at approx rec ~scnt
                        end 
                        tmess = 22 
                        perform dtalk (tmess) 
                      end 
                    end 

                    mrest_line = line 
                    measnum = g 
                    if wrest = 1 or multirest_flag = 0    /* New code &dA01/03/04&d@ and &dA03/04/06
                      perform setmrest (mrest, wrest) 
                      mrest = 0 
                    else 
                      if line{2,4} <> "easu" 
                        perform setmrest (mrest, wrest) 
                        mrest = 0 
                      end 
                    end 
                    @n = 0 
                    out = trm(line) 
                    if len(out) > 7 
                      if len(out) > 12 
                        out = line{1,8} // chs(g-1) // pad(12) 
                        out = out // line{13..} 
                        out = trm(out) 
                      else 
                        out = line{1,8} // chs(g-1) 
                        out = trm(out) 
                      end 
                    end 
                    if (Debugg & 0x06) > 0 
                      if mreport_flag = 1 or (Debugg & 0x08) > 0 
                        pute ~out 
                      end 
                    end 
                    goto PR 
                  end 
                end 
              else 
                if @n = vflag * 2 - 1 and nstaves = 1 
                  loop for t1 = 1 to vflag * 2 step 2 
                    out = trm(tdata(t1,1)) 
                    if "ir" not_con tcode(t1){1} or out <> "" 
                      t1 = 10000 
                    else 
                      if t1 < @n 
                        out = trm(tdata(t1+1,1)) 
                        if tcode(t1+1) <> "back" or out <> "" 
                          t1 = 10000 
                        end 
                      end 
                    end 
                  repeat 
                  if t1 < 10000 
                    ++mrest 

                    if mrest = 1 
                      how_much_mrest(1) = divspq 
                      how_much_mrest(2) = tv2(1) 
                    else 
                      if tv2(1) <> how_much_mrest(2) 
                        if (Debugg & 0x01) > 0 
                          pute Stage 2 file format error at approx rec ~scnt
                        end 
                        tmess = 22 
                        perform dtalk (tmess) 
                      end 
                    end 

                    mrest_line = line 
                    measnum = g 
                    if wrest = 1 or multirest_flag = 0    /* New code &dA01/03/04&d@ and &dA03/04/06
                      perform setmrest (mrest, wrest) 
                      mrest = 0 
                    else 
                      if line{2,4} <> "easu" 
                        perform setmrest (mrest, wrest) 
                        mrest = 0 
                      end 
                    end 
                    @n = 0 
                    out = trm(line) 
                    goto PR 
                    if (Debugg & 0x06) > 0 
                      if mreport_flag = 1 or (Debugg & 0x08) > 0 
                        pute ~out 
                      end 
                    end 
                  end 
                end 
              end 
            end 
          end 
          f4 = 0 
          ++@n 
          tv1(@n) = BAR_LINE 
          tv2(@n) = g 
          tv3(@n) = nstaves 
          measnum = g 
          tcode(@n) = line{4,4} 
          tdata(@n,1) = line{17..80} 
          tdata(@n,2) = chs(barnum2) // "+" 

          if tdata(@n,1) not_con "*" and tdata(@n,1) not_con "&"  /* 2nd condition added &dA01/30/05
            out = trm(line) 
            if len(out) > 7 
              if len(out) > 12 
                out = line{1,8} // chs(g-1) // pad(12) 
                out = out // line{13..} 
                out = trm(out) 
              else 
                out = line{1,8} // chs(g-1) 
                out = trm(out) 
              end 
            end 
            if (Debugg & 0x06) > 0 
              if mreport_flag = 1 or (Debugg & 0x08) > 0 
                pute ~out 
              end 
            end 
            perform action 
            @n = 0 
          end 
          goto PR 
        end 
        if (Debugg & 0x01) > 0 
          pute ~line 
        end 
        tmess = 7 
        perform dtalk (tmess) 
*          
NEXT: 
        tget [Y,1] t5 .t1 temp3 
&dA 
&dA &d@       Adding this code &dA01/30/05&d@ to make sure text is set at the right height
&dA 
        if text_flag = 1 
          t5 = text_loc 
        end 
        if single_line = 0 
          LL = "L" 
        else 
          LL = "l" 
        end 
&dA 
&dA &d@    If Syscode = "", collect data for constructing a default Syscode 
&dA 
        if Syscode = "" 
          if t5 = 0 
&dA 
&dA &d@     String Section 
&dA 
            partname = partname // " " 
            if partname con "iolin" 
              sys_data(f3,1) = 1 
              sys_data(f3,2) = 1 
              goto SYSC 
            end 
            if partname con "iola" 
              sys_data(f3,1) = 1 
              sys_data(f3,2) = 2 
              goto SYSC 
            end 
            if partname con "iolon" and partname not_con "cello" 
              sys_data(f3,1) = 1 
              sys_data(f3,2) = 3 
              goto SYSC 
            end 
            if partname con "Cello" or partname con "cello" 
              sys_data(f3,1) = 1 
              sys_data(f3,2) = 4 
              goto SYSC 
            end 
            if partname con "Basso" or partname con "basso" or partname con "Bass "
              if partname not_con "larinet" and partname not_con "orn" and partname not_con "rombon"
                sys_data(f3,1) = 1 
                sys_data(f3,2) = 5 
                goto SYSC 
              end 
            end 
&dA 
&dA &d@     Woodwind Section 
&dA 
            if (partname con "Flute" or partname con "flute") and partname not_con "icco"
              sys_data(f3,1) = 2 
              sys_data(f3,2) = 6 
              goto SYSC 
            end 
            if (partname con "Flaut" or partname con "flaut") and partname not_con "icco"
              sys_data(f3,1) = 2 
              sys_data(f3,2) = 7 
              goto SYSC 
            end 
            if partname con "Obo" or partname con "obo" 
              sys_data(f3,1) = 2 
              sys_data(f3,2) = 8 
              goto SYSC 
            end 
            if partname con "larinet"
              if partname con "Basso" or partname con "basso" or partname con "Bass "
                sys_data(f3,1) = 2 
                sys_data(f3,2) = 10 
              else 
                sys_data(f3,1) = 2 
                sys_data(f3,2) = 9 
              end 
              goto SYSC 
            end 
            if partname con "assoon" or partname con "agot" 
              if partname con "ontra" 
                sys_data(f3,1) = 2 
                sys_data(f3,2) = 12 
              else 
                sys_data(f3,1) = 2 
                sys_data(f3,2) = 11 
              end 
              goto SYSC 
            end 
            if partname con "enlish" 
              sys_data(f3,1) = 2 
              sys_data(f3,2) = 13 
              goto SYSC 
            end 
            if partname con "iccolo" and partname not_con "r" 
              sys_data(f3,1) = 2 
              sys_data(f3,2) = 14 
              goto SYSC 
            end 
&dA 
&dA &d@     Brass Section 
&dA 
            if partname con "rump" 
              sys_data(f3,1) = 3 
              sys_data(f3,2) = 15 
              goto SYSC 
            end 
            if partname con "romb" and partname not_con "rombo" 
              sys_data(f3,1) = 3 
              sys_data(f3,2) = 16 
              goto SYSC 
            end 
            if partname con "larino" 
              sys_data(f3,1) = 3 
              sys_data(f3,2) = 17 
              goto SYSC 
            end 
            if partname con "rombon" 
              sys_data(f3,1) = 3 
              sys_data(f3,2) = 18 
              goto SYSC 
            end 
            if partname con "uba" 
              sys_data(f3,1) = 3 
              sys_data(f3,2) = 19 
              goto SYSC 
            end 
            if partname con "orn" and partname not_con "nglish" 
              sys_data(f3,1) = 3 
              sys_data(f3,2) = 20 
              goto SYSC 
            end 
&dA 
&dA &d@     Percussions Section 
&dA 
            if partname con "imp" 
              sys_data(f3,1) = 4 
              sys_data(f3,2) = 21 
              goto SYSC 
            end 
            if partname con "iatt" 
              sys_data(f3,1) = 4 
              sys_data(f3,2) = 22 
              goto SYSC 
            end 
            if partname con "ymbal" 
              sys_data(f3,1) = 1 
              sys_data(f3,2) = 23 
              goto SYSC 
            end 
&dA 
&dA &d@     Two Staves            
&dA 
            if nstaves = 2 
              sys_data(f3,1) = 5 
              sys_data(f3,2) = 24 
              goto SYSC 
            end 
&dA 
&dA &d@     Unknown      
&dA 
            sys_data(f3,1) = 6 
            sys_data(f3,2) = 100 
            goto SYSC 
          else          
&dA 
&dA &d@     Singers 
&dA 
            sys_data(f3,1) = 7 
            if "SsAaTtBb" con partname{1} 
              t1 = mpt - 1 / 2 
            end 
            sys_data(f3,2) = 96 + t1 
            goto SYSC 
          end 
SYSC: 
          sys_data(f3,3) = 0 
          sys_data(f3,4) = 0 
        end 

        partname = trm(partname) 

        ++zcnt 
        tput [Z,zcnt] ******************************************** 

        if nstaves = 2 
          ++zcnt 
          tput [Z,zcnt] L ~granddist  ~t5  ~notesize  !39~partname 
        else 
          ++zcnt 
          tput [Z,zcnt] ~LL  0 ~t5  ~notesize  !39~partname 
        end 

        loop for t1 = 2 to outpnt 
          tget [Y,t1] line 
          ++zcnt 
          tput [Z,zcnt] ~line 
        repeat 
        treset [X] 
        treset [Y] 
* 
        ++f3 
        if f3 > f2 
&dA 
&dA &d@    If Syscode = "", analyse and construct a default Syscode 
&dA 
          if Syscode = "" 
            t2 = 0 
            loop for t1 = 1 to f2 
              if t2 = 0 
                if t1 < f2 
                  if sys_data(t1+1,1) = sys_data(t1,1) 
                    sys_data(t1,3) = 1 
                    t2 = 1 
                  end 
                end 
              else 
                if t1 = f2 
                  sys_data(t1,3) = 2 
                  t2 = 0 
                else 
                  if sys_data(t1+1,1) <> sys_data(t1,1) 
                    sys_data(t1,3) = 2 
                    t2 = 0 
                  end 
                end 
              end 
            repeat 

            t2 = 0 
            loop for t1 = 1 to f2 
              if t2 = 0 
                if sys_data(t1,1) = 5 
                  sys_data(t1,4) = 3 
                else 
                  if t1 < f2 
                    if sys_data(t1+1,2) = sys_data(t1,2) 
                      sys_data(t1,4) = 1 
                      t2 = 1 
                    end 
                  end 
                end 
              else 
                if t1 = f2 
                  sys_data(t1,4) = 2 
                  t2 = 0 
                else 
                  if sys_data(t1+1,2) <> sys_data(t1,2)
                    sys_data(t1,4) = 2 
                    t2 = 0 
                  end 
                end 
              end 
            repeat 

            t2 = 0 
            loop for t1 = 1 to f2 
              if t2 = 0 
                if sys_data(t1,3) = 1 
                  Syscode = Syscode // "[" 
                  t2 = 1 
                else 
                  Syscode = Syscode // "(" 
                  t2 = 2 
                end 
                if sys_data(t1,4) = 1 or sys_data(t1,4) = 3 
                  Syscode = Syscode // "{" 
                end 
                if sys_data(t1,1) = 5 
                  Syscode = Syscode // ":" 
                else 
                  Syscode = Syscode // "." 
                end 
                if sys_data(t1,4) = 3 
                  Syscode = Syscode // "}" 
                end 
              else 
                if sys_data(t1,4) = 1 or sys_data(t1,4) = 3 
                  Syscode = Syscode // "{" 
                end 
                if sys_data(t1,1) = 5 
                  Syscode = Syscode // ":" 
                else 
                  Syscode = Syscode // "." 
                end 
                if sys_data(t1,4) = 3 or sys_data(t1,4) = 2 
                  Syscode = Syscode // "}" 
                end 
                if t2 = 1 
                  if sys_data(t1,3) = 2 
                    Syscode = Syscode // "]" 
                    t2 = 0 
                  end 
                end 
              end 
              if t2 = 2 
                Syscode = Syscode // ")" 
                t2 = 0 
              end 
            repeat 
          end 

          return 
        end 
        goto BIG 
*  
      return 

&dA 
&dA &d@                &dAÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿&d@ 
&dA &d@                &dA³ End of processing music data    ³&d@ 
&dA &d@                &dAÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ&d@ 
&dA 
&dA                                                                       
