
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 40. build_regular_slur_dict (ns,t1,t2,t3,t4,t5,t6)               ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³    Purpose: construct a customized Postscript                      ³ 
&dA &d@³                dictionary for regular slurs on                     ³ 
&dA &d@³                a page                                              ³ 
&dA &d@³                                                                    ³ 
&dA &d@³   Inputs:  table ST  contains data for regular slurs               ³ 
&dA &d@³            int   ns      number of slurs in dictionary             ³ 
&dA &d@³            int   t1      table pointer to first entry              ³ 
&dA &d@³            int   t2      table pointer to last data entry          ³ 
&dA &d@³            int   t3      maximum height for all slurs              ³ 
&dA &d@³            int   t4      maximum width for all slurs               ³ 
&dA &d@³            int   t5      dictionary number (1 or 2, at the moment) ³ 
&dA &d@³            int   t6      page number                               ³ 
&dA &d@³            int   pt_cnt2 pointer to next available location        ³ 
&dA &d@³                            in auxillary PostScript output table    ³ 
&dA &d@³            int   sd_cnt  pointer to next available location        ³ 
&dA &d@³                            in the slur dictionary                  ³ 
&dA &d@³                                                                    ³ 
&dA &d@³   Output:  table SD  custormized Postscript dictionaries           ³ 
&dA &d@³                        of slurs                                    ³ 
&dA &d@³            int   pt_cnt2 pointer to next available location        ³ 
&dA &d@³                            in auxillary PostScript output table    ³ 
&dA &d@³            int   sd_cnt  pointer to next available location        ³ 
&dA &d@³                            in the slur dictionary                  ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure build_regular_slur_dict (ns, t1, t2, t3, t4, t5, t6) 
        str data.100
        str temp.1000

        int ns 
        int font,glyph 
        int t1,t2,t3,t4,t5,t6,t7 
        int a1,a2,a3,a4,a5,a6,a7,a8 
        int hh,kk 

        getvalue ns,t1,t2,t3,t4,t5,t6 

        t4 = t4 + 7 / 8 * 8                 /* allign maximum width 
                                            /* on byte boundary 
&dA 
&dA &d@    Start up the auxiliary PostScript output table for this page number 
&dA 
        a6 = (t5 + 1) * 1000 + t6 
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
&dA 
&dA &d@    Construct coordinates for font bounding box 
&dA 
        temp = "" 
        a1 = t4 / 100 
        a2 = rem 
        temp = temp // chs(a1) // "." 
        if a2 < 10 
          temp = temp // "0" 
        end 
        temp = temp // chs(a2) // " " 

        a1 = t3 / 100 
        a2 = rem 
        temp = temp // chs(a1) // "." 
        if a2 < 10 
          temp = temp // "0" 
        end 
        temp = temp // chs(a2) // " 0 0" 

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

        a2 = 32 
        loop for a1 = 1 to ns 
          if a1 = ns 
            ++sd_cnt 
            tput [SD,sd_cnt]   ~a2  /mus_~a2  put 
          else 
            ++sd_cnt 
            tput [SD,sd_cnt]   dup ~a2  /mus_~a2  put 
          end 
          ++a2 
          if a2 = 128 
            a2 = 160 
          end 
        repeat 

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
        tput [SD,sd_cnt]   /CharData ~(ns+1)  dict def 
        ++sd_cnt 
        tput [SD,sd_cnt]   CharData begin 

        a1 = t1 - 1 
        a8 = 32 
        loop for a2 = 1 to ns 
          ++a1 
          tget [ST,a1] temp 
          if temp con "slur at" 
            a3 = mpt 
            temp = temp{a3+9..} 
            tput [Y,1] ~temp 
            tget [Y,1] hh kk 
          end 
          ++a1 
          tget [ST,a1] temp 
&dA 
&dA &d@      Determine height and width of this slur 
&dA 
          a4 = 0                                 /* height counter 
          a5 = 0                                 /* max width 
          loop for a3 = a1+1 to t2               /* t2 is end of table 
            tget [ST,a3] temp 
            temp = trm(temp) 
            temp = temp // pad(1) 
            if temp{1} = ":"                     /* terminating ":" 
              a3 = t2                            /* exit loop 
            else 
              ++a4                               /* increment height 
              a6 = len(temp) 
              if a6 > a5 
                a5 = a6 
              end 
            end 
          repeat 
          a5 = a5 + 7 / 8 * 8                    /* allign width on byte boundary
&dA 
&dA &d@      With height now determined, you can now locate the slur 
&dA 
          t3 = hh + 50               /* magic number 
          t3 = t3 * 10 * 24 
             
          t4 = 3150 - kk             /* also a magic number 
          t4 -= a4                   /* position to bottom of image 
          t4 = t4 + 1                /* another magic number 
          t4 = t4 * 10 * 24 

          temp = oct(a8) 
          if len(temp) < 3 
            temp = "0" // temp 
          end 
&dA 
&dA &d@      Convert t3 and t4 to decimals (i.e., divide by 1000) 
&dA 
          data = "" 
          a6 = t3 / 1000 
          a7 = rem 
          data = data // chs(a6) // "." 
          if a7 < 100 
            data = data // "0" 
          end 
          if a7 < 10 
            data = data // "0" 
          end 
          data = data // chs(a7) // " " 

          a6 = t4 / 1000 
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
          tput [PT2,pt_cnt2] ~data   moveto (\~temp ) show 

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
          tput [SD,sd_cnt]   /mus_~a8  ~temp  < 
          ++a8 
          if a8 = 128 
            a8 = 160 
          end 
              
&dA 
&dA &d@       Build the definition string 
&dA 
          data = "" 
          loop for a3 = 1 to a4 
            ++a1                                 /* next record
            tget [ST,a1] temp 
            temp = temp // pad(a5) 
&dA 
&dA &d@       Convert this to a hex string 
&dA 
            t7 = 0 
            loop for t4 = 1 to a5 
              if t7 = 0 
                t7 = 0x04 
                if temp{t4} = "x" 
                  t3 = 0x08 
                else 
                  t3 = 0 
                end 
              else 
                if temp{t4} = "x" 
                  t3 += t7 
                end 
                t7 >>= 1 
                if t7 = 0 
                  if t3 < 10 
                    data = data // chs(t3) 
                  else 
                    data = data // chr(55 + t3) 
                  end 
                  if len(data) = 60 
                    ++sd_cnt 
                    tput [SD,sd_cnt] ~data 
                    data = "" 
                  end 
                end 
              end 
            repeat 
          repeat 
          if len(data) > 0 
            ++sd_cnt 
            tput [SD,sd_cnt] ~data 
          end 
          ++sd_cnt 
          tput [SD,sd_cnt] > ] def 
          ++a1                              /* skip terminating ":" 
          tget [ST,a1] temp 
        repeat 
        ++sd_cnt 
        tput [SD,sd_cnt]   /.b46 notdef [ 0 0 0 0 0 1 0 0 <> ] def 
        ++sd_cnt 
        tput [SD,sd_cnt]   end 

        a6 = (t5 + 1) * 1000 + t6 
        ++sd_cnt 
        tput [SD,sd_cnt]   /UniqueID ~a6  def 
        ++sd_cnt 
        tput [SD,sd_cnt] end 
        ++sd_cnt 
        tput [SD,sd_cnt] /Bitfont~a6  exch definefont pop 

      return 
