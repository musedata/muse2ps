
&dA &d@�������������������������������������������������������������������Ŀ 
&dA &d@�P*  7. superfor (operates on an entire chord at once)              � 
&dA &d@�                                                                   � 
&dA &d@�    Purpose:  Get new snums for forward tie, forward slurs and     � 
&dA &d@�                forward tuplet                                     � 
&dA &d@�                                                                   � 
&dA &d@�    Inputs:      c1 = pointer to top of chord                      � 
&dA &d@�                 c2 = pointer to bottom of chord                   � 
&dA &d@�           passtype = type of pass (reg,cue,grace,cuegrace)        � 
&dA &d@�            passnum = pass number                                  � 
&dA &d@�                  x = x co-ordinate of object                      � 
&dA &d@�                  y = y co-ordinate of object                      � 
&dA &d@�         super_flag = composite of SUPER_FLAGs for this chord      � 
&dA &d@�          slur_flag = composite of SLUR_FLAGs for this chord       � 
&dA &d@�               stem = stem direction                               � 
&dA &d@�         color_flag = put out ties in color  (&dA12/21/10&d@)            � 
&dA &d@�                                                                   � 
&dA &d@�    Function: If there is a forward tie, this procedure increments � 
&dA &d@�              snum and puts result in tv4(.,1).  The color for     � 
&dA &d@�              that tie is put in tv4(.,2)                          � 
&dA &d@�              If there are forward slurs, this procedure increments� 
&dA &d@�              snum and stores results in the appropriate           � 
&dA &d@�              slurar(.,SL_NEXTSNUM).                               � 
&dA &d@�              If there is a forward tuplet, this procedure         � 
&dA &d@�              increments snum and constructs the tuar for this     � 
&dA &d@�              tuplet.                                              � 
&dA &d@�              For all cases, the procedure increments supcnt and   � 
&dA &d@�              adds the new super-object number to supnums(.) for   � 
&dA &d@�              later output in the object record.                   � 
&dA &d@��������������������������������������������������������������������� 
      procedure superfor 
        int t1,t2 

        tiecnt = 0 
        loop for c3 = c1 to c2 
          color_flag = ts(c3,SUBFLAG_1) >> 28  /* Added &dA12/21/10&d@ 
          if bit(0,ts(c3,SUPER_FLAG)) = 1      /* if tie starts 
            ++snum 
            ++supcnt 
            supnums(supcnt) = snum 
            ++tiecnt 
            tv4(tiecnt,1) = snum 
            tv4(tiecnt,2) = color_flag 
          end 
        repeat 
        loop for t1 = 1 to 8 
          t2 = t1 * 2 - 2 
          if t1 > 4 
            t2 += 8 
          end 
          if bit(t2,slur_flag) = 1             /* if slur starts 
            ++snum 
            ++supcnt 
            supnums(supcnt) = snum 
            slurar(t1,SL_NEXTSNUM) = snum 
          else 
            slurar(t1,SL_NEXTSNUM) = 0 
          end 
        repeat 
        if bit(4,super_flag) = 1 
          ++snum 
          ++supcnt 
          supnums(supcnt) = snum 
          tuar(passtype,passnum,TU_SNUM) = snum 
          tuar(passtype,passnum,TU_Y1) = y 
          if stem = UP 
            tuar(passtype,passnum,TU_Y2) = y 
          else 
            tuar(passtype,passnum,TU_Y2) = ts(c1,STAFFLOC) 
          end 
          tuar(passtype,passnum,TU_FSTEM) = stem 
          t1 = super_flag & 0x3c0                 /* bits 6,7,8,9 &dA03-21-97&d@ 
          t1 <<= 2 
          tuar(passtype,passnum,TU_FSTEM) |= t1   /* tuplet flags &dA03-21-97&d@ 
        end 
      return   
