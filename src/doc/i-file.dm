 
   
               INTERMEDIATE FILES FOR MUSIC PRINTING 
   
                       November 28, 1990     
                       (revised 5-28-93) 
                       (revised 11-11-93) 
                       (revised 9-15-94) 
                       (revised 9-27-94) 
                       (revised 2-25-95) 
                       (revised 8-28-02) 
                       (revised 1-06-04) 
                       (revised 4-26-05) 
                       (revised 3-18-06) 
                       (revised 12-26-10) 

   
I. File Structure  
   
   Variable length ASCII records 
   Fields separated by blanks  
   
II. Types of I-files 
   
    I-files come in four types: linear, page-specific, scrolling 
    page-specific, and multi-page.  

  (1) Linear.  

    These files represent the first step toward generating 
    real musical notation.  MuseData source files are organized 
    as musical parts, which can be combined in various ways 
    to produce musical scores, short scores, parts, and 
    arrangements of parts.  Musical typesetting in this system
    is logically a two step process: (1) translate source data 
    into the i-file format, and (2) combine the individual 
    i-files into real musical notation for display, printing, 
    or conversion to another format, e.g., SCORE format or 
    one of the POSTSCRIPT formats.  

    Linear i-files are not suitable for actual display.  The 
    clef, key and time signatures occur only at the beginning 
    of the file, and there are no line breaks or page breaks.  
    The x-offset parameter increases indefinitely.  

  (2) Page-specific.  

    Page-specific files are the final result of combining    
    one or more individual linear files into a form suitable 
    for display, etc.  Musical data is organized as a set of 
    musical systems, each of which may have one or more lines. 

     1. In order to locate the output on pages of finite horizontal 
        size, the systems and their musical lines are broken at 
        various points.  

     2. Getting the notes in various parts to line up properly 
        requires that the horizontal positions of musical objects 
        in some parts be adjusted.  

     3. In order to achieve right-side justification, horizonal 
        distances between musical objects may be also be altered.  

     4. Clef, key and time signatures are placed at the beginning 
        of every line.  

     5. Ties, slurs, extended hyphens and other multi-measure 
        super-objects may be broken up and continued across line 
        and page boundaries.  

  (3) Scrolling page-specific 

    These files are similar to page-specific files but are designed 
    for scrolling in a display output.  Conditions (1), (3), (4) 
    and (5) above do not hold, since there are no system breaks.  
    Only condition (2) must be met.  This, and the fact that the 
    music is organized into a system of one or more lines are what 
    distinguish scrolling page-specific files from their linear 
    i-file sources.  

  (4) Multi-page (page_specific) files 

    This is a special case of the page-specific format, where 
    several page-specific files are concatenated to form one 
    large file.  The delineator is a record having the following 
    properties: 

      1. Column 1 must contain the letter "P" 

      2. One of the following three conditions must be met.  

         (a) Record length = 1 
         (b) "space" character in column 3 
         (c) The first 4 columns must be the word "Page" 

         These are to insure that we don't confuse the page 
         boundary with a "P" super-object.  

    The last record in a multi-page file must be either a 
    "P" record or the four character string "/eof".  Multi-page 
    files are designed primarily for use as (one form of) input 
    to the muse2ps conversion program.  

   
III. Record Types    
   
      Linear Files                     Page Specific (additional) 
      ------------                     -------------------------- 
       Music Lines                      Systems 
       Objects                          Music Lines (page specific) 
       Sub-objects                      End of Music Line 
       Text (form of sub-object)        System Bar 
       Words (form of sub-object)       Page Text 
       Attribute (form for sub-object)  Page delineators 
       Super-objects 
       Q-records (linear only)   
       Tag records (linear only) 
   
IV. Record Formats -- Linear Files 
   
  A. Music Lines 
   
     Field 1: Identifier = L (or small l = single line staff, e.g., for triangle)
     Field 2: 0 = single staff; # = vertical offset of second staff 
     Field 3: vertical displacement of text line   
     Field 4: notesize (zero if not specified) 
     Field 5: part name (ASCII string) 
       
   
  B. Objects 
   
     Field 1: Identifier = J 
   
     Field 2: type of object    B = bar line 
                                C = clef 
                                K = key signature  
                                T = time signature 
                                D = directive (e.g. time word, etc)
                                S = other symbol 
                                N = note 
                                R = rest 
                                G = grace note 
                                Q = cue note 
                                F = figures  
                                I = isolated directive or symbol (not 
                                      associated with a note, rest, or figure) 
                                M = mark (mostly for superobjects)   
     Field 3: object code  
   
           Bar line:   x = measure number if there be one, else zero
   
           Clef:       x = clef code   
           Key:        x = key code  
           Time sig:   x = time code (100 * tnum + tden)   
           Directive:  0 = print always (parts and score)  
                       bit 0 set = print in parts   
                       bit 1 set = print in score   
                       bit 2 set = print if top part in score   
                       bit 3 set = print if bottom part in score  
                          (bit 1 over-rides bits 2 and 3)   
   
           Symbol:     0 = not identified  
                       4 = extended rest   
                       6 = whole measure rest  

                       From the standpoint of typesetting for a score 
                       the major difference between a directive and a 
                       symbol is that a symbol will always be printed 
                       whether or not the part stands alone or is part 
                       of a score (e.g., letter dynamics), whereas a 
                       directive can be "made invisible" in parts that 
                       are not at the top or the bottom of a score 
                       (e.g., the segno sign).  
   
           Notes:      x = note type   
           Rests:      x = rest type   
           Grace note: x = note type   
           Cue note:   x = note type   
           Figure:     0   
           Isolated:   same as for Directives 
           Mark:       0   
   
     Field 4: horizontal displacement measured in 32-bit precision   
                from beginning of piece  
   
           For objects which are groups of notes (chords),   
           the x co-ordinate is the position of the notes  
           which fall on the proper side of the stem.  For   
           stem up, the object's position is that of the   
           note heads to the left of the stem; for stem down,  
           the object's position is that of the note heads   
           to the right of the stem.   
   
     Field 5: vertical displacement from top staff line  
   
           For objects which are groups of notes (chords), the 
           y co-ordinate is the position of the note which is  
           farthest from the note-end of the stem (and hence 
           closest to a beam, if there be one).  This is impor-  
           tant for the proper setting of beams at print time. 
   
           For objects to be placed on the second (or greater) 
           staff of the grand staff, 1000 (2000) will be added 
           to the displacement.  This means that the print 
           program must check the range of the displacement before 
           placing the object.  

           For Bar type objects, which always have a   
           y co-ordinate of 0, this field contains instead   
           the bar line code:  
                                 1 = single light bar  
                                 2 = single heave bar  
                                 3 = dotted bar  
                                 5 = double light bar  
                                 6 = light-heavy double bar  
                                 9 = heavy-light double bar  
                                10 = heavy-heavy double bar  

               In case the bar object extends to more than one staff 
               an amount equal to 1000 times (n-1) where n is the 
               number of staves is added to the bar line code 

               Note: If the stage2 source file contains a print suggestion 
                     modifying how mskpage deals with the music in the 
                     measure following a bar line, this suggestion is 
                     communicated to the mskpage program in this field.  
                     The suggestion code is multiplied by 1,000,000 (one 
                     million) and added to Field 5.  

                     Print suggestions for dealing with music in a measure: 

                       1 = do not modify the spacings in this measure when 
                           justifying a line of music in a score (used only 
                           by mskpage).  

                       3 = same thing

                     If the stage2 source file contains a print suggestion 
                     requesting that a particular bar line within a movement
                     should be right justified, this suggestion is 
                     communicated to the mskpage program in this field by 
                     adding 10,000,000 (ten million) to Field 5.  

                     These print suggestions apply only to non-page-specific
                     files and are removed by mskpage (and mkpart) after they
                     are utilized.  They do not appear in the page-specific 
                     output.  

     Field 6: print code (or if < 32, number of sub-objects) 
   
     Field 7: space node number  
   
           1. Multiple rests -- number = measures of rest  
   
           2. Everything else -- number = division number  
   
              This number will indicate the division within the  
            measure to which the object belongs.  The measure    
            is divided into 6912 (27 x 256) parts.  Divisions  
            run from 1 to 6912.  It is possible for several  
            objects to have the same space node number.  These   
            objects will have separate numbers in the page-  
            specific format.   
   
     Field 8: distance increment flag.  This flag describes the  
              distance from the preceding object, as well as an  
              attribute of the node:  
   
                 0 = preceding distance should remain fixed    
                      at print time  
   
                 # = preceding distance may vary at print time;  
                      parameter is the duration of the preceding   
                      node, measured in units such that  
                      576 = quarter note.  
     
             10000 = object will be centered between bar lines   
                      (used only with whole measure rests)   
   
     Field 9: number of super-objects associated with this object  
   
     Fields 9a,b...,: super-object numbers   
   
  C. Sub-objects (these must follow directly after their associated  
                    objects) 
   
     Field 1: Identifier = K or C (or k for "silent" Sub-objects) 

                "C" is used in place of "K" to indicate that the 
                sub-object should be displayed in color rather 
                than black.  This feature is used for highlighting.  

        Case 1: Identifier = K or k  (no color) 

           Field 2: horiz. displacement, relative to object co-ordinate 
           Field 3: vertical displacement, relative to object co-ordinate 
           Field 4: print code of sub-object 

        Case 2: Identifier = C

           Field 2: Color specification, three bytes in in 6 digit hex format.

               byte 1: red     (0x00 to 0xff) 
               byte 2: green   (0x00 to 0xff) 
               byte 3: blue    (0x00 to 0xff) 

               Example: 0x808000  = half red, half green, no blue 

           Field 3: horiz. displacement, relative to object co-ordinate 
           Field 4: vertical displacement, relative to object co-ordinate 
           Field 5: print code of sub-object 
   
        Note: If the identifier is "C" and field 2 does not start with the 
              hex format specifier "0x", then the default color Red is 
              assumed, and field 2 is assumed to contain the horizonal 
              displacement, as in the "K" case.  


  D. Text (a form of sub-object attached to note or rest)  
   
     Field 1: Identifier = T 
     Field 2: horizontal displacement of text, relative to object  

                Note: Non-page-specific i-files may have a second 
                parameter attached to field 2 (separated by the "|" 
                character).  The second parameter is the "ideal" 
                displacement of text, relative to the object note 
                under the assumption that we don't have to worry 
                about clashes with adjacent notes.  

     Field 3: vertical code (text line number, between 1 and 10) 
                The vertical code may be followed by the "|" character 
                and a y offset.  The interpretation of the offset is 
                a displacement from the normal position of the line 
                (see page-specific lines below).  
     Field 4: ASCII string 
                If this field = "~", this means that this note is the 
                termination of a forward underline.  

     Field 5: indication of forward hyphen or underline character  
   
                - = forward hyphen   
                _ = forward underline character  
                . =     "         "       "     followed by  . 
                , =     "         "       "        "     "   , 
                : =     "         "       "        "     "   : 
                ; =     "         "       "        "     "   ; 
                ! =     "         "       "        "     "   ! 
                ? =     "         "       "        "     "   ? 
                * = nothing  
   
     Field 6: space taken up by ASCII string 
   
  E. Words (a form of sub-object attached to symbol) 
   
     Field 1: Identifier = W 
     Field 2: horizontal displacement of word(s), relative to  
                 directive or symbol object  
     Field 3: vertical displacement  
     Field 4: font number  
     Field 5: ASCII string (including font designations) 
   
  F. Attributes (a form of sub-object attached to notes/rests) 

     The purpose of attributes is to communication information about 
     an object that is not represented precisely by purely graphical 
     information.  An example is the duration of tuplets.  The tuplet 
     super-object (H . X) references only the end points of a tuplet; 
     there is no precise way to determine the remaining objects whose 
     duration might be effected by the tuplet.  When converting page 
     specific i-files to SCORE pmx files, we need to know the precise 
     duration of all notes.  The only foolproof way to convey this 
     information is in an attribute.  Attributes are ignored 
     in the printing process.  

     Field 1: Identifier = A 
     Field 2: type of attribute 

     1. D = duration 

        Field 3: numerator of duration 
        Field 4: denominator of duration 

            Duration is represented as a proper fraction.  
              1/4 = quarter note 
              1/2 = half note 
              etc.  
            In terms of divisions (from stage2 source representation) 
            the numerator is the number of divisions, and the denominator 
            is four times the divisions per quarter.  

        Field 5: tie (if present) 

          (no field) = situation not determined (older files) 
            0 = no tie
            1 = tie to following note 
            2 = tie appended to selected pitches (multiple pitches only) 

            Note: In the case of a rest, field 5 may be used (optionally) 
                  to indicate that the next duration in this track is 
                  also a rest (a tied rest, in effect) 

        NOTE: Field 5 was introduced in Feb-2006 and might be absent 
                from some older i-files.  

     2. P = pitch 

        Field 3: track number (normally 1) 

        Field 4: base-40 pitch number (C4 = 163)  (0 = rest) 

        Field 5: tie (in case of multiple pitches and ties) 

            0 = no tie                          
            1 = tie to following note    

        NOTE: In case of multiple pitches, there will be multiple    
                A P ...  records.  A P ... records should not precede 
                A D ...  records 


  G. Super-objects (these are things whose shapes depend on the  
           locations of more than one object.  They generally follow 
           after all of their associated objects have been described 
   
     Field 1: Identifier = H or P 

                "P" is used in place of "H" to indicate that the 
                super-object should be displayed in color (in whole 
                or in part) rather than black.  This feature applies 
                only to Ties and Beams and is used for highlighting.  

                If "P" is used, then field 2 must contain the color 
                specification (as with the "C" case of sub-objects), 
                and all subsequent fields are shifted over by one 
                field.  

           Field 2: Color specification, three bytes in in 6 digit hex format.

               byte 1: red     (0x00 to 0xff) 
               byte 2: green   (0x00 to 0xff) 
               byte 3: blue    (0x00 to 0xff) 

               Example: 0x808000  = half red, half green, no blue 

        Note: If the identifier is "P" and field 2 does not start with the 
              hex format specifier "0x", then the default color Red is 
              assumed, and field 2 is assumed to contain the super_object  
              number, as in the "H" case.  

     Field 2: super-object number  
     Field 3: type of super-object 
   
                B = beam 
                T = tie  
                S = slur (dotted slur) 
                X = tuple/bracket  
                W = wedge  
                D = word plus dashes 
                E = ending 
                R = long trills  
                V = octave transposition 
                F = figure extension 
                N = null super-object (no action)  
   
     Fields 4--: depend on the super-object type 
   
     G-1. Beams    (type = B)  

        Fields 4 and 5: 

          Case I: Non-page-specific i-files 

            Field 4:  0 = beam above first object 
                      1 = beam below first object 

              Note: If the stage2 source file contained a print suggestion 
                    for modifying the length of the first stem of a beam, 
                    this suggestion will be communicated to the mskpage 
                    program in this field.  

                    a) If the stem is to be lengthened (regardless of 
                       whether it goes up or down), the suggested amount 
                       of the change (in units of 1/10 of a staff line 
                       distance) is multiplied by 100 and added to Field 4.  

                    b) If the stem is to be shortened (regardless of 
                       whether it goes up or down), the suggested amount 
                       of the change (in units of 1/10 of a staff line 
                       distance) is multiplied by 10000 and added to Field 4.

                    These print suggestions apply only to non-page-specific 
                    files and are removed by mskpage (and mkpart) after they
                    are utilized.  They do not appear in the page-specific 
                    output.  

   
            Field 5:  0 or 1 = stem directions are all the same 
                    > 1 = binary representation of stem direction.  
                          If field 4 = 0, then bit set = stem up; 
                          if field 4 = 1, then bit set = stem down; 
                          Example: if field 4 = 1, then 101001010 = 
                          down, up, down, up, up, down, up, down, up 

          Case II: Page-specific i-files 

            Field 4:  length of first stem (positive = stem up) 

            Field 5:  slope of beam 

        Field 6: font number 
        Field 7: number of associated objects  
        Fields 7a, b,...   beam codes 

            beam code = up to 6 digit number 

               0 = no beam 
               1 = continue beam 
               2 = begin beam 
               3 = end beam 
               4 = forward hook 
               5 = backward hook 
               6 = single stem repeater 
               7 = begin repeated beam 
               8 = end repeated beam 

                    1's digit = eight level beams  
                   10's digit = 16th level beams 
                  100's digit = 32nd level beams 
                 1000's digit = 64th level beams 
                10000's digit = 128th level beams  
               100000's digit = 256th level beams  
   
     G-2. Ties    (type = T) 
   
        Fields 4--6:  locations of note heads to be tied 
   
          Field 4: vertical position of tied notes (position 
                     measured in dots (300/inch) from top staff
                     line)

              For ties on a virtual (second) staff, 1000 will be added
                to this value.  


          Field 5: horizontal displacement of first note head from   
                     associated object (non-zero only with chords) 
          Field 6: horizontal displacement of second note head from  
                     associated object (non-zero only with chords)  
   
        Fields 7--9:  Meaning depends on value of reset parameter (Field 11)
                                                     
          If reset parameter is 0 

             Field 7: (from print suggestion) horizontal displacement of 
                        &dEthe left end&d@ of the tie relative to the default 
                        computed position.  Tie length will be changed.  
             Field 8: (from print suggestion) vertical displacement.  
                        In most cases, displacement will be relative to     
                        the default computed position.  Adding 10000 (ten 
                        thousand) to the number will make the displacement 
                        relative to the tied note, itself.  

             Field 9: (from print suggestion) horizontal displacement of   
                        the right end of the tie relative to the default    
                        computed position.  Tie length will be changed.       
   
          If reset paramter is > 0 
   
             Field 7: horizontal displacement from note head one 
             Field 8: vertical displacement from note head one 
             Field 9: font number 
   
        Field 10: situation flag 
   
           interference     tips down       tips up  
           stem   staff   space   line    space   line 
           -----  -----   -----   ----    -----   ---- 
            no     yes      1       5        9     13  
            no     no       2       6       10     14  
            yes    yes      3       7       11     15  
            yes    no       4       8       12     16  
   
        Field 11: reset parameter flag (used in cases where    
              post-editing has specified non-standard parameters)  
   
            value    action  
            -----    ------  
              0      recompute position and font (normal setting)  
              1      do not recompute position 
              2      do not recompute font 
              3      do not recompute position or font 

   
     G-3. Slurs (dotted slurs)    (type = S) 
   
        Field 4: situation flag  
   
                       bit clear            bit set 
                     --------------       ------------- 
            bit 0:   full slur            dotted slur 
            bit 1:   stock slur           custom slur 
            bit 2:   first tip down       first tip up  
       (*)  bit 3:   second tip down      second tip up     
       (+)  bit 4:   compute stock slur   hold stock slur 
            bit 5:   print slur           don't print slur 
           
            (*) used on custom slurs only  
            (+) used on stock slurs only 
       
        Field 5--8:  position fields:  
     
            For stock slurs, these are displacements added to  
               the note positions before the slur number is 
               calculated.  Displacements are measured in dots 
               (300/inch).  Horizontal positive is forward to 
               the right; vertical positive is down.  
     
            For custom slurs, these displacements are the actual 
               starting point and ending points of the slur 
               relative to the first and second objects.  

            Field 5: (extra) horizontal displacement from 
                        associated object one 
            Field 6: (extra) vertical displacement from 
                        associated object one 
            Field 7: (extra) horizontal displacement from 
                        associated object two 
            Field 8: (extra) vertical displacement from 
                        associated object two 
   
        Field 9--10:  parameter fields:  
   
            Stock slurs:  Field 9:   post adjustment to curvature 
                          Field 10:  beam flag  1 = set slur above beam 
                                                2 = set slur below beam 
     
            Custom slurs:  Field 9:   vertical height parameter 
                           Field 10:  length of flat portion as a 
                                      percent of span between end 
                                      points 
     
        Field 11--12:  more parameters 

            Stock slurs:  Field 11:  post adjustment to x-position 
                                     negative = left; positive = right 
                          Field 12:  post adjustment to y-position 
                                     negative = up; positive = down 


     G-4. Tuplets/brackets    (type = X)   
   
        Field 4: situation flag  
   
                       bit clear                  bit set 
                     --------------             ------------- 
            bit 0:   no tuplet number           tuplet number 
            bit 1:   no bracket                 bracket 
            bit 2:   tips down                  tips up 
            bit 3:       0                      tuplet aligns with beam 
            bit 4:   tuple near notes           tuple near beam 
                     (bit 4 has meaning only if bit 3 is set) 

            bit 5:   break bracket for number   bracket is continuous 
                     (bit 5 has meaning only if bit 0 is set) 
            bit 6:   number outside bracket     number inside bracket 
                     (bit 6 has meaning only if bit 5 is set) 
            bit 7:   bracket is square          bracket is curved 
                     (bit 7 has meaning only if bit 1 is set) 

        Field 5:  tuplet number:  value = 1000 * [second number] + first 
                    or single number 
   
        Fields 6--10: parameters 

          Case I: bit 3 of sitflag = 0 (tuple not aligned with beam) 
               or bit 3 of sitflag = 1 and bit 4 of sitflag = 0 
                  (tuple aligned with notes of beam) 

            Field 6:  horizontal displacement from 
                            associated object one 
            Field 7:  vertical displacement from 
                            associated object one 
            Field 8:  horizontal displacement from 
                            associated object two 
            Field 9:  vertical displacement from 
                            associated object two 
            Field 10: not used 

          Case II: bit 3 of sitflag = 1 (tuple aligned with beam) 

            Field 6:  horizontal post adjustment to tuple 

            Field 7:  vertical post adjustment to tuple 

            Field 8:  horizontal post adjustment to tuple 

            Field 9:  vertical post adjustment to tuple 

            Field 10: beam super-object number with which tuplet 
                            aligns 
   
     G-5. Wedges    (type = W) 
   
        Field 4: wedge size at left end  
   
        Field 5: wedge size at right end 
     
        Field 6: horizontal displacement from  
                        associated object one  
        Field 7: vertical displacement from  
                        top of staff 
        Field 8: horizontal displacement from  
                        associated object two  
        Field 9: vertical displacement from  
                        top of staff 
   
     G-6. Word(s) plus dashes    (type = D)  
   
        Field 4: horizontal displacement from  
                        associated object one  
        Field 5: horizontal displacement from  
                        associated object two  
        Field 6: vertical displacement from staff lines  
   
        Field 7: spacing parameter     
                   0 = use default in display program 
                   >0 = space between dashes (units = dash length) 
     
        Field 8: font designator 
   
   
     G-7. Endings    (type = E)  
   
        Field 4: situation flag  
   
                  0 = ending with no number  
                  1 = first ending 
                  2 = second ending  
                  3 = third ending 
                  4 = fourth ending  

             The display/printing of ending superobjects is normally 
             suppressed for all staff lines below the top staff line 
             in a score.  That is, the superobjects may be there, but 
             they are not displayed/printed.  Adding 10 to the situation 
             flag will force the display/printing of an ending 
             superobject.  For example: 

                 11 = force the display/printing of first ending 
                 12 = force the display/printing of second ending 
   
        Field 5: horizontal displacement from  
                        associated object one  
        Field 6: horizontal displacement from  
                        associated object two  
        Field 7: vertical displacement from staff lines  
   
        Field 8: length of left vertical hook  
   
        Field 9: length of right vertical hook 
     
   
     G-8. Long trills    (type = R)  
   
        Field 4: situation    1 = no trill 
                              2 = trill with no accidental 
                              3 = trill with sharp
                              4 = trill with natural
                              5 = trill with flat
                              6 = trill with sharp following   
                              7 = trill with natural following        " 
                              8 = trill with flat following           " 
   
        Field 5: horizontal displacement from  
                        associated object one  
        Field 6: horizontal displacement from  
                        associated object two  
        Field 7: vertical displacement from  
                        associated object one  
   
   
     G-9. Octave transposition     (type = V)  
   
        Field 4: situation    0 = 8ve up, 1 = 8ve down 
                              2 = 15 up,  3 = 15 down
   
        Field 5: horizontal displacement from  
                        associated object one  
        Field 6: horizontal displacement from  
                        associated object two  
        Field 7: vertical displacement from  
                        associated object one  
        Field 8: length of vertical hooks  
   
   
    G-10. Figure extension    (type = F) 
     
        Field 4: level   1,2,3 or 4  
   
        Field 5: horizontal displacement from  
                        associated object one  
        Field 6: horizontal displacement from  
                        associated object two  
   
        Field 7: additional vertical displacement from 
                        default height 
   
  H. Q-records (linear only) 
   
     Field 1: Identifier = Q  (one field only) 

        A Q-record is used to force MSKPAGE to make a page 
        break.  At the moment, these are not incerted by 
        AUTOSET; they must be added by hand to a linear 
        i-file.  

  I. Tag records (linear only) 

     Field 1: Identifier = Y 

       Tags are incerted into linear i-files by AUTOSET.  Their purpose 
       is pass instructions and information to MSKPAGE.  They are not 
       propogated into page-specific i-files. 

     Field 2: type of tag     P = print abbreviated part name 
                              U = line control 

     I-1. Part name (type = P) 

        This tag signals MSKPAGE that from this point in the score 
        (until cancelled), MSKPAGE is to append the designated 
        abbreviated part name to the left of the staff line containing 
        this part. 

        Field 3: font number  (0 = turn this feature off after 
                                   typesetting the current line) 

        Field 4: ASCII string (includine font designations) 

     I-2. Line control (type = U) 

        This tag sends MSKPAGE instructions to help it determine 
        whether or not to DELETE this part from a particular system.  
        MSKPAGE starts by typesetting (logically) all parts in the 
        system.  It then uses these tags to determine which parts 
        in a particular system are "extraneous." 

        Field 3: control code   0 = nullify the previous control code 
                                    (i.e., return to normal rules) 
                                1 = tag the current and all subsequent 
                                    measures as type-1 
                                2 = tag the current and all subsequent 
                                    measures as type-2 

          Type-1 measure:  Delete a line of music if every one of its 
                           measures is type-1.  This is used to suppress 
                           a "dominant" representation of a part.  

          Type-2 measure:  Delete a line of music if any one of its 
                           measures is type-2.  This is used to suppress 
                           a "non-dominant" representation of a part.  

            The "dominant" version of a part is the one which contains 
            the most or greatest variety of information.  

            For example, when a section (e.g., Violin I) divides into 
            two sections (divisi) and is represented on two staves, 
            this becomes the "dominant" version of the part, because on 
            a system-line basis it over-rides and must replace the single 
            line version of the part.  The divisi parts will be flagged 
            as type-1 up to the point where they diverge (or where the 
            music engraver definitely wants them on two staves).  The 
            single line part will be normal (considered printable) up 
            to the point where the divisi parts take over and will be 
            flagged as type-1 thereafter.  At the point where the 
            divisi goes away, the divisi parts are again flagged as 
            type-1 and the type-2 designation for the single line 
            is cancelled.  



V. Record Formats for Page Specific Record Types (page-specific, 
    scrolling page-specific, and multi-page) 
   
  A. Systems 
   
     Field 1: Identifier = S 
     Field 2: 0  
     Field 3: x co-ordinate of system on page  
     Field 4: y co-ordinate of system on page  
     Field 5: horizontal length of system  
     Field 6: vertical length of system  
     Field 7: number of lines in system  
     Field 8: control string in double quotes (null string allowed)  
   
            The control string describes how the lines of the system 
            are bound together on the left, and where bar lines stop 
            and start between the staff lines.  The control string 
            consists of the following elements: 

               [  =  start bracket 
               ]  =  end bracket 
               {  =  start brace   
               }  =  end brace 
               (  =  start bar line 
               )  =  end bar line 
               .  =  part with a single staff line 
               :  =  part with a grand staff (piano) 

            What defines a system (holds it together) is a single 
            vertical line on the left.  To the left of this line can 
            appear an arrangement of brackets and braces, which help 
            the reader group the lines in the system.  

            The bar lines in a system have their own (vertical) pattern 
            of starting and stopping.  These are indicated in the control 
            string by the placement of the '(' ')' characters.  The '(' 
            character indicates the start of a bar line on the top staff 
            line of the part indicated by the next dot (.:,;); and the 
            ')' character indicates the end of a bar line on the bottom 
            staff line of the part indicated by the previous dot (.:,;).  

            Examples:   (.)     creates a bar line through one set of 
                                  staff lines 
                        (:)     creates a bar line through a grand staff 
                                  (two sets staff lines) 
                        (..)    creates a bar line which starts at the top 
                                  of the first staff line and ends at the 
                                  bottom of the second staff (i.e., two 
                                  independent parts with a bar line          
                                  connecting them together).  
                        (.)(.)  creates a bar line through each of the 
                                  staff lines separately, with no 
                                  connection between them.  

            All segments of a system bar line must be specified.  The 
            control string "{..}" will produce a a brace on the left, but 
            no bar lines will appear.  In this case, one must either 
            specify "{(.)(.)}", meaning two bar lines with no connection, 
            or "{(..)}", meaning one bar line crossing both staff lines.  

            The control string "(....)(.):{..}..." would produce the 
            funny looking result of having no bar lines in the piano part 
            or in the (string) parts below them.  

            As a short cut for convenience, the '[' character also doubles 
            as a '(' character, and the ']' character also doubles as a ')' 
            character.  This allows one to write "[....]" as a shortcut for 
            "[(....)]".  Shortcuts are handy, but they can have unintended 
            side affects.  In the example above, modifying control string 
            with outside square brackets (i.e., "[(....)(.):{..}...]" ) 
            will produce bar lines for all staff lines, but may not connect 
            the staff lines in a manner the user intends.  This control 
            string will produce a solid bar line from the fifth staff line 
            through to the bottom.  If this were the control line for a 
            score of a piano concerto with four woodwinds, timpani, piano 
            and strings, it might have the following form.  
                           "[(....)(.)(:)({..}...)]" 

            The staff lines in a system are normally of the same size, but 
            it is possible to combine staff lines of different sizes in the 
            same system.  When this is done, the print and display software 
            must decide what font size to use for printing the various bar 
            lines, braces, and brackets.  At the moment, the decision is 
            made in the following way: 

            1. The left line, and all braces and brackets are printed 
               using the same font size.  The default is to use the font 
               size from the bottom staff line.  If the size from a 
               different staff line is desired, this should be indicated 
               by replacing the dot for that staff line with a comma, or 
               in the case of the grand staff replacing the colon with a 
               semi-colon.  If more than one comma/semi-colon appears, the 
               largest of the indicated sizes will be used.  

            2. As stated above, bar lines can run through one or more staff 
               lines, and they can be printed in different sizes (widths).  

               (a) If a bar line runs through only one staff, then it is   
                   printed in the font size of that staff.  

               (b) If a bar line runs through multiple staves of the same 
                   font size, then it is printed in that font size.  

               (c) If a bar line connects staves of different font sizes 
                   the default size for the bar line is given by the 
                   size of the bottom staff.  If the size of another  
                   staff is desired, this is indicated by replacing the 
                   dot for that staff line with a comma, or in the case 
                   of the grand staff replacing the colon with a semi- 
                   colon.  If more than one comma/semi-colon appears, 
                   the largest of the indicated sizes will be used.  

            3. These rules will work in most situations, but there are some 
               limitations.  In cases 2(a) and 2(b) you cannot use a font 
               size different from that of the staff size to print bars.  
               You cannot, for example, use one font size to print all    
               segments of a bar line in the case where the segments span 
               staff sets of different sizes.  It is possible to remove 
               these limitations, but this would require a more elaborate 
               definition of the control string (such as allowing the 
               font size for each bar segment to be specified explicitly).  
               At this stage of development, such an elaboration seems   
               excessive and unnecessary.  


  B. Music Lines (page specific)   
   
     Field 1: Identifier = L (or small l = single line staff, e.g., for triangle)
     Field 2: y off-set in system  
     Field 3: text off-set(s) from line   (separated by |) 
     Fields 4--7:  parameters carried over from previous line 

       Field 4: dyoff(s) 
       Field 5: uxstart(s) 
       Field 6: backloc(s) 
       Field 7: xbyte(s)   (length of field = number of text lines) 

     Field 8: y off-set to virtual staff line (0 = none) 
     Field 9: notesize (optional; 0 = none) 
     Field 10: additional vertical off-set for figured harmonies (0 = none) 
                 Note: Field 10 cannot exist without Field 9 


  C. End of Music Line 
   
     Field 1: Identifier = E 
     Field 2: xbyte(s) at end of line (length of field = number of bytes) 
   

  D. System Bar  
   
     Field 1: Identifier = B 
     Field 2: bar type     Single bars   Double Bars 
                           -----------   ----------- 
                           1 = simple    5 = double light  
                           2 = heavy     6 = light-heavy 
                           3 = dotted    9 = heavy-light 
                                        10 = heavy-heavy 
                                        25 = heavy-light with 
                          99 = no bar            repeat dots
   
     Field 3: x off-set from beginning of line 
     Field 4: number of breaks in line (to avoid interference with 
                  text and other designations) 
       Fields 5--: parameter pairs, beginning and ending of breaks 
   

  E. Page Text 
   
     Field 1: Identifier = X 
     Field 2: font number  
     Field 3: x co-ordinate of beginning of text 
     Field 4: y co-ordinate of text line 
     Field 5: ASCII text   
  
     The ASCII text may contain font change instructions.  The sequence 
     is the "!" character, followed by a two digit number (which at the 
     moment must be between 30 and 48), followed optionally by the "|" 
     character, which serves as a terminator to the font change instruction.
     The need for a terminator arises because in the future we may not want 
     to restrict the font change number to exactly two digits.  If the 
     display software finds a "|" following a string of digits following 
     the "!" character, it will consider this a terminator and remove 
     it from the text along with the font change command.  To print/display 
     the "|" character immediately following a font change, use the "|" 
     twice.  

     Special cases: 

     (1) If the page text record has only two fields, the letter X and 
         a number, then the number is interpreted as a new value for 
         notesize.  
     
     (2) If the number in Field 3 (x co-ordinate) is followed directly 
         by the letters "C" or "R", this means (C) center the text on the
         x co-ordinate, or (R) right justify the text to the x co-ordinate,
         respectively.  


  F. Tagged Page Text 

     Field 1: Identifier = Y 
     Field 2: font number (if this = 0, then no print/display) 
     Field 3: x co-ordinate of beginning of text 
     Field 4: y co-ordinate of text line 
     Field 5: ASCII text 

     In addition to the font change instructions in "X" records, these "Y" 
     records also support a system of tagged fields.  Listed below are 
     the tagging sequences and their functions.  

        \< = begin tag structure.  A tag structure has two components: 
               the tag, and the data field being tagged.  The tag comes 
               first and may contain any ASCII characters except the "|" 
               character, which is interpreted as "End of Tag."  Immediately
               following the "|" is the data field.  This is terminated 
               by the "end tag structure" sequence.  
        \> = end tag structure.  
        \] = break tag structure.  It is possible for a tag data field to 
               continue over to a line or page boundary.  In this case, 
               the tag structure must be broken at the end of the line 
               and restarted at the beginning of the next line.  
        \[ = restart tag structure.  A tag structure can only be restarted 
               if it was broken on the previous line (or last line of the 
               previous page).  It is a requirement that the tag (first 
               component of the tag structure) be restated.  In theory, 
               the software could reconstruct the tag, but in the case 
               where the data field extends over several lines, this 
               could prove cumbersome.  Therefore, following the "\[" 
               sequence comes the tag, followed by the "|" character, 
               followed by a continuation of the data field.  

     Under this structure, it is possible to have nested tags.  This 
     feature could prove useful.  For example, suppose we are interested 
     in tagging names, and suppose we are also interested in knowing 
     the first name and the last name.  We could implement this with 
     three tags: name, fname, and lname.  Now suppose we want to tag 
     the name in the line of text "According to Lowell Lindgren," 
     The Y record might appear as follows: 

     Y 37 50 140 According to \<name|\<fname|Lowell\> \<lname|Lindgren\>\>, 

     This includes both the "outer" or "primary" tag, with its endpoints 
     and "inner" or "secondary" tags with their endpoints.  

     If this structure were broken across a line boundary, it might 
     look like this 

     Y 37 50 140 According to \<name|\<fname|Lowell\>\] 
     Y 37 50 180 \[name|\<lname|Lindgren\>\>, there was a cantata 

     What this allows the software to know is that the first name "Lowell" 
     and the last name "Lindgren" are part of the same name, even though 
     they occur on separate lines.  


  G. Page delineator (Multi-page files only) 

     Field 1: Identifier = P 

     To distinguish a page delineator from a "P" type super-object, 
     one of the following conditions must hold.  

         (a) Record length = 1 
         (b) "space" character in column 3 
         (c) The first 4 columns must be the word "Page" 

     The last record in a multi-page file must be the four 
     character string "/eof".  Multi-page files are designed 
     primarily for use as (one form of) input to the muse2ps 
     conversion program.  


  H. Meta-data records 

     Field 1: Identifier = @ 

     This line is ignored by the display/print software, but may contain 
     important information related to the description or structure of the 
     data.  

     Some uses of @-records: 

     1. Source ID.  

        Field 2: "SOURCE:" 

        Field 3: <File ID> 

        Filed 4: <[md5sum: ... ]> 

        The idea is to represent all of the sources that contributed to 
        making this page (or musical example).  The Source ID records 
        should normally follow the Z-header records.  In cases where 
        there are no Z-header records, the Source ID record should 
        appear before the first system (and before any @ SYSTEM: records).  

     2. Movement ID. + Info 

        Field 2: "MVT:" 

        Field 3: Type of data 

          N = name  Field 4: = movement name 

          P = part  Field 4: = part number 
                    Field 5: = <sub-part numbers> enclosed in carrot brackets
                                numbers separated by commas, null-set allowed
                    Field 6: = part name 

          L = line  Field 4: = line index number 
                    Field 5: = <part numbers for each track> enclosed 
                                numbers separated by commas, no null set allowed
                                If the first field inside the <..> string is an
                                "x", this indicates a keyboard part, which is
                                non-divisible and multi-track.  The numbers that
                                follow, e.g., "<x,#,#,..>" are the part numbers
                                assigned to the various keyboard tracks.  
                    Field 6: = line name 

          Note: "part" means any part or group of parts.  If there are two 
                   oboes, then there are likely to be three parts: oboe-1, 
                   oboe-2, and oboes.  
                "line" means any line compiled by AUTOSET for purposes of 
                   making a score.  For the bass strings, there are often 
                   three lines: cello, basso, and cello + basso.  These 
                   three lines never appear in the same system; either 
                   the cello and basso appear as separate lines, or they 
                   appear combined on the same, single line.  

     3. System ID.  

        Field 2: "SYSTEM:" 

        Field 3: ASCII string                 

           The purpose of this record is to identify the composer,       
           work, and movement to which this system belongs.  This 
           information (if present) will be used by the search program 
           to identify "hits."  This record should be located just 
           above the System record to which it applies.  

           There is an option to include a bar line number in this  
           ASCII string.  If this is to be used, the number must 
           occur at the beginning of the string, and must be enclosed 
           in < > brackets, e.g., <28>, with no space following.  

     4. Line ID.  

        Field 2: "LINE:" 

        Field 3: line index number (for joining lines between systems) 

        Field 4: ASCII string 

           The purpose of this record is to identify the instrument(s) 
           or the voice represented on this staff line.  This information 
           (if present) will be used by the search program to identify 
           "hits."  This record should be located just above the Line 
           record to which it applies.  

     5. Line Text(s) 

        Field 2: "TEXT:" 

        Field 3: ASCII string                 

           The purpose of this record is to provide a searchable ASCII 
           string containing the text (underlay) represented on the line.  
           This record should be located just below the Line record to 
           which it applies.  In cases where there is multiple text 
           underlay (e.g., some Bach chorals), there will be mulitple 
           @ TEXT: records.  

     6. Comment.  

        Field 2: "COMMENT:" 

        Field 3: ASCII string 

     7. Grid data. (scribe program) 

        Field 2: "GRID:" 

        Field 3: Command Set (includes grid units per measure) 

        Field 4: Notation represented by one grid unit, e.g. 7 = quarter note

        Field 5: Minumum grid spacing 

           The purpose of this record is to provide the scribe program with 
           parameters it needs to implement cursor movement along the grid 
           This record, if it exists will alway be at the top of the file.  

     8. Pointer data. (scribe program) 

        Field 2: "POINTERS:" 

        Field 3: pointer to the next note (or rest) object (index into pointers array)

        Field 4: pointer to the previous note (or rest) object (index into pointers array)

           The purpose of this record is to store various pointers used by the
           scribe program.  The values have meaning only in the context of that
           program and of the working pointers it creates.  The @POINTERS: record,
           if it exists will always following directly after the object record to
           which it refers.  
