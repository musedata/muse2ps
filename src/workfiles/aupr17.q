
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 17. subj                                                 ³ 
&dA &d@³                                                            ³ 
&dA &d@³    Purpose:  write sub-object to intermediate list         ³ 
&dA &d@³                                                            ³ 
&dA &d@³    Inputs:  x = horizontal position of sub-object          ³ 
&dA &d@³             y = vertical position of sub-object            ³ 
&dA &d@³             z = character number                           ³ 
&dA &d@³             obx = object offset from staff x-position      ³ 
&dA &d@³             oby = object offset from staff y-position      ³ 
&dA &d@³             sobcnt = counter in intermediate list          ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure subj   
        ++sobcnt
        sobx = x - obx
        soby = y - oby 
        sobl(sobcnt) = "K " // chs(sobx) // " " // chs(soby) // " "
        sobl(sobcnt) = sobl(sobcnt) // chs(z) 
      return 
