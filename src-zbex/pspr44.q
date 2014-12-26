
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 44. not_very_messy                                          ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose: get slurpar and tiepar parameters from the        ³ 
&dA &d@³                slurpars glob                                  ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure not_very_messy 
        str big_slurpars.1500000 
        str temp2.480 
        str rec.400,delim.2 
        int a1,a2,a3,a4 
        int t1,t2,t3
        int start 

        open [8,8] slurpars 
        len(big_slurpars) = sze 
        read [8] big_slurpars 
        close [8] 

        delim = chr(13) // chr(10) 
        start = 1 
        loop for t1 = 1 to 11 
          loop for t2 = 1 to 11 
            loop for t3 = 1 to 6 
              if big_slurpars{start..} con delim 
                slurpar06(t1,t2,t3) = big_slurpars{start..sub-1} 
                start = sub + 2 
              end 
            repeat 
          repeat 
        repeat 
        loop for t1 = 1 to 11 
          loop for t2 = 1 to 11 
            loop for t3 = 1 to 6 
              if big_slurpars{start..} con delim 
                slurpar14(t1,t2,t3) = big_slurpars{start..sub-1} 
                start = sub + 2 
              end 
            repeat 
          repeat 
        repeat 
        loop for t1 = 1 to 11 
          loop for t2 = 1 to 11 
            loop for t3 = 1 to 6 
              if big_slurpars{start..} con delim 
                slurpar16(t1,t2,t3) = big_slurpars{start..sub-1} 
                start = sub + 2 
              end 
            repeat 
          repeat 
        repeat 
        loop for t1 = 1 to 11 
          loop for t2 = 1 to 11 
            loop for t3 = 1 to 6 
              if big_slurpars{start..} con delim 
                slurpar18(t1,t2,t3) = big_slurpars{start..sub-1} 
                start = sub + 2 
              end 
            repeat 
          repeat 
        repeat 
        loop for t1 = 1 to 11 
          loop for t2 = 1 to 11 
            loop for t3 = 1 to 6 
              if big_slurpars{start..} con delim 
                slurpar21(t1,t2,t3) = big_slurpars{start..sub-1} 
                start = sub + 2 
              end 
            repeat 
          repeat 
        repeat 
&dA 
&dA &d@    Get tie parameters 
&dA 
        loop for a1 = 1 to 12 
          loop for a2 = 1 to 4 
            loop for a4 = 1 to 12 
              if big_slurpars{start..} con delim 
                temp2 = big_slurpars{start..sub-1} 
                start = sub + 2 
              end 
              a3 = 0 
              t1 = 1 
              t3 = 0 
              sub = 0 
              loop while a3 < ( TIE_DISTS ) 
                if temp2{t1} = "+" 
                  t2 = int(temp2{t1+1..}) 
                  t1 = sub - 1 
                else 
                  t2 = ors(temp2{t1}) 
                  if t2 < 96 
                    t2 -= 64 
                  else 
                    t2 = 96 - t2 
                  end 
                end 
                t3 += t2 
                ++a3 
                tiearr(a1,a2,a3,a4) = t3 
                ++t1 
              repeat 
            repeat 
          repeat 
        repeat 

      return 
