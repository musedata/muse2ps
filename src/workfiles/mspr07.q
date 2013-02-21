
&dA &d@������������������������������������������������������������������Ŀ 
&dA &d@�M*  7. setckt                                                     � 
&dA &d@�                                                                  � 
&dA &d@�    Purpose:  Generate entries in marr for possible clef, key,    � 
&dA &d@�                time and clef signatures in that order            � 
&dA &d@�                (snode = 6913)                                    � 
&dA &d@�                                                                  � 
&dA &d@�    Input:  marc =  index into marr array                         � 
&dA &d@�          f(.,6) =  record pointer in part (.)                    � 
&dA &d@�         f(.,10) =  active measure flag for part (.)              � 
&dA &d@�      olddist(.) =  value of x-coordinate for previous object     � 
&dA &d@�                                                                  � 
&dA &d@�    Outputs:  Entries in marc for clef, key and time signature    � 
&dA &d@�                 when any of these are present                    � 
&dA &d@�              Updated marc and f(.,6) pointers                    � 
&dA &d@�              Updated olddist(.)                                  � 
&dA &d@�              Updated ldist                                       � 
&dA &d@�              rmarg changed (this will be changed back to hxpar(4)� 
&dA &d@�                 at CF: if signatures are not at end of line)     � 
&dA &d@�                                                                  � 
&dA &d@�    Internal variables:  tarr(.)                                  � 
&dA &d@�                                                                  � 
&dA &d@�������������������������������������������������������������������� 
      procedure setckt 
        int t1,t2,t3,t4,t5,t6 
        int firstclef 
        int tarr4(32,4) 

&dA &d@  check for presence of clef, key, time and clef (again) 

        loop for f12 = 1 to f11 
          loop for t1 = 1 to 4 
            tarr4(f12,t1) = 0 
          repeat 
        repeat 
        loop for t1 = 1 to 4 
          tarr(t1) = 0 
        repeat 

        t3 = 0 
        t4 = 0 
        loop for f12 = 1 to f11  
          firstclef = 0 
          notesize = f(f12,14) 
          if f(f12,10) = 0 
            rec = f(f12,6) 
CKT1:       perform save3              /* oby not used here 
            ++rec
            if line{1} = "J" 
              if snode <> 6913 
                t2 = dvar1 - olddist(f12) 
                if t2 > t3 
                  t3 = t2               /* constructing maximum distance 
                end  
                goto CKT2  
              end  
              if "CKT" con jtype 
                if mpt > 1                        
                  firstclef = 1       /* K or T encountered 
                else 
                  if firstclef = 1 
                    mpt = 4           /* Clef after K or T 
                  end 
                end 
                ++tarr4(f12,mpt)          /* here is where we count 
              end  
            end  
            goto CKT1  
          end  
CKT2:
          loop for t1 = 1 to 4 
            if tarr4(f12,t1) > tarr(t1) 
              tarr(t1) = tarr4(f12,t1)      /* we want maximum of count for each sign
            end 
          repeat 
        repeat 
&dA 
&dA &d@  t3 = maximum distance from bar line to first object beyond signatures 
&dA 
        loop for t1 = 1 to 4 
          if tarr(t1) > 0 
            t4 = 1 
            ++marc
            marr(marc,PRE_DIST) = 0           
            if t1 < 4 
              marr(marc,MNODE_TYPE) = 13 + t1 
            else 
              marr(marc,MNODE_TYPE) = 14       /* Clef following Key or Time
            end 
            marr(marc,TIME_NUM)  = 0          
            marr(marc,SNODE)     = 6913 
            marr(marc,ACT_FLAG)  = 0 
            marr(marc,M_ADJ)     = adj_space 
            marr(marc,MARR_TEMP) = 0

            t5 = 0  
            t6 = 1               /* for constructing marr(marc,ACT_FLAG) 
            loop for f12 = 1 to f11  
              if tarr4(f12,t1) > 0 
                --tarr4(f12,t1) 
                notesize = f(f12,14) 
                if f(f12,10) = 0 
                  rec = f(f12,6) 
CKT3:             perform save3           /* oby not used here 
                  ++rec 
                  if line{1} = "J" and jtype = "CKTC"{t1} 
                    marr(marc,ACT_FLAG) |= t6        
                    t2 = dvar1 - olddist(f12) 
                    if t2 > marr(marc,PRE_DIST)      
                      marr(marc,PRE_DIST) = t2       
                    end 
                    ++t5 
                    tdist(t5,1) = f12 
                    tdist(t5,2) = dvar1 
                    f(f12,6) = rec 
                    goto CKT4 
                  end 
                  if rec < f(f12,2) 
                    goto CKT3 
                  end 
                end 
              end 
CKT4: 
              t6 <<= 1 
            repeat 
            perform adjolddist 
            ldist += marr(marc,PRE_DIST)      
            t3 -= marr(marc,PRE_DIST)          
          end  
          --tarr(t1) 
          if tarr(t1) > 0  /* if more than one of a sign, 
            --t1           /*   go though loop again 
          end 
        repeat 
&dA 
&dA &d@  If t4 = 1, t3 = maximum distance from last signature to the first 
&dA &d@     object beyond signatures.  
&dA 
        if t4 = 1 
          false_rmarg = hxpar(4) - t3     
        end  
      return 
