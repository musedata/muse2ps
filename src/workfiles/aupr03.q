
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³P*  3. action                                                       ³ 
&dA &d@³                                                                    ³ 
&dA &d@³    Purpose:  Action is basically a continuation of the music       ³ 
&dA &d@³              processing program.  It is called when the data       ³ 
&dA &d@³              for a measure is complete.                            ³ 
&dA &d@³                                                                    ³ 
&dA &d@³    Inputs:  @n = number of elements in data arrays                 ³ 
&dA &d@³             tv1(.) = element type                                  ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                type   element                                      ³ 
&dA &d@³                ----   -------                                      ³ 
&dA &d@³                  1    regular note                                 ³ 
&dA &d@³                  2    extra regular note in chord                  ³ 
&dA &d@³                  3    regular rest                                 ³ 
&dA &d@³                  4    cue note                                     ³ 
&dA &d@³                  5    extra cue note in chord                      ³ 
&dA &d@³                  6    cue rest                                     ³ 
&dA &d@³                  7    grace note or grace rest                     ³ 
&dA &d@³                  8    extra grace note in chord                    ³ 
&dA &d@³                  9    figured harmony                              ³ 
&dA &d@³                 10    bar line                                     ³ 
&dA &d@³                 11    musical direction                            ³ 
&dA &d@³                 12    invisable rest                               ³ 
&dA &d@³                 13    backspace                                    ³ 
&dA &d@³                 14    clef change                                  ³ 
&dA &d@³                 15    time designation or other directive          ³ 
&dA &d@³                 16    time change                                  ³ 
&dA &d@³                 17    change in divspq                             ³ 
&dA &d@³                 18    key change                                   ³ 
&dA &d@³                 19    print suggestion                             ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                tv2(.) = duration for types 1--9, 12,13             ³ 
&dA &d@³                       = measure number for type 10                 ³ 
&dA &d@³                       = track number for type 11 (1 = default)     ³ 
&dA &d@³                       = new clef number for type 14                ³ 
&dA &d@³                       = 0 for type 15                              ³ 
&dA &d@³                       = new time flag for type 16                  ³ 
&dA &d@³                       = new divspq for type 17                     ³ 
&dA &d@³                       = new key for type 18                        ³ 
&dA &d@³                       = type of suggestion for type 19             ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                           if between 0 and 7                       ³ 
&dA &d@³                             0 = force slur 1 over                  ³ 
&dA &d@³                             1 = force slur 1 under                 ³ 
&dA &d@³                             2 = force slur 2 over                  ³ 
&dA &d@³                             3 = force slur 2 under                 ³ 
&dA &d@³                             4 = force slur 3 over                  ³ 
&dA &d@³                             5 = force slur 3 under                 ³ 
&dA &d@³                             6 = force slur 4 over                  ³ 
&dA &d@³                             7 = force slur 4 under                 ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                           if between 8 and 9                       ³ 
&dA &d@³                             8 = overhanded tie (tips down)         ³ 
&dA &d@³                             9 = underhanded tie (tips up)          ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                           if between 16 and 31 (&dA03-21-97&d@)          ³ 
&dA &d@³                             bit 0: clear = square tuplet           ³ 
&dA &d@³                                    set   = round tuplet            ³ 
&dA &d@³                             bit 1: clear = broken tuplet           ³ 
&dA &d@³                                    set   = continuous tuplet       ³ 
&dA &d@³                             bit 2: clear = number outside tuplet   ³ 
&dA &d@³                                    set   = number inside tuplet    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                           if between 128 and 255                   ³ 
&dA &d@³                             font = type - 128                      ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                           if between 0x100 and 0x1ff               ³ 
&dA &d@³                             vert and/or horz adj to musical dir    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                           if between 0x200 and 0x2ff               ³ 
&dA &d@³                             vert and/or horz adj to sub-obj        ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                           if between 0x300 and 0x3ff               ³ 
&dA &d@³                             vert and/or horz adj to note/rest/fig  ³ 
&dA &d@³                               objects.                             ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                           if between 0x400 and 0x4ff               ³ 
&dA &d@³                             suggestion for barline or measure      ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                           if between 0x500 and 0x5ff  New &dA11/05/05&d@ ³ 
&dA &d@³                             x adjustment to tuple                  ³ 
&dA &d@³                               (range -127 to +127)                 ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                           if between 0x600 and 0x6ff  New &dA11/05/05&d@ ³ 
&dA &d@³                             y adjustment to tuple                  ³ 
&dA &d@³                               (range -127 to +127)                 ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                tv3(.) & 0x000f = staff number  (0 or 1)            ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                       For notes, rests and irests                  ³ 
&dA &d@³                       & 0x00f0 = track number (0 to 9) 0=unknown   ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                       For notes,                                   ³ 
&dA &d@³                       & 0xff00 = value of repeater_flag            ³ 
&dA &d@³                       & 0xf0000 = value of color_flag              ³ (New &dA12/20/10&d@)
&dA &d@³                       For rests,                                   ³ 
&dA &d@³                       & 0xff00 = value of restplace                ³ 
&dA &d@³                       & 0xf0000 = value of color_flag              ³ (New &dA12/20/10&d@)
&dA &d@³                       For musical directions                       ³ 
&dA &d@³                       & 0xff00 = value of optional forward         ³ 
&dA &d@³                                    offset for division counter     ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                tv5(.) used for flagging $ data that occurs         ³ (New &dA01/17/04&d@)
&dA &d@³                         at the beginning of a measure, but         ³ 
&dA &d@³                         is not typeset immediately                 ³ 
&dA &d@³                                                                    ³ 
&dA &d@³              tcode(.) = pitch (rest) for types 1--8                ³ 
&dA &d@³                       = number of figure fields for type 9         ³ 
&dA &d@³                           (figured harmony)                        ³ 
&dA &d@³                       = bar type for type 10                       ³ 
&dA &d@³                       = musical direction code and position        ³ 
&dA &d@³                           for type 11                              ³ 
&dA &d@³                       = "ires" for type 12                         ³ 
&dA &d@³                       = "back" for type 13                         ³ 
&dA &d@³                       = "0" or "128" for type 14 (clef change)     ³ 
&dA &d@³                       = "" for types 15--18                        ³ 
&dA &d@³                       = for type 19 (print suggestions)            ³          
&dA &d@³                           a 4 byte code                            ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                         byte 1: 0x01: active flag (0 = inactive)   ³ 
&dA &d@³                                 0xfe: various meanings             ³ 
&dA &d@³                         (for ties only)                            ³ 
&dA &d@³                                 length modification (+128)         ³ 
&dA &d@³                                   (0 = no data)                    ³ 
&dA &d@³                         (for start slurs &dE([{z&d@ only)                ³ 
&dA &d@³                                 curvature modification (+128)      ³ 
&dA &d@³                                   (0 = no data)                    ³ 
&dA &d@³                                  (-1 = suppress slur) &dA04/26/05&d@     ³ 
&dA &d@³                         (for notes, etc.)                          ³ 
&dA &d@³                                 upper four bits used to designate  ³ 
&dA &d@³                                 note head shape.                   ³ 
&dA &d@³                                    0 = regular                     ³ 
&dA &d@³                                    1 = x (cymbal crash) &dA02/19/06&d@   ³ 
&dA &d@³                                   (2 = diamond)                    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                         byte 2: x-y active flags                   ³ 
&dA &d@³                                 0x01: active flag (0 = inactive)   ³ 
&dA &d@³                                 0x02: 0 = x position is relative   ³ 
&dA &d@³                                       1 = x position is absolute   ³ 
&dA &d@³                                 0x04: 0 = y position is relative   ³ 
&dA &d@³                                       1 = y position is absolute   ³ 
&dA &d@³                         byte 3: x position data (+128) (0=no data) ³ 
&dA &d@³                         byte 4: y position data (+128) (0=no data) ³ 
&dA &d@³                                                                    ³ 
&dA &d@³            tdata(.,.) = additional data for types 1--11, 19        ³ tdata(.,.) for type 10
&dA &d@³                                                                    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³    Output:  ts(.,.)                                                ³ 
&dA &d@³                          Description of ts                         ³ 
&dA &d@³                     --------------------------                     ³ 
&dA &d@³                                                                    ³ 
&dA &d@³     Case I:  Notes, Rests, Grace Notes, Cue Notes, Cue Rests       ³ 
&dA &d@³                 Extra Regular, Grace, and Cue notes in Chords      ³ 
&dA &d@³                     (types  1--8)                                  ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(1) = type:   1 = note                                    ³ 
&dA &d@³                        2 = extra regular note in chord             ³ 
&dA &d@³                        3 = rest                                    ³ 
&dA &d@³                        4 = cue note                                ³ 
&dA &d@³                        5 = extra cue note in chord                 ³ 
&dA &d@³                        6 = cue rest                                ³ 
&dA &d@³                        7 = grace note or grace rest                ³ 
&dA &d@³                        8 = extra grace note in chord               ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(2) = division number (starting with 1)                   ³ 
&dA &d@³        ts(3) = clave    <100 = clave number                        ³ 
&dA &d@³                          100 = rest                                ³ 
&dA &d@³                          101 = movable rest                        ³ 
&dA &d@³                          200 = irest <--                           ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(4) (used initially to store pointer to tcode(.) )        ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(4) = accidental flag                                     ³ 
&dA &d@³                                                                    ³ 
&dA &d@³           bits 0x0f: 0 = none        6 = natural-sharp             ³ 
&dA &d@³                      1 = natural     7 = natural-flat              ³ 
&dA &d@³                      2 = sharp      10 = double sharp              ³ 
&dA &d@³                      3 = flat       15 = double flat               ³ 
&dA &d@³                                                                    ³ 
&dA &d@³           bit  0x10: 0 = regular   1 = "silent"                    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³           bits 0xff00: left shift (positioning)                    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(5) = note type                                           ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                    0 = eighth with slash                           ³ 
&dA &d@³                    1 = 256th note      7 = quarter note            ³ 
&dA &d@³                    2 = 128th note      8 = half note               ³ 
&dA &d@³                    3 = 64th note       9 = whole note              ³ 
&dA &d@³                    4 = 32nd note      10 = breve                   ³ 
&dA &d@³                    5 = 16th note      11 = longa                   ³ 
&dA &d@³                    6 = 8th note       12 = maxima                  ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(6) = dot flag   0 = no dot,  1 = dot,  2 = double dot    ³ 
&dA &d@³        ts(7) = tuplet flag   0 = no tuplet, # = tuplet             ³ 
&dA &d@³                      0xff    first number                          ³ 
&dA &d@³                    0xff00    second number                         ³ 
&dA &d@³                  0xff0000    x adjustment (128 centered)           ³ 
&dA &d@³                0xff000000    y adjustment (128 centered)           ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(8) = location on staff                                   ³ 
&dA &d@³        ts(9) = spacing number                                      ³ 
&dA &d@³       ts(10) = stem/chord flag    bit      clear        set        ³ 
&dA &d@³                                  -----    -------    ---------     ³ 
&dA &d@³                                    0      no stem      stem        ³ 
&dA &d@³                                    1      step up    stem down     ³ 
&dA &d@³                                    2    single note    chord       ³ 
&dA &d@³                                    3    first note   extra note    ³ 
&dA &d@³                                  4-7    (note number in chord)     ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(11) = beam flag   0 = no beam                             ³ 
&dA &d@³                            1 = end beam                            ³ 
&dA &d@³                            2 = start beam                          ³ 
&dA &d@³                            3 = continue beam                       ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(12) = beam code (up to six digits)                        ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                 This is an integer less than 1000000.  The one's   ³ 
&dA &d@³                 digit is the code for the eighth beam; the         ³ 
&dA &d@³                 tens digit is the code for the sixteenth beam,     ³ 
&dA &d@³                 etc.                                               ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                        digit    char    meaning                    ³ 
&dA &d@³                       -------   ----   ---------                   ³ 
&dA &d@³                          0     blank   no beam                     ³ 
&dA &d@³                          1       =     continued beam              ³ 
&dA &d@³                          2       [     begin beam                  ³ 
&dA &d@³                          3       ]     end beam                    ³ 
&dA &d@³                          4       /     forward hook                ³ 
&dA &d@³                          5       \     backward hook               ³ 
&dA &d@³                          6             simple repeater             ³ 
&dA &d@³                          7             begin repeated beam         ³ 
&dA &d@³                          8             end repeated beam           ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(13) = local x-offset (for chords)                         ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(14) = superflag     bit        set                        ³ 
&dA &d@³                              -----     --------                    ³ 
&dA &d@³                               0        tie                         ³ 
&dA &d@³                               1        begin ~~~~~ without tr.     ³ 
&dA &d@³                               2        begin ~~~~~ with tr.        ³ 
&dA &d@³                               3        end ~~~~~                   ³ 
&dA &d@³                               4        begin tuplet                ³ 
&dA &d@³                               5        end tuplet                  ³ 
&dA &d@³                               6        tuple has a bracket         ³ 
&dA &d@³                               7        bracket is continuous       ³ 
&dA &d@³                                           (0 = broken)             ³ 
&dA &d@³                               8        number is inside            ³ 
&dA &d@³                                           (0 = outside)            ³ 
&dA &d@³                               9        bracket is round            ³ 
&dA &d@³                                           (0 = square)             ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                              16        tie is editorial (dotted)   ³ 
&dA &d@³                              17        ~~~ is editorial            ³ 
&dA &d@³                              18        tuple is editorial          ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(15) = slurflag    bit set  meaning                        ³ 
&dA &d@³                             -------  -------                       ³ 
&dA &d@³                               0      start slur1 (new slur)        ³ 
&dA &d@³                               1      stop slur1 (from prev. note)  ³ 
&dA &d@³                               2      start slur2  (etc.)           ³ 
&dA &d@³                               3      stop slur2                    ³ 
&dA &d@³                               4      start slur3                   ³ 
&dA &d@³                               5      stop slur3                    ³ 
&dA &d@³                               6      start slur4                   ³ 
&dA &d@³                               7      stop slur4                    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                                 for editorial slurs                ³ 
&dA &d@³                                 ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ                ³ 
&dA &d@³                              16      start slur1 (new slur)        ³ 
&dA &d@³                              17      stop slur1 (from prev. note)  ³ 
&dA &d@³                              18      start slur2  (etc.)           ³ 
&dA &d@³                              19      stop slur2                    ³ 
&dA &d@³                              20      start slur3                   ³ 
&dA &d@³                              21      stop slur3                    ³ 
&dA &d@³                              22      start slur4                   ³ 
&dA &d@³                              23      stop slur4                    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                                 for both kinds of slurs            ³ 
&dA &d@³                                 ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ            ³ 
&dA &d@³                               8      force slur1                   ³ 
&dA &d@³                               9      0 = up, 1 = down              ³ 
&dA &d@³                              10      force slur2                   ³ 
&dA &d@³                              11      0 = up, 1 = down              ³ 
&dA &d@³                              12      force slur3                   ³ 
&dA &d@³                              13      0 = up, 1 = down              ³ 
&dA &d@³                              14      force slur4                   ³ 
&dA &d@³                              15      0 = up, 1 = down              ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                                 for ties                           ³ 
&dA &d@³                                 ÄÄÄÄÄÄÄÄ                           ³ 
&dA &d@³                              24      specify tie orientation       ³ 
&dA &d@³                              25      0 = overhand; 1 = underhand   ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(16) = subflag 1    bit     item                           ³ 
&dA &d@³                             -----   -------                        ³ 
&dA &d@³                             0-3     ornaments                      ³ 
&dA &d@³                                     ---------                      ³ 
&dA &d@³                                      0 = none                      ³ 
&dA &d@³                                      1 = turn                      ³ 
&dA &d@³                                      2 = trill(tr.)                ³ 
&dA &d@³                                      3 = shake                     ³ 
&dA &d@³                                      4 = mordent                   ³ 
&dA &d@³                                      5 = delayed turn              ³ 
&dA &d@³                                      6 = tremulo  New &dA01/07/06&d@     ³ 
&dA &d@³                                     7-15 (available)               ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                             4-9     accidental combinations        ³ 
&dA &d@³                                        with ornaments              ³ 
&dA &d@³                                     -----------------------        ³ 
&dA &d@³                                     4-6 accidental above ornament  ³ 
&dA &d@³                                     7-9 accidental below ornament  ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                                     Accidental code                ³ 
&dA &d@³                                     ---------------                ³ 
&dA &d@³                                      0 = none                      ³ 
&dA &d@³                                      1 = sharp-sharp               ³ 
&dA &d@³                                      2 = flat-flat                 ³ 
&dA &d@³                                      3 = sharp                     ³ 
&dA &d@³                                      4 = natural                   ³ 
&dA &d@³                                      5 = flat                      ³ 
&dA &d@³                                      6 = (not used)                ³ 
&dA &d@³                                      7 = (not used)                ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                            10--13   dynamics                       ³ 
&dA &d@³                                     --------                       ³ 
&dA &d@³                                        0 = none                    ³ 
&dA &d@³                                        1 = p                       ³ 
&dA &d@³                                        2 = pp                      ³ 
&dA &d@³                                        3 = ppp                     ³ 
&dA &d@³                                        4 = pppp                    ³ 
&dA &d@³                                        5 = f                       ³ 
&dA &d@³                                        6 = ff                      ³ 
&dA &d@³                                        7 = fff                     ³ 
&dA &d@³                                        8 = ffff                    ³ 
&dA &d@³                                        9 = mp                      ³ 
&dA &d@³                                       10 = mf                      ³ 
&dA &d@³                                       11 = fp                      ³ 
&dA &d@³                                       12 = sfp                     ³ 
&dA &d@³                                       13 = sf                      ³ 
&dA &d@³                                       14 = sfz                     ³ 
&dA &d@³                                       15 = rfz                     ³ 
&dA &d@³                                       16 = ffp                     ³ 
&dA &d@³                                       17 = mfp    (added &dA01/12/09&d@) ³ 
&dA &d@³                                       18 = Zf     (added &dA03/16/09&d@) ³ 
&dA &d@³                                       19--31      (free)           ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                            15    print note in square/diamond font ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                            16    print note in cue size            ³ 
&dA &d@³                            17    editorial accidental              ³ 
&dA &d@³                            18    cautionary accidental             ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                            19    accidental follows trill          ³ 
&dA &d@³                                    rather than above or below      ³ 
&dA &d@³                                         (added &dA11/05/05&d@)           ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                            20--23   shape of note head             ³ 
&dA &d@³                                     ------------------             ³ 
&dA &d@³                                        0 = regular                 ³ 
&dA &d@³                                        1 = x (cymbal crash)        ³ 
&dA &d@³                                        2 -> (un-assigned)          ³ 
&dA &d@³                                          possibilities include     ³ 
&dA &d@³                                            normal diamond          ³ 
&dA &d@³                                            stem centered diamond   ³ 
&dA &d@³                                            blank (stem only)       ³ 
&dA &d@³                                            18th century            ³ 
&dA &d@³                                        (added &dA02/19/06&d@)            ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                            24    overhand back tie                 ³ 
&dA &d@³                            25    underhand back tie                ³ 
&dA &d@³                                        (added &dA04/22/08&d@)            ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                            26    upright fermata                   ³ 
&dA &d@³                            27    inverted fermata                  ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                            28--30   note color                     ³ 
&dA &d@³                                     ----------                     ³ 
&dA &d@³                                       0 = none                     ³ 
&dA &d@³                                       1 = red                      ³ 
&dA &d@³                                       2 = green                    ³ 
&dA &d@³                                       3 = blue                     ³ 
&dA &d@³                                       4 = (unallocated)            ³ 
&dA &d@³                                       5 = RED                      ³ 
&dA &d@³                                       6 = GREEN                    ³ 
&dA &d@³                                       7 = BLUE                     ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(17) = subflag 2    bit     item                           ³ 
&dA &d@³                            -----    -------                        ³ 
&dA &d@³                      n       0      down bow                       ³ 
&dA &d@³                      v       1      up bow                         ³ 
&dA &d@³                      i       2      spiccato                       ³ 
&dA &d@³                      .       3      staccato                       ³ 
&dA &d@³                      =       4      line over dot                  ³ 
&dA &d@³                      _       5      legato                         ³ 
&dA &d@³                      >       6      horizontal accent              ³ 
&dA &d@³                      A       7      vertical sfortzando accent     ³ 
&dA &d@³                      V       8      vertical sfortzando accent     ³ 
&dA &d@³                      o       9      harmonic                       ³ 
&dA &d@³                      Q      10      thumb (*)                      ³ 
&dA &d@³                      0      11      open string (0)                ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                            12-31    fingering (up to 5 numbers)    ³ 
&dA &d@³                                     ----------                     ³ 
&dA &d@³                            12-14    first number                   ³ 
&dA &d@³                                       0 = no number                ³ 
&dA &d@³                                       1 = finger 1                 ³ 
&dA &d@³                                       2 = finger 2                 ³ 
&dA &d@³                                       3 = finger 3                 ³ 
&dA &d@³                                       4 = finger 4                 ³ 
&dA &d@³                                       5 = finger 5                 ³ 
&dA &d@³                              15     substitution bit               ³ 
&dA &d@³                                       0 = no substitution          ³ 
&dA &d@³                                       1 = substitution             ³ 
&dA &d@³                            16-19   (second number, see 12 to 15)   ³       
&dA &d@³                            20-23   (third  number)                 ³ 
&dA &d@³                            24-27   (fourth number)                 ³ 
&dA &d@³                            28-31   (fifth  number)                 ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(18) = used for sorting, later used to indicate position   ³ 
&dA &d@³                     of virtual note head (for placing slurs and    ³ 
&dA &d@³                     other articulations and signs).  bit 24        ³ 
&dA &d@³                     set if modified                                ³ 
&dA &d@³       ts(19) = used for sorting, later used to indicate global     ³ 
&dA &d@³                     x-offset for chord groups                      ³ 
&dA &d@³       ts(20) = index to ASCII tsdata                               ³ 
&dA &d@³       ts(21) = pass number                                         ³ 
&dA &d@³       ts(22) = backtie flag (for regular, chord and cue notes)     ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                     0 = this note is not backward tied             ³ 
&dA &d@³                     # = this note is backward tied                 ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                 Actually the BACKTIE flag has multiple uses.       ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                 (1) When the ts array is first being constructed,  ³ 
&dA &d@³                 there may be a tie &dAinto&d@ this group of notes        ³ 
&dA &d@³                 from a previous measure.  In this case, a tiearr   ³ 
&dA &d@³                 ROW element has already been constructed.  The     ³ 
&dA &d@³                 tiearr rows need to be searched and the proper     ³ 
&dA &d@³                 one found.  This index (+ INT10000) is then        ³ 
&dA &d@³                 stored as the backtie flag.                        ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                 (2) For all other row elements of the ts array,    ³ 
&dA &d@³                 it is sufficient to store a back pointer to the    ³ 
&dA &d@³                 ts row that originated the tie.                    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                 (3) When it comes time to process the ts array,    ³ 
&dA &d@³                 three cases may be encountered.                    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                   (a) There is a non-zero backtie flag, and this   ³ 
&dA &d@³                   flag is greater than INT10000.  In this case,    ³ 
&dA &d@³                   the backtie flag (- INT10000) points to a tiearr ³ 
&dA &d@³                   ROW element, and the tie may be processed.       ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                   (b) There is a forward tie from this note.  In   ³ 
&dA &d@³                   this case, the backtie flag has already been     ³ 
&dA &d@³                   used to set a tie and the element is now free    ³ 
&dA &d@³                   for other use.  We can generate a new row element³ 
&dA &d@³                   in tiearr, and place the pointer to this element ³ 
&dA &d@³                   in the backtie flag (the term "backtie" is now   ³ 
&dA &d@³                   a misnomer).                                     ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                   (c) Now when we encounter a non-zero backtie     ³ 
&dA &d@³                   flag in a new ts ROW, we know this points to a   ³ 
&dA &d@³                   previous ts row, from which we can get the       ³ 
&dA &d@³                   pointer to the relevant tiearr ROW in that       ³ 
&dA &d@³                   ts(,.BACKTIE).                                   ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                 For this method to work properly, it is            ³ 
&dA &d@³                 necessary that backward ties be processed before   ³ 
&dA &d@³                 forward ties.  When a backward tie is processed    ³ 
&dA &d@³                 it is important to set the backtie flag to zero.   ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(23) = note duration (in divisions)                        ³ 
&dA &d@³       ts(24) = increment distance flag                             ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                0 -- fixed distance (not to be modified by print)   ³ 
&dA &d@³                # -- variable distance; # = time elaps between      ³ 
&dA &d@³                     this  node and next node.                      ³ 
&dA &d@³                     (576 divisions = quarter note)                 ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(25) = virtual end of stem (bit 24 set if modified)        ³ 
&dA &d@³       ts(26) = editorial version of ts(16), subflag 1              ³ 
&dA &d@³       ts(27) = editorial version of ts(17), subflag 2              ³ 
&dA &d@³       ts(28) = staff number                                        ³ 
&dA &d@³       ts(29) = multi-track flag << 2 + mcat flag                   ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                multi-track flag                                    ³ 
&dA &d@³                ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ                                    ³ 
&dA &d@³                0 = this note lies on a staff that has notes from   ³ 
&dA &d@³                     only one pass (the simplest and most common    ³ 
&dA &d@³                     situation).                                    ³ 
&dA &d@³                1 = this note belongs to one of multiple passes     ³ 
&dA &d@³                     on this staff and all notes on this pass       ³ 
&dA &d@³                     have stems which point up                      ³ 
&dA &d@³                2 = this note belongs to one of multiple passes     ³ 
&dA &d@³                     on this staff and all notes on this pass       ³ 
&dA &d@³                     have stems which point down                    ³ 
&dA &d@³                3 = this note belongs to one of multiple passes     ³ 
&dA &d@³                     on this staff and the notes for at least one   ³ 
&dA &d@³                     of these passes have stem directions which     ³ 
&dA &d@³                     are both up and down                           ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                mcat flag                                           ³ 
&dA &d@³                ÄÄÄÄÄÄÄÄÄ                                           ³ 
&dA &d@³                0 = only one independent instrument represented     ³ 
&dA &d@³                     in this measure (vflag = 1)                    ³ 
&dA &d@³                1 = more than one independent instrument (vflag > 1)³ 
&dA &d@³                     but only one pass and without chords (either   ³ 
&dA &d@³                     unison part, or single part)                   ³ 
&dA &d@³                2 = more than one independent instrument (vflag > 1)³ 
&dA &d@³                     but only one pass but with chords (more than   ³ 
&dA &d@³                     one part, but parts are isorhythmic)           ³ 
&dA &d@³                3 = more than one independent instrument (vflag > 1)³ 
&dA &d@³                     and more than one pass (two or more musically  ³ 
&dA &d@³                     independent parts)                             ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(30) = spacing parameter (1 <= spn <= 6913)                ³ 
&dA &d@³       ts(31) = y position of object (saves time in proc. chords)   ³ 
&dA &d@³       ts(32) = pointer to extra ts() row element for storing data  ³ 
&dA &d@³                  on slurs.  Elements 1-6 of new element are for    ³ 
&dA &d@³                  storing global data on slurs entering and leaving ³ 
&dA &d@³                  the note.  Elements 7-42 are taken in groups of   ³ 
&dA &d@³                  three (expanded from two in &dA05/06/03&d@ code revi-   ³ 
&dA &d@³                  sion), making a total of 12 such groups.  Each    ³ 
&dA &d@³                  group describes a slur entering or leaving this   ³ 
&dA &d@³                  note.  The first element in the group contains    ³ 
&dA &d@³                  general information + the x-offset; the second    ³ 
&dA &d@³                  element in the group contains the y-offset.  The  ³ 
&dA &d@³                  third element in the group contains the integer   ³ 
&dA &d@³                  equivalent of the 4-byte print suggestion for     ³ 
&dA &d@³                  the slur.  See &dATS32&d@ for more information.         ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(33) = node shift flag (positive and negative values)      ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(34) = track number: 0 if not present                      ³ 
&dA &d@³       ts(35) = base-40 pitch                                       ³ 
&dA &d@³       ts(36) = displacement of note head from the definitive       ³ 
&dA &d@³                    node position (related to GLOBAL_XOFF)          ³ 
&dA &d@³                  Value = -100  if the displacement is (approx.)    ³ 
&dA &d@³                                  one notehead to the left <--      ³ 
&dA &d@³                  Value = 100   if the displacement is (approx.)    ³ 
&dA &d@³                                  one notehead to the right -->     ³ 
&dA &d@³                  Otherwise Value = a * INT10000 + b where          ³ 
&dA &d@³                    a = width of notehead in dots                   ³ 
&dA &d@³                    b = displacement (right or left) meas. in dots  ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(39) = tsr pointer                                         ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³     Case II:  Figures                                              ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(1) = 9                                                   ³ 
&dA &d@³        ts(2) = division number (starting with 1)                   ³ 
&dA &d@³        ts(3) = number of figures in this chord                     ³ 
&dA &d@³        ts(4) = space parameter                                     ³ 
&dA &d@³        ts(5) = first figure -- position one                        ³ 
&dA &d@³        ts(6) = first figure -- position two                        ³ 
&dA &d@³        ts(7) = first start/stop flag for continuation line         ³ 
&dA &d@³        ts(8) = second figure -- position one                       ³ 
&dA &d@³        ts(9) = second figure -- position two                       ³ 
&dA &d@³       ts(10) = second start/stop flag for continuation line        ³ 
&dA &d@³       ts(11) = third figure -- position one                        ³ 
&dA &d@³       ts(12) = third figure -- position two                        ³ 
&dA &d@³       ts(13) = third start/stop flag for continuation line         ³ 
&dA &d@³       ts(14) = fourth figure -- position one                       ³ 
&dA &d@³       ts(15) = fourth figure -- position two                       ³ 
&dA &d@³       ts(16) = fourth start/stop flag for continuation line        ³ 
&dA &d@³                                                                    ³ 
&dA &d@³              figure field:  0 = blank                              ³ 
&dA &d@³                          1-19 = figure                             ³ 
&dA &d@³                            20 = +                                  ³ 
&dA &d@³                            21 = x                                  ³ 
&dA &d@³                            22 = 2+                                 ³ 
&dA &d@³                            23 = sharp                              ³ 
&dA &d@³                            24 = 4+                                 ³ 
&dA &d@³                            25 = 5+                                 ³ 
&dA &d@³                            26 = 6\                                 ³ 
&dA &d@³                            27 = 7\                                 ³ 
&dA &d@³                            28 = natural                            ³ 
&dA &d@³                            29 = flat                               ³ 
&dA &d@³                            30 = short continuation line (-)        ³ 
&dA &d@³                                                                    ³ 
&dA &d@³              Adding 1000 to figure field (position one) indicates  ³      
&dA &d@³                small parantheses around the field.                 ³ 
&dA &d@³              Adding 2000 to figure field (position one) indicates  ³      
&dA &d@³                large parantheses this figure and the one below it. ³ 
&dA &d@³              Adding 3000 to figure field (position one) indicates  ³      
&dA &d@³                large parantheses this figure and the two below it. ³ 
&dA &d@³                                                (Added &dA11/16/03&d@)    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³              start/stop continuation flag:  0 = none               ³ 
&dA &d@³                                             1 = stop               ³ 
&dA &d@³                                             2 = start              ³ 
&dA &d@³                                             3 = continue           ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(20) = minimum space for figure group                      ³ 
&dA &d@³       ts(21) = pass number                                         ³ 
&dA &d@³       ts(23) = figure duration in divisions (0 if not given)       ³ 
&dA &d@³       ts(24) = increment distance flag (see notes)                 ³ 
&dA &d@³       ts(28) = staff number                                        ³ 
&dA &d@³                                                                    ³ 
&dA &d@³     Case III:  Bar Lines                                           ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(1) = 10                                                  ³ 
&dA &d@³        ts(2) = division number (starting with 1)                   ³ 
&dA &d@³        ts(3) = bar number (0 = none)                               ³ 
&dA &d@³        ts(4) = bar type                                            ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                    1 = regular      5 = double regular             ³ 
&dA &d@³                    2 = heavy        6 = regular-heavy              ³ 
&dA &d@³                    3 = dotted       9 = heavy-regular              ³ 
&dA &d@³                                    10 = heavy-heavy                ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(5) = repeat flag                                         ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                    0 = no repeats       1 = forward repeat         ³ 
&dA &d@³                    2 = back repeat      3 = both repeats           ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(6) = backward ending flag                                ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                    0 = no ending                                   ³ 
&dA &d@³                    # = ending number: positive = stop ending       ³ 
&dA &d@³                                       negative = discontinue       ³ 
&dA &d@³                                                     ending         ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(7) = forward ending flag                                 ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                    0 = no ending                                   ³ 
&dA &d@³                    # = ending number                               ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(8) = flags                                               ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                  bit         set           clear                   ³ 
&dA &d@³                 -----    ------------     -------                  ³ 
&dA &d@³                   0      continue ~~~      stop ~~~                ³ 
&dA &d@³                   1      segno sign         0                      ³ 
&dA &d@³                   2      fermata over bar   0                      ³ 
&dA &d@³                   3      fermata under bar  0                      ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(9) = space parameter (important for non-contr. bars)     ³ 
&dA &d@³       ts(10) = number over previous measure: 0 = none              ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(20) = index to ASCII tsdata   &dKtaken out&d@,                  ³ 
&dA &d@³                                        &dAthen put back&d@  &dA03/21/03&d@     ³ 
&dA &d@³                   The reason for putting this back is that         ³ 
&dA &d@³                   we need an ASCII string to communicate           ³ 
&dA &d@³                   the NTRACK data that goes with the barline       ³ 
&dA &d@³                   object.                                          ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(21) = pass number                                         ³ 
&dA &d@³       ts(28) = number of staves                                    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³     Case IV:  Signs, Words, Marks                                  ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(1) = type   sign = 11, words = 12, mark = 13             ³ 
&dA &d@³        ts(2) = division number (starting with 1)                   ³ 
&dA &d@³        ts(3) = vertical position flag:  1 = below line             ³ 
&dA &d@³                                         2 = above line             ³ 
&dA &d@³        ts(4) = sign number                                         ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                  0 = no sign                                       ³ 
&dA &d@³                  1 = segno                                         ³ 
&dA &d@³                  2 = ped                                           ³ 
&dA &d@³                  3 = *                                             ³ 
&dA &d@³                  4 = other letter dynamics                         ³ 
&dA &d@³                  5 = D.S or D.C. (right justified string)          ³ 
&dA &d@³                  6 = fine (centered string)                        ³ 
&dA &d@³                  7 = words (left justified string)                 ³ 
&dA &d@³                  8 = tie terminator       (added &dA10-12-96&d@)         ³ 
&dA &d@³                  9 = rehearsal mark (left justified + box)         ³ 
&dA &d@³                                           (added &dA02-03-08&d@)         ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(5) = super flag                                          ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                  0 = no super-object                               ³ 
&dA &d@³                  1 = start wedge                                   ³ 
&dA &d@³                  2 = stop wedge                                    ³ 
&dA &d@³                  3 = start dashes (after words)                    ³ 
&dA &d@³                  4 = stop dashes                                   ³ 
&dA &d@³                  5 = start 8ve up                                  ³ 
&dA &d@³                  6 = stop  8ve up                                  ³ 
&dA &d@³                  7 = start 8ve down                                ³ 
&dA &d@³                  8 = stop  8ve down                                ³ 
&dA &d@³                  9 = start 15 up                                   ³ 
&dA &d@³                 10 = stop  15 up                                   ³ 
&dA &d@³                 11 = start 15 down                                 ³ 
&dA &d@³                 12 = stop  15 down                                 ³ 
&dA &d@³                 13 = normal transposition (temporary flag)         ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(6) = parameter for words:  optional font designation     ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(7) = wedge offset  (for cases where a wedge begins after ³ 
&dA &d@³                                or stops at a letter dynamic)       ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(8) = track number  (useful for multiple wedges, dashes   ³ 
&dA &d@³                                or transpositions of the same type) ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(9) = spacing (for case of isolated mark)                 ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(10) = parameter for wedges: wedge spread                  ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(11) = parameter for musical directions which are          ³ 
&dA &d@³                  objects: position shift                           ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(12) = special flag for case where this element is         ³ 
&dA &d@³                  isolated on a division (possibly with other       ³ 
&dA &d@³                  members of this same group).                      ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(13) = parameter for musical directions which are          ³ 
&dA &d@³                  super-objects: position shift                     ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(20) = index to ASCII tsdata                               ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(21) = pass number                                         ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(22) = backtie flag (for tie terminators) (added &dA10-12-96&d@) ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       ts(28) = staff number                                        ³ 
&dA &d@³                                                                    ³ 
&dA &d@³     Case V:  Clef change in middle of a measure                    ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(1) = type = 14                                           ³ 
&dA &d@³        ts(2) = division number (starting with 1)                   ³ 
&dA &d@³        ts(3) = clef number                                         ³ 
&dA &d@³        ts(4) = clef font number                                    ³ 
&dA &d@³        ts(5) = transpostion flag:                                  ³ 
&dA &d@³                                                                    ³ 
&dA &d@³                   1 = notes written octave higher than sound       ³ 
&dA &d@³                   0 = notes written at sound                       ³ 
&dA &d@³                  -1 = notes written octave lower than sound        ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(6) = position on staff                                   ³ 
&dA &d@³        ts(9) = space parameter                                     ³ 
&dA &d@³       ts(20) = index to ASCII tsdata                               ³ 
&dA &d@³       ts(21) = pass number                                         ³ 
&dA &d@³       ts(28) = staff number                                        ³ 
&dA &d@³                                                                    ³ 
&dA &d@³     Case VI:  Time designation in middle of a measure              ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(1) = type = 15                                           ³ 
&dA &d@³        ts(2) = division number (starting with 1)                   ³ 
&dA &d@³        ts(9) = space parameter                                     ³ 
&dA &d@³       ts(20) = index to ASCII tsdata                               ³ 
&dA &d@³       ts(21) = pass number                                         ³ 
&dA &d@³       ts(28) = staff number                                        ³ 
&dA &d@³                                                                    ³ 
&dA &d@³     Case VII:  Meter change in middle of a measure                 ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(1) = type = 16                                           ³ 
&dA &d@³        ts(2) = division number (starting with 1)                   ³ 
&dA &d@³        ts(3) = time number (100 time numerator + denominator)      ³ 
&dA &d@³        ts(9) = space parameter                                     ³ 
&dA &d@³       ts(20) = index to ASCII tsdata                               ³ 
&dA &d@³       ts(21) = pass number                                         ³ 
&dA &d@³       ts(28) = number of currently active staves                   ³ 
&dA &d@³                                                                    ³ 
&dA &d@³     Case VIII:  Change in number of divisions per quarter          ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(1) = type = 17                                           ³ 
&dA &d@³        ts(2) = division number (starting with 1)                   ³ 
&dA &d@³        ts(3) = divisions per quarter                               ³ 
&dA &d@³        ts(9) = space parameter                                     ³ 
&dA &d@³       ts(20) = index to ASCII tsdata                               ³ 
&dA &d@³       ts(21) = pass number                                         ³ 
&dA &d@³                                                                    ³ 
&dA &d@³       Case IX:  Change in key signature                            ³ 
&dA &d@³                                                                    ³ 
&dA &d@³        ts(1) = type = 18                                           ³ 
&dA &d@³        ts(2) = division number (starting with 1)                   ³ 
&dA &d@³        ts(3) = new key signature                                   ³ 
&dA &d@³        ts(4) = old key signature                                   ³ 
&dA &d@³        ts(9) = space parameter                                     ³ 
&dA &d@³       ts(20) = index to ASCII tsdata                               ³ 
&dA &d@³       ts(21) = pass number                                         ³ 
&dA &d@³       ts(28) = number of currently active staves                   ³ 
&dA &d@³                                                                    ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure action   
        str temp2.160 
        str slurlet.1 
        str xbyte.2,note.4,codes.12 

        int tvar1,tvar2 
        int mf2(120) 
        int multichk(3,MAX_PASS,MAX_STAFF) 
        int tiearr(MAX_TIES,TIE_ARR_SZ) 
        int figarr(MAX_FIG,4)
        int sitf 
        int tclaveax(50) 
        int dv4 
        int beamfont 
        int a3,a4,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16 
        int save_a4 
        int y1,y2,z1 
        int olda1 
        int passpar(MAX_PASS) 
        int firstsp,tfirstsp 
        int divpoint,totdiv,cuediv,mdiv,qflag 
        int figdiv,smusdir(30,4) 
        int ctrarrf(MAX_PASS),try(MAX_PASS) 
        int nodtype 
        int sobx2
        int obx1,obx2,oby1,oby2 
        int chorddur 
        int sflag,mcat 
        int xposi_shift,yposi_shift 
        int save_xposi_shift       
        int repeater_flag2 
        int repeater_dot_flag                         
        int repeater_dot_flag2                        
        int chord_spread,mdir_offset 
        int profile(100,2) 
        int sgroup(13,3),nsgroups 
        int curve       
        int npasses,thispass,passcnt(MAX_PASS,3) 
        int pitchcnt(10) 
        int clashes(10,10) 
        int tgroup(10),ntgroups 
        int ps_passcount(2) 
        int oldgr(2,45) 
        int ttextcnt 
        str ttextarr.80(6) 
        str xbytearr.2(6) 
        str chord_tones.4(10) 
        int chordsize,last_chordsize,chordsize2 
        int checkoff(10) 
        int restplace2 
        int inctype_rem 
        int org_c4 
        int nspace(MAX_M,8) 
        int old_c2 
        int color_flag2         
        bstr tbit1.2000,tbit2.2000 
        real r1,r2,r3
&dA     
        int t1,t2,t3,t4,t5,t6,t7,t8      
        if @n = 0  
          goto ACT_RETURN 
        end  
        passnum = 1  
        yposi_shift = 0 
        xposi_shift = 0 
&dA 
&dA &d@   If there are no pending slurs, then clear the ts array and set sct = 0 
&dA 
        if sct = 0 
          loop for a9 = 1 to MAX_OBJECTS 
            loop for a10 = 1 to TS_SIZE 
              ts(a9,a10) = 0 
            repeat 
            tsr(a9) = zpd(TSR_LENG)             /* &dA05/02/03&d@: was zpd(72)         
            ts(a9,TSR_POINT) = a9 
          repeat 
          outslurs = "00000000" 
        else 
          if outslurs = "00000000" 
            if sct > maxsct 
              maxsct = sct 
            end 
            loop for a9 = 1 to maxsct + 10   
              loop for a10 = 1 to TS_SIZE 
                ts(a9,a10) = 0 
              repeat 
              tsr(a9) = zpd(TSR_LENG)           /* &dA05/02/03&d@: was zpd(72)       
              ts(a9,TSR_POINT) = a9 
            repeat 
            sct = 0 
            old@n = 0 
          else 
            if sct > maxsct 
              maxsct = sct 
            end 
            loop for a9 = sct+1 to maxsct+10 
              loop for a10 = 1 to TS_SIZE 
                ts(a9,a10) = 0 
              repeat 
              tsr(a9) = zpd(TSR_LENG)           /* &dA05/02/03&d@: was zpd(72)     
              ts(a9,TSR_POINT) = a9 
            repeat 
          end 
        end 
        oldsct = sct 
&dA 
&dA &d@   If you are starting a new version of the ts(.) array then 
&dA &d@     copy claveax(.) to tclaveax(.)   &dA12/14/07&d@ 
&dA 
        if sct = 0 
          loop for a9 = 1 to 50 
            tclaveax(a9) = claveax(a9) 
          repeat 
        end 
&dA           

&dA 
&dA &d@   Store original data in set array 
&dA 
        divpoint = 1 
        figdiv = 0
        cuediv = 0 
        totdiv = 1 
        qflag = 0
        divspq = olddivspq

        loop for a9 = 1 to @n    
          tsdata(a9+old@n) = "" 
          line = tdata(a9,1) 
          tvar1 = tv1(a9)    
          tvar2 = tv2(a9)  
&dA 
&dA &d@   New code &dA12/20/10&d@ dealing with (real) color 
&dA 
          if tv3(a9) > 0xffff 
            if tvar1 <= NOTE_OR_REST 
              c5 = tv3(a9) >> 16           /* 1 <= c5 <= 7  (three colors, two modes)
              c5 <<= 28 
              ts(sct+1,SUBFLAG_1) |= c5    /* sct hasn't been incremented yet
            end 
            tv3(a9) &= 0xffff 
          end 
&dA      
          if tv3(a9) > 0xff 
            if tvar1 <= NOTE_OR_REST 
              if tvar1 = REST or tvar1 = CUE_REST 
                restplace2 = tv3(a9) >> 8 
              else 
                repeater_flag2 = tv3(a9) >> 8            /* changed &dA01/01/08
              end 
            else 
              mdir_offset = tv3(a9) >> 8 
            end 
            tv3(a9) &= 0xff 
          else 
            repeater_flag2 = 0 
            restplace2 = 0 
            mdir_offset = 0 
          end 
&dA 
&dA &d@  Deal with situation where there is an irest followed by a 
&dA &d@  print suggestion that it should be allocated space 
&dA 
          if tvar1 = IREST 
            if a9 < @n and tv1(a9+1) = P_SUGGESTION 
              if tv2(a9+1) & 0xff00 = 0x0300 
                pcontrol = ors(tcode(a9+1){1}) 
                if pcontrol = 3 or pcontrol = 5 
                  tvar1 = REST                  /* send it through the system
                  tcode(a9) = "rest"            /* as a "regular" rest 
                end 
              end 
            end 
          end        
&dA &d@              
&dA &d@  Case I:  notes, rests, cue notes, grace notes,  
&dA &d@              extra notes in chords, figures  
&dA 
          if tvar1 <> FIGURES and tvar1 <> P_SUGGESTION 
            figdiv = 0 
          end  
          if tvar1 <= NOTE_OR_REST
            loop for a3 = 1 to 7 step 3  
              a4 = a3 + 1  
              if tvar1 = a4        /* extra chord tone 
                if a9 = 1  
                  tmess = 1 
                  perform dtalk (tmess) 
                end  
                c5 = 1 
                loop while tv1(a9-c5) = P_SUGGESTION and a9 > c5 + 1 
                  ++c5 
                repeat 
                if tv1(a9-c5) <> a3   
                  if tv1(a9-c5) <> a4   
                    tmess = 1 
                    perform dtalk (tmess) 
                  end  
                else 
*  tricky code to set chord bit on first note in chord 
                  ts(sct,STEM_FLAGS) += 4   /* sct -> previous array entry 
                end        
              end  
            repeat 
            ++sct                                 /* &dIincrementing array pointer &dAsct
            ts(sct,TYPE) = tvar1   
&dA 
&dA &d@    &dASet DIV&d@ (for cue notes) 
&dA 
            if chr(tvar1) in [CUE_NOTE,XCUE_NOTE,CUE_REST] 
              if tvar1 <> XCUE_NOTE
                ts(sct,DIV) = divpoint + cuediv 
              else 
                ts(sct,DIV) = divpoint + cuediv - chorddur 
              end 
              goto WWCC 
            end  
&dA 
&dA &d@    &dASet DIV&d@ (for regular and grace notes) 
&dA 
            if tvar1 = XNOTE 
              ts(sct,DIV) = divpoint - chorddur 
            else 
              ts(sct,DIV) = divpoint 
            end 

            cuediv = 0 
&dA 
&dA &d@    In special case of arpeggios &dA01/13/06&d@, get vertical veriables 
&dA 
            if tvar1 = GR_NOTE and tvar2 = ARPEGGIO 
              if line{1} = " " 
                ts(sct,ARPEG_TOP) = int(line{2}) 
              else 
                ts(sct,ARPEG_TOP) = int(line{1,2}) 
              end 
              if line{3} = "x" 
                ts(sct,ARPEG_FLAG) = granddist 
              else 
                ts(sct,ARPEG_FLAG) = 0 
              end 
              if line{4} = " " 
                ts(sct,ARPEG_BOTTOM) = int(line{5}) 
              else 
                ts(sct,ARPEG_BOTTOM) = int(line{4,2}) 
              end 
              line{1,7} = "e      " 
            end 
&dA     

&dA 
&dA &d@     Normally at this point, we would decode the note and get  
&dA &d@     its clave number and accidental.  The reason we cannot safely  
&dA &d@     do this at this time is that the backspace command might 
&dA &d@     cause us to insert some accidentals at earlier points in 
&dA &d@     the measure.  Because of the current order, these notes  
&dA &d@     would not be accidentalized, whereas a later one (from     
&dA &d@     an earlier pass) would be.  Also, we would like to allow 
&dA &d@     the various passes to run through non-controlling bar  
&dA &d@     lines.  In any event, we must put off decoding and other 
&dA &d@     calculations that depend on this data until the entries  
&dA &d@     can be ordered by time.  In the meantime, we will store  
&dA &d@     the a pointer to the proper tcode element in ts(4)  
WWCC: 
            ts(sct,TEMP4) = a9 
            a4 = tvar2                  /* duration field, in this case 
            if tvar1 > REST                  
              a5 = tvar2                /* this will become NTYPE 

              if chr(tvar1) in [CUE_NOTE,CUE_REST] 
&dA 
&dA &d@          We must, in this case, try to assign a length to the 
&dA &d@          cue-type entity in terms of the current value of divspq.  
&dA &d@          The parameter, a4, indicates the note type: 
&dA 
&dA &d@                 1 = 256th note      7 = quarter note 
&dA &d@                 2 = 128th note      8 = half note 
&dA &d@                 3 = 64th note       9 = whole note 
&dA &d@                 4 = 32nd note      10 = breve 
&dA &d@                 5 = 16th note      11 = longa 
&dA &d@                 6 = 8th note 
&dA 
&dA &d@          Columns 4-6 of the variable line contain tuple modifications 
&dA &d@          to the note value 
&dA 
                --a4
                a3 = 1 << a4  
&dA 
&dA &d@           a3 = 64 -->  means quarter note, etc.  
&dA 
                a3 *= divspq 
&dA 
&dA &d@           a3 --> length of notetype as measured in units (64*divspq) 
&dA 
                if line{4} <> " " 
                  a4 = int(line{4}) 
                  if line{4} in ['A'..'Z'] 
                    a4 = ors(line{4}) - 55   /* A = 10, etc 
                  end 
                  a8 = a4 / 3 
               /* default values for "denominator" 
                  if rem = 0 
                    a8 *= 2 
                  else 
                    a8 = a4 - 1 
                  end 
                  if line{6} <> " " 
                    a8 = int(line{6}) 
                    if line{6} in ['A'..'Z'] 
                      a8 = ors(line{6}) - 55   /* A = 10, etc 
                    end 
                  end 
                  a3 *= a8 
                  a3 /= a4 
                  if rem <> 0 
                    tmess = 23 
                    perform dtalk (tmess) 
                  end 
                end 
&dA 
&dA &d@           a3 --> length of note measured in units (64*divspq) 
&dA &d@                    as modified by tuple information 
&dA 
                if ".:;!" con line{2}              /*  code modified &dA12-24-96
                  if mpt = 1 
                    a3 = a3 / 2 * 3 
                  else 
                    if mpt = 2 
                      a3 = a3 / 4 * 7 
                    else 
                      if mpt = 3 
                        a3 = a3 / 8 * 15 
                      else       
                        a3 = a3 / 16 * 31 
                      end 
                    end 
                  end 
                end  
&dA 
&dA &d@           a3 --> length of note measured in units (64*divspq) 
&dA &d@                    as further modified by dot information 
&dA 
                chorddur = a3 / 64 
                if rem <> 0 
                  tmess = 23 
                  perform dtalk (tmess) 
                end 
&dA 
&dA &d@               chorddur --> length of measured in units (divspq) 
&dA 
                cuediv += chorddur 
              end  
            else 
              if tvar1 <> XNOTE
                chorddur = a4  
                divpoint += a4 
                if divpoint > totdiv 
                  totdiv = divpoint  
                end  
              end  
&dA 
&dA &d@   &dA01/08/11&d@ Here is where we separate modern notation from diamond notation
&dA 
&dK &d@             if "zyxtseqhwbL" con line{1} 
&dK &d@               a5 = mpt 
&dK 
              if "zyxtseqhwbLMZYXTSEQHWB" con line{1} 
                a5 = mpt                /* this will become NTYPE 
                if a5 >= 12 
                  ts(sct,SUBFLAG_1) |= 0x008000     /* set square/diamond flag
                  if a5 > 12 
                    a5 -= 12 
                  end 
                end 
&dA     
              else 
                if "123456789AB" con line{1} 
                  a5 = mpt              /* this will become NTYPE 
                  ts(sct,SUBFLAG_1) |= 0x010000     /* set small print flag 
                else 
                  if tvar1 = REST 
&dA                            
&dA 
&dA &d@    New &dA10/15/07&d@ 
&dA 
                    if len(line) > 0 
                      if "ZYXTSEQHWB" con line{1} 
                        a5 = mpt                /* this will become NTYPE with flag
                        a5 += 0x100 
                      else 
&dA 
&dA &d@    Code modified &dA01/03/04&d@ to deal with optional whole rests 
&dA 
                        if line{1} = "o"                         /* o = float New &dA10/15/07
                          ts(sct,CLAVE) = 2   /* temporary floating rest with optionality
                        else 
                          ts(sct,CLAVE) = 1   /* temporary floating rest flag
                        end 
&dA   
                        a5 = WHOLE          /* this will become NTYPE 
                      end 
                    end 
                  else 
                    tmess = 24              /* Note type is missing.  
                    perform dtalk (tmess) 
                  end 
                end 
              end  
            end  
&dA 
&dA &d@    &dASet NTYPE
&dA 
            ts(sct,NTYPE) = a5  
&dA 
&dA &d@    &dASet STAFFLOC (for rests)&d@ 
&dA 
            if tvar1 = REST or tvar1 = CUE_REST 
              ts(sct,STAFFLOC) = restplace2 
            end 
&dA 
&dA &d@    &dASet NOTE_DUR&d@ 
&dA 
            if chr(tvar1) in [GR_NOTE,XGR_NOTE] 
              ts(sct,NOTE_DUR) = 0 
            else 
              ts(sct,NOTE_DUR) = chorddur 
            end 
                
            a8 = int(line{4}) 
            if line{4} in ['A'..'Z'] 
              a8 = ors(line{4}) - 55 
            end 
            if a8 > 0 
&dA 
&dA &d@     Code added to account for complex tuples: 5-11-93 
&dA 
              a3 = int(line{6}) 
              if line{6} in ['A'..'Z'] 
                a3 = ors(line{6}) - 55   /* A = 10, etc 
              end 
              a3 *= 256                     /* New &dA11/05/05&d@ 
&dA 
&dA &d@    &dASet TUPLE
&dA 
              ts(sct,TUPLE) = a8 + a3 
            end 
&dA 
&dA &d@    &dASet DOT&d@            
&dA 
            if ".^:^^^;^^^^^^^!" con line{2}     /*  code modified &dA12-24-96&d@ 
              ts(sct,DOT) = mpt    /* 1 = single dot; 3 = double dot; 7 = triple dot; 15 =
            end 
            if tcode(a9) <> "rest" and tcode(a9) <> "ires" 

&dAÕÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸&d@ 
&dA³&d@     This calculation must be delayed until after the decoding   &dA³&d@ 
&dA³&d@     ---------------------------------------------------------   &dA³&d@ 
&dA³&d@             a1 = 52 - ts(sct,3) - cline(.) + c8flag(.)          &dA³&d@ 
&dA³&d@             ts(sct,8) = a1 * notesize / 2                       &dA³&d@ 
&dAÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾&d@ 

&dA 
&dA &d@    &dASet STEM_FLAGS&d@   (incomplete) 
&dA 
              a1 = 0 
&dA 
&dA &d@    New code &dA12/20/05&d@ implementing general suggestion for setting stem directions
&dA 
              if stem_change_flag = 0 or stem_change_flag = 3 
                if "u@d" con line{7}     /*  stem direction "u" or "d" 
                  a1 = mpt 
                end 
              else 
                if stem_change_flag = 1
                  a1 = 0 
                else 
                  a1 = 2 
                end 
              end 
&dA       
              if tvar1 = XNOTE   
                a1 += 12 
              end  
              ts(sct,STEM_FLAGS) = a1 
&dA 
&dA &d@    &dASet BEAM_FLAG&d@ 
&dA 
              if "][=" con line{10}  
                ts(sct,BEAM_FLAG) = mpt  
              else 
                ts(sct,BEAM_FLAG) = NO_BEAM 
              end  
&dA 
&dA &d@    &dASet BEAM_CODE&d@ 
&dA 
              a4 = 0 
              if ts(sct,BEAM_FLAG) > NO_BEAM 
                if "[]=" con line{10} 
                  a3 = 1 
                  loop for a1 = 10 to 15 
                    if " =[]/\" con line{a1} 
                      a4 = mpt - 1 * a3 + a4 
                    end 
                    if mpt = 1 
                      a1 = 15 
                    else 
                      a3 *= 10 
                    end 
                  repeat 
                end 
              end 
              ts(sct,BEAM_CODE) = a4 
&dA 
&dA &d@     &dAI think this is the place to alter the ts array, in the case where&d@ 
&dA &d@     &dAa repeater is requested                                           
&dA 
              if repeater_flag2 > 0 and ts(sct,BEAM_FLAG) = END_BEAM 
                repeater_dot_flag = 0 
                a3 = repeater_flag2 & 0x03 
                if a3 = 3                       
                  repeater_dot_flag = 1 
                end 
&dA 
&dA &d@     Decision Point No. 1:  Decide if repeaters are possible 
&dA 
                a3 = 1 
REP2: 
                if a4 / a3 > 9 
                  a3 *= 10 
                  goto REP2 
                end 
                c6 = bit(1,ts(sct,STEM_FLAGS)) 
                c7 = ts(sct,NTYPE) 
&dA 
&dA &d@      For purposes of the code that follows, we need to keep track of the 
&dA &d@      subscripts which point to real data (i.e. not print suggestions) 
&dA &d@      in the data(.), tcode(.), and tv(.) arrays.  We will store these 
&dA &d@      "valid" subscripts in the mf(.) array.  
&dA 
                c10 = a9 
                c2  = 0                            /* counter for primary type 
                c4  = 100                          /* secondary beam break flag
                c14 = 100                          /* secondary beam break flag for threesomes (&dA09/21/08&d@)
                repeater_dot_flag2 = 0             /* added &dA09/21/08&d@ 

                loop for a1 = sct to 1 step -1     /* Two exits from this loop:     
                                                   /*   To REP1 when ts(a1,BEAM_FLAG) = START_BEAM (below)
                                                   /*   to NO_REP whenever a test "fails"
                  loop while tv1(c10) = P_SUGGESTION 
                    --c10 
                  repeat 
                  mf(a1) = c10
                  --c10 

                  if ts(a1,TYPE) < tvar1 or ts(a1,TYPE) > tvar1 + 1 
                    goto NO_REP 
                  end 
                  if ts(a1,TYPE) = tvar1
                    if ts(a1,TUPLE) <> 0 
                      c4 = 100000 + (ts(a1,TUPLE) & 0xffff) 
                    end 
                    a5 = ts(a1,BEAM_CODE) / a3 
                    if a5 > 3 or a5 = 0 
                      goto NO_REP 
                    end 
                    if a1 < sct and a5 = 3 and c4 < 100000  /* secondary beam ends and starts again
                      if c4 = 100 
                        c4 = 16 
                      end 
                      if c14 = 100          /* New &dA09/21/08&d@ 
                        c14 = 6 
                      end 
&dA           
&dA 
&dA &d@    &dA09/21/08&d@ Working on repeaters:  In the case of secondary beam endings, the following (existing)
&dA &d@             code allows endings only in multiples of 2.  Since multiple passes are made
&dA &d@             through this code, c4 becomes the smallest group size.  Specifically, this
&dA &d@             prevents group sizes of 3 and 6, which common enough to consider.            
&dA 
                      loop while c4 > 1 
                        c5 = c2 / c4 
                        if rem <> 0 
                          c4 >>= 1 
                        end 
                      repeat while rem <> 0 
&dA 
&dA &d@    &dA09/21/08&d@ I think the solution is to run twosome and threesome tests in parallel. 
&dA &d@             A jump to NO_REP occurs when both tests fail.  I will use c14 for this
&dA &d@             test.  (New code) 
&dA 
                      loop while c14 > 1 
                        c5 = c2 / c14 
                        if rem <> 0 
                          c14 >>= 1 
                        end 
                      repeat while rem <> 0 
                      if c4 = 1 and c14 = 1      /* c14 test added &dA09/21/08&d@ 
                        goto NO_REP 
                      end 
&dA 
&dA          
                    end 
                    ++c2 
                    mf2(c2) = a1 
                  end 
                  if bit(1,ts(a1,STEM_FLAGS)) <> c6 or ts(a1,NTYPE) <> c7 or ts(a1,DOT) > 0
                    goto NO_REP 
                  end 
                  codes = tdata(mf(a1),1){16,12} 
                  if ts(a1,BEAM_FLAG) = START_BEAM 
                    if codes con ['~',','] 
                      goto NO_REP 
                    end 
                    if codes con ['b','c','h'..'k','n','o','r'..'z','A','M','Q','S','V']
                      goto NO_REP 
                    end 
                    goto REP1 
                  end 
                  if ts(a1,BEAM_FLAG) = END_BEAM 
                    if codes con ['-','(','[','{','~','>','.','_','=',','] 
                      goto NO_REP 
                    end 
                  else 
                    if codes con ['-','(',')','[',']','{','}','~','>','.','_','=','0'..'5',',',':']
                      goto NO_REP 
                    end 
                  end 
                  if codes con ['b','c','f','h'..'z','A','E','F','M','Q'..'S','V','Z']
                    goto NO_REP 
                  end 
                repeat 
&dA 
&dA &d@     Case 1:  Check to see if all chords under the beam are the same 
&dA 
REP1: 
                chordsize = 1 
                chord_tones(1) = tcode(mf(a1)) 
                loop for a2 = a1 + 1 to sct 
                  if ts(a2,TYPE) = tvar1 
                    a2 = sct 
                  else 
                    ++chordsize 
                    chord_tones(chordsize) = tcode(mf(a2)) 
                  end 
                repeat 
&dA 
&dA &d@       In case of chord at end of beam, finish building mf(.) array 
&dA 
                c10 = a9 + 1 
                last_chordsize = 1 
                loop for a2 = sct + 1 to 100000 
                  loop while tv1(c10) = P_SUGGESTION 
                    ++c10 
                  repeat 
                  if tv1(c10) = tvar1 + 1 
                    mf(a2) = c10 
                    if "zyxtseqhwbL" con tdata(c10,1){1} 
                      if mpt <> c7            /* NTYPE of last chord tones 
                        goto NO_REP 
                      end 
                    else 
                      if "123456789AB" con tdata(c10,1){1} 
                        if mpt <> c7          /* NTYPE of last chord tones 
                          goto NO_REP 
                        end 
                      end 
                    end 
                    ++c10 
                    ++last_chordsize 
                  else  
                    a2 = 100000 
                  end 
                repeat 

                if c4 < 100                   /* secondary beams have breaks 
&dA 
&dA &d@    &dA09/21/08&d@  We need to put the correct value in c4 at this point 
&dA 
                  if c4 = 1 
                    c4 = c14 
                  end 
&dA     
                  goto REP3 
                end 

                loop for a2 = a1 + chordsize to sct
                  if ts(a2,TYPE) <> tvar1 
                    goto REP3 
                  end 
                  c5 = 0 
                  loop for c6 = 1 to chordsize 
                    checkoff(c6) = 1 
                  repeat 
REP4: 
                  c14 = 0 
                  loop for c3 = 1 to chordsize 
                    if checkoff(c3) = 1 and chord_tones(c3) = tcode(mf(a2)) 
                      checkoff(c3) = 0 
                      c14 = 1 
                      c3 = chordsize 
                    end 
                  repeat 
                  if c14 = 0 
                    goto REP3 
                  end 
                  ++c5 
                  if c5 < chordsize 
                    ++a2 
                    if a2 <= sct 
                      if ts(a2,TYPE) <> tvar1 + 1 
                        goto REP3 
                      end 
                    else 
                      if tv1(mf(a2)) <> tvar1 + 1 
                        goto REP3 
                      end 
                    end 
                    goto REP4 
                  else 
                    if a2 > sct + chordsize - 1 
                      goto NO_REP 
                    end 
                  end 
                repeat 
&dA &d@                     
&dA &d@        At this point, we have determined that all chords under the 
&dA &d@           beam are the same.  We must compact all of these notes 
&dA &d@           into one note (simplest case).  
&dA &d@                             
                c3 = sct - a1 / chordsize + 1  /* number of notes 
                c5 = ts(a1,NTYPE) 
                c6 = 0 
                c14 = ts(a1,TUPLE) & 0xffff    /* added &dA11/05/05&d@ 
                if c14 > 255                   /* no complex tuples allowed 
                  goto NO_REP 
                end 
                if c14 > 0 
                  if c14 = c3 
                    c7 = 2 
                    loop 
                      c5 += 1 
                      c8 = c3 / c7 
                      if c8 > 1 
                        c7 <<= 1 
                      end 
                    repeat while c8 > 1 
                    goto REP5 
                  else 
                    goto NO_REP                /* if tuple, then # must = group size
                  end 
                else 
                  if chr(c3) not_in [2,3,4,6,7,8,12,14,15,16,24,28,30,31,32] /* modified &dA12-24-96
                    goto NO_REP                /* must be representable with note value + dot(s)
                  end 
                  c7 = 2 
                  loop 
                    c5 += 1 
                    c8 = c3 / c7 
                    if c8 = 1 
                      mpt = rem 
                      if mpt > 0               /* code modified &dA12-24-96&d@ 
                        if mpt = c7 >> 1 
                          c6 = 1 
                        else 
                          if mpt = c7 / 4 * 3 
                            c6 = 3 
                          else 
                            if mpt = c7 / 8 * 7 
                              c6 = 7 
                            else 
                              c6 = 15 
                            end 
                          end     
                        end 
                      end 
                    else 
                      c7 <<= 1 
                    end 
                  repeat while c8 > 1 
                end 
REP5: 
                if chordsize > 1 
                  a9 += chordsize - 1          /* advance a9 over rest of last chord
                end 

                c7 = 6 
                loop for a2 = 1 to QUARTER - ts(a1,NTYPE) - 1 
                  c7 *= 10 
                  c7 += 6 
                repeat 
                ts(a1,BEAM_CODE) = c7                    /* 666... etc 
&dA 
&dA &d@    New code &dA01/01/08&d@.  Deal with special case of the repeater dot.  
&dA 
                if repeater_dot_flag = 1 and c6 = 0 
                  c6 = 1 
                end 
&dA        
                loop for a2 = a1 to a1 + chordsize - 1 
                  ts(a2,NTYPE)    =  c5 
                  ts(a2,DOT)      =  c6 
                  ts(a2,NOTE_DUR) *= c3 
                  ts(a2,BEAM_FLAG) = NO_BEAM 
                  if a2 > a1 
                    ts(a2,BEAM_CODE) = 0          
                  end 
                repeat 
&dA 
&dA &d@     &dA11/20/06&d@ Adding code here that allows a slur over repeated notes with a 
&dA &d@              repeater, provided that the slur covers all notes in the group
&dA &d@              and that chordsize = 1.  
&dA 
&dA &d@              Also, clear the rest of the ts array and reset sct 
&dA 
                a3 = 0 
                if (ts(a1,SLUR_FLAG) & 0xff) <> 0 and chordsize = 1 
                  a2 = ts(a1,SLUR_FLAG) & 0xff 
                  codes = line{16,12} 

                  if codes con ")" and a2 = 1 
                    a3 = 2 
                  end 
                  if codes con "]" and a2 = 3 
                    a3 = 8 
                  end 
                  if codes con "}" and a2 = 5 
                    a3 = 32 
                  end 
                  if codes con "x" and a2 = 7 
                    a3 = 128 
                  end 
                end 
&dA 
&dA &d@          We have already eliminated those cases where slurs start or end 
&dA &d@            within a repeater group. (about 200 lines above) 
&dA 
                if a3 > 0 
                  c5 = ts(sct,DIV) 
                  c6 = ts(sct,AX) 
                  c7 = ts(sct,NOTE_DUR) 
                  ts(a1,NOTE_DUR) -= c7 
                  loop for a2 = a1 + chordsize to sct 
                    loop for c8 = 1 to TS_SIZE 
                      if c8 <> TSR_POINT 
                        ts(a2,c8) = 0 
                      end 
                    repeat 
                  repeat 
                  ++a1 
                  ts(a1,TYPE) = NOTE 
                  ts(a1,DIV) = c5 
                  ts(a1,AX) = c6 
                  ts(a1,NOTE_DUR) = c7 
                  ts(a1,TEXT_INDEX) = c6 
                  ts(a1,PASSNUM) = passnum 
                  ts(a1,SLUR_FLAG) = a3 

&dA                 &d@ End of &dA11/20/06&d@ addition 

                else 
                  loop for a2 = a1 + chordsize to sct 
                    loop for a3 = 1 to TS_SIZE 
                      if a3 <> TSR_POINT 
                        ts(a2,a3) = 0 
                      end 
                    repeat 
                  repeat 
                end 
&dA 
&dA &d@   &dA01/04/06&d@:  There is a problem when a tuple has been started on a repeater.
&dA &d@              First, tuflag has be set to 1, and has not been reset.  Second,
&dA &d@              the SUPER_FLAG has been set to show a tuple starting, but never
&dA &d@              ending.  I can fix these problems here, but this may be symtomatic
&dA &d@              of problems with other super-objects, such as slurs.  I am not
&dA &d@              going to check this out at this point, but be aware!  
&dA 
                loop for a2 = a1 to a1 + chordsize - 1 
                  if ts(a2,SUPER_FLAG) <> 0 
                    if (ts(a2,SUPER_FLAG)) & 0x10 <> 0 
                      tuflag = 0 
                      ts(a2,SUPER_FLAG) &= 0xffef     /* turn off start tuple
                    else 
                      if (Debugg & 0x06) > 0 
                        pute WARNING:  SUPER_FLAG is non-zero at a repeater at
                        pute approximately measure number ~measnum .   Which means
                        pute that repeaters are mixed with ties, slurs, or other
                        pute notations that touch more than one note (in a manner
                        pute not supported by this program).  
                      end 
                    end 
                  else 
                    ts(a2,TUPLE) = 0 
                  end 
                repeat 
&dA       
                sct = a1 + chordsize - 1 
                goto EBL  
REP3: 
&dA 
&dA &d@     Case 2:  Check to see if chords under the beam can be arranged 
&dA &d@                in groups of 2, 4, 8, or 16 
&dA 
&dA &d@                c2 = number of chords 
&dA &d@                mf2(.) = ts subscripts for primary notes of each chord 
&dA &d@                c4 = either: maximum group size    
&dA &d@                         or: 100 (no group size limitation) 
&dA &d@                         or: >= 1000 (tuples are present; no groups allowed)
&dA 
                if c4 >= 100000 
                  goto REP15       /* &dA02/19/97&d@ change accomodates tuples 
                end 
                if c4 = 100 
                  c4 = 32 
                  loop while c4 > c2 / 2 
                    c4 >>= 1 
                  repeat 
                end 
                loop while c4 > 1 
                  c3 = c2 / c4 
                  if rem <> 0 
                    c4 >>= 1 
                  end 
                repeat while rem <> 0 
                c5 = ts(a1,NTYPE)    
                c6 = 1 
                loop while c5 < EIGHTH
                  c6 <<= 1 
                  ++c5 
                repeat 

                repeater_dot_flag2 = 0        /* New &dA09/21/08&d@ 
                if c4 > c6 
                  c11 = c4 / 3 
                  if rem = 0 
                    repeater_dot_flag2 = 1    /* New &dA09/21/08&d@ 
                  else 
                    c4 = c6                   /* Default from old version 
                  end 
                end 
                if c4 = 1 
                  goto REP15 
                end 
&dA 
&dA &d@          c4 is now the largest possible group notes under beam 
&dA &d@          Next we investigate the question of whether c4 is a 
&dA &d@          "legal" group size.  
&dA 
REP11: 
&dA 
&dA &d@          Look for first (actually last) chord prototype 
&dA 
                c1 = 1                      /* index into mf2 
                c3 = mf2(c1)                /* c3 should start as sct 
                chordsize = 1 
                chord_tones(1) = tcode(mf(c3)) 
                ++c3 
                loop while chordsize < last_chordsize   /* 
                  ++chordsize 
                  chord_tones(chordsize) = tcode(mf(c3))    /* accumulate chord tones
                  ++c3 
                repeat 
&dA 
&dA &d@          Look for additional chords to match prototype 
&dA 
REP9: 
                c6 = 1                  /* chord counter 
REP8: 
                ++c1 
                c3 = mf2(c1)            /* ts index to next primary note backward in list
                c5 = 0 
                loop for c11 = 1 to chordsize 
                  checkoff(c11) = 1 
                repeat 
REP6: 
                c11 = 0 
                loop for c12 = 1 to chordsize 
                  if checkoff(c12) = 1 and chord_tones(c12) = tcode(mf(c3)) 
                    checkoff(c12) = 0 
                    c11 = 1 
                    c12 = chordsize 
                  end 
                repeat 
                if c11 = 0 
                  goto REP7                /* this pitch (tcode) was not found in chord
                end 
                ++c5 
                ++c3 
                if c5 < chordsize 
                  if c3 = mf2(c1-1)                              
                    goto REP7              /* this chord is not big enough 
                  end 
                  goto REP6 
                else 
                  if c3 <> mf2(c1-1)         
                    goto REP7              /* this chord is too big 
                  end 
                end 
                ++c6                       /* "valid" chord found 
                if c6 < c4 
                  goto REP8 
                end 
&dA 
&dA &d@          Set up to look for new chord prototype 
&dA 
                if c1 < c2 
                  ++c1                        /* index into mf2 
                  c3 = mf2(c1)                /* c3 should start as sct 
                  chordsize = 1 
                  chord_tones(1) = tcode(mf(c3)) 
                  ++c3 
                  loop while c3 < mf2(c1-1) 
                    ++chordsize 
                    chord_tones(chordsize) = tcode(mf(c3))    /* accumulate chord tones
                    ++c3 
                  repeat 
                  goto REP9 
                end 
                goto REP10                    /* successful pattern match 
REP7: 
                c4 >>= 1 
                if c4 > 1 
                  goto REP11 
                else 
                  goto REP15 
                end 
&dA 
&dA &d@       Repeaters on groups of chords will work, if group size = c4 
&dA 
REP10: 
                c5 = ts(a1,NTYPE) 
                c7 = c4 
                c15 = 0 
                loop 
                  ++c15 
                  ++c5 
                  c7 >>= 1 
                repeat while c7 > 1 

                c1 = c2 
                c6 = mf2(c2)                     /* position for revised data 
REP13:                                           /* loop between groups 
                c3 = mf2(c1) 
REP12:                                           /* loop within chord 
                ts(c3,NTYPE) = c5 
                ts(c3,NOTE_DUR) *= c4 
                ts(c3,DOT) = repeater_dot_flag2      /* New &dA09/21/08&d@ 
                if c3 <> mf2(c1) 
                  c13 = NO_BEAM 
                  ts(c3,BEAM_CODE) = 0
                else 
                  temp3 = chs(ts(c3,BEAM_CODE)) 
                  c14 = len(temp3) 
                  if c1 = c2                     /* beginning of first group 
                    c13 = START_BEAM 
                    temp3 = "222222"{1,c14} 
                  else 
                    if c1 = c4                   /* beginning of last group 
                      c13 = END_BEAM 
                      temp3 = "333333"{1,c14} 
                    else 
                      c13 = CONT_BEAM 
                      temp3 = "111111"{1,c14} 
                    end 
                  end 
                  temp3{1,c15} = "666666"{1,c15} 
                  ts(c3,BEAM_CODE) = int(temp3) 
                end 
                ts(c3,BEAM_FLAG) = c13 
                ++c3                             /* next pitch in chord 
                if c3 < mf2(c1-1) 
                  goto REP12 
                end 
                chordsize = c3 - mf2(c1) 
&dA 
&dA &d@         Move data to revised position 
&dA 
                if c1 <> c2  
                  c7 = mf2(c1)                   /* source location; c6 = destination
                  loop for c8 = 1 to chordsize        
                    loop for c9 = 1 to TS_SIZE 
                      if c9 <> TSR_POINT 
                        ts(c6,c9) = ts(c7,c9) 
                      end 
                    repeat 
                    ++c6 
                    ++c7 
                  repeat 
                else 
                  c6 += chordsize 
                end 
                if c1 > c4 
                  c1 -= c4 
                  goto REP13 
                end 
                if last_chordsize > 1 
                  a9 += last_chordsize - 1    /* advance a9 over rest of last chord
                end 
&dA 
&dA &d@         Clear the rest of the ts array and reset sct 
&dA 
                loop for c8 = c6 to sct 
                  loop for c9 = 1 to TS_SIZE 
                    if c9 <> TSR_POINT 
                      ts(c8,c9) = 0 
                    end 
                  repeat 
                repeat 
                sct = c6 - 1 
                goto EBL  
REP15: 
&dA 
&dA &d@        Alternating case is the only possibility left 
&dA 
&dA &d@     Case 3:  Check to see if chords under the beam alternate             
&dA &d@                in groups of 4, 8, 16, or 32, or a tuple size which is even
&dA 
&dA &d@                c2 = number of chords 
&dA &d@                mf2(.) = ts subscripts for primary notes of each chord 
&dA 

&dA 
&dA &d@           Also allow alternating groups of size 6, 12, and 24 (&dA01/15/06&d@) 
&dA 
                if chr(c2) not_in [4,6,8,12,16,24,32] 
                  if c4 > 100000                      /* &dA02/19/97&d@ change accomodates tuples
                    c4 -= 100000 
                    if c4 & 0x01 = 0 
                      if c4 = c2 and c4 >= 6 
                        goto REP15A 
                      end 
                    end 
                  end 
                  goto REP16 
                end 
&dA 
&dA &d@          Look for first (actually last) chord prototype 
&dA 
REP15A: 
                c1 = 1                      /* index into mf2 
                c3 = mf2(c1)                /* c3 should start as sct 
                chordsize = 1 
                chord_tones(1) = tcode(mf(c3)) 
                ++c3 
                loop while chordsize < last_chordsize   /* 
                  ++chordsize 
                  chord_tones(chordsize) = tcode(mf(c3))    /* accumulate chord tones
                  ++c3 
                repeat 
&dA 
&dA &d@          Check all "odd" chords for a match               
&dA 
                loop for c1 = 3 to c2 - 1 step 2 
                  c3 = mf2(c1)          /* ts index to next "odd" primary note backward in list
                  c5 = 0 
                  loop for c11 = 1 to chordsize 
                    checkoff(c11) = 1 
                  repeat 
REP17: 
                  c11 = 0 
                  loop for c12 = 1 to chordsize 
                    if checkoff(c12) = 1 and chord_tones(c12) = tcode(mf(c3)) 
                      checkoff(c12) = 0 
                      c11 = 1 
                      c12 = chordsize 
                    end 
                  repeat 
                  if c11 = 0 
                    goto NO_REP            /* this pitch (tcode) was not found in chord
                  end 
                  ++c5 
                  ++c3 
                  if c5 < chordsize 
                    if c3 = mf2(c1-1) 
                      goto NO_REP            /* this chord is not big enough 
                    end 
                    goto REP17 
                  else 
                    if c3 <> mf2(c1-1) 
                      goto NO_REP            /* this chord is too big 
                    end 
                  end 
                repeat 
&dA 
&dA &d@          Look for second (actually penultimate) chord prototype 
&dA 
                c1 = 2                      /* index into mf2 
                c3 = mf2(c1)        
                chordsize2 = 1 
                chord_tones(1) = tcode(mf(c3)) 
                ++c3 
                loop while c3 <> mf2(c1-1) 
                  ++chordsize2 
                  chord_tones(chordsize2) = tcode(mf(c3))    /* accumulate chord tones
                  ++c3 
                repeat 
&dA 
&dA &d@          Check all "even" chords for a match 
&dA 
                loop for c1 = 4 to c2 step 2 
                  c3 = mf2(c1)          /* ts index to next "even" primary note backward in list
                  c5 = 0 
                  loop for c11 = 1 to chordsize2 
                    checkoff(c11) = 1 
                  repeat 
REP18: 
                  c11 = 0 
                  loop for c12 = 1 to chordsize2 
                    if checkoff(c12) = 1 and chord_tones(c12) = tcode(mf(c3)) 
                      checkoff(c12) = 0 
                      c11 = 1 
                      c12 = chordsize2 
                    end 
                  repeat 
                  if c11 = 0 
                    goto NO_REP            /* this pitch (tcode) was not found in chord
                  end 
                  ++c5 
                  ++c3 
                  if c5 < chordsize2 
                    if c3 = mf2(c1-1) 
                      goto NO_REP            /* this chord is not big enough 
                    end 
                    goto REP18 
                  else 
                    if c3 <> mf2(c1-1) 
                      goto NO_REP            /* this chord is too big 
                    end 
                  end 
                repeat 
&dA 
&dA &d@       At this point, we have determined that there are c2/2 matching 
&dA &d@       pairs of chords, and that c2 = 4,6,8,12,16,24 or 32, or an even tuple
&dA &d@       of 6 or greater.  In this situation we may reduce these c2 
&dA &d@       entries to two entries.  The duration of each entry is c2/2 
&dA &d@       times the old duration.  The old duration determines the number 
&dA &d@       of beams; the new duration determines the number of through 
&dA &d@       beams.  We are going to have to change the the division number 
&dA &d@       for the second member of the group.  It is the same as the 
&dA &d@       division number of the (c2/2+1)-th member of the group.  
&dA 

&dA 
&dA &d@      &dA01/15/06&d@ Code added to deal with alternating groups of size 6, 12, and 24
&dA 
                c7 = c2 / 3 
                if rem = 0 
                  ts(c3,DOT) = 1 
                  c4 = c2 / 3 
                else 
                  c4 = c2 / 2 
                end 
&dA      
                c5 = ts(a1,NTYPE) 
                c7 = c4 
                loop 
                  ++c5                     /* new duration 
                  c7 >>= 1 
                repeat while c7 > 1 
                if c5 > 6 and c2 < 8       /* don't do a four group of eighths, etc.
                  goto NO_REP 
                end 

                c15 = 7 - ts(a1,NTYPE)     /* total number of beams 
                c14 = 7 - c5               /* number through beams 
                if c14 < 0 
                  c14 = 0 
                end 
#if OLD_REPEATERS 
                if c5 = 7 
                  c5 = 8 
                  c14 = c15 
                end 
#endif 
                c15 -= c14                 /* number of shortened beams 
&dA 
&dA &d@         Code added &dA01/15/06&d@ to allow alternating group sizes of 6, 12, and 24
&dA &d@            with repeaters.  This code gets the DIV variable right 
&dA &d@                   
                if ts(c3,DOT) = 1 
                  c12 = c4 * 3 / 2         /* because we are counting backward in mf2(.)
                  c12 = mf2(c12) 
                else 
                  c12 = mf2(c4) 
                end 
&dA      
                c12 = ts(c12,DIV)          /* division number for second member

                c6 = mf2(c2)                     /* position for revised data 
                c3 = mf2(c2) 
REP19:                                           /* loop within first chord 
                ts(c3,NTYPE) = c5 
                c13 = c2 / 3                     /* &dA02/19/97&d@  added for 6-tuples, 12-tuples
                if rem = 0 
                  ts(c3,DOT) = 1  
                end 
                ts(c3,NOTE_DUR) *= c4 
                if c3 <> mf2(c2) 
                  c13 = NO_BEAM 
                  ts(c3,BEAM_CODE) = 0 
                else 
                  temp3 = "777777"{1,c15} // "222222"{1,c14} 
                  ts(c3,BEAM_CODE) = int(temp3) 
                  c13 = START_BEAM 
                end 
                ts(c3,BEAM_FLAG) = c13 
                ++c3                             /* next pitch in chord 
                if c3 < mf2(c2-1) 
                  goto REP19 
                end 
                chordsize = c3 - mf2(c2) 
                c6 += chordsize 
REP20:                                           /* loop within second chord 
                ts(c3,DIV)   = c12 
                ts(c3,NTYPE) = c5 
                c13 = c2 / 3                     /* &dA02/19/97&d@  added for 6-tuples, 12-tuples
                if rem = 0 
                  ts(c3,DOT) = 1  
                end 
                ts(c3,NOTE_DUR) *= c4 
                if c3 <> mf2(c2-1) 
                  c13 = NO_BEAM 
                  ts(c3,BEAM_CODE) = 0 
                else 
                  temp3 = "888888"{1,c15} // "333333"{1,c14} 
                  ts(c3,BEAM_CODE) = int(temp3) 
                  c13 = END_BEAM 
                end 
                ts(c3,BEAM_FLAG) = c13 
                ++c3                             /* next pitch in chord 
                if c3 < mf2(c2-2) 
                  goto REP20 
                end 
                chordsize = c3 - mf2(c2-1) 
                c6 += chordsize 

                if last_chordsize > 1 
                  a9 += last_chordsize - 1    /* advance a9 over rest of last chord
                end 
&dA 
&dA &d@         Clear the rest of the ts array and reset sct 
&dA 
                loop for c8 = c6 to sct 
                  loop for c9 = 1 to TS_SIZE 
                    if c9 <> TSR_POINT 
                      ts(c8,c9) = 0 
                    end 
                  repeat 
                repeat 
                sct = c6 - 1 
REP16: 
              end 
NO_REP: 
            end  
&dA 
&dA &d@    &dAConstruct SUPER_FLAG&d@ 
&dA 
            a14 = 0                                 /* a14 will become ts(14) 
            codes = line{16,12} 
&dA 
&dA &d@    look for starting tuplet  
&dA 
            if ts(sct,TUPLE) > 0  
              if tuflag = 0 and codes con "*" 
                tuflag = 1 
                a1 = mpt 
                a14 |= 0x10                         /* begin tuplet 
                if codes con "&" and mpt < a1 
                  a14 |= 0x40000                    /* editorial tuplet flag &dA03-21-97
                end                                 
              end  
            end  
&dA 
&dA &d@    look for end of ~~~~~ 
&dA 
            if ctrflag(passnum) > 0                 /* ctrflag changed to array &dA12/08/07
              if codes con "c"   
              else 
                a14 |= 0x08                         /* end ~~~~~ 
                if ctrflag(passnum) >= 0x100 
                  a14 |= 0x20000                    /* editorial ~~~ flag &dA03-21-97
                end  
                ctrflag(passnum) = 0 
              end  
            end  
&dA 
&dA &d@    look for start of ~~~~~ 
&dA 
            if codes con "~"   
              if ctrflag(passnum) = 0               /* New &dA12/08/07&d@ 
                a7 = mpt 
                if codes con "&" and mpt < a7 
                  ctrflag(passnum) = 0x0200         /* editorial start ~~~~~
                  a14 |= 0x20000                    /* editorial ~~~ flag &dA03-21-97
                else 
                  ctrflag(passnum) = 0x02           /* start ~~~~~ 
                end  
                if codes con "t"   
                  ctrflag(passnum) <<= 1 
                  a14 |= 0x04                       /* begin ~~~ with trill 
                else 
                  a14 |= 0x02                       /* begin ~~~ without trill
                end 
              end  
            end  
&dA 
&dA &d@    look for forward tie 
&dA 
            if codes con "-"   
              a7 = mpt 
              a14 |= 0x01                           /* tie flag 
              if codes con "&" and mpt < a7 
                a14 |= 0x10000                      /* editorial tie (dotted) &dA03-21-97
              end  
            end  
&dA 
&dA &d@    look for end of tuplet 
&dA 
            if codes con "!" and tuflag = 1 
              a7 = mpt 
              a14 |= 0x20                           /* end tuplet 
              if codes con "&" and mpt < a7 
                a14 |= 0x40000                      /* editorial tuplet flag &dA03-21-97
              end 
              tuflag = 0 
            end  
&dA 
&dA &d@    &dASet SUPER_FLAG&d@ 
&dA 
            ts(sct,SUPER_FLAG) = a14  

            a14 = 0  
            loop for a1 = 1 to 12 
              if codes{a1} = "@"     /* New &dA12/18/10&d@.  Just to make sure "@" isn't used
                codes{a1} = "?" 
              end 
              if codes{a1} = "&"     /* and codes{a1+1} in ['0'..'9'] 
                a14 = 1  
                if codes{a1+1} in ['0'..'9','X']        /* New &dA05/17/03&d@ 
                  ++a1 
                end 
                goto TLP1      /* skip &# 
              end  
              if "()[]{}zx" con codes{a1} 
                --mpt 
                a7 = 1 << mpt 
                if a14 = 1 
                  a7 <<= 16 
                end 
                ts(sct,SLUR_FLAG) |= a7 
                goto TLP1      
              end 
&dA 
&dA &d@    look for turns, mordents, and their accidentals (trills taken out &dA11/05/05&d@)
&dA &d@                    (T) tremulos added &dA01/07/06&d@ 
&dA 
              if "r@wMkT" con codes{a1}       /* code amended      &dA01/07/06&d@ 
                a7 = mpt 
&dA 
&dA &d@    Special case of tremulo &dA01/07/06&d@; no editorial and no accidentals allowed
&dA 
                if a14 = 0 and a7 = 6 
                  ts(sct,SUBFLAG_1) |= a7
                  goto TLP1 
                end 
&dA    
                if a14 = 0 
                  ts(sct,SUBFLAG_1) |= a7
                else   
                  ts(sct,ED_SUBFLAG_1) |= a7 
                end  

                temp3 = codes // pad(13) 
                loop for a3 = a1 + 1 to 13 
                repeat while "shbu" con temp3{a3} 
                if a3 = a1 + 1 
                  goto TLP1 
                end 
                a7 = 0 
                temp3 = codes{a1+1..a3-1} 
                a1 = a3 - 1 
                if temp3 con "u" 
                  temp4 = temp3{mpt..} // "..." 
                  if mpt = 1 
                    temp3 = "" 
                  else 
                    temp3 = temp3{1,mpt-1} 
                  end 
                  if "uss.ubb.us..uh..ub.." con temp4{1,4} 
                    a7 = mpt + 3 
                    a7 = a7 << 1 
                  end 
                end 
                temp4 = temp3 // "...." 
                if "ss..bb..s...h...b..." con temp4{1,4} 
                  mpt += 3 
                  mpt >>= 2 
                  a7 |= mpt
                end 
                a7 <<= 4 
                if a14 = 0 
                  ts(sct,SUBFLAG_1) |= a7 
                else 
                  ts(sct,ED_SUBFLAG_1) |= a7 
                end 
                goto TLP1      
              end 
&dA 
&dA &d@    New code &dA11/05/05&d@ for trills and their accidentals 
&dA 
              if codes{a1} = "t" 
                a4 = 0                                /* this will be bit 19
                a7 = 2  
                if a14 = 0 
                  ts(sct,SUBFLAG_1) |= a7
                else   
                  ts(sct,ED_SUBFLAG_1) |= a7 
                end  

                temp3 = codes // pad(13) 
                loop for a3 = a1 + 1 to 13 
                repeat while "shbuU" con temp3{a3} 
                if a3 = a1 + 1 
                  goto TLP1 
                end 

                a7 = 0 
                temp3 = codes{a1+1..a3-1} 
                a1 = a3 - 1 

                if temp3 con "u" or temp3 con "U" 
                  temp4 = temp3{mpt..} // "..." 
                  if mpt = 1 
                    temp3 = "" 
                  else 
                    temp3 = temp3{1,mpt-1} 
                  end 
                  if "uss.ubb.us..uh..ub.." con temp4{1,4} 
                    a7 = mpt + 3                          /*  4,8,12,16,20 
                    a7 = a7 << 1                          /*  8,16,24,32,40  = 8 x (1,2,3,4,5)
                  end 
                  if "Uss.Ubb.Us..Uh..Ub.." con temp4{1,4} 
                    a7 = mpt + 3                          /*  4,8,12,16,20 
                    a7 = a7 >> 2                          /*  1,2,3,4,5 
                    a4 = 1 
                  end 
                end 
                temp4 = temp3 // "...." 
                if "ss..bb..s...h...b..." con temp4{1,4} 
                  mpt += 3 
                  mpt >>= 2 
                  a7 |= mpt
                end 
                a7 <<= 4 
                a4 <<= 19 
                if a14 = 0 
                  ts(sct,SUBFLAG_1) |= a7 
                  ts(sct,SUBFLAG_1) |= a4                  /* establish bit 19
                else 
                  ts(sct,ED_SUBFLAG_1) |= a7 
                  ts(sct,ED_SUBFLAG_1) |= a4               /* establish bit 19
                end 
                goto TLP1      
              end 
&dA 
&dA                            &d@ End of &dA11/05/05&d@ New Code 

              if "^+@@@@@@@FE" con codes{a1}       /* Fermatas moved &dA12/18/10
                mpt += 16 
                a7 = 1 << mpt   
                if a14 = 0 
                  ts(sct,SUBFLAG_1) |= a7
                else   
                  ts(sct,ED_SUBFLAG_1) |= a7 
                end  
                goto TLP1      
              end  
&dA 
&dA &d@    look for dynamics   (This section recoded &dA10/08/08&d@ to simplify and add extra dynamic combinations)
&dA 
&dA &d@          New code &dA10/08/08&d@ 
&dA 
              if "mpfZR" con codes{a1} 
                a7 = 0 
                temp4 = codes // pad(13)    /* so we don't run off at the end
                temp3 = temp4{a1} 
                loop while "pf" con temp4{a1+1}   /* add f's and p's to first letter
                  temp3 = temp3 // temp4{a1+1} 
                  ++a1                      /* this will rightsize a1 
                repeat 
                temp3 = temp3 // pad(4) 
                temp3 = temp3{1,4} 
                temp3 = temp3 // "."        /* max data length = 4; full padded length = 5
                if "p   .pp  .ppp .pppp.f   .ff  .fff .ffff.mp  .mf  .fp  .Zp  .fz  .Z   .R   ." con temp3
                  a7 = mpt + 4 / 5          /* values 1 to 15 
                  a7 <<= 10                 /* range in bits 0x3c00 
                end 

                if "ffp .mfp .Zf  ." con temp3 
                  a7 = mpt + 4 / 5 + 15     /* values 16 to 18 New &dA03/16/09&d@; rearranged &dA12/18/10
                  a7 <<= 10                 /* range in bits 0x7c00 
                end 
&dA 
&dA            &d@  End of new code &dA10/08/08&d@ 

                if a14 = 0 
                  if ts(sct,SUBFLAG_1)  & 0x7c00 = 0      /* &dA12/18/10&d@ dynamics in one spot now
                    ts(sct,SUBFLAG_1) |= a7 
                  end 
                else 
                  if ts(sct,ED_SUBFLAG_1) & 0x7c00 = 0        /* &dA12/18/10&d@ (see above)
                    ts(sct,ED_SUBFLAG_1) |= a7 
                  end 
                end 
                goto TLP1 
              end 
&dA 
&dA &d@    look for back ties   New &dA04/22/08&d@ 
&dA 
              if "JK" con codes{a1} 
                a7 = 1 << (mpt + 23) 
                ts(sct,SUBFLAG_1) |= a7 
                goto TLP1 
              end 
&dA 
&dA &d@    other directions connected with notes 
&dA 
              if "nvi.=_>AVoQ0" con codes{a1}    
                --mpt 
                a7 = 1 << mpt 
                if a14 = 0 
                  ts(sct,SUBFLAG_2) |= a7 
                else 
                  ts(sct,ED_SUBFLAG_2) |= a7 
                end 
                goto TLP1 
              end 
&dA 
&dA &d@    fingering connected with notes 
&dA 
              if "12345" con codes{a1} 
                a4 = mpt 
                a7 = 0 
                a3 = 0 
FINNN: 
                if a1 < len(codes) and "12345:" con codes{a1+1} 
                  if mpt = 6 
                    a4 += 8 
                  else 
                    a4 <<= a3 
                    a7 += a4 
                    a4 = mpt 
                    a3 += 4 
                  end 
                  ++a1 
                  goto FINNN 
                end 
                a4 <<= a3 
                a7 += a4 
                a7 <<= 12 
                if a14 = 0 
                  ts(sct,SUBFLAG_2) |= a7 
                else 
                  ts(sct,ED_SUBFLAG_2) |= a7 
                end 
                goto TLP1 
              end 
TLP1: 
            repeat 
            tsdata(a9+old@n) = line{28..} 

            ts(sct,TEXT_INDEX) = a9 + old@n 
            ts(sct,PASSNUM) = passnum  
            ts(sct,STAFF_NUM) = tv3(a9) & 0x000f 
            ts(sct,TRACK_NUM) = tv3(a9) >> 4 & 0x000f 
            goto EBL 
          end  
&dA 
&dA &d@  Case II:  figures 
&dA 
          if tvar1 = FIGURES
            ++sct
            ts(sct,TYPE) = tvar1   
            if figdiv = 0  
              figdiv = divpoint  
            end  
            ts(sct,DIV) = figdiv  
            ts(sct,FIG_DUR) = tvar2  
            figdiv += tvar2 
            a3 = sct - 1 
            a4 = 0 
            loop while a3 > oldsct 
              if ts(a3,TYPE) = FIGURES 
                a4 = a3  
              end  
              --a3
            repeat while a4 = 0  
*   a4 = pointer to previous figure data in measure (or 0) 
            ts(sct,NUMBER_OF_FIG) = int(tcode(a9))  
            if ts(sct,NUMBER_OF_FIG) > 4  
              tmess = 2 
              perform dtalk (tmess) 
            end  
            a7 = FIG_DATA
            loop for a5 = 1 to ts(sct,NUMBER_OF_FIG) 
              line = mrt(line) 
              if line = "" 
                tmess = 2 
                perform dtalk (tmess) 
              end  
&dA 
&dA &d@    Adding new code &dA11/16/03&d@ to allow for parentheses around figure fields 
&dA 
              a13 = 0                           /* initialize parentheses flag to null
              line = line // " " 
              if line{1} = "(" 
                if line con ")" 
                  a6 = mpt - 1 
                  if mpt = 2 
                    tmess = 2 
                    perform dtalk (tmess) 
                  end 
                  a13 = 1 
                  temp = line{2..(mpt-1)}       /* section of line inside ()
                  if temp{1} = " " 
                    tmess = 2 
                    perform dtalk (tmess) 
                  end                           /* section starts with non-blank field
WB1a: 
                  if temp con " " 
                    temp = temp{mpt..}          /* skip over non-blank field
                    temp = mrt(temp)            /* and remove leading blanks to next field
                    if temp = "" 
                      tmess = 2 
                      perform dtalk (tmess) 
                    end 
                    ++a13   
                    goto WB1a 
                  end 
                  if a13 > (ts(sct,NUMBER_OF_FIG) - a5 + 1) 
                    tmess = 2 
                    perform dtalk (tmess) 
                  end 
                  a13 *= 1000 
                  line = line{2..a6}            /* now remove parentheses from line
                else 
                  tmess = 2 
                  perform dtalk (tmess) 
                end 
              end 
&dA   
              if line con " "  
                temp = line{1,mpt-1} 
                line = line{mpt..} 
              end  

              temp = temp // pad(3)  
              if "_-" con temp{1}  
                if mpt = 1 
                  if a4 = 0  
                    tmess = 2 
                    perform dtalk (tmess) 
                  end  
                  if ts(a4,a7+2) = 0  
                    ts(a4,a7+2) = 2 
                  else 
                    ts(a4,a7+2) = 3 
                  end  
                  ts(sct,a7+2) = 1  
                else 
                  ts(sct,a7) = 30                         /* 30 
                end  
              else 
                if "x@#@@@@nf" con temp{1}                /* 21,23,28,29 
                  ts(sct,a7) = mpt + 20 
                  a6 = 2 
                  goto WB1 
                end  
                if "2@45" con temp{1} and temp{2} = "+"   /* 22,24,25 
                  ts(sct,a7) = mpt + 21 
                  a6 = 4 
                  goto WB1 
                end  
                if "/\" con temp{2} and "67" con temp{1}  /* 26,27 
                  ts(sct,a7) = mpt + 25 
                  a6 = 4 
                  goto WB1 
                end  
                a6 = int(temp)                            /* 1..19 
                if a6 < 0 or a6 > 19 
                  tmess = 2 
                  perform dtalk (tmess) 
                end 
                ts(sct,a7) = a6 
                if ts(sct,a7) < 10  
                  a6 = 2 
                else 
                  a6 = 3 
                end  
WB1:            if a6 < 4  
                  temp = temp{a6..}  
                  if "+x@#@@@@nf" con temp{1}  
                    ts(sct,a7+1) = mpt + 19 
                  else 
                    ts(sct,a7+1) = int(temp)  
                  end  
                end  
              end  
              ts(sct,a7) += a13                  /* Adding parentheses flag &dA11/16/03
              a7 += 3 
            repeat 
            ts(sct,PASSNUM) = passnum  
            ts(sct,STAFF_NUM) = nstaves - 1 
            goto EBL 
          end  
&dA 
&dA &d@  Case III:  bar lines  
&dA 
          if tvar1 = BAR_LINE
            ++sct
            ts(sct,TYPE) = tvar1   
            ts(sct,DIV) = divpoint  
            ts(sct,BAR_NUMBER) = tvar2   
            if tcode(a9) = "sure"  
              ts(sct,BAR_TYPE) = REGULAR 
            else 
              if "@1d@e2@@34" con tcode(a9){4} 
                ts(sct,BAR_TYPE) = mpt 
              end  
            end  
            if line con ":|" 
              ts(sct,REPEAT) |= 0x02
            end  
            if line con "|:" 
              ts(sct,REPEAT) |= 0x01
            end  
            if line con "stop-end" 
              ts(sct,BACK_ENDING) = int(line{mpt+8..})  
            end  
            if line con "start-end"  
              ts(sct,FORW_ENDING) = int(line{mpt+9..})  
            end  
            if line con "disc-end" 
              a3 = int(line{mpt+8..})  
              ts(sct,BACK_ENDING) = 0 - a3  
            end  
            if line con "~" 
              loop for a7 = 1 to passnum 
                if ctrflag(a7) > 0 
                  ts(sct,BAR_FLAGS) |= 0x01 
                end 
              repeat 
            end 
            if line con "A"  
              ts(sct,BAR_FLAGS) |= 0x02 
            end  
            if line con "F"  
              ts(sct,BAR_FLAGS) |= 0x04 
            end  
            if line con "E"  
              ts(sct,BAR_FLAGS) |= 0x08 
            end  
            ts(sct,SPACING) = hpar(37) 
            ts(sct,M_NUMBER) = m_number 
            if m_number > 0 
              ++m_number 
            end 

            ts(sct,TEXT_INDEX) = a9 + old@n   
            tsdata(a9+old@n) = tdata(a9,2)    

            ts(sct,PASSNUM) = passnum  
            ts(sct,NUM_STAVES) = tv3(a9) 
            goto EBL 
          end  
&dA 
&dA &d@  Case IV:  signs, words, marks 
&dA 
          if tvar1 = MUSICAL_DIR
            ++sct
            a4 = 0 
            temp = tcode(a9) 
            loop for a3 = 1 to 2 
              if "APQG" con temp{a3} 
                ts(sct,TYPE) = SIGN
                ts(sct,SIGN_TYPE) = mpt 
              end  
              if temp{a3} = "X"                /* (added &dA10/12/96&d@) 
                ts(sct,TYPE) = SIGN
                ts(sct,SIGN_TYPE) = TIE_TERM 
              end  
              if "BCD" con temp{a3}  
                ts(sct,TYPE) = WORDS
                ts(sct,SIGN_TYPE) = mpt + 4 
              end  
              if "R" con temp{a3}              /* (added &dA02/03/08&d@) 
                ts(sct,TYPE) = WORDS
                ts(sct,SIGN_TYPE) = REH_MARK 
              end 
              if "EFHJ" con temp{a3} 
                ts(sct,SUPER_TYPE) = mpt 
                if mpt < 3 
                  a4 = int(line{5..7})   /* get numerical parameter for wedges 
                  ts(sct,WEDGE_SPREAD) = a4 * notesize / 10 
                end 
              end  
              if "UWV" con temp{a3} 
                if mpt = 2 
                  ts(sct,SUPER_TYPE) = NORMAL_TRANS
                else 
                  ts(sct,SUPER_TYPE) = mpt + 4       /* 5 or 7 */ 
                  if int(tdata(a9,1){5,3}) <> 0 
                    ts(sct,SUPER_TYPE) += 4 
                  end 
                end  
              end 
            repeat 
            if ts(sct,TYPE) = 0  
              ts(sct,TYPE) = MARK
            end  
            ts(sct,DIV) = divpoint + cuediv 
            ts(sct,DIV) += mdir_offset 
            if temp{3} = "+" 
              ts(sct,SIGN_POS) = ABOVE
            else 
              ts(sct,SIGN_POS) = BELOW 
            end 
            if a4 = 0 
              a4 = int(line{5..7}) 
              ts(sct,FONT_NUM) = a4    /* get numerical parameter for words, etc.
            end 

            ts(sct,WEDGE_OFFSET) = vpar(1)       
            if ts(sct,SUPER_TYPE) = WEDGES << 1    /* end of wedge 
              if ts(sct,WEDGE_SPREAD) = 0          /* point of wedge 
                ts(sct,WEDGE_OFFSET) = notesize
              end 
            end 

            if ts(sct,SIGN_TYPE) = LETTER_DYNAM 
              if ts(sct,SUPER_TYPE) = 1        /* start wedge
                line = trm(line) 
                line = line // pad(9) 
                temp = line{9..} 
&dA 
&dA &d@    Adjust temp for "Zp", "Z", and "R".  
&dA 
                temp = " " // temp // " " 
                if temp con "Zp" 
                  temp = temp{1..mpt-1} // "sfp" // temp{mpt+2..} 
                end 
                if temp con "Z" 
#if SFZ 
                  temp = temp{1..mpt-1} // "sfz" // temp{mpt+1..} 
#else 
                  temp = temp{1..mpt-1} // "sf" // temp{mpt+1..} 
#endif 
                end 
                if temp con "R" 
#if SFZ 
                  temp = temp{1..mpt-1} // "rfz" // temp{mpt+1..} 
#else 
                  temp = temp{1..mpt-1} // "rf" // temp{mpt+1..} 
#endif 
                end 
                temp = temp{2..} 
                temp = trm(temp) 
                a5 = notesize / 2  

                loop for a4 = 1 to len(temp) 
                  if "pmfszr" con temp{a4} 
                    mpt += 59 
                    a5 += hpar(mpt) 
                  end  
                repeat 
                ts(sct,WEDGE_OFFSET) = a5  
              end  
              if ts(sct,SUPER_TYPE) = 2        /* stop wedge
                ts(sct,WEDGE_OFFSET) = 0 - hpar(46)      
              end  
            end 
            if ts(sct,SIGN_TYPE) = CENTER_STR or ts(sct,SIGN_TYPE) = LEFT_JUST_STR
              if ts(sct,SUPER_TYPE) = 1        /* start wedge                  
                if len(line) > 8 
                  ttext = line{9..} 
                  ttext = trm(ttext) 
                  perform kernttext            
                  c5 = mtfont 
                  perform wordspace 
&dA &d@³    Outputs:    a5 = space taken up by word          
                  if ts(sct,SIGN_TYPE) = CENTER_STR   /* centered word 
                    a5 >>= 1 
                  end 
                  a5 += notesize / 2 
                  ts(sct,WEDGE_OFFSET) = a5 
                end 
              end  
              if ts(sct,SUPER_TYPE) = 2        /* stop wedge
                ts(sct,WEDGE_OFFSET) = 0 - notesize
              end  
            end  
            tsdata(a9+old@n) = line{9..} 
            ts(sct,TEXT_INDEX) = a9 + old@n 
            ts(sct,PASSNUM) = passnum  
            ts(sct,STAFF_NUM) = tv3(a9) 
            ts(sct,S_TRACK_NUM) = tvar2 
            goto EBL 
          end  
&dA 
&dA &d@  Case V, VI, VII and VIII:
&dA &d@     clef change, time designation, meter change, divspq change
&dA 
          if chr(tvar1) in [CLEF_CHG,DESIGNATION,METER_CHG,DIV_CHG]
            ++sct
            ts(sct,TYPE) = tvar1 
            ts(sct,DIV) = divpoint  
            ts(sct,3) = tvar2               /* first parameter
            if tvar1 = CLEF_CHG
              ts(sct,CLEF_FONT) = int(tcode(a9))  
            end  
            tsdata(a9+old@n) = tdata(a9,1) 
            ts(sct,TEXT_INDEX) = a9 + old@n 
            ts(sct,PASSNUM) = passnum  
            ts(sct,STAFF_NUM) = tv3(a9) 
            ts(sct,DOLLAR_SPN) = tv5(a9)    /* added &dA01/17/04&d@ 
&dA &d@       assure proper current value of divspq for this loop  
            if tvar1 = DIV_CHG
              qflag = 1  
              divspq = tvar2 
            end  
            goto EBL 
          end  
&dA 
&dA &d@  Case IX: key change     
&dA 
          if tvar1 = AX_CHG 
            ++sct 
            ts(sct,TYPE) = tvar1 
            ts(sct,DIV) = divpoint  
            ts(sct,3) = tvar2               /* new key        
            ts(sct,4) = key                 /* old key 
            tsdata(a9+old@n) = tdata(a9,1) 
            ts(sct,TEXT_INDEX) = a9 + old@n 
            ts(sct,PASSNUM) = passnum  
            ts(sct,NUM_STAVES) = tv3(a9) 
            ts(sct,DOLLAR_SPN) = tv5(a9)    /* added &dA01/17/04&d@ 

&dA                                                             
&dA 
&dA &d@     New &dA12/14/07&d@:  This code adjusts tclaveax(.) to reflect 
&dA &d@       the current situation 
&dA 
            loop for a6 = 1 to 50 
              tclaveax(a6) = 0 
            repeat 

            a6 = tvar2 
            if a6 > 0 
              a7 = 4 
              loop for a8 = 1 to a6 
                loop for c5 = a7 to 50 step 7 
                  tclaveax(c5) = 2 
                repeat 
                a7 += 4 
                if a7 > 7 
                  a7 -= 7 
                end 
              repeat 
            end 
            if a6 < 0 
              a6 = 0 - a6 
              a7 = 7 
              loop for a8 = 1 to a6 
                loop for c5 = a7 to 50 step 7 
                  tclaveax(c5) = 3 
                repeat 
                a7 -= 4 
                if a7 < 1 
                  a7 += 7 
                end 
              repeat 
            end 

            loop for a6 = 1 to 50 
              loop for a7 = 1 to 4              /* &dA06/04/08&d@ was 3 
                measax(a7,a6) = tclaveax(a6)
              repeat 
            repeat 
&dA 
&dA                  &d@  End of &dA12/14/07&d@ addition &dA              

            goto EBL 
          end 
&dA 
&dA &d@  Case X: irst, backspace 
&dA 
          if tvar1 = IREST
            divpoint += tvar2 
            if divpoint > totdiv 
              totdiv = divpoint 
            end 
            cuediv = 0 
            goto EBL 
          end  
          if tvar1 = BACKSPACE
            ++passnum
            divpoint -= tvar2
            cuediv = 0 
            goto EBL 
          end  
&dA 
&dA &d@  Case XI: print suggestions 
&dA 
          if tvar1 = P_SUGGESTION 
            if tvar2 < 8                    /* forced slur suggestion 
              a3 = tvar2 & 0x06 
              a4 = tvar2 & 0x01 
              a4 <<= 1 
              ++a4                          /* 1 = over; 3 = under 
              a4 <<= a3 + 8 
              ts(sct,SLUR_FLAG) |= a4       /* turn on forced slur flag 
              goto EBL 
            end 
            if tvar2 < 10 
              if tvar2 = 8 
                ts(sct,SLUR_FLAG) |= 0x1000000    /* overhanded tie 
              else 
                ts(sct,SLUR_FLAG) |= 0x3000000    /* underhanded tie 
              end 
              goto EBL 
            end 
            if tvar2 < 32 
              ts(sct,SUPER_FLAG) |= 0x40          /* tuplet has a bracket &dA03-21-97
              if bit(0,tvar2) = 1 
                ts(sct,SUPER_FLAG) |= 0x200       /* bracket is round &dA03-21-97
              end 
              if bit(1,tvar2) = 1 
                ts(sct,SUPER_FLAG) |= 0x80        /* bracket is continuous &dA03-21-97
              end 
              if bit(2,tvar2) = 1 
                ts(sct,SUPER_FLAG) |= 0x100       /* tuplet number is inside &dA03-21-97
              end 
              goto EBL 
            end 
            if tvar2 >= 0x100 and tvar2 < 0x200   /* musical direction 
              a3 = ors(tcode(a9){1}) 
              if a3 > 0 
                ts(sct,FONT_NUM) = a3   
              end 
              a3 = ors(tcode(a9){2}) << 8 + ors(tcode(a9){3}) 
              if tvar2 & 0xff = 0 
                ts(sct,POSI_SHIFT1) = a3 << 8 + ors(tcode(a9){4}) 
              else 
                ts(sct,POSI_SHIFT2) = a3 << 8 + ors(tcode(a9){4}) 
              end 
              goto EBL 
            end 
            if tvar2 & 0xff00 = 0x0200      /* position of ornaments, etc.  
              a3 = tvar2 & 0xff * 4 + 1 
              tsr(sct){a3,4} = tcode(a9){1,4} 
              goto EBL 
            end 
            if tvar2 & 0xff00 = 0x0300      /* printing of actual objects 
              a3 = ors(tcode(a9){1}) 
              if a3 > 6 
                a3 >>= 1
                a3 &= 0x07 
&dA &d@                             3 = print object, no extension dot      
&dA &d@                             4 = print object, include extension dot 
&dA &d@                             5 = double note length, no extension dot 
&dA &d@                             6 = double note length, include extension dot 
&dA &d@                             7 = quadruple note length, no extension dot 
                if a3 > 2 
                  if a3 = 4 or a3 = 6 
                    ts(sct,DOT) = 1 
                  else 
                    ts(sct,DOT) = 0 
                  end 
                  if a3 > 4 
                    ++ts(sct,NTYPE) 
                  end 
                  if a3 > 6 
                    ++ts(sct,NTYPE) 
                  end 
                  ts(sct,SUPER_FLAG) &= 0xfffffffe  /* turn off ties 
                end 
              end 
              tsr(sct){1,4} = tcode(a9){1,4} 
              goto EBL 
            end 
&dA 
&dA &d@       New Code &dA05/25/03&d@ and &dA05/28/05&d@ 
&dA 
            if tvar2 & 0xff00 = 0x0400      /* print suggestion for preceding bar line
              loop for c1 = outpnt to 1 step -1 
                tget [Y,c1] line            
                if line{1,3} = "J B" 
                  sub = 5 
                  c2 = int(line{sub..})           /* bar number 
                  c3 = int(line{sub..})           /* obx        
                  c4 = int(line{sub..})           /* oby 
                  temp = line{sub..} 
                  if tvar2 & 0xffff = 0x0400 
                    c4 += 1000000                 /* 1 million is flag for fixed length
                  else 
                    if tvar2 & 0xffff = 0x0401 
                      c4 += 10000000              /* New &dA05/28/05&d@ 10 million is flag for
                    end                           /* &dEmid-movement&d@ right justification
                  end 
                  line = "J B " // chs(c2) // " " // chs(c3) // " " // chs(c4) // temp
                  tput [Y,c1] ~line 
                  c1 = 1 
                end 
              repeat 
              goto EBL 
            end 
&dA 
&dA &d@       New code &dA11/05/05&d@ for implementing location suggestions for tuples 
&dA 
            if tvar2 & 0xff00 = 0x0500      /* print suggestion for horizontal adjustment
              c2 = tvar2 & 0xff 
              c2 <<= 16 
              ts(sct,TUPLE) |= c2           /* horizontal adjustment 
              goto EBL 
            end 
            if tvar2 & 0xff00 = 0x0600      /* print suggestion for vertical adjustment
              c2 = tvar2 & 0xff 
              c2 <<= 24 
              ts(sct,TUPLE) |= c2           /* vertical adjustment 
              goto EBL 
            end 
&dA 
&dA                 &d@ End of &dA11/05/05&d@ Code 

          end  
EBL:       
        repeat 
        old@n += @n 

&dA   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿   
&dA   ³ End of storing original data in set array  ³   
&dA   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   

&dA 
&dA &d@         ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ» 
&dA &d@         º   N E W    S O R T    A L G O R I T H M   º 
&dA &d@         ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼ 
&dA 
&dA &d@                       &dA09/30/93&d@ 
&dA 
&dA &d@   Reorder set array according to location in measure.  Do not 
&dA &d@     separate extra chord notes from their original lead notes.  
&dA &d@     Do not change the order of bar/clef/grace-note.  Do not 
&dA &d@     extract signs, words, or marks when they precede a bar, 
&dA &d@     clef or grace note; otherwise extract them and put them 
&dA &d@     in front of figures, cues and regular notes.  Do not 
&dA &d@     extract time designations when they precede a bar, 
&dA &d@     clef or grace note; otherwise extract them and put them 
&dA &d@     in front of words, signs, marks, figures, cues and regular 
&dA &d@     notes. 
&dA 
&dA &d@   For objects at same location, the order is as follows: 
&dA 
&dA &d@              1. bar, clef, grace note/chord (in original order for each div) 
&dA &d@              2.  
&dA &d@              3.  
&dA &d@              4. change in divisions per quarter 
&dA &d@              5. time designation, meter change, key change 
&dA &d@              6. word, sign, mark 
&dA &d@              7. figure 
&dA &d@              8. cue note/chord, cue rest 
&dA &d@              9. regular note/chord, regular rest   &dANote: this is why we send irests    
&dA &d@                                                    &dA      through the system as rests   
&dA &d@                                                    &dA      and not as marks              
&dA &d@   Summary of algorithm: 
&dA 
&dA &d@      1. For each division, assign parameters as listed above 
&dA &d@      2. bar, clef, and grace note/chord will be assigned numbers 
&dA &d@           1, 2, and 3 in the order in which they first occur 
&dA &d@           in the array on this division 
&dA &d@      3. For time designations, words, signs and marks, if 
&dA &d@           they preceed a type 1,2,or 3, or if they preceed 
&dA &d@           another or this kind which preceeds a 1,2 or 3, 
&dA &d@           then they take this respective type 
&dA &d@      4. order the elments of mf(.) on each division according 
&dA &d@           to the parameter numbers assigned to them.  mf(.) 
&dA &d@           will now contain the indexes for the proper order 
&dA &d@           of ts(.) from oldsct to sct.  
&dA &d@      5. reorder the elements of ts(.) accordingly 
&dA 

        a7 = 0                  /* global counter in measure 

        a3 = ts(sct,DIV)        /* divisions per measure 
        loop for a2 = 1 to a3 
          temp = "999888007066606545"   /* initial "priority" string (with unknowns = 0)
          a6 = 0 
          a8 = a7                       /* local counter on this division 
          loop for a1 = oldsct + 1 to sct 
            if ts(a1,DIV) = a2 
              a4 = ts(a1,TYPE) 
              a5 = int(temp{a4}) 
              if a5 = 0         /* setting "unknowns" in the order they are encountered
                ++a6 
                if a4 = 7 or a4 = 8 
                  temp{7} = chs(a6) 
                  temp{8} = chs(a6) 
                else 
                  temp{a4} = chs(a6) 
                end 
                a5 = a6 
              end 
              ts(a1,SORTPAR1) = a5 
              ++a8 
              mf(a8) = a1 
            end 
          repeat 

          a5 = 20 
          loop for a3 = a8 to a7 + 1 step -1 
            a1 = mf(a3) 
            a4 = ts(a1,SORTPAR1) 
            if a4 = 6         /* time designation,  word, sign, mark 
              if a5 < 4       /* bar, clef, grace note/chord  or  ...  
                ts(a1,SORTPAR1) = a5 
                a4 = a5 
              else 
                if ts(a1,TYPE) = DESIGNATION 
                  ts(a1,SORTPAR1) = 5 
                end 
              end 
            end 
            a5 = a4 
          repeat 

&dA 
&dA &d@       Sort this section of mf(.) according to SORTPAR1, taking care 
&dA &d@         &dAnot&d@ to separate chord tones from their principal tones.  
&dA 

          if a8 > a7 + 1 

    /* (1) transfer relevant portion to mf2 array 

            loop for a3 = a7+1 to a8 
              mf2(a3) = mf(a3) 
            repeat 

    /* (2) move elements back using order of sort priorites &dAonly&d@ 

            a6 = a7 
            loop for a1 = 1 to 9             /* sort priorities 
              loop for a3 = a7+1 to a8 
                a5 = mf2(a3)                 /* a5 is a ts(.) index 
                if a5 <> 1000 
                  a5 = ts(a5,SORTPAR1)       /* a5 is a sort priority (0 to 9) 
                  if a5 = a1 
                    ++a6 
                    mf(a6) = mf2(a3)         /* move element back to mf 
                    mf2(a3) = 1000           /* and disqualify this element 
                  end 
                end 
              repeat 
            repeat 
          end 
&dA 
&dA &d@       End of mf() section sort 
&dA 
          a7 = a8 
        repeat 

     /* now sort the ts(.,.) array according to the mf(.) order 

        a5 = sct + 1            /* address of "hole" 
        a1 = oldsct + 1 
        loop for a2 = 1 to a8 
          a3 = mf(a2) 
          if a3 <> a1 
      /* move ts(a1) to "hole" and  put  ts(a3) in a1 slot 
            loop for a6 = 1 to TS_SIZE 
              ts(a5,a6) = ts(a1,a6) 
              ts(a1,a6) = ts(a3,a6) 
            repeat 
      /* search mf(.) array for reference to a1 element 
      /*   and tell it that this element is now in a5 
            loop for a7 = a2+1 to a8 
              if mf(a7) = a1 
                mf(a7) = a5 
                a7 = a8 
              end 
            repeat 
&dA &d@           mf(a2) = a1 
      /* set a5 to the new "hole", which is a3 
            a5 = a3 
          end 
      /* advance the destination, a1 
          ++a1 
        repeat 
&dA 
&dA &d@    Code added &dA01/07/06&d@ reporting on a possible failure condition 
&dA &d@           brought on by a faulty stage2 file.  
&dA 
        a5 = sct - oldsct 

        if a5 <> a8 
          if a5 <= sct 
            if (Debugg & 0x06) > 0 
              pute WARNING!  There may be a format error in your source file
              pute (possibly having to do with (cue note) durations).  
            end 
            sct = a8 - oldsct 
          end 
        end 
&dA       

&dA 
&dA &d@    Clear work space 
&dA 
        loop for a1 = oldsct + 1 to sct 
          ts(a1,SORTPAR1) = 0 
        repeat 
        loop for a1 = 1 to TS_SIZE 
          ts(sct+1,a1) = 0 
        repeat 
&dA 
&dA &d@   Reorder multiple grace notes 
&dA 
        loop for a3 = 1 to MAX_PASS 
          passpar(a3) = 200           /* reverse order scheme, starting at 200 
        repeat 
        a6 = 200 
        a5 = 0 
        loop for a1 = sct to oldsct step -1 
          if a1 > oldsct and chr(ts(a1,TYPE)) in [GR_NOTE,XGR_NOTE] 
            if a5 = 0 
              a5 = a1 
            end 
            a2 = ts(a1,PASSNUM) 
            ts(a1,SORTPAR1) = passpar(a2) 
            if a6 > passpar(a2) 
              a6 = passpar(a2) 
            end 
            if ts(a1,TYPE) = GR_NOTE 
              --passpar(a2) 
            end 
          else 
            if a5 > 0           /* some grace notes were found 
              a5 -= a1          /* a5 = number of elements 
              a4 = 0 
              loop for a7 = a6 to 200 
                a3 = 0 
                loop for a8 = 1 to a5 
                  if ts(a1+a8,SORTPAR1) = a7 
                    ++a4 
                    mf(a4) = a1 + a8 
                /* here is where we must add space parameter for GRACE notes 
                    if a3 = 0 
                      if ts(a1+a8,BEAM_FLAG) = NO_BEAM 
                        ts(a1+a8,SPACING) = hpar(97)   /*  Removed  * 4 / 3 &dA05-15-95
                      else 
                        ts(a1+a8,SPACING) = hpar(97) 
                      end 
                      a3 = 1 
                    else 
                      ts(a1+a8,SPACING) = 0 
                    end 
                  end 
                repeat 
              repeat 
           /* mf(.) now contains the locations of array elements (in reordered form)

              loop for a8 = 1 to a5 
                a4 = mf(a8) 
                if a1+a8 <> a4        /* what's there now  is not  what goes there
                  loop for a7 = 1 to TS_SIZE 
                    ts(sct+1,a7) = ts(a1+a8,a7)     /* make hole for new element
                    ts(a1+a8,a7) = ts(a4,a7)        /* move in new element 
                    ts(a4,a7)    = ts(sct+1,a7)     /* put old element in vacancy
                  repeat 
                  loop for a7 = 1 to a5 
                    if mf(a7) = a1 + a8             /* this element has been moved
                      mf(a7) = a4                   /*   now give new location 
                      a7 = a5 
                    end 
                  repeat 
                  mf(a8) = a1 + a8 
                end 
              repeat 

           /* re-initialize sorting parameters 
              loop for a3 = 1 to MAX_PASS 
                passpar(a3) = 200 
              repeat 
              a5 = 0 
              a6 = 200 
            end 
          end 
        repeat 
        loop for a1 = oldsct+1 to sct 
          ts(a1,SORTPAR1) = 0 
        repeat 

&dA  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿   
&dA  ³ End of reorder process. ³   
&dA  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   

&dA 
&dA &d@       Check for isolated SIGNS, WORDS, or MARKS 
&dA 
        a2 = oldsct + 1 
        a5 = ts(a2,DIV) 
        loop for a1 = oldsct+1 to sct 
          if ts(a1,DIV) <> a5 
            loop for a3 = a2 to a1 - 1 
              nodtype = ts(a3,TYPE) 
              if chr(nodtype) not_in [SIGN,WORDS,MARK] 
                a3 = 1000000 
              end 
            repeat 
            if a3 <> 1000000 
              loop for a3 = a2 to a1 - 1 
                ts(a3,ISOLATED) = 1 
              repeat 
            end 
            a2 = a1 
            a5 = ts(a2,DIV) 
          end 
        repeat 
&dA 
&dA &d@  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@  ³ Before decoding the notes, we must determine if this part      ³ 
&dA &d@  ³ represents more than one independent instrument.  If so then   ³ 
&dA &d@  ³ the rules regarding accidentals are slightly different.  Each  ³ 
&dA &d@  ³ instrumental part must have its own, independent measax array. ³ 
&dA &d@  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
&dA 

&dA 
&dA &d@    For the case where more than one independent instrument is being 
&dA &d@    represented on this measure, (vflag > 1) we need to catagorize 
&dA &d@    the measure into one of three types: 
&dA 
&dA &d@    (1) one pass, no chords.  
&dA 
&dA &d@       This situation arrises when we have an a2 (zu 2) situation, 
&dA &d@       i.e., all instruments are active, but are playing the same 
&dA &d@       music, or a 1. (2. or 3.) situation, i.e., only one 
&dA &d@       instrument is specifically active -- all other instruments 
&dA &d@       have been told not to play.  In this case, the music is 
&dA &d@       easy to typeset.  
&dA 
&dA &d@    (2) one pass, chords.            
&dA 
&dA &d@       This is the situation more than 90% of the time.  Two or 
&dA &d@       more parts (99.99% of the time, it is two parts) are 
&dA &d@       represented in the measure, and the following conditions 
&dA &d@       hold true: 
&dA 
&dA &d@          a) all parts have the same rhythm (including resting 
&dA &d@               at the same time) 
&dA &d@          b) part 1 is at unison or is higher than part 2, etc.  
&dA 
&dA &d@          c) all parts have identical slurs and articulations.  
&dA &d@               This includes slurs entering and leaving the    
&dA &d@               measure.  
&dA 
&dA &d@          d) if there is a unison and it is an eighth note or less, 
&dA &d@               then it is not attached to a beam.  
&dA 
&dA &d@       The parts will be printed as chords.  Slurs and articulations 
&dA &d@       will be attached to the note head at the end of stem.  Unison 
&dA &d@       notes (represented as chords with two or more identical notes) 
&dA &d@       will be printed in one of two ways: 
&dA 
&dA &d@          a) whole notes and larger will be printed side-by-side.  
&dA 
&dA &d@          b) half notes and smaller will be printed with two stems 
&dA &d@               (up and down) regardless of the listed stem direction.  
&dA &d@               (three unisons cannot be handled by this program) 
&dA 
&dA &d@       &dAWith this type, each part (defined by its position in the chord)&d@ 
&dA &d@       &dAwill have its own measax array.  This is because accidentals    
&dA &d@       &dAmust be repeated, if they appear in different parts.            
&dA 
&dA &d@    (3) more than one pass.  
&dA 
&dA &d@       With this type, notes occuring on the same division and having 
&dA &d@       the same duration and same stem direction will be combined into 
&dA &d@       one chord. &dA As with type (2) above, each part (defined in this   
&dA &d@       &dAcase by pass number) will have its own measax array.  Accidentals&d@ 
&dA &d@       &dAmust be repeated, if they appear in different parts.&d@  Unison 
&dA &d@       whole notes and larger will be printed side-by-side.  
&dA 
        if vflag > 1 
          if passnum = 1 
&dA &d@                     
&dA &d@         Must determine if there are chords in this measure 
&dA 
            mcat = 1 
            loop for a1 = 1 to sct 
              if ts(a1,TYPE) = XNOTE 
                mcat = 2 
                a1 = sct 
              end 
            repeat 
          else 
            mcat = 3 
          end 
        else 
          mcat = 0 
        end 
&dA 
&dA &d@   (added &dA10-12-96&d@) 
&dA 
&dA &d@   Determine links between tie terminators and earlier pitches 
&dA 
&dA &d@       Basically, we look backward through the data to find the pitch 
&dA &d@       referred to by the tie terminator.  If the pitch cannot be found, 
&dA &d@       this is an error condition.  We must search on the correct staff 
&dA &d@       number.  Once we have found the pitch, we need to store its  
&dA &d@       index number.  Later we will determine the STAFFLOC parameter.  
&dA &d@       This will be used later to generate the mark object and the tie 
&dA &d@       super object.  
&dA 
        loop for a1 = oldsct+1 to sct 
          if ts(a1,TYPE) = SIGN and ts(a1,SIGN_TYPE) = TIE_TERM 
            tsdata(ts(a1,TEXT_INDEX)) = tsdata(ts(a1,TEXT_INDEX)) // pad(4) 
            note = tsdata(ts(a1,TEXT_INDEX)){1,4} 
            loop for t7 = a1 to oldsct+1 step -1 
              if ts(t7,TYPE) <= NOTE_OR_REST 
                if ts(t7,STAFF_NUM) = ts(a1,STAFF_NUM) 
                  t8 = ts(t7,4) 
                  if note = tcode(t8) 
                    ts(a1,BACKTIE) = t7        /* store ts index of pitch generating tie
                    goto TIE_TERM_FOUND 
                  end 
                end 
              end 
            repeat 
            tmess = 10 
            perform dtalk (tmess) 
          end 
TIE_TERM_FOUND: 
        repeat 
&dA 
&dA &d@   End of &dA10-12-96&d@ addition 
&dA 

&dA 
&dA &d@   Decode pitches, store &dAunmodified&d@ accidentals in ts(.,AX) 
&dA 
        loop for a1 = oldsct+1 to sct 
          nodtype = ts(a1,TYPE) 
          if nodtype <= NOTE_OR_REST 
            a2 = ts(a1,4) 
            note = tcode(a2) 
&dA 
&dA &d@       Putting the decodenote procedure "in line" here, since it 
&dA &d@       is called only once.  
&dA 
            if note = "rest" 
              a7 = 100 
              a8 = 0 
              mf(1) = 0 
              goto DECODE_DONE 
            end 
            if note = "ires" 
              a7 = 200 
              a8 = 0 
              goto DECODE_DONE 
            end 
            if "CDEFGAB" con note{1} 
              t1 = mpt 
            end 
            a8 = 0 
            loop for t2 = 2 to 4 
              if "0123456789" con note{t2} 
                a7 = mpt - 2 * 7 + t1 
                goto DECODE_DONE 
              end 
              a8 <<= 2 
              if " #f" con note{t2} 
                a8 = a8 | mpt 
              end 
            repeat 
            if (Debugg & 0x01) > 0 
              pute note = ~note    ...  
            end 
            tmess = 9 
            perform dtalk (tmess) 
DECODE_DONE: 
            if a7 = 100 
              a7 += ts(a1,CLAVE)       /* see "floating rest flag"
            end 
            ts(a1,CLAVE) = a7          /* &dAHere is where CLAVE is definitively set
            ts(a1,AX) = a8 
            a4 = ts(a1,STAFF_NUM) + 1 
            if a7 < 100  
              ts(a1,STAFFLOC) = 52 - a7 - cline(a4) + c8flag(a4) + 20 * notesize / 2 - vpar20
            end  
&dA 
&dA &d@      We need to capture the note shape data now, because it will figure in on
&dA &d@      whether a passage is iso-rhythmic; i.e., you can't have iso-rhythm with 
&dA &d@      different note shapes.    Code added &dA02/19/06&d@ 
&dA 
            a14 = ts(a1,TSR_POINT) 
            a4 = ors(tsr(a14){1}) 
            if a4 > 16 
              a4 >>= 4           /* upper four bits 
              a4 <<= 20          /*   shifted to space 20-23 
              ts(a1,SUBFLAG_1) |= a4 
            end 
&dA     
          end  
          if chr(nodtype) in [SIGN,WORDS,MARK]
            a4 = ts(a1,STAFF_NUM) + 1    /* staff number 
            a2 = ts(a1,SUPER_TYPE) + 1 / 2
            if chr(a2) in [OCT_UP,OCT_DOWN,DBL_OCT_UP,DBL_OCT_DOWN]
&dA 
&dA &d@         adjust c8flag(.) 
&dA 
              if a2 = OCT_UP 
                c8flag(a4) = -7 
              end 
              if a2 = OCT_DOWN 
                c8flag(a4) = 7 
              end 
              if a2 = DBL_OCT_UP 
                c8flag(a4) = -14 
              end 
              if a2 = DBL_OCT_DOWN 
                c8flag(a4) = 14 
              end 
              transflag(a4) = 2 * a2
            end
            if ts(a1,SUPER_TYPE) = NORMAL_TRANS 
              c8flag(a4) = 0             /* return to normal 
              if transflag(a4) < 2 * OCT_UP 
                if (Debugg & 0x06) > 0 
                  pute Possible Coding error with transpositions 
                end 
              end 
              ts(a1,SUPER_TYPE) = transflag(a4) 
              transflag(a4) = 0
            end 
          end  
          if nodtype = CLEF_CHG
            a4 = ts(a1,STAFF_NUM) + 1    /* staff number 
            clef(a4) = ts(a1,CLEF_NUM) 
            perform zjcline (a4) 
*     this resets clef and cline 
            ts(a1,CLEF_STAFF_POS) = 5 - clef_vpos * notesize     /* &dA  Possibly     
            a3 = hpar(8) * 5 / 6                                 /* &dA  unnecessary  
            if ts(a1,CLEF_FONT) >= 128   /* music font           /* &dA  at this      
              a3 = a3 * 8 / 10                                   /* &dA  point        
            end                                                  /* &dA               
            ts(a1,SPACING) = a3                                  /* &dA               

          end  
        repeat 

&dA 
&dA &d@   If mcat = 3, reorganize notes on the same division.  If two notes 
&dA &d@   with different pass numbers have the same duration and stem directions 
&dA &d@   in the same direction, and these notes do not have beam connections, 
&dA &d@   then these notes can be combined into one chord.  This will save 
&dA &d@   considerable trouble later during the computing of x-offsets (both 
&dA &d@   local and global) and the setting of stems.  
&dA 
&dA &d@   &dA09/22/93&d@  Actually I would like to expand this section.  
&dA 
&dA &d@    (1) I would like to try to combine isorhythmic passages that do connect 
&dA &d@        to beams 
&dA 
&dA &d@    (2) If the entire measure is isorhythmic, then I would like to set 
&dA &d@        mcat to 2 and reduce the number of passes 
&dA 
&dA &d@    (3) Also, if the measure is isorhythmic, I would like to print out 
&dA &d@        rests only one time 
&dA 
&dA &d@    (4) Also, if mcat > 1, accidentals on the same line should NOT be 
&dA &d@        reprinted.  This should be easy to fix, simply by looping though 
&dA &d@        all simultanities on a staff and removing accidentals that 
&dA &d@        occur twice on the same pitch.  
&dA 
&dA &d@   available variables: a1 --> a16 
&dA 
        if mcat = 3               /* %%% add code here for changing ax behavior
&dA 
&dA &d@     First thing: fix accidentals according to pass number 
&dA 
          loop for a1 = oldsct+1 to sct 
            nodtype = ts(a1,TYPE) 
            if nodtype <= NOTE_OR_REST 
              a4 = ts(a1,PASSNUM) 
              if a4 > 3 
                tmess = 25 
                perform dtalk (tmess) 
              end 
              perform decodeax (a1,a4) 
            end 
            if nodtype = BAR_LINE 
              loop for a3 = 1 to 50 
                loop for a4 = 1 to 4                    /* &dA06/04/08&d@ was 3 
                  measax(a4,a3) = tclaveax(a3)          /* New &dA12/14/07&d@ 
                repeat 
              repeat 
            end 
            if nodtype = CLEF_CHG 
              a4 = ts(a1,STAFF_NUM) + 1    /* staff number 
              clef(a4) = ts(a1,CLEF_NUM) 
              perform zjcline (a4) 
*     this resets clef and cline 
              ts(a1,CLEF_FONT) += z        /* music font 
              ts(a1,CLEF_STAFF_POS) = 5 - clef_vpos * notesize 
              a3 = hpar(8) * 5 / 6                           /* Added &dA06-24-94&d@ 
              if ts(a1,CLEF_FONT) > 128     /* music font 
                a3 = a3 * 8 / 10 
              end 
              ts(a1,SPACING) = a3 
              if nstaves > 1     /* Case: assume one part to stave (usual case)
                loop for a3 = 1 to 50 
                  measax(a4,a3) = tclaveax(a3)          /* New &dA12/14/07&d@ 
                repeat 
              else 
                loop for a4 = 1 to 4                    /* &dA06/04/08&d@ was 3 
                  loop for a3 = 1 to 50 
                    measax(a4,a3) = tclaveax(a3)        /* New &dA12/14/07&d@ 
                  repeat 
                repeat 
              end 
            end 
          repeat 
&dA 
&dA &d@     Now you can combine notes into chords  (and alter pass numbers) 
&dA 
&dA &d@     If there are notes of different note shapes in a measure, this is a 
&dA &d@     non-starter for combining any notes into chords.  All notes must have 
&dA &d@     the same note shape (bits 20-23 of SUBFLAG_1).  This information was 
&dA &d@     encoded at the same time as pitch.  (added &dA02/19/06&d@) 
&dA 
          a2 = 0 
          loop for a1 = oldsct+1 to sct 
            nodtype = ts(a1,TYPE) 
            if nodtype <= NOTE_OR_REST 
              if a2 = 0  
                a2 = a1 
              end 
              if (ts(a2,SUBFLAG_1) & 0xf00000) <> (ts(a1,SUBFLAG_1) & 0xf00000) 
                goto ISO_DONE
              end 
            end 
          repeat 
&dA         

&dA 
&dA &d@     First check to see if the entire measure is isorhythmic.  This will 
&dA &d@     save time in the end, and is also necessary in determining whether or 
&dA &d@     not to eliminate duplicate rests.  There are some caviats here: 
&dA 
&dA &d@      (1) Notes with lower pass numbers must always be unison or higher   
&dA &d@            on the staff 
&dA &d@      (2) All stem directions must be the same (for a particular division)
&dA &d@            &dAREMOVED
&dA 
&dA &d@      (3) All beam flags for notes from each pass must be identical.        
&dA 
&dA &d@      (4) Every division must have a representative from each pass.  These 
&dA &d@            must be either all notes or all rests.  
&dA 
          /* %%% add code here for disabling isorhythmic compression 

          loop for a1 = oldsct+1 to sct 
            nodtype = ts(a1,TYPE) 
            if nodtype <= NOTE_OR_REST 
              loop for a2 = a1 + 1 to sct 
                if ts(a2,DIV) <> ts(a1,DIV) or ts(a2,SPACING) <> 0 
                  goto JOL1 
                end 
                if nodtype = REST or nodtype = CUE_REST 
                  if ts(a2,TYPE) <> nodtype 
                    goto JOL1 
                  end 
                else 
                  if ts(a2,TYPE) <> nodtype and ts(a2,TYPE) <> nodtype + 1 
                    goto JOL1 
                  end 
                end 
              repeat        
JOL1: 
              --a2 
              if a2 - a1 + 1 < passnum 
                goto ISO_FAIL 
              end 
              a4 = 0 
              a5 = 0 
              a6 = ts(a1,PASSNUM) 
              a7 = 1000 
              loop for a3 = a1 to a2 
                if ts(a3,CLAVE) < 100 
                  if ts(a3,STAFF_NUM) <> ts(a1,STAFF_NUM) 
                    goto ISO_FAIL 
                  end 
&dA &d@                 if bit(1,ts(a3,STEM_FLAGS)) <> bit(1,ts(a1,STEM_FLAGS)) 
&dA &d@                   goto ISO_FAIL 
&dA &d@                 end 
                  if ts(a3,BEAM_FLAG) <> ts(a1,BEAM_FLAG) 
                    goto ISO_FAIL 
                  end 
                  if bit(0,ts(a3,SUPER_FLAG)) <> bit(0,ts(a1,SUPER_FLAG))    /* ties
                    goto ISO_FAIL 
                  end 
                  if bit(2,ts(a3,STEM_FLAGS)) = 0         /* number of "events"
                    ++a4 
                  end 
                  if ts(a3,PASSNUM) = a6                 /* order of pitches */
                    if ts(a3,CLAVE) < a7 
                      a7 = ts(a3,CLAVE) 
                    end 
                  else 
                    if ts(a3,CLAVE) > a7 
                      goto ISO_FAIL 
                    end 
                    a6 = ts(a3,PASSNUM) 
                    a7 = ts(a3,CLAVE) 
                  end 
                else 
                  ++a5 
                end 
              repeat 
              if a4 = 0 
                if a5 <> passnum 
                  goto ISO_FAIL 
                end 
              else 
                if a4 <> passnum or a5 > 0 
                  goto ISO_FAIL 
                end 
              end 
              a1 = a2 
            end 
          repeat 

&dA 
&dA &d@     The measure meets the conditions of isorhythmic compression.  Here is 
&dA &d@     what we must do: 
&dA 
&dA &d@       (1) Rests:  Delete duplicate rests.  Do this all at one time, 
&dA &d@             since this involves resizing the ts array.  
&dA 
&dA &d@           &dANote on this&d@: I don't think autoscr actually wants to delete 
&dA &d@             rests, but rather to make them "silent."  To do otherwise 
&dA &d@             might remove time from a track.  
&dA 
&dA &d@       (2) Notes--situation 1: Note not connected to a beam 
&dA 
&dA &d@          New condition &dA12/20/05&d@: If stem_change_flag < 3, then do the 
&dA &d@            steps below only if the stem directions are the same.  
&dA 
&dA &d@          &dA &d@ If no unison and no chords in separate parts, then combine all 
&dA &d@          &dA &d@      pitches into one chord 
&dA &d@          &dA &d@   If separate stem directions do not agree, determine 
&dA &d@          &dA &d@     best direction; otherwise use common direction 
&dA &d@          &dA 
&dA &d@          &dA &d@          TYPE: for each note group, make first type 1,4,7 and 
&dA &d@          &dA &d@                  all others 2,5,8 
&dA &d@          &dA &d@    STEM_FLAGS: set all bit2's; set all bit3's for all but first 
&dA &d@          &dA &d@                  member of group 
&dA &d@          &dA &d@     BEAM_FLAG: zero for all but first member of chord group 
&dA &d@          &dA &d@     BEAM_CODE: zero for all but first member of chord group 
&dA &d@          &dA &d@     PASSNUM: equal to PASSNUM for first member of group 
&dA &d@          &dA 
&dA &d@          &dA &d@ Otherwise, set the stem direction for the upper pass 
&dA &d@          &dA &d@   to up and for the lower pass to down.  
&dA 
&dA &d@       (3) Notes--situation 2: Note is connected to a beam 
&dA 
&dA &d@            For all notes on that beam determine if there are any unisons 
&dA &d@               or any chords in separate chords.  
&dA 
&dA &d@              If no unisons and no chords, then combine all pitches into one chord
&dA &d@                If separate stem directions do not agree, determine 
&dA &d@                  best direction; otherwise use common direction 
&dA 
&dA &d@                       TYPE: for each note group, make first type 1,4,7 and 
&dA &d@                               all others 2,5,8 
&dA &d@                 STEM_FLAGS: set all bit2's; set all bit3's for all but first 
&dA &d@                               member of group 
&dA &d@                  BEAM_FLAG: zero for all but first member of chord group 
&dA &d@                  BEAM_CODE: zero for all but first member of chord group 
&dA &d@                  PASSNUM: equal to PASSNUM for first member of group 
&dA 
&dA &d@              If unisons, then set the stem direction for the upper pass 
&dA &d@                to up and for the lower pass to down.  
&dA 
&dA &d@       (4) If all notes in measure were combined into chords, then 
&dA &d@              decrease passnum by amount of largest PASSNUM + 1 / 2 
&dA 

&dA 
&dA &d@   (1) Rests:  Delete duplicate rests 
&dA 

          a1 = oldsct+1 
COMPRESS1: 
          nodtype = ts(a1,TYPE) 
          if (nodtype = REST or nodtype = CUE_REST) and rest_collapse = TRUE
            loop for a2 = a1 + 1 to sct 
              if ts(a2,DIV) <> ts(a1,DIV) or ts(a2,TYPE) <> nodtype 
                goto JOL2 
              end 
            repeat         
JOL2: 
            if a2 > a1 + 1                           /* do this only if another rest is found
              a5 = a1 + 1 
              loop for a3 = a2 to sct 
                loop for a4 = 1 to TS_SIZE 
                  ts(a5,a4) = ts(a3,a4) 
                repeat 
                ++a5 
              repeat 
              loop for a4 = 1 to TS_SIZE            /* &dA1/30/96&d@  clear last ts(.,.) line
                ts(sct,a4) = 0 
              repeat 
              sct -= a2 - a1 - 1 
            end 
          end 
          ++a1 
          if a1 <= sct 
            goto COMPRESS1 
          end 
&dA 
&dA &d@   (2) (3) Notes-- situations 1 and 2      
&dA 
          a16 = 0  /* New &dA12/20/05&d@ and be careful not to modify this in other parts of AUTOSET
          a15 = 0  /* New &dA12/20/05&d@ 
          a10 = 0 
          a5 = 0 
          a6 = 0 
          a7 = 0              
          a8 = 0 

          loop for a1 = oldsct+1 to sct 
            nodtype = ts(a1,TYPE) 
            if nodtype = NOTE or nodtype = CUE_NOTE or nodtype = GR_NOTE 
              loop for a2 = a1 + 1 to sct 
                if ts(a2,DIV) <> ts(a1,DIV) or ts(a2,SPACING) <> 0 
                  goto JOL3 
                end 
              repeat while ts(a2,TYPE) = nodtype or ts(a2,TYPE) = nodtype + 1 
JOL3: 
              --a2 
&dA 
&dA &d@     Remove duplicate fermatas for notes on same division (because it is easy 
&dA &d@         to do at this point) 
&dA 
&dA &d@     New code &dA12/18/10&d@.  Treats up and down fermatas separately, and in new location
&dA 
              a4 = ts(a1,SUBFLAG_1) & 0x04000000      /* 0100 0000 0000 0000 0000 0000 0000
              a7 = ts(a1,ED_SUBFLAG_1) & 0x04000000   /* 0100 0000 0000 0000 0000 0000 0000
              loop for a3 = a1 + 1 to a2                      
                if ts(a3,SUBFLAG_1) & 0x04000000 = a4 
                  ts(a3,SUBFLAG_1) &= 0xfbffffff 
                end 
                if ts(a3,ED_SUBFLAG_1) & 0x04000000 = a7
                  ts(a3,ED_SUBFLAG_1) &= 0xfbffffff 
                end 
              repeat 

              a4 = ts(a1,SUBFLAG_1) & 0x08000000      /* 1000 0000 0000 0000 0000 0000 0000
              a7 = ts(a1,ED_SUBFLAG_1) & 0x08000000   /* 1000 0000 0000 0000 0000 0000 0000
              loop for a3 = a1 + 1 to a2 
                if ts(a3,SUBFLAG_1) & 0x08000000 = a4 
                  ts(a3,SUBFLAG_1) &= 0xf7ffffff 
                end 
                if ts(a3,ED_SUBFLAG_1) & 0x08000000 = a7
                  ts(a3,ED_SUBFLAG_1) &= 0xf7ffffff 
                end 
              repeat 
&dA 
&dA      &d@ End of new code &dA12/18/10&d@ 

              if a2 - a1 + 1 > passnum 
                a7 = 1                      /* chords are present on this division
              end 
&dA 
&dA &d@     Determine if there is a unison in this group 
&dA 
              if a7 = 0 and stem_change_flag = 3      /* New condition &dA12/20/05
                loop for a3 = a1 + 1 to a2 
                  if ts(a3,CLAVE) = ts(a3-1,CLAVE) 
                    a7 = 1 
                  end 
                repeat 
              end 

              if a16 = 0 
                loop for a3 = a1 + 1 to a2 
                  if bit(1,ts(a3,STEM_FLAGS)) <> bit(1,ts(a1,STEM_FLAGS)) 
                    a8 = 1                  /* conflicting stem directions 
                  end 
                repeat 
              end 
              if ts(a1,BEAM_FLAG) <> 0      /* this note is on a beam 
                a15 = 1                     /* New &dA12/20/05&d@ "beam flag" 
                if ts(a1,BEAM_FLAG) = START_BEAM 
                  a16 = a1                  /* index starts (first/top) beam
                end 
                if ts(a1,BEAM_FLAG) = END_BEAM 
                  a16 += INT10000           /* beams end; now use saved value of a1 from above
                end 
              else 
                a16 = a1 + INT10000         /* "no beam" case 
              end 
              if a16 > INT10000             /* process notes here 
                a16 -= INT10000             /* recover value of starting "a1"
&dA 
&dA &d@           New condition &dA12/20/05&d@: If stem_change_flag < 3, then (for 
&dA &d@             non-beam case) do steps below only if the stem directions 
&dA &d@             are the same.  (i.e., when a15 = 0, a8 must be zero, 
&dA &d@             if stem_change_flag < 3) 
&dA 
                if a15 = 0      /* no beam 
                  if stem_change_flag < 3 and a8 = 1 
                    a10 = 1                            /* New condition &dA12/20/05
                    goto NO_STEM_CHANGE 
                  end 
                end 
&dA        
&dA &d@           At this point: either a15 = 1 (this is a beamed group or set of beamed groups)
&dA &d@                 or stem_change_flag = 3 (old code situation) 
&dA &d@                               or a8 = 0 (all stems point the same way) 
&dA 
&dA &d@      Case 1: either a unison between passes or a chord on one of the passes 
&dA &d@              (note: in order for a unison to trigger this case, stem_change_flag must = 3
&dA &d@                     otherwise, unisons will fall into case 2 
&dA 
                if a7 = 1 
&dA 
&dA &d@        New &dA12/20/05&d@ change stem directions only of stem_change_flag = 3 
&dA 
                  if stem_change_flag = 3 
                    loop for a3 = a16 to a2                /* all notes inclusive
                      a7 = ts(a3,TYPE) 
                      if a7 <= NOTE_OR_REST and a7 <> REST and a7 <> CUE_REST
                        if ts(a3,PASSNUM) = ts(a16,PASSNUM) 
                          ts(a3,STEM_FLAGS) &= 0xfffd      /* stem up for upper pass
                        else 
                          ts(a3,STEM_FLAGS) |= 0x0002      /* stem down for lower pass
                        end 
                      end 
                    repeat 
                  end 
                  a10 = 1 
                else 
&dA 
&dA &d@      Old Case 2: no unisons, no chords -- combine passes in one chord                
&dA &d@                    (and stem_change_flag = 3) 
&dA 
&dA &d@      &dA12/20/05&d@ Case 2: no chords -- combine passes in one chord 
&dA &d@                       (note: unisons may fall into this case if stem_change_flag < 3)
&dA 
&dA 
                  if a8 = 1 and stem_change_flag < 3     /* New condition &dA12/20/05
                    a10 = 1 
                    goto NO_STEM_CHANGE 
                  end 

                  if a8 = 1            /* determine stem direction 
                    a8 = 0 
                    loop for a3 = a16 to a2 
                      a7 = ts(a3,TYPE) 
                      if a7 <= NOTE_OR_REST and a7 <> REST and a7 <> CUE_REST 
                        a8 += ts(a3,STAFFLOC) 
                      end 
                    repeat 
                    a8 <<= 1 
                    a8 /= notesize 
                    a9 = a2 - a16 + 1 
                    a8 += a9 + 1 / 2 
                    a8 /= a9             
                    if a8 >= 5 
                      a9 = UP 
                    else 
                      a9 = DOWN 
                    end 
                  else 
                    a9 = bit(1,ts(a16,STEM_FLAGS)) 
                  end 

                  a11 = 0 
                  a12 = 0 
                  loop for a3 = a16 to a2       /* put all notes into chords
                    a7 = ts(a3,TYPE) 
                    if a7 <= NOTE_OR_REST and a7 <> REST and a7 <> CUE_REST 
                      ts(a3,STEM_FLAGS) &= 0xfffd     /* prepare for new stem direction
                      ts(a3,STEM_FLAGS) |= a9 << 1 
&dA   
&dA &d@     Also move all dynamics for notes on same division to first note (This is correct place
&dA &d@       to do this operation &dA12/20/05&d@)   &dEThis code uses a4, a6 and a14 in a temporary manner
&dA   
                      if ts(a3,DIV) <> a11 or ts(a3,SPACING) <> 0 or a12 <> a7 or a3 = a16
                        a12 = a7 
                        a11 = ts(a3,DIV) 
                        ts(a3,STEM_FLAGS) |= 0x04 
                        a8 = a3 
&dA   
&dA &d@     Collect dynamics data for this note (a3) &dA12/20/05&d@ 
&dA   

                        a4 = ts(a3,SUBFLAG_1)    & 0x007c00 
                        a6 = ts(a3,ED_SUBFLAG_1) & 0x007c00 
                      else 
                        ts(a3,TYPE) = ts(a8,TYPE) + 1 
                        ts(a3,STEM_FLAGS) |= 0x0c 
                        ts(a3,BEAM_FLAG) = 0 
                        ts(a3,BEAM_CODE) = 0 
                        if ts(a3,PASSNUM) > a5 
                          a5 = ts(a3,PASSNUM)         /* save max passnum 
                        end 
                        ts(a3,PASSNUM) = ts(a8,PASSNUM) 
&dA    
&dA &d@     Merge dynamics data with data for first (a8) note 
&dA 
                        a4 |= ts(a3,SUBFLAG_1)    & 0x007c00 
                        a6 |= ts(a3,ED_SUBFLAG_1) & 0x007c00 
&dA 
&dA &d@     Turn off dynamics data for this note (a3) 
&dA 
                        ts(a3,SUBFLAG_1) &= 0xffff83ff 
                        ts(a3,ED_SUBFLAG_1) &= 0xffff83ff 
&dA 
&dA &d@     Add in (new) dynamics data to first (a8) note 
&dA 
                        ts(a8,SUBFLAG_1) |= a4 
                        ts(a8,ED_SUBFLAG_1) |= a6 
&dA 
&dA &d@          The following code is untested, and may cause problems.  
&dA &d@          Note: &dA10/28/07&d@ it has!   I will make some changes that fix a definite
&dA &d@            bug, but there may still be other problems.  
&dA 
                        c4 = ts(a3,TSR_POINT) 
                        c5 = ts(a8,TSR_POINT) 
             /* byte 1 
                        c6 = ors(tsr(c4){1}) & 0xff 
                        c7 = ors(tsr(c5){1}) & 0xff 
                        c7 |= c6 
                        tsr(c5){1} = chr(c7) 
             /* byte 2 
                        c6 = ors(tsr(c4){2}) & 0xff 
                        c7 = ors(tsr(c5){2}) & 0xff 
                        c7 |= c6 
                        tsr(c5){2} = chr(c7) 
             /* byte 3 = x offset (modification by suggestion) 
                        c6 = ors(tsr(c4){3}) & 0xff 
                        c7 = ors(tsr(c5){3}) & 0xff 
                        if c6 <> c7 
                          if (Debugg & 0x06) > 0 
                            pute WARNING:  At approximate measure number ~(measnum - 1)
                            pute 
                            pute       You have asked autoset to combine into a chord two pitches
                            pute   which have different x offsets.  This will be done, but the
                            pute   results are unpredictable.  Note combination usually arrises
                            pute   when two instruments occupy the same staff (multi track) and
                            pute   have simultaneous notes with the same stem direction.  If you
                            pute   really want different x offsets, you should make the stem
                            pute   directions on these notes different.  
                            pute 
                          end 
                        end 
                        tsr(c5){3} = chr(c7) 
             /* byte 4 = y offset (modification by suggestion) 
                        c6 = ors(tsr(c4){4}) & 0xff 
                        c7 = ors(tsr(c5){4}) & 0xff 
                        if c6 <> c7 
                          if (Debugg & 0x06) > 0 
                            pute WARNING:  At approximate measure number ~(measnum - 1)
                            pute 
                            pute       You have asked autoset to combine into a chord two pitches
                            pute   which have different x offsets.  This will be done, but the
                            pute   results are unpredictable.  Note combination usually arrises
                            pute   when two instruments occupy the same staff (multi track) and
                            pute   have simultaneous notes with the same stem direction.  If you
                            pute   really want different x offsets, you should make the stem
                            pute   directions on these notes different.  
                            pute 
                          end 
                        end 
                        tsr(c5){4} = chr(c7) 

                        c7 = TSR_LENG 
                        a14 = ts(a3,TSR_POINT)             /* combine tsr strings
                        tbit2 = cbi(tsr(a14){5..}) 
                        a14 = ts(a8,TSR_POINT) 
                        tbit1 = cbi(tsr(a14){5..}) 
                        tbit1 = bor(tbit1,tbit2) 
                        tsr(a14){5..c7} = cby(tbit1) 
&dA 
&dA                     &d@  End of &dA10/28/07&d@ modifications 

&dA 
&dA &d@     End of dynamics merge process (moved here &dA12/20/05&d@) 
&dA    
                      end 
                    end 
                  repeat 

                end 
NO_STEM_CHANGE: 
                a16 = 0 
                a7 = 0             
                a8 = 0 
                a15 = 0                        /* New &dA12/20/05&d@ 
              end 
              a1 = a2 
            end 
          repeat 

&dA 
&dA &d@   (4) If all notes in measure were combined into chords, then 
&dA &d@         Adjust PASSNUM for all nodes and decrease passnum by 
&dA &d@         amount of largest PASSNUM + 1 / 2  (not fully implemented) 
&dA 
          if a10 = 0 
            if a5 > 2 
              if (Debugg & 0x06) > 0 
                pute WARNING:  This program may have problems with more than
                pute   two separate instruments on a staff line 
              end 
            end 
            loop for a1 = oldsct+1 to sct 
              ts(a1,PASSNUM) = 1 
            repeat 
            passnum = 1 
          end 

          goto ISO_DONE 

ISO_FAIL: 

          loop for a1 = oldsct+1 to sct 
            nodtype = ts(a1,TYPE) 
            if nodtype <= NOTE_OR_REST and ts(a1,BEAM_FLAG) = NO_BEAM 
              a4 = ts(a1,DIV)                /* test note 
              a5 = ts(a1,NOTE_DUR) 
              a6 = bit(1,ts(a1,STEM_FLAGS)) 
              a7 = ts(a1,STAFF_NUM) 
              if nodtype = NOTE or nodtype = CUE_NOTE 
                loop for a3 = a1+1 to sct 
                  if ts(a3,DIV) = a4 
                    if ts(a3,TYPE) = nodtype and ts(a3,NOTE_DUR) = a5 
                      if bit(1,ts(a3,STEM_FLAGS)) = a6 and ts(a3,BEAM_FLAG) = NO_BEAM
                        if ts(a3,STAFF_NUM) = a7 
&dA 
&dA &d@           Move this to be part of a chord on test note 
&dA 
                          a9 = a1+1 
                          perform rotate_array (a9,a3) 
                          ts(a9,TYPE) = nodtype + 1    /* chord note 
                          ts(a9,STEM_FLAGS) |= 0x0c 
                          ts(a1,STEM_FLAGS) |= 0x04    /* make note at a1 "first" in chord &dA1/30/96
                          ts(a9,PASSNUM) = ts(a1,PASSNUM) 
                        end 
                      end 
                    end 
                  else 
                    a3 = sct 
                  end 
                repeat 
              end 
              if nodtype = GR_NOTE 
                a8 = ts(a1,NTYPE) 
                loop for a3 = a1+1 to sct 
                  if ts(a3,DIV) = a4 
                    if ts(a3,TYPE) = GR_NOTE and ts(a3,NTYPE) = a8 and ts(a3,SPACING) = 0
                      if bit(1,ts(a3,STEM_FLAGS)) = a6 and ts(a3,BEAM_FLAG) = NO_BEAM
                        if ts(a3,STAFF_NUM) = a7 
&dA 
&dA &d@           Move this to be part of a chord on test note 
&dA 
                          a9 = a1+1 
                          perform rotate_array (a9,a3) 
                          ts(a9,TYPE) = XGR_NOTE 
                          ts(a9,STEM_FLAGS) |= 0x0c 
                          ts(a1,STEM_FLAGS) |= 0x04    /* make note at a1 "first" in chord &dA1/30/96
                          ts(a9,PASSNUM) = ts(a1,PASSNUM) 
                        end 
                      end 
                    end 
                  else 
                    a3 = sct 
                  end 
                repeat 
              end 
            end 
          repeat 

&dA                                                                            
&dA 
&dA &d@     New code &dA10/14/07&d@ 
&dA &d@     Without wrecking what already works with autoset, I will now attempt to
&dA &d@        combine groups of notes under the same beam for the case where there
&dA &d@        is a third "silent" track or other disruptive objects.  
&dA 
          loop for a1 = oldsct+1 to sct 
            nodtype = ts(a1,TYPE) 
            if nodtype = NOTE and ts(a1,BEAM_FLAG) = START_BEAM 
              a4 = ts(a1,DIV)                /* test note 
              a5 = ts(a1,NOTE_DUR) 
              a6 = bit(1,ts(a1,STEM_FLAGS)) 
              a7 = ts(a1,STAFF_NUM) 
              a2 = a1 + 1 
              if ts(a2,TYPE) = NOTE and ts(a2,BEAM_FLAG) = START_BEAM 
                if ts(a2,DIV) = a4 and ts(a2,NOTE_DUR) = a5 
                  if bit(1,ts(a2,STEM_FLAGS)) = a6 and ts(a2,STAFF_NUM) = a7 
                    c1 = a1 + 2 
                    c2 = a2 + 2 
                    loop while ts(c1,BEAM_FLAG) = CONT_BEAM or ts(c1,BEAM_FLAG) = END_BEAM
                      if ts(c2,BEAM_FLAG) <> ts(c1,BEAM_FLAG) 
                        goto NO_BCOM 
                      end 
                      if ts(c1,TYPE) <> NOTE or ts(c2,TYPE) <> NOTE 
                        goto NO_BCOM 
                      end 
                      if ts(c2,DIV) <> ts(c1,DIV) or ts(c2,NOTE_DUR) <> ts(c1,NOTE_DUR)
                        goto NO_BCOM 
                      end 
                      if bit(1,ts(c1,STEM_FLAGS)) <> a6 or bit(1,ts(c2,STEM_FLAGS)) <> a6
                        goto NO_BCOM 
                      end 
                      if ts(c1,STAFF_NUM) <> a7 or ts(c2,STAFF_NUM) <> a7 
                        goto NO_BCOM 
                      end 
&dA 
&dA &d@   New code &dA12/18/10&d@.  Don't combine if there are ornaments, back ties, or fermatas
&dA 
                      c3 = ts(c1,SUBFLAG_1) & 0x0f0803ff      
                      c4 = ts(c1,ED_SUBFLAG_1) & 0x0f0803ff   
                      if c3 <> 0 or c4 <> 0 
                        goto NO_BCOM 
                      end 
&dA     
                      c1 += 2 
                      c2 += 2 
                    repeat 
                    c1 -= 2 
                    c2 -= 2 
                    if ts(c1,BEAM_FLAG) <> END_BEAM or ts(c2,BEAM_FLAG) <> END_BEAM
                      goto NO_BCOM 
                    end 
&dA 
&dA &d@           Move these notes to be part of chords on test notes 
&dA 
                    loop for c3 = a1 to c1 step 2 
                      a9 = c3 + 1 
                      ts(a9,TYPE) = nodtype + 1    /* chord note 
                      ts(a9,STEM_FLAGS) |= 0x0c 
                      ts(c3,STEM_FLAGS) |= 0x04 
                      ts(a9,PASSNUM) = ts(c3,PASSNUM) 
&dA 
&dA &d@   New code &dA12/18/10&d@.  From SUBFLAG_1, combine only the dynamics 
&dA 
                      c4 = ts(a9,SUBFLAG_1) & 0x7c00        /* dynamics only
                      ts(c3,SUBFLAG_1) |= c4                /* add these to main note
                      ts(a9,SUBFLAG_1) &= 0xffff83ff        /* and turn them off here
                      c4 = ts(a9,ED_SUBFLAG_1) & 0x7c00     /* dynamics only
                      ts(c3,ED_SUBFLAG_1) |= c4             /* add these to main note
                      ts(a9,ED_SUBFLAG_1) &= 0xffff83ff     /* and turn them off here
&dA      
                      ts(c3,SUBFLAG_2) |= ts(a9,SUBFLAG_2)        /* New &dA05/17/03
                      ts(a9,SUBFLAG_2) = 0                                                
                      ts(c3,ED_SUBFLAG_2) |= ts(a9,ED_SUBFLAG_2)  /* New &dA05/17/03
                      ts(a9,ED_SUBFLAG_2) = 0 
                    repeat 
                    a1 = a9 
                  end 
                end 
              end 
            end 
NO_BCOM: 
          repeat 
&dA 
&dA &d@     Check to see if the number of passes has been reduced            
&dA &d@        (omitted for the moment; may not be necessary) 
&dA 

ISO_DONE: 

        end 
&dA 
&dA &d@   Make sure at this point that all chords are oriented with the top 
&dA &d@   note first.  Also, for each note (or set of notes = chord), compute 
&dA &d@   the position of the note head at the end of the stem, and also 
&dA &d@   compute the position of the end of the stem.  Later, we will make  
&dA &d@   a "best guess" about what the beam height for those notes belonging 
&dA &d@   to a beam.  Store the note position in VIRT_NOTE (for all notes 
&dA &d@   of the chord) and the stem position in VIRT_STEM (for all notes 
&dA &d@   of the chord) 
&dA 
        loop for a1 = oldsct+1 to sct 
          nodtype = ts(a1,TYPE) 
          if chr(nodtype) in [NOTE,CUE_NOTE,GR_NOTE]
            if bit(2,ts(a1,STEM_FLAGS)) = 1  /* This is a chord 
              a5 = ts(a1,STEM_FLAGS) & 0x03           /* save lower two bits 
              a2 = a1 + 1 
              loop while ts(a2,TYPE) = nodtype + 1 
                ++a2 
              repeat 
              --a2            /* a2 = last note in chord 
&dA 
&dA &d@         Bubble sort 
&dA 
              loop for a3 = a1 to a2-1 
                loop for a4 = a3 to a2 
                  if ts(a3,CLAVE) < ts(a4,CLAVE) 
                    loop for a7 = 2 to TS_SIZE        /* keep primary type on top
                      if a7 <> BEAM_FLAG and a7 <> BEAM_CODE     /* and don't move beam flags, etc.
                        ts(sct+1,a7) = ts(a3,a7)        /* make hole for new element
                        ts(a3,a7)    = ts(a4,a7)        /* move in new element 
                        ts(a4,a7)    = ts(sct+1,a7)     /* put old element in vacancy
                      end 
                    repeat 
                  end 
                repeat 
              repeat 
&dA 
&dA &d@         Rewrite stem flags 
&dA 
              loop for a3 = a1 to a2  
                if a3 = a1 
                  ts(a3,STEM_FLAGS) = a5 + 0x04       /* turn bit 2 
                else 
                  ts(a3,STEM_FLAGS) = a5 + 0x0c       /* turn bits 2 and 3 (&dA01-31-97&d@ added a5)
                end 
                a4 = a3 - a1 + 1 << 4 
                ts(a3,STEM_FLAGS) += a4               /* note number in chord 
              repeat 
            else 
              a2 = a1 
            end 
&dA 
&dA &d@         Put in y location of object, y location of end note head 
&dA &d@           and (tentitive) y location of end of stem.  
&dA 
            if bit(1,ts(a1,STEM_FLAGS)) = UP 
              a4 = ts(a1,STAFFLOC) 
              a5 = ts(a2,STAFFLOC) 
              a6 = ts(a1,STAFFLOC) 
              if a6 >= vpar(5) 
                c3 = vpar(7) 
              else 
                c3 = vpar(6) 
                if ts(a1,NTYPE) > EIGHTH and a6 < 0 - vpar(1) 
                  c3 = vpar(5) 
                end 
              end 
              if nodtype <> NOTE and c3 > vpar(5) 
                if c3 = vpar(6) 
                  c3 = vpar(5) 
                else 
                  c3 = vpar(6) 
                end 
              end 
              a6 -= c3 
              a6 += vpar(1)              /* &dAFUDGE&d@ 
              if a6 > vpar(5) 
                a6 = vpar(5) 
              end 
            else 
              a4 = ts(a2,STAFFLOC) 
              a5 = ts(a1,STAFFLOC) 
              a6 = ts(a2,STAFFLOC) 
              if a6 <= vpar(4)          /* &dA09/22/05&d@ was vpar(3) 
                c3 = vpar(7) 
              else 
                c3 = vpar(6) 
                if ts(a1,NTYPE) > EIGHTH and a6 >= vpar(10) 
                  c3 = vpar(5) 
                end 
              end 
              if nodtype <> NOTE and c3 > vpar(5) 
                if c3 = vpar(6) 
                  c3 = vpar(5) 
                else 
                  c3 = vpar(6) 
                end 
              end 
              a6 += c3 
              a6 -= vpar(1)              /* &dAFUDGE&d@ 
              if a6 < vpar(3) 
                a6 = vpar(3) 
              end 
            end 
            loop for a3 = a1 to a2 
              ts(a3,OBY) = a4 
              ts(a3,VIRT_NOTE) = a5 
              ts(a3,VIRT_STEM) = a6 
            repeat 
            a1 = a2         /* advance index to last note of chord 
          end 
        repeat 
&dA 
&dA &d@   Now we can make a "best guess" about what the beam height for those 
&dA &d@   notes (chords) belonging to a beam.  Store the modified height 
&dA &d@   (for all notes of the chord) in VIRT_STEM. 
&dA 
        loop for a1 = oldsct+1 to sct 
          nodtype = ts(a1,TYPE) 
          if chr(nodtype) in [NOTE,CUE_NOTE,GR_NOTE]
            c5 = ts(a1,BEAM_FLAG) 
            if c5 <> NO_BEAM 
              c3 = ts(a1,PASSNUM) 
              c4 = nodtype + 2 / 3      /* 1, 2, or 3 
              if c5 = START_BEAM 
                passcnt(c3,c4) = 0 
              end 
              ++passcnt(c3,c4) 
              c6 = passcnt(c3,c4) 
              beamdata(c4,c3,c6) = a1       /* index to this note 

              if c5 = END_BEAM 
                stem = bit(1,ts(a1,STEM_FLAGS)) 
                if c4 = 1 
                  c5 = 0 
                else 
                  c5 = 1 
                end 
                loop for c7 = 1 to c6 
                  c1 = beamdata(c4,c3,c7) 
                  mf(c7) = ts(c1,OBY)            /*  vpar(7) * c8 + ts(c1,VIRT_STEM)
                  beamcode(c7) = ts(c1,BEAM_CODE) 
                repeat 
                perform guessbeam (c10, c11) 
&dA 
&dA &d@          Put in "new" values for virtual stem position 
&dA 
                loop for c7 = 1 to c6 
                  c9 = c7 - 1 * vpar(6) * c10 / BHPAR1 
                  c1 = beamdata(c4,c3,c7) 
                  ts(c1,VIRT_STEM) = c11 + c9 
                repeat 
              end 
            end 
          end 
        repeat 

        loop for a1 = oldsct+1 to sct 
          nodtype = ts(a1,TYPE) 
          if chr(nodtype) in [XNOTE,XCUE_NOTE,XGR_NOTE]
            ts(a1,VIRT_STEM) = ts(a1-1,VIRT_STEM) 
          end 
        repeat 
&dA 
&dA &d@   If mcat = 2, decode all accidentals using a measax array which depends 
&dA &d@   on the note position in a chord.  
&dA 
        if mcat = 2                /* %%% add code here for changing ax behavior
          loop for a1 = oldsct+1 to sct 
            nodtype = ts(a1,TYPE) 
            if nodtype <= NOTE_OR_REST 
              a4 = ts(a1,STEM_FLAGS) >> 4     /* Note number in chord 
              if a4 = 0 
                a4 = 1 
              end 
              if a4 > 4                                 /* &dA06/04/08&d@ was 3 
                tmess = 26 
                perform dtalk (tmess) 
              end 
              perform decodeax (a1,a4) 
            end 
            if nodtype = BAR_LINE 
              loop for a3 = 1 to 50 
                loop for a4 = 1 to 4                    /* &dA06/04/08&d@ was 3 
                  measax(a4,a3) = tclaveax(a3)          /* New &dA12/14/07&d@ 
                repeat 
              repeat 
            end 
            if nodtype = CLEF_CHG 
              a4 = ts(a1,STAFF_NUM) + 1    /* staff number 
              clef(a4) = ts(a1,CLEF_NUM) 
              perform zjcline (a4) 
*     this resets clef and cline 
              ts(a1,CLEF_FONT) += z        /* music font 
              ts(a1,CLEF_STAFF_POS) = 5 - clef_vpos * notesize 
              a3 = hpar(8) * 5 / 6                           /* Added &dA06-24-94&d@ 
              if ts(a1,CLEF_FONT) > 128     /* music font 
                a3 = a3 * 8 / 10 
              end 
              ts(a1,SPACING) = a3 
              if nstaves > 1     /* Case: assume one part to stave (usual case)
                loop for a3 = 1 to 50 
                  measax(a4,a3) = tclaveax(a3)          /* New &dA12/14/07&d@ 
                repeat 
              else 
                loop for a4 = 1 to 4                    /* &dA06/04/08&d@ was 3 
                  loop for a3 = 1 to 50 
                    measax(a4,a3) = tclaveax(a3)        /* New &dA12/14/07&d@ 
                  repeat 
                repeat 
              end 
            end 
          repeat 
        end 
&dA 
&dA &d@   Decode all accidentals for all other cases               
&dA 
        if mcat < 2 
          loop for a1 = oldsct+1 to sct 
            nodtype = ts(a1,TYPE) 
            if nodtype <= NOTE_OR_REST 
              a4 = ts(a1,STAFF_NUM) + 1    /* staff number 
              perform decodeax (a1,a4) 
            end 
            if nodtype = BAR_LINE 
              loop for a3 = 1 to 50 
                loop for a4 = 1 to 4                    /* &dA06/04/08&d@ was 3 
                  measax(a4,a3) = tclaveax(a3)          /* New &dA12/14/07&d@ 
                repeat 
              repeat 
            end 
            if nodtype = CLEF_CHG 
              a4 = ts(a1,STAFF_NUM) + 1    /* staff number 
              clef(a4) = ts(a1,CLEF_NUM) 
              perform zjcline (a4) 
*     this resets clef and cline 
              ts(a1,CLEF_FONT) += z         /* music font 
              ts(a1,CLEF_STAFF_POS) = 5 - clef_vpos * notesize 
              a3 = hpar(8) * 5 / 6                           /* Added &dA06-24-94&d@ 
              if ts(a1,CLEF_FONT) > 128     /* music font 
                a3 = a3 * 8 / 10 
              else 
                a3 = a3 * 6 / 5                              /* Added &dA12/09/03&d@ as a cludge
              end 
              ts(a1,SPACING) = a3 
              loop for a3 = 1 to 50 
                measax(a4,a3) = tclaveax(a3)            /* New &dA12/14/07&d@ 
              repeat 
            end 
          repeat 
        end 
&dA 
&dA &d@   Now remove all places where accidentals have been placed twice on 
&dA &d@   the same line as a result of multiple parts playing the same 
&dA &d@   altered note.  This code added &dA09/22/93&d@ 
&dA 
        loop for a1 = oldsct+1 to sct 
          nodtype = ts(a1,TYPE) 
          if nodtype <= NOTE_OR_REST               
            loop for a2 = a1 + 1 to sct 
            repeat while ts(a2,SPACING) = 0 and ts(a2,DIV) = ts(a1,DIV) and ts(a2,TYPE) <= NOTE_OR_REST
            --a2 
            if a2 > a1 
              loop for a3 = a1 to a2 
                if ts(a3,AX) > 0 
                  loop for a4 = a3 + 1 to a2 
                    if ts(a4,STAFF_NUM) = ts(a3,STAFF_NUM) 
                      if ts(a4,CLAVE) = ts(a3,CLAVE) 
                        if ts(a4,AX) = ts(a3,AX) 
                          ts(a4,AX) = 0 
                        end 
                      end 
                    end 
                  repeat 
                end 
              repeat 
            end 
            a1 = a2 
          end 
        repeat 
&dA 
&dA &d@   Set backtie for division 1 elements in the ts() array.  
&dA &d@   
&dA &d@     If this is the measure in a group of measures, then 
&dA &d@     BACKTIE for division 1 will point to a ROW element of tiearr, 
&dA &d@     otherwise (2) BACKTIE for division 1 will point to the ts() ROW 
&dA &d@     element that originated the tie.  
&dA &d@   
        loop for a1 = 1 to MAX_TIES
          if tiearr(a1,TIE_SNUM) > 0 and tiearr(a1,TIE_FOUND) = 0 
&dA 
&dA &d@     Case 1:  division 1 of first measure in group 
&dA 
            if oldsct = 0 
              loop for a2 = 1 to sct 
                if ts(a2,DIV) = 1 
                  a3 = tiearr(a1,TIE_NTYPE) 
                  a4 = ts(a2,TYPE) 
                  xbyte = chr(a3) // chr(a4) 
                  if ts(a2,STAFFLOC) = tiearr(a1,TIE_VLOC) 
                    if ts(a2,STAFF_NUM) = tiearr(a1,TIE_STAFF) 
                      if ts(a2,BACKTIE) = 0 
                        if xbyte in [NOTE,XNOTE]    /* i.e., both a3 and a4 are in set
                          ts(a2,BACKTIE) = a1 + INT10000   /* backtie = tie number
                          goto TS1 
                        end 
                        if xbyte in [CUE_NOTE,XCUE_NOTE] 
                          ts(a2,BACKTIE) = a1 + INT10000   /* backtie = tie number
                          goto TS1 
                        end 
                      end 
                    end 
                  end 
                end 
              repeat 
              tmess = 3 
              perform dtalk (tmess) 
            else 
&dA 
&dA &d@     Case 2:  division 1 for subsequent measures in group 
&dA 
              loop for a2 = oldsct+1 to sct 
                if ts(a2,DIV) = 1 
                  a3 = tiearr(a1,TIE_NTYPE) 
                  a4 = ts(a2,TYPE) 
                  xbyte = chr(a3) // chr(a4) 
                  if ts(a2,STAFFLOC) = tiearr(a1,TIE_VLOC) 
                    if ts(a2,STAFF_NUM) = tiearr(a1,TIE_STAFF) 
                      if xbyte in [NOTE,XNOTE]    /* i.e., both a3 and a4 are in set
                        ts(a2,BACKTIE) = tiearr(a1,TIE_NDX)   /* backtie = ts index
                        tiearr(a1,TIE_SNUM) = 0   /* free-up this ROW element of tiearr
                        goto TS1 
                      end 
                      if xbyte in [CUE_NOTE,XCUE_NOTE] 
                        ts(a2,BACKTIE) = tiearr(a1,TIE_NDX)   /* backtie = ts index
                        tiearr(a1,TIE_SNUM) = 0   /* free-up this ROW element of tiearr
                        goto TS1 
                      end 
                    end 
                  end 
                end 
              repeat 
              tmess = 3 
              perform dtalk (tmess) 
            end 
TS1: 
            tiearr(a1,TIE_FOUND) = 1 
          end  
        repeat 
&dA 
&dA &d@   Set backtie for all non-division-1 elements in the ts() array.  
&dA &d@   
        loop for a1 = oldsct+1 to sct 
&dA 
&dA &d@     Special case: Grace note tied to a regular note on the same division &dA11/02/05
&dA 
          if chr(ts(a1,TYPE)) in [GR_NOTE,XGR_NOTE] 
            if bit(0,ts(a1,SUPER_FLAG)) = 1 and a1 < sct      /* tie present 
              a4 = ts(a1,DIV)
              loop for a2 = a1+1 to sct 
                if ts(a2,DIV) = a4    
                  if ts(a1,STAFF_NUM) = ts(a2,STAFF_NUM) 
                    if ts(a1,STAFFLOC) = ts(a2,STAFFLOC) 
                      if chr(ts(a2,TYPE)) in [NOTE,XNOTE] 
                        ts(a2,BACKTIE) = a1     /* Case: backtie = ts index to first note
                        goto SEARCH_DONE 
                      end 
                    end 
                  end 
                else 
                  a2 = 1000000 
                end 
              repeat 
            end 
          end 
&dA 
&dA &d@     End of &dA11/02/05&d@ special case 
&dA 
          if chr(ts(a1,TYPE)) in [NOTE,XNOTE,CUE_NOTE,XCUE_NOTE]
            if bit(0,ts(a1,SUPER_FLAG)) = 1 and a1 < sct      /* tie present 
              a4 = ts(a1,DIV) + ts(a1,NOTE_DUR) 
&dA 
&dA &d@        Try it first where pass numbers must be the same (usual case) 
&dA 
              loop for a2 = a1+1 to sct 
                if ts(a2,DIV) = a4 and ts(a1,PASSNUM) = ts(a2,PASSNUM) 
                  if ts(a1,STAFFLOC) = ts(a2,STAFFLOC) 
                    if chr(ts(a1,TYPE)) in [NOTE,XNOTE] 
                      if chr(ts(a2,TYPE)) in [NOTE,XNOTE] 
                        ts(a2,BACKTIE) = a1     /* Case: backtie = ts index to first note
                        goto SEARCH_DONE 
                      end 
                    else 
                      if chr(ts(a2,TYPE)) in [CUE_NOTE,XCUE_NOTE] 
                        ts(a2,BACKTIE) = a1     /* Case: backtie = ts index to first note
                        goto SEARCH_DONE 
                      end 
                    end 
                  end 
                end 
              repeat 
&dA 
&dA &d@        Now try it where pass numbers need not be the same (unusual case) 
&dA 
              loop for a2 = a1+1 to sct 
                if ts(a2,DIV) = a4 
                  if ts(a1,STAFFLOC) = ts(a2,STAFFLOC) 
                    if chr(ts(a1,TYPE)) in [NOTE,XNOTE] 
                      if chr(ts(a2,TYPE)) in [NOTE,XNOTE] 
                        ts(a2,BACKTIE) = a1     /* Case: backtie = ts index to first note
                        goto SEARCH_DONE 
                      end 
                    else 
                      if chr(ts(a2,TYPE)) in [CUE_NOTE,XCUE_NOTE] 
                        ts(a2,BACKTIE) = a1     /* Case: backtie = ts index to first note
                        goto SEARCH_DONE 
                      end 
                    end 
                  end 
                end 
              repeat 
&dA 
&dA &d@    If you reach this point (i.e., you have not found a terminating 
&dA &d@    note), then you must use the tiearr to temporarily store the 
&dA &d@    information about this note for future reference.  This info must  
&dA &d@    be discarded before the final processing of the ts() array.       
&dA 
&dA &d@        Identify a free slice of tiearr 
&dA 
              loop for c7 = 1 to MAX_TIES 
                if tiearr(c7,TIE_SNUM) = 0 
                  goto XXX2 
                end 
              repeat 
&dA 
&dA &d@          Here is where the pseudo tiearr is built 
&dA 
XXX2:         tiearr(c7,TIE_SNUM)  = INT1000000       /* pseudo super number 
              tiearr(c7,TIE_NTYPE) = ts(a1,TYPE) 
              tiearr(c7,TIE_VLOC)  = ts(a1,STAFFLOC) 
              tiearr(c7,TIE_NDX)   = a1 
              tiearr(c7,TIE_STAFF) = ts(a1,STAFF_NUM) 
              tiearr(c7,TIE_FOUND) = 0 
              tiearr(c7,TIE_FORCE) = ts(a1,SLUR_FLAG) >> 24 
       /* &dA04/20/03&d@: New code 
              c6 = ts(a1,TSR_POINT) 
              tiearr(c7,TIE_SUGG)  = ors(tsr(c6){69,4}) 
              tiearr(c7,TIE_COLOR) = ts(a1,SUBFLAG_1) >> 28   /* New &dA12/21/10
            end  
          end  
SEARCH_DONE: 
        repeat 
&dA 
&dA &d@  Determine space parameter for notes and figures (and isolated signs, words and marks)
&dA 
        loop for a1 = 1 to 120 
          mf(a1) = 0 
        repeat 
        a9 = 0 
        divspq = olddivspq
        inctype_rem = 0                            /* Code added &dA02/24/97&d@ 
        loop for a1 = oldsct+1 to sct 
          nodtype = ts(a1,TYPE)  
          if nodtype = DIV_CHG
            mdiv = ts(a1,DIV)
            divspq = ts(a1,DIVSPQ)
          end
          if nodtype = METER_CHG
            perform newnsp
          end
          if nodtype > NOTE_OR_REST and nodtype <> FIGURES
            if chr(nodtype) in [SIGN,WORDS,MARK] and ts(a1,ISOLATED) = 1 
            else 
              goto TS3 
            end 
          end  
          if chr(nodtype) not_in [XNOTE,XCUE_NOTE,XGR_NOTE]
            if nodtype = GR_NOTE
              goto TS3       /* grace note spacing has already been computed. see GRACE
            end  
&dA 
&dA &d@     determine space and duration for this note/figure 
&dA 
            if nodtype <= NOTE_OR_REST
              a5 = a1  
              perform getspace 
              a7 = a6  
              a8 = ts(a1,NOTE_DUR)  
&dA 
&dA &d@     Code added &dA05-29-94&d@   We cannot allow a8 to be less than time    
&dA &d@                           distance to the next division.  
&dA 
&dA &d@     Code added &dA06-18-94&d@   We also cannot allow a8 to be more than the 
&dA &d@                           time distance to the next division, if the 
&dA &d@                           next division contains an isolated sign, 
&dA &d@                           words, or mark. 
&dA 
              loop for a2 = a1+1 to sct 
                a3 = ts(a2,DIV) - ts(a1,DIV) 
                if a3 > 0
                  if a3 > a8 
                    a8 = a3 
                  end 
                  if chr(ts(a2,TYPE)) in [SIGN,WORDS,MARK] and ts(a2,ISOLATED) = 1
                    if a3 < a8 
                      a8 = a3 
                    end 
                  end 
                  a2 = sct 
                end 
              repeat 
            else 
&dA 
&dA &d@   case 2: figures (and isolated signs, words, and marks) 
&dA 
&dA &d@     1) determine duration (given or implied) 
&dA 
              if nodtype = FIGURES and ts(a1,FIG_DUR) > 0 
                a8 = ts(a1,FIG_DUR)  
              else 
&dA &d@       if figure is not isolated, adopt a duration, else
&dA &d@         impute duration
                if a1 <> sct 
                  loop for a11 = a1+1 to sct 
                    if ts(a11,DIV) = ts(a1,DIV)  
                      if ts(a11,TYPE) <= NOTE_OR_REST
                        a8 = ts(a11,NOTE_DUR) 
                        goto TS4 
                      end  
                    else 
&dA &d@             isolated figure in middle of data  
                      a8 = ts(a11,DIV) - ts(a1,DIV)  
                      goto TS4 
                    end  
                  repeat 
                end  
&dA &d@             isolated figure at end of data 
                a8 = divspq  
              end  
&dA 
&dA &d@     2) compute space for this duration 
&dA 

TS4:          a10 = a8 

&dA &d@        a) adjust duration for triplet  
              a12 = 0  
              a11 = divspq / 3 
              if rem = 0 
                a11 = a10 / 3  
                if rem > 0 
                  a10 = a10 * 3 / 2  
                  a12 = 1  
                end  
              end  
&dA &d@        b) find index into space parameter array  
              a11 = 35 - a12 
              a12 = divspq * 16  
              loop 
                a13 = a10 / a12  
                a12 >>= 1 
                a11 -= 3 
              repeat while a13 = 0 
              if rem > 0 
                ++a11
              end  
              a7 = nsp(a11)  
            end  
            a14 = a7 
&dA 
&dA &d@    notes and figures re-unified at this point in program 
&dA 
&dA &d@   a7 = space for first note/figure in node 
&dA &d@   a8 = duration for first note/figure in node  
&dA &d@  a14 = largest space for shortest full duration on this division (initially a14 = a7)
&dA 
            ++a9
            ts(oldsct+a9,TEMP1) = a7 
            ts(oldsct+a9,TEMP2) = a8 
            mf(a9) = a8  
&dA 
&dA &d@    proceeding from this point, we have only regular and cue notes, 
&dA &d@                     rests and chords on this division  
&dA 
            if a1 < sct 
              loop for a2 = a1+1 to sct  
                if ts(a2,DIV) <> ts(a1,DIV)  
                  --a2
                  goto TS2 
                else 
                  a11 = ts(a2,TYPE)
                  if a11 <> XNOTE and a11 <> XCUE_NOTE 
                    a5 = a2  
                    perform getspace 
                    a15 = ts(a2,NOTE_DUR) 
&dA 
&dA &d@     &dA12/04/05&d@  This code moved from below (before modifying a15) 
&dA &d@      
                    ++a9
                    mf(a9) = a15 
&dA      &d@         
                    if a15 < a8                        /* modified &dA3/20/94&d@ 
                      a7 = a6 
                      a14 = a7 
&dA 
&dA &d@       Code added &dA05-29-94&d@   We cannot allow the "time-space increment" 
&dA &d@                             to be less than the time distance to the 
&dA &d@                             next division. 
&dA 
                      loop for a3 = a2+1 to sct 
                        if ts(a3,DIV) <> ts(a1,DIV) 
                          a15 = ts(a3,DIV) - ts(a1,DIV) 
                          a8 = a15 
                          a3 = sct 
                        end 
                      repeat 
                    else 
                      if a15 = a8 
                        if a6 < a7 
                          a7 = a6 
                        end 
                        if a6 > a7 
                          a14 = a6 
                        end 
                      end 
                    end  
                    ts(oldsct+a9,TEMP1) = a6 
                    ts(oldsct+a9,TEMP2) = a15 
                  end  
                end  
              repeat 
              a2 = sct 
            else   
              a2 = a1  
            end  
&dA 
&dA &d@   a2 = pointer into set for last figure/note/rest/cue
&dA &d@                on this division
&dA &d@   a7 = smallest space for notes for shortest duration on this division 
&dA &d@   a8 = duration of notes of shortest duration on this division 
&dA &d@   a9 = total size of mf array (notes longer than smallest) 
&dA &d@  a14 = largest space for shortest full duration on this division 
&dA 
TS2: 
            a4 = 10000 
            a5 = 10000 
            a6 = a7  
            loop for a3 = 1 to a9 
              if mf(a3) > 0  
                if mf(a3) < a4 
                  a4 = mf(a3)  
                end  
&dA 
&dA &d@          &dA07/01/03&d@:  Fixing this to account for irests with &dEnull&d@ space 
&dA 
                if ts(oldsct+a3,TEMP2) <= a5 
                  a5 = ts(oldsct+a3,TEMP2) 
                  if ts(oldsct+a3,TEMP1) > 0 
                    a6 = ts(oldsct+a3,TEMP1) 
                  end 
                end  
              end  
            repeat 
&dA 
&dA &d@   a4 = smallest number of divisions from left over notes 
&dA &d@   a5 = duration of shortest note sounding at this point  
&dA &d@   a6 = space parameter for this shortest note  
&dA &d@   a4 < a8 means syncopation  
&dA &d@   here also is where we set the increment distance flag.
&dA &d@      Since we are going to increment the distance, we 
&dA &d@      know at this point what technique we will be using.
&dA &d@      ts(24) describes this technique.
&dA 
            if a4 < a8   
              a7 = a6 * a4 / a5    
              a8 = a4  
            else 
              a7 = a14 
            end 
&dA 
&dA &d@   a7 = space parameter for this node 
&dA &d@   a8 = real duration of this node  
&dA 
            dv4 = 576 * a8 / divspq  
            inctype_rem += rem                     /* Code added &dA02/24/97&d@ 
            if inctype_rem > (divspq / 2) 
              inctype_rem -= divspq 
              ++dv4 
            end                                    /* End of &dA02/24/97&d@ addition
            ts(a1,DINC_FLAG) = dv4
            loop for a3 = 1 to a9  
              mf(a3) -= a8 
              if mf(a3) < 0  
                mf(a3) = 0 
              end  
            repeat 
            if chr(nodtype) in [SIGN,WORDS,MARK]
              ts(a1,SPACING) = a7                  /* must be small, but non-zero
            else 
              if nodtype <= NOTE_OR_REST 
                ts(a1,SPACING) = a7 
              else 
                if a1 = a2 
                  ts(a1,FIG_SPACE) = a7 
                  ts(a1,MIN_FIG_SPAC) = a7 
                else 
                  a6 = a1 + 1 
                  if ts(a6,TYPE) <= NOTE_OR_REST 
                    ts(a6,SPACING) = a7 
                  else 
                    tmess = 8 
                    perform dtalk (tmess) 
                  end 
                end 
              end 
            end 
            a1 = a2  
          end  
TS3: 
        repeat 
&dA 
&dA &d@   Update olddivspq
&dA 
        olddivspq = divspq
        if mdiv = totdiv  /*  &dAadded 1-27-93    This code is necessary&d@ 
          qflag = 0       /*  &dAto cope with the situation where the   
        end               /*  &dAdivisions-per-quarter is changed at the&d@ 
                          /*  &dAend of the measure                     
        loop for a1 = 1 to a9  
          ts(oldsct+a1,TEMP1) = 0 
          ts(oldsct+a1,TEMP2) = 0 
        repeat 
&dA 
&dA &d@   Space parameter is initialized 
&dA 
&dA 
&dA &d@   We have computed ts(24), the distance increment flag, for all 
&dA &d@   regular/cue/figure nodes.  This parameter is the time elaps 
&dA &d@   between this node and the next node in the measure.  It is 
&dA &d@   measured in divisions, with 576 divisions being the equivalent 
&dA &d@   of a quarter note.  In the example below the notes are triplet 
&dA &d@   eights and regular sixteenths respectively.  The distances are 
&dA &d@   listed by letter.  
&dA 
&dA &d@                   :=======:=======: 
&dA &d@      triplet 8ths |       |       |       |    a =  144 (reg 16th) 
&dA &d@                   @       @       @       O    b =   48 
&dA &d@                   /  a  /b/ c / d /e/  f  /    c =   96 
&dA &d@                   @     @     @     @     O    d =   96 
&dA &d@      sixteenths   |     |     |     |     |    e =   48 
&dA &d@                   |_____|_____|_____|          f =  144 (reg 16th) 
&dA &d@                   *=====*=====*=====* 
&dA 
&dA &d@   These parameters will be assigned to the first object in the 
&dA &d@   node FOLLOWING THE DISTANCE, whatever it is.  It might, for 
&dA &d@   example, be a grace note, or some kind of sign.  The first 
&dA &d@   object in the node is the one where we can best describe the 
&dA &d@   distance that has been traversed.  In order to accomplish this, 
&dA &d@   we do not set the inctype parameter until after the object 
&dA &d@   containing the ts(24) parameter is processed.  When spn rolls 
&dA &d@   over to a new value, the object in question will be assigned 
&dA &d@   the prior ts(24) parameter.  
&dA 
        tfirstsp = 0  
&dA 
&dA &d@   Adjust accidentals for case where tie crosses bar line 
&dA 
        a10 = 1  
        loop for a1 = oldsct+1 to sct   
          nodtype = ts(a1,TYPE)  
          if ts(a1,DIV) = a10 and ts(a1,BACKTIE) > 0 
            if chr(nodtype) in [NOTE,XNOTE,CUE_NOTE,XCUE_NOTE] 
              loop for a3 = a1+1 to sct 
                if ts(a3,DIV) > a10 and ts(a3,TYPE) <= NOTE_OR_REST 
                  if ts(a3,CLAVE) = ts(a1,CLAVE) 
                    if ts(a3,STAFF_NUM) = ts(a1,STAFF_NUM)    /* added &dA3-23-94&d@ 
                      if ts(a3,AX) = 0 
                        ts(a3,AX) = ts(a1,AX) 
                      end 
&dA 
&dA &d@                   Now remove any similar accidentals which might have 
&dA &d@                   existed previously on this <pitch, staff, division> 
&dA &d@                   combination.  
&dA 
                      loop for a4 = a3 + 1 to sct 
                      repeat while ts(a4,SPACING) = 0 and ts(a4,DIV) = ts(a3,DIV) and ts(a4,TYPE) <= NOTE_OR_REST
                      --a4 
                      loop for a5 = a3 + 1 to a4 
                        if ts(a5,STAFF_NUM) = ts(a3,STAFF_NUM) 
                          if ts(a5,CLAVE) = ts(a3,CLAVE) 
                            if ts(a5,AX) = ts(a3,AX) 
                              ts(a5,AX) = 0 
                            end 
                          end 
                        end 
                      repeat 
                      goto XD 
                    end 
                  end 
                end 
              repeat 
XD: 
              if ts(a1,AX) > 0 and (ts(a1,SUBFLAG_1) & 0x040000) = 0 /* condition added &dA11/05/05
                ts(a1,AX) |= 0x10       /* Code added &dA02/25/97&d@.  This is the "silent" flag
              end
            end  
          end  
          if nodtype = BAR_LINE       /* non-controlling case 
            a10 = ts(a1,DIV)  
          end  
        repeat       

&dA 
&dA &d@    We have a tiny chore to do here.  In the case where we have 
&dA &d@    a down-up pattern of stems on the same beam, we need to be 
&dA &d@    sure the spacing between these notes is at least some minimum 
&dA &d@    distance.  (This code will work most of the time). 
&dA 
        a5 = hpar(4) * 4 / 5 + hpar(82) 
        a4 = 0 
        loop for a1 = oldsct+1 to sct 
          nodtype = ts(a1,TYPE) 
          if nodtype <= NOTE_OR_REST 
            a3 = nodtype + 1 / 3        /* &dAThis code assumes               
            if rem <> 0                 /* &dAXNOTE=2  XCUE_NOTE=5  XGR_NOTE=8&d@ 
              if ts(a1,SPACING) > 0 
                a4 = a1                 /* save index to spacing number 
              end 
            end 
            if nodtype = NOTE or nodtype = GR_NOTE or nodtype = CUE_NOTE 
              if bit(1,ts(a1,STEM_FLAGS)) = UP 
                c12 = ts(a1,BEAM_FLAG) 
                if c12 = CONT_BEAM or c12 = START_BEAM 
                  a3 = 0 
                  loop for a2 = a1 + 1 to sct 
                    if ts(a2,SPACING) > 0 
                      ++a3 
                      if a3 > 1 
                        goto NEXTNOTE 
                      end 
                    end 
                    if ts(a2,TYPE) = nodtype 
                      if ts(a2,PASSNUM) = ts(a1,PASSNUM) 
                        if bit(1,ts(a2,STEM_FLAGS)) = DOWN 
                          if ts(a4,SPACING) < a5 
                            ts(a4,SPACING) = a5 
                          end 
                        end 
                        goto NEXTNOTE 
                      end 
                    end 
                  repeat 
                end 
              end 
            end 
          end 
NEXTNOTE: 
        repeat 
&dA 
&dA &d@    Make space for text                
&dA 
&dA &d@    This is not an easy task to perform.  I have tried a couple of 
&dA &d@    methods already and am not too happy with them.  Let me start 
&dA &d@    by summarizing the objectives.  
&dA 
&dA &d@    1) We want to underlay the text in as compact a way as possible 
&dA &d@         The reason for this is that in the later stages of typesetting 
&dA &d@         we almost always &dAexpand&d@ the music, so we want to start with 
&dA &d@         as compact a version as possible.  
&dA 
&dA &d@    2) We want the notes to be as true to their rythmic values as 
&dA &d@         possible.  
&dA 
&dA &d@    3) We need to preserve spacings attached to grace notes, clef  
&dA &d@         signs, key changes, etc.  
&dA 
        a2 = firstoff  
        a3 = hpar(37) + tfirstsp 
        a11 = 0  
        c11 = 0                             /* added &dA12/09/03&d@ 
        loop for a1 = oldsct+1 to sct 
          nodtype = ts(a1,TYPE)  
          if nodtype = NOTE
            a8 = ts(a1,TEXT_INDEX)  
            temp2 = trm(tsdata(a8)) 
            temp2 = temp2 // pad(1) 
&dA 
&dA &d@        New test for text data &dA09/01/03&d@ 
&dA 
            c6 = 0 
            if temp2{1} in ['A'..'Z','a'..'z','!'..'(','\','='] 
              c6 = 1 
            else 
              temp2 = temp2 // " " 
              loop for c7 = 1 to len(temp2) 
                if temp2{c7} = "|" and temp2{c7+1} in ['A'..'Z','a'..'z','!'..'(','\','=']
                  c6 = 1 
                  c7 = len(temp2) 
                end 
              repeat 
              temp2 = trm(temp2) 
            end 
            if c6 = 1 
&dA 
&dA &d@        End of test &dA09/01/03&d@ 
&dA 
              c11 = 1                       /* added &dA12/09/03&d@ 
              textconflag = OFF 
&dA 
&dA &d@    Look for case of multiple text 
&dA 
              c6 = 0 
              c7 = 0 
              temp2 = temp2 // "| " 
CCCB: 
              if temp2 con "|" 
                ttext = temp2{1,mpt-1} 
                temp2 = temp2{mpt+1..} 
                c5 = mtfont 
                perform wordspace 
                a6 = len(ttext) 
                if "-_" con ttext{a6} 
                  if mpt = 1 
                    a5 -= spc(45) 
                  else 
                    a5 -= spc(95) 
                  end 
                else 
                  c7 = 1 
                end 
                if c6 < a5 
                  c6 = a5 
                end 
                goto CCCB 
              end 
              a5 = c6 
              if c7 = 0    /* all words end in "_" or "-" 
                if a1 <> sct and ts(a1+1,TYPE) = NOTE 
                  c8 = ts(a1+1,TEXT_INDEX) 
                  temp2 = trm(tsdata(c8)) 
                  temp2 = temp2 // pad(1) 
                  if "-_" con temp2{1} 
                    a4 = a5 - ts(a1,SPACING) - hpar(51) / 3 
                    if a4 < 0 
                      a4 = 0 
                    end 
                    goto CCCC 
                  end 
                end 
                if bit(0,ts(a1,SUPER_FLAG)) = 1 
                  a4 = a5 - ts(a1,SPACING) - hpar(51) / 3 
                  if a4 < 0 
                    a4 = 0 
                  end 
                  goto CCCC 
                end 
              end 
              a4 = a5 / 3 - (spc(45) >> 1) 

CCCC:         a6 = a3 - a4 
              a7 = a2 - a6 
&dA 
&dA &d@  a5       = projected space taken up by syllable 
&dA &d@  a4       = amount by which a syllable is backed up from the note 
&dA &d@                 position 
&dA &d@  tfirstsp = amount by which first note is shifted forward to make 
&dA &d@                 space for text 
&dA &d@  a3       = projected position of current note from bar line 
&dA &d@  a6       = projected position of beginning of current syllable 
&dA &d@  firstoff = amount by which last syllable from previous measure 
&dA &d@                 overhangs the space allowed for the last note 
&dA &d@  a2       = smallest value of a6 allowed 
&dA &d@  a7       = difference between smallest allowed a6 and current a6 
&dA 

              if a7 > 0  
                if a11 = 0   
                  tfirstsp += a7 
&dA &d@                 a3 += a7 
                else 
                  if ts(a10,TYPE) = NOTE 
                    c8 = ts(a10,TEXT_INDEX) 
                    temp2 = trm(tsdata(c8)) 
                    temp2 = temp2 // pad(1) 
                    if "-_" con temp2{1} 
                      c9 = 0 
                      loop for c10 = a10 - 1 to oldsct + 1 step -1 
                        if ts(c10,SPACING) > 0 and ts(c10,TYPE) < GR_NOTE 
                          c9 = c10 
                          c10 = 0 
                        end 
                      repeat 
                      if c9 > 0 
                        ts(c9,SPACING) += a7 >> 1 
                        ts(a10,SPACING) += a7 >> 1                    
                        goto CCCA 
                      end 
                    end 
                  end 
                  ts(a10,SPACING) += a7     /* a10 set later 
                end  
              end  
CCCA: 
              tsdata(a8) = trm(tsdata(a8)) // "$$$$" // chs(a4) 

              a5 -= a4 
              a2 = a3 + a5 + hpar(58)       /* hpar(58) = space between words        
            end  
            if temp2{1} = "_"  
              a5 = a3 + spc(95)  
              if a5 > a2 
                a2 = a5  
              end  
            end  

            temp2 = trm(tsdata(a8)) 
            temp2 = temp2 // pad(1) 
            if temp2{1} = "_" 
              textconflag = ON 
            end 

            sub = 1 
            a11 = 1 
            loop while temp2{sub..} con "|" 
              a11 <<= 1 
              ++sub 
              if temp2{sub} = "_" 
                textconflag += a11 
              end 
            repeat 

            if temp2 = " " and textconflag > OFF     /* code added &dA02-23-95&d@ 
              tsdata(a8) = pad(10) 
              loop for a11 = 0 to 9 
                if bit(a11,textconflag) = ON 
                  tsdata(a8){a11+1} = "~" 
                end 
              repeat 
              tsdata(a8) = trm(tsdata(a8)) 
              textconflag = OFF 
            end 
            a11 = 1  
          end  
          if nodtype = REST and ts(a1,CLAVE) < 200   /* code added &dA02-23-95&d@ 
            textconflag = OFF 
          end 
          if nodtype = BAR_LINE 
            if a2 - hpar(36) > a3 
              ts(a10,SPACING) += a2 - hpar(36) - a3 
              a3 = a2 - hpar(36) 
            end 
          end 
&dA 
&dA &d@   a10 = backpointer to prior space for note/rest object set  
&dA 
          if ts(a1,SPACING) > 0 and ts(a1,TYPE) < GR_NOTE 
            a10 = a1 
          end  
          firstoff = 0 
          if a1 = sct  
            a4 = a2 - hpar(36) 
            if a4 > a3 
              firstoff = a4 - a3 
            end  
          else 
            a3 += ts(a1,SPACING) 
          end  
        repeat 
&dA 
&dA &d@    Adding a new section of code (&dA12/09/03&d@) which attempts to midigate somewhat
&dA &d@    the unevenness in note spacing introduced by the addition of text.  Code
&dA &d@    uses c11 to c17 as temporary variables, as well as a new array variable nspace(.,.)
&dA 
        if c11 = 1 
          c12 = 0 
          loop for a1 = oldsct+1 to sct 
            nodtype = ts(a1,TYPE) 
            if nodtype = NOTE or nodtype = REST 
              a8 = ts(a1,TEXT_INDEX) 
              temp2 = trm(tsdata(a8)) 
              ++c12 
              nspace(c12,1) = a1 
              nspace(c12,2) = ts(a1,NTYPE) & 0xff           /* new &dA10/15/07&d@ 
              nspace(c12,3) = ts(a1,SPACING) 
              nspace(c12,4) = ts(a1,TYPE)      
              if temp2 con "$$$$" 
                nspace(c12,5) = int(temp2{mpt+4..}) 
              else 
                nspace(c12,5) = 0 
              end 
              nspace(c12,6) = 0 
              nspace(c12,7) = 0 
              nspace(c12,8) = 0 

            end 
          repeat 
&dA 
&dA &d@ Algorithm.  
&dA 
&dA &d@ (1) examine all pairs of notes.  Find the pair for which 
&dA &d@     (a) same duration 
&dA &d@     (b) if d1 = distance after 1st note, and d2 = distance after 2nd note 
&dA &d@           and both d1 and d2 are non-zero                     (added &dA04/10/05&d@)
&dA &d@           and abs(d1 - d2) > 1 
&dA &d@     (c) smallest distance in this set 
&dA 
&dA &d@ (2) try moving 2nd note one unit either towards (d1 > d2) or away from (d2 > d1) first note.
&dA &d@     (a) resulting total shift of 2nd note cannot more than 1/2 nspace(.,5) to the right
&dA &d@           or more than nspace(.,5) to the left 
&dA &d@     (b) if note cannot be moved, goto (1) and consider next pair 
&dA 
&dA &d@ (3) if (1)+(2) fail, look for situations where                               
&dA &d@     (a) a note of longer duration follows a note of shorter duration, and 
&dA &d@           the shorter note is allowed more space.  Try moving the 2nd note
&dA &d@           closer to the first, then goto (1).  
&dA &d@     (b) a note of shorter duration follows a note of longer duration, and 
&dA &d@           the shorter note is allowed more space.  Try moving the 2nd note
&dA &d@           away from the first, then goto (1).  
&dA &d@     (c) in all cases under (3), principal (2)(a) must be followed, 
&dA &d@           and both notes in question must have non-zero following distances (added &dA04/10/05&d@)
&dA 
&dA 
NXPAIR: 
          c15 = 1000 
          c16 = 0 
          loop for c13 = 1 to c12 - 1 
            if nspace(c13,2) = nspace(c13+1,2) and nspace(c13+1,3) <> 0 and nspace(c13,3) <> 0
              c14 = abs(nspace(c13,3) - nspace(c13+1,3)) 
              if c14 > 1 
                if c14 < c15 
                  if nspace(c13+1,5) = 0                     /* next node is a rest, etc.
                    if nspace(c13+1,6) > -6                  /* max incroachment is 6
                      c15 = c14 
                      c16 = c13 
                    end 
                  else 
                    if nspace(c13,3) > nspace(c13+1,3)       /* move 2nd note to the left
                      if nspace(c13+1,6) < 0 
                        if abs(nspace(c13+1,6)) < nspace(c13+1,5) 
                          c15 = c14 
                          c16 = c13 
                        end 
                      else 
                        c15 = c14 
                        c16 = c13 
                      end 
                    else                                     /* move 2nd note to the right
                      if nspace(c13+1,6) < (nspace(c13+1,5) + 1 >> 1) 
                        c15 = c14 
                        c16 = c13 
                      end 
                    end 
                  end 
                end 
              end 
            end 
          repeat 
          if c16 > 0 
            loop for c13 = 1 to c12 
              nspace(c13,7) = 0 
            repeat 
          end 

          if c16 = 0 
            loop for c13 = 1 to c12 - 1 
              if nspace(c13,2) = nspace(c13+1,2) and nspace(c13+1,3) <> 0 and nspace(c13,3) <> 0
                c14 = abs(nspace(c13,3) - nspace(c13+1,3)) 
                if c14 = 1 and nspace(c13,7) = 0 
                  if nspace(c13+1,5) = 0                     /* next node is a rest, etc.
                    if nspace(c13+1,6) > -6                  /* max incroachment is 6
                      c16 = c13 
                      c13 = c12 
                    end 
                  else 
                    if nspace(c13,3) > nspace(c13+1,3)       /* move 2nd note to the left
                      if nspace(c13+1,6) < 0 
                        if abs(nspace(c13+1,6)) < nspace(c13+1,5) 
                          c16 = c13 
                          c13 = c12 
                        end 
                      else 
                        c16 = c13 
                        c13 = c12 
                      end 
                    else                                     /* move 2nd note to the right
                      if nspace(c13+1,6) < (nspace(c13+1,5) + 1 >> 1) 
                        c16 = c13 
                        c13 = c12 
                      end 
                    end 
                  end 
                end 
              end 
            repeat 
            if c16 > 0 
              nspace(c16,7) = 1 
            end 
          end 

          if c16 > 0           /* note pair found 
            if nspace(c16,3) > nspace(c16+1,3) 
              if c16 > 1 and nspace(c16-1,2) > nspace(c16,2) and nspace(c16,6) < nspace(c16,5)
                --nspace(c16,3) 
                ++nspace(c16-1,3) 
                ++nspace(c16,6) 
              else 
                --nspace(c16,3) 
                ++nspace(c16+1,3) 
                --nspace(c16+1,6) 
              end 
            else 
              ++nspace(c16,3) 
              --nspace(c16+1,3) 
              ++nspace(c16+1,6) 
            end 
            goto NXPAIR 
          end 

          loop for c13 = 1 to c12 - 1 
            if nspace(c13,3) <> 0 and nspace(c13+1,3) <> 0   /* this condition added &dA04/10/05
              if nspace(c13,2) > nspace(c13+1,2) 
                if nspace(c13,3) < nspace(c13+1,3) 
                  if nspace(c13+1,6) < nspace(c13+1,5) or (nspace(c13+1,4) = 3 and nspace(c13+1,6) < 6)
                    ++nspace(c13,3) 
                    --nspace(c13+1,3) 
                    ++nspace(c13+1,6) 
                    goto NXPAIR 
                  end 
                end 
              end 
              if nspace(c13,2) < nspace(c13+1,2) 
                if nspace(c13,3) > nspace(c13+1,3) 
                  if abs(nspace(c13+1,6)) < (nspace(c13+1,5) + 1 >> 1) 
                    --nspace(c13,3) 
                    ++nspace(c13+1,3) 
                    --nspace(c13+1,6) 
                    goto NXPAIR 
                  end 
                end 
              end 
            end 
          repeat 
          c12 = 0 
          loop for a1 = oldsct+1 to sct 
            nodtype = ts(a1,TYPE) 
            if nodtype = NOTE or nodtype = REST 
              a8 = ts(a1,TEXT_INDEX) 
              temp2 = trm(tsdata(a8)) 
              ++c12 
              ts(a1,SPACING) = nspace(c12,3) 
              if temp2 con "$$$$" 
                c13 = nspace(c12,5) + nspace(c12,6) 
                temp2 = temp2{1,mpt+3} // chs(c13) // "," // chs(nspace(c12,5))
                tsdata(a8) = trm(temp2) 
              end 
            end 
          repeat 

        end 
&dA     &d@  End of &dA12/09/03&d@ addition 

&dA 
&dA &d@    If there is more that one pass in this measure, one of the 
&dA &d@    things we need to know is the number of passes per staff.  
&dA &d@    If this number is greater than one for a particular staff, 
&dA &d@    then we are going to need to know (1) whether ties have tips 
&dA &d@    up or down for each pass, and (2) whether slurs should connect 
&dA &d@    to note heads or to stems.  
&dA 
&dA &d@    I propose the following rule:  If there is more than one track 
&dA &d@    on a particular staff and if stem directions are consistant 
&dA &d@    for each track on that particular staff, then 
&dA 
&dA &d@      (1) tie tips will always go the opposite direction of the 
&dA &d@            stem direction 
&dA &d@      (2) slurs should connect to stems rather than to note heads 
&dA 
&dA &d@    Before beginning the processing loop, I need to determine the 
&dA &d@    situation, since it is dependent on what happens in the entire 
&dA &d@    measure.  I propose (6-4-93) to add a new element to the ts(.) 
&dA &d@    array, in this case, element 29 = MULTI_TRACK flag.  The meaning 
&dA &d@    of this flag will be as follows: 
&dA 
&dA &d@        0 = this note lies on a staff that has notes from only one 
&dA &d@              pass.  
&dA 
&dA &d@              In this situation, mcat can be 0, 1 or 2              
&dA 
&dA &d@              (1) mcat = 0 or mcat = 1.   Any tie or slur 
&dA &d@              starting or ending on this note will follow the 
&dA &d@              rules for a single part on a staff.  
&dA 
&dA &d@              (2) mcat = 2   There is only one pass, but notes 
&dA &d@              will occur in chords.  In this case, slurs and 
&dA &d@              articulations will mainly fall on the note head at 
&dA &d@              the end of the stem.  In the case where both stem 
&dA &d@              directions are involved, slurs are generally put 
&dA &d@              above the notes (tips down) 
&dA 
&dA 
&dA &d@        1 = this note belongs to one of multiple passes on this 
&dA &d@              staff and all notes on this pass have stems which 
&dA &d@              point up.  
&dA 
&dA &d@              In this situation, mcat can be either 0 or 3, depending 
&dA &d@              on the value of vflag.  Whatever the case, slurs 
&dA &d@              will go above the notes (tips down).  
&dA 
&dA 
&dA &d@        2 = this note belongs to one of multiple passes on this 
&dA &d@              staff and all notes on this pass have stems which 
&dA &d@              point down.  
&dA 
&dA &d@              In this situation, mcat can be either 0 or 3, depending 
&dA &d@              on the value of vflag.  Whatever the case, slurs 
&dA &d@              will go below the notes (tips up).  
&dA 
&dA &d@        3 = this note belongs to one of multiple passes on this 
&dA &d@              staff and the stem directions for the note of at least 
&dA &d@              one of these passes on this staff are inconsistant 
&dA &d@              (both up and down).  
&dA 
&dA &d@              In this situation, mcat can be either 0 or 3, depending 
&dA &d@              on the value of vflag.  In either case, the placement of 
&dA &d@              slurs cannot be inferred from this parameter.  The note 
&dA &d@              in question might belong to a track that is "well behaved", 
&dA &d@              i.e., not the "rogue track".  In this case, determining 
&dA &d@              the type and placement of the slur will be straight- 
&dA &d@              forward.  In the case where mcat = 0 (i.e. vflag = 1), 
&dA &d@              it is likely that the rules for a single part may work 
&dA &d@              fairly well.  In the case where mcat = 3 (i.e. vflag > 1), 
&dA &d@              a number of difficult situations can arrise, such as a 
&dA &d@              slur from a stem-up chord note (pass one) to a stem down 
&dA &d@              note (pass two).  Such situation will have to be handled 
&dA &d@              in a way that seems best under the particular circumstances.  
&dA 
&dA 
&dA &d@    The MULTI_TRACK parameter will actually be combination of the 
&dA &d@    multi-track flag and the value of mcat, according to the 
&dA &d@    formula below: 
&dA 
&dA &d@        ts(.,MULTI_TRACK) = multi-track << 2 + mcat 
&dA 

        loop for a2 = 1 to 3             
          loop for a3 = 1 to passnum         /* assume passnum = total # of passes
            loop for a4 = 1 to MAX_STAFF 
              multichk(a2,a3,a4) = 0 
            repeat 
          repeat 
        repeat 
        loop for a1 = oldsct+1 to sct 
          nodtype = ts(a1,TYPE) 
          if nodtype <= NOTE_OR_REST 
            a2 = nodtype + 2 / 3 
            a3 = ts(a1,PASSNUM) 
            a4 = ts(a1,STAFF_NUM) + 1        /* staff number 
            a6 = multichk(a2,a3,a4) 
            if rem <> 2 
              a5 = bit(1,ts(a1,STEM_FLAGS)) + 1 
              if a6 = 0 or a6 = 4 
                multichk(a2,a3,a4) = a5 
              else 
                if a6 <> a5 
                  multichk(a2,a3,a4) = 3 
                end 
              end 
            else 
              if a6 = 0 
                multichk(a2,a3,a4) = 4        /* rest (stem direction unspecified)
              end 
            end 
          end 
        repeat 

        loop for a2 = 1 to 3               /* loop through note types i.e. reg,cue,grace
          loop for a4 = 1 to MAX_STAFF 
            a5 = 0 
            a6 = 0 
            loop for a3 = 1 to passnum 
              a7 = multichk(a2,a3,a4) 
              if a7 = 3                    /* Case: multiple stem directions 
                a6 = 100 
              end 
              if a7 > 0 
                ++a5 
                if a7 = 4 
                  a8 = a3 + 1 / 2               /* set multichk to 1 for odd passnums, 2 for even
                  multichk(a2,a3,a4) = rem + 1  /*   for parts with only rests 
                end 
              end 
            repeat 
            if a6 = 100 and a5 > 1         /* Case: mult passes on staff and ambiguous stem dirs
              loop for a3 = 1 to passnum 
                multichk(a2,a3,a4) = 3     /* all notes (for this type) on this staff have mt = 3
              repeat 
            end 
            if a5 = 1                      /* Case: single pass on this staff (for this note type)
              loop for a3 = 1 to passnum 
                multichk(a2,a3,a4) = 0     /* all notes (for this type) on this staff have mt = 0
              repeat 
            end 
          repeat 
        repeat 

        loop for a1 = oldsct+1 to sct 
          nodtype = ts(a1,TYPE) 
          if nodtype <= NOTE_OR_REST 
            a2 = nodtype + 2 / 3 
            a3 = ts(a1,PASSNUM) 
            a4 = ts(a1,STAFF_NUM) + 1      /* staff number 
            a5 = multichk(a2,a3,a4) << 2 
            ts(a1,MULTI_TRACK) = a5 + mcat 
          end 
        repeat 
        if oldsct = 0 
          firstsp = tfirstsp 
        else 
&dA 
&dA &d@     Include tfirstsp in the spacing after previous completed bar 
&dA 
          if ts(oldsct,TYPE) <> BAR_LINE 
            ts(oldsct,SPACING) += tfirstsp 
          else 
            ts(oldsct,SPACING) += tfirstsp 
          end 
        end 
&dA 
&dA &d@     Compute the spn (spacing) parameter 
&dA 
        loop for a1 = oldsct+1 to sct   
          if ts(a1,TYPE) = DIV_CHG and qflag = 1 
            qflag = 2 
          end  
          if qflag = 0 
            a5 = totdiv - 1  
            a4 = ts(a1,DIV) - 1   
            if a5 = a4 
              spn = 6913 
            else 
              spn = 6912 / a5 * a4 + 1   
            end  
          else   
            if qflag = 1   
              a5 = mdiv - 1  
              a4 = ts(a1,DIV) - 1 
              if a5 = a4 
                spn = 3457                                           
              else 
                spn = 3456 / a5 * a4 + 1 
              end  
            else 
              a5 = totdiv - mdiv 
              a4 = ts(a1,DIV) - mdiv  
              if a5 = a4 
                spn = 6913 
              else 
                spn = 3456 / a5 * a4 + 3457  
              end  
            end  
          end  
          ts(a1,SPN_NUM) = spn 
        repeat 
&dA 
&dA &d@     We have a choice at this point whether to do extra calculations on 
&dA &d@     the placement of notes, note-dots, and note-accidentals, or to wait 
&dA &d@     to do this until the point when we process the entire array.  I think 
&dA &d@     now is a good time to do this, because (1) I prefer to do work I think 
&dA &d@     I know how to do earlier rather than later (you never know just what 
&dA &d@     kinds of tasks you may have to do later, so why not get this one out 
&dA &d@     of the way), and (2) the information gained in the this process might 
&dA &d@     help us in the placement of slurs (which we will need to do first 
&dA &d@     thing when we begin processing the entire array).  
&dA 
&dA &d@     Basically we are going to try to compute the following information for 
&dA &d@     each "musical node".  The definition of a "musical node" is the set of 
&dA &d@     one or more objects (chords + dots + accidentals) occuring on the same 
&dA &d@     division number and &dAwhich would, if possible, be placed in the same&d@ 
&dA &d@     &dAx-position on the staff&d@.  
&dA 
&dA &d@       (1) the global x-offset.  This is the amount by which each &dAobject&d@ 
&dA &d@             is displaced from the 0 x-position of all objects on this 
&dA &d@             musical node.  I believe the global x-offset is always >= 0.  
&dA &d@                                   
&dA &d@       (2) the local x-offset for note heads.  This is the amount by which 
&dA &d@             each note head of a particular object is displaced from the 
&dA &d@             x position of the object.  
&dA 
&dA &d@       (3) the location of rests on the staff (based on the position of 
&dA &d@             other objects at this location).  
&dA 
&dA &d@       (4) the x and y offsets for any dot(s) which might follow each 
&dA &d@             note head of a particular object. &dA Note: the y-position of 
&dA &d@             &dAan object which has more than one note head (chord) is     
&dA &d@             &dAthe y position of the note head furthest from the note-end 
&dA &d@             &dAof the stem (i.e., therefore nearest to the beam end of    
&dA &d@             &dAthe stem, if there is a beam).     
&dA 
&dA &d@       (5) the x offset (as measured to the left) of any accidental(s) 
&dA &d@             which might precede each note head.  
&dA 
&dA 
&dA &d@     I. How to store this information.  
&dA 
&dA &d@     (0) The grouping of elements in the ts(.,.) array into "musical 
&dA &d@         nodes" can be determined by the space parameter "&dLSPACING&d@".  
&dA &d@         The first array element of a "musical node" will have a 
&dA &d@         non-zero space parameter, and any other element in the node 
&dA &d@         will have a space parameter = 0.  
&dA 
&dA &d@     (1) The global x-offset can be stored in the GLOBAL_XOFF element 
&dA &d@         of the ts(.,.) array.  If we further specify that the GLOBAL_XOFF 
&dA &d@         element will be set to INT10000 * a1 (index of first note in the 
&dA &d@         chord) + a2 (index of last note in chord), this will give us an 
&dA &d@         easy way to determine the number of array elements (note heads) 
&dA &d@         in the object (chord).  
&dA 
&dA &d@     (2) The local x-offset for note heads can be stored in the 
&dA &d@         LOCAL_XOFF element of the ts(.,.) array.  
&dA 
&dA &d@     (3) The location of rests on the staff can be stored in the 
&dA &d@         STAFFLOC element of the ts(.,.) array.  
&dA 
&dA &d@     (4) For the x and y offsets for any dots(s), we can use the DOT    (modified &dA12-24-96&d@)
&dA &d@         element of the ts(.,.) array.  Up to this point, the DOT element 
&dA &d@         could have five values: 0 = no dot; 1 = single dot; 3 = double dot;
&dA &d@         7 = triple dot; 15 = quadruple dot.  We need to preserve this          
&dA &d@         information, which uses bits 0 through 3 of the integer.  Since 
&dA &d@         the x offset is always positive, and the y offset may be positive 
&dA &d@         or negative, we can construct a number which is x * INT10000 + y, 
&dA &d@         shift it over 4 and &dAOR&d@ it with the current value of DOT.  
&dA 
&dA &d@     (5) For the x offset of any accidental(s), we can use the AX 
&dA &d@         element of the ts(.,.) array.  Up to this point, the AX element 
&dA &d@         could have sixteen values: 0 to 15.  There is also the "silent" 
&dA &d@         flag in bit 4 (value 16) which we need to preserve.  Altogether  (added &dA02/25/97&d@)
&dA &d@         we need to preserve bits 0 through 4 of the integer.  Since 
&dA &d@         the x offset (measured to the left) is always positive, we can 
&dA &d@         simply shift this offset over 8 and &dAOR&d@ with the current value 
&dA &d@         of AX.  
&dA 
&dA &d@    II. Method of computation.  
&dA 
&dA &d@         The first task will be to compute the global and local x-offset 
&dA &d@         for the note heads in each musical node.  We have a way of doing 
&dA &d@         this, which we call pseudo-typesetting.  A concurrent task will 
&dA &d@         be to compute the y location of rests in each musical node.  
&dA 
&dA &d@         The second task will be to compute the x and y offsets for any 
&dA &d@         dots(s).  The method will be as follows (for each staff): 
&dA 
&dA &d@           (1) If there is only one note head on the staff, use the 
&dA &d@               single note method for determining dot position.  
&dA 
&dA &d@               Otherwise, determine the x position for a "row of dots".  
&dA &d@               This position will be to the right of the right-most 
&dA &d@               note head on the stave.  (Note that the x-offset for 
&dA &d@               each dot is the x position minus the global x-offset 
&dA &d@               for each object).  
&dA 
&dA &d@           (2) Starting with the left-most objects in the "musical node" 
&dA &d@               and moving to the right, set dot positions according to 
&dA &d@               the following algorithm (keeping track of all previous 
&dA &d@               dots for this stave): 
&dA 
&dA &d@                  Start with the note head furtherest from note-end of stem 
&dA &d@                  If note on line, 
&dA &d@                    if space above is free, put dot there 
&dA &d@                    else put dot in first free space below 
&dA &d@                  else 
&dA &d@                    if space is free, put dot there 
&dA &d@                    else put dot in first free space in reverse direction 
&dA &d@                  end 
&dA 
&dA &d@         The third task will be to compute the x offsets for any 
&dA &d@         accidental(s) for each note head.  The method will be as 
&dA &d@         follows (for each staff): 
&dA 
&dA &d@           (1) Check the left-hand border from the typesetting operation. 
&dA &d@               If there are any accidentals that could be set on right- 
&dA &d@               shifted note heads, set these first, starting from the 
&dA &d@               top down.  This defines column 1 of the accidentals.  
&dA 
&dA &d@               Otherwise, column one is the first free location to the 
&dA &d@               left of the left-most note head.  
&dA 
&dA &d@           (2) For all remaining accidentals to set, start at the top 
&dA &d@               of the group.  Make successive passes until all accidentals 
&dA &d@               are set.  
&dA 
&dA &d@               (a) moving down, put in as many accidentals as possible 
&dA &d@                   where the distance between eligible notes (delta) >= 
&dA &d@                   vpar(6), with the caviat that you do not put an 
&dA &d@                   accidental on the lower half of a second before the 
&dA &d@                   upper half of a second (as you move down).  
&dA 
&dA &d@               (b) move to the left by the largest thickness of accidentals 
&dA &d@                   just placed.  Decide on the direction to move for the 
&dA &d@                   next pass and goto (a).  The new direction will be 
&dA &d@                   down (again) if the previous pass hit the lowest remaining 
&dA &d@                   accidental; otherwise, the new direction will be up.  
&dA 
&dA 
&dA &d@         Good Luck with all of this!  If you get it right, you will have 
&dA &d@         accomplished a good deal of the task of setting simultaneous 
&dA &d@         notes!  
&dA 
&dA &d@         &dA3-23-94&d@: 
&dA 
&dA &d@         I am going to add another element to this process.  It turns out that
&dA &d@         this is the best time to determine whatever extra space is required 
&dA &d@         for each object, based on the items previously typeset.  (We had been
&dA &d@         doing this later, but without the detailed information available in this
&dA &d@         part of the process, i.e. global-right boundaries, etc.).  
&dA 
&dA &d@         We start with the fact that the process below begins either after the
&dA &d@         initial setting of the clef, key and time, or after a controlling bar
&dA &d@         line.  In either case, we know the profile of "emptyspace" relative 
&dA &d@         to the position we are about to put something.  
&dA 
&dA &d@         After processing each object, we need to be sure two things are done.
&dA 
&dA &d@         (1) If there will be a need to shift the position of a node, the 
&dA &d@         value of this shift (positive or negative) needs to be stored in the 
&dA &d@         array element: NODE_SHIFT.  
&dA 
&dA &d@         (2) The values of emptyspace need to be updated.  
&dA 
        olda1 = 0      

        loop for a1 = oldsct+1 to sct   
          nodtype = ts(a1,TYPE)  
          if nodtype > NOTE_OR_REST 
&dA 
&dA &d@       A. Figure out space for Bar Line 
&dA 
            if nodtype = BAR_LINE 
              a5 = 1000000 
              loop for a3 = 1 to MAX_STAFF 
                loop for a4 = 1 to 45 
                  if emptyspace(a3,a4) < a5 
                    a5 = emptyspace(a3,a4) 
                  end 
                repeat 
              repeat 
              a6 = mindist - hpar(82) - a5 
&dA &d@   Task (1) 
              if a6 > 0 
                ts(a1,NODE_SHIFT) = a6 
              end 
&dA &d@   Task (2) 
              a5 = ts(a1,SPACING) - hpar(93) 
              loop for a4 = 1 to MAX_STAFF 
                loop for a3 = 1 to 45 
                  emptyspace(a4,a3) = a5 
                repeat 
              repeat 
              goto WWWW 
            end 
&dA 
&dA &d@       B. Figure out space for Clef change
&dA 
            if nodtype = CLEF_CHG 
              a3 = ts(a1,STAFF_NUM) + 1         /* staff number 
&dA 
&dA &d@      Check to see if we can "backup" the node position        
&dA 
              a5 = 1000000 
              loop for a4 = 1 to 45 
                if emptyspace(a3,a4) < a5 
                  a5 = emptyspace(a3,a4)        /* minimum emptyspace on this staff
                end 
              repeat 
&dA &d@   Task (1) 
              if a5 > ts(a1,SPACING) >> 1 
                a4 = a5 * 2 / 3 
                a7 = ts(a1,SPACING) 
                c2 = 0 
                loop for c1 = a1+1 to sct          /* check if following note has accidentals
                  if ts(c1,DIV) <> ts(a1,DIV) 
                    goto HJKO 
                  end 
                  a6 = ts(c1,TYPE) 
                  if a6 > FIGURES 
                    goto HJKO 
                  end 
                  if a6 <> REST and a6 <> CUE_REST and a6 <> FIGURES 
                    if ts(c1,STAFF_NUM) = ts(a1,STAFF_NUM) 
                      a6 = ts(c1,AX) & 0x1f 
                      if a6 < 0x10 and a6 > 0 and hpar(a6) > c2   /* Code modified &dA02/25/97
                        c2 = hpar(a6) 
                      end 
                    end   
                  end 
                repeat 
HJKO: 
                a7 += c2 
                if a4 > a7
                  a4 = a7
                end 
                ts(a1,NODE_SHIFT) = 0 - a4    /* negative shift 
              else 
                a6 = mindist - hpar(82) - a5 
                if a6 > 0 
                  ts(a1,NODE_SHIFT) = a6 
                end 
              end 
&dA &d@   Task (2) 
              a5 = ts(a1,SPACING) - a4          /* amount by position really advanced
              a7 = hpar(86) 
              if z > 128 
                a7 = a7 * 7 / 10                /* use to be 8 / 10 
              end 
              a7 = ts(a1,SPACING) - a7          /* empty space after clef sign 
              loop for a4 = 1 to MAX_STAFF 
                if a4 = a3 
                  loop for a6 = 1 to 45 
                    emptyspace(a4,a6) = a7 
                  repeat 
                else 
                  loop for a6 = 1 to 45 
                    emptyspace(a4,a6) += a5 
                  repeat 
                end 
              repeat 
              goto WWWW 
            end 
&dA 
&dA &d@       C. Figure out space for Time change
&dA 
            if nodtype = METER_CHG 
              a5 = 1000000 
              loop for a3 = 1 to MAX_STAFF 
                loop for a4 = 1 to 45 
                  if emptyspace(a3,a4) < a5 
                    a5 = emptyspace(a3,a4) 
                  end 
                repeat 
              repeat 
              a6 = hpar(12) - a5 
&dA &d@   Task (1) 
              if a6 > 0 
                ts(a1,NODE_SHIFT) = a6 
              end 
&dA &d@   Task (2) 
              loop for a4 = 1 to MAX_STAFF 
                loop for a3 = 1 to 45 
                  emptyspace(a4,a3) = min_space            /* replaces hpar(29)   &dA11/19/07
                repeat 
              repeat 
              goto WWWW 
            end 
&dA 
&dA &d@       D. Figure out space for Key change 
&dA 
            if nodtype = AX_CHG 
              a5 = 1000000 
              loop for a3 = 1 to MAX_STAFF 
                loop for a4 = 1 to 45 
                  if emptyspace(a3,a4) < a5 
                    a5 = emptyspace(a3,a4) 
                  end 
                repeat 
              repeat 
              a6 = hpar(37) - hpar(93) - a5 
&dA &d@   Task (1) 
              if a6 > 0 
                ts(a1,NODE_SHIFT) = a6 
              end 
&dA &d@   Task (2) 
              loop for a4 = 1 to MAX_STAFF 
                loop for a3 = 1 to 45 
                  emptyspace(a4,a3) = hpar(12) 
                repeat 
              repeat 
              goto WWWW 
            end 
&dA 
&dA &d@       E. Figure out space for Signs, Words and Marks which are Objects 
&dA &d@                    
            if nodtype = SIGN or nodtype = WORDS or nodtype = MARK 
              ts(a1,NODE_SHIFT) = 0  
              goto WWWW 
            end 
&dA 
&dA &d@       F. Figure out space for Figures 
&dA &d@                    
            if nodtype = FIGURES 
              c3  = FIG_DATA 
              c11 = 0 
              c14 = 0                         /* Flag for preceding accidentals on figures
              loop for c2 = 1 to ts(a1,NUMBER_OF_FIG) 
                c12 = 0 
&dA 
&dA &d@    Code added &dA11/16/03&d@ to deal with parentheses around figures 
&dA 
                c6 = ts(a1,c3) 
                c13 = 0                       /* Flag for parentheses around figures
                if c6 > 1000 
                  c6 -= 1000 
                  if c6 > 1000                /* large parentheses 
                    c6 = c6 / 1000 
                    c6 = rem 
                    c13 = hpar(138) + hpar(139) 
                  else                        /* small parentheses 
                    c13 = hpar(136) + hpar(137) 
                  end 
                end 
&dA   

&dA 
&dA &d@    And this code rewritten &dA11/16/03&d@ 
&dA 
                if c6 > 0 
                  temp = chr(c6+28) 
                  if "1389" con temp          /* case: accidental x,#,f,n 
                    c4 = ts(a1,c3+1) 
                    if c4 > 0                 /* sub-case: accidental followed by figure
                      c14 = hpar(c4+47)       /* result: set flag for preceding accidental
                      if c4 < 20                    /* figure 
                        if c4 < 10 
                          c12 = hpar(66) 
                        else 
                          c12 = hpar(66) << 1 
                        end 
                      else 
                        c12 = hpar(c4+67) 
                      end 
                    else 
                      c12 = hpar(c6+47)       /* 20 <= c6 <= 30 --> hpar(67) to hpar(77)
                    end 
                  else 
                    if c6 < 20                /* case: figure 
                      if c6 < 10 
                        c12 = hpar(66) 
                      else 
                        c12 = hpar(66) << 1 
                      end 
                      c4 = ts(a1,c3+1) 
                      if c4 > 0               /* accidental following number
                        temp = chr(c4+28) 
                        if "01389" con temp 
                          c12 += hpar(c4+47) 
                        end 
                      end 
                    else                      /* cases: isolated +,2+,4+,5+,6\,7\,-
                      c12 += hpar(c6+47) 
                    end 
                  end 
                end 
&dA   
                c12 += c13                    /* Adding space for parentheses &dA11/16/03
                if c12 > c11 
                  c11 = c12 
                end 
                c3 += 3 
              repeat 

              c11 += c14                      /* Adding space for pre-accidentals &dA11/16/03
              c11 += hpar(75)                 /* free space = width of natural 

              if ts(a1,MIN_FIG_SPAC) < c11 
                ts(a1,MIN_FIG_SPAC) = c11 
              end 
              if ts(a1,FIG_SPACE) > 0 and ts(a1,FIG_SPACE) < c11 
                ts(a1,FIG_SPACE) = c11 
              end 
              a4 = ts(a1,FIG_SPACE) 
              ts(a1,NODE_SHIFT) = 0  
              if a4 > 0 
                loop for a3 = 1 to MAX_STAFF 
                  loop for a2 = 1 to 45 
                    emptyspace(a3,a2) += a4 
                  repeat 
                repeat 
              end 
              goto WWWW 
            end 
            goto WWWW 
          end 
&dA 
&dA &d@    &dA PROCESSING NOTES AND RESTS NOW 
&dA 
          npasses = 1 
          a3 = 1 
          if a1 = sct              /* added &dA01-31-97&d@ 
            a2 = a1 
            pitchcnt(1) = 1 
            goto X1 
          end 
          loop for a2 = a1+1 to sct  
            if ts(a2,SPACING) <> 0 
              --a2 
              pitchcnt(npasses) = a3 
              goto X1 
            end 
            if ts(a2,TYPE) > NOTE_OR_REST 
              --a2 
              pitchcnt(npasses) = a3 
              goto X1 
            end 
            if nodtype = GR_NOTE
              if ts(a2,TYPE) = XGR_NOTE 
                ++a3 
              else 
                pitchcnt(npasses) = a3 
                a3 = 1 
                ++npasses 
              end 
            else 
              if ts(a2,TYPE) = XNOTE or ts(a2,TYPE) = XCUE_NOTE 
                ++a3 
              else 
                pitchcnt(npasses) = a3 
                a3 = 1 
                ++npasses 
              end 
            end 
          repeat 
X1:  
&dA 
&dA &d@    a2          = index to last element in node 
&dA &d@    npasses     = number of passes 
&dA &d@    pitchcnt(.) = size of chord for each pass
&dA 
&dA &d@         if a1 = a2     /* Simple (and most common) case:  single element, a2 = a1
&dA 
          if ts(a1,MULTI_TRACK) < 4 and a1 = a2 

            a3 = ts(a1,STAFF_NUM) + 1         /* staff number 
            c1 = a1  
            passnum = ts(c1,PASSNUM) 
            ntype = ts(c1,NTYPE) & 0xff           /* new &dA10/15/07&d@ 
            stem = bit(1,ts(c1,STEM_FLAGS)) 
            if nodtype <= REST
              passtype = REG          
              passsize = FULLSIZE 
              if bit(16,ts(c1,SUBFLAG_1)) = 1 
                passsize = CUESIZE                /* EXPERIMENT  &dA06-24-94&d@ 
              end 
            else
              passsize = CUESIZE 
              if nodtype <= CUE_REST
                passtype = CUE
              else
                passtype = GRACE
              end
            end
&dA 
&dA &d@     a) rests 
&dA 
            if nodtype = REST or nodtype = CUE_REST
              if nodtype = REST 
                c8 = vpar(4) 
              else 
                c8 = vpar(2) 
              end 
              if ts(c1,STAFFLOC) = 1 
                c8 = vpar(4) 
              end 
              ts(c1,STAFFLOC) = c8 
              ts(c1,OBY) = c8
              if ts(c1,DOT) > 0 
                c4 = 0            /* additions to "eighth rest" 
                c2 = 0            /* y shift down for starting rests 
                c6 = 0            /* extra height of dot  (negative shift) 
                if ntype <= SIXTEENTH 
                  c6 = notesize 
                  c4 = EIGHTH - ntype 
                  c2 = notesize 
                  if ntype < THIRTY_SECOND 
                    c2 = THIRTY_SECOND - ntype * notesize + c2 
                  end 
                end 
                if ntype > QUARTER 
                  c3 = hpar(30) 
                else 
                  c3 = c4 * hpar(54) + hpar(31) 
                  c6 *= c4 
                end 
                if passsize = CUESIZE 
                  c3 = c3 * 8 / 10 
                end 
                c7 = c3 
&dA 
&dA &d@    Minor code modification &dA04/19/08&d@ 
&dA 
                if ntype <= SIXTEENTH 
                  c3 -= hpar(54) 
                end 
&dA    
                c6 += vpar(1) /* shift to space   OK 4-21-95 
             /* c3 is the x shift to the dot(s) 
                c2 -= c6      /* final y offset 
                c9 = c2 
             /* x * INT10000 + y, shift it over 4 and &dAOR&d@ it with DOT   (code modified &dA12-24-96&d@)
                c3 *= INT10000 
                c3 += c2 
                c3 <<= 4                                         /*    (code modified &dA12-24-96&d@)
                ts(c1,DOT) |= c3  
              else 
                c7 = 0 
                c9 = 0 
              end 
&dA &d@   Task (1) 
              a5 = 1000000 
              loop for a4 = 1 to 45 
                if emptyspace(a3,a4) < a5 
                  a5 = emptyspace(a3,a4)        /* minimum emptyspace on this staff
                end 
              repeat 

              a6 = mindist - hpar(82) - a5 
              if a6 > 0 
                ts(a1,NODE_SHIFT) = a6 
              end 
&dA &d@   Task (2) 
              loop for a6 = 1 to 45 
                gr(a3,a6) = -200 
              repeat 

              if ts(c1,CLAVE) < 200
                perform rest_occupy_space (c8,a3)     /* ntype is read directly
              end 

              if ts(c1,DOT) > 0 
                c8 += c9 
                if c8 >= 0 
                  c8 = 2 * c8 + 1 / vpar(2) 
                else 
                  c8 = 2 * c8 - 1 / vpar(2) 
                end 
                c8 = 23 - c8 
                c7 += hpar(80) 
                if ts(c1,DOT) & 0x0e > 0            /* code modified &dA12-24-96
                  if ts(c1,DOT) & 0x02 > 0 
                    c7 += hpar(91)                    /* extra shift to second dot
                  end 
                  if ts(c1,DOT) & 0x04 > 0 
                    c7 += hpar(91)                    /* extra shift to third dot
                  end 
                  if ts(c1,DOT) & 0x08 > 0 
                    c7 += hpar(91)                    /* extra shift to fourth dot
                  end 
                end 
                loop for a6 = c8 - 1 to c8 + 1 
                  gr(a3,a6) += c7  
                repeat 
              end 
              c10 = ts(c1,SPACING) 
              loop for c11 = 1 to MAX_STAFF 
                if c11 = a3 
                  loop for c6 = 1 to 45 
                    if gr(c11,c6) = -200 
                      emptyspace(c11,c6) += c10 
                    else 
                      emptyspace(c11,c6) = c10 - gr(c11,c6) 
                    end 
                  repeat 
                else 
                  loop for c6 = 1 to 45 
                    emptyspace(c11,c6) += c10 
                  repeat 
                end 
              repeat 
            else 
&dA 
&dA &d@     b) notes 
&dA 
              repeater_case      = 0 
              ts(c1,LOCAL_XOFF)  = 0 
              ts(c1,GLOBAL_XOFF) = 0 
&dA 
&dA &d@  Technically, this code must also appear here, although it is highly unlikely 
&dA &d@  that anyone would want to shift a single note on a stave from its primary position.
&dA 
&dA &d@                              All New code &dA05/02/03&d@ 
&dA 
&dA &d@       At this point, we need to see if the note object position has been modified
&dA &d@       "absolutely" by a print suggestion.  If this is the case, we need to make the
&dA &d@       adjustment here, AND, elimate the suggestion from the tsr string.  
&dA 
              c6 = ts(c1,TSR_POINT) 
              c7 = ors(tsr(c6){2}) 
              if bit(0,c7) = 1 
                px = ors(tsr(c6){3}) 
                if px > 0 
                  px = px - 128 * notesize / 10 
                  pxx = c7 & 0x02 >> 1 
                  if pxx = 1 
                    ts(c1,GLOBAL_XOFF) = px 
                    tsr(c6){3} = chr(0)         /* here is where suggestion is zerod out
                  end 
                end 
              end 
&dA 
&dA &d@       End of new code &dA05/02/03&d@ 
&dA 
              c6 = ts(c1,STAFFLOC) + vpar20 * 2 + 1 / vpar(2) - 20 

              if ts(c1,DOT) > 0 
                if (ts(c1,SUBFLAG_1) & 0x8000) = 0   /* modern notation 
                  if ntype > HALF 
                    c3 = hpar(32) 
                  else 
                    c3 = hpar(33) 
                  end 
                else                                 /* New &dA01/08/11&d@ 
                  if ntype > WHOLE 
                    c3 = vpar(2) * 5 / 2 
                  else 
                    if ntype > HALF 
                      c3 = vpar(2) * 9 / 5 
                    else 
                      c3 = vpar(2) * 3 / 2 
                    end 
                  end 
                end 
                c10 = ts(c1,STAFFLOC) / notesize 
                c10 = rem                 /* c10 = 0 means note on line 
                if stem = UP and bit(15,ts(c1,SUBFLAG_1)) = 0 /* modern only
                  if ts(c1,BEAM_FLAG) = NO_BEAM and ts(c1,NTYPE) < QUARTER 
                    c3 += hpar(27) 
                    if c10 <> 0
                      c3 -= hpar(34) 
                    end 
                  end 
                end 
&dA 
&dA &d@    if dot is on staff line, c10 = 0     
&dA 
                if c10 = 0 
                  c2 = 0 - vpar(12) 
           /* lower dot if more than one track and stem is down 
                  if bit(3,ts(c1,MULTI_TRACK)) = 1 
                    if stem = DOWN 
                      c2 = vpar(12) 
                    end 
                  end 
                  c3 -= hpar(34) 
                else 
                  c2 = 0 
                end 
                if passsize = CUESIZE 
                  c3 = c3 * 8 / 10 
                end 
             /* c3 = x shift 
             /* c2 = y offset 

             /* x * INT10000 + y, shift it over 2 and &dAOR&d@ it with DOT   (code modified &dA12-24-96&d@)
                c7 = c3 
                c8 = c2 
                c3 *= INT10000 
                c3 += c2 
                c3 <<= 4                                            /*  code modified &dA12-24-96
                ts(c1,DOT) |= c3  
              end 

&dA &d@   Task (1) 
              loop for c10 = 1 to 45 
                gl(a3,c10) = 200 
                pseudo_gl(a3,c10) = 200 
                gr(a3,c10) = -200 
              repeat 
              c6 = 23 - c6 

              if c6 > 45 or c6 < 1 
                tmess = 27 
                perform dtalk (tmess) 
              end 
        /* Determine thickness of note: c11 
              if (ts(c1,SUBFLAG_1) & 0x8000) = 0 
                if ntype <= HALF or ntype = SLASH8 
                  c11 = hpar(82) 
                else 
                  if ntype = WHOLE 
                    c11 = hpar(83) 
                  else 
                    if ntype = BREVE 
                      c11 = hpar(84) 
                    else 
                      if ntype = LONGA 
                        c11 = vpar(2) * 5 / 4 
                      else 
                        c11 = hpar(144) + 3 
                      end 
                    end 
                  end 
                end 
              else                            /* New  &dA01/08/11&d@ 
                if ntype <= HALF
                  c11 = vpar(2) 
                else 
                  if ntype <= LONGA 
                    c11 = vpar(2) * 5 / 4 
                  else 
                    c11 = hpar(144) + 3 
                  end 
                end 
              end 

              if passsize = CUESIZE 
                c11 = c11 * 8 / 10 
              end 
        /* Put in limits of note head 
              gl(a3,c6+1) = hpar(95) 
              pseudo_gl(a3,c6+1) = 0
              gl(a3,c6)   = 0 
              gr(a3,c6+1) = c11  
              gr(a3,c6)   = c11 - hpar(95) 

              if ntype < WHOLE 
        /* Determine length of stem: c10 
                if ntype > EIGHTH 
                  c10 = 8                          /* length of stem 
                else 
                  c10 = 7 
                  if ntype < EIGHTH 
                    c10 += EIGHTH - ntype
                  end 
                end 
                if passsize = CUESIZE 
                  c10 = c10 * 8 / 10 
                end 
                if ts(c1,BEAM_FLAG) = NO_BEAM and ts(c1,BEAM_CODE) > 0 
                  repeater_case = 1
                  c13 = ts(c1,BEAM_CODE) / 10 
                  loop while c13 > 0 
                    c13 /= 10 
                    c10 += 2 
                  repeat 
                end 
        /* Determine thickness of stem: c12 
                if ts(c1,BEAM_FLAG) = NO_BEAM and ntype < QUARTER 
                  if bit(15,ts(c1,SUBFLAG_1)) = 0 
                    c12 = hpar(26) 
                    if passsize = CUESIZE 
                      c12 = c12 * 8 / 10 
                    end 
                  else                          /* New &dA01/08/11&d@ 
                    c12 = hpar(26) - c11
                  end 
                else 
                  if stem = UP 
                    if bit(15,ts(c1,SUBFLAG_1)) = 0      /* modern notation 
                      c12 = 0 
                    else                                 /* New &dA01/08/11&d@ 
                      c12 = 0 - c11
                    end 
                  else 
                    c12 = hpar(90) 
                  end 
                end 
&dA 
&dA &d@     Put in limits of gl(.,.) and gr(.,.) for stem 
&dA 
&dA &d@     &dA06/04/08&d@  Fixing case where there are no-beam repeaters 
&dA 
                if stem = UP 
                  c13 = c6 + c10 
                  if c13 > 45 
                    c13 = 45 
                  end 
                  gr(a3,c6+1) = c11 + c12 
                                               
                  loop for c14 = c6 + 2 to c6 + 3   /* No repeaters near note head
                    gr(a3,c14) = c11 + c12                  
                    gl(a3,c14) = c11 - hpar(90) 
                  repeat 

                  if repeater_case = 1 
                    c15 = hpar(98) + hpar(90) 
                    if ntype >= QUARTER 
                      c12 += hpar(98) 
                    end 
                  else 
                    c15 = hpar(90) 
                  end 
                  loop for c14 = c6 + 4 to c13      /* &dA06/04/08&d@ changing c6 + 2 to c6 + 4
                    gr(a3,c14) = c11 + c12                  
                    gl(a3,c14) = c11 - c15
                  repeat 
                else 
                  c13 = c6 - c10 
                  if c13 < 1 
                    c13 = 1 
                  end 

                  loop for c14 = c6 - 2 to c6 - 1   /* No repeaters near note head
                    gr(a3,c14) = c12       
                    gl(a3,c14) = 0         
                  repeat 

                  if repeater_case = 1 
                    c11 = hpar(98) 
                  else 
                    c11 = 0 
                  end 
                  loop for c14 = c13 to c6 - 3      /* &dA06/04/08&d@ changing c6 - 1 to c6 - 3
                    gr(a3,c14) = c12       
                    gl(a3,c14) = 0 - c11 
                  repeat 
                end 
              end 
&dA 
&dA &d@          Put in limits of for accidentals 
&dA &d@               and store location of accidental 
&dA 
              if ts(c1,AX) > 0 
                c5 = ts(c1,AX) & 0x0f 
                c7 = passsize 
                perform place_accidental (a3,c6,c5,c7)  /* returns c7 = negative offset
            /* shift the offset over 8 and &dAOR&d@ with AX 
                c7 = 0 - c7                             /* we store positive value
                c7 <<= 8               /* &dA02/25/97&d@ shift changed from 4 to 8
                ts(c1,AX) |= c7               
              end 
&dA 
&dA &d@       Adjust the gr(.,.) array to accommodate space for dots 
&dA &d@           (added &dA04/04/94&d@) 
&dA 
              c8 = ts(a1,STAFF_NUM) + 1                    /* staff number 
              c3 = ts(a1,DOT) 
              if c3 > 0                                    /* code modified &dA12-24-96
                c4 = c3 & 0x0f               /* dot flag   /* &dA12-24-96&d@ 
                c3 >>= 4                                   /* &dA12-24-96&d@ 
                c5 = c3 / INT10000           /* x offset 
                c6 = rem                     /* y offset 
                if c6 > INT10000 >> 1 
                  c6 -= INT10000 
                  ++c5 
                end 
                c6 = c6 + vpar(8) * 2 - 1 / vpar(2) - 7 

                c10 = ts(a1,STAFFLOC) + vpar20 * 2 + 1 / vpar(2) - 20 
                c6 = 23 - c10 - c6 

                c5 += hpar(80) 
                if c4 > 1                                  /* modified &dA12-24-96
                  c5 += hpar(91)                         /* second dot 
                  if c4 > 4 
                    c5 += hpar(91)                         /* third dot 
                  end 
                  if c4 > 8 
                    c5 += hpar(91)                         /* fourth dot 
                  end 
                end 
                if c6 < 46 and c6 > 0 
                  gr(c8,c6) = c5 
                end 
              end 

        /* Calculate NODE_SHIFT 
              c10 = 0
              if c1 = 1 or ts(c1-1,TYPE) < CUE_NOTE 
                c6 = min_space            /* replaces hpar(29)   &dA11/19/07&d@ 
              else 
                c6 = min_space / 2        /* replaces hapr(29) / 2  &dA11/19/07
              end 
              loop for c11 = 1 to 45 
                if gl(a3,c11) > pseudo_gl(a3,c11) 
                  gl(a3,c11) = pseudo_gl(a3,c11) 
                end 
                c12 = c6       - gl(a3,c11) - emptyspace(a3,c11) /* should be negative
                if c12 > c10                                     /* most of the time
                  c10 = c12                     
                end 
              repeat 
              if (ts(c1,AX) & 0x0f) > 0 and ts(c1,SPACING) = mindist and c10 < hpar(94)
                c10 = hpar(94) 
              end 
              if c10 > 0 
                ts(c1,NODE_SHIFT) = c10 
              end 
&dA &d@   Task (2) 
              c10 = ts(c1,SPACING) 
              loop for c11 = 1 to MAX_STAFF 
                if c11 = a3 
                  loop for c6 = 1 to 45 
                    if gr(c11,c6) = -200 
                      emptyspace(c11,c6) += c10 
                    else 
                      emptyspace(c11,c6) = c10 - gr(c11,c6) 
                    end 
                  repeat 
                else 
                  loop for c6 = 1 to 45 
                    emptyspace(c11,c6) += c10 
                  repeat 
                end 
              repeat 
            end 
          else 

&dA &d@ &dAÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»&d@ 
&dA &d@ &dAº&d@                                                                &dAº&d@ 
&dA &d@ &dAº&d@   Here is where you deal with chords and with multiple passes  &dAº&d@ 
&dA &d@ &dAº&d@                                                                &dAº&d@ 
&dA &d@ &dAÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼&d@ 

&dA &d@                       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@                       ³ D I S C U S S I O N  ³ 
&dA &d@                       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
&dA 
&dA &d@       To start with, a major difference between the single note version 
&dA &d@   and this multiple note version is the placement of (1) the note heads 
&dA &d@   in chords and (2) the chord groups, themselves.  The major problem is 
&dA &d@   to determine the x-offset for each note in a chord and the x-offset for 
&dA &d@   each chord group.  Once this information is known, it will then be 
&dA &d@   possible to typeset the various entities in a manner somewhat similar 
&dA &d@   to the case of the single note version above.  
&dA 
&dA &d@       The x placement of all of the elements of a multiple note node 
&dA &d@   requires consideration of all of the elements; i.e., they cannot be 
&dA &d@   simply put down in a serial fashion.  Therefore, we must do a pseudo- 
&dA &d@   typesetting of the elements, and from this extract the x-offsets we 
&dA &d@   need to do the real job.  I note that set array elements 13 and 19 
&dA &d@   are free at this point, so we can use them to store local x-offset and 
&dA &d@   global x-offset, respectively (&dDLOCAL_XOFF&d@, &dDGLOBAL_XOFF&d@).  
&dA 
&dA &d@       Also, the vertical placement of rests must be taken into 
&dA &d@   consideration.  There is no definite parameter in the stage2 source 
&dA &d@   file that tells us were to locate rests vertically.  We have two 
&dA &d@   indirect parameters available: (1) the pass number, based on the 
&dA &d@   the order of encoding the material, and (2) the optional track 
&dA &d@   number.  I would favor using the pass number at this point.  Where 
&dA &d@   the maximum pass number is 2, rests could be located "high" and 
&dA &d@   "low" for passes 1 and 2, respectively; where the maximum pass number 
&dA &d@   is 3, rests could be located "high", "medium" and "low", etc.  In the 
&dA &d@   case of the grand staff (two or more staves), these locations could 
&dA &d@   be refined to reflect the staff on which the rests are being put.  
&dA 
&dA 
&dA &d@  &dA ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ» 
&dA &d@  &dA º &d@                                                   &dA º 
&dA &d@  &dA º &d@          (A) pseudo-typeset the notes             &dA º 
&dA &d@  &dA º &d@                                                   &dA º 
&dA &d@  &dA ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼ 
&dA 

&dA &d@               ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@               ³   construct note data   ³ 
&dA &d@               ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
&dA &d@ 
&dA &d@   ndata(1) = pass number (set to 0, after chord is typeset)
&dA &d@   ndata(2) = stem flag: 
&dA &d@                 bit 0: direction    0 = up, 1 = down 
&dA &d@                 bit 1: repeater     0 = none, 1 = present 
&dA &d@              bits 2-4: flag flag    0 = no flag 
&dA &d@                                     1 = eighth flag 
&dA &d@                                     2 = sixteenth flag 
&dA &d@                                     3 = 32nd flag 
&dA &d@                                     4 = 64th flag 
&dA &d@                                     5 = 128th flag 
&dA &d@                                     6 = 256th flag 
&dA 
&dA &d@   ndata(3)  = note_head   0 = black, 1 = half, 2 = whole, 3 = breve 
&dA &d@   ndata(4)  = dot         0 = none, 1 = dot 
&dA &d@   ndata(5)  = pitch 
&dA &d@   ndata(6)  = position in chord (from note end of stem) 
&dA &d@   ndata(7)  = final x-position of this pitch within chord 
&dA &d@   ndata(8)  = pass number 
&dA &d@   ndata(9)  = staff number 
&dA &d@   ndata(10) = note size (full size vs. que size) 
&dA &d@   ndata(11) = ntype
&dA &d@   ndata(12) = note style 
&dA &d@   pcnt     = total number of notes (and rests) 
&dA &d@            
#define  PS_PASS    1 
#define  PS_STEM    2 
#define  PS_HEAD    3 
#define  PS_DOT     4 
#define  PS_PITCH   5 
#define  PS_RANK    6 
#define  PS_XPOS    7 
#define  PS_PASS2   8 
#define  PS_STAFF   9 
#define  PS_NSIZE  10 
#define  PS_NTYPE  11 
#define  PS_NSTYLE 12 

            loop for c1 = 1 to 45     /* initialize right and left boundaries 
              gr(1,c1) = -200 
              gr(2,c1) = -200 
              pseudo_gr(1,c1) = -200 
              pseudo_gr(2,c1) = -200 
              pseudo_gl(1,c1) = 200 
              pseudo_gl(2,c1) = 200 
              gl(1,c1) = 200 
              gl(2,c1) = 200 
            repeat 

            pcnt = 0 
            c1 = a1 
            ps_passcount(1) = 0 
            ps_passcount(2) = 0 

            loop for thispass = 1 to npasses 
              c2 = ts(c1,STAFF_NUM) + 1           /* staff number 
              ++ps_passcount(c2) 
              c2 = 0 
              loop for c3 = 1 to pitchcnt(thispass) 
                ++pcnt 
                ndata(pcnt,PS_PASS2) = thispass 
                ndata(pcnt,PS_PASS)  = thispass 
                ndata(pcnt,PS_STEM)  = bit(1,ts(c1,STEM_FLAGS)) 
                if c3 = 1 and ts(c1,BEAM_FLAG) = NO_BEAM 
                  if ts(c1,BEAM_CODE) > 0 
                    ndata(pcnt,PS_STEM) += 2 
                  end 
                  if ts(c1,NTYPE) < QUARTER 
                    c4 = QUARTER - ts(c1,NTYPE) << 2 
                    ndata(pcnt,PS_STEM) += c4 
                  end 
                end 

                if ts(c1,CLAVE) < 100           /* note 
                  if ts(c1,NTYPE) < HALF 
                    ndata(pcnt, PS_HEAD) = 0 
                  else 
                    ndata(pcnt,PS_HEAD) = ts(c1,NTYPE) - 7 
                  end 
                else 
                  ndata(pcnt,PS_HEAD) = ts(c1,NTYPE) & 0xff    /* new &dA10/15/07
                end 
                ndata(pcnt,PS_NTYPE) = ts(c1,NTYPE) & 0xff      /* new &dA10/15/07
                ndata(pcnt,PS_NSTYLE) = ts(c1,SUBFLAG_1) >> 15  /* new &dA01/08/11
                ndata(pcnt,PS_NSTYLE) &= 0x01                   /* new &dA01/08/11
                if ts(c1,TYPE) <= REST 
                  ndata(pcnt,PS_NSIZE) = bit(16,ts(c1,SUBFLAG_1)) 
                else 
                  ndata(pcnt,PS_NSIZE) = CUESIZE
                end 

                ndata(pcnt,PS_DOT)   = ts(c1,DOT)
                if ts(c1,CLAVE) < 100           /* note 
                  c10 = ts(c1,STAFFLOC) + vpar20 * 2 + 1 / vpar(2) - 20 
                  ndata(pcnt,PS_PITCH) = 23 - c10 
                else 
                  ndata(pcnt,PS_PITCH) = 100    /* rest 
                end 
                ndata(pcnt,PS_XPOS)  = 0 
                ndata(pcnt,PS_STAFF) = ts(c1,STAFF_NUM) 
                ++c1 
&dA &d@     compute horizontal placement of notes for down stems (on the fly) 
                if bit(0,ndata(pcnt,PS_STEM)) = DOWN and c3 > 1 
                  c4 = ndata(pcnt-1,PS_PITCH) - ndata(pcnt,PS_PITCH) 
                  if c4 = 1 
                    if c2 = 0 
                      ndata(pcnt,PS_XPOS) = -1 
                      c2 = 1 
                    else 
                      c2 = 0 
                    end 
                  else 
                    c2 = 0 
                  end 
                end 
&dA &d@     rank the notes in a chord 
                if bit(0,ndata(pcnt,PS_STEM)) = UP 
                  ndata(pcnt,PS_RANK) = pitchcnt(thispass) + 1 - c3 
                else 
                  ndata(pcnt,PS_RANK) = c3 
                end 
              repeat 
&dA &d@     compute horizontal placement of notes for up stems 
              if pcnt > 0 and bit(0,ndata(pcnt,PS_STEM)) = UP and pitchcnt(thispass) > 1
                c5 = pcnt 
                c2 = 0 
                loop for c3 = 2 to pitchcnt(thispass) 
                  c4 = ndata(c5-1,PS_PITCH) - ndata(c5,PS_PITCH) 
                  if c4 = 1 and c2 = 0 
                    ndata(c5-1,PS_XPOS) = 1 
                    c2 = 1 
                  else 
                    c2 = 0 
                  end 
                  --c5 
                repeat 
              end 
              c2 = pcnt - pitchcnt(thispass) + 1 
            repeat 
&dA 
&dA &d@     determine all clashes between chords 
&dA 
            loop for c2 = 1 to npasses 
              loop for c3 = 1 to npasses 
                clashes(c2,c3) = 0 
              repeat 
            repeat 

            loop for c2 = 1 to pcnt - 1 
              loop for c3 = c2+1 to pcnt 
                c4 = ndata(c2,PS_PASS) 
                c5 = ndata(c3,PS_PASS) 
                if c4 <> c5 and ndata(c2,PS_STAFF) = ndata(c3,PS_STAFF) 
                  if ndata(c2,PS_XPOS) = 0 and ndata(c3,PS_XPOS) = 0 
                    if ndata(c2,PS_PITCH) < 100 
                      c6 = ndata(c2,PS_PITCH) - ndata(c3,PS_PITCH) 
                      if c6 = 0                                     /* same pitch
                        if bit(0,ndata(c2,PS_STEM)) = bit(0,ndata(c3,PS_STEM)) 
                          clashes(c4,c5) = 1 
                          clashes(c5,c4) = 1 
                          goto PS_D2 
                        end 
                        if ndata(c2,PS_HEAD) <> ndata(c3,PS_HEAD) 
                          clashes(c4,c5) = 1 
                          clashes(c5,c4) = 1 
                          goto PS_D2 
                        end 
                        if ndata(c2,PS_NSIZE) <> ndata(c3,PS_NSIZE) 
                          clashes(c4,c5) = 1 
                          clashes(c5,c4) = 1 
                          goto PS_D2 
                        end 
&dA 
&dA &d@     &dA12/24/05&d@  This optional code is now controlled by dot_difference_flag 
&dA 
                        if dot_difference_flag = 1 
                          if ndata(c2,PS_DOT) <> ndata(c3,PS_DOT) 
                            clashes(c4,c5) = 1 
                            clashes(c5,c4) = 1 
                            goto PS_D2 
                          end 
                        end 
&dA              
                        if ndata(c2,PS_RANK) * ndata(c3,PS_RANK) <> 1 
                          clashes(c4,c5) = 1 
                          clashes(c5,c4) = 1 
                          goto PS_D2 
                        end 
&dA &d@                           
&dA &d@           We must now ask the question: are all notes of first chord either 
&dA &d@              equal/above all notes of second chord, or equal/below all notes 
&dA &d@              of second chord.  
&dA 
                        c10 = 0 
                        loop for c9 = 1 to pcnt 
                          if ndata(c9,PS_PASS) = ndata(c2,PS_PASS) 
                            if ndata(c9,PS_PITCH) <> ndata(c2,PS_PITCH) 
                              if ndata(c9,PS_PITCH) > ndata(c2,PS_PITCH) 
                                if c10 = -1 
                                  c10 = 1000 
                                else 
                                  c10 = 1 
                                end 
                              end 
                              if ndata(c9,PS_PITCH) < ndata(c2,PS_PITCH) 
                                if c10 = 1 
                                  c10 = 1000 
                                else 
                                  c10 = -1 
                                end 
                              end 
                            end 
                          end 
                        repeat 
                        if c10 = 1000 
                          clashes(c4,c5) = 1 
                          clashes(c5,c4) = 1 
                          goto PS_D2 
                        end 
                        loop for c9 = 1 to pcnt 
                          if ndata(c9,PS_PASS) = ndata(c3,PS_PASS) 
                            if ndata(c9,PS_PITCH) <> ndata(c3,PS_PITCH) 
                              if ndata(c9,PS_PITCH) > ndata(c3,PS_PITCH) 
                                if c10 = 0 
                                  c10 = -1   
                                end 
                                if c10 = 1 
                                  c10 = 1000 
                                end 
                              end 
                              if ndata(c9,PS_PITCH) < ndata(c3,PS_PITCH) 
                                if c10 = 0 
                                  c10 = 1 
                                end 
                                if c10 = -1 
                                  c10 = 1000 
                                end 
                              end 
                            end 
                          end 
                        repeat 
                        if c10 = 1000 
                          clashes(c4,c5) = 1 
                          clashes(c5,c4) = 1 
                          goto PS_D2 
                        end 
                        clashes(c4,c5) = 2 
                        clashes(c5,c4) = 2 
                        goto PS_D2 
                      end 
                      if c6 = 1 or c6 = -1 
                        clashes(c4,c5) = 1 
                        clashes(c5,c4) = 1 
                      end 
                    end 
                  end 
                end 
PS_D2: 
              repeat 
            repeat 
&dA 
&dA &d@     typeset all groups of chords for which there are no clashes 
&dA 
            loop for c2 = 1 to npasses 
              tgroup(c2) = 0 
            repeat 
            ntgroups = 0 
            loop for c2 = 1 to npasses 
              c5 = 0 
              loop for c3 = c2+1 to npasses 
                if clashes(c2,c3) <> 1 and tgroup(c3) = 0 
                  if c5 = 0 
                    ++ntgroups 
                    c5 = 1 
                    tgroup(c2) = ntgroups 
                    tgroup(c3) = ntgroups 
                  else 
                    loop for c4 = c2+1 to c3-1 
                      if tgroup(c4) = ntgroups and clashes(c4,c3) = 1 
                        c4 = 1000 
                      end 
                    repeat 
                    if c4 <> 1000 
                      tgroup(c3) = ntgroups 
                    end 
                  end 
                end 
              repeat 
            repeat 
            c10 = 0                        /* initialize right-hand chord boundary

            loop for c3 = 1 to ntgroups    /* number of typeset groups 
&dA 
&dA &d@     typeset chords
&dA 
              loop for c4 = 1 to 2    /* typeset stem down first 
                c5 = 2 - c4 
PS_CC:          c6 = 0 
                c7 = 0 
                c15 = 0 
                loop for c2 = 1 to pcnt 
                  c9 = ndata(c2,PS_PASS) 
                  if c9 > 0 and tgroup(c9) = c3   /* this typeset group 
                    if bit(0,ndata(c2,PS_STEM)) = c5 
                      if ndata(c2,PS_PITCH) > c6           /* typeset highest pitch first
                        if c6 > 0 and c15 > EIGHTH         /* but check first to see if
                          if ndata(c2,PS_NTYPE) < QUARTER  /* type is quarter or greater
                            if ndata(c2,PS_PITCH) - c6 < 3 
                              goto NOSWITCH 
                            end 
                          end 
                        end 
                        c6 = ndata(c2,PS_PITCH) 
                        c7 = ndata(c2,PS_PASS) 
                        c15 = ndata(c2,PS_NTYPE) 
NOSWITCH: 
                      else 
                        if c15 < QUARTER and ndata(c2,PS_NTYPE) > EIGHTH 
                          if c6 - ndata(c2,PS_PITCH) < 3 
                            c6 = ndata(c2,PS_PITCH) 
                            c7 = ndata(c2,PS_PASS) 
                            c15 = ndata(c2,PS_NTYPE) 
                          end 
                        end 
                      end 
                    end 
                  end 
                repeat 
                if c7 > 0 
                  c8 = 100 
                  loop for c2 = 1 to npasses 
                    if clashes(c2,c7) = 2         /* unison 
                      c8 = c2 
                      c2 = 100 
                    end 
                  repeat 
                  perform ps_setchord (c7, c8, c10) 
                  goto PS_CC 
                end 
              repeat 
            repeat 
&dA 
&dA &d@     determine if there are clashes left 
&dA 
PS_B:    
            loop for c2 = 1 to pcnt - 1 
              if ndata(c2,PS_PASS) > 0 and ndata(c2,PS_XPOS) = 0 
                             /* chord(PS_PASS) has not been set 
                loop for c3 = c2+1 to pcnt 
                  if ndata(c3,PS_XPOS) = 0 and ndata(c3,PS_PASS) > 0 
                    if ndata(c2,PS_STAFF) = ndata(c3,PS_STAFF) 
                      if ndata(c2,PS_PITCH) < 100 
                        c4 = ndata(c2,PS_PITCH) - ndata(c3,PS_PITCH) 
                        if c4 = 0 
                          if bit(0,ndata(c2,PS_STEM)) = bit(0,ndata(c3,PS_STEM))
                            goto PS_CL 
                          end 
                          if ndata(c2,PS_HEAD) <> ndata(c3,PS_HEAD) 
                            goto PS_CL 
                          end 
&dA 
&dA &d@     &dA12/24/05&d@  This optional code is now controlled by dot_difference_flag 
&dA 
                          if dot_difference_flag = 1 
                            if ndata(c2,PS_DOT) <> ndata(c3,PS_DOT) 
                              goto PS_CL 
                            end 
                          end 
&dA              
                          if ndata(c2,PS_RANK) * ndata(c3,PS_RANK) <> 1 
                            goto PS_CL 
                          end 
&dA &d@                           
&dA &d@           We must now ask the question: are all notes of first chord either 
&dA &d@              equal/above all notes of second chord, or equal/below all notes 
&dA &d@              of second chord.  
&dA 
                          c10 = 0 
                          loop for c9 = 1 to pcnt 
                            if ndata(c9,PS_PASS) = ndata(c2,PS_PASS) 
                              if ndata(c9,PS_PITCH) <> ndata(c2,PS_PITCH) 
                                if ndata(c9,PS_PITCH) > ndata(c2,PS_PITCH) 
                                  if c10 = -1 
                                    c10 = 1000 
                                  else 
                                    c10 = 1 
                                  end 
                                end 
                                if ndata(c9,PS_PITCH) < ndata(c2,PS_PITCH) 
                                  if c10 = 1 
                                    c10 = 1000 
                                  else 
                                    c10 = -1 
                                  end 
                                end 
                              end 
                            end 
                          repeat 
                          if c10 = 1000 
                            goto PS_CL 
                          end 
                          loop for c9 = 1 to pcnt 
                            if ndata(c9,PS_PASS) = ndata(c3,PS_PASS) 
                              if ndata(c9,PS_PITCH) <> ndata(c3,PS_PITCH) 
                                if ndata(c9,PS_PITCH) > ndata(c3,PS_PITCH) 
                                  if c10 = 0 
                                    c10 = -1 
                                  end 
                                  if c10 = 1 
                                    c10 = 1000 
                                  end 
                                end 
                                if ndata(c9,PS_PITCH) < ndata(c3,PS_PITCH) 
                                  if c10 = 0 
                                    c10 = 1 
                                  end 
                                  if c10 = -1 
                                    c10 = 1000 
                                  end 
                                end 
                              end 
                            end 
                          repeat 
                          if c10 = 1000 
                            goto PS_CL 
                          end 
                          goto PS_UNIS     /*  typeset unison 
                        end 
                        if c4 = 1 or c4 = -1 
                          if ndata(c2,PS_PASS) <> ndata(c3,PS_PASS) 
                            goto PS_CL 
                          end 
                        end 
                      end 
                    end 
                  end 
                repeat 
              end 
            repeat 
&dA 
&dA &d@     no clashes found.  Typeset chords 
&dA 
            loop for c4 = 1 to 2    /* typeset stem down first 
              c5 = 2 - c4 
PS_C:         c6 = 0 
              c7 = 0 
              loop for c2 = 1 to pcnt 
                if ndata(c2,PS_PASS) > 0 and bit(0,ndata(c2,PS_STEM)) = c5 
                  if ndata(c2,PS_PITCH) > c6     /* typeset highest pitch first
                    c6 = ndata(c2,PS_PITCH) 
                    c7 = ndata(c2,PS_PASS) 
                  end 
                end 
              repeat 
              if c7 > 0 
                c8 = 100 
                perform ps_setchord (c7, c8, c10) 
                goto PS_C 
              end 
            repeat 
&dA 
&dA &d@     Note: When you have reached this point in the code, you have determined 
&dA &d@     the local position of all notes (but not rests) in the simultaneity.  The
&dA &d@     arrays gr(.,.) and gl(,.,) have been computed (if there were notes in 
&dA &d@     the simultaneity).  You can now use this information to try to place 
&dA &d@     any rests vertically as best you can.  After this, you need to compute 
&dA &d@     the NODE_SHIFT parameter (from emptyspace(.,.) and gl(,.,) and then 
&dA &d@     the new values for emptyspace(.,.) 
&dA 
&dA &d@     Now store results in set array    (watch out for c9 and c10 in this loop)
&dA 
            c2 = 0 
            c5 = 0 
            pitchcnt(1) = 0 
            pitchcnt(2) = 0 
            loop for c1 = a1 to a2 
              ++c2 
              c4 = ts(c1,STAFF_NUM) + 1      /* staff number 
              thispass = ndata(c2,PS_PASS2)
              if thispass <> c5 
                c5 = thispass 
                ++pitchcnt(c4) 
              end 
              if ndata(c2,PS_PITCH) = 100    /* rest 
                ntype = ndata(c2,PS_HEAD) 
                c6 = ntype << 1 - 1 
                c8 = int("1008060402020402030303"{c6,2}) 
                c7 = int("0505050505030301000101"{c6,2}) 
                if ps_passcount(c4) = 1 
                  c3 = vpar(4) 
                  if ts(c1,MULTI_TRACK) >= 4 
                    c6 = ts(c1,MULTI_TRACK) >> 2 
                    if c6 = 1 
                      c3 -= vpar(2) 
                    end 
                    if c6 = 2 
                      c3 += vpar(4) 
                    end 
                  end 
                else 
                  if ps_passcount(c4) = 2 
                    if pitchcnt(c4) = 1 
                      if chr(ts(c1+1,TYPE)) in [NOTE,CUE_NOTE] 
                        c3 = ts(c1+1,STAFFLOC)
                      else 
&dA 
&dA &d@       &dA05/10/05&d@ Addition to allow a single rest (expressing parallel rests)
&dA &d@                  to be located at vpar(4), the middle staff line.  
&dA &d@                  Note: this work-around may not cover all cases.  
&dA 
                        if ts(c1+1,TYPE) = REST and ts(c1+1,CLAVE) = 200 
                          c3 = vpar(4) 
                          goto RTYY3 
                        else 
                          c3 = vpar(2) 
                          if (ts(c1,NTYPE) & 0xff) < EIGHTH and c3 > 0    /* new &dA10/15/07
                            c3 = 0 
                          end 
                        end 
&dA           
                      end 
                      c11 = c3 + vpar20 * 2 + 1 / vpar(2) - 20 
                      c6 = 23 - c11 

                      c13 = c6 
                      loop while gr(c4,c6) <> -200 
                        c3 -= vpar(1) 
                        c11 = c3 * 2 / vpar(2) 
                        c3 -= rem                 /* tricky code 

                        ++c6      
                      repeat 
                      c6 -= c7                          /* c7 is lower part of rest
                      loop while gr(c4,c6) <> -200 
                        c3 -= vpar(1) 
                        c11 = c3 * 2 / vpar(2) 
                        c3 -= rem                 /* tricky code 

                        ++c6      
                      repeat 
                      if c6 > c13 + 8 
                        c3 += vpar(2) 
                      end 
                      if c3 > vpar(2) 
                        c3 = vpar(2) 
                      end 
                      c6 = c3 / notesize 
                      if rem <> 0 
                        c3 -= vpar(1)     /* OK 4-21-95 
                      end 
                    else 
                      if chr(ts(c1-1,TYPE)) in [REST,CUE_REST] 
                        if ts(c1-1,CLAVE) < 200
                          c3 = vpar(8) 
                        else 
                          c3 = vpar(4) 
                          goto RTYY3 
                        end 
                      else 
                        c3 = ts(c1-1,STAFFLOC) + vpar(2) 
                      end 
                      c11 = c3 + vpar20 * 2 + 1 / vpar(2) - 20 
                      c6 = 23 - c11 

                      c13 = c6 
                      loop while gr(c4,c6) <> -200 
                        c11 = c3 * 2 / vpar(2) 
                        if rem <> 0               /* tricky code 
                          ++c3       
                        end 
                        c3 += vpar(1) 

                        --c6   
                      repeat 
                      c6 += c8                          /* c8 is "clearance" at top of rest
                      loop while gr(c4,c6) <> -200 
                        c11 = c3 * 2 / vpar(2) 
                        if rem <> 0               /* tricky code 
                          ++c3       
                        end 
                        c3 += vpar(1) 

                        --c6   
                      repeat 
                      if c6 < c13 - 8 
                        c3 -= vpar(2) 
                      end 
                      if c3 < vpar(8) 
                        c3 = vpar(8) 
                      end 
                      c6 = c3 / notesize 
                      if rem <> 0 
                        c3 = c6 + 1 * notesize 

                      end 
                    end 
                  else 
                    if pitchcnt(c4) = 1 
                      if chr(ts(c1+1,TYPE)) in [NOTE,CUE_NOTE] 
                        c3 = ts(c1+1,STAFFLOC)           
                      else 
                        c3 = vpar(2) 
                      end 
                      if (ts(c1,NTYPE) & 0xff) < EIGHTH and c3 > 0     /* new &dA10/15/07
                        c3 = 0 
                      end 
                      c11 = c3 + vpar20 * 2 + 1 / vpar(2) - 20 
                      c6 = 23 - c11 

                      c13 = c6 
                      loop while gr(c4,c6) <> -200 
                        c3 -= vpar(1) 
                        c11 = c3 * 2 / vpar(2) 
                        c3 -= rem                 /* tricky code 

                        ++c6      
                      repeat 
                      c6 -= c7                          /* c7 is lower part of rest
                      loop while gr(c4,c6) <> -200 
                        c3 -= vpar(1) 
                        c11 = c3 * 2 / vpar(2) 
                        c3 -= rem                 /* tricky code 

                        ++c6      
                      repeat 
                      if c6 > c13 + 8 
                        c3 += vpar(2) 
                      end 
                      if c3 > vpar(2) 
                        c3 = vpar(2) 
                      end 
                      c6 = c3 / notesize 
                      if rem <> 0 
                        c3 -= vpar(1)      /* OK 4-21-95 
                      end 
                    else 
                      if pitchcnt(c4) = ps_passcount(c4) 
                        if chr(ts(c1-1,TYPE)) in [REST,CUE_REST] 
                          if ts(c1-1,CLAVE) < 200
                            c3 = vpar(10) 
                          else 
                            c3 = vpar(4) 
                          end 
                        else 
                          c3 = ts(c1-1,STAFFLOC) + vpar(2) 
                        end 
                        c11 = c3 + vpar20 * 2 + 1 / vpar(2) - 20 
                        c6 = 23 - c11 

                        c13 = c6 
                        loop while gr(c4,c6) <> -200 
                          c11 = c3 * 2 / vpar(2) 
                          if rem <> 0               /* tricky code 
                            ++c3 
                          end 
                          c3 += vpar(1) 

                          --c6        
                        repeat 
                        c6 += c8                          /* c8 is "clearance" at top of rest
                        loop while gr(c4,c6) <> -200 
                          c11 = c3 * 2 / vpar(2) 
                          if rem <> 0               /* tricky code 
                            ++c3 
                          end 
                          c3 += vpar(1) 

                          --c6        
                        repeat 
                        if c6 < c13 - 8 
                          c3 -= vpar(2) 
                        end 
                        if c3 < vpar(8) 
                          c3 = vpar(8) 
                        end 
                        c6 = c3 / notesize 
                        if rem <> 0 
                          c3 = c6 + 1 * notesize 

                        end 
                      else 
&dA 
&dA &d@               Look for empty space in middle of staff 
&dA 
                        loop for c3 = 45 to 1 step -1 
                        repeat while gr(c4,c3) = -200 
                        if c3 <= 21                      /* suppose there's nothing up there
                          c3 += 3 
                          if c3 < 19 
                            c3 = 19 
                          end 
                          goto RTYY2 
                        end 
                        loop while c3 > 0 
                          --c3 
                        repeat while gr(c4,c3) <> -200
RTYY: 
                        loop for c6 = 1 to 8 
                          --c3 
                        repeat while c3 > 0 and gr(c4,c3) = -200 
                        if c6 = 8 or c3 <= 0 
                          c3 += 3 
                        else 
                          goto RTYY 
                        end 
RTYY2: 
                        c3 = 43 - c3 / 2 * vpar(2) 
                        c3 += rem * vpar(1) 
                        c3 -= vpar20       
                      end 
                    end 
                  end 
                end 
RTYY3: 
                if ts(c1,CLAVE) < 200
                  if ts(c1,STAFFLOC) = 1 
                    c3 = vpar(4) 
                  end 
                  ts(c1,STAFFLOC) = c3 
                  perform rest_occupy_space (c3,c4)   /* ntype is read directly
                  ts(c1,OBY) = ts(c1,STAFFLOC) 
                end 
              else 
                c3 = ndata(c2,PS_HEAD) 
                if ndata(c2,PS_NSTYLE) = 0 
                  if c3 < 3 
                    c4 = hpar(82) 
                  else 
                    if c3 = 3
                      c4 = hpar(83) 
                    else 
                      c4 = hpar(84) 
                    end 
                  end 
                else                            /* New  &dA01/08/11&d@ 
                  if c3 < 3
                    c4 = vpar(2) 
                  else 
                    if c3 = 3
                      c4 = vpar(2) * 5 / 4 
                    else 
                      c4 = hpar(84) 
                    end 
                  end 
                end 

                if ndata(c2,PS_NSIZE) = CUESIZE 
                  c4 = c4 * 8 / 10 
                end 

                c4 -= 1 
&dA 
&dA &d@     Note: LOCAL_XOFF will now be set for this notehead, and will not be changed.
&dA &d@           The value is negative, zero, or positive by the approximate thickness
&dA &d@           of a notehead.  This information can be used in the final computation
&dA &d@           of P10 for this notehead.  
&dA 
                ts(c1,LOCAL_XOFF)  = c4 * ndata(c2,PS_XPOS)     /* uniquely set here
                
&dA 
&dA &d@  &dA NOTE: Do not call procedure get_topbottom before this point in the program 
&dA 

&dA 
&dA &d@     Note: We are about to set GLOBAL_XOFF for all noteheads in a chord 
&dA &d@           to the value in printpos(thispass).  The spacing of simultaneous
&dA &d@           chords in this program is hopelessly complicated.  Therefore 
&dA &d@           we cannot know directly whether a notehead has been shifted 
&dA &d@           exactly one thickness to the right or left, or whether the 
&dA &d@           shift has been built up in several parts.  All we know is that 
&dA &d@           the shift adds up to GLOBAL_XOFF.  In order to set the NOTE_DISP
&dA &d@           parameter properly, we will need to compare GLOBAL_XOFF with autoscr's
&dA &d@           normal shift distance = (width of black note - 2).  If GLOBAL_XOFF
&dA &d@           is within 2 dots either side of +/- (hpar(82) - 2), then we will
&dA &d@           infer that the shift was an integral notehead thickness; otherwise
&dA &d@           we must record the shift measured in dots.  A shift of an 
&dA &d@           integral notehead thickness will be recorded as -100 or +100.  
&dA 
                if chr(ts(c1,TYPE)) in [NOTE,CUE_NOTE,GR_NOTE] 
                  c9 = c1 
                  ts(c1,GLOBAL_XOFF) = printpos(thispass) 
&dA 
&dA &d@                              All New code &dA05/02/03&d@ 
&dA 
&dA &d@       At this point, we need to see if the note object position has been modified
&dA &d@       "absolutely" by a print suggestion.  If this is the case, we need to make the
&dA &d@       adjustment here, AND, elimate the suggestion from the tsr string.  
&dA 
                  c4 = ts(c1,TSR_POINT) 
                  c3 = ors(tsr(c4){2}) 
                  if bit(0,c3) = 1 
                    px = ors(tsr(c4){3}) 
                    if px > 0 
                      px = px - 128 * notesize / 10 
&dA 
&dA &d@     &dA11/24/07&d@  We need to take action in both the relative and 
&dA &d@     absolute cases of x-shift.  Apparently, there is a difference, 
&dA &d@     at least here.  Relative shift ("x") is added to whatever is 
&dA &d@     already in the GLOBAL_XOFF; whereas absolute shift ("X") replaces 
&dA &d@     any value in GLOBAL_XOFF.  This holds for note placement, but 
&dA &d@     I am unclear whether it is true for musical signs, dynamics, etc.  
&dA 
                      pxx = c3 & 0x02 >> 1 
                      if pxx = 1                    /* true when "X" is used
                        ts(c1,GLOBAL_XOFF) = px 
                        tsr(c4){3} = chr(0)         /* here is where suggestion is zeroed out
                      else 
                        ts(c1,GLOBAL_XOFF) += px 
                        tsr(c4){3} = chr(0)         /* here is where suggestion is zeroed out
                      end 
&dA                 
                    end 
                  end 
                  printpos(thispass) = ts(c1,GLOBAL_XOFF) 
&dA 
&dA &d@       End of new code &dA05/02/03&d@ 
&dA 
                  c10 = c1 + 1
                  loop while ts(c10,TYPE) = ts(c1,TYPE) + 1 
                    ++c10 
                  repeat 
                  --c10 
                else 
                  ts(c1,GLOBAL_XOFF) = c9 * INT10000 + c10    /* temporary storage of indexes
                  ts(c1,NOTE_DISP) = ts(c9,NOTE_DISP) 
                end 
              end 
            repeat 
            goto PS_END 

&dA 
&dA &d@     Clashes
&dA 
PS_CL: 
            c4 = ndata(c2,PS_PASS) 
            c5 = ndata(c3,PS_PASS) 
            if ndata(c2,PS_DOT) > 0 and ndata(c3,PS_DOT) = 0 
              c7 = c5 
              goto PS_CLT 
            end 
            if ndata(c2,PS_DOT) = 0 and ndata(c3,PS_DOT) > 0 
              c7 = c4 
              goto PS_CLT 
            end 
            if bit(0,ndata(c2,PS_STEM)) = UP and bit(0,ndata(c3,PS_STEM)) = DOWN
              c7 = c4 
              goto PS_CLT 
            end 
            if bit(0,ndata(c2,PS_STEM)) = DOWN and bit(0,ndata(c3,PS_STEM)) = UP
              c7 = c5 
              goto PS_CLT 
            end 
            if ndata(c2,PS_PITCH) >= ndata(c3,PS_PITCH) 
              c7 = c4 
            else 
              c7 = c5 
            end 
PS_CLT:
            c8 = 100 
            perform ps_setchord (c7, c8, c10) 
            goto PS_B 
*
PS_UNIS:
            c7 = ndata(c2,PS_PASS) 
            c8 = ndata(c3,PS_PASS) 
            perform ps_setchord (c7, c8, c10) 
            goto PS_B 

PS_END: 

&dA 
&dA &d@     At this point you have accomplished tasks (1), (2), and (3) 
&dA &d@     for the case of multiple note heads on a division.  You now 
&dA &d@     need to do the following (for all ts(.,.) elements from a1   
&dA &d@     to a2).  
&dA 
&dA &d@       (4) Compute the x and y offsets for any dot(s) which might 
&dA &d@           follow each note head.     
&dA 
&dA &d@       (5) Compute the x offset (as measured to the left) of any 
&dA &d@             accidental(s) which might precede each note head.
&dA 

&dA 
&dA &d@     (4) X and Y offsets for dots 
&dA 
&dA &d@       (a) determine number and spacing of note heads on each stave 
&dA &d@             to determine method of placement of dots.  Use column 
&dA &d@             method if note heads (with dots) occur on space and line
&dA &d@             on the same staff.  Otherwise use conventional placement.  
&dA &d@             (This code assumes MAX_STAFF <= 3) 
&dA 
&dA &d@             First find all staves where all offsets (global and local) 
&dA &d@             are zero.  In these cases, we can use the absolute method.  
&dA 
            tgroup(1) = 4 
            tgroup(2) = 4 
            tgroup(3) = 4 
            loop for c1 = a1 to a2 
              c8 = ts(c1,STAFF_NUM) + 1        /* staff number 
              if chr(ts(c1,TYPE)) in [NOTE,CUE_NOTE,GR_NOTE] 
                if ts(c1,GLOBAL_XOFF) > 0 
                  tgroup(c8) = 0 
                end 
              end 
              if ts(c1,LOCAL_XOFF) > 0 
                tgroup(c8) = 0 
              end 
            repeat 

            loop for c1 = a1 to a2 
              if ts(c1,DOT) > 0 
                c8 = ts(c1,STAFF_NUM) + 1      /* staff number 
                if tgroup(c8) <> 4 
                  c9 = ts(c1,STAFFLOC) + vpar20 * 2 + 1 / vpar(2) - 20 

                  c9 = bit(0,c9) + 1 
                  if tgroup(c8) = 0 
                    tgroup(c8) = c9 
                  else 
                    if tgroup(c8) <> c9 
                      tgroup(c8) = 3           /* use column method 
                    end 
                  end 
                end 
              end 
            repeat 
&dA 
&dA &d@       (b) for those staves using the column method, determine the 
&dA &d@             x offset of the column.  
&dA 
            c5 = 0 
            loop for c8 = 1 to 3 
              if tgroup(c8) = 3 
                tgroup(c8) = 1 
                c5 = 1 
              else 
                tgroup(c8) = 0 
              end 
            repeat 
            if c5 = 1 
              loop for c1 = a1 to a2 
                if ts(c1,GLOBAL_XOFF) < INT10000   
                  c9 = ts(c1,GLOBAL_XOFF)                    /* global offset 
                end 
                if ts(c1,DOT) > 0 
                  c8 = ts(c1,STAFF_NUM) + 1                  /* staff number 
                  if tgroup(c8) > 0 
                    c7 = c9 + ts(c1,LOCAL_XOFF)              /* note head position
                    c10 = ts(c1,TYPE) / 3 
                    if rem = 0
                      if ts(c1,NTYPE) > QUARTER 
                        c3 = hpar(30) 
                      else 
                        c3 = hpar(31) 
                      end 
                    else 
                      if (ts(c1,SUBFLAG_1) & 0x8000) = 0   /* modern notation
                        if ts(c1,NTYPE) > HALF 
                          c3 = hpar(32) 
                        else 
                          c3 = hpar(33) 
                        end 
                      else                                 /* New &dA01/08/11&d@ 
                        if ts(c1,NTYPE) > WHOLE 
                          c3 = vpar(2) * 5 / 2 
                        else 
                          if ts(c1,NTYPE) > HALF 
                            c3 = vpar(2) * 9 / 5 
                          else 
                            c3 = vpar(2) * 3 / 2 
                          end 
                        end 
                      end 
                    end 
                    if rem = 1 and bit(1,ts(c1,STEM_FLAGS)) = UP and bit(16,ts(c1,SUBFLAG_1)) = 0 /* modern only
                      if ts(c1,BEAM_FLAG) = NO_BEAM and ts(c1,NTYPE) < QUARTER 
                        c3 += hpar(27) 
                      end 
                    end 
                    if ts(c1,TYPE) > REST 
                      c3 = c3 * 8 / 10 
                    end 
                    c7 += c3             /* dot position for this note head 
                    if tgroup(c8) < c7 
                      tgroup(c8) = c7 
                    end 
                  end 
                end 
              repeat 
&dA &d@              
&dA &d@       (c) place dots for all staves which use the column method
&dA &d@             (relative x placement; absolute y placement) 
&dA 
&dA &d@           Starting with the left-most objects in the "musical node" 
&dA &d@           and moving to the right, set dot positions according to 
&dA &d@           the following algorithm (keeping track of all previous 
&dA &d@           dots for this stave): 
&dA 
&dA &d@              Start with the note head furtherest from note-end of stem 
&dA &d@              If note on line, 
&dA &d@                if space above is free, put dot there 
&dA &d@                else put dot in first free space below 
&dA &d@              else 
&dA &d@                if space is free, put dot there 
&dA &d@                else put dot in first free space in reverse direction 
&dA &d@              end 
&dA 
              loop for c13 = 1 to 3       /* loop though staves 
                if tgroup(c13) > 0 
                  c5 = 0 
                  c10 = 0                 /* count up for stems up 
                  c11 = 1000              /* count down for stems down 
&dA 
&dA &d@    Special case: two notes on stave and multi-tracks on this stave 
&dA 
                  if a2 = a1 + 1 
                    if ts(a1,MULTI_TRACK) >= 4 
                      if abs(ts(a1,STAFFLOC) - ts(a2,STAFFLOC)) > notesize 
                        if bit(1,ts(a1,STEM_FLAGS)) <> bit(1,ts(a2,STEM_FLAGS))
                          loop for c1 = a1 to a2 
                            c8 = ts(c1,GLOBAL_XOFF) 
                            if c8 >= INT10000 
                              c8 /= INT10000 
                              c8 = ts(c8,GLOBAL_XOFF) 
                            end 
                            c10 = ts(c1,STAFFLOC) 
                            c9 = c10 / notesize 
                            if rem = 0                 /* note on line 
                              if bit(1,ts(c1,STEM_FLAGS)) = UP 
                                c10 -= vpar(12) 
                              else 
                                c10 += vpar(12)           
                              end 
                            end 
                            c10 -= ts(c1,OBY)          /* convert to relative y offset
                            c9 = tgroup(c13) - c8      /* relative x offset from obx
                            c9 *= INT10000 
                            c9 += c10 
                            c9 <<= 4                   /* code modified &dA12-24-96
                            ts(c1,DOT) |= c9 
                          repeat 
                          goto X_DOT 
                        end 
                      end 
                    end 
                  end                                        /* global offset 

                  loop for c1 = a1 to a2 
                    if ts(c1,GLOBAL_XOFF) < INT10000   
                      c9 = ts(c1,GLOBAL_XOFF)                /* global offset           
                    end 
                    c8 = ts(c1,STAFF_NUM) + 1         /* staff number 
                    if ts(c1,DOT) > 0 and c8 = c13    /* dot on this staff 
                      ++c5 
                      c12 = bit(1,ts(c1,STEM_FLAGS)) 
                      if c12 = UP       /* stem up 
                        ndata(c5,1) = c10 
                        ++c10 
                      else 
                        ndata(c5,1) = c11 
                        --c11 
                      end 
                      ndata(c5,1) += c9 * 10000        /* tricky code (for ordering)
                      ndata(c5,2) = c1 
                      ndata(c5,3) = c12                /* stem direction 
                      ndata(c5,4) = c9                 /* global x offset 
                      ndata(c5,5) = 100 
                    end 
                  repeat 
&dA 
&dA &d@           Sort the ndata array by ndata(.,1) smallest on top 
&dA &d@           first by global offset, then by stem (up first), then by order 
&dA &d@           on stem (up in order, down reverse order) 
&dA 
                  loop for c8 = 1 to c5 
                    c6 = 10000000    
                    loop for c4 = 1 to c5 
                      if ndata(c4,5) = 100 and ndata(c4,1) < c6 
                        c6 = ndata(c4,1) 
                        c7 = c4 
                      end 
                    repeat 
                    ndata(c7,6) = c8 
                    ndata(c7,5) = 0 
                  repeat 
&dA 
&dA &d@           Typeset dots on this staff 
&dA 
                  loop for c8 = 1 to 50 
                    mf(c8) = 0 
                  repeat 
                  loop for c8 = 1 to c5 
                    c7 = ndata(c8,6)                /* typeset this note head 
                    c1 = ndata(c7,2)                /* c1 is the index 
                    c9 = tgroup(c13) - ndata(c7,4)  /* relative x offset from obx
                    c16 = ts(c1,STAFFLOC) + vpar20 * 2 + 1 / vpar(2) - 20 
                    c4 = 23 - c16                            /* 23 = top line of staff

&dA 
&dA &d@              If note on line, 
&dA &d@                if space above is free, put dot there 
&dA &d@                else put dot in first free space below 
&dA &d@              else 
&dA &d@                if space is free, put dot there 
&dA &d@                else put dot in first free space in reverse direction 
&dA &d@              end 
&dA 
                    if bit(0,c4) = 1                /* if note on line 
                      if mf(c4+1) = 0 
                        mf(c4+1) = 1 
                        c10 = c4 + 1                /* absolute y offset (23 = top line)
                      else 
                        c10 = 0 
                        --c4 
                        loop 
                          if mf(c4) = 0 
                            mf(c4) = 1 
                            c10 = c4 
                          else 
                            c4 -= 2 
                          end 
                        repeat while c10 = 0 
                      end 
                    else                            /* else, note on space 
                      if mf(c4) = 0 
                        mf(c4) = 1 
                        c10 = c4 
                      else 
                        if ndata(c7,3) = UP         /* if stem up, look up 
                          c10 = 0 
                          c4 += 2 
                          loop 
                            if mf(c4) = 0 
                              mf(c4) = 1 
                              c10 = c4 
                            else 
                              c4 += 2 
                            end 
                          repeat while c10 = 0 
                        else                        /* else, stem is down; look down
                          c10 = 0 
                          c4 -= 2 
                          loop 
                            if mf(c4) = 0 
                              mf(c4) = 1 
                              c10 = c4 
                            else 
                              c4 -= 2 
                            end 
                          repeat while c10 = 0 
                        end 
                      end 
                    end 
&dA 
&dA &d@             c10 is the absolute y position (23 = top line) for the dot(s) 
&dA 
                    c10 = 43 - c10 / 2 * vpar(2) 
                    c10 += rem * vpar(1) 
                    c10 -= vpar20 
&dA 
&dA &d@           Store relative values of x and y for this note head 
&dA &d@             c9 is the relative x shift to the dot(s) from obx 
&dA &d@             x * INT10000 + y, shift it over 4 and &dAOR&d@ it DOT   (modified &dA12-24-96&d@)
&dA 
                    c9 *= INT10000 
                    c10 -= ts(c1,OBY)          /* convert to relative y offset 
                    c9 += c10 
                    c9 <<= 4                   /* code modified &dA12-24-96&d@ 
                    ts(c1,DOT) |= c9  
                  repeat 
X_DOT: 

                end 
              repeat 
            end 
&dA &d@              
&dA &d@       (d) place dots for all remaining note heads (absolute placement first) 
&dA 
            old_c2 = 10000                    /* added &dA11/26/06&d@ 
            loop for c1 = a1 to a2 
              if ts(c1,DOT) > 0 and ts(c1,DOT) < INT9000      /* dot not yet placed
                ntype = ts(c1,NTYPE) & 0xff                   /* new &dA10/15/07
                c10 = ts(c1,TYPE) / 3 
                if rem = 0                    /* rests 
                  if ntype > QUARTER 
                    c3 = hpar(30) 
                  else 
                    c3 = hpar(31) 
                  end 
                else 
                  if (ts(c1,SUBFLAG_1) & 0x8000) = 0   /* modern notation 
                    if ntype > HALF 
                      c3 = hpar(32) 
                    else 
                      c3 = hpar(33) 
                    end 
                  else                                 /* New &dA01/08/11&d@ 
                    if ntype > WHOLE 
                      c3 = vpar(2) * 5 / 2 
                    else 
                      if ntype > HALF 
                        c3 = vpar(2) * 9 / 5 
                      else 
                        c3 = vpar(2) * 3 / 2 
                      end 
                    end 
                  end 
                end 
                c6 = ts(c1,STAFFLOC) + vpar20 * 2 + 1 / vpar(2) - 20 
                c5 = ts(c1,STAFFLOC) / notesize 
                c5 = rem                           /* c5 = 0 means note on line

                if bit(1,ts(c1,STEM_FLAGS)) = UP and bit(16,ts(c1,SUBFLAG_1)) = 0
                  if ts(c1,BEAM_FLAG) = NO_BEAM and ts(c1,NTYPE) < QUARTER 
                    c10 = ts(c1,TYPE) / 3 
                    if rem = 1 
                      c3 += hpar(27) 
                      if c5 <> 0 
                        c3 -= hpar(34) 
                      end 
                    end 
                  end 
                end 
*    if dot is on staff line, c5 = 0    
                if c5 = 0 
                  c2 = 0 - vpar(12) 
           /* lower dot if more than one track and stem is down 
                  if bit(3,ts(c1,MULTI_TRACK)) = 1 
                    if bit(1,ts(c1,STEM_FLAGS)) = DOWN 
                      c2 = vpar(12) 
                    end 
                  end 
                  c3 -= hpar(34) 
                else 
                  c2 = 0 
                end 
                if ts(c1,TYPE) <= REST 
                  c5 = bit(16,ts(c1,SUBFLAG_1)) 
                else 
                  c5 = CUESIZE 
                end 
                if c5 = 1 
                  c3 = c3 * 8 / 10 
                end 
                c2 += ts(c1,STAFFLOC) 
                c2 -= ts(c1,OBY)       
&dA 
&dA &d@    This code added &dA11/26/06&d@ (as a cludge) to fix a minor bug in the 
&dA &d@      placement extension dots when one is "on top of" another.  
&dA 
                if ts(c1,TYPE) = XNOTE or ts(c1,TYPE) = XCUE_NOTE or ts(c1,TYPE) = XGR_NOTE
                  if abs(old_c2 - c2) < vpar(1) 
                    c2 += vpar(2) 
                  end 
                end 
                old_c2 = c2 
&dA 
&dA                 &d@ End of &dA11/26/06&d@ addition 

             /* c3 = x offset to the dot(s) from obx 
             /* c2 = y offset to the dot(s) from oby 
             /* x * INT10000 + y, shift it over 4 and &dAOR&d@ it with DOT  (modified &dA12-24-96&d@)
                c3 *= INT10000 
                c3 += c2 
                c3 <<= 4                                   /* code modified &dA12-24-96
                ts(c1,DOT) |= c3    
              end 
            repeat 
&dA 
&dA &d@       Adjust the gr(.,.) array to accommodate space for dots 
&dA 
            c17 = 0                                        /* used below 
            loop for c1 = a1 to a2 
              if ts(c1,GLOBAL_XOFF) < INT10000 
                c9 = ts(c1,GLOBAL_XOFF)                    /* global offset 
              end 
              c8 = ts(c1,STAFF_NUM) + 1                    /* staff number 

&dA                       
&dA 
&dA &d@     Special code added to deal with the discrepency in how single vs. multiple
&dA &d@     tracks handle the minimal spacing for dotted rests.   &dA04/19/08&d@ 
&dA &d@     This section computes the value of the right hand border for the dot, c7
&dA &d@     It also sets the exception variable c17 = 1 
&dA 
              c7 = 10000                                 /* "normal" condition

              c3 = ts(c1,DOT) 
              if c3 > 0 

                if c7 = 1

                  ntype = ts(c1,NTYPE) & 0xff 

                  c4 = 0 
                  if ntype <= SIXTEENTH 
                    c4 = EIGHTH - ntype 
                  end 
                  if ntype > QUARTER 
                    c7 = hpar(30) 
                  else 
                    c7 = c4 * hpar(54) + hpar(31) 
                  end 

                  c7 += hpar(80) 

                  if ntype > WHOLE 
                    c4 = hpar(87) * 4 / 3 
                  else 
                    if ntype > QUARTER 
                      c4 = hpar(87) 
                    else 
                      if ntype > EIGHTH 
                        c4 = hpar(88) 
                      else 
                        c4 = EIGHTH - ntype * hpar(54) + hpar(88) 
                      end 
                    end 
                  end 

                  c7 += c4 

                  if ts(c1,DOT) & 0x0e > 0            
                    if ts(c1,DOT) & 0x02 > 0 
                      c7 += hpar(91)                    /* extra shift to second dot
                    end 
                    if ts(c1,DOT) & 0x04 > 0 
                      c7 += hpar(91)                    /* extra shift to third dot
                    end 
                    if ts(c1,DOT) & 0x08 > 0 
                      c7 += hpar(91)                    /* extra shift to fourth dot
                    end 
                  end 
                end 
&dA 
&dA                       

                c4 = c3 & 0x0f               /* dot flag    (modified &dA12-24-96&d@)
                c3 >>= 4                                    /* code modified &dA12-24-96
                c5 = c3 / INT10000           /* x offset 
                c6 = rem                     /* y offset 
                if c6 > INT10000 >> 1 
                  c6 -= INT10000 
                  ++c5 
                end 
                c6 = c6 + vpar(8) * 2 - 1 / vpar(2) - 7 

                c16 = ts(c1,STAFFLOC) + vpar20 * 2 + 1 / vpar(2) - 20 
                c6 = 23 - c16 - c6 

                c5 += c9 + ts(c1,LOCAL_XOFF)               /* final offset for dot
                c5 += hpar(80) 
                if c4 > 1                                  /* code modified &dA12-24-96
                  c5 += hpar(91)              /* second dot 
                  if c4 > 4 
                    c5 += hpar(91)            /* third dot 
                  end 
                  if c4 > 8 
                    c5 += hpar(91)            /* fourth dot 
                  end 
                end 
                if c6 < 46 and c6 > 0 

&dA                       
&dA 
&dA &d@     More code added to deal with the discrepency in how single vs. multiple
&dA &d@     tracks handle the minimal spacing for dotted rests.   &dA04/19/08&d@ 
&dA &d@     This section sets the value of the right hand object "border" gr(.,.) 
&dA 
                  if c7 = 10000                 /* "normal" condition 
                    gr(c8,c6) = c5 
                  else 
                    gr(c8,c6) = c7 
                    if c6 < 44 
                      gr(c8,c6+1) = c7 
                      gr(c8,c6+2) = c7 
                    end 
                  end 
&dA 
&dA                       

                end 
              end 
            repeat 

&dA 
&dA &d@     (5) Compute the x offset (as measured to the left) of any 
&dA &d@             accidental(s) which might precede each note head.
&dA 
&dA &d@       (a) Check the left-hand border from the typesetting operation.  
&dA &d@           If there are any accidentals that could be set on right- 
&dA &d@           shifted note heads, set these first, starting from the 
&dA &d@           top down.  This defines column 1 of the accidentals.  
&dA 
&dA &d@           Otherwise, column one is the first free location to the 
&dA &d@           left of the left-most note head.  
&dA 
&dA &d@       (b) For all remaining accidentals to set, start at the top 
&dA &d@           of the group.  Make successive passes until all accidentals 
&dA &d@           are set.  
&dA 
&dA &d@            1. moving down, put in as many accidentals as possible 
&dA &d@               where the distance between eligible notes (delta) >= 
&dA &d@               vpar(6), with the caviat that you do not put an 
&dA &d@               accidental on the lower half of a second before the 
&dA &d@               upper half of a second (as you move down).  
&dA 
&dA &d@            2. move to the left by the largest thickness of accidentals 
&dA &d@               just placed.  Decide on the direction to move for the 
&dA &d@               next pass and goto (a).  The new direction will be 
&dA &d@               down (again) if the previous pass hit the lowest remaining 
&dA &d@               accidental; otherwise, the new direction will be up.  
&dA 
&dA &d@       (Maximum staves for this code is 2, because this is the size of gl(.,.))
&dA 
            tgroup(1) = 0 
            tgroup(2) = 0 
            tgroup(3) = 0 
            c5 = 0 

            loop for c1 = a1 to a2 
              if ts(c1,AX) > 0 
                c8 = ts(c1,STAFF_NUM) + 1        /* staff number 
                ++tgroup(c8)
                ndata(tgroup(c8),c8) = c1 
                c5 = 1 
              end 
            repeat 
            if c5 = 1                     /* &dADon't change this variable (c5) 
                                          /* &dAuntil task (1) is complete      
              loop for c13 = 1 to 2       /* loop though staves 
                if tgroup(c13) > 0 
                  if a1 = a2              /* simple case (one note group) 
                    c1 = ndata(1,c13)     /* index 
                    c3 = ts(c1,AX) & 0x0f 
                    c16 = ts(c1,STAFFLOC) + vpar20 * 2 + 1 / vpar(2) - 20 
                    c2 = 23 - c16 

                    if ts(c1,TYPE) > REST 
                      c4 = CUESIZE 
                    else 
                      c4 = bit(16,ts(c1,SUBFLAG_1))
                    end 
                    perform place_accidental (c13,c2,c3,c4) /* returns c4 = absolute x

              /* shift offset left 8 and &dAOR&d@ with AX 
                    c4 = 0 - c4 
                    c4 <<= 8             /* &dA02/25/97&d@ shift changed from 4 to 8
                    ts(c1,AX) |= c4       
                  else 
&dA 
&dA &d@        (1) We must re-order elements so that they are in descending 
&dA &d@              order on the staff.  Use bubble sort.  
&dA 
                    loop for c7 = 1 to tgroup(c13) - 1 
                      loop for c8 = c7+1 to tgroup(c13) 
                        c1 = ndata(c7,c13) 
                        c2 = ndata(c8,c13) 
                        if ts(c1,STAFFLOC) > ts(c2,STAFFLOC) 
                          ndata(c7,c13) = c2 
                          ndata(c8,c13) = c1 
                        end 
                      repeat 
                    repeat 
&dA &d@                     
&dA &d@        (2) Try first to set accidentals on "right shifted chords" 
&dA 
                    loop for c8 = 1 to tgroup(c13) 
                      c1 = ndata(c8,c13) 
                      if c8 > 1 
                        c2 = ndata(c8-1,c13) 
                        if c2 < DUMMY_VALUE 
                          c16 = ts(c1,STAFFLOC) - ts(c2,STAFFLOC) 
                          if c16 = vpar(1) or c16 = vpar(1) + 1           /* second
                            if ts(c1,LOCAL_XOFF) < ts(c2,LOCAL_XOFF) 
                              /* don't set accidental in this situation 
                              goto QQQ1 
                            end 
                          end 
                        end 
                      end 
                      c16 = ts(c1,STAFFLOC) + vpar20 * 2 + 1 / vpar(2) - 20 
                      c2 = 23 - c16 

                      c4 = 200 
                      c12 = ts(c1,AX) & 0x0f 
                      c14 = c2 - int("221002200100001"{c12})    /* lower limit 
                      c15 = c2 + int("333003300200003"{c12})    /* upper limit 

                      loop for c3 = c14 to c15 
                        if c3 > 0 and c3 <= 45 
                          if gl(c13,c3) <= 0 
                            c3 = 1000 
                          else 
                            if gl(c13,c3) < c4 
                              c4 = gl(c13,c3) 
                            end 
                          end 
                        end 
                      repeat 
                      if c3 < 1000 
                        c3 = ts(c1,AX) & 0x0f 
                        if ts(c1,TYPE) > REST 
                          c4 = CUESIZE 
                        else 
                          c4 = bit(16,ts(c1,SUBFLAG_1)) 
                        end 
                        perform place_accidental (c13,c2,c3,c4) /* returns c4 = absolute x

                        c3 = ts(c1,GLOBAL_XOFF) 
                        if c3 > INT10000 
                          c3 /= INT10000              /* index of top of chord 
                          c3 = ts(c3,GLOBAL_XOFF) 
                        end 
                        c6 = c3 - c4   /* relative x offset (to the left) 
                  /* shift offset left 8 and &dAOR&d@ with AX 
                        c6 <<= 8                       /* &dA02/25/97&d@ shift changed from 4 to 8
                        ts(c1,AX) |= c6                
                        ndata(c8,c13) = DUMMY_VALUE    /* accidental set 
                      end 
QQQ1: 
                    repeat 
&dA &d@                     
&dA &d@        (3) Now make successive passes until all accidentals are set 
&dA 
                    c10 = DOWN 
                    loop 
                      c6 = 0 
                      loop for c8 = 1 to tgroup(c13) 
                        if ndata(c8,c13) <> DUMMY_VALUE    /* accidental not set
                          c6 = c8 
                        end 
                      repeat 
                      if c6 = 0 
                        goto QQQ2                          /* DONE 
                      end 
                      if c10 = DOWN 
                        c11 = 1 
                        c12 = tgroup(c13) 
                        c9 = 1 
                      else 
                        c11 = tgroup(c13) 
                        c12 = 1 
                        c9 = -1 
                      end 
                      c10 = UP 
                      loop for c8 = c11 to c12 step c9 
                        c1 = ndata(c8,c13) 
                        if c1 = DUMMY_VALUE 
                          goto QQQ3 
                        end 
                        if c8 > 1 
                          c2 = ndata(c8-1,c13) 
                          if c2 < DUMMY_VALUE 
                            c16 = ts(c1,STAFFLOC) - ts(c2,STAFFLOC) 
                            if c16 = vpar(1) or c16 = vpar(1) + 1           /* second
                              if ts(c1,LOCAL_XOFF) < ts(c2,LOCAL_XOFF) 
                                /* don't set accidental in this situation 
                                goto QQQ3 
                              end 
                            end 
                          end 
                        end 
                        if c8 = c6 
                          c10 = DOWN 
                        end 
                        c16 = ts(c1,STAFFLOC) + vpar20 * 2 + 1 / vpar(2) - 20 
                        c2 = 23 - c16 

                        c3 = ts(c1,AX) & 0x0f 
                        if ts(c1,TYPE) > REST 
                          c4 = CUESIZE 
                        else 
                          c4 = bit(16,ts(c1,SUBFLAG_1)) 
                        end 
                        perform place_accidental (c13,c2,c3,c4) /* returns c4 = absolute x

                        c3 = ts(c1,GLOBAL_XOFF) 
                        if c3 > INT10000 
                          c3 /= INT10000              /* index of top of chord 
                          c3 = ts(c3,GLOBAL_XOFF) 
                        end 
                        c15 = c3 - c4   /* relative x offset (to the left) 
                  /* shift offset left 8 and &dAOR&d@ with AX 
                        c15 <<= 8                   /* &dA02/25/97&d@ shift changed from 4 to 8
                        ts(c1,AX) |= c15 
                        ndata(c8,c13) = DUMMY_VALUE    /* accidental set 

QQQ3: 
                      repeat 
                    repeat 
QQQ2: 
                  end 
                end 
              repeat 
            end 
&dA 
&dA &d@   Task (1)         Calculate NODE_SHIFT 
&dA &d@           
            c10 = 0 

            if c17 = 0                       /* set above 

              loop for a3 = 1 to nstaves 
                loop for c11 = 1 to 45 
                  if gl(a3,c11) > pseudo_gl(a3,c11) 
                    gl(a3,c11) = pseudo_gl(a3,c11) 
                  end 
&dA 
&dA &d@              &dA11/19/07&d@ min_space replaces hpar(29) 
&dA 
                  c12 = min_space - gl(a3,c11) - emptyspace(a3,c11) /* should be negative
                  if c12 > c10                                      /* most of the time
                    c10 = c12 
                  end 
                repeat 
              repeat 
              if c5 > 0 and ts(a1,SPACING) = mindist and c10 < hpar(94) 
                c10 = hpar(94) 
              end 

            else 

&dA                          
&dA 
&dA &d@     More code from the &dA04/19/08&d@ cludge 
&dA &d@     This section uses the single-track formula to compute the 
&dA &d@     value of this nodes NODE_SHIFT. 
&dA 
              loop for a3 = 1 to nstaves 
                c7 = 100000 
                loop for c11 = 1 to 45 
                  if emptyspace(a3,c11) < c7 
                    c7 = emptyspace(a3,c11)        /* minimum emptyspace on this staff
                  end 
                repeat 
                c10 = mindist - hpar(82) - c7 
              repeat 
&dA 
&dA                          

            end 
            if c10 > 0 
              ts(a1,NODE_SHIFT) = c10 
            end 
&dA &d@   Task (2) 
            c10 = ts(a1,SPACING) 
            loop for a3 = 1 to nstaves 
              loop for c6 = 1 to 45 
                if pseudo_gr(a3,c6) > gr(a3,c6) 
                  gr(a3,c6) = pseudo_gr(a3,c6) 
                end 
                if gr(a3,c6) = -200 
                  emptyspace(a3,c6) += c10 
                else 
                  emptyspace(a3,c6) = c10 - gr(a3,c6) 
                end 
              repeat 
            repeat 

&dA &d@ &dAÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»&d@ 
&dA &d@ &dAº&d@                                                               &dAº&d@ 
&dA &d@ &dAº&d@   End of where you deal with chords and with multiple passes  &dAº&d@ 
&dA &d@ &dAº&d@                                                               &dAº&d@ 
&dA &d@ &dAÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼&d@ 

          end 
MMMMM: 
&dA 
&dA &d@     We need to check (for now) if the present simultaneity generates 
&dA &d@     a "clash" with the previous simultaneity.  
&dA 
          if olda1 > 0 
            c6 = -1000 
            loop for c3 = 1 to 2 
              loop for c4 = 1 to 45 
                c5 = oldgr(c3,c4) - gl(c3,c4) 
                if c5 > c6 
                  c6 = c5 
                end 
              repeat 
            repeat 
          end 
          loop for c3 = 1 to 2 
            loop for c4 = 1 to 45 
              oldgr(c3,c4) = gr(c3,c4) 
            repeat 
          repeat 
          olda1 = a1 
          a1 = a2  
WWWW: 
        repeat 

&dA 
&dA &d@  &dAÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»&d@ 
&dA &d@  &dAº&d@                                                               &dAº&d@ 
&dA &d@  &dAº&d@   End of calculations on the placement of notes, note-dots,   &dAº&d@ 
&dA &d@  &dAº&d@     and note-accidentals.                                     &dAº&d@ 
&dA &d@  &dAº&d@                                                               &dAº&d@ 
&dA &d@  &dAÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼&d@ 
&dA 

&dA 
&dA &d@  &dAÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»&d@ 
&dA &d@  &dAº &d@                                                                      &dA º&d@ 
&dA &d@  &dAº &d@  At this point, we have a decision to make.  Either we process the   &dA º&d@ 
&dA &d@  &dAº &d@  ts array now (i.e. typeset the music) or we return from this        &dA º&d@ 
&dA &d@  &dAº &d@  procedure and let the ts array continue to grow.  The question that &dA º&d@ 
&dA &d@  &dAº &d@  must be answered is "will all outstanding slurs be processed when   &dA º&d@ 
&dA &d@  &dAº &d@  the ts array is fully processed?"  If "yes", then we can go ahead   &dA º&d@ 
&dA &d@  &dAº &d@  and process the ts array; otherwise, not.                           &dA º&d@ 
&dA &d@  &dAº &d@                                                                      &dA º&d@ 
&dA &d@  &dAº &d@  The information we need is contained in the SLUR_FLAG portion       &dA º&d@ 
&dA &d@  &dAº &d@  of the ts array.  We need to cycle through the array elements we    &dA º&d@ 
&dA &d@  &dAº &d@  have added, taking note of where slurs terminate and where they     &dA º&d@ 
&dA &d@  &dAº &d@  start.  We need a variable to keep track of the state of slur       &dA º&d@ 
&dA &d@  &dAº &d@  completion.  We call this variable bstr "outslurs".  The relevant   &dA º&d@ 
&dA &d@  &dAº &d@  bits will be bits 1 to 8.  When a slur is initiated, the relevant   &dA º&d@ 
&dA &d@  &dAº &d@  bit will be turned on; when a slur is terminated, the relevant      &dA º&d@ 
&dA &d@  &dAº &d@  bit will be turned off.  If at the end of this process,             &dA º&d@ 
&dA &d@  &dAº &d@  outslurs = "00000000", then we can process the array.               &dA º&d@ 
&dA &d@  &dAº &d@                                                                      &dA º&d@ 
&dA &d@  &dAÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼&d@ 
&dA 
        loop for a1 = oldsct+1 to sct 
          nodtype = ts(a1,TYPE)  
          if nodtype <= NOTE_OR_REST
            a2 = ts(a1,SLUR_FLAG) & 0xff 
            a3 = ts(a1,SLUR_FLAG) >> 8 
            a3 &= 0xff00 
            a3 += a2                  /* 16 bits, i.e., stop,start,stop,start etc.
            if a3 > 0 
              a5 = 1 
              loop for a4 = 1 to 8 
                if bit(a5,a3) = 1 
                  if outslurs{a4} = "0"    /* can't stop a non-existant slur 
                    tmess = 28 
                    perform dtalk (tmess) 
                  else 
                    outslurs{a4} = "0" 
                  end 
                end 
                --a5 
                if bit(a5,a3) = 1 
                  if outslurs{a4} = "1"    /* can't start an existing slur 
                    tmess = 29 
                    perform dtalk (tmess) 
                  else 
                    outslurs{a4} = "1" 
                  end 
                end 
                a5 += 3 
              repeat 
            end 
          end 
        repeat 
        if outslurs <> "00000000" 
          goto ACT_RETURN 
        end 
&dA 
&dA &d@   At this point we will be working with the entire ts array.  First 
&dA &d@   thing, we must clear the pseudo tiearr ROWs.  
&dA 
        loop for c7 = 1 to MAX_TIES 
          if tiearr(c7,TIE_SNUM) = INT1000000       /* pseudo super number 
            tiearr(c7,TIE_SNUM) = 0 
          end 
        repeat 
&dA 
&dA &d@    &dASlur Analysis&d@ 
&dA 
&dA &d@    We am now in a position to compile complete information on slurs, 
&dA &d@    so that they can more or less be set properly.  We possess the 
&dA &d@    following information for the notes on which the slur starts and 
&dA &d@    ends: 
&dA &d@                                                                             
&dA &d@      (1) pitch (also whether it is part of a chord, also top or not)        
&dA &d@      (2) stem direction (dist from end of stem, also if beam connects)      
&dA &d@      (3) pass number                                                        
&dA &d@      (4) staff number                                                       
&dA &d@      (5) values of mcat and MULTI                                           
&dA &d@                                                                             
&dA &d@    In addition, we need to compile the following information for each 
&dA &d@    slur: 
&dA &d@                                                                             
&dA &d@      (1) the "high point" and "low point" for all objects on the 
&dA &d@           slur staff between the starting and ending notes.  
&dA &d@                                                                             
&dA &d@    Based on this analysis, it should be possible to state: 
&dA &d@                                                                             
&dA &d@      (1) whether the slur has tips up or down                               
&dA &d@                                                                             
&dA &d@      (2) the x-shift and y-shift for the start of the slur 
&dA &d@                                                                             
&dA &d@      (3) the x-shift and y-shift for the end of the slur 
&dA &d@                                                                             
&dA &d@      (4) any extra curviture that might help the situation                  
&dA &d@                                                                             
&dA &d@    In computing the parameters in (2), (3) and (4), it may be helpful 
&dA &d@    to something about the profile of the desired slur.   For example: 
&dA &d@                                                                             
&dA &d@        *                *               *     * * * * * *     * * * *  
&dA &d@       *    *          *   *         *    *    *         *   *         * 
&dA &d@      *  1.    *    *    2.   *   *    3.  *   *    4.   *   *    5.   * 
&dA &d@      raise start   raise both     raise end    raise both     add to 
&dA &d@                       some                       a lot       curviture 
&dA &d@                                                                             
&dA &d@    &dAStorage of Information&d@ 
&dA &d@                                                                             
&dA &d@    We need to figure out where we are going to store this information.  
&dA &d@    The way this program is constructed, it is possible (in theory at 
&dA &d@    least) for eight slurs to end and for eight slurs to start on the 
&dA &d@    same note.  This could require as many as 32 separate parameters 
&dA &d@    at one ts(.,.) element, to say nothing about the 16 curviture 
&dA &d@    numbers, which must be stored somewhere.  Rather than extend the 
&dA &d@    size of the second dimension of the ts array by this amount, I 
&dA &d@    would rather propose that we add one more element, call it 
&dA &d@    SLUR_X, which would be a pointer to an additional ROW element in the 
&dA &d@    ts array, somewhere below sct (the size of ts, after all, must be 
&dA &d@    much larger than necessary, in order to accommodate 99.99% of all 
&dA &d@    situations).  
&dA 
&dA &d@    While it is possible for eight slurs (four regular and four editorial) 
&dA &d@    to start or end on one chord, I think it is unlikely that more than      
&dA &d@    four would do so.  I would therefore propose that we use a system of 
&dA &d@    flags to define the meaning of a data element within the ROW.  As 
&dA &d@    will be explained below, the first 6 elements of the ROW are reserved 
&dA &d@    for current information about the chord generating the slur, and after 
&dA &d@    this, elements 7 to 32 can be used to hold data on slurs.  We will 
&dA &d@    need to use two elements to contain all of the data.  Let us establish 
&dA &d@    the convention that the first element will contain the key to the 
&dA &d@    meaning of data as well as the type of slur (tips up/down), extra 
&dA &d@    information on curvature, and the x-offset.  Specifically, the key 
&dA &d@    will occupy bits 24-27, with the slur number (1-8) being stored in 
&dA &d@    bits 24-26, and bit 27 being the the start/end flag (0 = start,  
&dA &d@    1 = end).  Bit 16 will be the up/down flag (0 = tips up, 1 = tips 
&dA &d@    down) and bits 17-23 will contain information on extra curvature 
&dA &d@    (this information is necessary only in a slur-end element).  Bits 
&dA &d@    0-15 will contain the x-offset + 1000 (always a positive number).  
&dA &d@    The second element will contain the absolute y-position.  Since 
&dA &d@    there are 26 free elements in the ROW, we can accommodate 13 data 
&dA &d@    groups in this fashion (surely more than necessary).  
&dA 
&dA &d@    Several points to note: 
&dA 
&dA &d@    (1) for purposes of these calculations, and temporary data stroage, 
&dA &d@        it will be simplest to record all y values as absolute y positions 
&dA &d@        (relative to the staff lines).  x values can be stored as offsets.  
&dA 
&dA &d@    (2) In cases where more than one slur starts on a note head, or more 
&dA &d@        than one slur ends on a note head, care must be taken to insure 
&dA &d@        that the "longer" slur stays "on top" (assuming they have tips 
&dA &d@        going in the same direction).  Let's take the situation pictured 
&dA &d@        below: 
&dA 
&dA &d@                    * * * * * * * * slur 1 * * * * * * * * 
&dA &d@                *                                           *          slur 1a
&dA &d@             *                          * * * * slur 2 * * *  *      * 
&dA &d@           *  * slur 4 *             * * slur 3 *             * *  * 
&dA &d@          **             *         **             *             *** 
&dA &d@        note 1         note 2    note 3        note 4          note 5 
&dA &d@                                               
&dA &d@        Slur 1 would be encountered first as we proceeded through the ts 
&dA &d@        array.  If we were to try to process this slur when we first             
&dA &d@        encountered it, we would discover that another slur (slur 2) 
&dA &d@        ended on the same note as slur 1.  Since slur 2 is shorter than   
&dA &d@        slur 1, (and therefore should lie "under" it), we cannot fully    
&dA &d@        process slur 1 until we have processed slur 2.  But in looking back 
&dA &d@        to the beginning of slur 2, we see that another slur (slur 3) also  
&dA &d@        starts on the same note, and that slur 3 (which also we have not     
&dA &d@        seen before) must be processed before we can process slur 2.  
&dA &d@        Clearly we cannot simply follow the rule of "process a slur when 
&dA &d@        you first come to it".  A similar argument can be used to show 
&dA &d@        that you cannot simply work your way through the ts array from 
&dA &d@        end to the start.  
&dA &d@      
&dA &d@        Here is how the process must be conducted:  You proceed forward 
&dA &d@        though the ts array, but do nothing until you encounter the end 
&dA &d@        of a slur (or more than one end, as in the case of note 5 above).  
&dA &d@        If there is more than one slur ending on this note (chord), you can 
&dA &d@        determine which one is shorter by looking backward in the array.  
&dA &d@        The shorter one should be processed first.  In this way, you can 
&dA &d@        always be sure that shorter slurs will be processed before longer 
&dA &d@        ones.  
&dA 
&dA &d@        This method will require extra work in keeping track of what has 
&dA &d@        already been done.  This is the purpose of the first 6 elements of 
&dA &d@        the extra ts ROW element.  In our example above, slur 4 will be the 
&dA &d@        first to be processed.  Since it is the first slur for both note 1 
&dA &d@        and note 2, SLUR_X records must be generated for both of these 
&dA &d@        notes.  In the case of note 2, this is the only slur, but for note 1 
&dA &d@        we will be processing another slur (slur 1) much later.  We need 
&dA &d@        to keep track of what has already transpired as a result of slur 4.  
&dA &d@        The first 6 elements of the SLUR_X ROW element will contain the 
&dA &d@        information listed below: 
&dA &d@        
&dA &d@          (1) current y-position above object for incoming slurs.  
&dA &d@          (2)              "     below   "     "     "       "  .  
&dA &d@          (3)              "     above   "     "  outgoing   "  .  
&dA &d@          (4)              "     below   "     "     "       "  .  
&dA &d@          (5) y-position for staccato, legato, etc.  
&dA &d@          (6) 2 = marks above chord; 1 = marks below chord; 0 = don't use 
&dA 
&dA &d@        Clearly, the information about what has happened at note 1 will 
&dA &d@        be available when it comes time to set slur 1.  
&dA 
&dA &d@        One more thing: in handling this problem, we must deal with a chord 
&dA &d@        as one object.  A chord may be made up of several elements (notes), 
&dA &d@        and slurs coming to or leaving this chord may be coded on separate 
&dA &d@        elements.  Nevertheless, the processing of information requires 
&dA &d@        that all data related to slurs be stored in one place.  Therefore, 
&dA &d@        when a slur ROW element is allocated, the pointer to the element 
&dA &d@        must be put in SLUR_X for &dGall notes in the chord&d@.  
&dA &d@        
&dA &d@    (3) It should be noted that the smallest meaningful resolution of a 
&dA &d@        y-position as far as slurs are concerned is vpar(1), since the 
&dA &d@        printing program treats these shifts as adjusted note positions.  
&dA &d@                       
&dA &d@    (4) The curvature parameter should be a number from 0 to 9 (9 being 
&dA &d@        the most curved).  The printing program actually uses a look-up 
&dA &d@        method to determine which slur to put in a particular position.  
&dA &d@        One of the characterizations of such a slur is its curvature 
&dA &d@        (this is part of the slur number).  It only makes sense to change 
&dA &d@        this number if the new curvature is more than the "look up" 
&dA &d@        value.  Since increasing the curvature will put the "cross part" 
&dA &d@        of the slur at a different height, a new curvature should only 
&dA &d@        be suggested in those cases where it is thought that the slur 
&dA &d@        will not be interfering with staff lines.  One other thing: 
&dA &d@        we do not know the final length of the slur until print time.  
&dA &d@        It turns out that for slurs longer than a certain length 
&dA &d@        (I think about .6 inches) there are varients available which 
&dA &d@        are asymmetric (where the relative high point comes either 
&dA &d@        earlier or later in the slur).  It is possible to "make a 
&dA &d@        suggestion" to the print program that an asymmetric slur 
&dA &d@        be used, if one is available.  Adding 10 to the curvature 
&dA &d@        will suggest that the high point be delayed; and adding 20 
&dA &d@        to the curvature will suggest that the high point come  
&dA &d@        earlier.  Actually, as I remember it, slurs longer about 1.3 
&dA &d@        inches only come in asymmetric versions, so for slurs that 
&dA &d@        appear to be really long (either many notes, or multiple 
&dA &d@        measures), it might actually be helpful to make a recommendation.  
&dA &d@                       
&dA &d@                 S U M M A R Y   O F   I N F O R M A T I O N   (TS32) 
&dA &d@                 ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA &d@                       
&dA &d@    1. A slur is processed when its &dGend&d@ is encountered.  If there is more 
&dA &d@       than one slur on a &dGchord&d@, the shortest one is processed first.  If 
&dA &d@       more than one of the same length is encountered, the one on the 
&dA &d@       lowest note is processed first.  
&dA &d@        
&dA &d@    2. The first time a slur is encountered on a chord, a new ts ROW 
&dA &d@       element is allocated and a pointer to it is placed in the SLUR_X 
&dA &d@       element for all notes in the chord.  
&dA &d@                       
&dA &d@    3. The first six elements of a slur ROW element are reserved for the 
&dA &d@       following information: 
&dA &d@                       
&dA &d@          (1) current y-position above object for incoming slurs.  
&dA &d@          (2)              "     below   "     "     "       "  .  
&dA &d@          (3)              "     above   "     "  outgoing   "  .  
&dA &d@          (4)              "     below   "     "     "       "  .  
&dA &d@          (5) y-position for staccato, legato, etc.  
&dA &d@          (6) 2 = marks above chord; 1 = marks below chord; 0 = don't use 
&dA &d@                       
&dA &d@    4. Specific information about slurs coming to or leaving a chord is 
&dA &d@       stored in groups of three (up from two &dA05/06/03&d@) elements, starting 
&dA &d@       with element 7.  The format is as follows: 
&dA &d@                       
&dA &d@       first element 
&dA &d@       ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA &d@          bit 27:     start/end flag (0 = start, 1 = end) 
&dA &d@          bits 24-26: slur number - 1 (0 to 7) 
&dA &d@          bits 17-23: curvature information (end only) 
&dA &d@          bit 16:     up/down flag (0 = tips up, 1 = tips down) (end only) 
&dA &d@          bits 0-15:  x-offset + 1000 (always a positive number) 
&dA &d@       second element 
&dA &d@       ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA &d@          y position relative to the staff 
&dA &d@       third element (added &dA05/06/03&d@) 
&dA &d@       ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA &d@          integer equivalent of 4-byte print suggestion for slur 
&dA &d@                       

&dA 
&dA &d@          &dA  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿  
&dA &d@          &dA  ³ &d@                                       &dA ³  
&dA &d@          &dA  ³ &d@   P R O C E S S I N G    S L U R S    &dA ³  
&dA &d@          &dA  ³ &d@                                       &dA ³  
&dA &d@          &dA  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
&dA 

        a14 = sct + 2                   /* SLUR_X pointer 

        loop for a1 = 1 to sct 
          nodtype = ts(a1,TYPE) 
          if nodtype > NOTE_OR_REST 
            goto YYYY 
          end 
          a4 = ts(a1,SLUR_FLAG) & 0x00aa00aa 
          if a4 > 0                     /* a slur ends here 
&dA 
&dA &d@     Compile a list of all slurs that end on this note and on any  
&dA &d@       other (lower) notes in this chord.  
&dA 
            a5 = a4 >> 1 
            a5 &= 0x00ff00ff            /* a list of starts to look for 
            ndata(1,1) = a5 
            ndata(1,2) = a1 
            pcnt = 1 
            perform get_topbottom (a1,c1,c2) 
            loop for a2 = a1+1 to c2 
              a4 = ts(a2,SLUR_FLAG) & 0x00aa00aa 
              if a4 > 0                 /* a slur ends here 
                a5 = a4 >> 1 
                a5 &= 0x00ff00ff        /* a list of starts to look for 
                ++pcnt 
                ndata(pcnt,1) = a5 
                ndata(pcnt,2) = a2 
              end 
            repeat 
            a1 = c2       /* so that we don't look at these notes again 
            nsgroups = 0 
            c9 = pcnt                            /* moved here from +3 lines &dA09/28/93
            loop for c7 = c1-1 to 1 step -1 
              if ts(c7,TYPE) <= NOTE_OR_REST 
                a6 = ts(c7,SLUR_FLAG) & 0x00550055   /* starts on this note 
                loop for c8 = 1 to pcnt 
                  a5 = ndata(c8,1)            /* list of starts for this note of chord
                  a2 = ndata(c8,2)            /* index to this note of chord 
                  a7 = a6 & a5                /* a7 = matches 
                  if a7 > 0 
                    c11 = a7 >> 8 
                    c11 &= 0xff00 
                    c11 += a7 & 0xff                 /* compact a7 into 16 bits

                    a7 = not(a7) 
                    a5 &= a7                         /* remove this slur from a5
                    ndata(c8,1) = a5 

                    c10 = 0                   /* slur number - 1 
                    c6 = a2 
                    loop while c11 > 0 
                      if bit(0,c11) = 1  
                        c4 = c10 & 0x03              /* slur number mod(4)        
                        c5 = 1 << (c4 * 2) 
                        c5 <<= 8 
                        if c5 & ts(c7,SLUR_FLAG) > 0   /* this slur is forced 
                          c5 <<= 1 
                          if c5 & ts(c7,SLUR_FLAG) = 0 
                            c6 |= 0x00010000      /* this is a "force over" slur
                          else 
                            c6 |= 0x00020000      /* this is a "force under" slur
                          end 
                        end 
                        ++nsgroups 
                        sgroup(nsgroups,1) = c7   /* record index starting note
                        sgroup(nsgroups,2) = c6   /* record index ending note (+ flags)
                        sgroup(nsgroups,3) = c10  /* slur number - 1 
                      end 
                      c11 >>= 2 
                      ++c10 
                    repeat 

                    if a5 = 0 
                      --c9 
                      if c9 = 0         /* no more slurs to look for 
                        c7 = 0 
                      end 
                    end 
                  end 
                repeat 
              end 
            repeat 
            if nsgroups = 0 or c9 > 0 
              tmess = 30 
              perform dtalk (tmess) 
            end 
&dA &d@             
&dA &d@     At this point, we have a list of slurs which end on this chord.  
&dA &d@     We need to decide what to do with them.  We certainly can proceed 
&dA &d@     by looping though the group, but we should probably first learn 
&dA &d@     something about the chords we are dealing with.  For example, 
&dA &d@     is the stem up or down?  Where on the chords do the slurs attach?  
&dA &d@     Do the note heads (or chords) have staccato, legato or spiccato 
&dA &d@     marks on them?  (Remember that the notes of a chord have been 
&dA &d@     re-ordered so that the top note comes first; i.e., the top note 
&dA &d@     head may not be at the note end of the stem.)   The purpose of 
&dA &d@     all of this "research" is basically to answer the following 
&dA &d@     two questions: 
&dA 
&dA &d@        (1) should the slur be oriented with tips up or tips down, and 
&dA 
&dA &d@        (2) should the slur take its position from the note head or 
&dA &d@              from the end of the stem?  
&dA 
&dA &d@     I think I have found a system which will at least (1) give an answer         
&dA &d@     to every possible situation, and (2) give "right" answers for most 
&dA &d@     situations.  Essentially, what I will use is "situation based" 
&dA &d@     programming, rather than "rule based" programming.  I have described 
&dA &d@     all possible situations under two conditions: (1) the final note 
&dA &d@     has the multi-track flag = 0, and (2) the final note has the multi-track 
&dA &d@     flag > 0.  These templates are laid out below 
&dA 
&dA &d@ I. Final note multi-track flag = 0 
&dA 
&dA &d@  starting note            ending note        x-shift stem option           overrides
&dA &d@ stem  position         stem   position  tips 1st 2nd 1st 2nd          code over under
&dA &d@ ÄÄÄÄÄÄÄÄÄÄÄÄÄÄ         ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÂÄÄÄÄÂ
&dA &d@ up    single        up     single      ³ up ³H    H ³  no            ³  F ³  l ³  F ³
&dA &d@ (multi-track = 0)   up    top of many  ³down³  no   ³s    s          ³  p ³  p ³  G ³
&dA &d@                     up  middle of many ³down³nr   Y ³  no            ³  m ³  p ³  H ³
&dA &d@                     up  bottom of many ³ up ³H    H ³  no            ³  F ³  p ³  F ³
&dA &d@                    down    single      ³down³nr   H ³s    H (if flag)³  j ³  j ³  I ³
&dA &d@                    down   top of many  ³down³  no   ³s    H          ³  o ³  o ³  G ³
&dA &d@                    down middle of many ³down³nr   H ³                ³  i ³  i ³  O ³
&dA &d@                    down bottom of many ³ up ³  no   ³H    s          ³  O ³  o ³  O ³
&dA &d@                                        ³    ³       ³                ³    ³    ³    ³
&dA &d@ up    single        up     single      ³down³nr   H ³s    s (mid stf)³  l ³  l ³  F ³
&dA &d@ (multi-track > 0)   up    top of many  ³down³  no   ³s    s          ³  p ³  p ³  G ³
&dA &d@                     up  middle of many ³down³nr   Y ³  no            ³  m ³  p ³  H ³
&dA &d@                     up  bottom of many ³ up ³H    H ³  no            ³  F ³  p ³  F ³
&dA &d@                    down    single      ³down³  no   ³s    H          ³  o ³  j ³  I ³
&dA &d@                    down   top of many  ³down³  no   ³s    H          ³  o ³  o ³  G ³
&dA &d@                    down middle of many ³down³nr   H ³                ³  i ³  i ³  O ³
&dA &d@                    down bottom of many ³ up ³  no   ³H    s          ³  O ³  o ³  O ³
&dA &d@                                        ³    ³       ³                ³    ³    ³    ³
&dA &d@ up   top of many    up     single      ³down³  no   ³s    s          ³  p ³  p ³  F ³
&dA &d@ (multi-track = 0)   up    top of many  ³down³nr   n ³s    s (no oths)³  h ³  h ³  N ³
&dA &d@ (multi-track > 0)   up  middle of many ³down³  no   ³s    s          ³  p ³  p ³  F ³
&dA &d@                     up  bottom of many ³ up ³H    H ³  no            ³  F ³  p ³  F ³
&dA &d@                    down    single      ³down³  no   ³s    H          ³  o ³  o ³  I ³
&dA &d@                    down   top of many  ³down³nr   H ³s    H (no oths)³  k ³  k ³  N ³
&dA &d@                    down middle of many ³down³  no   ³s    H          ³  o ³  o ³  G ³
&dA &d@                    down bottom of many ³down³nr   H ³  no            ³  i ³  i ³  G ³
&dA &d@                                        ³    ³       ³                ³    ³    ³    ³
&dA &d@ up middle of many   up     single      ³down³Yr   n ³  no            ³  f ³  f ³  F ³
&dA &d@ (multi-track = 0)   up    top of many  ³down³Yr   n ³  no            ³  f ³  f ³  F ³
&dA &d@ (multi-track > 0)   up  middle of many ³down³nr   nl³  no            ³  n ³  n ³  N ³
&dA &d@                     up  bottom of many ³ up ³H    H ³  no            ³  F ³  r ³  F ³
&dA &d@                    down    single      ³down³Yr   H ³  no            ³  g ³  g ³  I ³
&dA &d@                    down   top of many  ³down³Yr   H ³  no            ³  g ³  g ³  G ³
&dA &d@                    down middle of many ³down³nr   nl³  no            ³  n ³  n ³  N ³
&dA &d@                    down bottom of many ³ up ³H    nl³  no            ³  H ³  g ³  H ³
&dA &d@                                        ³    ³       ³                ³    ³    ³    ³
&dA &d@ up botton of many   up     single      ³ up ³H    H ³  no            ³  F ³  f ³  F ³
&dA &d@ (multi-track = 0)   up    top of many  ³down³Yr   n ³  no            ³  f ³  f ³  F ³
&dA &d@ (multi-track > 0)   up  middle of many ³ up ³H    H ³  no            ³  F ³  s ³  F ³
&dA &d@                     up  bottom of many ³ up ³H    H ³  no            ³  F ³  n ³  F ³
&dA &d@                    down    single      ³ up ³H    nl³H    s (positio)³  I ³  g ³  I ³
&dA &d@                    down   top of many  ³down³Yr   H ³  no            ³  g ³  g ³  G ³
&dA &d@                    down middle of many ³ up ³H    Yl³                ³  G ³  g ³  G ³
&dA &d@                    down bottom of many ³ up ³H    nl³H    s (p n oth)³  J ³  n ³  J ³
&dA &d@                                        ³    ³       ³                ³    ³    ³    ³
&dA &d@ down  single        up     single      ³down³H    n ³H    s (positio)³  c ³  c ³  B ³
&dA &d@ (multi-track = 0)   up    top of many  ³down³H    n ³H    s (positio)³  c ³  c ³  B ³
&dA &d@                     up  middle of many ³down³H    Y ³  no            ³  e ³  e ³  B ³
&dA &d@                     up  bottom of many ³ up ³n    H ³s    H (positio)³  B ³  e ³  B ³
&dA &d@                    down    single      ³down³H    H ³  no            ³  d ³  d ³  E ³
&dA &d@                    down   top of many  ³down³H    H ³  no            ³  d ³  d ³  C ³
&dA &d@                    down middle of many ³down³H    H ³  no            ³  d ³  d ³  C ³
&dA &d@                    down bottom of many ³ up ³  no   ³s    s          ³  Q ³  d ³  Q ³
&dA &d@                                        ³    ³       ³                ³    ³    ³    ³
&dA &d@ down  single        up     single      ³ up ³n    H ³s    H (positio)³  B ³  c ³  B ³
&dA &d@ (multi-track > 0)   up    top of many  ³down³H    n ³  no            ³  a ³  c ³  B ³
&dA &d@                     up  middle of many ³ up ³n    H ³  no            ³  A ³  e ³  B ³
&dA &d@                     up  bottom of many ³ up ³  no   ³s    H          ³  P ³  e ³  B ³
&dA &d@                    down    single      ³ up ³n    nl³s    s (mid stf)³  E ³  d ³  E ³
&dA &d@                    down   top of many  ³down³H    H ³  no            ³  d ³  d ³  C ³
&dA &d@                    down middle of many ³ up ³  no   ³s    s          ³  Q ³  d ³  C ³
&dA &d@                    down bottom of many ³ up ³  no   ³s    s          ³  Q ³  d ³  Q ³
&dA &d@                                        ³    ³       ³                ³    ³    ³    ³
&dA &d@ down  top of many   up     single      ³down³H    n ³H    s (positio)³  c ³  c ³  K ³
&dA &d@ (multi-track = 0)   up    top of many  ³down³H    n ³H    s (p n oth)³  b ³  b ³  C ³
&dA &d@ (multi-track > 0)   up  middle of many ³down³H    Y ³  no            ³  e ³  e ³  K ³
&dA &d@                     up  bottom of many ³down³H    Y ³  no            ³  e ³  e ³  K ³
&dA &d@                    down    single      ³down³H    H ³  no            ³  d ³  d ³  Q ³
&dA &d@                    down   top of many  ³down³H    H ³  no            ³  d ³  d ³  N ³
&dA &d@                    down middle of many ³down³H    H ³  no            ³  d ³  d ³  L ³
&dA &d@                    down bottom of many ³ up ³Y    nl³  no            ³  M ³  d ³  M ³
&dA &d@                                        ³    ³       ³                ³    ³    ³    ³
&dA &d@ down middle of many up     single      ³ up ³Y    H ³  no            ³  K ³  c ³  K ³
&dA &d@ (multi-track = 0)   up    top of many  ³down³H    n ³  no            ³  a ³  a ³  K ³
&dA &d@ (multi-track > 0)   up  middle of many ³ up ³nr   nl³  no            ³  N ³  n ³  N ³
&dA &d@                     up  bottom of many ³ up ³Y    H ³  no            ³  K ³  a ³  K ³
&dA &d@                    down    single      ³down³H    H ³  no            ³  d ³  d ³  M ³
&dA &d@                    down   top of many  ³down³H    H ³  no            ³  d ³  d ³  L ³
&dA &d@                    down middle of many ³ up ³nr   nl³  no            ³  N ³  n ³  N ³
&dA &d@                    down bottom of many ³ up ³Y    nl³  no            ³  M ³  d ³  M ³
&dA &d@                                        ³    ³       ³                ³    ³    ³    ³
&dA &d@ down bottom of many up     single      ³ up ³n    H ³s    H (positio)³  B ³  c ³  B ³
&dA &d@ (multi-track = 0)   up    top of many  ³down³H    n ³  no            ³  a ³  a ³  K ³
&dA &d@ (multi-track > 0)   up  middle of many ³ up ³n    H ³  no            ³  A ³  e ³  A ³
&dA &d@                     up  bottom of many ³ up ³n    H ³  no            ³  A ³  n ³  A ³
&dA &d@                    down    single      ³ up ³n    nl³s    s (mid stf)³  E ³  d ³  E ³
&dA &d@                    down   top of many  ³ up ³n    Yl³  no            ³  C ³  d ³  C ³
&dA &d@                    down middle of many ³ up ³n    Yl³  no            ³  C ³  d ³  C ³
&dA &d@                    down bottom of many ³ up ³n    nl³s    s (no oths)³  D ³  n ³  D ³
&dA 
&dA 
&dA &d@ II. Final note multi-track flag > 0 
&dA 
&dA &d@  starting note            ending note        x-shift stem option              (same)
&dA &d@ stem  position         stem   position  tips 1st 2nd 1st 2nd          code  (overrides)
&dA &d@ ÄÄÄÄÄÄÄÄÄÄÄÄÄÄ         ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂ
&dA &d@ up    single        up     single      ³down³nr   H ³s    s (mid stf)³  l ³ 
&dA &d@ (multi-track = 0)   up    top of many  ³down³  no   ³s    s          ³  p ³ 
&dA &d@                     up  middle of many ³down³nr   Y ³  no            ³  m ³ 
&dA &d@                     up  bottom of many ³ up ³H    H ³  no            ³  F ³ 
&dA &d@                    down    single      ³ up ³H    nl³H    s (positio)³  I ³ 
&dA &d@                    down   top of many  ³ up ³H    Yl³  no            ³  G ³ 
&dA &d@                    down middle of many ³ up ³H    Yl³  no            ³  G ³ 
&dA &d@                    down bottom of many ³ up ³  no   ³H    s          ³  O ³ 
&dA &d@                                        ³    ³       ³                ³    ³ 
&dA &d@ up    single        up     single      ³down³nr   H ³s    s (mid stf)³  l ³ 
&dA &d@ (multi-track > 0)   up    top of many  ³down³  no   ³s    s          ³  p ³ 
&dA &d@                     up  middle of many ³down³nr   Y ³  no            ³  m ³ 
&dA &d@                     up  bottom of many ³ up ³H    H ³  no            ³  F ³ 
&dA &d@                    down    single      ³ up ³  no   ³H    s          ³  O ³ 
&dA &d@                    down   top of many  ³ up ³H    Yl³  no            ³  G ³ 
&dA &d@                    down middle of many ³ up ³  no   ³H    s          ³  O ³ 
&dA &d@                    down bottom of many ³ up ³  no   ³H    s          ³  O ³ 
&dA &d@                                        ³    ³       ³                ³    ³ 
&dA &d@ up   top of many    up     single      ³down³  no   ³s    s          ³  p ³ 
&dA &d@ (multi-track = 0)   up    top of many  ³down³nr   n ³s    s (no oths)³  h ³ 
&dA &d@ (multi-track > 0)   up  middle of many ³down³  no   ³s    s          ³  p ³ 
&dA &d@                     up  bottom of many ³ up ³H    H ³  no            ³  F ³ 
&dA &d@                    down    single      ³down³  no   ³s    H          ³  o ³ 
&dA &d@                    down   top of many  ³down³nr   H ³  no            ³  i ³ 
&dA &d@                    down middle of many ³ up ³H    Yl³  no            ³  G ³ 
&dA &d@                    down bottom of many ³ up ³H    nl³  no            ³  H ³ 
&dA &d@                                        ³    ³       ³                ³    ³ 
&dA &d@ up middle of many   up     single      ³down³Yr   n ³  no            ³  f ³ 
&dA &d@ (multi-track = 0)   up    top of many  ³down³Yr   n ³  no            ³  f ³ 
&dA &d@ (multi-track > 0)   up  middle of many ³down³nr   nl³  no            ³  n ³ 
&dA &d@                     up  bottom of many ³ up ³H    H ³  no            ³  F ³ 
&dA &d@                    down    single      ³down³Yr   H ³  no            ³  g ³ 
&dA &d@                    down   top of many  ³down³Yr   H ³  no            ³  g ³ 
&dA &d@                    down middle of many ³ up ³nr   nl³  no            ³  N ³ 
&dA &d@                    down bottom of many ³ up ³H    nl³  no            ³  H ³ 
&dA &d@                                        ³    ³       ³                ³    ³ 
&dA &d@ up botton of many   up     single      ³ up ³H    H ³  no            ³  F ³ 
&dA &d@ (multi-track = 0)   up    top of many  ³down³Yr   n ³  no            ³  f ³ 
&dA &d@ (multi-track > 0)   up  middle of many ³ up ³H    H ³  no            ³  F ³ 
&dA &d@                     up  bottom of many ³ up ³H    H ³  no            ³  F ³ 
&dA &d@                    down    single      ³ up ³H    nl³H    s (positio)³  I ³ 
&dA &d@                    down   top of many  ³down³Yr   H ³  no            ³  g ³ 
&dA &d@                    down middle of many ³ up ³H    Yl³  no            ³  G ³ 
&dA &d@                    down bottom of many ³ up ³H    nl³H    s (p n oth)³  J ³ 
&dA &d@                                        ³    ³       ³                ³    ³ 
&dA &d@ down   single       up     single      ³down³H    n ³H    s (positio)³  c ³ 
&dA &d@ (multi-track = 0)   up    top of many  ³down³H    n ³H    s (positio)³  c ³ 
&dA &d@                     up  middle of many ³down³H    Y ³  no            ³  e ³ 
&dA &d@                     up  bottom of many ³ up ³n    H ³s    H (positio)³  B ³ 
&dA &d@                    down    single      ³ up ³n    nl³s    s (mid stf)³  E ³ 
&dA &d@                    down   top of many  ³ up ³n    Yl³  no            ³  C ³ 
&dA &d@                    down middle of many ³ up ³  no   ³s    s          ³  Q ³ 
&dA &d@                    down bottom of many ³ up ³  no   ³s    s          ³  Q ³ 
&dA &d@                                        ³    ³       ³                ³    ³ 
&dA &d@ down   single       up     single      ³down³H    n ³H    s (positin)³  c ³ 
&dA &d@ (multi-track > 0)   up    top of many  ³down³H    H ³  no            ³  d ³ 
&dA &d@                     up  middle of many ³down³H    Y ³  no            ³  e ³ 
&dA &d@                     up  bottom of many ³ up ³n    H ³  no            ³  A ³ 
&dA &d@                    down    single      ³ up ³n    nl³s    s (mid stf)³  E ³ 
&dA &d@                    down   top of many  ³ up ³n    Yl³  no            ³  C ³ 
&dA &d@                    down middle of many ³ up ³  no   ³s    s          ³  Q ³ 
&dA &d@                    down bottom of many ³ up ³  no   ³s    s          ³  Q ³ 
&dA &d@                                        ³    ³       ³                ³    ³ 
&dA &d@ down  top of many   up     single      ³down³H    n ³H    s (positio)³  c ³ 
&dA &d@ (multi-track = 0)   up    top of many  ³down³H    n ³H    s (p n oth)³  b ³ 
&dA &d@ (multi-track > 0)   up  middle of many ³down³H    Y ³  no            ³  e ³ 
&dA &d@                     up  bottom of many ³down³H    Y ³  no            ³  e ³ 
&dA &d@                    down    single      ³down³H    H ³  no            ³  d ³ 
&dA &d@                    down   top of many  ³down³H    H ³  no            ³  d ³ 
&dA &d@                    down middle of many ³ up ³Y    Yl³  no            ³  L ³ 
&dA &d@                    down bottom of many ³ up ³Y    nl³  no            ³  M ³ 
&dA &d@                                        ³    ³       ³                ³    ³ 
&dA &d@ down middle of many up     single      ³ up ³Y    H ³  no            ³  K ³ 
&dA &d@ (multi-track = 0)   up    top of many  ³down³H    n ³  no            ³  a ³ 
&dA &d@ (multi-track > 0)   up  middle of many ³ up ³nr   nl³  no            ³  N ³ 
&dA &d@                     up  bottom of many ³ up ³Y    H ³  no            ³  K ³ 
&dA &d@                    down    single      ³ up ³Y    nl³  no            ³  M ³ 
&dA &d@                    down   top of many  ³down³H    H ³  no            ³  d ³ 
&dA &d@                    down middle of many ³ up ³nr   nl³  no            ³  N ³ 
&dA &d@                    down bottom of many ³ up ³Y    nl³  no            ³  M ³ 
&dA &d@                                        ³    ³       ³                ³    ³ 
&dA &d@ down bottom of many up     single      ³ up ³n    H ³  no            ³  A ³ 
&dA &d@ (multi-track = 0)   up    top of many  ³down³H    n ³  no            ³  a ³ 
&dA &d@ (multi-track > 0)   up  middle of many ³ up ³n    H ³  no            ³  A ³ 
&dA &d@                     up  bottom of many ³ up ³n    H ³  no            ³  A ³ 
&dA &d@                    down    single      ³ up ³n    nl³s    s (mid stf)³  E ³ 
&dA &d@                    down   top of many  ³ up ³n    Yl³  no            ³  C ³ 
&dA &d@                    down middle of many ³ up ³n    Yl³  no            ³  C ³ 
&dA &d@                    down bottom of many ³ up ³n    nl³s    s (p n oth)³  D ³ 
&dA 
&dA 
&dA &d@                            Meaning of codes 
&dA &d@                ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA 
&dA &d@                           x-shift    stem option 
&dA &d@            code   tips    1st  2nd    1st  2nd 
&dA &d@            ÄÄÄÄÄ ÄÄÄÄÄÄ  ÄÄÄÄÄÄÄÄÄÄ  ÄÄÄÄÄÄÄÄÄÄÄ 
&dA &d@              A     up      n    H        no 
&dA &d@              B     up      n    H      s    H (position) 
&dA &d@              C     up      n    Yl       no 
&dA &d@              D     up      n    nl     s    s (no others) 
&dA &d@              E     up      n    nl     s    s (mid stuff) 
&dA &d@              F     up      H    H        no 
&dA &d@              G     up      H    Yl       no 
&dA &d@              H     up      H    nl       no 
&dA &d@              I     up      H    nl     H    s (position) 
&dA &d@              J     up      H    nl     H    s (pos no oth) 
&dA &d@              K     up      Y    H        no 
&dA &d@              L     up      Y    Yl       no 
&dA &d@              M     up      Y    nl       no 
&dA &d@              N     up      nr   nl       no 
&dA &d@              O     up        no        H    s 
&dA &d@              P     up        no        s    H 
&dA &d@              Q     up        no        s    s 
&dA 
&dA &d@              a    down     H    n        no 
&dA &d@              b    down     H    n      H    s (pos no oth) 
&dA &d@              c    down     H    n      H    s (position) 
&dA &d@              d    down     H    H        no 
&dA &d@              e    down     H    Y        no 
&dA &d@              f    down     Yr   n        no 
&dA &d@              g    down     Yr   H        no 
&dA &d@              h    down     nr   n      s    s (no oths) 
&dA &d@              i    down     nr   H        no 
&dA &d@              j    down     nr   H      s    H (if flag) 
&dA &d@              k    down     nr   H      s    H (no oths) 
&dA &d@              l    down     nr   H      s    s (mid stuff) 
&dA &d@              m    down     nr   Y        no 
&dA &d@              n    down     nr   nl       no 
&dA &d@              o    down       no        s    H 
&dA &d@              p    down       no        s    s 
&dA 
&dA 
&dA &d@                              Extra codes 
&dA &d@                            Meaning of codes 
&dA &d@                ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA 
&dA &d@                           x-shift     2nd option 
&dA &d@            code   tips    1st  2nd    1st  2nd 
&dA &d@            ÄÄÄÄÄ ÄÄÄÄÄÄ  ÄÄÄÄÄÄÄÄÄÄ  ÄÄÄÄÄÄÄÄÄÄÄ 
&dA &d@              R     up      n    nl       no 
&dA 
&dA 
&dA &d@              q    down     nr   n        no 
&dA &d@              r    down     Yr   Yl       no 
&dA &d@              s    down     Yr   Y        no 
&dA &d@              t    down       no        H    s 
&dA 
&dA &d@     This information is combined into a 160 byte string.  By correctly 
&dA &d@     diagnosing the situation, we can therefore determine what actions 
&dA &d@     should be taken.  For both and starting note and the ending note 
&dA &d@     we need to determine:  
&dA 
&dA &d@        (1) multi-track flag? (zero or non-zero) 
&dA &d@        (2) stem direction?   (up or down)   
&dA &d@        (3) note catagory?    (single, top of many, 
&dA &d@                               middle of many, bottom of many) 
&dA &d@          

&dA &d@        &dA  ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»   
&dA &d@        &dA  º   This is the loop which processes slurs   º   
&dA &d@        &dA  ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼   

            loop for a4 = 1 to nsgroups   /* loop through all slurs ending on this chord
              a6 = sgroup(a4,1) 
              a7 = sgroup(a4,2) 
              c7 = a7 >> 16                   /* get forced slur flag 
              a7 &= 0xffff                    /* clean up index 
&dA 
&dA &d@        1a. Get information on starting note 
&dA 
&dA &d@             c1 = multi-track flag for this note 
&dA &d@             c2 = stem direction for this note 
&dA &d@             c3 = note catagory for this note:  0 = single 
&dA &d@                                                1 = top of many 
&dA &d@                                                2 = middle of many 
&dA &d@                                                3 = bottom of many 
&dA &d@             c7 = forced slur flag 
&dA 
              c1 = ts(a6,MULTI_TRACK) >> 2 
              c2 = bit(1,ts(a6,STEM_FLAGS)) 
              c3 = bit(2,ts(a6,STEM_FLAGS)) 
              if c3 = 1 and bit(3,ts(a6,STEM_FLAGS)) = 1 
                ++c3 
                if ts(a6+1,TYPE) <> ts(a6,TYPE) 
                  ++c3 
                end 
              end 
&dA 
&dA &d@        1b. Get information on ending note 
&dA 
&dA &d@             c4 = multi-track flag for this note 
&dA &d@             c5 = stem direction for this note 
&dA &d@             c6 = note catagory for this note:  0 = single 
&dA &d@                                                1 = top of many 
&dA &d@                                                2 = middle of many 
&dA &d@                                                3 = bottom of many 
&dA 
              c4 = ts(a7,MULTI_TRACK) >> 2 
              c5 = bit(1,ts(a7,STEM_FLAGS)) 
              c6 = bit(2,ts(a7,STEM_FLAGS)) 
              if c6 = 1 and bit(3,ts(a7,STEM_FLAGS)) = 1 
                ++c6 
                if ts(a7+1,TYPE) <> ts(a7,TYPE) 
                  ++c6 
                end 
              end 
&dA 
&dA &d@        1c. Modify multi-track flags under certain conditions 
&dA 
              if c1 > 0 and c4 > 0     /* &dACHANGED&d@ from = 3  on 9-10-93 
                if ts(a6,PASSNUM) = ts(a7,PASSNUM) and c2 = c5 
                  if ts(a6,PASSNUM) = 1 and c2 = DOWN 
                    c1 = 0 
                    c4 = 0 
                  end 
                  if ts(a6,PASSNUM) = 2 and c2 = UP  
                    c1 = 0 
                    c4 = 0 
                  end 
                end 
              end 
&dA 
&dA &d@     2. Derive "situation" letter from c1 - c7.  
&dA &d@                 
              c8 = c3 
              if c8 <> 0 or c1 <> 0 
                ++c8 
              end 
              if c2 = DOWN 
                c8 += 5 
              end 
              if c4 > 0 and c7 = 0 
                c8 += 10 
              end 
              c8 *= 8                /* c8 ranges by 8's from 0 to 19*8 
              c8 += c6 
              if c5 = DOWN 
                c8 += 4 
              end 
              ++c8                   /* c8 ranges from 1 to 160 (1 to 80 for forced slurs)
              if c7 = 0 
                slurlet = slurstr{c8} 
                if c1 = 0 and c4 = 0 
                  if chr(ts(a6,TYPE)) in [GR_NOTE,XGR_NOTE] 
                    if chr(ts(a7,TYPE)) in [NOTE,XNOTE] 
                      slurlet = slurunder{c8}   /* force under 
                    end 
                  end 
                end 
              else 
                if c7 = 1 
                  slurlet = slurover{c8}    /* force over 
                else 
                  slurlet = slurunder{c8}   /* force under 
                end 
              end 
&dA 
&dA &d@     2a. Attempt to account for interfering beams 
&dA 
              if ts(a6,TYPE) < GR_NOTE or ts(a7,TYPE) > XNOTE 
                if "abcIJijAB" con slurlet 
                  if mpt < 6 
                    c12 = ts(a7,BEAM_FLAG) 
                    if c12 = CONT_BEAM or c12 = END_BEAM 
                      if mpt < 4           /* down-up; tips down; modify end 
                        slurlet = "t" 
                      else                 /* up-down; tips up; modify end 
                        slurlet = "O" 
                      end 
                    end 
                  else 
                    c12 = ts(a6,BEAM_FLAG) 
                    if c12 = CONT_BEAM or c12 = START_BEAM 
                      if mpt < 8           /* down-up; tips up; modify beginning
                        slurlet = "o" 
                      else                 /* up-down; tips down; modify beginning
                        slurlet = "P" 
                      end 
                    end 
                  end 
                end 
              end 
&dA 
&dA &d@     3. Decompose "compound" situations into separate "simple" situations 
&dA 
&dA &d@        (1) if code in [D,J,b,h,k], are there other slurs between the chords?  
&dA &d@              If yes, then these codes become [R,H,a,q,i] 
&dA 
&dA &d@        (2) if code = I or J, is ending note vpar(6) higher than starting note?
&dA &d@              If yes, then these codes both become O, otherwise they become H 
&dA 
&dA &d@        (3) if code in [B,b,c], is ending note vpar(6) lower than starting note?
&dA &d@              If yes, then codes become [P,t,t]; otherwise they become [A,a,a]
&dA 
&dA &d@        (4) if code = j, does starting note have a flag?  If yes, it becomes 
&dA &d@               an "o".  Otherwise it is an "i" 
&dA 
&dA &d@        (5) if code = l or E, is there anything between the notes (chords) 
&dA &d@               If yes, they become p and Q; otherwise they are i and R.  
&dA 
              if "DJbhk" con slurlet 
                c12 = mpt 
                perform get_topbottom (a6,c1,c2) 
                perform get_topbottom (a7,c4,c5) 

                if c2 > c1 and c5 > c4        /* both chords 
                  loop for c3 = c1 to c2      /* first chord 
                    if c3 <> a6 

                  /* look for other slurs 

                      c8 = ts(c3,SLUR_FLAG) & 0x00550055 
                      if c8 > 0               /* slur(s) start(s) 
                        c8 <<= 1              /* set of end flags for these slurs
                        loop for c9 = c2 + 1 to c5 
                          c10 = ts(c9,TYPE) 
                          if chr(c10) in [NOTE,XNOTE,CUE_NOTE,XCUE_NOTE,GR_NOTE,XGR_NOTE]
                            c11 = ts(c9,SLUR_FLAG) & c8 
                            if c11 > 0    /* slur ends 
                              if c9 >= c4 and c9 <> a7  /* condition met!  
                                slurlet = "RHaqi"{c12} 
                                goto SSEND1 
                              else 
                                c11 = not(c11) 
                                c8 &= c11   /* turn off this possibility 
                              end 
                            end 
                          end 
                        repeat 
                      end 

                  /* now look for ties 

                      if bit(0,ts(c3,SUPER_FLAG)) = 1 
                        loop for c9 = c4 to c5 
                          if c9 <> a7 
                            c10 = ts(c9,BACKTIE) 
                            if c10 = c3                 /* condition met!  (tricky code)
                              slurlet = "RHaqi"{c12} 
                              goto SSEND1 
                            end 
                          end 
                        repeat 
                      end 
                    end 
                  repeat 
                end 
                slurlet = "QJbpo"{c12} 
              end 
SSEND1: 
              c7 = 0              /* option flag 

              if "IJBbcjlE" con slurlet 
                c8 = ts(a6,BEAM_FLAG) 
                c9 = ts(a7,BEAM_FLAG) 
                goto SS(mpt) 
SS(1):                            /* "IJ" 
                if ts(a6,STAFFLOC) - ts(a7,STAFFLOC) > vpar(7) 
                  c7 = 1
                end 
                if ts(a6,TYPE) < GR_NOTE or ts(a7,TYPE) > XNOTE 
                  if c9 = CONT_BEAM or c9 = END_BEAM 
                    c7 = 1 
                  end 
                end 
                goto SSEND 
SS(3):                            /* "Bbc" 
                if ts(a7,STAFFLOC) - ts(a6,STAFFLOC) > vpar(7) 
                  if slurlet = "B" 
                    c7 = 1 
                  else                             /* (New &dA05/17/03&d@) 
                    if ts(a7,SUBFLAG_2) & 0x3c > 0 or ts(a7,ED_SUBFLAG_2) & 0x3c > 0
                      if ts(a7,STAFFLOC) - ts(a6,STAFFLOC) > vpar(9) 
                        c7 = 1 
                      end 
                    else 
                      c7 = 1 
                    end 
                  end 
                end 
                if mpt = 3 
                  if c8 = START_BEAM or c8 = CONT_BEAM 
                    c7 = 1 
                  end 
                else 
                  if c9 = CONT_BEAM or c9 = END_BEAM 
                    c7 = 1 
                  end 
                end 
                goto SSEND 
SS(6):                            /* "j" 
                if c8 = NO_BEAM 
                  if ts(a6,NTYPE) < QUARTER 
                    c7 = 1
                  end 
                else 
                  if c8 = START_BEAM or c8 = CONT_BEAM 
                    c7 = 1                           
                  end 
                end 
                goto SSEND 
SS(7):                            /* "lE"   beams on both notes of slur?  
                if c8 > NO_BEAM and c9 > NO_BEAM 
                  slurlet = "      pQ"{mpt} 
                end 
                goto SSEND2 
&dA 
&dA &d@     At this point in the code, a1,a4,a6,a7 and a14 should not be changed 
&dA 
SSEND: 
&dA 
&dA &d@     Break 'm up 
&dA &d@                               
                if c7 = 1 
                  slurlet = "OOPttopQ"{mpt} 
                else 
                  slurlet = "HHAaaiiR"{mpt} 
                end 
              end 
&dA 
&dA &d@     At this point, you have determined the "situation" letter for the     
&dA &d@     between "a6" and "a7" (with the exception of the cases "l" and "E", 
&dA &d@     which depend on the material between the slurs).  You now need to 
&dA &d@     compile a profile of whatever material might be between the slurs 
&dA &d@     on this staff. (organized by advancing division) 
&dA 
SSEND2: 
              c12 = 0 
              if "lE" con slurlet          /* we do cases "l" and "E" here 
                c12 = mpt 
                c3 = ts(a6,STAFFLOC) 
                c4 = ts(a7,STAFFLOC) 
                if c3 < c4               
                  c3 = c4                
                  c4 = ts(a6,STAFFLOC)   
                end                      
                if mpt = 1               
                  c4 -= vpar(4)          
                else                     
                  c3 += vpar(4) 
                end 
              end 
              c9 = 0 
              c7 = 0 
              c8 = ts(a7,STAFF_NUM) 
              c15 = ts(a6,DIV) 
              c10 = a7  
              loop while chr(ts(c10,TYPE)) in [XNOTE,XCUE_NOTE,XGR_NOTE] 
                --c10 
              repeat 
              --c10       /* c10 will not point to the last chord 
              loop for c1 = a6+1 to c10  
                if ts(c1,STAFF_NUM) = c8 
                  nodtype = ts(c1,TYPE) 
                  if chr(nodtype) in [NOTE,CUE_NOTE,GR_NOTE] 
                    if bit(1,ts(c1,STEM_FLAGS)) = UP 
                      c5 = ts(c1,VIRT_STEM)
                      c6 = ts(c1,VIRT_NOTE) 
                    else 
                      c5 = ts(c1,VIRT_NOTE) 
                      c6 = ts(c1,VIRT_STEM)
                    end 
                  else 
                    if chr(nodtype) in [REST,CUE_REST] 
                      c5 = ts(c1,STAFFLOC) - vpar(3) 
                      c6 = ts(c1,STAFFLOC) + vpar(3) 
                    else 
                      if nodtype = CLEF_CHG 
                        c5 = 0 
                        c6 = vpar(8) 
                      else 
&dA 
&dA &d@         &dA11/26/06&d@  Fixing a minor bug in the placement of slurs 
&dA 
                        if nodtype < METER_CHG 
                          c5 = 1000   
                          c6 = -1000 
                        else 
                          c5 = 10000 
                        end 
&dA             &d@  End of &dA11/26/06&d@ change 
                      end 
                    end 
                  end 
                  if c5 < 10000 
                    if c12 > 0 
                      if c3 > c5 and c4 < c6 
                        c7 = 1 
                      end 
                    end 
                    if ts(c1,DIV) <> c15 
                      ++c9                             /*   Case 1: 
                      profile(c9,1) = c5 - vpar(2)     /*     new division 
                      profile(c9,2) = c6 + vpar(2)     /* 
                    else 
                      if c9 > 0 
                        c5 -= vpar(2)                  /*   Case 2: 
                        c6 += vpar(2)                  /*     more notes 
                        if c5 < profile(c9,1)          /*     on same 
                          profile(c9,1) = c5           /*     division 
                        end                            /* 
                        if c6 > profile(c9,2) 
                          profile(c9,2) = c6 
                        end 
                      end 
                    end 
                  end 
                end 
                if ts(c1,TYPE) = BAR_LINE 
                  c15 = 0 
                else 
                  c15 = ts(c1,DIV) 
                end 
              repeat 
              if c12 > 0 
                if c7 = 1 
                  slurlet = "pQ"{c12}
                else 
                  slurlet = "iR"{c12} 
                end 
              end 
&dA 
&dA &d@     More modifications to slurlet.  If there are staccatos, legatos, 
&dA &d@     or spiccatos connected to the note head, then under certain    
&dA &d@     conditions the slur must start at the stem of the note.  
&dA 
            /* New code rewritten &dA05/17/03&d@ 

              c16 = ts(a6,SUBFLAG_2) | ts(a6,ED_SUBFLAG_2)   /* combination subflag_2 at a6
              c16 &= 0x3c                                    /* staccato, legato, etc.
              c17 = ts(a7,SUBFLAG_2) | ts(a7,ED_SUBFLAG_2)   /* combination subflag_2 at a7
              c17 &= 0x3c                                    /* staccato, legato, etc.

              if slurlet < chr(96)     /* tips up 
                if c16 > 0 
                  if bit(1,ts(a6,STEM_FLAGS)) = DOWN 
                    if "ACRKLM" con slurlet 
                      slurlet = "PQQPQQ"{mpt} 
                    end 
                  end 
                end 
                if ts(a6,TYPE) < GR_NOTE and c17 > 0 
                  if bit(1,ts(a7,STEM_FLAGS)) = DOWN 
                    if "CGHLMR" con slurlet 
                      slurlet = "QOOQQQ"{mpt} 
                    end 
                  end 
                end 
              else                      /* tips down 
                if c16 > 0 
                  if bit(1,ts(a6,STEM_FLAGS)) = UP 
                    if "fgimqrs" con slurlet 
                      slurlet = "poopppp"{mpt} 
                    end 
                  end 
                end 
                if c17 > 0 
                  if bit(1,ts(a7,STEM_FLAGS)) = UP 
                    if slurlet = "o" 
                      slurlet = "p" 
                    end 
                  end 
                end 
              end                         /* End of &dA05/17/03&d@ rewrite 
&dA 
&dA &d@                Updated list of letter codes 
&dA &d@              ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA 
&dA &d@       tips up           tips down            explanation            
&dA &d@   code   1st  2nd    code   1st  2nd    letter        meaning 
&dA &d@   ÄÄÄÄÄ ÄÄÄÄÄÄÄÄÄÄ   ÄÄÄÄÄ ÄÄÄÄÄÄÄÄÄÄ   ÄÄÄÄÄÄ  ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA &d@     A     n    H       a     H    n        n     note 
&dA &d@     C     n    Yl      d     H    H        nr    start right of note 
&dA &d@     F     H    H       e     H    Y        nl    end left of note 
&dA &d@     G     H    Yl      f     Yr   n        H     head of chord 
&dA &d@     H     H    nl      g     Yr   H        Y     position of object 
&dA &d@     K     Y    H       i     nr   H              (opposite of H) 
&dA &d@     L     Y    Yl      m     nr   Y        Yr    start right of object 
&dA &d@     M     Y    nl      n     nr   nl       Yl    end left of object 
&dA &d@     N     nr   nl      o     s    H        s     stem 
&dA &d@     O     H    s       p     s    s 
&dA &d@     P     s    H       q     nr   n 
&dA &d@     Q     s    s       r     Yr   Yl 
&dA &d@     R     n    nl      s     Yr   Y 
&dA &d@                        t     H    s 
&dA 

&dA 
&dA &d@     At this point, we need to check to see of this is the first time 
&dA &d@     either chord has been touched by a slur.  When creating the 
&dA &d@     slur element ROW, we need to write in the first four elements: 
&dA 
&dA &d@        (1) current y-position above object for incoming slurs.  
&dA &d@        (2)              "     below   "     "     "       "  .  
&dA &d@        (3)              "     above   "     "  outgoing   "  .  
&dA &d@        (4)              "     below   "     "     "       "  .  
&dA 
              perform get_topbottom (a6,c1,c2) 
              if ts(a6,SLUR_X) = 0 
                ++a14 
                loop for c8 = c1 to c2 
                  ts(c8,SLUR_X) = a14 
                repeat 
                if bit(1,ts(a6,STEM_FLAGS)) = UP 
                  ts(a14,1) = ts(a6,VIRT_STEM) 
                  ts(a14,2) = ts(a6,VIRT_NOTE) 
                  ts(a14,3) = ts(a6,VIRT_STEM) 
                  ts(a14,4) = ts(a6,VIRT_NOTE) 
                else 
                  ts(a14,1) = ts(a6,VIRT_NOTE) 
                  ts(a14,2) = ts(a6,VIRT_STEM) 
                  ts(a14,3) = ts(a6,VIRT_NOTE) 
                  ts(a14,4) = ts(a6,VIRT_STEM) 
                end 
              end 
              if bit(1,ts(a6,STEM_FLAGS)) = UP 
                c3 = c2 
                c2 = c1 
                c1 = c3 
              end 

              perform get_topbottom (a7,c3,c4) 
              if ts(a7,SLUR_X) = 0 
                ++a14 
                loop for c8 = c3 to c4 
                  ts(c8,SLUR_X) = a14 
                repeat 
                if bit(1,ts(a7,STEM_FLAGS)) = UP 
                  ts(a14,1) = ts(a7,VIRT_STEM) 
                  ts(a14,2) = ts(a7,VIRT_NOTE) 
                  ts(a14,3) = ts(a7,VIRT_STEM) 
                  ts(a14,4) = ts(a7,VIRT_NOTE) 
                else 
                  ts(a14,1) = ts(a7,VIRT_NOTE) 
                  ts(a14,2) = ts(a7,VIRT_STEM) 
                  ts(a14,3) = ts(a7,VIRT_NOTE) 
                  ts(a14,4) = ts(a7,VIRT_STEM) 
                end 
              end 
              if bit(1,ts(a7,STEM_FLAGS)) = UP 
                c5 = c4 
                c4 = c3 
                c3 = c5 
              end 
&dA 
&dA &d@       a6 = note we are looking at in first chord 
&dA &d@       c1 = head of first chord 
&dA &d@       c2 = last note (Y) of first chord 
&dA 
&dA &d@       a7 = note we are looking at in second chord 
&dA &d@       c3 = head of second chord 
&dA &d@       c4 = last note (Y) of second chord 
&dA 
&dA &d@     If this slur starts or ends on an element which has either (1) a 
&dA &d@     staccato dot and/or a legato line, or (2) a spiccato indication 
&dA &d@     associated with it, then we need to check to see if this is the 
&dA &d@     first time the element in question has been encountered, i.e., 
&dA &d@     element (5) of the slur element ROW is zero.  If so, this parameter 
&dA &d@     needs to be adjusted to make space for the indication.  This will 
&dA &d@     also shift the position of the slur.  
&dA 

&dA 
&dA &d@     (1) starting 
&dA 
              c5 = ts(a6,SUBFLAG_2) | ts(a6,ED_SUBFLAG_2)   /* New &dA05/17/03&d@ 
                                                            /* At the moment, I am treating 
                                                            /* editorial marks the same way
                                                            /* as regular.  In fact, the 
                                                            /* addition of square brackets
                                                            /* may require additional
                                                            /* vertical space             

              c14 = ts(a6,SLUR_X)        /* index to slur element ROW 
              temp = "FGHOadet"          /* note (changed at bottom of loop) 
              temp2 = "PQop"             /* stem (changed at bottom of loop) 

              loop for c15 = 2 to 0 step -2 /* cases: 2 = start; 0 = end 

                if c5 & 0x3c > 0 
                  if ts(c14,5) = 0 
                    if temp con slurlet     /* if slur starts (ends) on a note 
&dA &d@         
&dA &d@             We need to write elements (5) and (6) and to modify elements 
&dA &d@             (1) and (3), or elements (2) and (4).
&dA &d@         
                      if mpt < 5            /* this works for both cases 
                        stem = UP 
                        t3 = 1 
                        y = ts(c14,c15+2) 
                      else 
                        stem = DOWN 
                        t3 = -1 
                        y = ts(c14,c15+1) 
                      end 

                      if c5 & 0x38 > 0       /* staccato or legato 
                        t2 = notesize 
                        y += t2 * t3 
               /*  check for interference 
                        t4 = 1 
                        if stem = DOWN 
                          if y >= 0 
                            t1 = y / notesize 
                            t4 = rem 
                          else 
                            y = 0 - notesize / 4 + y 
                          end 
                        else 
                          if y <= vpar(8) 
                            t1 = y / notesize 
                            t4 = rem 
                          else 
                            y = notesize / 4 + y 
                          end 
                        end 
               /*  adjust for interference with staff 
                        if t4 = 0                       /* interference 
                          c16 = t2 + vpar20 / vpar(2) 
                          if rem <> 0       
                            ++t2 
                          end 
                          t2 += vpar(1) 
                          c16 = t3 + 20 * vpar(2) / 2 - vpar20 
                          y += c16 
                        end 
                        c10 = t2 
                        if c5 & 0x10 > 0     /* line over dot 
                          y = notesize * t3 + y 
                          c10 += notesize 
                        end 
               /*  write elements 
                        ts(c14,5) = y 
                        if stem = UP 
                          ts(c14,2) += c10 
                          ts(c14,4) += c10 
                          ts(c14,6) = BELOW 
                        else 
                          ts(c14,1) -= c10 
                          ts(c14,3) -= c10 
                          ts(c14,6) = ABOVE 
                        end 
                      end 
                      if c5 & 0x04 > 0       /* spiccato 
                        if stem = DOWN 
                          if y > vpar(1) 
                            y = vpar(1) 
                          end 
                        else 
                          if y < vpar(7) 
                            y = vpar(7) 
                          end 
                        end 
                        y = 5 * notesize / 4 * t3 + y 
                        if stem = UP 
                          y += vpar(50) 
                        end 
               /*  write elements 
                        ts(c14,5) = y 
                        if stem = UP 
                          ts(c14,2) = y 
                          ts(c14,4) = y 
                          ts(c14,6) = BELOW 
                        else 
                          ts(c14,1) = y - vpar(50) 
                          ts(c14,3) = y - vpar(50) 
                          ts(c14,6) = ABOVE 
                        end 
                      end 
                    else 
                      if temp2 con slurlet  /* if slur starts (ends) on the stem
&dA &d@         
&dA &d@             We need to write element (5) and (6) and to modify elements 
&dA &d@             (1) and (3), or elements (2) and (4).
&dA &d@         
                        if mpt > 2           /* works in both cases 
                          stem = UP 
                          t3 = -1 
                          y = ts(c14,c15+1) 
                        else 
                          stem = DOWN 
                          t3 = 1 
                          y = ts(c14,c15+2) 
                        end 
                        if c5 & 0x38 > 0     /* staccato or legato 
                          t2 = vpar(1) 
                          c16 = t3 + 20 * vpar(2) / 2 - vpar20 
                          y += c16 

               /*  check for interference 
                          t4 = 1 
                          if stem = UP 
                            if y >= 0 
                              t1 = y / notesize 
                              t4 = rem 
                            else 
                              y = 0 - notesize / 4 + y 
                            end 
                          else 
                            if y <= vpar(8) 
                              t1 = y / notesize 
                              t4 = rem 
                            else 
                              y = notesize / 4 + y 
                            end 
                          end 
               /*  adjust for interference with staff 
                          if t4 = 0                     /* interference 
                            c16 = t2 + vpar20 / vpar(2) 
                            if rem <> 0 
                              ++t2 
                            end 
                            t2 += vpar(1) 
                            c16 = t3 + 20 * vpar(2) / 2 - vpar20 
                            y += c16 
                          end 
                          c10 = t2 
                          if c5 & 0x10 > 0   /* line over dot 
                            y = notesize * t3 + y 
                            c10 += notesize 
                          end 
               /*  write elements 
                          ts(c14,5) = y 
                          if stem = DOWN 
                            ts(c14,2) += c10 
                            ts(c14,4) += c10 
                            ts(c14,6) = ABOVE 
                          else 
                            ts(c14,1) -= c10 
                            ts(c14,3) -= c10 
                            ts(c14,6) = BELOW 
                          end 
                        end 
                        if c5 & 0x04 > 0     /* spiccato 
                          if stem = DOWN 
                            if y < vpar(8) 
                              y = vpar(8) 
                            end 
                          else 
                            if y > 0 
                              y = 0 
                            end 
                          end 
                          c16 = t3 + 20 * vpar(2) / 2 - vpar20 
                          y += c16 

                          if stem = DOWN 
                            y += vpar(50) 
                          end 
               /*  write elements 
                          ts(c14,5) = y 
                          if stem = DOWN 
                            ts(c14,2) = y 
                            ts(c14,4) = y 
                            ts(c14,6) = ABOVE 
                          else 
                            ts(c14,1) = y - vpar(50) 
                            ts(c14,3) = y - vpar(50) 
                            ts(c14,6) = BELOW 
                          end 
                        end 
                      end 
                    end 
                  end 
                end 
&dA 
&dA &d@     (2) ending 
&dA 
                c5 = ts(a7,SUBFLAG_2) | ts(a7,ED_SUBFLAG_2)   /* New &dA05/17/03&d@; see above.
                c14 = ts(a7,SLUR_X)            /* index to slur element ROW 
                temp = "AFKPdgio" 
                temp2 = "OQpt"   

              repeat 
&dA 
&dA &d@     Now you can affix the position of the slur, and store the results 
&dA &d@     in the appropriate slur element ROWS.  Also, the values of elements 
&dA &d@     (1) (2) (3) or (4) can be updated.  
&dA 

&dA &d@                              T H E   P L A N 
&dA &d@                           ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA 
&dA &d@     1. Using slurlet and elements (1) to (4), determine tentative start-y 
&dA &d@        and end-y values for slur.  Determine orientation (tips up/down) 
&dA 
&dA &d@     2. If c9 = 0, no adjustments are necessary; proceed with placing slur.  
&dA 
&dA &d@     3. Using curve data, convert actual interior y-values to relative 
&dA &d@        interior y-values.  If all interior y-values fall below (above) the 
&dA &d@        straight line connecting the end points, proceed with placing slur.  
&dA 
&dA &d@     4. Determine interior point with maximum deviation, and raise (lower) 
&dA &d@        the slur end-point on that side to the next multiple of vpar(1). 
&dA &d@        If there is more than one interior point at the maximum, or if the 
&dA &d@        interior point with the maximum is in the center of the slur, 
&dA &d@        raise (lower) both slur end-points to the next multiple of vpar(1).  
&dA 
&dA &d@     5. If all interior y-values now fall below (above) straight line 
&dA &d@        connecting the end points, proceed with placing slur.  
&dA 
&dA &d@     6. Determine interior point(s) with maximum deviation.  If this point 
&dA &d@        (all of these points) fall with the 25%-75% region of the slur, 
&dA &d@        increase the curvature one notch, and goto (3); otherwise goto (4).  
&dA 
&dA &d@     To execute this plan, we will need to set up some temporary variables.  
&dA 
&dA &d@        y1  = starting point of slur 
&dA &d@        y2  = ending point of slur 
&dA &d@        c5  = counting index for interior points 
&dA &d@        c6  = index for maximum on left 
&dA &d@        c7  = index for maximum on right 
&dA &d@        c9  = number of interior points (don't change this) 
&dA 
&dA &d@     I think the easiest way to handle the up/down situation is to convert 
&dA &d@     all down values to 1000 * vpar(1) - down, and treat this as part of the 
&dA &d@     "up" case.  Initial data includes y1, y2 and the profile data.  When we 
&dA &d@     are done, we simply perform the same tranformation to get the final 
&dA &d@     y1 and y2 values.  
&dA 

&dA              
&dA 
&dA &d@     New feature &dA05/01/08&d@.  If slur_adjust flag is non-zero, then this 
&dA &d@     should turn off all automatic post adjustment of slur posiiton.  I 
&dA &d@     think we can do this by setting c9 = 0, which essentially turns off 
&dA &d@     the profile.  
&dA 
              if slur_adjust <> 0 
                c9 = 0 
              end 
&dA 
&dA              

&dA &d@                           A C T I O N 
&dA &d@                          ÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA 
&dA &d@     1. Using slurlet and elements (1) to (4), determine tentative start-y 
&dA &d@        and end-y values for slur.  Determine orientation (tips up/down) 
&dA 
              if "ACNRimnq"  con slurlet         /* slur starts on note 
                y1 = ts(a6,STAFFLOC) 
              else 
                if "KLMfgrs"   con slurlet       /* slur starts on Y 
                  y1 = ts(a6,OBY) 
                else 
                  c13 = 3 
                  c14 = ts(a6,SLUR_X) 
                  c15 = bit(1,ts(a6,STEM_FLAGS)) 
                  if "FGHOadet"  con slurlet     /* slur starts on H 
                    if c15 = UP 
                      ++c13
                    end  
                  else 
                    if c15 = DOWN 
                      ++c13
                    end  
                  end 
                  y1 = ts(c14,c13) 
                end 
              end 
              if "HMNRafnq"  con slurlet         /* slur ends on note 
                y2 = ts(a7,STAFFLOC) 
              else 
                if "CGLemrs"   con slurlet       /* slur ends on Y 
                  y2 = ts(a7,OBY) 
                else 
                  c13 = 1 
                  c14 = ts(a7,SLUR_X) 
                  c15 = bit(1,ts(a7,STEM_FLAGS)) 
                  if "AFKPdgio"  con slurlet     /* slur ends on H 
                    if c15 = UP 
                      ++c13
                    end  
                  else 
                    if c15 = DOWN 
                      ++c13
                    end  
                  end 
                  y2 = ts(c14,c13) 
                end 
              end 
&dA 
&dA &d@     2. If c9 = 0, no adjustments are necessary; proceed with placing slur.  
&dA 
              if c9 = 0 
                curve = 1 
                goto PLACE_SLUR 
              end 
              c10 = 500 * vpar(2) 
              if slurlet < chr(96)     /* tips up 
                y1 = c10 - y1 
                y2 = c10 - y2 
                loop for c13 = 1 to c9 
                  profile(c13,1) = c10 - profile(c13,2)   /* first cut                 
                repeat 
              else 
                y1 += c10 
                y2 += c10  
                loop for c13 = 1 to c9 
                  profile(c13,1) += c10  
                repeat 
              end 
&dA 
&dA &d@     3. Using curve data, convert actual interior y-values to relative 
&dA &d@        interior y-values.  If all interior y-values fall below (above) the 
&dA &d@        straight line connecting the end points, proceed with placing slur.  
&dA &d@        (see beginning of program for construction of curvedata).  
&dA 
              t1 = 0 
              t2 = 0 
              curve = 1 
              sflag = 1 
              if abs(ts(a6,STAFFLOC) - ts(a7,STAFFLOC)) <= vpar(1) + 1 
                if bit(1,ts(a6,STEM_FLAGS)) = bit(1,ts(a7,STEM_FLAGS)) 
                  sflag = 0 
                end 
              end 
NEW_CURVE: 
              if c9 < 9  
                loop for c10 = 1 to c9 
                  profile(c10,2) = profile(c10,1) + curvedata(c9,curve,c10)
                repeat 
              else 
                loop for c10 = 1 to 4 
                  profile(c10,2) = profile(c10,1) + curvedata(8,curve,c10)
                repeat 
                loop for c10 = 5 to c9 - 4 
                  profile(c10,2) = profile(c10,1) + curvedata(8,curve,4) - 1
                repeat 
                c11 = 1 
                loop for c10 = c9 to c9 - 4 step -1 
                  profile(c10,2) = profile(c10,1) + curvedata(8,curve,c11)
                  ++c11 
                repeat 
              end 

              r1 = flt(y1) + .5 - flt(vpar(2)) 
              r2 = flt(y2 - y1) 
              r3 = flt(c9+1) 
              r2 = r2 / r3 
              c14 = 0 
              c15 = 0 
              c12 = c9 + 1 >> 1 
              c13 = c9 >> 1 + 1 
              t5 = 0 
              t6 = 0 
              loop for c5 = 1 to c9 
                r1 += r2 
                c11 = fix(r1) 
                c11 -= profile(c5,2) 
                if c11 > 0 
                  if c5 <= c12
                    if c11 > c14 
                      c14 = c11 
                      t5 = c5 
                    end 
                  end 
                  if c5 >= c13 
                    if c11 > c15 
                      c15 = c11 
                      t6 = c5 
                    end 
                  end 
                end 
              repeat 
              if c14 = 0 and c15 = 0 
                goto FIX_ENDS 
              end 
&dA 
&dA &d@     4. Determine interior point with maximum deviation, and raise (lower) 
&dA &d@        the slur end-point on that side to the next multiple of vpar(1). 
&dA &d@        If there is more than one interior point at the maximum, or if the 
&dA &d@        interior point with the maximum is in the center of the slur, 
&dA &d@        raise both slur end-points to the next multiple of vpar(1).  
&dA 

              c7 = 0                              
              if c9 > 4 and bit(0,c9) = 0                                 /* 
                c6 = c9 >> 1                                              /*   &dA          
                if t5 = c6 or t6 - 1 = c6                                 /*   &dA  TRIAL   
                  c7 = 1                                                  /*   &dA          
                  if bit(1,ts(a6,STEM_FLAGS)) <> bit(1,ts(a7,STEM_FLAGS)) /* 
                    if abs(ts(a6,STAFFLOC) - ts(a7,STAFFLOC)) <= vpar(10) /* 
                      if curve = 1                                        /* 
                        if c15 > c14                                      /* 
                          t1 = 2                                          /* 
                        else                                              /*   &dA          
                          t2 = 2                                          /*   &dA          
                        end                                               /*   &dA  TRIAL   
                        c7 = 0                                            /*   &dA          
                      end                                                 /* 
                    end                                                   /* 
                  end                                                     /* 
                end 
              end 
NEW_HEIGHT: 
              if c15 = c14 or sflag = 0 or c7 = 1 
                y2 -= vpar(1) 
                c16 = y2 * 2 / vpar(2) 
                y2 -= rem
                y1 -= vpar(1) 
                c16 = y1 * 2 / vpar(2) 
                y1 -= rem
                      
                if sflag = 0 
                  sflag = 1 
                end 
              else 
JKL: 
                if c15 > c14 
                  if t2 > 0 
                    t1 = 0 
                    t2 = 0 
                  end 
                  if t1 = 2            
                    t1 = 0 
                    c14 = c15 + 1 
                  else 
                    ++t1 
                    y2 -= vpar(1) 
                    c16 = y2 * 2 / vpar(2) 
                    y2 -= rem 
                  end 
                end 
                if c14 > c15 
                  if t1 > 0 
                    t1 = 0 
                    t2 = 0 
                  end 
                  if t2 = 2 
                    t2 = 0 
                    c15 = c14 + 1 
                    goto JKL 
                  else 
                    y1 -= vpar(1) 
                    c16 = y1 * 2 / vpar(2) 
                    y1 -= rem 
                  end 
                end 
              end 
&dA 
&dA &d@     5. If all interior y-values now fall below (above) straight line 
&dA &d@        connecting the end points, proceed with placing slur.  
&dA 
              r1 = flt(y1) + .5 - flt(vpar(2)) 
              r2 = flt(y2 - y1) 
              r3 = flt(c9+1) 
              r2 = r2 / r3 
              c14 = 0 
              c15 = 0 
              c6 = 0 
              c7 = 0 
              c12 = c9 + 1 >> 1 
              c13 = c9 >> 1 + 1 
              loop for c5 = 1 to c9 
                r1 += r2 
                c11 = fix(r1) 
                c11 -= profile(c5,2) 
                if c11 > 0 
                  if c5 <= c12
                    if c11 > c14 
                      c6 = c5 
                      c14 = c11 
                    end 
                  end 
                  if c5 >= c13 
                    if c11 > c15 
                      c7 = c5 
                      c15 = c11 
                    end 
                  end 
                end 
              repeat 
              if c6 = 0 and c7 = 0 
                goto FIX_ENDS 
              end 
              t5 = c6 
              t6 = c7 
&dA 
&dA &d@     6. Determine interior point(s) with maximum deviation.  If this point 
&dA &d@        (all of these points) fall with the 25%-75% region of the slur, 
&dA &d@        increase the curvature one notch, and goto (3); otherwise goto (4).  
&dA 
              c5 = 10000 / (c9 + 1) 
              c6 *= c5 
              c7 *= c5 
              if c14 >= c15 and c6 >= 2500 and curve < 4 
                ++curve 
                goto NEW_CURVE 
              end 
              if c14 <= c15 and c7 <= 7500 and curve < 4 
                ++curve 
                goto NEW_CURVE 
              end 
              goto NEW_HEIGHT 
&dA 
&dA &d@     Transform to actual y-values 
&dA 
FIX_ENDS: 
              c10 = 500 * vpar(2) 
              if slurlet < chr(96)     /* tips up 
                y1 = c10 - y1 
                y2 = c10 - y2 
              else 
                y1 -= c10  
                y2 -= c10  
              end 
&dA 
&dA &d@          Adjust slur height if both ends show tuplet 
&dA 
              if bit(4,ts(a6,SUPER_FLAG)) = 1 and bit(5,ts(a7,SUPER_FLAG)) = 1 
                c10 = 0   /* = no 
                goto ADJS(tpflag+1) 
ADJS(1): 
                if ts(a6,BEAM_FLAG) > 0 and ts(a7,BEAM_FLAG) > 0 
                  if ts(a7,MULTI_TRACK) = 0 
                    c10 = 1 
                  end 
                else 
                  c10 = 1 
                end 
                goto ADJSE 
ADJS(2):                       /* always 
                c10 = 1 
                goto ADJSE 
ADJS(3):                       /* never 
                goto ADJSE 
ADJS(4):                       /* only when tips down 
                if slurlet > chr(96)     /* tips down 
                  c10 = 1 
                end 
                goto ADJSE 
ADJS(5):                       /* only when tips up  
                if slurlet < chr(96)     /* tips up 
                  c10 = 1 
                end 
ADJSE:  
                if c10 = 1 
                  if slurlet < chr(96)     /* tips up 
                    if y1 + y2 > vpar(6) << 1 
                      y1 += vpar(2) 
                      y2 += vpar(2) 
                    end 
                  else 
                    if y1 + y2 < vpar(4) 
                      y1 -= vpar(2) 
                      y2 -= vpar(2) 
                    end 
                  end 
                end 
              end 
&dA 
&dA &d@     For both starting and ending chords, (1) find next empty slot in 
&dA &d@     in each SLUR_X row and construct the following information: 
&dA 
&dA &d@       first element 
&dA &d@       ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA &d@          bit 27:     start/end flag (0 = start, 1 = end) 
&dA &d@          bits 24-26: slur number - 1 (0 to 7) 
&dA &d@          bits 17-23: curvature information (end only) 
&dA &d@          bit 16:     up/down flag (0 = tips up, 1 = tips down) (end only) 
&dA &d@          bits 0-15:  x-offset + 1000 (always a positive number) 
&dA &d@       second element 
&dA &d@       ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA &d@          y position relative to the staff 
&dA &d@       third element (&dA05/06/03&d@) 
&dA &d@       ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA &d@          print suggestion for this end of the slur 
&dA 
PLACE_SLUR: 
&dA 
&dA &d@         Starting point 
&dA 
              c10 = 1000           /* x-offset 
              if "ACRNimnq" con slurlet     /* start on "n" 
                if ts(a6,LOCAL_XOFF) > 0 
                  c10 += ts(a6,LOCAL_XOFF) 
                end 
                if mpt > 3 
                  c10 += hpar(82) * 3 / 4 
                end 
              else 
                if "KLMfgrs" con slurlet    /* start on "Y" 
                  if bit(1,ts(a6,STEM_FLAGS)) = UP 
                    if ts(c2,LOCAL_XOFF) > 0 
                      c10 += ts(a6,LOCAL_XOFF) 
                    end 
                    if mpt > 3 
                      c10 += hpar(82) * 3 / 4 
                    end 
                  end 
                else 
                  if "PQop" con slurlet     /* start on "s" 
                    if mpt < 3 
                      c10 -= hpar(82) / 3 
                    else 
                      c10 += hpar(82) / 3 
                    end 
                  end 
                end 
              end 
              c11 = sgroup(a4,3) << 24       /* slur number 
              c11 += c10                     /* odd numbered element 
              c12 = ts(a6,SLUR_X) 
              loop for c13 = 7 to (TS_SIZE - 2) step 3       /* &dA05/06/03&d@ 
                if ts(c12,c13) = 0 
                  goto PLACE_SLUR1 
                end 
              repeat 
PLACE_SLUR1: 
              ts(c12,c13) = c11 
              ++c13 
              ts(c12,c13) = y1 
&dA 
&dA &d@          Fine tuning for special situation 
&dA 
              if slurlet = "i" 
                if ts(a6,STAFFLOC) - ts(a7,STAFFLOC) >= 0 
                  c17 = ts(a7,SUBFLAG_2) | ts(a7,ED_SUBFLAG_2)   /* New &dA05/17/03
                  if c17 & 0x3c > 0                              /* New 
                    ts(c12,c13) -= vpar(2) 
                  end 
                end 
              end 
&dA 
&dA &d@          Code added &dA05/06/03&d@ get print suggestion for this end of slur 
&dA 
              ++c13 
              c11 = sgroup(a4,3)                   /* 0 to 7 
              if c11 > 3 
                c11 -= 4                           /* 0 to 3 = (,[,{,z 
              end 
              c11 *= 4                             /* 0,4,8,12 
              c11 += 81                            /* 81,85,89,93  (97,101,105,109)
              c10 = ts(a6,TSR_POINT)                      
              ts(c12,c13) = ors(tsr(c10){c11,4}) 
&dA 
&dA &d@          End code addition 
&dA 
              if "opadet" con slurlet        /* starting from over (3) 
                ts(c12,3) = y1 - vpar(1) 
                c16 = ts(c12,3) * 2 / vpar(2) 
                ts(c12,3) -= rem 
              end 
              if "FGHOPQ" con slurlet        /* starting from under (4) 
                ts(c12,4) = y1 
                c16 = ts(c12,4) * 2 / vpar(2) 
                if rem <> 0 
                  ++ts(c12,4) 
                end 
                ts(c12,4) += vpar(1) 
              end 
&dA 
&dA &d@         Ending point 
&dA 
              c10 = 1000           /* x-offset 
              if "HMNRnafq" con slurlet     /* end on "n" 
                if ts(a7,LOCAL_XOFF) < 0 
                  c10 += ts(a6,LOCAL_XOFF) 
                end 
                if mpt < 6 
                  c10 -= hpar(82) * 3 / 4 
                end 
              else 
                if "CGLrems" con slurlet    /* end on "Y" 
                  if bit(1,ts(a7,STEM_FLAGS)) = DOWN 
                    if ts(c4,LOCAL_XOFF) < 0 
                      c10 += ts(a6,LOCAL_XOFF) 
                    end 
                    if mpt < 5 
                      c10 -= hpar(82) * 3 / 4 
                    end 
                  end 
                else 
                  if "OQpt" con slurlet     /* end on "s" 
                    if mpt < 3 
                      c10 -= hpar(82) / 3 
                    else 
                      c10 += hpar(82) / 3 
                    end 
                  end 
                end 
              end 
              c11 = sgroup(a4,3)             /* slur number 
              c11 += 16                      /* end flag 
              c11 <<= 8 
              c11 += curve << 1              /* curvature 
              if slurlet > chr(96)     /* tips up 
                ++c11                        /* tips up/down flag 
              end 
              c11 <<= 16 
              c11 += c10                     /* x-offset              
              c12 = ts(a7,SLUR_X) 
              loop for c13 = 7 to (TS_SIZE - 2) step 3       /* &dA05/06/03&d@ 
                if ts(c12,c13) = 0 
                  goto PLACE_SLUR2 
                end 
              repeat 
PLACE_SLUR2: 
              ts(c12,c13) = c11 
              ++c13 
              ts(c12,c13) = y2 
&dA 
&dA &d@          Code added &dA05/06/03&d@ get print suggestion for this end of slur 
&dA 
              ++c13 
              c11 = sgroup(a4,3)                   /* 0 to 7 
              if c11 > 3 
                c11 -= 4                           /* 0 to 3 = (,[,{,z 
              end 
              c11 *= 4                             /* 0,4,8,12 
              c11 += 97                            /* 97,101,105,109 
              c10 = ts(a7,TSR_POINT) 
              ts(c12,c13) = ors(tsr(c10){c11,4}) 
&dA 
&dA &d@          End code addition 
&dA 
              if "ptdgio" con slurlet        /* ending from over (1) 
                ts(c12,1) = y2 - vpar(1) 
                c16 = ts(c12,1) * 2 / vpar(2) 
                ts(c12,1) -= rem 
              end 
              if "AFKPOQ" con slurlet        /* ending from under (2) 
                ts(c12,2) = y2 
                c16 = ts(c12,2) * 2 / vpar(2) 
                if rem <> 0 
                  ++ts(c12,2) 
                end 
                ts(c12,2) += vpar(1) 
              end 
            repeat 

&dA &d@   &dA  ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»  
&dA &d@   &dA  º   This is the end of the loop which processes slurs   º  
&dA &d@   &dA  ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼  

          end 
YYYY: 
        repeat 
        maxsct = a14 
&dA 
&dA &d@***************************************************************** 
&dA &d@    Processing loop (loop ends at ZZZ)   PROCESSING TS ARRAY 
&dA 
&dA &d@    Actions:  
&dA 
&dA &d@       I. Construct text sub-object, if present 
&dA 
&dA &d@      II. Deal with music   
&dA 
&dA &d@          A. Bar Lines  
&dA 
&dA &d@          B. Clef changes, Time changes
&dA 
&dA &d@          C. Signs, Words, Marks  
&dA 
&dA &d@          D. Figures  
&dA 
&dA &d@          E. Notes/Rests  
&dA 
&dA &d@              1. Accidentals  
&dA &d@              2. Note heads, dots   
&dA &d@              3. Leger lines  
&dA &d@              4. Stems and beams  
&dA 
&dA &d@     III. Write object records into intermediate file 
&dA 
        p += firstsp 
        loop for a1 = 1 to sct   
          nodtype = ts(a1,TYPE)  
          a5 = ts(a1,TEXT_INDEX)  
          if a5 > 0 
            ttext = tsdata(a5) // pad(1) 
          else 
            ttext = pad(1) 
          end 
          sobcnt = 0 
          obx = p  
          if nodtype = DIV_CHG
            goto ZZZ 
          end  
&dA 
&dA &d@    Get the spn (spacing) parameter 
&dA 
          spn = ts(a1,SPN_NUM) 
&dA 
&dA &d@   II. Typeset Music  
&dA 
&dA &d@     A. Typeset Bar Line  
&dA 
          if nodtype = BAR_LINE
            a2 = hpar(36)  
            a14 = ts(a1,BAR_TYPE)  
&dA 
&dA &d@    determine location of obx for this object 
&dA 
            if bit(1,ts(a1,REPEAT)) = 1    /* backward repeat
              a2 += hpar(43) 
            end                                                           
            a10 = hpar(43) + hpar(93) - hpar(80) 
&dA 
&dA &d@     hpar(44) = actual white space between two light lines 
&dA &d@     hpar(45) = actual white space between heavy/light, light/heavy and heavy/heavy combinations
&dA &d@     hpar(79) = thickness of light line 
&dA &d@     hpar(81) = thickness of heavy line 
&dA 
&dA &d@                                                                        shift for
&dA &d@                                                                       forward dots(repeats)
&dA &d@   a14   a2+ (add to p)       a4 (1st shft) a5 (2nd shft)  a8 (inc)        a10
&dA &d@  ----  ----                 ----           ---------     ----            -----
&dA &d@    1    0                    0             0               0              a10
&dA &d@    2  { hpar(81) - hpar(79  a2             0               0              a10
&dA &d@              + 1 } 
&dA &d@    3    0                    0             0               0              a10
&dA &d@    5    hpar(44) + hpar(79) a2             0               0              a10
&dA &d@    6  { hpar(45) + hpar(81) a2   - { hpar(81) - hpar(79)   0              a10
&dA &d@              + 1 }                          + 1 } 
&dA &d@    9    0                    0       hpar(81) + hpar(45)   a5           a10 + a5
&dA &d@   10    hpar(81) + hpar(45) a2             0         { hpar(81) -   hpar(43)+hpar(96)-hpar(80)
&dA &d@                                                     hpar(79) + 1 } 
&dA 

            a4 = 0 
            a5 = 0 
            a8 = 0 
            if a14 = HEAVY
              a2 += hpar(81) - hpar(79) + 1 
              a4 = hpar(81) - hpar(79) + 1 
            end  
            if a14 = DOUBLE_REG or a14 = DOUBLE_DOTTED
              a2 += hpar(44) + hpar(79) 
              a4 = hpar(44) + hpar(79) 
            end  
            if a14 = REG_HEAVY
              a2 += hpar(45) + hpar(81) + 1 
              a4 = hpar(45) + hpar(81) + 1 
              a5 = 0 - (hpar(81) - hpar(79) + 1) 
            end  
            if a14 = HEAVY_REG
              a5 = hpar(81) + hpar(45) 
              a8 = a5        
              a10 += a5       
            end  
            if a14 = DOUBLE_HEAVY
              a2 += hpar(81) + hpar(45) 
              a4 =  hpar(81) + hpar(45) 
              a8 =  hpar(81) - hpar(79) + 1 
              a10 = hpar(43) + hpar(96) - hpar(80) 
            end  
            obx = p + a2 
            if ts(a1,NODE_SHIFT) > 0 
              obx += ts(a1,NODE_SHIFT) 
            end 
&dA 
&dA &d@    put out signet signs (if present) 
&dA 
            if bit(1,ts(a1,BAR_FLAGS)) = 1     /* segno sign
              out = "0"  
              jtype = "D"  
              jcode = 8 + sigflag  
              pcode = 106                 /* music font
              oby = vpar(45) 
              if nstaves = 2 
                oby += 1000 
              end 
              putobjpar = 0 
              perform putobj 
              jcode = 5 - sigflag  
              oby = 0 - vpar(43) 
              perform putobj 
              if sigflag = 0 
                sigflag = 1  
              end  
            end  
&dA &d@                 
&dA &d@    put out fermata signs (if present) 
&dA 
            if ts(a1,BAR_FLAGS) & 0x000c > 0 
              putobjpar = 0 
              if bit(2,ts(a1,BAR_FLAGS)) = 1     /* fermata over bar 
                out = "0" 
                jtype = "D" 
                jcode = 5            
                pcode = 101                 /* music font 
                oby = 0 - vpar(3) 
                obx -= vpar(2) 
                perform putobj 
                obx += vpar(2) 
              end 
              if bit(3,ts(a1,BAR_FLAGS)) = 1     /* fermata under bar 
                out = "0" 
                jtype = "D" 
                jcode = 9 
                pcode = 102                 /* music font 
                oby = vpar(3) + vpar(8) 
                if nstaves = 2 
                  oby += 1000 
                end 
                obx -= vpar(2) 
                perform putobj 
                obx += vpar(2) 
              end 
            end 
            oby = 0  
&dA 
&dA &d@    contruct superobject string for bar line  
&dA 
            supcnt = 0 
*    look for termination of ending  
            a9 = ts(a1,BACK_ENDING) 
            if a9 <> 0   
              if esnum > 0 
                ++supcnt
                supnums(supcnt) = esnum  
                a6 = esnum 
              else 
                tmess = 4 
                perform dtalk (tmess) 
              end  
              esnum = 0  
            end  
*    look for termination of long trill ~~~~ 
            if bit(0,ts(a1,BAR_FLAGS)) = 0 
              loop for a3 = 1 to MAX_PASS 
                if tsnum(a3) > 0 
                  ++supcnt                         /* stop trill 
                  supnums(supcnt) = tsnum(a3) 
                end 
              repeat 
            end  
*    look for origination of ending  
            if ts(a1,FORW_ENDING) > 0 
              ++snum
              esnum = snum 
              ++supcnt
              supnums(supcnt) = esnum  
            end  
*    construct supernumber string for object
            out = chs(supcnt)  
            loop for a3 = 1 to supcnt  
              out = out // " " // chs(supnums(a3))   
            repeat 
            supcnt = 0 
&dA 
&dA &d@    Typeset elements of the bar line 
&dA 
*    numbered measure                   /* Code added &dA02-23-97&d@ 
            a3 = ts(a1,M_NUMBER) 
            if a3 > 0 
              c5 = 38
              perform spacepar (c5) 
              c5 = spc(176) >> 1        /* space for small "0" 
              if a3 > 9 
                c5 <<= 1 
              end 
              sobl(1) = "W " // "-" // chs(c5) // " 0 38 " 
              sobcnt = 1 
              if a3 > 9 
                c5 = a3 / 10 
                a3 = rem 
                sobl(1) = sobl(1) // "\0" // chs(c5) 
              end 
              sobl(1) = sobl(1) // "\0" // chs(a3) 
            end 

*    back-repeat 
            if bit(1,ts(a1,REPEAT)) = 1   /* backward repeat 
              x = p + hpar(36) 
              x += ts(a1,NODE_SHIFT)     /* This line added &dA09/22/03&d@ (but not fully checked)
              y = vpar(3) 
              z = 44                      /* music font 
              perform subj 
              y = vpar(5) 
              perform subj 
            end 
*    first of double bar 
            y = 0 
            if a14 > 3 
              a3 = a14 & 0x0c 
              z = a3 / 2 + 80             /* music font 
              x = obx - a4 
              perform subj 
            end 
*    second or single bar  
            a3 = ts(a1,BAR_TYPE) & 0x03 
            z = a3 * 2 + 80               /* music font 
            x = obx + a5 
            perform subj 
*    forward-repeat  
            if bit(0,ts(a1,REPEAT)) = 1   /* forward repeat 
              x = obx + a10 
              a8 += hpar(43) 
              y = vpar(3) 
              z = 44                      /* music font 
              perform subj 
              y = vpar(5) 
              perform subj 
            end 
*    put out object (and sub-objects)  
            jtype = "B" 
            jcode = ts(a1,BAR_NUMBER) 
            if sobcnt = 1 
              pcode = z                   /* music font 
            else 
              pcode = sobcnt 
            end 
            oby = ts(a1,NUM_STAVES) - 1 * 1000 + a14 
            putobjpar = 0 

            perform putobj 
&dA 
&dA 
*    put out ending super-object 
            if a9 <> 0                    /* backward ending
              if ts(a1,FORW_ENDING) > 0 
                out = "-" // chs(hpar(41)) 
              else 
                out = "0"  
              end  
              out = out // " -" // chs(vpar(40)) // " " 
              out = out // chs(vpar(41)) // " "  
              if a9 > 0                   /* ending stops
                out = out // chs(vpar(41)) 
              else                        /* ending discontinues
                a9 = 0 - a9  
                out = out // "0"   
              end  
              ++outpnt 
              tput [Y,outpnt] H ~a6  E ~a9  0 ~out 
            end  
*    put out long trill super-object 
            if bit(0,ts(a1,BAR_FLAGS)) = 0 
              loop for c5 = 1 to MAX_PASS 
                if tsnum(c5) > 0 
                  out = "H " // chs(tsnum(c5)) // " R " // chs(ctrarrf(c5)) 
                  out = out // " 0" 
                  ++outpnt 
                  tput [Y,outpnt] ~out  -~hpar(42)  ~try(c5) 
                  tsnum(c5) = 0 
                  ctrarrf(c5) = 0 
                end 
              repeat 
            end  
*    adjust p
            p = obx + ts(a1,SPACING) + a8   

            goto ZZZ 
          end  
&dA 
&dA &d@     B. Typeset Clef change, Time change, Key change 
&dA 
          if nodtype = CLEF_CHG
&dA 
&dA &d@    Code added &dA01/17/04&d@ to deal with time clef in measure groups 
&dA 
            if ts(a1,DOLLAR_SPN) = 6913             /* 6913 used here as a code, not a value
              spn = 6913 
            end                                     /* otherwise don't change spn
&dA   
            a3 = ts(a1,STAFF_NUM) + 1         /* staff number 

            if ts(a1,NODE_SHIFT) < 0 
              a7 = 0 - ts(a1,NODE_SHIFT) 
              p += ts(a1,NODE_SHIFT) 
            end 

            obx = p  

            clef(a3) = ts(a1,CLEF_NUM) 
            z = ts(a1,CLEF_FONT)              /* music font 
            oby = ts(a1,STAFF_NUM) * 1000     /* added &dA5-28-93&d@ 
            oby += ts(a1,CLEF_STAFF_POS) 
            perform putclef (a3) 
            p += ts(a1,SPACING) 

            goto ZZZ 
          end  
 
          if nodtype = DESIGNATION
&dA 
&dA &d@    Code added &dA01/17/04&d@ to deal with designation in measure groups 
&dA 
            if ts(a1,DOLLAR_SPN) = 6913             /* 6913 used here as a code, not a value
              spn = 6913 
            end                                     /* otherwise don't change spn
&dA   
            c5 = 37 
            perform spacepar (c5) 
&dA 
&dA &d@       Introducing optional conversion to ligitures in designations  &dA04/22/04
&dA 
            perform kernttext                  /* New &dA04/22/04&d@ 
            jtype = "D"  
            jcode = 5  
            obx = p  
            oby = ts(a1,STAFF_NUM) * 1000     /* added &dA5-28-93&d@ 
            oby -= tword_height * vpar(1) 
            out = "0"  
            sobl(1) = "" 
            temp3 = "W 0 0 " // chs(dtivfont) // " " // ttext 
            pcode = 1  
            putobjpar = 0 
            perform putobj 
            goto ZZZ 
          end  
 
          if nodtype = METER_CHG
&dA 
&dA &d@    Code added &dA01/17/04&d@ to deal with meter changes in measure groups 
&dA 
            if ts(a1,DOLLAR_SPN) = 6913             /* 6913 used here as a code, not a value
              spn = 6913 
            end                                     /* otherwise don't change spn
&dA   
            tnum = ts(a1,TIME_NUM) / 100 
            tden = rem 
            oby = 0 
            t1 = p 
            loop for t2 = 1 to ts(a1,NUM_STAVES) 
              p = t1 
              perform settime (a3) 
              oby += 1000 
            repeat 
            if tnum = 1 and tden = 1 
              tnum = 4 
              tden = 4 
            end 
            if tnum = 0 and tden = 0 
              tnum = 2     
              tden = 2 
            end 
            goto ZZZ 
          end  
 
          if nodtype = AX_CHG 
&dA 
&dA &d@    Code added &dA01/17/04&d@ to deal with key changes in measure groups 
&dA 
            if ts(a1,DOLLAR_SPN) = 6913             /* 6913 used here as a code, not a value
              spn = 6913 
            end                                     /* otherwise don't change spn
&dA   
            t1 = ts(a1,3)                              /* new key 
            t2 = ts(a1,4)                              /* old key 
            a3 = ts(a1,NUM_STAVES)                     /* number of staves 
            a4 = 0 
            a5 = 0                                     /* added &dA08/23/06&d@ 
            perform key_change (t1,t2,a3,a4,a5)        /* emptyspace(.,.) not set
            key = t2                               /* &dA08/23/06&d@ 5th variable added to procedure
&dA 
&dA &d@    NOTE: The following instruction was added &dA05/29/05&d@ to fix a minor bug 
&dA &d@          that I have never seen before.  It makes perfect sense that we 
&dA &d@          should go to the next element in the ts(.) array, and I can't see
&dA &d@          how this "bug" has remained hidden for so long.  My worry is that
&dA &d@          there was a good reason why we wanted to "fall through" to the 
&dA &d@          note processing section, although this would be &dEvery poor&d@ programming
&dA &d@          practice.  I do believe, however, in light of the fact that this 
&dA &d@          program has worked properly for so long, that we need to keep an 
&dA &d@          eye on this situation.  This "goto" instruction &dEis&d@ a major change!
&dA 
            goto ZZZ                                  
          end 
&dA 
&dA &d@     C. Typeset Signs, Words and Marks which are Objects  
&dA 
          if nodtype = SIGN or nodtype = WORDS or nodtype = MARK
            putobjpar = 0 
            a4 = ts(a1,TEXT_INDEX)  
            ttext = tsdata(a4)  
            ttext = trm(ttext) 
            out = "0"  
&dA 
&dA &d@     determine vertical positions of object and superobject 
&dA 
            if ts(a1,SIGN_TYPE) = SEGNO 
              oby = 0 - vpar(43) 
            else 
              if ts(a1,SIGN_POS) = ABOVE 
                oby = 0 - vpar(44) 
              else 
                oby = vpar(45) 
              end 
            end 
            oby1 = oby 
            oby2 = oby 
            obx1 = obx 
            obx2 = obx 
&dA 
&dA &d@     Comment: &dA01/07/06&d@ The code here is somewhat convoluted, but I think 
&dA &d@         this addition corrects a problem with the way print suggestions 
&dA &d@         interact with transpositions.  Stay alert!  
&dA 
            if nodtype = MARK
              oby = 0  
            end  
&dA     
            if ts(a1,POSI_SHIFT1) > 0 
              a3 = ts(a1,POSI_SHIFT1) & 0xff 
              if a3 > 0 
                oby1 = a3 - 0x80 * vpar(2) / 10 
                yposi_shift = 0 
              else 
                a3 = ts(a1,POSI_SHIFT1) >> 8  
                yposi_shift = a3 & 0xff 
                if yposi_shift > 0 
                  yposi_shift = yposi_shift - 0x80 * vpar(2) / 10 
                end 
              end 
              xposi_shift = ts(a1,POSI_SHIFT1) >> 16 
              if xposi_shift > 0 
                xposi_shift = xposi_shift - 0x80 * vpar(2) / 10 
              end 
            else 
              yposi_shift = 0 
              xposi_shift = 0 
            end 
            save_xposi_shift = xposi_shift 
            obx1 += xposi_shift 
            oby1 += yposi_shift 

            if ts(a1,POSI_SHIFT2) > 0 
              a3 = ts(a1,POSI_SHIFT2) & 0xff 
              if a3 > 0 
                oby2 = a3 - 0x80 * vpar(2) / 10 
                yposi_shift = 0 
              else 
                a3 = ts(a1,POSI_SHIFT2) >> 8  
                yposi_shift = a3 & 0xff 
                if yposi_shift > 0 
                  yposi_shift = yposi_shift - 0x80 * vpar(2) / 10 
                end 
              end 
              xposi_shift = ts(a1,POSI_SHIFT2) >> 16 
              if xposi_shift > 0 
                xposi_shift = xposi_shift - 0x80 * vpar(2) / 10 
              end 
            else 
              yposi_shift = 0 
              xposi_shift = 0 
            end 
            obx2 = xposi_shift 
            oby2 += yposi_shift 

            temp = " " // chs(oby1) 
            temp2 = " " // chs(oby2) 

            a2 = ts(a1,SUPER_TYPE) 
*     construct superflags for object  
            if a2 > 0  
              a3 = a2 + 1 / 2  
              a8 = 0 
              if a3 = 4  
                a8 = 1 
                a3 = 3 
              end  
              if rem = 0     /* start of super-object 
              
                a4 = a3 - WEDGES * 5 + ts(a1,S_TRACK_NUM) /* row element 
                loop for a5 = 1 to 5 
                  if smusdir(a4,1) = 0                    /* must be zero to use 
                    a5 = 1000 
                  else                                    /* else look at others
                    ++a4 
                    if a4 > a3 * 5 
                      a4 -= 5                             /* in the set 
                    end 
                  end 
                repeat 
                if a5 <> 1000 
                  if a3 = WEDGES 
                    tmess = 31 
                  else 
                    if a3 = DASHES 
                      tmess = 32 
                    else 
                      tmess = 33 
                    end 
                  end 
                  perform dtalk (tmess) 
                end 
                ++snum
                smusdir(a4,1) = snum 
                smusdir(a4,4) = oby2 
                if a3 = WEDGES
                  smusdir(a4,2) = ts(a1,WEDGE_SPREAD)
                  smusdir(a4,3) = ts(a1,WEDGE_OFFSET) + obx2 
                else 
                  if a3 = DASHES 
                    if ts(a1,FONT_NUM) = 0 
                      c5 = mtfont 
                    else 
                      c5 = ts(a1,FONT_NUM) 
                    end 
                    smusdir(a4,3) = c5 
                    perform wordspace 
                    smusdir(a4,2) = a5 + obx2 
                  else 
                    smusdir(a4,3) = obx2 
                    smusdir(a4,4) -= oby    /* tricky code 
                    if a3 = OCT_UP 
                      smusdir(a4,2) = 0 
                    end 
                    if a3 = OCT_DOWN 
                      smusdir(a4,2) = 1 
                    end 
                    if a3 = DBL_OCT_UP 
                      smusdir(a4,2) = 2 
                    end 
                    if a3 = DBL_OCT_DOWN 
                      smusdir(a4,2) = 3 
                    end 
                  end 
                end 

              else                 /* end of super-object 

                a4 = a3 - WEDGES * 5 + ts(a1,S_TRACK_NUM) /* row element 
                loop for a5 = 1 to 5 
                  if smusdir(a4,1) <> 0                   /* must be non zero to use
                    a5 = 1000 
                  else                                    /* else look at others
                    ++a4 
                    if a4 > a3 * 5 
                      a4 -= 5                             /* in the set 
                    end 
                  end 
                repeat 
                if a5 <> 1000 
                  if a3 = WEDGES 
                    tmess = 34 
                  else 
                    if a3 = DASHES 
                      tmess = 35 
                    else 
                      tmess = 36 
                    end 
                  end 
                  perform dtalk (tmess) 
                end 
                save_a4 = a4 
              end 
              out = "1 " // chs(smusdir(a4,1)) 
            end  
&dA 
&dA &d@     if single character, write object  
&dA 
            a3 = ts(a1,SIGN_TYPE) 
            if a3 = PED or a3 = END_PED 
              pcode = 112 + a3           /* music font 
              jtype = "S"  
              jcode = 0  
              obx = obx1 
              oby = ts(a1,STAFF_NUM) * 1000 + oby1 
              if ts(a1,ISOLATED) = 1 
                jtype = "I" 
              end 
              perform putobj 
              goto VT2 
            end  
            if a3 = LETTER_DYNAM          /* one letter dynamics 
              if ttext con "Z" 
#if SFZ 
                ttext{mpt,1} = "sfz" 
#else 
                ttext{mpt,1} = "sf" 
#endif 
              end 
              if len(ttext) = 1 and "pf" con ttext 
                if mpt = 1      
                  pcode = 108             /* music font
                else 
                  pcode = 110             /* music font
                end  
                jtype = "S"  
                jcode = 0  
                obx = obx1 
                oby = ts(a1,STAFF_NUM) * 1000 + oby1 
                if ts(a1,ISOLATED) = 1 
                  jtype = "I" 
                end 
                perform putobj 
                goto VT2 
              end  
            end  
&dA 
&dA &d@    put out segno signs (as directives) 
&dA 
            if a3 = SEGNO    
              pcode = 106                 /* music font 
              jtype = "D" 
              jcode = 8 + sigflag 
              obx = obx1 
              oby = ts(a1,STAFF_NUM) * 1000 + vpar(45)      /* oby reset here 
              if ts(a1,ISOLATED) = 1 
                jtype = "I" 
              end 
              perform putobj 
              jcode = 5 - sigflag 
              oby = ts(a1,STAFF_NUM) * 1000 + oby1     
              if ts(a1,ISOLATED) = 1 
                jtype = "I" 
              end 
              perform putobj 
              if sigflag = 0 
                sigflag = 1  
              end  
              goto VT2 
            end  

&dA                                                                   
&dA 
&dA &d@               This code added &dA10-12-96&d@ 
&dA 

&dA 
&dA &d@    Put out mark for tie terminator
&dA 
            if a3 = TIE_TERM 
              jtype = "M"  
              jcode = 0  
              obx = obx1 + hpar(81) + hpar(45)   /* guarenteed to put you beyond bar line
              oby = 0  
              pcode = 0  
              c7 = ts(a1,BACKTIE) 
              c7 = ts(c7,BACKTIE) 
              out = "1 " // chs(tiearr(c7,TIE_SNUM)) 
              perform putobj 
&dA 
&dA &d@     Now put out the Tie Super-object 
&dA 
&dA &d@        compute sitf (situation flag) 
&dA 
&dA &d@        Description of sitf:   range 1 to 16  
&dA &d@    
&dA &d@        If the range were from 0 to 15, then bits 3 to 0     
&dA &d@          would have the following meanings:  
&dA &d@    
&dA &d@                          zero          |         one 
&dA &d@                   -------------------------------------------- 
&dA &d@          bit 3:        tips down       |       tips up 
&dA &d@          bit 2:      note on space     |     note on line  
&dA &d@          bit 1:   no stem interfenence |   stem interference 
&dA &d@          bit 0:    staff interference  | no staff interference 
&dA 
              c9 = tiearr(c7,TIE_VLOC) 
              c10 = tiearr(c7,TIE_FHDIS)        /* local x-offset for first note
              c11 = 0                           /* local x-offset for second note
              c12 = tiearr(c7,TIE_FORCE)        /* force flag 
              if c12 = 3 
                c12 = 9 
              end 
&dA 
&dA &d@           Rules for single note 
&dA 
              c5 = tiearr(c7,TIE_FSTEM) 
              if c5 = 0 
                sitf = 9                    /* stem up 
              else 
                sitf = 1 
              end 

              if c12 > 0 
                sitf = c12                  /* forced situation 
              end 

              if tiearr(c7,TIE_FSTEM) = UP and sitf < 9 
                sitf += 2                   /* stem interference 
              end 
&dA 
&dA &d@       Note:  you won't know if there is staff interference until 
&dA &d@                   you know the final length of the tie 
&dA 
              c9 += tiearr(c7,TIE_STAFF) * 1000 

          /* New code added &dA04/20/03&d@, modified &dA05/02/03&d@    

              c13 = tiearr(c7,TIE_SUGG) & 0xff000000        /* length data     
              c6 =  tiearr(c7,TIE_SUGG) & 0xff0000          /* position flags
              c4 =  tiearr(c7,TIE_SUGG) & 0xff00            /* x data 
              c5 =  tiearr(c7,TIE_SUGG) & 0xff              /* y data 
              c13 >>= 24 
              c6 >>= 16 
              c4 >>= 8 
              if c4 > 0 
                c4 = c4 - 128 * notesize / 10 
              end 
              if c5 > 0 
                c5 = c5 - 128 * notesize / 10 
              end 
              if bit(2,c6) = 1 
                c5 += 10000 
              end 
              c6 = 0 
              if c13 > 0 
                c6 = c13 - 128 * notesize / 10 
              end 

          /* end New code 

              c8 = tiearr(c7,TIE_SNUM) 

              ++outpnt 
              if tiearr(c7,TIE_COLOR) > 4                /* New &dA12/21/10&d@ 
                if tiearr(c7,TIE_COLOR) = 5 
                  tput [Y,outpnt] P ~c8  T ~c9  ~c10  ~c11  ~c4  ~c5  ~c6  ~sitf  0
                else 
                  if tiearr(c7,TIE_COLOR) = 6 
                    tput [Y,outpnt] P 0x00ff00 ~c8  T ~c9  ~c10  ~c11  ~c4  ~c5  ~c6  ~sitf  0
                  else 
                    tput [Y,outpnt] P 0x0000ff ~c8  T ~c9  ~c10  ~c11  ~c4  ~c5  ~c6  ~sitf  0
                  end 
                end 
              else 
                tput [Y,outpnt] H ~c8  T ~c9  ~c10  ~c11  ~c4  ~c5  ~c6  ~sitf  0
              end 

              tiearr(c7,TIE_SNUM) = 0 
              ts(a1,BACKTIE) = 0 
              goto VT2 
            end 
&dA &d@                    
&dA &d@               End of &dA10-12-96&d@ addition 
&dA 
&dA                                                                      

            if nodtype = MARK
              jtype = "M"  
              jcode = 0  
              obx = obx1 
              oby = 0  
              pcode = 0  
              if ts(a1,ISOLATED) = 1 
                jtype = "I" 
              end 
              perform putobj 
              goto VT2 
            end  
*     words  
            if nodtype = WORDS
              jtype = "D"  
              jcode = 0  

              if ttext = "Fine"  
                jcode = 9  
              end  
              if ttext = "fine"  
                jcode = 9  
              end  
              if ttext = "[fine]"  
                jcode = 9  
              end  
              if ttext con " " 
                if ttext{1,mpt-1} = "da" 
                  jcode = 9  
                end  
                if ttext{1,mpt-1} = "dal"  
                  jcode = 9  
                end  
                if ttext{1,mpt-1} = "Dal"  
                  jcode = 9  
                end  
                if ttext{1,mpt-1} = "Da"  
                  jcode = 9  
                end  
                if ttext con " da " 
                  jcode = 9 
                end 
              end  
              if ttext con "D.C." or ttext con "D. C." 
                jcode = 9 
              end 

              pcode = 1  
              a4 = ts(a1,FONT_NUM) 
              if a4 = 0  
                a4 = mdirfont
              end  

&dA          
&dA &d@      
&dA &d@      This code moved to this location from below, because we need 
&dA &d@      to the operative font number for spacing purposes.  &dA10/08/08&d@ 
&dA 
              ttext = ttext // pad(4) 
              if ttext{1} = "!" 
                a4 = int(ttext{2..}) 
                if ttext{sub} = "|"           /* New &dA01/17/04&d@: skip over "|"
                  ++sub 
                end 
                ttext = ttext{sub..} 
              end 
              ttext = trm(ttext) 
&dA 
&dA          
              if a3 > 4                 /* (a3 = SIGN_TYPE here) 
                c5 = a4 
                if a3 < 7  
&dA 
&dA &d@       Introducing optional conversion to ligitures in words  &dA04/22/04&d@ 
&dA 
                  perform kernttext            /* New &dA04/22/04&d@ 
                  perform wordspace 

&dA                                                       &d@  (reminder) 
&dA &d@³    Inputs:    ttext   = word                       ³ 
&dA &d@³                  c5   = font number                ³ 
&dA &d@³               curfont = currently active font      ³ 
&dA &d@³                                                    ³ 
&dA &d@³    Outputs:   a5 = space taken up by word          ³ 
&dA                                                       

                  if a3 = 6  
                    a5 /= 2 
                  else 
                    a5 += 10 
                  end  
                else 

&dA                                                                    
&dA 
&dA &d@          New code (&dA02/03/08&d@) for determining box size and position 
&dA &d@            for Rehearsal numbers or letters (uses c10,c11,c12,c13,c14,c15,c16,c17)
&dA 
                  if a3 = REH_MARK 
                    perform wordspace 
                    c12 = 2 * font_base + zero_height / 3           /* displacement to top
                    c13 = font_height - font_base * 2 / 3           /* displacement to bottom
                    c14 = spc(48) / 2                               /* displacement to the left
                    c15 = a5 + (spc(48) * 3 / 5)                    /* displacement to the right
                  end 
&dA 
&dA                                                                    

                  a5 = 0 
                end  
              end  
              if a5 > 0  
                temp3 = "W -" // chs(a5) 
              else 
                temp3 = "W 0"  
              end  

&dA                                                           
&dA 
&dA &d@      More code &dA02/03/08&d@ for dealing with boxes 
&dA 
              if a3 = REH_MARK
                sobl(1) = temp3 // temp // " " // chs(a4) // " " // ttext 
                c10 = 1 
                c11 = oby1 - c12              /* actual displacement to top 
                c12 = oby1 + c13              /* actual displacement to bottom
                c13 = 0 - c14                 /* actual displacement to the left
                c14 = c15                     /* actual displacement to the right
&dA 
&dA &d@          First put in horizontal lines of the box 
&dA 
                c17 = 0 
                if notesize = 6 
                  c15 = c13 + 1 
                  loop for c16 = 1 to 8 
                    ++c10 
                    sobl(c10) = "K " // chs(c15) // " " // chs(c11) // " 45"
                    ++c10 
                    sobl(c10) = "K " // chs(c15) // " " // chs(c12) // " 45"
                    c15 += 10 
                    if c17 = 1 
                      c16 = 1000 
                    end 
                    if c15 > (c14 - 9) 
                      c15 = c14 - 9 
                      c17 = 1 
                    end 
                  repeat 
                else 
                  c15 = c13 
                  loop for c16 = 1 to 8 
                    ++c10 
                    sobl(c10) = "K " // chs(c15) // " " // chs(c11) // " 90"
                    ++c10 
                    sobl(c10) = "K " // chs(c15) // " " // chs(c12) // " 90"
                    if c17 = 1 
                      c16 = 1000 
                    end 
                    c15 += 30 
                    if c15 > (c14 - 30) 
                      c15 = c14 - 30 
                      c17 = 1
                    end 
                  repeat 
                end 
&dA 
&dA &d@             for glyph 45                    for glyph 90                         for glyph 89
&dA &d@           ---------------                 ---------------                     -----------------
&dA &d@              notesize 6    -1  0  10        notesize 6       0  0  30            notesize 6         0  0  1  (6)
&dA &d@              notesize 14   -3  0  24        notesize 14      0  1  30            notesize 14        0  1  2  (14)
&dA &d@              notesize 16   -3  0  28        notesize 16      0  1  30            notesize 16        0  1  2  (16)
&dA &d@              notesize 18   -4  0  32        notesize 18      0  1  30            notesize 18        0  1  3  (18)
&dA &d@              notesize 21   -4  0  35        notesize 21      0  2  30            notesize 21        0  1  4  (21)
&dA 

&dA 
&dA &d@          Now put in vertical lines of the box 
&dA 
                c17 = 0 
                c15 = c11 
                --c14 
                if notesize > 6 
                  --c14 
                end 
                if notesize > 16 
                  --c14 
                end 
                if notesize > 18 
                  --c14 
                end 

                loop for c16 = 1 to 8 
                  ++c10 
                  sobl(c10) = "K " // chs(c13) // " " // chs(c15) // " 89" 
                  ++c10 
                  sobl(c10) = "K " // chs(c14) // " " // chs(c15) // " 89" 
                  if c17 = 1 
                    c16 = 1000 
                  end 
                  c15 += notesize 
                  if c15 > (c12 - notesize) 
                    c15 = c12 - notesize 
                    c17 = 1
                  end 
                repeat 
                pcode = c10 
              else 
&dA     
&dA &d@          Need to make a cludge of a modification here &dA01/12/09&d@.  The problem
&dA &d@          is that when the node is isolated, any non-null xposi_shift becomes
&dA &d@          irrelevant, once mskpage takes over.  In this case, if we want the 
&dA &d@          word shifted horizontally, the shift must be in the Word sub-object,
&dA &d@          not in the object position.  We will adjust the obx position because
&dA &d@          it is relevant when printing individual parts 
&dA 
                if ts(a1,ISOLATED) = 1 
                  temp3 = "W " // chs(save_xposi_shift) // temp // " " // chs(a4) // " " // ttext
                  obx1 -= save_xposi_shift 
                else 
                  temp3 = temp3 // temp // " " // chs(a4) // " " // ttext 
                end 
&dA     
                sobl(1) = "" 
              end 

&dA 
&dA          &d@ End of &dA02/03/08&d@ Changes 

              obx = obx1 
              oby = ts(a1,STAFF_NUM) * 1000       
              if ts(a1,ISOLATED) = 1 
                jtype = "I" 
              end 
              perform putobj 
              goto VT2 
            end  
*     multi-letter dynamics  
            jtype = "S"  
            jcode = 0  
            pcode = len(ttext)   
            obx = obx1 
            oby = oby1 
            x = obx 
            y = oby 
            loop for a4 = 1 to pcode 
              if "pmfszr" con ttext{a4}  
                z = mpt + 107             /* music font
                mpt += 59 
                perform subj 
                x += hpar(mpt) 
              end  
            repeat 
            oby = ts(a1,STAFF_NUM) * 1000 + oby 
            if ts(a1,ISOLATED) = 1 
              jtype = "I" 
            end 
            perform putobj 
&dA 
&dA &d@      put out super-objects 
&dA 
VT2:        a2 = ts(a1,SUPER_TYPE) 
            if a2 > 0  
              a2 /= 2 
              if rem = 0 and a2 >= 1 and a2 <= 6 
                a4 = save_a4                              /* this was computed above
                if a2 = WEDGES
*        wedges  
                  line = chs(smusdir(a4,2)) // " " 
                  line = line // chs(ts(a1,WEDGE_SPREAD)) // " " 
                  line = line // chs(smusdir(a4,3)) // " " // chs(smusdir(a4,4)) // " "
                  line = line // chs(ts(a1,WEDGE_OFFSET) + obx2) // " " // chs(smusdir(a4,4))

                  ++outpnt 
                  tput [Y,outpnt] H ~smusdir(a4,1)  W ~line 
                end  
                if a2 = DASHES
*        dashes  
                  if ts(a1,SIGN_TYPE) = LETTER_DYNAM 
                    a6 = obx2 - (2 * hpar(46)) 
                  else 
                    a6 = obx2 
                  end 
                  line = chs(a6) // " " // chs(smusdir(a4,4)) // " 0" 
                  a6 = smusdir(a4,3)  
                  ++outpnt 
                  tput [Y,outpnt] H ~smusdir(a4,1)  D ~smusdir(a4,2)  ~line  ~a6
                end  
*        range shifts                           
                if chr(a2) in [OCT_UP,OCT_DOWN,DBL_OCT_UP,DBL_OCT_DOWN] 
                  if a2 = OCT_UP or a2 = DBL_OCT_UP 
                    a5 = smusdir(a4,4) + vpar(47) 
                  else 
                    a5 = smusdir(a4,4) - vpar(46) 
                  end 
                  line = chs(smusdir(a4,2)) // " " // chs(smusdir(a4,3)) // " "
                  a6 = obx2 - hpar(47) 
                  line = line // chs(a6) // " " // chs(a5) // " " // chs(vpar(41))
                  ++outpnt 
                  tput [Y,outpnt] H ~smusdir(a4,1)  V ~line 
                end 
                smusdir(a4,1) = 0        /* clear the row for next use 
              end  
            end  
            if ts(a1,DINC_FLAG) > 0  
              inctype = ts(a1,DINC_FLAG) 
            end  
            goto ZZZ 
          end  
&dA 
&dA &d@     D. Typeset Figures 
&dA 
          if nodtype = FIGURES 
            obx = p  
&dA 
&dA &d@       We need to run a little check here.  If there is an element 
&dA &d@       in the ts array that has the same division number and is a note or 
&dA &d@       cue-note, then the possibility exist that this object might 
&dA &d@       have to be shifted to the right in order to be placed under 
&dA &d@       the note (and not under some accidental to the note).  
&dA 
            if ts(a1+1,DIV) = ts(a1,DIV) 
              if ts(a1+1,TYPE) = NOTE or ts(a1+1,TYPE) = CUE_NOTE 
                obx += ts(a1+1,NODE_SHIFT) 
                p   += ts(a1+1,NODE_SHIFT) 
                ts(a1+1,NODE_SHIFT) = 0 
                if ts(a1+1,SPACING) < ts(a1,MIN_FIG_SPAC) 
                  ts(a1+1,SPACING) = ts(a1,MIN_FIG_SPAC) 
                end 
              end 
            end 

            a3 = FIG_DATA
            supcnt = 0   
*     determine if accidentals precede any figures in this set 
            loop for a2 = 1 to 4 
              mf(a2) = 0 
            repeat 
            a10 = FIG_DATA
            loop for a2 = 1 to ts(a1,NUMBER_OF_FIG) 
              a4 = ts(a1,a10) + 28  /* tricky code, possible rewrite
&dA 
&dA &d@    Code added &dA11/16/03&d@ to deal with parentheses around figures 
&dA 
              if a4 > 1000 
                a4 = a4 / 1000 
                a4 = rem 
              end 
&dA   
              temp = chr(a4)   
              if "1389" con temp    
                if ts(a1,a10+1) > 0 and ts(a1,a10+1) < 20
                  mf(a2) = a4 - 48 
                end  
              end  
              a10 += 3 
            repeat 
*     construct sub-objects  
            oby = vpar(49) 
            y = vpar(49) 
            loop for a2 = 1 to ts(a1,NUMBER_OF_FIG)
              a6 = ts(a1,a3)  
&dA 
&dA &d@    Code added &dA11/16/03&d@ to deal with parentheses around figures 
&dA 
              a10 = 0 
              if a6 > 1000 
                a10 = a6 / 1000 
                a6 = rem 
                if a6 = 0 
                  a10 = 0 
                else 
                  if a10 = 1 
                    y -= vpar(92) 
                    x = obx - hpar(136) 
                    if mf(a2) > 0 
                      a9 = mf(a2) + 67 
                      a9 = hpar(a9) 
                      x -= a9 
                    end 
                    z = 197                   /* music font 
                    perform subj              /* small left parenthesis 
                    y += vpar(92) 
                  else 
                    if a10 = 3                /* shift down to bracket 3 figures
                      y += (vpar(48) >> 1) 
                    end 
                    y += vpar(93) 
                    x = obx - hpar(138) 
                    if mf(a2) > 0 
                      a9 = mf(a2) + 67 
                      a9 = hpar(a9) 
                      x -= a9 
                    end 
                    z = 69                    /* music font 
                    perform subj              /* large left parenthesis 
                    y -= vpar(93) 
                    if a10 = 3 
                      y -= (vpar(48) >> 1) 
                    end 
                  end 
                end 
              end 
&dA   
              x = obx  
              if a6 > 0    
                if mf(a2) > 0  
                  a9 = mf(a2) + 67 
                  a9 = hpar(a9)  
                  x = obx - a9 
                  z = mf(a2) + 210        /* music font
                else 
                  a9 = hpar(66)  
                  if a6 = 30 
                    z = 220               /* music font
                  else 
                    if a6 < 10 
                      z = a6 + 199 
                    else 
                      if a6 < 20 
                        z = 200 
                        perform subj 
                        x += a9 
                        z = a6 + 189 
                      else 
                        a9 = a6 + 47 
                        a9 = hpar(a9) 
                        z = a6 + 190 
                      end 
                    end 
                  end  
                end  
                perform subj 
                x += a9 
                a6 = ts(a1,a3+1)  
                if a6 > 0  
                  a9 = hpar(66)  
                  if a6 < 10 
                    z = a6 + 199 
                  else 
                    if a6 < 20 
                      z = 200 
                      perform subj 
                      x += a9 
                      z = a6 + 189 
                    else 
                      a9 = a6 + 47 
                      a9 = hpar(a9) 
                      z = a6 + 190 
                    end 
                  end 
                  perform subj 
                  x += a9 
                end  
&dA 
&dA &d@    Code added &dA11/16/03&d@ to deal with parentheses around figures 
&dA 
                if a10 > 0 
                  x -= a9 
                  if a10 = 1 
                    x += hpar(137) 
                    y -= vpar(92) 
                    z = 198                 /* music font 
                    perform subj            /* small right parenthesis 
                    y += vpar(92) 
                  else 
                    if a10 = 3                /* shift down to bracket 3 figures
                      y += (vpar(48) >> 1) 
                    end 
                    x += hpar(139) 
                    y += vpar(93) 
                    z = 70                  /* music font 
                    perform subj            /* large right parenthesis 
                    y -= vpar(93) 
                    if a10 = 3 
                      y -= (vpar(48) >> 1) 
                    end 
                  end 
                  x += a9 
                end 
&dA   
              end  
*       set up for dealing with continuation lines 
              if ts(a1,a3+2) = 2  
                ++snum
                figarr(a2,FIG_SNUM) = snum  
                dv4 = x - obx  
                if a6 > 0  
                  dv4 += (hpar(66) * 3 / 2)     /* &dA11/16/03&d@ Experiment: was simply hpar(66)
                end  
                figarr(a2,FIG_HOFF1) = dv4 
                ++supcnt
                supnums(supcnt) = snum   
              end  
              if ts(a1,a3+2) = 1  
                figarr(a2,FIG_HOFF2) = hpar(77)  
                figarr(a2,FIG_READY) = 1 
                ++supcnt
                supnums(supcnt) = figarr(a2,FIG_SNUM)   
              end  
              a3 += 3 
              y += vpar(48) 
            repeat 
*    put out object and sub-objects  
            out = chs(supcnt)  
            loop for a3 = 1 to supcnt  
              out = out // " " // chs(supnums(a3)) 
            repeat 
            supcnt = 0 
            jtype = "F"  
            jcode = 0  
            pcode = sobcnt 
            oby = ts(a1,STAFF_NUM) * 1000 + oby 
&dA 
&dA &d@       Now look for print suggestions for this figure object 
&dA 
            putobjpar = 0 
            c5 = ts(a1,TSR_POINT) 
            pcontrol = ors(tsr(c5){1})                  /* &dA05/02/03&d@ 
            px = ors(tsr(c5){3}) << 8 
            py = ors(tsr(c5){4}) << 16 
            a2 = ors(tsr(c5){2}) << 24 
            putobjpar = a2 + px + py + pcontrol         /* Note: order of data has been changed

            perform putobj 
*    write out continuation line super-objects 
            loop for a2 = 1 to MAX_FIG
              if figarr(a2,FIG_READY) > 0  
                ++outpnt 
tput [Y,outpnt] H ~figarr(a2,FIG_SNUM)  F ~a2  ~figarr(a2,FIG_HOFF1)  ~figarr(a2,FIG_HOFF2)  0
                loop for a3 = 1 to 4 
                  figarr(a2,a3) = 0  
                repeat 
              end  
            repeat 
            a4 = ts(a1,FIG_SPACE) 
            if a4 > 0  
              p += a4 
            end 
            if ts(a1,DINC_FLAG) > 0  
              inctype = ts(a1,DINC_FLAG) 
            end  
            goto ZZZ 
          end  
&dA 
&dA &d@ ================================================================= 
&dA &d@                  GENERAL SECTION COMMENT 
&dA 
&dA &d@      At this point, we have only notes (grace, regular and cue) 
&dA &d@  and rests (regular and cue) left to typeset.  This is actually 
&dA &d@  where the process becomes interesting and can be quite complex.  
&dA &d@  For music on the grand staff (the most complex situation) 
&dA &d@  there can be as many as &dDten&d@ (&dDMAX_PASS&d@) passes and as many as 
&dA &d@  &dDsix&d@ notes in a single pass (maximum chord size) 
&dA 
&dA &d@      We need to review the way note events are organized in the set 
&dA &d@  array and how this relates to the way they are organized in the 
&dA &d@  i-files.  In the i-files, the basic unit of organization is the 
&dA &d@  object.  An object can contain a note, a set of notes (chord), or a 
&dA &d@  rest.  Items which normally attach to notes such as accidentals, 
&dA &d@  ornaments, articulations, leger lines, etc., are included as 
&dA &d@  sub-objects to the object.  Items which normally connect notes such 
&dA &d@  as beams, ties, and slurs, are represented by superobjects.  Among 
&dA &d@  the parameters associated with an object are (1) &dDhorizontal location&d@, 
&dA &d@  (2) &dDspace node number&d@, and (3) &dDdistance&d@ &dDincrement flag&d@.  
&dA 
&dA &d@      &dDThe first level of organization in the set array is by division&d@.  
&dA &d@  A division is a time-location with a measure.  A division may have 
&dA &d@  several note events belonging to it (as well as other types of events, 
&dA &d@  which, at this point in the program have already been dealt with). 
&dA &d@  &dDAll members of a division will have the same space node number.&d@  
&dA &d@  The first object in a division will have a non-zero distance 
&dA &d@  increment flag.  This feature is handled automatically by the 
&dA &d@  putobj procedure.  
&dA 
&dA &d@      Within a division, we first find all of the grace notes (and 
&dA &d@  grace chord notes).  Since grace notes generally precede regular and 
&dA &d@  cue notes, these notes can have non-zero advance-space parameters 
&dA &d@  associated with them.  This means that grace notes objects can 
&dA &d@  advance the horizontal location pointer.  On the other hand, cue-size 
&dA &d@  and regular objects will generally have the same horizontal location 
&dA &d@  (except for for shifts to accomodate clashes).  
&dA 
&dA &d@      From the above analysis, we can see that &dDthe next level of&d@ 
&dA &d@  &dDorganization in the set array is by general location&d@.  In particular, 
&dA &d@  grace notes will tend fall into one or more groups, each having a 
&dA &d@  separate general location.  All cue-size and regular notes (and 
&dA &d@  rests will have the same general location.  
&dA 
&dA &d@      Finally &dDthe lowest level of organization in the set array is by&d@ 
&dA &d@  &dDactual object&d@.  Only notes of the same chord will share the same 
&dA &d@  object.  
&dA 
&dA &d@      We are currently inside a big loop, which begins under the title 
&dA &d@  "&dLProcessing loop (loop ends at ZZZ)&d@".  The loop itself is initiated 
&dA &d@  by the instruction "&dNloop for a1 = 1 to sct&d@".  The variable "spn", 
&dA &d@  which is the space node number, is retrieved from storage at the top 
&dA &d@  of this loop.  It is based on division number.  We do not need to 
&dA &d@  process all notes and rests on a particular division at one time; we 
&dA &d@  may proceed down to the next level of organization within the set 
&dA &d@  array, which is the general location.  The key variable in 
&dA &d@  determining this grouping is the space parameter "&dLSPACING&d@".  The 
&dA &d@  first ts(.,.) ROW element of a general location group will have a 
&dA &d@  non-zero space parameter, and any other element in such a group will 
&dA &d@  have a space parameter = 0.  
&dA 
&dA &d@      In typesetting a group of notes at a general location, the 
&dA &d@  following information is required.  
&dA 
&dA &d@      (1) The number of passes (chords or single notes) in the group 
&dA &d@      (2) The number of set array elements in each of these passes 
&dA &d@      (3) a4 = the spacing parameter for this group 
&dA &d@      (4) a2 = index to last element in group 
&dA &d@                                                                   
&dA &d@                         END OF COMMENT 
&dA &d@                                                                   
&dA &d@ ================================================================= 
&dA &d@                                                                   
&dA 
&dA &d@     E. Notes/Rests 
&dA 
          a4 = ts(a1,SPACING) 

          if ts(a1,NODE_SHIFT) > 0 
            p += ts(a1,NODE_SHIFT) 
          end 

          npasses = 1 
          a3 = 1 
          loop for a2 = a1+1 to sct  
            if ts(a2,SPACING) <> 0 
              --a2 
              pitchcnt(npasses) = a3 
              goto XX1 
            end 
            if ts(a2,TYPE) > NOTE_OR_REST 
              --a2 
              pitchcnt(npasses) = a3 
              goto XX1 
            end 
            if nodtype = GR_NOTE
              if ts(a2,TYPE) = XGR_NOTE 
                ++a3 
              else 
                pitchcnt(npasses) = a3 
                a3 = 1 
                ++npasses 
              end 
            else 
              if ts(a2,TYPE) = XNOTE or ts(a2,TYPE) = XCUE_NOTE 
                ++a3 
              else 
                pitchcnt(npasses) = a3 
                a3 = 1 
                ++npasses 
              end 
            end 
          repeat 
XX1: 
&dA 
&dA &d@    Create objects for this node  
&dA 
&dA &d@    a1          = index to first element in node 
&dA &d@    a2          = index to last element in node 
&dA &d@    npasses     = number of passes (separate chords) in this node 
&dA &d@    pitchcnt(.) = size of chord for each pass
&dA &d@    a4          = space parameter (space following this node) 
&dA 
&dA &d@    I. Typeset objects in this node 
&dA 

          c2 = a1 - 1 
          loop for a14 = 1 to npasses 
            obx = p 
            c1 = c2 + 1                       /* top of chord 
            c2 = c1 + pitchcnt(a14) - 1       /* bottom of chord 
            a3 = ts(c1,STAFF_NUM) + 1         /* staff number 
            passnum = ts(c1,PASSNUM) 
            oby = ts(c1,OBY) 
            ntype = ts(c1,NTYPE) & 0xff       /* new &dA10/15/07&d@ 
            opt_rest_flag = ts(c1,NTYPE) >> 8 /* new &dA10/15/07&d@ 
            nodtype = ts(c1,TYPE) 

&dA                                                                
&dA 
&dA &d@    I. Construct Text Sub-Object (new to this position  &dA06-26-94&d@ ) 
&dA 
            if nodtype = NOTE 
              c5 = ts(c1,TEXT_INDEX) 
              if c5 > 0 
                ttext = tsdata(c5) // pad(1) 
              else 
                ttext = pad(1) 
              end 
&dA 
&dA &d@        New test for text data &dA09/01/03&d@ 
&dA 
              c5 = 0 
              if ttext{1} in ['A'..'Z','a'..'z','!'..'(','\','='] 
                c5 = 1 
              else 
                ttext = ttext // " " 
                loop for c4 = 1 to len(ttext) 
                  if ttext{c4} = "|" and ttext{c4+1} in ['A'..'Z','a'..'z','!'..'(','\','=']
                    c5 = 1 
                    c4 = len(ttext) 
                  end 
                repeat 
                ttext = trm(ttext) 
              end 
              if c5 = 1 
&dA 
&dA &d@        End of test &dA09/01/03&d@ 
&dA 
                c5 = mtfont 
                perform spacepar (c5) 
                temp2 = ttext 
                if temp2 con "$$$$" 
                  ttext = temp2{1,sub-1} 
                  c4 = int(temp2{sub+4..})        /* x offset (calculated earlier)
                  if sub < len(temp2) 
                    org_c4 = int(temp2{sub+1..})  /* original "unbiased" (pre &dA12/09/03&d@) offset
                  else 
                    org_c4 = c4 
                  end 
                end 
                temp2 = ttext // "| " 
                ttextcnt = 0 
CCCD: 
                if temp2 con "|" 
                  ttext = temp2{1,mpt-1} 

                  if ttext = "_"             /* &dA09/01/03&d@ Must flag isolated "_"
                    ttext = "&" 
                  end 

                  temp2 = temp2{mpt+1..} 
                  ++ttextcnt 
                  ttextarr(ttextcnt) = trm(ttext) 
                  goto CCCD 
                end 
                loop for a7 = 1 to ttextcnt 

                  ttext = ttextarr(a7) 
&dA 
&dA &d@  determine values of xbytearr 
&dA 
                  a6 = len(ttext) 
                  xbytearr(a7) = "* " 
                  if "-_" con ttext{a6} 
                    ttext = ttext{1,a6-1} 
                    xbytearr(a7) = "-_"{mpt} // " " 
                    if mpt = 2 
                      a6 = len(ttext) 
                      if ",.;:!?" con ttext{a6} 
                        ttext = ttext{1,a6-1} 
                        xbytearr(a7) = ",.;:!?"{mpt} // " " 
                      end 
                    end 
                  end 
                  ttextarr(a7) = ttext 
                repeat 
&dA 
&dA &d@   determine relative position of ttext 
&dA 
                x = p - c4 
                sobx = x - obx 
&dA 
&dA &d@          Code added &dA12/09/03&d@ 
&dA 
                if org_c4 <> c4 
                  a8 = p - org_c4 
                  sobx2 = a8 - obx 
                else 
                  sobx2 = 0 
                end 
&dA   
                loop for a8 = 1 to ttextcnt 
                  ttext = ttextarr(a8) 

                  if ttext <> "&"              /* &dA09/01/03&d@  Use flag set above
                    ++sobcnt 
&dA 
&dA &d@          Code modified &dA12/09/03&d@ 
&dA 
                    if sobx2 <> 0 
                      temp3 = "T " // chs(sobx) // "|" // chs(sobx2) // " " // chs(a8) // " "
                    else 
                      temp3 = "T " // chs(sobx) // " " // chs(a8) // " " 
                    end 
&dA   
                    if ttext con "=" 
                      if mpt < 3               /* &dA10/19/03&d@  Fixing corner case error
                        ttext{mpt} = "-" 
                      else 
                        if ttext{mpt-2,3} <> "\0=" 
                          ttext{mpt} = "-" 
                        end 
                      end 
                    end 
&dA 
&dA &d@       Introducing optional conversion to ligitures in text  &dA10/20/03&d@ 
&dA 
                    perform kernttext          /* New &dA04/22/04&d@ 
                    perform wordspace 
                    sobl(sobcnt) = temp3 // ttext // " " // xbytearr(a8) // chs(a5)
                  end 

                repeat 
              else 
                if ttext in [' ','~']             /* code added &dA02-23-95&d@ 
                  loop for c15 = len(ttext) to 1 step -1 
                    if ttext{c15} = "~" 
&dA 
&dA &d@        I'm going to try something risky here, namely to add a text sub-object
&dA &d@          to the previous note: temp variables c13,c14,c15 
&dA 
                      loop for c13 = outpnt to 1 step -1 
                        tget [Y,c13] temp3 
                        if temp3{1,3} = "J N" 
&dA 
&dA &d@                  1. Increment field 6 of record at c13 
&dA 
                          temp3 = temp3{5..} 
                          c14 = int(temp3) 
                          c14 = int(temp3{sub..}) 
                          c14 = int(temp3{sub..}) 
                          temp2 = "J N " // temp3{1..sub} 

                          c14 = int(temp3{sub..}) 
                          ++c14 
                          temp2 = temp2 // chs(c14) // temp3{sub..} 
                          tput [Y,c13] ~temp2 
&dA 
&dA &d@                  2. Create space at c13+1 
&dA 
                          loop for c14 = outpnt to c13 + 1 step -1 
                            tget [Y,c14] temp3 
                            tput [Y,c14+1] ~temp3 
                          repeat 
&dA 
&dA &d@                  3. Add pseudo text record at c13+1 
&dA 
                          temp3 = "T 0 " // chs(c15) // " ~ * 0" 
                          tput [Y,c13+1] ~temp3 
&dA 
&dA &d@                  4. Increment outpnt 
&dA 
                          ++outpnt 
                          c13 = 1        /* end of loop 
                        end 
                      repeat 
                    end 
                  repeat 
                end 
              end 
            end 
&dA 
&dA 
&dA                                                                

            note_dur = ts(c1,NOTE_DUR)            /* Added &dA11-11-93&d@ 

            if nodtype <= REST
              passtype = REG          
              passsize = FULLSIZE 
              if bit(16,ts(c1,SUBFLAG_1)) = 1 
                passsize = CUESIZE                /* EXPERIMENT  &dA06-24-94&d@ 
              end 
            else
              passsize = CUESIZE 
              if nodtype <= CUE_REST
                passtype = CUE
              else
                passtype = GRACE
              end
            end
&dA 
&dA &d@     a) rests 
&dA 
            if nodtype = REST or nodtype = CUE_REST
              color_flag = ts(c1,SUBFLAG_1) >> 28   /* Added &dA12/21/10&d@ 
              c3 = ts(c1,STAFF_NUM) * 1000 
              perform setrest (c9)                          /*  OK 6-23-93 
              goto ZZZZ  
            end  
&dA 
&dA &d@     b) arpeggios  (New code &dA01/13/06&d@) 
&dA 
            if nodtype = GR_NOTE and ntype = ARPEGGIO 
              perform setarpeggio 
              goto ZZZZ 
            end 
&dA 
&dA &d@     c) notes 
&dA 
&dA &d@        leger lines  hpar(82) =  width of black note (for typesetting) 
&dA &d@                     hpar(83) =  width of whole note (for typesetting) 
&dA 
            c7 = c2 
            c8 = c1 
            c9 = 0 
            stem = bit(1,ts(c1,STEM_FLAGS))  
            if stem = UP 
              chord_spread = ts(c2,STAFFLOC) - ts(c1,STAFFLOC) 
            else 
              chord_spread = ts(c1,STAFFLOC) - ts(c2,STAFFLOC) 
            end 
            super_flag = 0 
            slur_flag = 0 
            loop for c3 = c1 to c2 
              super_flag |= ts(c3,SUPER_FLAG) 
              slur_flag  |= ts(c3,SLUR_FLAG) 
            repeat 
            if ntype > HALF
              c9 = hpar(83) - hpar(82) + 1 
            end  
            perform setleger                      /* looks O.K. 6-24-93 
&dA 
&dA &d@        accidentals 
&dA 
            loop for c3 = c1 to c2 
              color_flag = ts(c3,SUBFLAG_1) >> 28   /* New &dA12/21/10&d@ 
              c4 = ts(c3,AX) 
              if c4 > 0 
                y = ts(c3,STAFFLOC) 
                perform setax                     /* looks O.K. 6-24-93 
              end 
            repeat 
&dA 
&dA &d@        note heads and dots  &dA01/08/11&d@  adding square/diamond notation 
&dA 
            if (ts(c1,SUBFLAG_1) & 0x8000) = 0    /* modern notation 
              if ntype > 10 
                z1 = 1015 - ntype 
              else 
                z1 = 50 - ntype             /* music font 
                if z1 > 43                  /* music font 
                  z1 = 43                   /* music font 
                end 
              end 
              if passsize = CUESIZE 
                z1 += 128                   /* music font 
              end 
            else 
              if ntype > 10 
                z1 = 1015 - ntype 
              else 
                z1 = 1014 - ntype 
                if z1 > 1008 
                  z1 = 1008 
                end 
              end 
            end 
&dA 
&dA &d@        Adding code for percussion note heads &dA02/19/06&d@ 
&dA 
            c4 = ts(c1,SUBFLAG_1) & 0xf00000 
            if c4 > 0 
              c4 >>= 20 
              if c4 = 1 
                z1 = 1001                 /* extended music font 
                if passsize = CUESIZE 
                  ++z1                    /* 
                end 
              end 
            end 
&dA     
            color_flag2 = 0                         /* Added &dA12/21/10&d@ 
            loop for c3 = c1 to c2 
              color_flag = ts(c3,SUBFLAG_1) >> 28   /* Added &dA12/21/10&d@ 
              color_flag2 |= color_flag             /* Added &dA12/21/10&d@ 
              if c3 = c1 
                obx = ts(c1,GLOBAL_XOFF) + p 
              end 
              x = obx + ts(c3,LOCAL_XOFF) 
              y = ts(c3,STAFFLOC) 
              z = z1 
&dA 
&dA &d@    Adding code &dA11/26/06&d@ to allow for mixed note_head types in chords 
&dA 
              if mixed_note_head_flag > 0 
                z = 50 - ts(c3,NTYPE) 
                if z > 43                                 /* music font 
                  z = 43                                  /* music font 
                end                                       /* music font 
                if passsize = CUESIZE 
                  z += 128 
                end                                       /* music font 
              end 
&dA 
&dA            &d@ End of &dA11/26/06&d@ Addition 

              if color_flag > 0
                perform subj3 (color_flag)      /* New &dA12/21/10&d@ 
              else 
                perform subj 
              end 
              c16 = y / notesize 
              if c16 <= 0 
                --c16        /* guarentee c16 is above position for rem <> 0 
              end 

              c10 = rem 
              if y <= 0 - notesize 
                if c10 <> 0 
                  y = c16 + 1 * notesize 
                end 
                perform wideleger         /* looks O.K. 6-24-93 
              end 
              if y >= vpar(10) 
                if c10 <> 0 
                  y = c16 * notesize 
                end 
                perform wideleger 
              end 
              perform setdots             /* looks O.K. 6-24-93 
            repeat 
&dA 
&dA &d@        look for forward tie, slur and tuplet super-objects   
&dA 
            x = obx  
            y = oby  
            color_flag = color_flag2      /* New &dA12/21/10&d@ 
            perform superfor              /* operates on entire chord  
&dA 
&dA &d@        set certain articulations above or below notes or stems 
&dA 
            color_flag = color_flag2      /* New &dA12/21/10&d@ 
            perform setart                /* operates on entire chord 
&dA 
&dA &d@        if there are slurs entering or leaving this chord, adjust virtual 
&dA &d@           endpoints at this time.  
&dA 
            c14 = ts(c1,SLUR_X) 
            c8 = 0                          /* slur present flag 
            if c14 > 0 
              c5 = ts(c14,1) 
              c4 = ts(c14,3) 
              if c4 <> c5 
                c8 = 2                      /* slur present above (usually) 
              end 
              if c4 < c5 
                c5 = c4                     /* above 
              end 
              c4 = ts(c14,2) 
              c6 = ts(c14,4) 
              if c4 <> c6 
                c8 = 1                      /* slur present below (usually) 
              end 
              if c6 > c4 
                c4 = c6                     /* below 
              end 
              if stem = DOWN 
                c6 = c4 
                c4 = c5 
                c5 = c6 
                if c8 <> 0 
                  c8 = 3 - c8 
                end 
              end 
              loop for c6 = c1 to c2 
                ts(c6,VIRT_STEM) = c5 
                ts(c6,VIRT_NOTE) = c4 
              repeat 
            else 
              c5 = ts(c1,VIRT_STEM) 
              c4 = ts(c1,VIRT_NOTE) 
            end 
&dA 
&dA &d@        Set more indications  
&dA 
            color_flag = color_flag2      /* New &dA12/21/10&d@ 
            perform setperf               /* operates on entire chord 
            color_flag = 0                /* New &dA12/21/10&d@ 
&dA 
&dA &d@        Set forte and piano (New code &dA05/17/03&d@) 
&dA 
            c17 = ( ts(c1,SUBFLAG_1) | ts(c1,ED_SUBFLAG_1) ) & 0x00007c00  /* New &dA12/18/10
            if c17 > 0 
              c7 = stem 
              px = 0 
              py = 0 
              pyy = 0 
              pxx = 0 
              c5 = 14                       /* dynamics code = 14 
              perform getpxpy (c5,c1) 

              if bit(0,pcontrol) = 1 
                if bit(1,pcontrol) = 1 
                  if bit(2,pcontrol) = 0 
                    c7 = 1 - stem 
                  else 
                    c7 = stem 
                  end 
                end 
              end 

              c5 = ts(c1,VIRT_STEM) 
              c4 = ts(c1,VIRT_NOTE) 
              c13 = 0  
              perform yadjust 
              if c7 = stem 
                if stem = DOWN 
                  y = c5 + vpar(5) 
                else 
                  y = c4 + vpar(5) 
                end 
              else 
                if stem = UP  
                  y = c5 - vpar(2) 
                else 
                  y = c4 - vpar(2) 
                end 
              end 
              x = obx + px 
              if pyy = 1 
                y = py 
              else 
                y += py 
              end 
              c7 = c17 >> 10                /* potential range 1 to 31 

              c17 = ts(c1,ED_SUBFLAG_1) & 0x00007c00  /* New &dA12/18/10
&dA 
&dA &d@        Case I: regular dynmaics 
&dA 
              if c17 = 0 

&dA            &d@ New code &dA10/08/08&d@ and &dA01/12/09&d@ and &dA03/16/09&d@ 
&dA 
                if c7 = 16 or c7 = 17 or c7 = 18 
                  if c7 = 18             /* sff 
                    z = 111               /* music font 
                    perform subj 
                    x += hpar(63) 
                    z = 110               /* music font 
                    perform subj 
                    x += hpar(62) 
                    z = 110               /* music font 
                    perform subj 
                  else 
                    if c7 = 16 
                      z = 110 
                      perform subj       /* f 
                      x += hpar(140) 
                    else 
                      z = 109 
                      perform subj       /* m 
                      x += hpar(60) 
                      z = 110 
                    end 
                    perform subj 
                    x += hpar(140)       /* f 
                    z = 108 
                    perform subj 
                    x += hpar(62)        /* p 
                  end 
&dA            
                else 
                  if c7 < 5                   /* p, pp, ppp, pppp 
                    z = 108 
                    loop while c7 > 0 
                      perform subj 
                      x += hpar(60) 
                      --c7 
                    repeat 
                  else 
                    if c7 < 9                 /* f, ff, fff, ffff 
                      z = 110 
                      loop while c7 > 4 
                        perform subj 
                        x += hpar(140) 
                        --c7 
                      repeat 
                    else 
                      if c7 < 11              /* mp, mf 
                        z = 109                   /* music font 
                        perform subj 
                        x = obx + hpar(60) + px 
                        z = c7 * 2 + 90           /* music font 
                        perform subj 
                      else 
                        if c7 = 11            /* fp 
                          z = 110                 /* music font 
                          perform subj 
                          x = obx + hpar(140) + px 
                          z = 108                 /* music font 
                          perform subj 
                        else 
                          if c7 = 12          /* sfp 
                            z = 111               /* music font 
                            perform subj 
                            x = obx + hpar(63) + px 
                            z = 110               /* music font 
                            perform subj 
                            x += hpar(140) 
                            z = 108               /* music font 
                            perform subj 
                          else 
                            if c7 > 13          /* sfz, rfz 
                              z = c7 * 2 + 83       /* music font 
                              perform subj 
                              c8 = z - 48 
                              x = obx + hpar(c8) + px 
                            end 
                            z = 110                 /* music font 
                            perform subj 
#if SFZ 
                            x += hpar(62) 
                            z = 112                 /* music font 
                            perform subj 
#endif 
                          end 
                        end 
                      end 
                    end 
                  end 
                end 
              else 
&dA 
&dA &d@        Case II: editorial dynamics 
&dA 

&dA 
&dA &d@      Conditional code added &dA02/04/04&d@ to implement Roman editorial dynamics
&dA 
#if ROMAN_EDIT 
                ++sobcnt 
                sobx = x - obx 
                soby = y - oby 

&dA            &d@ New code &dA10/08/08&d@ 
&dA 
                if c7 = 16 
                  sobl(sobcnt) = "W " // chs(sobx) // " " // chs(soby) // " 31 ffp"
&dA            

                else 
                  if c7 < 5                   /* p, pp, ppp, pppp 
                    sobl(sobcnt) = "W " // chs(sobx) // " " // chs(soby) // " 31 "
                    loop while c7 > 0 
                      sobl(sobcnt) = sobl(sobcnt) // "p" 
                      --c7 
                    repeat 
                  else 
                    if c7 < 9                 /* f, ff, fff, ffff 
                      sobl(sobcnt) = "W " // chs(sobx) // " " // chs(soby) // " 31 "
                      loop while c7 > 4 
                        sobl(sobcnt) = sobl(sobcnt) // "f" 
                        --c7 
                      repeat 
                    else 
                      if c7 < 11              /* mp, mf 
                        sobl(sobcnt) = "W " // chs(sobx) // " " // chs(soby) // " 31 m"
                        if c7 = 9 
                          sobl(sobcnt) = sobl(sobcnt) // "p" 
                        else 
                          sobl(sobcnt) = sobl(sobcnt) // "f" 
                        end 
                      else 
                        if c7 = 11            /* fp 
                          sobl(sobcnt) = "W " // chs(sobx) // " " // chs(soby) // " 31 fp"
                        else 
                          if c7 = 12          /* sfp 
                            sobl(sobcnt) = "W " // chs(sobx) // " " // chs(soby) // " 31 sfp"
                          else 
                            if c7 > 13          /* sfz, rfz 
                              if c7 = 14 
                                sobl(sobcnt) = "W " // chs(sobx) // " " // chs(soby) // " 31 sf"
                              else 
                                sobl(sobcnt) = "W " // chs(sobx) // " " // chs(soby) // " 31 rf"
                              end 
#if SFZ 
                              sobl(sobcnt) = sobl(sobcnt) // "z" 
#endif 
                            end 
                          end 
                        end 
                      end 
                    end 
                  end 
                end 
#else 
&dA 
&dA &d@        Editorial dynamics using square brackets and the music font 
&dA 

&dA            &d@ New code &dA10/08/08&d@ 
&dA 
                if c7 = 16 
                  x -= hpar(116) 
                  y -= vpar(84) 
                  z = 195 
                  perform subj 
                  x += hpar(116) 
                  y += vpar(84) 
                  z = 253                     /* editorial f 
                  perform subj       /* f 
                  x += hpar(110) 
                  perform subj       /* f 
                  x += hpar(110) 
                  perform subj       /* p 
                  x += hpar(108) 
                  x += hpar(120) 
&dA            
                else 

                  if c7 < 5                   /* p, pp, ppp, pppp 
                    x -= hpar(114) 
                    y -= vpar(84) 
                    z = 195 
                    perform subj 
                    x += hpar(114) 
                    y += vpar(84) 
                    z = 251                       /* editorial p 
                    loop while c7 > 0 
                      perform subj 
                      x += hpar(108) 
                      --c7 
                    repeat 
                    x += hpar(120) 
                  else 
                    if c7 < 9                 /* f, ff, fff, ffff 
                      x -= hpar(116) 
                      y -= vpar(84) 
                      z = 195 
                      perform subj 
                      x += hpar(116) 
                      y += vpar(84) 
                      z = 253                     /* editorial f 
                      loop while c7 > 4 
                        perform subj 
                        x += hpar(110) 
                        --c7 
                      repeat 
                      x += hpar(119) 
                    else 
                      if c7 < 11              /* mp, mf 
                        x -= hpar(115) 
                        y -= vpar(84) 
                        z = 195 
                        perform subj 
                        x += hpar(115) 
                        y += vpar(84) 
                        z = 252                   /* editorial m 
                        perform subj 
                        x += hpar(109) 
                        if c7 = 9 
                          z = 251                 /* editorial p 
                          perform subj 
                          x += hpar(108) 
                          x += hpar(120) 
                        else 
                          z = 253                 /* editorial f 
                          perform subj 
                          x += hpar(110) 
                          x += hpar(119) 
                        end 
                      else 
                        if c7 = 11            /* fp 
                          x -= hpar(116) 
                          y -= vpar(84) 
                          z = 195 
                          perform subj 
                          x += hpar(116) 
                          y += vpar(84) 
                          z = 253                 /* editorial f 
                          perform subj 
                          x += hpar(110) 
                          z = 251                 /* editorial p 
                          perform subj 
                          x += hpar(108) 
                          x += hpar(120) 
                        else 
                          if c7 = 12          /* sfp 
                            x -= hpar(117) 
                            y -= vpar(84) 
                            z = 195 
                            perform subj 
                            x += hpar(117) 
                            y += vpar(84) 
                            z = 246               /* editorial s 
                            perform subj 
                            x += hpar(111) 
                            z = 253               /* editorial f 
                            perform subj 
                            x += hpar(110) 
                            z = 251               /* editorial p 
                            perform subj 
                            x += hpar(108) 
                            x += hpar(120) 
                          else 
                            if c7 > 13          /* sfz, rfz 
                              if c7 = 14 
                                x -= hpar(117) 
                                y -= vpar(84) 
                                z = 195 
                                perform subj 
                                x += hpar(117) 
                                y += vpar(84) 
                                z = 246           /* editorial s 
                                perform subj 
                                x += hpar(111) 
                              else 
                                x -= hpar(118) 
                                y -= vpar(84) 
                                z = 195 
                                perform subj 
                                x += hpar(118) 
                                y += vpar(84) 
                                z = 248           /* editorial r 
                                perform subj 
                                x += hpar(113) 
                              end 
                              z = 253             /* editorial f 
                              perform subj 
                              x += hpar(110) 
#if SFZ 
                              z = 247             /* editorial z 
                              perform subj 
                              x += hpar(112) 
#else 
                              x += hpar(119) 
#endif 
                            end 
                          end 
                        end 
                      end 
                    end 
                  end 
                end 
                y -= vpar(84) 
                z = 196 
                perform subj 
#endif 
&dA 
&dA    &d@  End of Conditional compile &dA02/04/04&d@ 
&dA 
              end 
            end 
&dA 
&dA &d@        End of New code &dA05/17/03&d@ 
&dA 
            loop for c3 = c1 to c2 
              ts(c3,VIRT_NOTE) = c4 
              ts(c3,VIRT_STEM) = c5 
            repeat 
&dA 
&dA &d@        set stems and beams for this note 
&dA 
            if stem = UP 
              c3 = c1 
            else 
              c3 = c2 
            end 
            color_flag = color_flag2      /* New &dA12/21/10&d@ 
            perform setstem        /* (revised for multiple notes) 
&dA 
&dA &d@        determine super-objects &dAwhich end&d@ on this note or which 
&dA &d@            contain this note (such as beams) 
&dA 
&dA &d@         1) beams 
&dA 
            if ts(c1,BEAM_FLAG) > 0  
              ++supcnt
              supnums(supcnt) = beampar(passtype,passnum,BM_SNUM)  
            end  
&dA 
&dA &d@         2) ties which end on this note                    
&dA 
            loop for c3 = c1 to c2 
              c7 = ts(c3,BACKTIE) 
              if c7 > 0 
                if c7 < INT10000         /* c7 = index to ts element which starts the tie
                  c7 = ts(c7,BACKTIE)    /* c7 now points to ROW of tiearr 
                else 
                  c7 -= INT10000 
                end 
                ++supcnt 
                supnums(supcnt) = tiearr(c7,TIE_SNUM) 
              end 
              ts(c3,BACKTIE) = c7        /* now set BACKTIE to point directly to ROW of tiearr
            repeat 
&dA 
&dA &d@         3) slurs      (revised for multiple notes)  
&dA 
            loop for c4 = 1 to 4 
              c5 = c4 * 2 - 1
              if bit(c5,slur_flag) = 1 
                ++supcnt
                supnums(supcnt) = slurar(c4,SL_SNUM) 
              end  
              if bit(c5+16,slur_flag) = 1 
                ++supcnt
                supnums(supcnt) = slurar(c4+4,SL_SNUM) 
              end  
            repeat 
&dA 
&dA &d@         4) tuplets    (revised for multiple notes)  
&dA 
            if bit(5,super_flag) = 1 
              ++supcnt
              supnums(supcnt) = tuar(passtype,passnum,TU_SNUM)  
            end  
&dA 
&dA &d@         5) long trills     (revised for multiple notes)  
&dA 
            if tsnum(passnum) > 0 and bit(3,super_flag) = 1    /* long trill ending
              ++supcnt 
              supnums(supcnt) = tsnum(passnum) 
            end  
&dA 
&dA &d@    New code (&dA11-11-93&d@)  Duration attribute of note 
&dA 
            ++sobcnt 
            sobl(sobcnt) = "A D " // chs(note_dur) // " " // chs(divspq*4) 
&dA 
&dA &d@    Write out Object Record and associated Sub-Objects  
&dA 
            out = chs(supcnt)  
            loop for c4 = 1 to supcnt  
              out = out // " " // chs(supnums(c4)) 
            repeat 
            if nodtype = GR_NOTE or nodtype = XGR_NOTE 
              jtype = "G" 
            else 
              jtype = "N" 
            end 
            jcode = ntype  
            pcode = sobcnt 
            c10 = ts(c1,STAFF_NUM) * 1000 
            oby += c10
&dA 
&dA &d@       Now look for print suggestions for this note object 
&dA 
            putobjpar = 0 
            c4 = ts(c1,TSR_POINT) 
            pcontrol = ors(tsr(c4){1})                  /* &dA05/02/03&d@ 
            px = ors(tsr(c4){3}) << 8 
            py = ors(tsr(c4){4}) << 16 
            c8 = ors(tsr(c4){2}) << 24 
            putobjpar = c8 + px + py + pcontrol         /* Note: order of data has been changed

            perform putobj                  
            oby -= c10
&dA 
&dA &d@    Write out completed Super-Objects and set up new ones 
&dA 
&dA &d@      1) Tuples 
&dA 
            if bit(5,super_flag) = 1      /*  (revised for multiple notes) 
&dA 
&dA &d@     Code added &dA05-31-95&d@ to prevent tuplets over "partial" beams from being 
&dA &d@        associated with those beams.  
&dA 
              if beampar(passtype,passnum,BM_TUPLE) > 0 
                if beampar(passtype,passnum,BM_READY) = 0 
                  beampar(passtype,passnum,BM_TUPLE) = 0 
                end 
              end 

              c8 = 1 
              t2 = 0 
              t1 = (tuar(passtype,passnum,TU_FSTEM) & 0xff) + stem 
              c9 = tuar(passtype,passnum,TU_Y1) 
              c11 = 0 
              goto TPF(tpflag+1) 
TPF(1):                                   /* default tuplet placement 
              if beampar(passtype,passnum,BM_TUPLE) > 0 
                c8 |= 0x08 
                t2 = beampar(passtype,passnum,BM_SNUM) 
                t1 = oby 
                if ts(c1,MULTI_TRACK) > 0 
                  c8 |= 0x10 
                else 
                  t1 += chord_spread 
                  c9 = tuar(passtype,passnum,TU_Y2) 
                end 
                c10 = tuar(passtype,passnum,TU_FSTEM) & 0xff00 
                c10 >>= 8 
                if bit(0,c10) = 1       /* bracket present &dA03-21-97&d@ 
                  c10 >>= 1 
                  c10 <<= 5 
                  c10 |= 0x02           /* add bracket 

                  if beampar(passtype,passnum,BM_TUPLE) = 2    /* this code expanded &dA05/06/03
                    if bit(4,c8) = 1 
                      c10 |= 0x04         /* tips up 
                    end 
                  else 
                    if bit(4,c8) = 0 
                      c10 |= 0x04         /* tips up 
                    end 
                  end 
                  c8 |= c10 
                end 
                goto TPFEC 
              else 
                if t1 = 0 
                  goto TPFEA 
                else 
                  goto TPFEB 
                end 
              end 
TPF(2):                                   /* place tuplet near note heads 
              if beampar(passtype,passnum,BM_TUPLE) > 0 
                c8 |= 0x08 
                t2 = beampar(passtype,passnum,BM_SNUM) 
                t1 = oby + chord_spread 
                c9 = tuar(passtype,passnum,TU_Y2) 
                c10 = tuar(passtype,passnum,TU_FSTEM) & 0xff00 
                c10 >>= 8 
                if bit(0,c10) = 1       /* bracket present &dA03-21-97&d@ 
                  c10 >>= 1 
                  c10 <<= 5 
                  c10 |= 0x02           /* add bracket 
                  if beampar(passtype,passnum,BM_TUPLE) = 1 
                    c10 |= 0x04         /* tips up 
                  end 
                  c8 |= c10 
                end 
                goto TPFEC 
              else 
                if t1 = 0 
                  goto TPFEA 
                else 
                  goto TPFEB 
                end 
              end 
TPF(3):                                   /* place tuplet near stems 
              if beampar(passtype,passnum,BM_TUPLE) > 0 
                c8 |= 0x18 
                t2 = beampar(passtype,passnum,BM_SNUM) 
                t1 = oby 
                c10 = tuar(passtype,passnum,TU_FSTEM) & 0xff00 
                c10 >>= 8 
                if bit(0,c10) = 1       /* bracket present &dA03-21-97&d@ 
                  c10 >>= 1 
                  c10 <<= 5 
                  c10 |= 0x02           /* add bracket 
                  if beampar(passtype,passnum,BM_TUPLE) = 2 
                    c10 |= 0x04         /* tips up 
                  end 
                  c8 |= c10 
                end 
                goto TPFEC 
              else 
                if t1 > 0 
                  goto TPFEA 
                else 
                  c11 = hpar(82)          /* shift for stems up 
                  goto TPFEB 
                end 
              end 
TPF(4):                                   /* place all tuplets above notes 
              if beampar(passtype,passnum,BM_TUPLE) > 0 
                t1 = oby 
                if stem = UP 
                  c8 |= 0x18 
                else 
                  c8 |= 0x08 
                  t1 += chord_spread 
                  c9 = tuar(passtype,passnum,TU_Y2) 
                end 
                t2 = beampar(passtype,passnum,BM_SNUM) 
                c10 = tuar(passtype,passnum,TU_FSTEM) & 0xff00 
                c10 >>= 8 
                if bit(0,c10) = 1       /* bracket present &dA03-21-97&d@ 
                  c10 >>= 1 
                  c10 <<= 5 
                  c10 |= 0x02           /* add bracket 
                  c8 |= c10 
                end 
                goto TPFEC 
              else 
                if t1 = 0 
                  c11 = hpar(82)
                end 
                goto TPFEB 
              end 
TPF(5):                                   /* place all tuplets below notes 
              if beampar(passtype,passnum,BM_TUPLE) > 0 
                t1 = oby 
                if stem = UP 
                  c8 |= 0x08 
                  t1 += chord_spread 
                  c9 = tuar(passtype,passnum,TU_Y2) 
                else 
                  c8 |= 0x18 
                end 
                t2 = beampar(passtype,passnum,BM_SNUM) 
                c10 = tuar(passtype,passnum,TU_FSTEM) & 0xff00 
                c10 >>= 8 
                if bit(0,c10) = 1       /* bracket present &dA03-21-97&d@ 
                  c10 >>= 1 
                  c10 <<= 5 
                  c10 |= 0x02           /* add bracket 
                  c10 |= 0x04           /* tips up 
                  c8 |= c10 
                end 
                goto TPFEC 
              else 
                if t1 > 0 
                  c11 = hpar(82)
                end 
                goto TPFEA 
              end 

TPFEA: 
              c9 = tuar(passtype,passnum,TU_Y2) + notesize 
              c9 += vpar(64) 
              if t1 > 0 
                c9 += vpar(7) 
                t1 = vpar(7)                       /* add distance if stem is down
              else 
                t1 = 0 
              end 
              c10 = notesize * 6 
              if c9 < c10 
                c9 = c10 
              end 
              t1 += oby + notesize + vpar(64)      /* t1 set above 
              if t1 < c10 
                t1 = c10 
              end 
              c10 = tuar(passtype,passnum,TU_FSTEM) & 0xff00 
              c10 >>= 8 
              if bit(0,c10) = 1       /* bracket present &dA03-21-97&d@ 
                c10 >>= 1 
                c10 <<= 5 
                c10 |= 0x02           /* add bracket 
                c10 |= 0x04           /* tips up  
                c8 |= c10 
              end 
              goto TPFEC 
TPFEB: 
              c9 = tuar(passtype,passnum,TU_Y2) - notesize 
              c10 = 0 - vpar(1)           /* OK 4-21-95 
              if t1 = 0 
                c9 -= vpar(7) 
                t1 = 0 - vpar(7)                   /* subtract distance if stem is up  
              else 
                t1 = 0 
              end 
              if c9 > c10 
                c9 = c10 
              end 
              t1 += oby - notesize                 /* t1 set above 
              if t1 > c10 
                t1 = c10 
              end 
              c10 = tuar(passtype,passnum,TU_FSTEM) & 0xff00 
              c10 >>= 8 
              if bit(0,c10) = 1       /* bracket present &dA03-21-97&d@ 
                c10 >>= 1 
                c10 <<= 5 
                c10 |= 0x02           /* add bracket 
                c8 |= c10 
              end 
TPFEC:        
              c9 -= tuar(passtype,passnum,TU_Y1) 
              t1 -= oby 
&dA 
&dA &d@       Convert c13 to 1000 * n1 + n2 and get x,y adjustments    New &dA11/05/05
&dA 
              c13 = ts(c1,TUPLE) & 0xffff 
              c17 = c13 >> 8 
              c13 &= 0xff 
              c17 *= 1000 
              c13 += c17 

              c17 = ts(c1,TUPLE) & 0xff0000       /* x adjustment 
              c17 >>= 16 
              if c17 > 0 
                c16 = c17 - 128                   /* center to zero 
              else 
                c16 = 0 
              end 
              c11 += c16 

              c17 = ts(c1,TUPLE) & 0xff000000     /* y adjustment 
              c17 >>= 24 
              if c17 > 0 
                c17 = c17 - 128                   /* center to zero 
              else 
                c17 = 0 
              end 
              c9 += c17 
              t1 += c17 
&dA        
              t3  = tuar(passtype,passnum,TU_SNUM)  
              ++outpnt 
              tput [Y,outpnt] H ~t3  X ~c8  ~c13  ~c16  ~c9  ~c11  ~t1  ~t2 
              tuar(passtype,passnum,TU_SNUM) = 0       /* &dA05/05/03&d@ adding this (from s2ed)     
              tpflag = global_tpflag 
            end  
&dA 
&dA &d@      2) Beams           (O.K. for multiple notes) 
&dA 
            if beampar(passtype,passnum,BM_READY) > 0 
              if notesize = 6 
                if beampar(passtype,passnum,BM_SIZE) = CUESIZE 
                  beamfont = 102                
                else 
                  beamfont = 103                 
                end 
              end 
              if notesize = 14 
                if beampar(passtype,passnum,BM_SIZE) = CUESIZE 
                  beamfont = 106                 
                else 
                  beamfont = 108                 
                end 
              end 
              if notesize = 16                  /* size-16 added &dA12/31/08&d@ 
                if beampar(passtype,passnum,BM_SIZE) = CUESIZE 
                  beamfont = 107                 
                else 
                  beamfont = 109                 
                end 
              end 
              if notesize = 18                  /* size-18 added &dA12/18/04&d@ 
                if beampar(passtype,passnum,BM_SIZE) = CUESIZE 
                  beamfont = 107                 
                else 
                  beamfont = 110                 
                end 
              end 
              if notesize = 21 
                if beampar(passtype,passnum,BM_SIZE) = CUESIZE 
                  beamfont = 109                 
                else 
                  beamfont = 112                 
                end 
              end 

              c4 = beampar(passtype,passnum,BM_CNT)        
              c5 = 1 
              c6 = 0 
              c7 = beampar(passtype,passnum,BM_STEM) << 1 
              loop for c3 = 1 to c4 
                c7 >>= 1 
                if c7 & 0x01 <> 1 
                  c6 = 1 
                end 
                c5 <<= 1 
              repeat 

              c7 += beampar(passtype,passnum,BM_SUGG)        /* New code &dA05/14/03

              out = chs(c7) // " "               /* first stem direction 
              c8 = beampar(passtype,passnum,BM_STEM) 
              if c6 = 0 or c8 = 0 
                out = out // "0 "                /* consistant stem directions 
              else 
                if c7 & 0x01 = UP                            /* New code &dA05/14/03
                  c5 -= 1                        /* c5 = 111 ... for number of notes
                  c8 = not(c8) & c5 
                end 
                out = out // chs(c8) // " " 
              end 
              out = out // chs(beamfont) // " " 
              out = out // chs(beampar(passtype,passnum,BM_READY))
              loop for c4 = 1 to beampar(passtype,passnum,BM_READY) 
                out = out // " " 
                out = out // chs(beamdata(passtype,passnum,c4))
              repeat 
              ++outpnt 

              if beampar(passtype,passnum,BM_COLOR) > 4 
                if beampar(passtype,passnum,BM_COLOR) = 5 
                  tput [Y,outpnt] P ~beampar(passtype,passnum,BM_SNUM)  B ~out
                else 
                  if beampar(passtype,passnum,BM_COLOR) = 6 
                    tput [Y,outpnt] P 0x00ff00 ~beampar(passtype,passnum,BM_SNUM)  B ~out
                  else 
                    tput [Y,outpnt] P 0x0000ff ~beampar(passtype,passnum,BM_SNUM)  B ~out
                  end 
                end 
              else 
                tput [Y,outpnt] H ~beampar(passtype,passnum,BM_SNUM)  B ~out
              end 

              beampar(passtype,passnum,BM_READY) = 0  
              beampar(passtype,passnum,BM_TUPLE) = 0 
              beampar(passtype,passnum,BM_COLOR) = 0 
            end  
&dA 
&dA &d@      3) Ties            (revised for multiple notes)  
&dA 
            tiecnt = 0 
            loop for c3 = c1 to c2 
              color_flag = ts(c3,SUBFLAG_1) >> 28   /* Added &dA12/21/10&d@ 
              c7 = ts(c3,BACKTIE) 
              if c7 > 0 
&dA 
&dA &d@        compute sitf (situation flag) 
&dA 
&dA &d@        Description of sitf:   range 1 to 16  
&dA &d@    
&dA &d@        If the range were from 0 to 15, then bits 3 to 0     
&dA &d@          would have the following meanings:  
&dA &d@    
&dA &d@                          zero          |         one 
&dA &d@                   -------------------------------------------- 
&dA &d@          bit 3:        tips down       |       tips up 
&dA &d@          bit 2:      note on space     |     note on line  
&dA &d@          bit 1:   no stem interfenence |   stem interference 
&dA &d@          bit 0:    staff interference  | no staff interference 
&dA 
                c9 = tiearr(c7,TIE_VLOC) 
                c10 = tiearr(c7,TIE_FHDIS)        /* local x-offset for first note
                c11 = ts(c3,LOCAL_XOFF)           /* local x-offset for second note
                c12 = tiearr(c7,TIE_FORCE)        /* force flag 
                if c12 = 3 
                  c12 = 9 
                end 
                c8 = ts(c3,MULTI_TRACK) 
                c6 = c8 >> 2                      /* multi-track flag 
                c8 &= 0x03                        /* mcat flag 
&dA 
&dA &d@             Modify multi-track flag under certain conditions 
&dA &d@                   &dAADDED   9-10-93&d@ 
&dA 
                if c6 > 0 
                  if ts(c3,PASSNUM) = 1 and bit(1,ts(c3,STEM_FLAGS)) = DOWN 
                    c6 = 0 
                  end 
                end 

                if c6 = 0 
                  if c8 < 2 
&dA 
&dA &d@             Rules for single note (or chord) of single part 
&dA 
                    if bit(2,ts(c3,STEM_FLAGS)) = 0 /* &dAsingle note&d@ 
                      c5 = tiearr(c7,TIE_FSTEM) + stem 
                      if c5 = 0 
                        sitf = 9                    /* both stems up 
                      else 
                        sitf = 1 
                      end 

                      if c12 > 0 
                        sitf = c12                  /* forced situation 
                      end 

                      if tiearr(c7,TIE_FSTEM) = UP and sitf < 9 
                        sitf += 2                   /* stem interference 
                      end 
                    else                            /* &dAchord&d@ 
                      if c3 < c2 
                        sitf = 1 
                      else 
                        sitf = 9 
                      end 

                      if c12 > 0 
                        sitf = c12                  /* forced situation 
                      end 

                      if sitf = 1 
                        if tiearr(c7,TIE_FSTEM) = UP  
                          if c10 = 0 
                            sitf += 2               /* stem interference 
                          end 
                        else 
                          if stem = DOWN and c3 <> c1 
                            if c11 = 0 
                              sitf += 2             /* stem interference 
                            end 
                          end 
                        end 
                      else 
                        if stem = DOWN 
                          if c11 = 0 
                            sitf += 2               /* stem interference 
                          end 
                        end 
                      end 
                    end 
                  else 
&dA 
&dA &d@             Rules for chords representing multiple parts 
&dA 
                    if c3 = c2                    /* bottom note of chord 
                      sitf = 9 
                    else 
                      sitf = 1 
                    end 

                    if c12 > 0 
                      sitf = c12                  /* forced situation 
                    end 

                    if c3 = c2 
                      if stem = DOWN 
                        sitf += 2                 /* stem interference 
                      end 
                    else 
                      if c3 = c1 
                        if tiearr(c7,TIE_FSTEM) = UP 
                          sitf += 2               /* stem interference 
                        end 
                      else 
                        if tiearr(c7,TIE_FSTEM) = UP or stem = DOWN 
                          sitf += 2               /* stem interference 
                        end 
                      end 
                    end 
                  end 
                else 
&dA 
&dA &d@             Rules for multiple passes on a staff 
&dA 
                  if c6 = 1 
                    sitf = 3 
                    if c12 = 9 
                      sitf = 11          
                    end 
                  else 
                    if c6 = 2 
                      sitf = 11 
                      if c12 = 1 
                        sitf = 3             
                      end 
                    else 
                      if c6 = 3 
                        if stem = UP 
                          sitf = 1 
                          if c12 > 0 
                            sitf = c12            /* forced situation 
                          end 
                          if tiearr(c7,TIE_FSTEM) = UP 
                            sitf += 2 
                          end 
                        else 
                          sitf = 11 
                          if c12 = 1 
                            sitf = 3 
                          end 
                        end 
                      end 
                    end 
                  end 
                end 
                c5 = c9 / notesize 
                if rem = 0 
                  sitf += 4                    /* note on line 
                end 
&dA 
&dA &d@       Note:  you won't know if there is staff interference until 
&dA &d@                   you know the final length of the tie 
&dA 
                c9 += tiearr(c7,TIE_STAFF) * 1000 
&dA 
&dA &d@            New code added &dA04/20/03&d@, modified &dA05/02/03&d@    
&dA 
                c13 = tiearr(c7,TIE_SUGG) & 0xff000000        /* length data
                c6  = tiearr(c7,TIE_SUGG) & 0xff0000          /* position flags
                c4  = tiearr(c7,TIE_SUGG) & 0xff00            /* x data 
                c5  = tiearr(c7,TIE_SUGG) & 0xff              /* y data 
                c13 >>= 24 
                c6 >>= 16 
                c4 >>= 8 
                if c4 > 0 
                  c4 = c4 - 128 * notesize / 10 
                end 
                if c5 > 0 
                  c5 = c5 - 128 * notesize / 10 
                end 
                if bit(2,c6) = 1 
                  c5 += 10000 
                end 
                c6 = 0 
                if c13 > 0 
                  c6 = c13 - 128 * notesize / 10 
                end 

          /* end New code 

                c8 = tiearr(c7,TIE_SNUM) 

                ++outpnt 
                if tiearr(c7,TIE_COLOR) > 4                /* New &dA12/21/10&d@ 
                  if tiearr(c7,TIE_COLOR) = 5 
                    tput [Y,outpnt] P ~c8  T ~c9  ~c10  ~c11  ~c4  ~c5  ~c6  ~sitf  0
                  else 
                    if tiearr(c7,TIE_COLOR) = 6 
                      tput [Y,outpnt] P 0x00ff00 ~c8  T ~c9  ~c10  ~c11  ~c4  ~c5  ~c6  ~sitf  0
                    else 
                      tput [Y,outpnt] P 0x0000ff ~c8  T ~c9  ~c10  ~c11  ~c4  ~c5  ~c6  ~sitf  0
                    end 
                  end 
                else 
                  tput [Y,outpnt] H ~c8  T ~c9  ~c10  ~c11  ~c4  ~c5  ~c6  ~sitf  0
                end 

                tiearr(c7,TIE_SNUM) = 0 
                ts(c3,BACKTIE) = 0 
              end 
&dA 
&dA &d@       If there is a tie leaving this note, build 
&dA &d@         up a new ROW element of tiearr 
&dA 
              if bit(0,ts(c3,SUPER_FLAG)) = 1 
*      identify free slice of tiearr 
                loop for c7 = 1 to MAX_TIES 
                  if tiearr(c7,TIE_SNUM) = 0 
                    goto X2 
                  end 
                repeat 
&dA 
&dA &d@          Here is where tiearr is built 
&dA 
X2:             ++tiecnt 
                tiearr(c7,TIE_SNUM)  = tv4(tiecnt,1) 
                tiearr(c7,TIE_NTYPE) = ts(c3,TYPE) 
                tiearr(c7,TIE_VLOC)  = ts(c3,STAFFLOC) 
                tiearr(c7,TIE_FHDIS) = ts(c3,LOCAL_XOFF) 
                tiearr(c7,TIE_FSTEM) = bit(1,ts(c3,STEM_FLAGS)) 
                tiearr(c7,TIE_NDX)   = c3 
                tiearr(c7,TIE_STAFF) = ts(c3,STAFF_NUM) 
                tiearr(c7,TIE_FOUND) = 0 
                tiearr(c7,TIE_FORCE) = ts(c3,SLUR_FLAG) >> 24 
       /* New code &dA04/20/03&d@ 
                c4 = ts(c3,TSR_POINT) 
                tiearr(c7,TIE_SUGG)  = ors(tsr(c4){69,4}) 
                tiearr(c7,TIE_COLOR) = tv4(tiecnt,2)            /* New &dA12/21/10

                ts(c3,BACKTIE) = c7        /* not used here as a back pointer 
              end 
            repeat 
&dA 
&dA &d@      4) Slurs           (revised for multiple notes) 
&dA 
            loop for c4 = 1 to 8 
              c5 = c4 * 2 - 1  
              if c4 > 4 
                c5 += 8 
              end 
&dA 
&dA &d@     end-slurs  
&dA &d@                       
&dA &d@       first element 
&dA &d@       ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA &d@          bit 27:     start/end flag (0 = start, 1 = end) 
&dA &d@          bits 24-26: slur number - 1 (0 to 7) 
&dA &d@          bits 17-23: curvature information (end only) 
&dA &d@          bit 16:     up/down flag (0 = tips up, 1 = tips down) (end only) 
&dA &d@          bits 0-15:  x-offset + 1000 (always a positive number) 
&dA &d@       second element 
&dA &d@       ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA &d@          y position relative to the staff 
&dA &d@       third element (&dA05/06/03&d@) 
&dA &d@       ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA &d@          print suggestion for this end of the slur 
&dA 
              if bit(c5,slur_flag) = 1 
                c14 = ts(c1,SLUR_X) 
                loop for c13 = 7 to (TS_SIZE - 2) step 3     /* &dA05/06/03&d@ 
                  c12 = ts(c14,c13)          
                  c11 = c12 >> 24 
                  if c11 = c4 + 0x0f       /* c4 - 1 + 0x10  (end of slur) 
                    c11 = c12 & 0xffff - 1000      /* x-offset 
                    c10 = bit(16,c12)              /* up/down flag 
                    c9  = c12 & 0x000e0000 >> 17   /* curvature (1 to 4) 
                    c8 = ts(c14,c13+1) - ts(c1,OBY) /* y-offset 
                    c15 = ts(c14,c13+2)            /* print suggestion at end of slur (&dA05/06/03&d@)
                    c13 = 100                      /* end of loop 
                  end 
                repeat 
                sitf = 0 
                if in_line_edslur > 0       /* New condition &dA01/12/09&d@ 
                  if c4 > 2 
                    sitf = 1                /* dotted slur 
                  end 
                else 
                  if c4 > 4 
                    sitf = 1                /* dotted slur 
                  end 
                end 
                if c10 = UP 
                  sitf += 12 
                end 
                c10 = slurar(c4,SL_SNUM)    /* slur number 
                c7  = slurar(c4,SL_YSHIFT)  /* starting y-shift 
                c6  = slurar(c4,SL_XSHIFT)  /* starting x-shift 
                c9 -= 1 
                c13 = slurar(c4,SL_BEAMF)   /* 0 = slur doesn't start on a beam                 
                                            /* 1 = slur starts on a stem up beam
                                            /* 2 = slur starts on a stem down beam
                c16 = slurar(c4,SL_SUGG)    /* print sugg. from beginning of slur (&dA05/06/03&d@)
                c12 = 0 
                if c13 > 0 
                  if bit(1,ts(c1,BEAM_FLAG)) = 1
                    if stem = UP and c8 < 0 - vpar(6) 
                      c12 = 1 
                    end 
                    if stem = DOWN and c8 > vpar(6) 
                      c12 = 2 
                    end 
                  end 
                  if c12 <> c13 
                    c12 = 0 
                  end 
                end 
&dA 
&dA &d@      Code added &dA04/26/05&d@ to implement suppression of slur printing 
&dA 
                if c16 = -1 
                  sitf = 32            
                  c16 = 0 
                end 
&dA         
                c17 = c16 >> 24                        /* relative x start 
                c17 &= 0xff 
                if c17 > 0 
                  c17 = c17 - 128 * notesize + 5 / 10 
                  c6 += c17 
                end 

                c17 = c16 & 0xff0000 >> 16             /* relative y start 
                if c17 > 0 
                  c17 = c17 - 128 * notesize + 5 / 10 
                  c7 += c17 
                end 

                c17 = c15 >> 24                        /* relative x end 
                c17 &= 0xff 
                if c17 > 0 
                  c17 = c17 - 128 * notesize + 5 / 10 
                  c11 += c17 
                end 

                c17 = c15 & 0xff0000 >> 16             /* relative y end  
                if c17 > 0 
                  c17 = c17 - 128 * notesize + 5 / 10 
                  c8 += c17 
                end 

                c17 = c15 & 0xff00 >> 8                /* change to curvature
                if c17 > 0 
                  c17 = c17 - 128 * notesize + 5 / 10 
                  c9 += c17 
                end 

                c17 = c16 & 0xff00 >> 8                /* global X shift 
                if c17 > 0 
                  c17 = c17 - 128 * notesize + 5 / 10 
                end 
                            
                c16 = c16 & 0xff                       /* global Y shift 
                if c16 > 0 
                  c16 = c16 - 128 * notesize + 5 / 10 
                end 

                ++outpnt 
                tput [Y,outpnt] H ~c10  S ~sitf  ~c6  ~c7  ~c11  ~c8  ~c9  ~c12  ~c17  ~c16
              end  
&dA 
&dA &d@     beginning-slurs  
&dA 
              --c5
              if bit(c5,slur_flag) = 1  
                c14 = ts(c1,SLUR_X) 
                loop for c13 = 7 to (TS_SIZE - 2) step 3     /* &dA05/06/03&d@ 
                  c12 = ts(c14,c13)          
                  c11 = c12 >> 24 
                  if c11 = c4 - 1                  /* c4 - 1  (beginning of slur)
                    c11 = c12 & 0xffff - 1000      /* x-offset 
                    c8 = ts(c14,c13+1) - ts(c1,OBY) /* y-offset 
                    c15 = ts(c14,c13+2)            /* print suggestion at beginning of slur
                    c13 = 100                      /* end of loop 
                  end 
                repeat 
                if c13 < 100 
                  tmess = 37 
                  perform dtalk (tmess) 
                end 
                c12 = 0 
                if ts(c1,BEAM_FLAG) > 1 
                  if stem = UP and c8 < 0 - vpar(6) 
                    c12 = 1 
                  end 
                  if stem = DOWN and c8 > vpar(6) 
                    c12 = 2 
                  end 
                end 
                slurar(c4,SL_SNUM)   = slurar(c4,SL_NEXTSNUM) 
                slurar(c4,SL_YSHIFT) = c8 
                slurar(c4,SL_XSHIFT) = c11 
                slurar(c4,SL_BEAMF)  = c12  /* 0 = slur doesn't start on a beam
                                            /* 1 = slur starts on a stem up beam
                                            /* 2 = slur starts on a stem down beam
                slurar(c4,SL_SUGG)   = c15  /* (&dA05/06/03&d@) 
              end  
            repeat 
&dA 
&dA &d@      5) Long Trills  
&dA 
            if bit(3,super_flag) = 1 and tsnum(passnum) > 0 
              out = "H " // chs(tsnum(passnum)) // " R " // chs(ctrarrf(passnum))
              out = out // " 0" 
              ++outpnt 
              if nodtype = GR_NOTE or nodtype = XGR_NOTE
                tput [Y,outpnt] ~out  0 ~try(passnum) 
              else 
                tput [Y,outpnt] ~out  -~hpar(42)  ~try(passnum) 
              end  
              tsnum(passnum) = 0 
              ctrarrf(passnum) = 0 
            end  
            if pre_tsnum(passnum) > 0                  /* substitute preliminary values
              tsnum(passnum) = pre_tsnum(passnum) 
              ctrarrf(passnum) = pre_ctrarrf(passnum) 
              try(passnum) = pre_try(passnum) 
              pre_tsnum(passnum) = 0 
            end 
ZZZZ: 
          repeat 
          p += a4    

&dA 
&dA &d@    Now that you are all done with the notes and rests of 
&dA &d@       this node, you may set the new inctype 
&dA 
          if ts(a1,DINC_FLAG) > 0 
            inctype = ts(a1,DINC_FLAG) 
          end  
          a1 = a2  
ZZZ:    repeat     
&dA 
&dA &d@    End of processing loop  
&dA &d@************************************************************* 
&dA 
ACT_RETURN: 
        loop for t1 = 1 to 50 
          loop for t2 = 1 to 4                      
            measax(t2,t1) = tclaveax(t1)            
          repeat 
        repeat 
      return   

&dA  ****************************************************************  
&dA ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ» 
&dA º        E N D   O F    P R O C E D U R E    A C T I O N         º 
&dA ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼ 
&dA  **************************  action *****************************  
