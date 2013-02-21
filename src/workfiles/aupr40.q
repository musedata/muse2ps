
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
&dA &d@³P* 40. dtalk (messnum)                                                        ³
&dA &d@³                                                                              ³
&dA &d@³    Operation:  This procedure runs only once in this program,                ³
&dA &d@³                and only if the debug option is on and the                    ³
&dA &d@³                program is about to terminate.                                ³
&dA &d@³                                                                              ³
&dA &d@³    Inputs:     messnum    Message number                                     ³
&dA &d@³                                                                              ³
&dA &d@³    Output:     halt                                                          ³
&dA &d@³                                                                              ³
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
      procedure dtalk (messnum) 
        int messnum 
        label E(120) 
        getvalue messnum 

        if Debugg = 0 
          stop 
        end 

        goto E(messnum) 
E(1): 
        pute Chord format error 
        goto EE 
E(2): 
        pute Figured harmony error 
        goto EE 
E(3): 
        pute Tie error 
        pute 
        pute This is most often caused by a tie that has no terminating note
        pute in any part.  You should first check to see that all ties in 
        pute region where this error occurred are properly terminated.  The 
        pute problem can also be caused by excessive durations in a measure 
        pute that has a tie.  This will cause the program to think the measure
        pute has ended (early) and it will look for a terminating note in the
        pute next measure; i.b46 e., it will skip a properly placed terminating
        pute note.  If you still can't find the error, you might try deleting
        pute ties one at a time to see which one is causing the problem.  
        pute 
        pute Another cause can be trying to tie notes which are on different
        pute staves of the grand staff.  At the moment, autoset does not support
        pute this feature.  
        goto EE 
E(4): 
        pute Bar error 
        goto EE 
E(5): 
        pute Text error 
        goto EE 
E(6): 
        pute Time signature error 
        goto EE 
E(7): 
        pute No recognizable control character 
        goto EE 
E(8): 
        pute Figured harmony out of order 
        pute 
        pute Possibly you have entered a figured offset improperly.  
        pute 
        pute For example, the offset to the second figure actually appears 
        pute in the record for the first figure.  The interpretation of the 
        pute offset number is how must to advance the division counter after
        pute a figure is printed.  
        pute 
        goto EE 
E(9): 
        pute This will cause a Pitch decoding error 
        goto EE 
E(10): 
        pute No pitch found to match tie termination (X) direction (*).  
        pute 
        pute Check musical direction records (*) in this measure for tie 
        pute terminations and verify that the pitch in column 25 appears 
        pute earlier in the measure, on the same staff.  
        pute 
        goto EE 
E(11): 
        goto EE 
E(12): 
        pute Error in the command line.  The specified group is not supported.
        pute "score", "parts", "skore", "short", "sound", and "data" 
        pute are the only groups allowed.  
        goto EE 
E(13): 
        pute Attempting to read a MuseData module within the data stream. 
        pute Bad format in the file header (first 11 lines).  
        pute One possible reason: missing /eof or misreading /END 
        goto EE 
E(14): 
        pute A MuseData module within the data stream is incomplete 
        pute or improperly terminated.  
        goto EE 
E(15): 
        pute Mismatch of group types following the Group Membership line.  
        goto EE 
E(16): 
        pute No termination found to a MuseData module.
        goto EE 
E(17): 
        pute There is a part number missing in the sequence, or 
        pute there is an ambiguity in the number of parts.  
        goto EE 
E(18): 
        pute Some part number is represented twice 
        goto EE 
E(19): 
        pute Missing one or more /END statements 
        goto EE 
E(20): 
        pute Mis-use of "/" or File not properly terminated.  
        pute This error can also be caused by a missing comment 
        pute terminator "&".  
        goto EE 
E(21): 
        pute Missing "/END" or some other error 
        goto EE 
E(22): 
        pute   Attempting to use indefinite rests (rest with no letter) 
        pute   of successively different lengths, without change 
        pute   of meter.  
        goto EE 
E(23): 
        pute Unable to represent cue note in terms of current 
        pute   value of divisions per quarter 
        goto EE 
E(24): 
        pute Missing note type (column 17). 
        goto EE 
E(25): 
        pute This program cannot deal with certain situations where there 
        pute are more than three independent instruments encoded in one part.
        goto EE 
E(26): 
        pute This code will not work with more than 4 notes in chord 
        goto EE 
E(27): 
        pute Note out of staff range.  Please check clef.  
        goto EE 
E(28): 
        pute Slur error: Can't stop a non-existant slur (possible missing instigation)
        goto EE 
E(29): 
        pute Slur error: Can't start an existing slur (possible missing termination)
        goto EE 
E(30): 
        pute Can't find start to a slur 
        goto EE 
E(31): 
        pute Too many simultaneous wedges in source file.  
        goto EE 
E(32): 
        pute Too many simultaneous sets of dashes in source file.  
        goto EE 
E(33): 
        pute Too many simultaneous transpositions of one type 
        pute in source file.  
        goto EE 
E(34): 
        pute Attempt to end a wedge that wasn't properly started.  
        goto EE 
E(35): 
        pute Attempt to end a set of dashes that wasn't properly started.  
        pute 
        goto EE 
E(36): 
        pute Attempt to end a transposition of a type that wasn't 
        pute properly started.  
        goto EE 
E(37): 
        pute Problem finding the end of a slur 
        pute Possible causes: 
        pute   1. A slur has not been closed properly 
        pute   2. Overlapping slurs using the same code 
        goto EE 
E(38): 
        pute In searching for something, like for example, the end of a slur,
        pute AUTOSET has searched past the end of the file.  There definitely
        pute is an error in the source file.  Please find and correct.  
        goto EE 
E(39): 
        pute This problem occurred in collating the parts 
        goto EE 
E(40): 
        pute To find error, look at durations in source file for this part 
        pute as well as for the top part (which provides the original count).
        pute Look also for the possible inconsistant use of non-contolling bar
        pute lines.  
        pute 
        pute A couple of things to note:  (1) The bar nubmer given above is 
        pute only approximate.  If there is a pickup at the beginning, for 
        pute example, the bar number could be one number too high.  Try 
        pute looking at the previous bar.  
        pute 
        pute (2) In most cases, the duration problem will be an obvious encoding
        pute error; but there is a subtle case which can escape normal detection.
        pute This is the case where an irest in a part produces an isolated 
        pute node in a part.  Isolated means that there in not another object
        pute in that part at that location.  In this case it is necessary to
        pute allocate space for this irest, even though it is not printed.  
        pute This is done by using the  "P   C1:p1" print suggestion below 
        pute the offending irest.  
        goto EE 
E(41): 
        pute This problem occurred in collating the parts.  
        goto EE 
E(42): 
        pute This problem occurred in collating the parts.  
        goto EE 
E(43): 
        pute This problem occurred in collating the parts.  
        goto EE 
E(44): 
        pute This problem occurred in collating the parts.  
        goto EE 
E(45): 
        pute This problem occurred in collating the parts.  
        goto EE 
E(46): 
        pute Error: Wrong number of superobjects 
        pute 
        pute    This obscure error sometimes occurs when collapse two 
        pute    parts (I:2) into one.  We suggest you check source file 
        pute    for duplicated triplets, or perhaps other duplicated 
        pute    super-objects (duplicate ties and slurs are O.K.) 
        pute 
        pute    Another cause could be beam super-object "=" characters 
        pute    extending across grace notes.  
        goto EE 
E(47): 
        pute Error: No more superobject capacity.  Too many simultaneous ties,
        pute slurs, endings, beams, wedges, octave transpositions, dash lines.
        goto EE 
E(48): 
        pute Error: Unexplained non-controlling object at end of line 
        pute   This error can sometimes result from a mistake in one of the 
        pute   source files.  Essentially, MSKPAGE found an object at the 
        pute   end of a measure that it did not expect to find.  For example,
        pute   word objects such as "Da Capo" may occur at the end of a measure,
        pute   but letter dynamics (symbols) should not.  In one case I ran 
        pute   across recently, a word musical direction (B,C,or D) was mistakenly
        pute   encoded as a letter dynamic (G).  This generated a symbol at 
        pute   the end of a measure, which caused MSKPAGE to fail at this point.
        goto EE 
E(49): 
        pute This problem occurred in collating the parts.  
        goto EE 
E(50): 
        pute This problem occurred in collating the parts.  
        goto EE 
E(51): 
        pute This problem occurred in collating the parts.  
        goto EE 
E(52): 
        pute Error: Beam extends over control bar line 
        pute This problem occurred in collating the parts.  
        goto EE 
E(53): 
        pute Error: No refererce to superobject ~supernum  in previous objects
        pute This problem occurred in collating the parts.  
        goto EE 
E(54): 
        pute This problem occurred in collating the parts.  
        goto EE 
E(55): 
        pute You have reached a point in this program where the code below will
        pute fail.  While not all cases of this situation have been identified, it
        pute is known that this situation will arise when the follow conditions hold:
        pute 
        pute (1) You are typesetting a part (not a score) 
        pute (2) You are using the C0:y<#> control flag to turn lines off 
        pute 
        pute In this situation, you must turn off the multiple measure feature,
        pute which is automatically (and silently) turned on when parts are being
        pute compiled by autoset.  Use the print suggestion:   P  C0:m0 
        pute in all relevent stage2 files.  
        goto EE 
E(56): 
        pute Mixed stem directions on two separate staves.  This case is often
        pute often impossible to draw and is therefore not handled by this program!
        goto EE 
E(57): 
        pute Notes on the staff with mixed stem directions are not sufficiently
        pute far apart to set a horizontal beam.  
        goto EE 
E(58): 
        pute Unable to find a slope to mixed stem beam 
        pute Try setting more distance between staves of the grand staff 
        goto EE 
E(59): 
        pute Program error in finding position of beam with mixed stems 
        goto EE 
E(60): 
        pute Unable to typeset this particular beam 
        goto EE 
E(61): 
        pute Stem up notes are not sufficiently higher that stem down notes 
        pute to allow space for a horizontal beam.  
        goto EE 
E(62): 
        pute Error: Unexplained object thrown to next line 
        goto EE 
E(63): 
        pute Error: Parts of different length.  This is probably caused 
        pute by an encoding error.  
        pute One possibility is that a slur was started but not 
        pute terminated.                                                  
        pute Another possibility is that a measure was left out of a 
        pute part with multiple rests. 
        pute Look also for the misspelling of measure, mdouble, mheavy, etc.
        pute somewhere in the source.
        goto EE 
E(64): 
        pute This problem occurred in collating the parts.  
        goto EE 
E(65): 
        pute This problem occurred in collating the parts.  
        goto EE 
E(66): 
        pute Program storage capacity has been exceeded 
        goto EE 
E(67): 
        pute Program Error.  Sorry.  
        goto EE 
E(68): 
        pute Incompatable syscode (left hand spine descriptor).  
        goto EE 
E(69): 
        goto EE 
E(70): 
        goto EE 
E(101): 
        pute Command line format error 
        pute 
        goto EE 

EE:     pute 
        pute    Program Halted 
        pute 
        stop 
      return 
