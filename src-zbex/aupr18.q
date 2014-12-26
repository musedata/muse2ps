
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 18. subj2     /* Addition to Code &dA02/25/97&d@               ³ 
&dA &d@³                                                            ³ 
&dA &d@³    Purpose:  write "invisible" sub-object to               ³ 
&dA &d@³                intermediate list                           ³ 
&dA &d@³                                                            ³ 
&dA &d@³    Inputs:  x = horizontal position of sub-object          ³ 
&dA &d@³             y = vertical position of sub-object            ³ 
&dA &d@³             z = character number                           ³ 
&dA &d@³             obx = object offset from staff x-position      ³ 
&dA &d@³             oby = object offset from staff y-position      ³ 
&dA &d@³             sobcnt = counter in intermediate list          ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure subj2 
        ++sobcnt
        sobx = x - obx
        soby = y - oby 
        sobl(sobcnt) = "k " // chs(sobx) // " " // chs(soby) // " "
        sobl(sobcnt) = sobl(sobcnt) // chs(z)   
      return 

&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 18b. subj3 (cc)        Addition to Code &dA12/21/10&d@         ³ 
&dA &d@³                                                            ³ 
&dA &d@³    Purpose:  write "color" sub-object to                   ³ 
&dA &d@³                intermediate list                           ³ 
&dA &d@³                                                            ³ 
&dA &d@³    Inputs:  x = horizontal position of sub-object          ³ 
&dA &d@³             y = vertical position of sub-object            ³ 
&dA &d@³             z = character number                           ³ 
&dA &d@³             obx = object offset from staff x-position      ³ 
&dA &d@³             oby = object offset from staff y-position      ³ 
&dA &d@³             sobcnt = counter in intermediate list          ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 

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
