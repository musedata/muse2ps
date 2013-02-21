Here are the proposed command line options: 

1.  &dE=c<#>&d@  compression factor:  This is measured as a percentage 
             of the default.  100 = no compression.  

2.  &dE=d<#>&d@  putc Diagnostics and Error Messages.  
             bit 0 of #:  ON = print error messages 
             bit 1 of #:  ON = print all diagnostics
             bit 2 of #:  ON = print diagnostics from autoset 
             bit 3 of #:  ON = print diagnostics from mskpage 
             bit 4 of #:  ON = print diagnostics from pspage 
             no number = 0x01: print error messages

3.  &dE=F&d@     fill pages to the bottom by adding to the 
             intersystem space only.  Default is don't change 
             the vertical spacings.  

4.  &dE=f<#>&d@  fill pages flag.
             0 = don't change the vertical spacings.  
             1 = fill page by stretching all spacings.  
             2 = fill page; use only intersystem space to expand (=F) 
             No number (=f) means =f1.  

5.  &dE=g<#>&d@  grand staff intra-space measured in multiples 
             of leger lines times 10.  The default is 100, 
             which is 10 leger lines.  

6.  &dE=h<#>&d@  alter the minimum allowed space between notes.  
             This is measured as a percentage of the default.  
             100 = no change.  

7.  &dE=j<#>&d@  right justify flag.  
             0 = do NOT right justify the last systme 
             1 = right justify the last system.  
             No number (=j) means =j1 

8.  &dE=l<#>&d@  length of a page.  Distance is measured dots, at 
             300 dots to the inch.  Default is 2740 dots.  The 
             default starting height is 120 dots.  This will not 
             be lowered, but may be raised to accommodate a 
             longer page.  

9.  &dE=m<#>&d@  left margin, measured in at 300 dots/inch.  The 
             default is 200 dots 

10. &dE=n<#>&d@  maximum number of systems on a page.  The default 
             is no maximum.  

11. &dE=Q<#>&d@  duration which is assigned the minimum distance 
               1 = whole notes 
              ...   . . .  
               8 = eighth notes 
              16 = sixteenth notes, etc 

12. &dE=s^string^&d@  custom left-hand spine.  If the format is 
             incorrect for any reason, the program will revert 
             to the default.  example: 

             =s^[(....)][(..)](.)[({..}..)]^ 

13. &dE=t<#>&d@  top of page.  Default is 120 dots                       

14. &dE=v<#,#,#...#>&d@  custom spacings.  If the format is incorrect 
             for any reason, the program will revert to the default.  
             example: 

             =v192,192,192,208,192,192,208,176,176,176,200 

15, &dE=w<#>&d@  system width, measured in at 300 dots/inch.  The       
             default is 2050 dots 

16. &dE=x&d@     defeat all part inclusion suggestions in the data 

17. &dE=y&d@     defeat all line control suggestions in the data 

18. &dE=z<#>&d@  notesize: choices are 6,14,16,18,21.  14 is the default.  

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

19. &dE=M&d@     include a listing of the MuseData source files in the 
             Trailer section of the file 

20. &dE=P&d@     include listings of the page specific i-files, which are 
             the source of the .ps files

21. &dE=p&d@     The source is a concatinated set of page specific i-files 
             (also called .mpg files), not a set of Musedate files.  

22. &dE=G^<group-name>^&d@ group name to process.  The default is "score" 

23. &dE=E&d@     /END = /eof 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

24. &dE=T^<work-name>^&d@ optional.  Generates this record on the top of the
             first system.  

             X <notesize> 
             X 40 1200C 0 <work-name> 

25. &dE=u^<work number>^&d@ optional.  Generates this record on the top of the   
             first system 

             X <next smaller notesize, or notesize> 
             X 31 1200C 0 <work number> 

           Used together, the work number is placed below the work name 

26. &dE=C^<composer>^&d@ optional.  Generates this record, which would be 
             right-justified on the top of the first system.  

             X <notesize> 
             X 31 <right justified> <4 * notesize above staff line> <Composer>

             If <composer> contains the new line character "\n", the line will
             displayed in two parts, both right justified.  

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

??  &dE=k^<number in hex format>^&d@ display alternatives.  (e.g., "0x0000") 
          
           Low order Byte 
           -------------- 
              bit 0: Option active flag 
                     0 = "k" option is active 
                     1 = turn off this option altogether (command line over-ride)
              bit 1: SFZ flag 
                     0 = print sfortzando as sf   (also works with rf) 
                     1 = print sfortzando as sfz  (also works with rfz) 
              bit 2: sub-edit flag 
                     0 = distinguish between original and editorial data 
                     1 = show all data as original   
              bit 3: no-edit flag 
                     0 = process all data 
                     1 = do not process editorial data 
              bit 4: Roman-edit flag 
                     0 = use cue-size music fonts for editoral marks 
                     1 = use Times Roman font for editorial marks: tr, dynamics
              bit 5: Ligature flag 
                     0 = do not use ligitures.  
                     1 = convert ffl, ffi, ff, fl, fi to ligitures  
              bit 6: Figured harmony flag 
                     0 = place figured harmony below the musical line 
                     1 = place figured harmony above the musical line 
              bit 7: mheavy4 flag 
                     0 = mheavy4 represented by two heavy bars 
                     1 = mheavy4 represented by three bars: regular, heavy, regular
              ____________________________________________________________ 
                          
           Next Byte:  (various operational flags (defaults are 0) ) 
           ---------- 
              bit 8: (for two or more tracks) 
                 0 = allow overstrike when there is a dot-difference 
                 1 = do not overstrike 
              bit 9: (for printing new key signatures) 
                 0 = don't print a new key signature if it is 
                       the same as the previous one (default) 
                 1 = always print a key signature 
                       even when it hasn't changed 
              bit 10: (chords with white and black notes) 
                 0 = don't allow a mixture of white and black 
                       notes in chords 
                 1 = allow mixture of white and black notes 
              bit 11: (for suppression of the key signature) 
                 0 = normal 
                 1 = suppress printing of the key signature 
                       (for timpani parts, etc.) 
              bit 12: (for assigning editorial slurs) 
                 0 = normal (no assignment) 
                 1 = "{ }" and "z x" combinations 
                       indicate editorial slurs 
              bit 13: (for printing new clef signs) 
                 0 = normal (large clefs, only at start of measure) 
                 1 = always use large clefs 

              Note: All options represent in this byte can be set 
                    in the individaul stage2 modules using general 
                    print suggestions.  This byte simply provides a 
                    global means for setting these options.  

??  &dE=i<#>&d@  indentation options flag 
             0 = use program defaults
             1 = no indentation
             2 = indent first line, and after force line breaks 
                                                      
??  &dE=I<#>&d@  indentation size (300 = 1 inch) 
             0 = use default 
             (use =i1 to force indentation of zero) 

??  &dE=D<#>&d@  spacing between dashes.  Will over-ride spacing in stage2 files 
             0 = use default 
             >0 = space between dashes (units are dash length) 

??  &dE=X<#>&d@  leave off the last bar (for examples and incipits) 
             0 = print the last bar 
             1 = don't print the last bar 
             No number (=X) means =X1.  
             Note: you can add extra staff line space in the last bar by 
             putting in irests, but you must put irests in all modules 
             and they must all represent the same note type (duration).  
             Note also:  If the last bar line is anything but a regular 
             measure line, it will continue to print.  

??  &dE=W<#>&d@  thin bar flag
             0 = use regular bar lines 
             1 = use thin bar lines          
             No number (=W) means =W1.  

??  &dE=Y<#>&d@  time signature flag 
             0 = print time signatures 
             1 = suppress time signatures 
             No number (=Y) means =Y1.  
             Note: You can also simply leave off the time signature altogether.

??  &dE=S<#>&d@  extra space between the title and the first system of music     
             0 = use default 
             >0 = lower the first system (units are dots: 300 dots/inch) 



Letters still available for use.  

    ab..e.........o.qr........  
    ||            |  | 
    AB.....H.JKL.NO..R..UV...Z 
