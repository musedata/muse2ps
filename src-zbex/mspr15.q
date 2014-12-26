
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³M* 15. procedure output_page (size)                               ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Purpose:  Transfer Y-table to output file                     ³ 
&dA &d@³                                                                  ³ 
&dA &d@³    Note:  This procedure must be rewritten at some point         ³ 
&dA &d@³                                                                  ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure output_page (size) 
        str line2.200 

        int t1,t2,t3,t4,t5,t6,t7,t8,t9 
        int p1,p2,p3 
        int size 
        int next_obx,prior_obx,current_obx 
        int next_t6 
        int gap,minspace,gap2,length,shift 
        int flag 
        int old_t2 

        getvalue size 
&dA 
&dA &d@    This procedure is written to handle both parts and scores.  
&dA &d@    In the case of parts (f11 = 1), an adjustment needs to be 
&dA &d@    made for the multiple rests.  In the case of scores (f11 > 1), 
&dA &d@    adjustments may be required in the vertical spacings.  
&dA 
        if job_type = "p" 
          goto M_OUT_PAGE1 
        end 
&dA 
&dA &d@    This section deals with scores 
&dA 
&dA &d@    Step 1: Determine space at the bottom 
&dA 
        t3 = 0 
        t8 = 0 
        loop for t1 = 1 to size  
          tget [Y,t1] line 
          if "Ll" con line{1} 
            ++t3 
          end 
          if line{1} = "S" 
            ++t8 
          end 
        repeat 
        --t3 
        --t8 

        if old_sys_bottom = 0 
          t2 = lowerlim - (sys_bottom + (4 * notesize)) 
        else 
          t2 = lowerlim - (old_sys_bottom + (4 * notesize)) 
        end 
&dA 
&dA &d@    Step 2: Determine space to add or subtract 
&dA 
        if t2 < 0 and t3 > 0   /* contraction is mandatory.  Just do it.  
          t2 = 0 - t2 
          t2 /= t3 
          old_t2 = 0 

          t6 = 0         /* space change counter 
          loop for t1 = 1 to size 
            tget [Y,t1] line
            if line{1} = "S" 
              p1 = int(line{3..}) 
              p2 = int(line{sub..}) 
              p3 = int(line{sub..}) 
              line = line{sub..} 
              if t6 > 0 
                p3 -= (t6 * t2) 
                line = "S 0 " // chs(p2) // " " // chs(p3) // line 
                tput [Y,t1] ~line 
              end 
              ++t6 
              t3 = t6    /* t3 = system "anchor" 
            end 
            if "Ll" con line{1} 
              t4 = int(line{3..}) 
              t5 = sub 
              t7 = t6 - t3 
              if t7 > 0 
                t4 -= (t2 * t7) 
                line = line{1} // " " // chs(t4) // line{t5..} 
                tput [Y,t1] ~line 
              end 
              ++t6 
            end 
          repeat 
          t2 = 0 
        else 
          if Vspace_flag = 0
            t2 = 0 
          end 
          if t2 > 0 
            if Vspace_flag = 1 
              if t3 = 0 
                t2 = 0 
              else 
                t2 /= t3 
              end 
            else 
              if t8 > 0 
                t2 /= t8 
              else 
                t2 = 0 
              end 
            end 
          end 
        end 
&dA 
&dA &d@    Step 3:  if t2 > 0, perform expansion 
&dA 
        if t2 > 0 
          if old_sys_bottom = 0 
            if t2 > (old_t2 * 3 / 2)      /* to keep the last page from looking funny
              t2 = old_t2 
            end 
          end 
          old_t2 = t2                     /* record this spacing for future pages

          if Vspace_flag = 1 
            t6 = 0         /* space change counter 
            loop for t1 = 1 to size 
              tget [Y,t1] line 
              if line{1} = "S" 
                p1 = int(line{3..}) 
                p2 = int(line{sub..}) 
                p3 = int(line{sub..}) 
                line = line{sub..} 
                if t6 > 0 
                  p3 += (t6 * t2) 
                  line = "S 0 " // chs(p2) // " " // chs(p3) // line 
                  tput [Y,t1] ~line 
                end 
&dK &d@               ++t6       /* error.  Use music lines only to advance t6 
                t3 = t6    /* t3 = system "anchor" 
              end 
              if "Ll" con line{1} 
                t4 = int(line{3..}) 
                t5 = sub 
                t7 = t6 - t3 
                if t7 > 0 
                  t4 += (t2 * t7) 
                  line = line{1} // " " // chs(t4) // line{t5..} 
                  tput [Y,t1] ~line 
                end 
                ++t6 
              end 
            repeat 
          else 
            t6 = 0         /* space change counter 
            loop for t1 = 1 to size 
              tget [Y,t1] line 
              if line{1} = "S" 
                p1 = int(line{3..}) 
                p2 = int(line{sub..}) 
                p3 = int(line{sub..}) 
                line = line{sub..} 
                if t6 > 0 
                  p3 += (t6 * t2) 
                  line = "S 0 " // chs(p2) // " " // chs(p3) // line 
                  tput [Y,t1] ~line 
                end 
                ++t6 
              end 
            repeat 
          end 
        end 
&dA 
&dA &d@    Step 4:  Put out (optional) Work_name, Work_number, and Composer 
&dA 
        t9 = 0 
        if Work_name <> "" or Work_number <> "" 
          ++if_cnt 
          tput [IF,if_cnt] X 14
          if Work_name <> "" 
            ++if_cnt 
            tput [IF,if_cnt] X 46 1200C ~t9  ~Work_name 
            t9 += 44 
          end 
          if Work_number <> "" 
            ++if_cnt 
            tput [IF,if_cnt] X 37 1200C ~t9  ~Work_number 
          end 
        end 
        if if_cnt < 5 and Composer <> "" 
          tget [Y,1] line .t3 p1 p1 p2 p3 
          if line{1} = "S" 
            p3 += p1 
            p2 -= (4 * notesize) 
            ++if_cnt 
            tput [IF,if_cnt] X ~notesize 
            ++if_cnt 
            tput [IF,if_cnt] X 31 ~p3 R ~p2  ~Composer 
          end 
        end 
&dA 
&dA &d@    Step 5:  Put out the lines to the page 
&dA 
        ++if_cnt                        /* need to communicate notesize here
        tput [IF,if_cnt] X ~notesize 
        loop for t6 = 1 to size 
          tget [Y,t6] line 
          line = trm(line) 
          ++if_cnt 
          tput [IF,if_cnt] ~line 
        repeat 
        ++if_cnt 
        tput [IF,if_cnt] P
        return 
        
&dA 
&dA &d@    This section deals with parts 
&dA 
M_OUT_PAGE1: 
        gap = maxnotesize * 2 
        minspace = gap * 2 + 90 
&dA 
&dA &d@    Step 1:  Put out (optional) Work_name, Work_number, and Composer 
&dA 
        t9 = 0 
        if Work_name <> "" or Work_number <> "" 
          ++if_cnt 
          tput [IF,if_cnt] X 14
          if Work_name <> "" 
            ++if_cnt 
            tput [IF,if_cnt] X 46 1200C ~t9  ~Work_name 
            t9 += 44 
          end 
          if Work_number <> "" 
            ++if_cnt 
            tput [IF,if_cnt] X 37 1200C ~t9  ~Work_number 
          end 
        end 
        if if_cnt < 5 and Composer <> "" 
          tget [Y,1] line .t3 p1 p1 p2 p3 
          if line{1} = "S" 
            p3 += p1 
            p2 -= (4 * notesize) 
            ++if_cnt 
            tput [IF,if_cnt] X ~notesize 
            ++if_cnt 
            tput [IF,if_cnt] X 31 ~p3 R ~p2  ~Composer 
          end 
        end 

        ++if_cnt                        /* need to communicate notesize here
        tput [IF,if_cnt] X ~notesize 
        loop for t6 = 1 to size 
          tget [Y,t6] line 
          line = line // pad(6) 
          if line{1,5} = "J S 4" 
            current_obx = int(line{7..}) 
            line = line{sub..} 
            line = mrt(line) 
            loop for t7 = t6 + 1 to size 
              tget [Y,t7] line2 
              if line2{1} = "J" 
                t2 = int(line2{5..}) 
                next_obx = int(line2{sub..})       /* next obx 
                next_t6 = t7 - 1 
                t7 = size 
              end 
            repeat 
            loop for t7 = t6 - 1 to 1 step -1 
              tget [Y,t7] line2 
              if line2{1} = "J" and line2{3} <> "D" and line2{3} <> "M"   /* New &dA02/13/09
                t2 = int(line2{5..}) 
                prior_obx = int(line2{sub..})      /* prior obx 
&dA 
&dA &d@          New &dA02/13/09&d@ 
&dA 
                if line2{3} = "K"   
                  t8 = int(line2{5..}) 
                  if t8 > 0 
                    prior_obx += (t8 * mhpar(f12,6)) 
                  end 
                  if t8 < 0 
                    prior_obx -= (t8 * mhpar(f12,7)) 
                  end 
                end 
&dA     
                t7 = 1 
              end 
            repeat 
            t8 = next_obx - prior_obx 
            if t8 > minspace 
              flag = 0 
              t5 = t8 / minspace 
              gap2 = gap * t5 
              t5 = prior_obx + gap2 
              length = next_obx - t5 - gap2 
              shift = length - 90 / 2 

              line = "J S 4 " // chs(t5) // " " // line 
              ++if_cnt 
              tput [IF,if_cnt] ~line 
              loop for t7 = t6 + 1 to next_t6 
                tget [Y,t7] line2 
                if line2{1} = "K" 
                  t1 = int(line2{3..}) 
                  t2 = int(line2{sub..}) 
                  t3 = int(line2{sub..}) 
                  if t3 > 70 and t3 < 81 
                    t1 += shift 
                    ++if_cnt 
                    tput [IF,if_cnt] K ~t1  ~t2  ~t3 
                  end 
                  if t3 = 62 
                    if t1 = 0 
                      ++if_cnt 
                      tput [IF,if_cnt] K 0 ~t2  62 
                    else 
                      ++if_cnt 
                      tput [IF,if_cnt] K ~length  ~t2  62 
                    end  
                  end 
                  if t3 = 92 and flag = 0 
                    flag = 1 
                    t1 = length 
                    loop while t1 > 30 
                      t4 = t1 - 30 
                      ++if_cnt 
                      tput [IF,if_cnt] K ~t4  ~t2  92 
                      t1 -= 30 
                    repeat 
                    ++if_cnt 
                    tput [IF,if_cnt] K 0 ~t2  92 
                  end 
                end 
              repeat 
              t6 = next_t6 
            end 
          else 
            line = trm(line) 
            ++if_cnt 
            tput [IF,if_cnt] ~line 
          end 
        repeat 
        ++if_cnt 
        tput [IF,if_cnt] P 
      return 
