
&dA &d@������������������������������������������������������������Ŀ 
&dA &d@�P* 18. subj2     /* Addition to Code &dA02/25/97&d@               � 
&dA &d@�                                                            � 
&dA &d@�    Purpose:  write "invisible" sub-object to               � 
&dA &d@�                intermediate list                           � 
&dA &d@�                                                            � 
&dA &d@�    Inputs:  x = horizontal position of sub-object          � 
&dA &d@�             y = vertical position of sub-object            � 
&dA &d@�             z = character number                           � 
&dA &d@�             obx = object offset from staff x-position      � 
&dA &d@�             oby = object offset from staff y-position      � 
&dA &d@�             sobcnt = counter in intermediate list          � 
&dA &d@�������������������������������������������������������������� 
      procedure subj2 
        ++sobcnt
        sobx = x - obx
        soby = y - oby 
        sobl(sobcnt) = "k " // chs(sobx) // " " // chs(soby) // " "
        sobl(sobcnt) = sobl(sobcnt) // chs(z)   
      return 

&dA &d@������������������������������������������������������������Ŀ 
&dA &d@�P* 18b. subj3 (cc)        Addition to Code &dA12/21/10&d@         � 
&dA &d@�                                                            � 
&dA &d@�    Purpose:  write "color" sub-object to                   � 
&dA &d@�                intermediate list                           � 
&dA &d@�                                                            � 
&dA &d@�    Inputs:  x = horizontal position of sub-object          � 
&dA &d@�             y = vertical position of sub-object            � 
&dA &d@�             z = character number                           � 
&dA &d@�             obx = object offset from staff x-position      � 
&dA &d@�             oby = object offset from staff y-position      � 
&dA &d@�             sobcnt = counter in intermediate list          � 
&dA &d@�������������������������������������������������������������� 

      procedure subj3 (cc) 
        str temp.80 
        int cc 
        getvalue cc 

        cc &= 0x3 
        ++sobcnt 
        sobx = x - obx 
        soby = y - oby 
        temp = "C " 
        if cc = 2 
          temp = temp // "0x00ff00 " 
        else 
          if cc = 3 
            temp = temp // "0x0000ff " 
          end 
        end 
        sobl(sobcnt) = temp // chs(sobx) // " " // chs(soby) // " " // chs(z)
      return 
