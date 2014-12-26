
&dA                                                                        
&dA &d@                                                                      &dA 
&dA &d@                   Global #define Definitions                         &dA 
&dA &d@                                                                      &dA 
&dA                                                                        

#define    DMUSE          1     
                               /* when program is being tested in the Dmuse environment
#define    XPOS_FIXED     1 
                               /* with Beethoven, try 1 first, then 0; with Haydn, use 1
#define    SFZ            0 
                               /* SFZ            = 1:  print sfortzando as sfz 
#define    NO_EDIT        0 
                               /* NO_EDIT        = 1:  do not process editorial data
#define    ROMAN_EDIT     0 
                               /* ROMAN_EDIT     = 1:  use Times Roman font for 
                               /*                        editorial marks: tr, dynamics
#define    OLD_REPEATERS  1 
                               /* OLD_REPEATERS  = 1:  use half notes instead of quarters
#define    CUSTOM_PAR     1 
                               /* allows use of custom parameters, for whatever reason
                               /* see code at CUSTOM_PAR 
#define    DEFAULT_DTIVFONT    37 
#define    DEFAULT_MDIRFONT    31 
                               /* default font for musical directions 

#define    TRUE           0 
#define    FALSE          1 
#define    YES            0 
#define    NO             1 
#define    OFF            0 
#define    ON             1 

&dA &d@     Actual Characters 

#define    DOT_CHAR      44 

&dA &d@     Font parameters 

#define   BEAM_OFFSET     12 
#define   TIE_OFFSET      25 
#define   LARGE_BRACK     42 
#define   SMALL_BRACK     43 

&dA &d@     Descriptive Definitions (array elements) 
  
#define    TIE_SNUM       1
#define    TIE_NTYPE      2
#define    TIE_VLOC       3
#define    TIE_FHDIS      4
#define    TIE_FSTEM      5
#define    TIE_NDX        6 
#define    TIE_STAFF      7 
#define    TIE_FOUND      8 
#define    TIE_FORCE      9 
#define    TIE_SUGG      10 
#define    TIE_COLOR     11 
#define    TIE_ARR_SZ    11 

#define    FIG_SNUM       1
#define    FIG_HOFF1      2
#define    FIG_HOFF2      3
#define    FIG_READY      4
 
#define    REG            1
#define    GRACE          2
#define    CUE            3
#define    CUEGRACE       4
 
#define    BM_SNUM        1
#define    BM_CNT         2
#define    BM_READY       3
#define    BM_STEM        4
#define    BM_TUPLE       5
#define    BM_SIZE        6 
#define    BM_SUGG        7 
#define    BM_COLOR       8 
#define    BM_SZ          8 
  
#define    SL_SNUM        1
#define    SL_YSHIFT      2
#define    SL_XSHIFT      3 
#define    SL_NEXTSNUM    4
#define    SL_BEAMF       5 
#define    SL_SUGG        6 
#define    SL_SIZE        6 
 
#define    TU_SNUM        1
#define    TU_Y1          2
#define    TU_Y2          3
#define    TU_FSTEM       4
 
#define    TYPE           1
#define    DIV            2
#define    CLAVE          3
#define    AX             4
#define    TEMP4          4
#define    NTYPE          5
#define    DOT            6
#define    TUPLE          7
#define    STAFFLOC       8
#define    SPACING        9
#define    STEM_FLAGS    10
#define    BEAM_FLAG     11
#define    BEAM_CODE     12
#define    LOCAL_XOFF    13 
#define    SUPER_FLAG    14
#define    SLUR_FLAG     15
#define    SUBFLAG_1     16
#define    SUBFLAG_2     17
#define    VIRT_NOTE     18
#define    SORTPAR1      18
#define    SORTPAR2      19
#define    TEMP2         19
#define    GLOBAL_XOFF   19
#define    TEXT_INDEX    20
#define    PASSNUM       21
#define    BACKTIE       22
#define    NOTE_DUR      23
#define    DINC_FLAG     24
#define    VIRT_STEM     25 
#define    ED_SUBFLAG_1  26 
#define    ED_SUBFLAG_2  27 
#define    STAFF_NUM     28 
#define    NUM_STAVES    28 
#define    MULTI_TRACK   29 
#define    TEMP1         30 
#define    SPN_NUM       30 
#define    OBY           31 
#define    SLUR_X        32 
#define    NODE_SHIFT    33 
#define    TRACK_NUM     34 
#define    BASE_40       35 
#define    NOTE_DISP     36 
#define    AX_DISP       37 
#define    AUG_DOTS      38 
#define    TSR_POINT     39 
#define    TS_SIZE       39 
&dA 
&dA &d@     ts(.) Array positions for arpeggio variables  (note doublings with other flags)
&dA 
#define    ARPEG_FLAG    16 
#define    ARPEG_TOP     26 
#define    ARPEG_BOTTOM  27 
#define    ARPEGGIO      33 
 
#define    TSR_LENG     116 
                                         
#define    NUMBER_OF_FIG  3
#define    FIG_SPACE      4
#define    FIG_DATA       5
#define    MIN_FIG_SPAC  20 
#define    FIG_DUR       23
 
#define    SIGN_POS       3
#define    SIGN_TYPE      4
#define    SUPER_TYPE     5
#define    FONT_NUM       6
#define    WEDGE_OFFSET   7
#define    S_TRACK_NUM    8 
#define    WEDGE_SPREAD  10 
#define    POSI_SHIFT1   11 
#define    ISOLATED      12 
#define    POSI_SHIFT2   13 
 
#define    DOLLAR_SPN     5 
#define    DIVSPQ         3
 
#define    CLEF_NUM       3
#define    CLEF_FONT      4
#define    CLEF_STAFF_POS 6
 
#define    BAR_NUMBER     3
#define    BAR_TYPE       4
#define    REPEAT         5
#define    BACK_ENDING    6
#define    FORW_ENDING    7
#define    BAR_FLAGS      8
#define    M_NUMBER      10 
 
#define    REGULAR        1
#define    HEAVY          2
#define    DOTTED         3
#define    DOUBLE_REG     5
#define    REG_HEAVY      6
#define    HEAVY_REG      9
#define    DOUBLE_HEAVY  10
#define    DOUBLE_DOTTED 15
 
#define    WEDGES         1
#define    DASHES         2
#define    OCT_UP         3
#define    OCT_DOWN       4
#define    DBL_OCT_UP     5
#define    DBL_OCT_DOWN   6
#define    NORMAL_TRANS  13 
 
#define    NOTE           1
#define    XNOTE          2
#define    REST           3
#define    CUE_NOTE       4
#define    XCUE_NOTE      5
#define    CUE_REST       6
#define    GR_NOTE        7
#define    XGR_NOTE       8
#define    NOTE_OR_REST   8
#define    FIGURES        9
#define    BAR_LINE      10
#define    SIGN          11
#define    WORDS         12
#define    MARK          13
#define    CLEF_CHG      14
#define    DESIGNATION   15
#define    METER_CHG     16
#define    DIV_CHG       17
#define    AX_CHG        18
#define    P_SUGGESTION  19 
 
#define    MUSICAL_DIR   11
#define    IREST         12
#define    BACKSPACE     13
 
#define    SEGNO          1
#define    PED            2
#define    END_PED        3
#define    LETTER_DYNAM   4
#define    RIGHT_JUST_STR 5 
#define    CENTER_STR     6 
#define    LEFT_JUST_STR  7 
#define    TIE_TERM       8 
#define    REH_MARK       9 

#define    BELOW          1 
#define    ABOVE          2 
 
#define    HEAD           0
#define    TAIL           1
 
#define    FULLSIZE       0
#define    CUESIZE        1
 
#define    THIRTY_SECOND  4
#define    SIXTEENTH      5
#define    EIGHTH         6
#define    QUARTER        7
#define    HALF           8
#define    WHOLE          9
#define    BREVE         10 
#define    LONGA         11 
#define    SLASH8         0 

#define    UP             0
#define    DOWN           1
#define    SINGLE_NOTE    0
#define    CHORD          1
 
#define    NO_BEAM        0
#define    END_BEAM       1
#define    START_BEAM     2
#define    CONT_BEAM      3 
 
*     Parametric Definitions
 
#define    MAX_STAFF      2 
#define    MAX_TIES      16 
#define    MAX_FIG        4
#define    MAX_PASS      10 
#define    MAX_OBJECTS 1000 
#define    MAX_M        400 
 
*     Other Definitions 
 
#define    DUMMY_VALUE 10000 
#define    INT1000000  1000000 
#define    INT10000    10000 
#define    INT100        100 
#define    INT9000      9000 
#define    BHPAR1         30 
#define    MAX_MEAS     2000 

&dA                                        
&dA &d@                                      &dA 
&dA &d@    Definitions added with mskpage    &dA 
&dA &d@                                      &dA 
&dA                                        

#define   M_NUM_FONT      37 
#define   NAMELEN         17 

#define   SUPERSIZE      192    
#define   MAX_BNOTES      32 
#define   N_SUPER         16 
#define   LIM1         20000 

#define   PRE_DIST         1 
#define   MNODE_TYPE       2 
#define   TIME_NUM         3 
#define   SNODE            4 
#define   ACT_FLAG         5 
#define   M_ADJ            6 
#define   MARR_TEMP        7 
#define   MARR_PARS        7 
                                
#define   CONTINUO         0 
                                /* 1 = set figured harmonies above staff 
#define   MAGIC1         300 

#define SUPERMAX          50 
#define N_SIZES           12            /* changed &dA03/15/04&d@ from 4 to 12 
#define TIE_DISTS        200 
