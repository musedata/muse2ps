
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
&dA &d@³P* 34. guessbeam (slope, t12)                                                 ³
&dA &d@³                                                                              ³
&dA &d@³                                                                              ³
&dA &d@³    Purpose:  Make a guess about the position of a beam                       ³
&dA &d@³                                                                              ³
&dA &d@³    Inputs:   int  c6            = number of notes under beam                 ³
&dA &d@³              int  mf(.)         = y-position of note                         ³
&dA &d@³              int  beamcode(.)   = beam code                                  ³
&dA &d@³              int  stem          = stem direction (UP/DOWN)                   ³
&dA &d@³              int  c5            = size: 0 = regular; 1 = small               ³
&dA &d@³                                                                              ³
&dA &d@³    Outputs:  int slope  = BHPAR1 * slope of beam                             ³
&dA &d@³              int t12    = end point of first stem (relative to top of staff) ³
&dA &d@³                                                                              ³
&dA &d@³    Internal variables:  beamfy = y coordinate of first note under beam       ³
&dA &d@³                         vrange = vertical range of note set                  ³
&dA &d@³                         zstaff = top of staff line                           ³
&dA &d@³                          slope = slope of beam                               ³
&dA &d@³                           ypiv = temporary variable                          ³
&dA &d@³                        (x1,y1) = temporary coordinates                       ³
&dA &d@³                        (x2,y2) = temporary coordinates                       ³
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
      procedure guessbeam (slope, t12) 
        int t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12 
        int zstaff,ypiv,slope 
        int x1,x2,y1,y2,vrange,beamfy 
        int xf(100) 
        int beamh,beamt,bthick 
        int beamtype 
        int loopcnt 
*  
        if c5 = 0 
          beamh = bvpar(16) 
          beamt = bvpar(32) 
          bthick = vpar(2) * 6 / 14 
        else 
          beamh = bvpar(16) * 4 / 5 
          beamt = bvpar(32) * 4 + 3 / 5 
          bthick = vpar(2) * 5 / 14 
        end 

        t6 = 0 
        loop for t5 = 1 to c6 
          xf(t5) = t6 
          t6 += vpar(6)                 /* average x increment (a guess) 
        repeat 

        beamfy = mf(1) 
* reverse if stem down 
        t3 = 0 
        if stem = DOWN 
          t3 = 150 * vpar(2) - vpar(8) 
          loop for t6 = 1 to c6 
            mf(t6) = 150 * vpar(2) - mf(t6) 
          repeat 
        end  
        zstaff = t3 
* determine slope and pivot of beam  
        t9  = 0 
        x1  = 5000 
        y1  = 5000 
        t11 = 6 
        t1  = 0 
        t4  = 0          /* changes in absolute height 
        t2  = 0 
        t5  = mf(1) 
&dA 
&dA &d@  identify:  t9 = 6 - smallest note type under beam 
&dA &d@            (x1,y1) = position of note closest to beam  
&dA &d@            (x2,y2) = position of note next closest to beam 
&dA &d@             t1 = y coordinate of note furthest from beam 
&dA 
        loop for t6 = 1 to c6 
*  also compute sum of absolute changes in vertical height 
          t8 = t5 - mf(t6) 
          testfor t8 < 0 
            if t2 = 0  
              t2 = -1  
            end  
            if t2 = 1  
              t2 = 2 
            end  
            t8 = 0 - t8 
          else (>) 
            if t2 = 0 
              t2 = 1 
            end 
            if t2 = -1 
              t2 = 2 
            end 
          end  
          t5 = mf(t6) 
          t4 += t8 
*  
          t8 = 0                 /* number of additional beams on this note 
          loop while beamcode(t6) > 9 
            ++t8 
            beamcode(t6) /= 10 
          repeat 
          if t8 > t9 
            t9 = t8              /* max number of additional beams 
          end 
          if t8 < t11 
            t11 = t8             /* min number of additional beams 
          end 

          t8 = mf(t6) 
          if t8 > t1 
            t1 = t8              /* lowest y co-ord of notes in beam set 
          end 
          if t8 < y1 
            y2 = y1 
            x2 = x1 
            y1 = t8              /* nearest y co-ord 
            x1 = xf(t6) 
          else 
            if t8 < y2 
              y2 = t8 
              x2 = xf(t6) 
            end  
          end  
        repeat 
&dA 
&dA &d@    Check point one: (x1,y1); (x2,y2); t1  set  
&dA 
        vrange = t1 - y1 
&dA 
&dA &d@    Formula for initial stem length 
&dA 
&dA &d@        note     t9      y1-t8 
&dA &d@      ÄÄÄÄÄÄÄ  ÄÄÄÄÄÄ   ÄÄÄÄÄÄÄ 
&dA &d@        8th:      0      beamh  
&dA &d@       16th:      1      beamh + (1 * notesize / 4) 
&dA &d@       32th:      2      beamh + (4 * notesize / 4)   
&dA &d@       64th:      3      beamh + (7 * notesize / 4) 
&dA &d@      128th:      4      beamh + (10 * notesize / 4)  
&dA &d@      256th:      5      beamh + (13 * notesize / 4)  
&dA 
        beamtype = t9 
        if t9 = 0  
          t8 = y1 - beamh  
        else 
          t8 = t9 * 3 - 2    
          t8 = 0 - notesize * t8 / 4 - beamh + y1  
        end  
        t1 = x1  
*   deal with case of severe up-down pattern   
        if t2 = 2  
          t4 /= c6 
          if t4 > bvpar(18) 
            slope = 0 
            goto GSB1 
          end  
        end  
*  
        slope = y1 - y2 * 2 * BHPAR1 
        t7 = x1 - x2 
        slope /= t7 
&dA 
&dA &d@  Comment: slope is (2*BHPAR1) times slope between two notes 
&dA &d@                nearest the beam  
&dA 
        t7 = mf(c6) - mf(1) * 2 * BHPAR1 
        t6 = xf(c6) 
        if t6 < vpar(5)  
          t6 = vpar(5) 
        end  
        t7 /= t6 
&dA 
&dA &d@  Comment: t7 is (2*BHPAR1) times slope between outside notes 
&dA 
&dA &d@  Formula:  slope = (slope + t7) / 6   provided 
&dA 
&dA &d@     |slope| must be equal to or less than |t7| 
&dA 
        t6 = abs(slope) - abs(t7) 
        if t6 > 0 
          if slope > 0 
            slope -= t6 
          else 
            slope += t6 
          end 
        end 
*  
        slope = slope + t7 / 6 
GSB1:   t7 = abs(slope) 
        if t7 > BHPAR1 / 2
          t7 = BHPAR1 / 2 
        end  
*   Soften slant for thirty-seconds and smaller  
        if t9 > 2 and t7 > 5 
          t7 = 0 - t9 / 2 + t7 
        end  
        if t7 < 0  
          t7 = 0 
        end  
&dA 
&dA &d@  set reduce slant if end note are closer than vpar(6)  
&dA 
        t4 = xf(c6) 
        if t4 <= vpar(6)  and  t7 > bvpar(35) 
          t7 = bvpar(35) 
        end  
&dA 
&dA &d@  shorten shortest stem, if gradual slope and large vertical range  
&dA &d@                              and relatively high note  
&dA 
        if vrange > vpar(3) 
          t4 = t9 * beamt + t8 - zstaff 
          t4 = 0 - t4 
          if t4 > vpar(3)  
            if t7 < 6  
              if x1 > 0 and x1 < xf(c6) 
                t8 += bvpar(17) 
              end  
              if c6 = 2 
                t8 += bvpar(17) 
              end  
            end  
          end  
        end  
*  
        if slope < 0 
          slope = 0 - t7 
        else 
          slope = t7 
        end  
&dA 
&dA &d@  slope   = BHPAR1 * slope of beam 
&dA &d@  t8      = y coordinate of pivot point (on highest note) of first beam 
&dA &d@  t7      = absolute value of @m 
&dA &d@  t3      = y coordinate of top of staff line 
&dA &d@  (x1,y1) = coordinate of note closest to beam (highest note) 
&dA &d@  (x2,y2) = coordinate of second closest note to beam (2nd highest note)  
&dA &d@  t9      = 6 - smallest note type number (number of beams - 1 
&dA &d@  t11     = 6 - largest note type number 
&dA 
        ypiv = t8 
        ++t9 
&dA 
&dA &d@    Check point two:  t9 = number of beams, current slope = slope 
&dA 
&dA &d@   Adjust slope and t8 so that beams will fall properly on staff lines 
&dA 
&dA &d@    Case I:   slope = 0 
&dA 
GCSI:   if slope = 0 
          t2 = t9 - 1 * notesize + t8 
          if t2 >= t3 
&dA 
&dA &d@    Adjust flat beam height   
&dA 
            t5 = t2 - t3 / notesize  
            if t9 = 1  and   rem <= bvpar(20) 
              rem += bvpar(20) 
            end  
            if t9 = 2  
              if rem <= bvpar(20) 
                rem += bvpar(34) 
              else 
                rem = rem - notesize + bvpar(20)  
              end  
            end  
            if t9 = 3  
              rem += bvpar(34) 
            end  
            if t9 = 4  
              if t5 = 3  
                beamt = bvpar(33) 
              end  
              if t5 < 3  
                t5 = rem 
                t5 -= vpar(1) / 2
                rem = t5   
              end  
            end  
            t8 -= rem 
*     (*) extremely low notes  
            if t9 = 1  
              t2 = vpar(4) + zstaff 
            else 
              t2 = 4 - t9 * vpar(2) + zstaff 
            end  
            if t8 > t2 
              t8 = t2 
              if t9 > 3  and  c5 = 0 
                beamt = bvpar(33) 
              end  
            end  
          end  
        else 
&dA 
&dA &d@    Case II:   slope <> 0 
&dA 
          loopcnt = 0 
GCSII:    
          ++loopcnt 
          t6 = 0 - x1 * slope / BHPAR1 + t8 
          t5 = xf(c6) * slope / BHPAR1 + t6 
          t2 = t5 + t6 / 2 
          if t9 > 1  
            if t11 > 0  
              t2 += beamt 
              if t9 = 2  
                t2 += 2 
              end  
            end  
            t10 = bvpar(22)  
          else 
            t10 = bvpar(23)  
          end  
&dA &d@  t6  = starting point of top beam 
&dA &d@  t5  = stopping point of top beam 
&dA &d@  t2  = average height of beam (second beam if always 2 or more) 
&dA &d@  t10 = fudge factor 
          t4 = t3 
          t3 -= notesize 
          if t9 > 2  
            t3 -= notesize 
          end  
          if t2 > t3 
&dA 
&dA &d@    Adjust slanted beam height  
&dA 
            if t9 > 2  
              if t2 > t4 
                beamt = bvpar(33) 
              else 
                t2 -= 2 
              end  
            end  
            t4 = abs(t5 - t6) 
            t5 = t2 - t3 / notesize  
            t5 = rem 
&dA &d@  t4 = rise/fall of beam  
&dA &d@  t5 = amount by which the average beam height lies below a line  
            if t4 < bvpar(24) 
              if t5 >= t10 
                t5 -= notesize 
                if t9 = 1  
                  ++t5 
                end  
              else 
                if t9 = 1  
                  --t5 
                end  
              end  
              t8 -= t5 
              goto GCV  
            end  
            if t4 < beamt  
              if loopcnt > 4 
                goto GCV 
              end 
              if t7 > 1  
                goto GCSJJ  
              end  
              ++t7 
              if slope < 0 
                slope = 0 - t7 
              else 
                slope = t7 
              end  
              goto GCSII  
            end  
            if t4 < bvpar(25) 
              c16 = t5 * 2 / vpar(2) 
              if rem <> 0 
                ++t5 
              end 
              t5 += vpar(1) 

              if t5 > t10 
                t5 -= notesize 
              end  
              t8 -= t5 
              goto GCV  
            end  
            if t4 > bvpar(26) 
              if t5 > t10      
                t5 -= notesize 
              end  
              t8 -= t5 
              goto GCV  
            end  
            if t7 = 2  
              c16 = t5 * 2 / vpar(2) 
              if rem <> 0 
                ++t5 
              end 
              t5 += vpar(1) 

              if t5 > t10 
                t5 -= notesize 
              end  
              t8 -= t5 
              goto GCV  
            end  
            if loopcnt > 4 
              goto GCV 
            end 
GCSJJ:      --t7 
            if slope < 0 
              slope = 0 - t7 
            else 
              slope = t7 
            end  
            goto GCSII  
          else 
            if t9 < 4  
              t8 = notesize / 3 + t8 
            end  
          end  
*   Check for extra low notes  
GCV:      t4 = 0 - x1 * slope / BHPAR1 + t8 
          t6 = xf(c6) - x1 * slope / BHPAR1 + t8 
          t5 = 0 
          if t9 = 1  
            t2 = vpar(4) + zstaff - 2 
          else 
            t2 = 4 - t9 * notesize + zstaff - 2 
          end  
          if slope > 0 
            if t4 > t2 
              t5 = 1 
              t4 = t2 + 1  
            end  
          else 
            if t6 > t2 
              t5 = 1 
              t6 = t2 + 1  
            end  
          end  
          t2 = t2 + bvpar(20) + 2 
          if slope > 0 
            if t6 > t2 
              t5 = 1 
              t6 = t2 
            end  
          else 
            if t4 > t2 
              t5 = 1 
              t4 = t2 
            end  
          end  
          if t5 = 1  
*    Correction necessary  
            t7 = xf(c6) 
            slope = t6 - t4 * BHPAR1 / t7 
            t8 = x1 * slope / BHPAR1 + t4 
            t7 = abs(slope) 
          end  
          t8 -= vpar(1) / 2
        end  
*  
        t12 = slope * t1 
        t12 = t8 * BHPAR1 - t12 
&dA 
&dA &d@    Check point three:  beam slope = slope; 
&dA &d@                        y intercept (times BHPAR1) = t12 
&dA 
&dA &d@     Post adjustment:  sometimes the stems of sixteenths are too  
&dA &d@       short.  This will be the case when (y2-t8) - ((t9-1)*beamt) < xxx  
&dA &d@       where xxx is some number.  In this case, we should raise the 
&dA &d@       beam by some small amount, yyy.  
&dA 
        t6 = 0 - (t9 - 1) * beamt + y2 - t8 
        if t6 < bvpar(29) 
          t12 -= bvpar(30) * BHPAR1 
        end  
&dA 
&dA &d@     In the case where c6 = 4, compare sum of the first two notes 
&dA &d@     verses the last two notes.  If the direction is different from 
&dA &d@     the slope, then the slope should be zero.  
&dA 
        if c6 = 4 
          t2 = mf(1) + mf(2) 
          t3 = mf(3) + mf(4) 
          if t2 > t3 
            if slope > 0 
              goto GSB2 
            end  
          end  
          t2 = t2 - t3 * slope 
          if t2 > 0  
            goto GSB2 
          end  
          goto GSB3 
GSB2:     slope = 0 
          t3 = zstaff 
          t8 = ypiv 
          goto GCSI 
        end  
GSB3: 
&dA 
&dA &d@  slope = BHPAR1 * slope of beam 
&dA &d@  t12   = y-intercept of beam (times BHPAR1) 
&dA 

        t8 = vpar(6) / 7 
        if beamtype > 0 
          t8 = vpar(5) / 4 
        end 
        t12 /= BHPAR1 

        if stem = DOWN 
          t12 = 150 * vpar(2) - t12 + bthick - t8
          slope = 0 - slope 
        else 
          t12 += t8
        end  
        passback slope, t12 
      return 
