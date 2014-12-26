
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
&dA &d@³P* 41. get_options                                                            ³
&dA &d@³                                                                              ³
&dA &d@³    Operation:  Read and process the command line.                            ³
&dA &d@³                                                                              ³
&dA &d@³    Inputs:     terminal (at the moment)                                      ³
&dA &d@³                                                                              ³
&dA &d@³    Output:     options set                                                   ³
&dA &d@³                                                                              ³
&dA &d@³      int Source_type:  0 = Musedata                                          ³
&dA &d@³                        1 = Page specific i-files                             ³
&dA &d@³                                                                              ³
&dA &d@³      int C_Addfiles: -1 = Not present in command line                        ³
&dA &d@³                       0 = no files                                           ³
&dA &d@³                       1 = Musedata files                                     ³
&dA &d@³                       2 = I-files                                            ³
&dA &d@³                       3 = Both Dmuse and I-files                             ³
&dA &d@³                                                                              ³
&dA &d@³      int C_Cfactor: -1 = Not present in command line                         ³
&dA &d@³                                                                              ³
&dA &d@³      int C_Debugg:  -1 = Not present in command line                         ³
&dA &d@³                     no number = 0x01                                         ³
&dA &d@³                  bit 0 of #:  ON = print error messages                      ³
&dA &d@³                  bit 1 of #:  ON = print all diagnostics                     ³
&dA &d@³                  bit 3 of #:  ON = print measure numbers from autoset        ³
&dA &d@³                  bit 4 of #:  ON = print diagnostics from mskpage            ³
&dA &d@³                  bit 5 of #:  ON = print diagnostics from pspage             ³
&dA &d@³                                                                              ³
&dA &d@³      int C_Vspace_flag: -1 = Not present in command line                     ³
&dA &d@³                                                                              ³
&dA &d@³                  0 = don't try to extend vertical space to the bottom        ³
&dA &d@³                        of the page                                           ³
&dA &d@³                  1 = extend vertical space to the bottom of the page         ³
&dA &d@³                        using proportional expansion                          ³
&dA &d@³                  2 = extend vertical space to the bottom of the page         ³
&dA &d@³                        using inter system spacing only                       ³
&dA &d@³                                                                              ³
&dA &d@³      int C_Granddist: -1 = Not present in command line                       ³
&dA &d@³                                                                              ³
&dA &d@³      int C_Min_space: -1 = Not present in command line                       ³
&dA &d@³                                                                              ³
&dA &d@³      int C_Just_flag: -1 = Not present in command line                       ³
&dA &d@³                        0 = do not right justify last system                  ³
&dA &d@³                        1 = right justify last system                         ³
&dA &d@³                                                                              ³
&dA &d@³      int C_Length_of_page:  -1 = Not present in command line                 ³
&dA &d@³                                                                              ³
&dA &d@³      int C_Marg_left:  -1 = Not present in command line                      ³
&dA &d@³                                                                              ³
&dA &d@³      int C_Max_sys_cnt:  -1 = Not present in command line                    ³
&dA &d@³                                                                              ³
&dA &d@³      int C_Minshort:  -1 = Not present in command line                       ³
&dA &d@³                                                                              ³
&dA &d@³      int C_W(32):  all zero  -> Not present in command line                  ³
&dA &d@³                                                                              ³
&dA &d@³      int C_Sys_width:  -1 = Not present in command line                      ³
&dA &d@³                                                                              ³
&dA &d@³      int C_Top_of_page:  -1 = Not present in command line                    ³
&dA &d@³                                                                              ³
&dA &d@³      int C_Defeat_flag:  -1 = Not present in command line                    ³
&dA &d@³                           0 = no defeats                                     ³
&dA &d@³                  bit 0 of #:  ON = defeat all part inclusion suggestions     ³
&dA &d@³                  bit 1 of #:  ON = defeat all line control suggestions       ³
&dA &d@³                                                                              ³
&dA &d@³      int C_Notesize:  -1 = Not present in command line                       ³
&dA &d@³                                                                              ³
&dA &d@³      str C_Syscode:  "NULL" = Not present in command line                    ³
&dA &d@³                                                                              ³
&dA &d@³      str C_Group:  "NULL" = Not present in command line                      ³
&dA &d@³                                                                              ³
&dA &d@³      int C_eof_flag:  -1 = Not present in command line                       ³
&dA &d@³                        1 = "/END" = "/eof"                                   ³
&dA &d@³                                                                              ³
&dA &d@³      str C_Work_name: "NULL" = Not present in command line                   ³
&dA &d@³                                                                              ³
&dA &d@³      str C_Work_number: "NULL" = Not present in command line                 ³
&dA &d@³                                                                              ³
&dA &d@³      str C_Composer: "NULL" = Not present in command line                    ³
&dA &d@³                                                                              ³
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
      procedure get_options 
        str command_line.400,temp.400,temp2.80 
        str save_command_line.400 
        str temp_s.100,temp_g.100 
        str temp_w.180,temp_n.80,temp_c.120 
        str bad_char.1 
        int t1,t2,t3 

        C_Syscode = "NULL" 
        Source_type = 0 
        C_Addfiles  = -1 
        C_Cfactor   = -1 
        C_Debugg    = 0 
        Debugg      = 0 
        C_Vspace_flag = -1 
        C_Granddist = -1  
        C_Min_space = -1 
        C_Just_flag = -1 
        C_Length_of_page = -1   
        C_Marg_left = -1 
        C_Max_sys_cnt = -1 
        C_Minshort    = -1 
        loop for t1 = 1 to 32 
          C_W(t1) = 0 
        repeat 
        C_Sys_width = -1   
        C_Top_of_page = -1 
        C_Defeat_flag = -1 
        C_Notesize    = -1 
        C_Group = "NULL" 
        temp_s = "NULL" 
        temp_g = "NULL" 
        temp_w = "NULL" 
        temp_n = "NULL" 
        temp_c = "NULL" 
        C_Syscode = temp_s 
        C_Work_name = temp_w 
        C_Work_number = temp_n 
        C_Composer = temp_c 
        C_Group = temp_g 
        C_eof_flag = -1 

        getC command_line 
        command_line = trm(command_line) 
        save_command_line = command_line 
        if command_line = "" 
          return 
        end 
        command_line = " " // command_line // " " 
&dA 
&dA &d@    Step 1: strip strings from command line 
&dA 
COMAGN: 
        if command_line con "^" 
          t1 = sub 
          if command_line{t1+1..} con "^" 
            t2 = sub 
            if "GsTuC" con command_line{t1-1} 
              if mpt = 1 
                temp_g = command_line{t1+1..t2-1} 
              end 
              if mpt = 2 
                temp_s = command_line{t1+1..t2-1} 
              end 
              if mpt = 3 
                temp_w = command_line{t1+1..t2-1} 
              end 
              if mpt = 4 
                temp_n = command_line{t1+1..t2-1} 
              end 
              if mpt = 5 
                temp_c = command_line{t1+1..t2-1} 
              end 
              command_line = command_line{1,t1-2} // command_line{t2+1..} 
              goto COMAGN 
            else 
              putc Improper command line syntax 
              pute Command line = ~save_command_line 
              tmess = 101 
              perform dtalk (tmess) 
            end 
          else 
            pute Missing a closing "^" in the command line 
            pute Command line = ~save_command_line 
            tmess = 101 
            perform dtalk (tmess) 
          end 
        end 
&dA 
&dA &d@    Step 2: Set Debugg = 1. This allows command_line 
&dA &d@              errors to be reported 
&dA 
        if command_line con "d" 
          t1 = mpt+1 
          if "0123456789" con command_line{t1} 
            C_Debugg = int(command_line{t1..}) 
          else 
            C_Debugg = 1 
          end 
          Debugg = C_Debugg 
        end 
&dA 
&dA &d@    Step 3: verify that command line starts with "=" 
&dA 
        command_line = mrt(command_line) 
        if command_line{1} <> "=" 
          pute Missing the equals "=" sign at the beginning of the command line
          pute Command line = ~save_command_line 
          tmess = 101 
          perform dtalk (tmess) 
        end 
&dA 
&dA &d@    Step 4: Now look for and set options
&dA 
        C_Syscode = temp_s 
        if temp_g <> "NULL" 
          C_Group = temp_g 
          if "score^parts^skore^short^sound^data^" con C_Group 
          else 
            tmess = 12 
            perform dtalk (tmess) 
          end 
        end 
        C_Work_name = temp_w 
        C_Work_number = temp_n 
        C_Composer = temp_c 

        if command_line con "c" 
          t1 = mpt+1 
          C_Cfactor = int(command_line{t1..}) 
        end 
        if command_line con "M" or command_line con "P" 
          C_Addfiles = 0 
          if command_line con "M" 
            C_Addfiles |= 0x01 
          end 
          if command_line con "P" 
            C_Addfiles |= 0x02 
          end 
        end 
        if command_line con "p" 
          Source_type = 1 
          if C_Addfiles > 0 
            C_Addfiles &= 0x02       /* make sure 0x01 is off 
          end 
        end 
        if command_line con "f" 
          t1 = mpt+1 
          if "012" con command_line{t1} 
            C_Vspace_flag = mpt - 1 
          else 
            C_Vspace_flag = 1 
          end 
        end 
        if command_line con "F" 
          C_Vspace_flag = 2 
        end 
        if command_line con "E" 
          C_eof_flag = 1 
        end 
        if command_line con "g" 
          t1 = mpt+1 
          C_Granddist = int(command_line{t1..}) 
        end 
        if command_line con "h" 
          t1 = mpt+1 
          C_Min_space = int(command_line{t1..}) 
        end 
        if command_line con "j" 
          t1 = mpt+1 
          if "01" con command_line{t1} 
            C_Just_flag = mpt - 1 
          else 
            C_Just_flag = 1 
          end 
        end 
        if command_line con "l" 
          t1 = mpt+1 
          C_Length_of_page = int(command_line{t1..}) 
        end 
        if command_line con "t" 
          t1 = mpt+1 
          C_Top_of_page = int(command_line{t1..}) 
        end 
        if command_line con "m" 
          t1 = mpt+1 
          C_Marg_left = int(command_line{t1..}) 
        end 
        if command_line con "n" 
          t1 = mpt+1 
          C_Max_sys_cnt = int(command_line{t1..}) 
        end 
        if command_line con "Q" 
          t1 = mpt+1 
          C_Minshort = int(command_line{t1..}) 
        end 
        if command_line con "v" 
          t1 = mpt 
          t2 = 0 
          loop while "0123456789" con command_line{t1+1} 
            ++t1 
            ++t2 
            C_W(t2) = int(command_line{t1..}) 
            t1 = sub 
          repeat while command_line{t1} = "," 
        end 
        if command_line con "w" 
          t1 = mpt+1 
          C_Sys_width = int(command_line{t1..}) 
        end 
        if command_line con "x" or command_line con "y" 
          C_Defeat_flag = 0    
          if command_line con "x" 
            C_Defeat_flag |= 0x01 
          end 
          if command_line con "y" 
            C_Defeat_flag |= 0x02 
          end 
        end 
        if command_line con "z" 
          t1 = mpt+1 
          t3 = int(command_line{t1..}) 
          if chr(t3) in [6,14,16,18,21] 
            C_Notesize = t3 
          end 
        end 
&dA 
&dA &d@    Step 5: look for errors of commission 
&dA 
        loop for t1 = 1 to len(command_line) 
          if "ab.:e;[i]k'<>oqrs()+/\ABD|GHIJKLNO_RSUVWXYZ" con command_line{t1}
            bad_char = command_line{t1} 
            pute Command line contains an unrecognized character:  ~bad_char
            pute Command line = ~save_command_line 
            tmess = 101 
            perform dtalk (tmess) 
          end 
          if command_line con chr(34) 
            bad_char = chr(34) 
            pute Command line = ~save_command_line 
            pute Command line contains an unrecognized character:  ~bad_char
            tmess = 101 
            perform dtalk (tmess) 
          end 
        repeat 
      return 
