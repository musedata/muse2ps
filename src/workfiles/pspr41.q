
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 41. build_long_slur_dict (t1,t2,t3,t4)                         ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Purpose: construct a customized Postscript                    ³ 
&dA &d@³                dictionary for one long slur                      ³ 
&dA &d@³                                                                  ³ 
&dA &d@³   Inputs:  table SST contains data for long slurs                ³ 
&dA &d@³            int   t1      table pointer to first entry            ³ 
&dA &d@³            int   t2      table pointer to last data entry        ³ 
&dA &d@³            int   t3      dictionary number (3 and climbing)      ³ 
&dA &d@³            int   t4      page number                             ³ 
&dA &d@³            int   pt_cnt2 pointer to next available location      ³ 
&dA &d@³                            in auxillary PostScript output table  ³ 
&dA &d@³            int   sd_cnt  pointer to next available location      ³ 
&dA &d@³                            in the slur dictionary                ³ 
&dA &d@³                                                                  ³ 
&dA &d@³   Output:  table SD  custormized Postscript dictionaries         ³ 
&dA &d@³                        of slurs                                  ³ 
&dA &d@³            int   pt_cnt2 pointer to next available location      ³ 
&dA &d@³                            in auxillary PostScript output table  ³ 
&dA &d@³            int   sd_cnt  pointer to next available location      ³ 
&dA &d@³                            in the slur dictionary                ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure build_long_slur_dict (t1, t2, t3, t4) 
        str data.100
        str temp.1000

        int font,glyph 
        int t1,t2,t3,t4,t5,t6 
        int a1,a3,a4,a5,a6,a7,a8 
        int hh,kk 

        getvalue t1,t2,t3,t4 
&dA 
&dA &d@    Add to the auxiliary PostScript output table for this page 
&dA 
        a6 = (t3 + 1) * 1000 + t4 
        ++pt_cnt2 
        tput [PT2,pt_cnt2] /Bitfont~a6  findfont 24 scalefont setfont 

        ++sd_cnt 
        tput [SD,sd_cnt] 
        ++sd_cnt 
        tput [SD,sd_cnt] 9 dict dup begin 
        ++sd_cnt 
        tput [SD,sd_cnt]   /FontType 3 def 
        ++sd_cnt 
        tput [SD,sd_cnt]   /FontMatrix [1 0 0 1 0 0] def 

        a1 = t1
        
        tget [SST,a1] temp 
        if temp con "location" 
          a3 = mpt 
          temp = temp{a3+10..} 
          tput [Y,1] ~temp 
          tget [Y,1] hh kk 
        end 
        ++a1 
        tget [SST,a1] temp 
&dA 
&dA &d@      Determine height and width of this slur 
&dA 
        a4 = 0                                 /* height counter 
        a5 = 0                                 /* max width 
        loop for a3 = a1+1 to t2               /* t2 is end of table 
          tget [SST,a3] temp 
          temp = trm(temp) 
          temp = temp // pad(1) 
          if temp{1} = ":"                     /* terminating ":" 
            if a3 <> t2 
              stop 
            end 
          else 
            ++a4                               /* increment height 
            a6 = len(temp) 
            if a6 > a5 
              a5 = a6 
            end 
          end 
        repeat 
        a5 *= 4                                /* convert to bit length 
&dA 
&dA &d@      With height now determined, you can now locate the slur 
&dA 
        t6 = hh + 50               /* magic number 
        t6 = t6 * 10 * 24 

        t5 = 3150 - kk             /* also a magic number 
        t5 -= a4                   /* position to bottom of image 
        t5 = t5 + 1                /* another magic number 
        t5 = t5 * 10 * 24 
&dA 
&dA &d@      Convert t6 and t5 to decimals (i.e., divide by 1000) 
&dA 
        data = "" 
        a6 = t6 / 1000 
        a7 = rem 
        data = data // chs(a6) // "." 
        if a7 < 100 
          data = data // "0" 
        end 
        if a7 < 10 
          data = data // "0" 
        end 
        data = data // chs(a7) // " " 

        a6 = t5 / 1000 
        a7 = rem 
        data = data // chs(a6) // "." 
        if a7 < 100 
          data = data // "0" 
        end 
        if a7 < 10 
          data = data // "0" 
        end 
        data = data // chs(a7) 

        ++pt_cnt2 
        tput [PT2,pt_cnt2] ~data   moveto (\040) show 
&dA 
&dA &d@    Construct coordinates for font bounding box 
&dA 
        temp = "" 
        a6 = a5 / 100 
        a7 = rem 
        temp = temp // chs(a6) // "." 
        if a7 < 10 
          temp = temp // "0" 
        end 
        temp = temp // chs(a7) // " " 

        a6 = a4 / 100 
        a7 = rem 
        temp = temp // chs(a6) // "." 
        if a7 < 10 
          temp = temp // "0" 
        end 
        temp = temp // chs(a7) // " 0 0" 

        ++sd_cnt 
        tput [SD,sd_cnt]   /FontBBox [~temp ] def 

        ++sd_cnt 
        tput [SD,sd_cnt] 
        ++sd_cnt 
        tput [SD,sd_cnt]   /Encoding 256 array def 
        ++sd_cnt 
        tput [SD,sd_cnt]   0 1 255 {Encoding exch /.b46 notdef put} for 
        ++sd_cnt 
        tput [SD,sd_cnt]   Encoding 
        ++sd_cnt 
        tput [SD,sd_cnt]   32 /mus_32  put 

        ++sd_cnt 
        tput [SD,sd_cnt] 
        ++sd_cnt 
        tput [SD,sd_cnt]   /BuildChar 
        ++sd_cnt 
        tput [SD,sd_cnt]     {0 begin 
        ++sd_cnt 
        tput [SD,sd_cnt]       /char exch def 
        ++sd_cnt 
        tput [SD,sd_cnt]       /fontdict exch def 
        ++sd_cnt 
        tput [SD,sd_cnt]       /charname fontdict /Encoding get char get def
        ++sd_cnt 
        tput [SD,sd_cnt] 
        ++sd_cnt 
        tput [SD,sd_cnt]       /charinfo fontdict /CharData get charname get def
        ++sd_cnt 
        tput [SD,sd_cnt] 
        ++sd_cnt 
        tput [SD,sd_cnt]       /wx charinfo 0 get def 
        ++sd_cnt 
        tput [SD,sd_cnt]       /charbbox charinfo 1 4 getinterval def 
        ++sd_cnt 
        tput [SD,sd_cnt]       wx 0 charbbox aload pop setcachedevice 
        ++sd_cnt 
        tput [SD,sd_cnt] 
        ++sd_cnt 
        tput [SD,sd_cnt]       charinfo 5 get charinfo 6 get true 
        ++sd_cnt 
        tput [SD,sd_cnt] 
        ++sd_cnt 
        tput [SD,sd_cnt]       fontdict /imagemaskmatrix get 
        ++sd_cnt 
        tput [SD,sd_cnt]         dup 4 charinfo 7 get put 
        ++sd_cnt 
        tput [SD,sd_cnt]         dup 5 charinfo 8 get put 
        ++sd_cnt 
        tput [SD,sd_cnt]       charinfo 9 1 getinterval cvx 
        ++sd_cnt 
        tput [SD,sd_cnt]       imagemask 
        ++sd_cnt 
        tput [SD,sd_cnt]       end 
        ++sd_cnt 
        tput [SD,sd_cnt]     } def 
        ++sd_cnt 
        tput [SD,sd_cnt] 
        ++sd_cnt 
        tput [SD,sd_cnt]   /BuildChar load 0 6 dict put 
        ++sd_cnt 
        tput [SD,sd_cnt] 


        ++sd_cnt 
        tput [SD,sd_cnt]   /imagemaskmatrix [100 0 0 -100 0 0] def 
        ++sd_cnt 
        tput [SD,sd_cnt] 

        ++sd_cnt 
        tput [SD,sd_cnt]   /CharData 2 dict def 
        ++sd_cnt 
        tput [SD,sd_cnt]   CharData begin 
&dA 
&dA &d@      Construct first 9 elements of def matrix 
&dA 
        temp = "[ 0 0 0 " 
        a6 = a5 / 100 
        a7 = rem 
        temp = temp // chs(a6) // "." 
        if a7 < 10 
          temp = temp // "0" 
        end 
        temp = temp // chs(a7) // " " 

        a6 = a4 / 100 
        a7 = rem 
        temp = temp // chs(a6) // "." 
        if a7 < 10 
          temp = temp // "0" 
        end 
        temp = temp // chs(a7) // " " 

        temp = temp // chs(a5) // " " // chs(a4) // " -0.5 " // chs(a4) // " "

        ++sd_cnt 
        tput [SD,sd_cnt]   /mus_32 ~temp  < 
&dA 
&dA &d@       Build the definition strings 
&dA 
        data = "" 
        loop for a3 = 1 to a4 
          ++a1                                 /* next record 
          tget [SST,a1] temp 
&dA 
&dA &d@       This is already a hex string 
&dA 
          loop for a8 = 1 to len(temp) 
            data = data // temp{a8} 
            if len(data) = 60 
              ++sd_cnt 
              tput [SD,sd_cnt] ~data 
              data = "" 
            end 
          repeat 
        repeat 
        if len(data) > 0 
          ++sd_cnt 
          tput [SD,sd_cnt] ~data 
        end 

        ++sd_cnt 
        tput [SD,sd_cnt] > ] def 

        ++sd_cnt 
        tput [SD,sd_cnt]   /.b46 notdef [ 0 0 0 0 0 1 0 0 <> ] def 
        ++sd_cnt 
        tput [SD,sd_cnt]   end 

        a6 = (t3 + 1) * 1000 + t4 
        ++sd_cnt 
        tput [SD,sd_cnt]   /UniqueID ~a6  def 
        ++sd_cnt 
        tput [SD,sd_cnt] end 
        ++sd_cnt 
        tput [SD,sd_cnt] /Bitfont~a6  exch definefont pop 

      return 
