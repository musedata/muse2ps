
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³M* 11. do_more_supers (t1,htype)                                  ³ 
&dA &d@³                                                                  ³ 
&dA &d@³     Purpose:  Continuation of super-object processing            ³ 
&dA &d@³                                                                  ³ 
&dA &d@³     Inputs:  t1 = index into super-object data sets              ³ 
&dA &d@³                                                                  ³ 
&dA &d@³     Internal:  a1,a2                                             ³ 
&dA &d@³                                                                  ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure do_more_supers (t1,htype) 
        str tline.180,htype.1 
        int t1,t2 
        getvalue t1,htype 

        if htype = "V" 
&dA 
&dA &d@  structure of transp super-object:  4. situation: 0=8av up, 1=8av down 
&dA &d@                                     5. horiz. disp. from obj1  
&dA &d@                                     6. horiz. disp. from obj2  
&dA &d@                                     7. vert. disp. from obj1 
&dA &d@                                     8. length of right vertical hook 
&dA 
          tline = txt(line,[' '],lpt) 
          t2 = int(tline) 
          tline = txt(line,[' '],lpt) 
          x1 = int(tline) 
          tline = txt(line,[' '],lpt) 
          x2 = int(tline)     /* + superdata(f12,t1,3) 
          tline = txt(line,[' '],lpt) 
          y1 = int(tline)     /* + superdata(f12,t1,2) 
          tline = txt(line,[' '],lpt) 
          a1 = int(tline) 
          if superdata(f12,t1,5) = 0 
            if justflag < 2 
              ++mainyp 
              tput [Y,mainyp] ~superline 
            end 
            x1 += superdata(f12,t1,1) 
          else 
            x1 = hxpar(8) - sp - notesize 
            if justflag < 2 
*      create mark at beginning of line (mindful of virtual staff possibility) 
              if superdata(f12,t1,2) > 700 and f(f12,12) = 2 
                ++mainyp 
                tput [Y,mainyp] J M 0 ~x1  1000 0 6913 0 1 ~supernum 
                y1 -= 1000 
              else 
                ++mainyp 
                tput [Y,mainyp] J M 0 ~x1  0 0 6913 0 1 ~supernum 
              end 
*      create "second half" of superobject (objects are out of order but will be reversed)
              ++mainyp 
              tput [Y,mainyp] H ~supernum  V ~t2  0 ~x2  ~y1  ~a1 
            end 
          end  
          return 
        end  
        if htype = "E" 
&dA 
&dA &d@  structure of ending super-object:  4. ending number (0 = none)  
&dA &d@                                     5. horiz. disp. from obj1  
&dA &d@                                     6. horiz. disp. from obj2  
&dA &d@                                     7. vert. disp. from staff lines  
&dA &d@                                     8. length of left vertical hook  
&dA &d@                                     9. length of right vertical hook 
&dA 
          tline = txt(line,[' '],lpt) 
          t2 = int(tline) 
          tline = txt(line,[' '],lpt) 
          x1 = int(tline) 
          tline = txt(line,[' '],lpt) 
          x2 = int(tline)       /* + superdata(f12,t1,3) 
          tline = txt(line,[' '],lpt) 
          y1 = int(tline) 
          tline = txt(line,[' '],lpt) 
          a1 = int(tline) 
          tline = txt(line,[' '],lpt) 
          a2 = int(tline) 
          if superdata(f12,t1,5) = 0 
            if justflag < 2 
              ++mainyp 
              tput [Y,mainyp] ~superline 
            end 
            x1 += superdata(f12,t1,1) 
          else 
            x1 = hxpar(8) - sp - mvpar(f12,3) 
            if superdata(f12,t1,6) = 0 or superdata(f12,t1,5) = 3        /* New &dA05/06/08
              a1 = 0 
              if superdata(f12,t1,5) <> 3 
                t2 = 0 
              end 
            end  
            if justflag < 2 
*      create mark at beginning of line  
              ++mainyp 
              tput [Y,mainyp] J M 0 ~x1  0 0 6913 0 1 ~supernum 
*      create "second half" of superobject (objects are out of order but will be reversed)
              ++mainyp 
              tput [Y,mainyp] H ~supernum  E ~t2  0 ~x2  ~y1  ~a1  ~a2 
            end 
          end  
          superdata(f12,t1,5) = 0        /* New &dA05/06/08&d@   Clear these to make
          superdata(f12,t1,6) = 0        /*   sure they are not used elsewhere.
          superdata(f12,t1,7) = 0 

          return 
        end  
        if htype = "D" 
&dA 
&dA &d@  structure of dashes super-object:  4. horiz. disp. from obj1  
&dA &d@                                     5. horiz. disp. from obj2  
&dA &d@                                     6. vert. disp. from staff lines  
&dA &d@                                     7. spacing parameter 
&dA &d@                                     8. font designator 
&dA 
          tline = txt(line,[' '],lpt) 
          x1 = int(tline) 
          tline = txt(line,[' '],lpt) 
          x2 = int(tline)     /* + superdata(f12,t1,3) 
          tline = txt(line,[' '],lpt) 
          y1 = int(tline) 
          tline = txt(line,[' '],lpt) 
          a1 = int(tline) 
          tline = txt(line,[' '],lpt) 
          a2 = int(tline) 
          if superdata(f12,t1,5) = 0 
            if justflag < 2 
              ++mainyp 
              tput [Y,mainyp] ~superline 
            end 
            x1 += superdata(f12,t1,1) 
          else 
            x1 = hxpar(8) - sp 
            if justflag < 2 
*      create mark at beginning of line (mindful of virtual staff possibility)
              if superdata(f12,t1,2) > 700 and f(f12,12) = 2 
                ++mainyp 
                tput [Y,mainyp] J M 0 ~x1  1000 0 6913 0 1 ~supernum 
              else 
                ++mainyp 
                tput [Y,mainyp] J M 0 ~x1  0 0 6913 0 1 ~supernum 
              end 
*      create "second half" of superobject (objects are out of order but will be reversed)
              ++mainyp 
              tput [Y,mainyp] H ~supernum  D 0 ~x2  ~y1  ~a1  ~a2 
            end 
          end 
          return 
        end 
        if htype = "R" 
&dA 
&dA &d@  structure of trill super-object:  4. situation: 1 = no trill, only ~~~~ 
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
          tline = txt(line,[' '],lpt) 
          x2 = int(tline)     /* + superdata(f12,t1,3) 
          tline = txt(line,[' '],lpt) 
          y1 = int(tline) + superdata(f12,t1,2) 
          if superdata(f12,t1,5) = 0 
            if justflag < 2 
              ++mainyp 
              tput [Y,mainyp] ~superline 
            end 
            x1 = int(tline) + superdata(f12,t1,1) 
          else 
            a1 = 1 
            x1 = hxpar(8) - sp - notesize 
            if justflag < 2 
*      create mark at beginning of line (mindful of virtual staff possibility)
              if superdata(f12,t1,2) > 700 and f(f12,12) = 2 
                ++mainyp 
                tput [Y,mainyp] J M 0 ~x1  1000 0 6913 0 1 ~supernum 
                y1 -= 1000 
              else 
                ++mainyp 
                tput [Y,mainyp] J M 0 ~x1  0 0 6913 0 1 ~supernum 
              end 
*      create "second half" of superobject (objects are out of order but will be reversed)
              ++mainyp 
              tput [Y,mainyp] H ~supernum  R ~a1  0 ~x2  ~y1 
            end 
          end 
          return 
        end 
        if htype = "W" 
&dA 
&dA &d@  structure of wedge super-object:  4. left spread 
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
          tline = txt(line,[' '],lpt) 
          y1 = int(tline) 
          tline = txt(line,[' '],lpt) 
          x2 = int(tline)     /* + superdata(f12,t1,3) 
          tline = txt(line,[' '],lpt) 
          y2 = int(tline) 
          a1 = superdata(f12,t1,5) 
          if a1 = 0 
            if justflag < 2 
              ++mainyp 
              tput [Y,mainyp] ~superline 
            end 
          else 
            x1 = hxpar(8) - sp 
            c1 = a1 
            if justflag < 2 
*      create mark at beginning of line (mindful of virtual staff possibility)
              if superdata(f12,t1,2) > 700 and f(f12,12) = 2 
                ++mainyp 
                tput [Y,mainyp] J M 0 ~x1  1000 0 6913 0 1 ~supernum 
              else 
                ++mainyp 
                tput [Y,mainyp] J M 0 ~x1  0 0 6913 0 1 ~supernum 
              end 
*      create "second half" of superobject (objects are out of order but will be reversed)
              ++mainyp 
              tput [Y,mainyp] H ~supernum  W ~c1  ~c2  0 ~y1  ~x2  ~y2 
            end 
          end 
          return 
        end 
      return 
 
