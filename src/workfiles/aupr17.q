
&dA &d@������������������������������������������������������������Ŀ 
&dA &d@�P* 17. subj                                                 � 
&dA &d@�                                                            � 
&dA &d@�    Purpose:  write sub-object to intermediate list         � 
&dA &d@�                                                            � 
&dA &d@�    Inputs:  x = horizontal position of sub-object          � 
&dA &d@�             y = vertical position of sub-object            � 
&dA &d@�             z = character number                           � 
&dA &d@�             obx = object offset from staff x-position      � 
&dA &d@�             oby = object offset from staff y-position      � 
&dA &d@�             sobcnt = counter in intermediate list          � 
&dA &d@�������������������������������������������������������������� 
      procedure subj   
        ++sobcnt
        sobx = x - obx
        soby = y - oby 
        sobl(sobcnt) = "K " // chs(sobx) // " " // chs(soby) // " "
        sobl(sobcnt) = sobl(sobcnt) // chs(z) 
      return 
