
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P* 28. key_change (newkey, oldkey, nstaves, t1, t2)   ³ 
&dA &d@³                                                      ³ 
&dA &d@³    Purpose:  Typeset a key change                    ³ 
&dA &d@³                                                      ³ 
&dA &d@³    Inputs:   int  newkey    new key                  ³ 
&dA &d@³              int  oldkey    old key                  ³ 
&dA &d@³              int  nstaves   number of staves         ³ 
&dA &d@³              int  t1        operation code           ³ 
&dA &d@³                               1 = change emptyspace  ³ 
&dA &d@³                               0 = don't do it        ³ 
&dA &d@³              int  t2        part of new key in       ³ 
&dA &d@³                               parenthesis  &dA08/23/06&d@  ³ 
&dA &d@³                                                      ³ 
&dA &d@³    Global variables:                                 ³ 
&dA &d@³                                                      ³ 
&dA &d@³              sobcnt         subobject counter        ³ 
&dA &d@³              p              x position pointer       ³ 
&dA &d@³              x              actual x-coordinate      ³ 
&dA &d@³              y              actual y-coordinate      ³ 
&dA &d@³              z              font number              ³ 
&dA &d@³              obx            object x-coordinate      ³ 
&dA &d@³              oby            object y-coordinate      ³ 
&dA &d@³              clef(.)        current clef             ³ 
&dA &d@³              measax(.,.)    current measure ax array ³ 
&dA &d@³              claveax(.)     global ax array          ³ 
&dA &d@³              jtype          object type              ³ 
&dA &d@³              jcode          object code              ³ 
&dA &d@³              pcode          number of sub objects    ³ 
&dA &d@³              out            ASCII string             ³ 
&dA &d@³                                                      ³ 
&dA &d@³    Outputs:    p = new x position                    ³ 
&dA &d@³                emptyspace(.,.) changed (if t1 = 1)   ³ 
&dA &d@³                                                      ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure key_change (newkey, oldkey, nstaves, t1, t2)    /* t2 added &dA08/23/06
        int newkey, oldkey, nstaves 
        int save_oldkey                          /* added &dA11/05/05&d@ 
        int sy 
        int hh 
        int t1,t2,t3,t4,t5,t6,t7,t8,t9 
        int klave,sklave 
        int tenor 
        int m1,m2,m3,m4,m5,m6                    /* added &dA08/23/06&d@ 

        getvalue newkey, oldkey, nstaves, t1, t2 

        if t2 <> 0                               /* magic numbers for editorial [] &dA08/23/06
          m1 = (2 * notesize + 3 / 6) 
          m2 = (4 * notesize + 3 / 6) 
          m3 = (7 * notesize + 3 / 6) 
          m4 = notesize + 3 / 6 
          m5 = (5 * notesize + 3 / 6) 
          m6 = notesize 
        end 

        t3 = newkey                  /* added &dA08/23/06&d@ 
        newkey = newkey + t2         /* added &dA08/23/06&d@ 
&dA 
&dA &d@    This code added &dA11/26/06&d@ to allow reprint of existing key signature 
&dA 
        if newkey = oldkey and key_reprint_flag > 0 
          oldkey = 0 
        end 
&dA                &d@ End of &dA11/26/06&d@ addition 

&dA                                                                
&dA 
&dA &d@    New code.  &dA10/15/07&d@.  It used to be the case that a non key 
&dA &d@    change in an orchestra part (such as horns) simply returned 
&dA &d@    at this point.  No i-file entry was generated because none was 
&dA &d@    needed.  The problem created by this was that if the mskpage 
&dA &d@    program was looking for a key change node (because other parts 
&dA &d@    had one) and didn't find one, this could cause a misalignment 
&dA &d@    of control node.  It turns out that the program crashed only 
&dA &d@    when the key change came at the end of a line, so nothing was 
&dA &d@    done about it.  (The bug was rare, and difficult to identify).  
&dA &d@    The advent of justification made the bug more likely to occur, 
&dA &d@    and it did (once too often).  So I decided on this fix, namely: 
&dA &d@     
&dA &d@    From now on, all key changes will generate a "J K" node, even 
&dA &d@    if there is none to be printed.  In this case, the node will 
&dA &d@    have no sub-objects and will therefore be "silent."  This seems 
&dA &d@    to have caused no other problems with the programs.  
&dA 

        if newkey = oldkey 
          loop for hh = 1 to nstaves 
            putobjpar = 0 
            sobcnt = 0 
            oby = 0 
            obx = p 
            x = obx 
            jtype = "K" 
            jcode = newkey 
            pcode = 0             
            out = "0" 
            oby = (hh - 1) * 1000 
            perform putobj 
          repeat 
          return 
        end 
&dA 
&dA &d@    End of &dA10/15/07&d@ addition 
&dA 
&dA                                                               &d@    

&dA                                                                
&dA 
&dA &d@    New code.  &dA11/02/07&d@.   Another situation has come up, which 
&dA &d@    I believe can be dealt with here.  In the case where the timpani 
&dA &d@    plays on the notes B-flat and F, the notation shows these two 
&dA &d@    pitches without a key signature.  In order to make this work, the 
&dA &d@    encoder used the pitches B-natural and F, and a key signature of 
&dA &d@    0 (no sharps or flats).  This of course would wreck havoc in a 
&dA &d@    midi file.  It would be far better to encode the key as -1 (one 
&dA &d@    flat) and then encode the pitches B-flat and F, as they would 
&dA &d@    actually sound.  The problem with this is that the key signature 
&dA &d@    would appear at the beginning of every line.  We need to have 
&dA &d@    a way to suppress this.  I propose a new global flag, suppress_key, 
&dA &d@    which can be set by the "k" global suggestion.  The following 
&dA &d@    code deals with this situation.  
&dA 
        if suppress_key > 0 
          save_oldkey = oldkey 
          loop for hh = 1 to nstaves 

*   set up new global accidentals for claveax 

            oldkey = newkey 
            loop for t7 = 1 to 50 
              claveax(t7) = 0 
            repeat 
            t6 = newkey 
            if t6 > 0 
              t5 = 4 
              loop for t7 = 1 to t6 
                loop for t8 = t5 to 50 step 7 
                  claveax(t8) = 2 
                repeat 
                t5 += 4 
                if t5 > 7 
                  t5 -= 7 
                end 
              repeat 
            end 
            if t6 < 0 
              t6 = 0 - t6 
              t5 = 7 
              loop for t7 = 1 to t6 
                loop for t8 = t5 to 50 step 7 
                  claveax(t8) = 3 
                repeat 
                t5 -= 4 
                if t5 < 1 
                  t5 += 7 
                end 
              repeat 
            end 
            oldkey = save_oldkey  

            putobjpar = 0 
            sobcnt = 0 
            oby = 0 
            obx = p 
            x = obx 
            jtype = "K" 
            jcode = 0        
            pcode = 0             
            out = "0" 
            oby = (hh - 1) * 1000 
            perform putobj 
          repeat 

          loop for t7 = 1 to 50 
            loop for t6 = 1 to 4                 /* &dA06/04/08&d@ was 3 
              measax(t6,t7) = claveax(t7) 
            repeat 
          repeat 
          oldkey = newkey                        /* moved &dA11/05/05&d@ 
          passback  oldkey 

          return 
        end 
&dA 
&dA &d@    End of &dA11/02/07&d@ addition 
&dA 
&dA                                                               &d@    

        putobjpar = 0 

        save_oldkey = oldkey                     /* added &dA11/05/05&d@ 
        loop for hh = 1 to nstaves 
          sobcnt = 0 
          oby = 0 
          t7 = clef(hh) / 10 
          klave = rem - 1 * 2
          t7 /= 3 
          t5 = 2 - rem * 3        
          klave -= t5 
          obx = p 
          x = obx 
          tenor = 0 
          if clef(hh) = 12 
            tenor = 2 
          end 
*   sharps 
          if newkey > 0 
*     cancellations?  
            sklave = klave 
            if oldkey > newkey 
              loop for t4 = 1 to newkey 
                klave += zak(1,t4) 
              repeat 
              t6 = oldkey - newkey 
              t9 = 1 + tenor 
              perform cancelsig (t9,t4,t6,klave) 
            end 
            if oldkey < 0 
              t6 = 0 - oldkey 
              klave += 4 
              t4 = 0 
              t9 = 2 
              perform cancelsig (t9,t4,t6,klave) 
            end 
            klave = sklave 
*   set new key 
            if t2 = 0 
              loop for t4 = 1 to newkey 
                z = 63 
                if tenor = 0 or klave >= 0 
                  y = klave + 20 * notesize / 2 - vpar20 
                else 
                  y = klave + 27 * notesize / 2 - vpar20    /* exception for tenor clef
                end 
                perform subj 
                klave += zak(1,t4) 
                x += hpar(9) 
              repeat 
            else 
&dA 
&dA &d@      This code added &dA08/23/06&d@ to deal with editorial additions of sharps 
&dA 
              if t2 > 0 
                loop for t4 = 1 to t3 
                  z = 63 
                  if tenor = 0 or klave >= 0 
                    y = klave + 20 * notesize / 2 - vpar20 
                  else 
                    y = klave + 27 * notesize / 2 - vpar20  /* exception for tenor clef
                  end 
                  perform subj 
                  klave += zak(1,t4) 
                  x += hpar(9) 
                repeat 
                loop for t4 = t3 + 1 to newkey 
                  x += m1                                   /* magic number 
                  z = 67 
                  if tenor = 0 or klave >= 0 
                    y = klave + 20 * notesize / 2 - vpar20 
                  else 
                    y = klave + 27 * notesize / 2 - vpar20  /* exception for tenor clef
                  end 
                  perform subj 
                  x += m2                                   /* magic number 
                  z = 63 
                  perform subj 
                  x += m3                                   /* magic number 
                  z = 68 
                  perform subj 
                  klave += zak(1,t4) 
                  x += (hpar(9) - m3)                       /* magic number 
                repeat 
              end 
&dA 
&dA        &d@ End of &dA08/23/06&d@ addition 
            end 
          end 
*   no sharps or flats 
          if newkey = 0 
*     cancellations?  
            t4 = 0 
            if oldkey > 0 
              t6 = oldkey 
              t9 = 1 + tenor 
              perform cancelsig (t9,t4,t6,klave) 
            end 
            if oldkey < 0 
              t6 = 0 - oldkey 
              t9 = 2 
              klave += 4
              perform cancelsig (t9,t4,t6,klave) 
            end 
          end 
*   flats 
          if newkey < 0 
*     cancellations?  
            sklave = klave 
            if oldkey < newkey 
              t6 = 0 - newkey 
              klave += 4       
              loop for t4 = 1 to t6 
                klave += zak(2,t4) 
              repeat 
              t6 = newkey - oldkey 
              t9 = 2 
              perform cancelsig (t9,t4,t6,klave) 
            end 
            if oldkey > 0 
              t6 = oldkey 
              t4 = 0 
              t9 = 1 + tenor 
              perform cancelsig (t9,t4,t6,klave) 
            end 
            klave = sklave + 4 
*   set new key 
            if t2 = 0 
              t6 = 0 - newkey 
              loop for t4 = 1 to t6 
                z = 65 
                y = klave + 20 * notesize / 2 - vpar20 
&dA 
&dA &d@   Code added &dA09/13/06&d@ to fix flats in soprano clef 
&dA 
                if y > vpar(8) 
                  y -= vpar(7) 
                end 
&dA      
                perform subj 
                klave += zak(2,t4) 
                x += hpar(11) 
              repeat 
            else 
&dA 
&dA &d@      This code added &dA08/23/06&d@ to deal with editorial additions of flats  
&dA 
              if t2 < 0 
                t3 = 0 - t3 
                t6 = 0 - newkey 
                loop for t4 = 1 to t3 
                  z = 65 
                  y = klave + 20 * notesize / 2 - vpar20 
&dA 
&dA &d@   Code added &dA09/13/06&d@ to fix flats in soprano clef 
&dA 
                  if y > vpar(8) 
                    y -= vpar(7) 
                  end 
&dA      
                  perform subj 
                  klave += zak(2,t4) 
                  x += hpar(9) 
                repeat 
                loop for t4 = t3 + 1 to t6        
                  x += m4                                   /* magic number 
                  z = 67 
                  y = klave + 20 * notesize / 2 - vpar20 
&dA 
&dA &d@   Code added &dA09/13/06&d@ to fix flats in soprano clef 
&dA 
                  if y > vpar(8) 
                    y -= vpar(7) 
                  end 
&dA      
                  perform subj 
                  x += m5                                   /* magic number 
                  z = 65 
                  perform subj 
                  x += m6                                   /* magic number 
                  z = 68 
                  perform subj 
                  klave += zak(2,t4) 
                  x += (hpar(11) - m6)                      /* magic number 
                repeat 
              end 
&dA 
&dA        &d@ End of &dA08/23/06&d@ addition 
            end 
          end 
*   Write out object and subobjects 
          jtype = "K" 
          jcode = newkey 
          pcode = sobcnt 
          out = "0" 
          oby = (hh - 1) * 1000 
          perform putobj 
* 
          if newkey = 0 and oldkey = 0 
            t7 = hpar(13) 
            if t1 = 1 
              loop for t4 = 1 to 45 
                emptyspace(hh,t4) += t7 
              repeat 
            end 
          else 
            t7 = hpar(12) 
            if t1 = 1 
              loop for t4 = 1 to 45 
                emptyspace(hh,t4) = t7 
              repeat 
            end 
          end 
        
          if hh = nstaves 
            p = x + t7 
          end 
*   set up new global accidentals for claveax 
          oldkey = newkey 
          loop for t7 = 1 to 50 
            claveax(t7) = 0 
          repeat 
          t6 = newkey 
          if t6 > 0 
            t5 = 4 
            loop for t7 = 1 to t6 
              loop for t8 = t5 to 50 step 7 
                claveax(t8) = 2 
              repeat 
              t5 += 4 
              if t5 > 7 
                t5 -= 7 
              end 
            repeat 
          end 
          if t6 < 0 
            t6 = 0 - t6 
            t5 = 7 
            loop for t7 = 1 to t6 
              loop for t8 = t5 to 50 step 7 
                claveax(t8) = 3 
              repeat 
              t5 -= 4 
              if t5 < 1 
                t5 += 7 
              end 
            repeat 
          end 
          oldkey = save_oldkey                   /* changed &dA11/05/05&d@ (was oldkey = newkey)
        repeat 
        loop for t7 = 1 to 50 
          loop for t6 = 1 to 4                   /* &dA06/04/08&d@ was 3 
            measax(t6,t7) = claveax(t7) 
          repeat
        repeat 
        oldkey = newkey                          /* moved &dA11/05/05&d@ 
        passback  oldkey 
      return 
