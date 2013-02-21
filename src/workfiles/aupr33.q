
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 33. ps_setchord (p1,p2,p3)                                    ³ 
&dA &d@³                                                                 ³ 
&dA &d@³    Purpose:  Add a chord to the simultaneity                    ³ 
&dA &d@³                                                                 ³ 
&dA &d@³    Inputs:   p1 = pass number (chord number)                    ³ 
&dA &d@³              p2 = second chord number (for unisons) or 100      ³ 
&dA &d@³              p3 = initialize parameter (0 = initialize)         ³ 
&dA &d@³                                                                 ³ 
&dA &d@³    Outputs:  p3 = initialize parameter (1 = don't initialize)   ³ 
&dA &d@³              printpos(.) = print position for this chord        ³ 
&dA &d@³                                                                 ³ 
&dA &d@³    Method:   construct the left boundary of the new chord.      ³ 
&dA &d@³              Move the chord to the right until it bumps         ³ 
&dA &d@³              with previous chords.                              ³ 
&dA &d@³                                                                 ³ 
&dA &d@³    Output:   when a note for a chord is set, ndata(*,PASS)      ³ 
&dA &d@³              for that note is set to zero.                      ³ 
&dA &d@³                                                                 ³ 
&dA &d@³              printpos(p1) and maybe printpos(p2)                ³ 
&dA &d@³                                                                 ³ 
&dA &d@³                                                                 ³ 
&dA &d@³                                                                 ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure ps_setchord (p1,p2,p3) 
        int t1,t2,t3,t4,t5 
        int x 
        int aa,bb,cc,dd 
        int tr(2,45),tl(2,45)
        int pseudo_tr(2,45) 
        int pseudo_tl(2,45) 
        int ff,gg,hh,ii,jj 
        int p1, p2, p3 
        int ps_width 
        int stem_up_flag 
        int stem_down_flag 

        getvalue p1,p2,p3 
        if p3 = 0 
          p3 = 1 
          x = 10000 
        else 
          x = 0 
        end 
        passback p3 
&dA 
&dA &d@       Calling ps_setchord  pass = ~p1   pass2 = ~p2 
&dA 
        ff = 0
        hh = 0

        loop for jj = 1 to 45 
          tl(1,jj) = 200 
          tr(1,jj) = -200 
          pseudo_tr(1,jj) = -200 
          pseudo_tl(1,jj) = 200 
          tl(2,jj) = 200 
          tr(2,jj) = -200 
          pseudo_tr(2,jj) = -200 
          pseudo_tl(2,jj) = 200 
        repeat 

        stem_up_flag    = 0 
        stem_down_flag  = 0 
        repeater_case   = 0 
        t3 = 100 
        loop for ii = 1 to pcnt 
          if ndata(ii,PS_PASS) = p1 or ndata(ii,PS_PASS) = p2 
            t2 = ndata(ii,PS_XPOS)
            t1 = ndata(ii,PS_PITCH)
            if t1 = 100 
              ndata(ii,PS_PASS) = 0 
              return 
            end 

            if t3 = 100 
              t3 = ndata(ii,PS_STAFF) + 1       /* staff number 
              t4 = ndata(ii,PS_HEAD) 
              if ndata(ii,PS_NSTYLE) = 0      /* New  &dA01/08/11&d@ 
                if t4 < 3 
                  ps_width = hpar(82) 
                else 
                  if t4 = 3 
                    ps_width = hpar(83) 
                  else 
                    ps_width = hpar(84) 
                  end 
                end 
              else 
                if t4 < 3 
                  ps_width = vpar(2) 
                else 
                  if t4 = 3 
                    ps_width = vpar(2) * 5 / 4 
                  else 
                    ps_width = hpar(84) 
                  end 
                end 
              end 

              if ndata(ii,PS_NSIZE) = CUESIZE 
                ps_width = ps_width * 8 / 10    
              end 
            end 

            if bit(0,ndata(ii,PS_STEM)) = UP         /* stem up 
              if t2 = 0
                if tl(t3,t1) > 0 
                  tl(t3,t1) = 0 
                end 
                if tl(t3,t1+1) > hpar(95)                
                  tl(t3,t1+1) = hpar(95) 
                end 
                if pseudo_tl(t3,t1) > 0 
                  pseudo_tl(t3,t1) = 0
                end 
                if pseudo_tl(t3,t1+1) > 0
                  pseudo_tl(t3,t1+1) = 0
                end 
                if tr(t3,t1) < ps_width - hpar(95) 
                  tr(t3,t1) = ps_width - hpar(95) 
                end 
                if tr(t3,t1+1) < ps_width                
                  tr(t3,t1+1) = ps_width 
                end 
                if pseudo_tr(t3,t1) < ps_width 
                  pseudo_tr(t3,t1) = ps_width 
                end 
                if pseudo_tr(t3,t1+1) < ps_width 
                  pseudo_tr(t3,t1+1) = ps_width 
                end 
              else
                dd = ps_width << 1 - hpar(90) 
                if tr(t3,t1) < dd - hpar(95) 
                  tr(t3,t1) = dd - hpar(95) 
                end 
                if tr(t3,t1+1) < dd 
                  tr(t3,t1+1) = dd 
                end 
                if pseudo_tr(t3,t1) < dd + hpar(49) 
                  pseudo_tr(t3,t1) = dd + hpar(49) 
                end 
                if pseudo_tr(t3,t1+1) < dd + hpar(49) 
                  pseudo_tr(t3,t1+1) = dd + hpar(49) 
                end 
              end
              if ff = 0
                ff = t1 + 8                     /* 8 = length of stem 
              end
              stem_up_flag |= ndata(ii,PS_STEM) >> 2 
            else
              if t2 = 0
                if tr(t3,t1) < ps_width - hpar(95) 
                  tr(t3,t1) = ps_width - hpar(95) 
                end 
                if tr(t3,t1+1) < ps_width 
                  tr(t3,t1+1) = ps_width 
                end 
                if pseudo_tr(t3,t1) < ps_width 
                  pseudo_tr(t3,t1) = ps_width 
                end 
                if pseudo_tr(t3,t1+1) < ps_width 
                  pseudo_tr(t3,t1+1) = ps_width 
                end 
                if tl(t3,t1) > 0 
                  tl(t3,t1) = 0 
                end 
                if tl(t3,t1+1) > hpar(95) 
                  tl(t3,t1+1) = hpar(95) 
                end 
                if pseudo_tl(t3,t1) > 0 
                  pseudo_tl(t3,t1) = 0
                end 
                if pseudo_tl(t3,t1+1) > 0
                  pseudo_tl(t3,t1+1) = 0
                end 
              else
                if tl(t3,t1) > hpar(90) - ps_width 
                  tl(t3,t1) = hpar(90) - ps_width 
                end 
                if tl(t3,t1+1) > hpar(90) - ps_width + hpar(95) 
                  tl(t3,t1+1) = hpar(90) - ps_width + hpar(95) 
                end 
                if pseudo_tl(t3,t1) > hpar(90) - ps_width - hpar(49) 
                  pseudo_tl(t3,t1) = hpar(90) - ps_width - hpar(49) 
                end 
                if pseudo_tl(t3,t1+1) > hpar(90) - ps_width - hpar(49) 
                  pseudo_tl(t3,t1+1) = hpar(90) - ps_width - hpar(49) 
                end 
              end
              if hh = 0
                hh = t1 - 1 
              end
              stem_down_flag |= ndata(ii,PS_STEM) >> 2 
            end
            repeater_case |= bit(1,ndata(ii,PS_STEM)) 
            if ndata(ii,PS_PASS) = p1 
              ndata(ii,PS_PASS) = 0
            end
            if ndata(ii,PS_PASS) = p2 
              ndata(ii,PS_PASS) = 0
            end
          end
        repeat
        if hh > 45 
          hh = 45 
        end
        if ff > 0               /*  put in stem up restraints
          if ndata(ii,PS_NSTYLE) = 0       /* modern 
            t5 = ps_width - hpar(90) 
            t4 = ps_width 
          else                             /* New  &dA01/08/11&d@ 
            t5 = ps_width / 2 
            t4 = t5 
          end 
          if repeater_case = 1 
            aa = t5 - hpar(98) 
            bb = t4 + hpar(98) 
          else 
            aa = t5 
            bb = t4 
          end 
          if stem_up_flag > 0 
            if stem_up_flag > 2 
              ff += stem_up_flag - 2 << 1 
            end 
            if ndata(ii,PS_NSTYLE) = 0       /* modern 
              dd = t4 + hpar(26) 
            else                             /* New  &dA01/08/11&d@ 
              dd = t4 / 2 + hpar(26) 
            end 
          else 
            dd = t4 
          end 
          if ff > 45 
            ff = 45 
          end 
          loop for ii = ff - 6 to ff
            if tl(t3,ii) > aa 
              tl(t3,ii) = aa 
            end
            if tr(t3,ii) < bb 
              tr(t3,ii) = bb 
            end
            if pseudo_tr(t3,ii) < dd 
              pseudo_tr(t3,ii) = dd 
            end 
          repeat
          loop for ii = t1 + 2 to ff - 7 
            if tl(t3,ii) > t5 
              tl(t3,ii) = t5 
            end
            if tr(t3,ii) < t4 
              tr(t3,ii) = t4 
            end
          repeat
        end
        if hh > 0               /*  put in stem down restraints
          t1 = t1 - 7
          if stem_down_flag > 0 
            if stem_down_flag > 2 
              t1 -= stem_down_flag - 2 << 1 
            end 
            dd = hpar(90) + hpar(26) 
          else 
            dd = hpar(90) 
          end 
          if t1 < 1
            t1 = 1
          end
&dA 
&dA &d@      Fixing the left border on stems down with repeaters 
&dA &d@      &dA06/04/08&d@   plus bug correction  &dA11/23/09&d@ 
&dA 
#if XPOS_FIXED 
          loop for ii = t1 + 4 to hh 
            if tl(t3,ii) > 0             /* aa 
              tl(t3,ii) = 0              /* aa 
            end
            if tr(t3,ii) < hpar(90)      /* bb 
              tr(t3,ii) = hpar(90)       /* bb 
            end
            if pseudo_tr(t3,ii) < dd 
              pseudo_tr(t3,ii) = dd 
            end 
          repeat
#else 
          loop for ii = t1 + 4 to hh 
            if tl(t3,ii) > 0   /* aa 
              tl(t3,ii) = 0    /* aa 
            end
            if tr(t3,ii) < bb       
              tr(t3,ii) = bb          
            end
            if pseudo_tr(t3,ii) < dd 
              pseudo_tr(t3,ii) = dd 
            end 
          repeat
#endif 

          if repeater_case = 1 
            aa = 0 - hpar(98) 
            bb = hpar(90) + hpar(98) 
          else 
            aa = 0 
            bb = hpar(90) 
          end 

          loop for ii = t1 to t1 + 3           /* 4 is magic number 
            if tl(t3,ii) > aa                 /* Repeaters only at bottom 
              tl(t3,ii) = aa 
            end
            if tr(t3,ii) < bb       
              tr(t3,ii) = bb          
            end
            if pseudo_tr(t3,ii) < dd 
              pseudo_tr(t3,ii) = dd 
            end 
          repeat
        end

        if x = 10000
          loop for ii = 1 to 45 
            gr(t3,ii) = tr(t3,ii)
            gl(t3,ii) = tl(t3,ii) 
            pseudo_gr(t3,ii) = pseudo_tr(t3,ii) 
          repeat
          x = 0                   /* amount shifted to the right 
        else
          ff = 1000
          loop for ii = 1 to 45 
            gg = 1000 - gr(t3,ii) + tl(t3,ii) - hpar(90)  /* &dA01/08/11&d@  hpar(90) replaces "5"
            if gg < ff
              ff = gg
            end
          repeat
          x = 1000 - ff           /* amount shifted to the right 
          loop for ii = 1 to 45 
            gg = x + tr(t3,ii)
            if gg > gr(t3,ii) and tr(t3,ii) <> -200 
              gr(t3,ii) = gg
            end
            gg = x + pseudo_tr(t3,ii) 
            if gg > pseudo_gr(t3,ii) and pseudo_tr(t3,ii) <> -200 
              pseudo_gr(t3,ii) = gg 
            end
            gg = x + tl(t3,ii) 
            if gg < gl(t3,ii) 
              gl(t3,ii) = gg
            end 
          repeat
        end

        loop for jj = 1 to 45 
          if pseudo_gl(1,jj) > pseudo_tl(1,jj) 
            pseudo_gl(1,jj) = pseudo_tl(1,jj) 
          end 
          if pseudo_gl(2,jj) > pseudo_tl(2,jj) 
            pseudo_gl(2,jj) = pseudo_tl(2,jj) 
          end 
        repeat 

        printpos(p1) = x
        if p2 <> 100 
          printpos(p2) = x 
        end 
      return
