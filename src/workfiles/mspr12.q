
&dA &d@������������������������������������������������������������������Ŀ 
&dA &d@�M* 12a. save3                                                     � 
&dA &d@�                                                                  � 
&dA &d@�    Purpose:  Execute a small segment of code that occures        � 
&dA &d@�                often                                             � 
&dA &d@�                                                                  � 
&dA &d@�������������������������������������������������������������������� 
      procedure save3 
        int t1 
        if rec > 400000 
          tmess = 66 
          perform dtalk (tmess) 
        end 
        cflag = 0 
        tget [Z,rec] line .t3 jtype ntype dvar1 oby z snode dincf 
*  dinct will be 10000 when there is a centered rest 
        if dincf = 10000                     
          dincf = 0 
          cflag = 1 
        end 
        if dincf = 10001 
          cflag = 1 
        end 
      return 
 
&dA &d@������������������������������������������������������������������Ŀ 
&dA &d@�M* 12b. save4                                                     � 
&dA &d@�                                                                  � 
&dA &d@�    Purpose:  Execute a small segment of code that occures        � 
&dA &d@�                often                                             � 
&dA &d@�                                                                  � 
&dA &d@�������������������������������������������������������������������� 
      procedure save4 
        str line2.200 
S4:     tget [Z,crec] line2 .t3 cjtype cntype cdv coby cz csnode 
        if line2{1} <> "J" 
          ++crec 
          goto S4 
        end 
        if "CKTDBSFIM" con cjtype 
          if mpt < 6 
            cntype = 13 + mpt 
          else 
            cntype = 17 
          end 
        end 
      return 
