
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
&dA &d@³P* 42. get_source                                                             ³
&dA &d@³                                                                              ³
&dA &d@³    Operation:  (1) Read the source file.  Strip off any "@" lines at         ³
&dA &d@³                the top.  Put the result in table [UR].  We will need         ³
&dA &d@³                a dedicated counter for this table: urcnt                     ³
&dA &d@³                (2) Using any "@" lines found, and the output from            ³
&dA &d@³                the get_options procedure, determine the final values         ³
&dA &d@³                for each of the program options.                              ³
&dA &d@³                                                                              ³
&dA &d@³    Inputs:     Source_type:  0 = Musedata                                    ³
&dA &d@³                              1 = Page specific i-files                       ³
&dA &d@³                                                                              ³
&dA &d@³    Output:     (1) in table UR(900000), length = urcnt                       ³
&dA &d@³                (2) options set                                               ³
&dA &d@³                                                                              ³
&dA &d@³      int Addfiles:  0 (default) = no files                                   ³
&dA &d@³                     1           = Musedata files                             ³
&dA &d@³                     2           = I-files                                    ³
&dA &d@³                     3           = Both Dmuse and I-files                     ³
&dA &d@³                                                                              ³
&dA &d@³      int Cfactor: default = 100                                              ³
&dA &d@³                                                                              ³
&dA &d@³      int Debugg:  default = 0                                                ³
&dA &d@³                   no number = 0x01                                           ³
&dA &d@³                  bit 0 of #:  ON = print error messages                      ³
&dA &d@³                  bit 1 of #:  ON = print all diagnostics                     ³
&dA &d@³                  bit 3 of #:  ON = print measure numbers from autoset        ³
&dA &d@³                  bit 4 of #:  ON = print diagnostics from mskpage            ³
&dA &d@³                  bit 5 of #:  ON = print diagnostics from pspage             ³
&dA &d@³                                                                              ³
&dA &d@³      int Vspace_flag: default = 0                                            ³
&dA &d@³                                                                              ³
&dA &d@³                  0 = don't try to extend vertical space to the bottom        ³
&dA &d@³                        of the page                                           ³
&dA &d@³                  1 = extend vertical space to the bottom of the page         ³
&dA &d@³                        using proportional expansion                          ³
&dA &d@³                  2 = extend vertical space to the bottom of the page         ³
&dA &d@³                        using inter system spacing only                       ³
&dA &d@³                                                                              ³
&dA &d@³      int Granddist: default = 100                                            ³
&dA &d@³                                                                              ³
&dA &d@³      int Min_space: default = 100                                            ³
&dA &d@³                                                                              ³
&dA &d@³      int Just_flag: default = 0   1 = right justify last system              ³
&dA &d@³                                                                              ³
&dA &d@³      int Length_of_page:  default = 2740 dots                                ³
&dA &d@³                                                                              ³
&dA &d@³      int Marg_left:  default = 200 dots                                      ³
&dA &d@³                                                                              ³
&dA &d@³      int Max_sys_cnt:  default = 0  -> no maximum                            ³
&dA &d@³                                                                              ³
&dA &d@³      int Minshort:  default = 0  -> let the program decide                   ³
&dA &d@³                                                                              ³
&dA &d@³      int W(32):  default, all zero  -> let the program decide                ³
&dA &d@³                                                                              ³
&dA &d@³      int Sys_width:  default = 2050 dots                                     ³
&dA &d@³                                                                              ³
&dA &d@³      int Top_of_page:  default = 120 dots                                    ³
&dA &d@³                                                                              ³
&dA &d@³      int Defeat_flag:  0 = no defeats                                        ³
&dA &d@³                  bit 0 of #:  ON = defeat all part inclusion suggestions     ³
&dA &d@³                  bit 1 of #:  ON = defeat all line control suggestions       ³
&dA &d@³                                                                              ³
&dA &d@³      int Notesize:  default = size-14   supported sizes = 6,14,16,18,21      ³
&dA &d@³                                                                              ³
&dA &d@³      str Syscode:  default = ""  -> let the program decide                   ³
&dA &d@³                                                                              ³
&dA &d@³      str Group:  default = "score"                                           ³
&dA &d@³                                                                              ³
&dA &d@³      int eof_flag:  0 = "/eof" at the end of each S2 file module (default)   ³
&dA &d@³                     1 = "/END" = "/eof"                                      ³
&dA &d@³                                                                              ³
&dA &d@³      str Work_name: optional work name (default = NULL)                      ³
&dA &d@³                                                                              ³
&dA &d@³      str Work_number: optional work number (default = NULL)                  ³
&dA &d@³                                                                              ³
&dA &d@³      str Composer: optional composer name (default = NULL)                   ³
&dA &d@³                                                                              ³
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
      procedure get_source 
        str command_line.400
        str save_command_line.400 
        str temp_s.100,temp_g.100 
        str temp_w.180,temp_n.80,temp_c.120 
        str cr.1 
        str temp.100,record.180,save_record.180 
        str @lines.180(100) 
        int @cnt,@flag 
        int t1,t2,t3 
        int t11 
        int z_size,vnum 

        cr = chr(13) 
        if C_Notesize <> -1         /* set the "active" z_size here 
          z_size = C_Notesize 
        else 
          z_size = 14 
        end 
&dA 
&dA &d@    Step 1: put in the lowest level defaults 
&dA 
        Syscode = "" 
        Addfiles    = 0    
        Cfactor     = 100 
        Debugg      = 0 
        Vspace_flag = 0 
        Granddist   = 100 
        Min_space   = 100 
        Just_flag   = 0 
        Length_of_page = 2740 
        Top_of_page = 120  
        Marg_left   = 200 
        Max_sys_cnt = 0 
        Minshort    = 0 
        loop for t1 = 1 to 32 
          W(t1) = 0 
        repeat 
        Sys_width   = 2050 
        Defeat_flag = 0 
        Notesize    = 14 
        Group       = "score" 
        Work_name   = "" 
        Work_number = "" 
        Composer    = "" 
        eof_flag = 0 
&dA 
&dA &d@    Step 2: put in the highest level defaults 
&dA 
        if C_Syscode <> "NULL" 
          Syscode = C_Syscode 
        end 
        if C_Group <> "NULL" 
          Group = C_Group 
        end 
        if C_Work_name <> "NULL" 
          Work_name = C_Work_name 
        end 
        if C_Work_number <> "NULL" 
          Work_number = C_Work_number 
        end 
        if C_Composer <> "NULL" 
          Composer = C_Composer 
        end 
        if C_Cfactor <> -1 
          Cfactor = C_Cfactor 
        end 
        if C_Addfiles <> -1 
          Addfiles = C_Addfiles 
        end 
        if C_Vspace_flag <> -1 
          Vspace_flag = C_Vspace_flag 
        end 
        if C_eof_flag <> -1 
          eof_flag = C_eof_flag 
        end 
        if C_Granddist <> -1 
          Granddist = C_Granddist 
        end 
        if C_Min_space <> -1 
          Min_space = C_Min_space 
        end 
        if C_Just_flag <> -1 
          Just_flag = C_Just_flag 
        end 
        if C_Length_of_page <> -1 
          Length_of_page = C_Length_of_page 
        end 
        if C_Top_of_page <> -1 
          Top_of_page = C_Top_of_page 
        end 
        if C_Marg_left <> -1 
          Marg_left = C_Marg_left 
        end 
        if C_Max_sys_cnt <> -1 
          Max_sys_cnt = C_Max_sys_cnt 
        end 
        if C_Minshort <> -1 
          Minshort = C_Minshort 
        end 
        if C_W(1) <> 0 
          loop for t1 = 1 to 32 
            W(t1) = C_W(t1) 
          repeat 
        end 
        if C_Sys_width <> -1 
          Sys_width = C_Sys_width 
        end 
        if C_Defeat_flag <> -1 
          Defeat_flag = C_Defeat_flag 
        end 
        if C_Notesize <> -1 
          Notesize = C_Notesize 
        end 
&dA 
&dA &d@    Step 3: Read source into UR table; get "@" lines at the top 
&dA 
        urcnt = 0 
        @cnt = 0 
        @flag = 0 
#if DMUSE 
        putc Source file?  
        getc temp 
        open [1,1] temp 
        loop      
          getf [1] record 
          record = record // pad(1) 
          if @flag = 0 
            if record{1} <> "@" 
              record = trm(record) 
              ++urcnt 
              tput [UR,urcnt] ~record 
              @flag = 1 
            else 
              ++@cnt 
              @lines(@cnt) = record 
            end 
          else 
            ++urcnt 
            tput [UR,urcnt] ~record 
          end 
        repeat 
eof1: 
        close [1] 
#else 
        save_record = "pyrzqxgl" 
        t3 = 0                        /* duplicate counter 
        loop 
          getc record 
          t2 = len(record) 
          if record{t2} = cr 
            record = record{1,t2-1} 
          end 
          if record = save_record     /* "backup" halting apparatus 
            ++t3 
            if t3 = 20 
              urcnt -= 20             /* i.e., you received 20 "extra" records from pipe
              goto IEND 
            end 
          else 
            t3 = 0 
            save_record = record 
          end 
          if @flag = 0 
            if record{1} <> "@" 
              record = trm(record) 
              ++urcnt 
              tput [UR,urcnt] ~record 
              @flag = 1 
            else 
              ++@cnt 
              @lines(@cnt) = record 
            end 
          else 
            ++urcnt 
            tput [UR,urcnt] ~record 
            record = record // pad(4) 
            if Source_type = 0 
              if record{1,2} = "//"     /* Normal halting apparatus for S2 sources
                goto IEND 
              end 
            else 
              if record{1,4} = "/eof"   /* Normal halting apparatus for i-file sources
                goto IEND 
              end 
            end 
          end 
        repeat 
IEND: 
#endif 
&dA 
&dA &d@    Step 4: Process any "@" lines found 
&dA 
        if @cnt > 0 
          temp_g = "" 
          temp_s = "" 
          temp_w = "" 
          temp_n = "" 
          temp_c = "" 
          loop for t11 = 1 to @cnt 
            record = @lines(t11) // pad(80) 
            if record{1,9} <> "@muse2psv" 
              goto NO_NEWOP 
            end 
            vnum = int(record{10..}) 
            t2 = sub 
            if record{t2} <> "=" 
              goto NO_NEWOP 
            end 
            ++t2 
            if record{t2} <> "=" 
              if record{t2} <> "z" 
                goto NO_NEWOP 
              end 
              ++t2 
              t3 = int(record{t2..}) 
              t2 = sub 
              if t3 <> z_size or record{t2} <> "=" 
                goto NO_NEWOP 
              end 
            end 
            ++t2 
&dA &d@           
&dA &d@        Here is where the "in-line" command line gets processed 
&dA 
            command_line = " " // record{t2..} // " " 
&dA 
&dA &d@    Step 4a: strip strings from command line 
&dA 
G_COMAGN: 
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
                  goto G_COMAGN 
                end 
              end 
            end 
&dA 
&dA &d@    Step 4b: Now look for and set options
&dA 
            if C_Syscode = "NULL" 
              if temp_s <> "" 
                Syscode = temp_s    
              end 
            end 

            if C_Group = "NULL" 
              if temp_g <> "NULL" 
                if "score^parts^skore^short^sound^data^" con temp_g 
                  Group = temp_g 
                end 
              end 
            end 

            if C_Work_name = "NULL" 
              if temp_w <> "NULL" 
                Work_name = temp_w 
              end 
            end 

            if C_Work_number = "NULL" 
              if temp_n <> "NULL" 
                Work_number = temp_n 
              end 
            end 

            if C_Composer = "NULL" 
              if temp_c <> "NULL" 
                Composer = temp_c 
              end 
            end 

            if C_Cfactor = -1 
              if command_line con "c" 
                t1 = mpt+1 
                Cfactor = int(command_line{t1..}) 
              end 
            end 

            if C_Addfiles = -1 
              if command_line con "M" or command_line con "P" 
                Addfiles = 0 
                if command_line con "M" 
                  Addfiles |= 0x01 
                end 
                if command_line con "P" 
                  Addfiles |= 0x02 
                end 
              end 
            end 

            if command_line con "p"    /* Source_type can be changed here 
              Source_type = 1 
              if Addfiles > 0 
                Addfiles &= 0x02       /* make sure 0x01 is off 
              end 
            end 

            if C_Vspace_flag = -1 
              if command_line con "f" 
                t1 = mpt+1 
                if "012" con command_line{t1} 
                  Vspace_flag = mpt - 1 
                else 
                  Vspace_flag = 1 
                end 
              end 
              if command_line con "F" 
                Vspace_flag = 2 
              end 
            end 

            if C_eof_flag = -1 
              if command_line con "E" 
                eof_flag = 1 
              end 
            end 

            if C_Granddist = -1 
              if command_line con "g" 
                t1 = mpt+1 
                Granddist = int(command_line{t1..}) 
              end 
            end 

            if C_Min_space = -1 
              if command_line con "h" 
                t1 = mpt+1 
                Min_space = int(command_line{t1..}) 
              end 
            end 

            if C_Just_flag = -1 
              if command_line con "j" 
                t1 = mpt+1 
                if "01" con command_line{t1} 
                  Just_flag = mpt - 1 
                else 
                  Just_flag = 1 
                end 
              end 
            end 

            if C_Length_of_page = -1 
              if command_line con "l" 
                t1 = mpt+1 
                Length_of_page = int(command_line{t1..}) 
              end 
            end 

            if C_Top_of_page = -1 
              if command_line con "t" 
                t1 = mpt+1 
                Top_of_page = int(command_line{t1..}) 
              end 
            end 

            if C_Marg_left = -1 
              if command_line con "m" 
                t1 = mpt+1 
                Marg_left = int(command_line{t1..}) 
              end 
            end 

            if C_Max_sys_cnt = -1 
              if command_line con "n" 
                t1 = mpt+1 
                Max_sys_cnt = int(command_line{t1..}) 
              end 
            end 

            if C_Minshort = -1 
              if command_line con "Q" 
                t1 = mpt+1 
                Minshort = int(command_line{t1..}) 
              end 
            end 

            if C_W(1) = 0 
              if command_line con "v" 
                t1 = mpt 
                t2 = 0 
                loop while "0123456789" con command_line{t1+1} 
                  ++t1 
                  ++t2 
                  W(t2) = int(command_line{t1..}) 
                  t1 = sub 
                repeat while command_line{t1} = "," 
              end 
            end 

            if C_Sys_width = -1 
              if command_line con "w" 
                t1 = mpt+1 
                Sys_width = int(command_line{t1..}) 
              end 
            end 

            if C_Defeat_flag = -1 
              if command_line con "x" or command_line con "y" 
                Defeat_flag = 0 
                if command_line con "x" 
                  Defeat_flag |= 0x01 
                end 
                if command_line con "y" 
                  Defeat_flag |= 0x02 
                end 
              end 
            end 

            if C_Notesize = -1 
              if command_line con "z" 
                t1 = mpt+1 
                t3 = int(command_line{t1..}) 
                if chr(t3) in [6,14,16,18,21] 
                  Notesize = t3 
                  z_size = Notesize       /* somewhat tricky code 
                end 
              end 
            end 
NO_NEWOP: 
          repeat 
        end 
      return 
