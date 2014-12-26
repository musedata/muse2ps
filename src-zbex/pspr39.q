
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 39. build_page_pdict                                        ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose: construct a customized Postscript                 ³ 
&dA &d@³                dictionary for a page                          ³ 
&dA &d@³                                                               ³ 
&dA &d@³   Input:  list of fonts and glyphs in table ZZ                ³ 
&dA &d@³                                                               ³ 
&dA &d@³   Output  custormized Postscript dictionary                   ³ 
&dA &d@³             in table PD                                       ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure build_page_pdict 

        str data.100 
        str temp.10000 

        int font,glyph 
        int t1,t2,t3,t4,t5 
        int a(16) 
        int glyph_loc(256) 
        int gcount 
        int glyphs(256) 
        int font_loc 

        pd_cnt = 0 
        zpnt = 1 
BPD_A: 
        tget [ZZ,zpnt] data .t6 font .t9 glyph 
        if data{1} = "$" 
          goto BPD_END 
        end 
        if data{1} = "f" 
          ++pd_cnt 
          tput [PD,pd_cnt] 
          tget [XX,font] t1 
          ++pd_cnt 
          tput [PD,pd_cnt] 
          font_loc = t1 
          t5 = 0 
          loop for t3 = 1 to 16 
            tget [XX,t1] a(1) a(2) a(3) a(4) a(5) a(6) a(7) a(8) a(9) a(10) a(11) a(12) a(13) a(14) a(15) a(16)
            ++t1 
            loop for t4 = 1 to 16 
              ++t5 
              glyph_loc(t5) = a(t4) 
            repeat 
          repeat 
          loop for t3 = 1 to 7 
            tget [XX,t1] data 
            ++t1 
            ++pd_cnt 
            tput [PD,pd_cnt] ~data 
          repeat 

          zpnt2 = zpnt + 2 
          gcount = 1 
BPD_B: 
          tget [ZZ,zpnt2] data .t9 glyph 
          tget [ZZ,zpnt2+1] temp 
          temp = temp // pad(4) 
          glyphs(gcount) = glyph 
          ++gcount 
          if data{4} = "c" and temp{4} = "c" 
            ++pd_cnt 
            tput [PD,pd_cnt]     dup ~glyph  /mus_~glyph  put 
            ++zpnt2 
            goto BPD_B 
          else 
            ++pd_cnt 
            tput [PD,pd_cnt]     ~glyph  /mus_~glyph  put 
            zpnt = zpnt2 + 1 
          end 

          ++pd_cnt 
          tput [PD,pd_cnt] 
          ++pd_cnt 
          tput [PD,pd_cnt]   /BuildChar 
          ++pd_cnt 
          tput [PD,pd_cnt]     {0 begin 
          ++pd_cnt 
          tput [PD,pd_cnt]       /char exch def 
          ++pd_cnt 
          tput [PD,pd_cnt]       /fontdict exch def 
          ++pd_cnt 
          tput [PD,pd_cnt]       /charname fontdict /Encoding get char get def
          ++pd_cnt 
          tput [PD,pd_cnt] 
          ++pd_cnt 
          tput [PD,pd_cnt]       /charinfo fontdict /CharData get charname get def
          ++pd_cnt 
          tput [PD,pd_cnt] 
          ++pd_cnt 
          tput [PD,pd_cnt]       /wx charinfo 0 get def 
          ++pd_cnt 
          tput [PD,pd_cnt]       /charbbox charinfo 1 4 getinterval def 
          ++pd_cnt 
          tput [PD,pd_cnt]       wx 0 charbbox aload pop setcachedevice 
          ++pd_cnt 
          tput [PD,pd_cnt] 
          ++pd_cnt 
          tput [PD,pd_cnt]       charinfo 5 get charinfo 6 get true 
          ++pd_cnt 
          tput [PD,pd_cnt] 
          ++pd_cnt 
          tput [PD,pd_cnt]       fontdict /imagemaskmatrix get 
          ++pd_cnt 
          tput [PD,pd_cnt]         dup 4 charinfo 7 get put 
          ++pd_cnt 
          tput [PD,pd_cnt]         dup 5 charinfo 8 get put 
          ++pd_cnt 
          tput [PD,pd_cnt]       charinfo 9 1 getinterval cvx 
          ++pd_cnt 
          tput [PD,pd_cnt]       imagemask 
          ++pd_cnt 
          tput [PD,pd_cnt]       end 
          ++pd_cnt 
          tput [PD,pd_cnt]     } def 
          ++pd_cnt 
          tput [PD,pd_cnt] 
          ++pd_cnt 
          tput [PD,pd_cnt]   /BuildChar load 0 6 dict put 
          ++pd_cnt 
          tput [PD,pd_cnt] 

          tget [XX,t1] data 
          ++t1                      /* imagemask 
          ++pd_cnt 
          tput [PD,pd_cnt] ~data 

          tget [XX,t1] data 
          ++t1                      /* /CharData xxx dict def 
          ++pd_cnt 
          tput [PD,pd_cnt]   /CharData ~gcount  dict def 
          ++pd_cnt 
          tput [PD,pd_cnt]   CharData begin 

          loop for t3 = 1 to gcount - 1 
            t4 = glyphs(t3) 
            t5 = glyph_loc(t4) + font_loc 
            tget [XX,t5] data .t8 t2 
            if t2 <> t4 
              if (Debugg & 0x12) > 0 
                pute Logic Error ~data   in building a page 
                pute ~t2  ~t4 
              end 
              stop 
            end 
            ++pd_cnt 
            tput [PD,pd_cnt] ~data 
            loop 
              ++t5 
              tget [XX,t5] data 
              ++pd_cnt 
              tput [PD,pd_cnt] ~data 
            repeat while data{1} <> ">" 
          repeat 

          t5 = glyph_loc(256) + font_loc 
          loop for t3 = 1 to 5 
            tget [XX,t5] data 
            ++t5 
            ++pd_cnt 
            tput [PD,pd_cnt] ~data 
          repeat 

          goto BPD_A 

        end 
       
BPD_END: 

      return 
