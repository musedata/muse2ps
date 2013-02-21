/***                         DMUSE PROGRAM 
                           LINUX version 0.02 
            (c) Copyright 1992, 1999, 2007 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 03/18/2007) 
                            (rev. 06/04/2009) 
                            (rev. 12/27/2009) 
                            (rev. 02/08/2010) 

                          CONSTANT DEFINITIONS 
                      Zbex Compiler and Interpreter 
                                                                        ***/ 
/* Constants used by compiler */ 

#define  SZ             39L            /* not used */ 
#define  DBZ           118L            /* not used */ 
#define  DEBUG           1             /* used by many files */ 
#define  GFN_SIZE     4000L            /* used for glob names */ 

/* Constants used by interpreter */ 

#define  TFSIZE         30L         /* maximum length of tfile names (not used) */

/* &dAThese are defined in c:\release\internet\disp\zconst1.h&d@ 

        LINELEN     used only by &dAz25&d@ 
        MAXSIZE     used only by &dAz25&d@ 
        MAXBSIZE    used only by &dAz25&d@ 

***/


/* Constants used by compiler and interpreter */ 

#define  LZ            400L            /* used by &dAMAIN&d@, &dAz21, z24&d@, &dAZMAIN&d@ */ 
#define  LZS           400             /* used by &dAMAIN&d@, &dAz21, z24&d@, &dAZMAIN&d@ */ 
#define  NUL             0L
#define  BEEP            7L
#define  TTYZ         4800             /* used by many files */ 
#define  ZPIPEZ        100             /* zpipe size divided by 4 &dA11-01-96&d@ */ 

/* &dAThese are defined in c:\release\internet\disp\zconst2.h&d@ 

        LX          used by &dAZMAIN&d@ 
        LXS         used by &dAZMAIN&d@ 

***/


/*   fixup flags (compiler and interpreter)  */ 

#define  FLAG1     0x01000000 
#define  FLAG2     0x02000000 
#define  FLAG3     0x03000000
#define  FLAG4     0x04000000
#define  FLAG5     0x05000000

/*    table and memory sizes (compiler)  */ 

#define  LABTQ       10000L            /* used by &dAZMAIN&d@, &dA18&d@                         */
#define  MAINX      500000L            /* not used                                  */


/* &dAThese are defined in c:\release\internet\disp\zconst2.h&d@ 

        TRZ         used by &dAZMAIN&d@ 
        DSTZ        used by &dAZMAIN, 07, 11&d@ 
        MSIZEQ      used by &dAZMAIN, 02&d@ 
        TFPZZ       used by &dAZMAIN, 11&d@ 
        ICXZ        used by &dAZMAIN&d@ 
        SDZ         used by &dAZMAIN&d@ 
        RELICZ      used by &dAZMAIN&d@ 
        REDSTRQ     used by &dAZMAIN&d@ 

   &dAThese are defined in c:\release\internet\disp\zconst3.h&d@ 

        LMZ         used by &dAZMAIN, 07, 11,&d@ &dA12, 14&d@ 
        LMXZ        used by &dAZMAIN&d@, &dA14&d@ 
        LABAZ       used by &dAZMAIN&d@, &dA13&d@ 
        SYMTQ       used by &dAZMAIN&d@, &dA12, 14&d@ 
        LOCSYMQ     used by &dAZMAIN&d@, &dA12, 14&d@ 
        PROTQ       used by &dAZMAIN&d@, &dA13&d@ 
        PROAZ       used by &dAZMAIN&d@, &dA13&d@ 

   &dAThese are defined in c:\release\internet\disp\zconst4.h&d@ 

        ICZ         used by &dAZMAIN&d@, &dA03, 08, 16, 17, 20&d@, &dAMAIN&d@ 
        TEMPICZ     used by &dAZMAIN&d@, &dA03, 08, 16, 17, 20&d@, &dAMAIN&d@ 

***/


/*    table and memory sizes (interpreter)  */ 

#define  MIDIZ       30000           /*   used by &dAMAIN&d@, &dAz32&d@   */ 
#define  MUSDATAZ     2000           /*   used by &dAMAIN&d@, &dAz32&d@   */ 

/* &dAThese are defined in c:\release\internet\disp\zconst1.h&d@ 

        BUFZ        used by &dAMAIN&d@, &dAXMAIN, z25, z27&d@ 
        OUTLEN      BUFZ - 4          used by &dAz25&d@ 

   &dAThese are defined in c:\release\internet\disp\zconst5.h&d@ 

        PROLEVEL    used by &dAMAIN&d@, &dAz22&d@ 
        LENG1       copy vs. shift concatenation (used by &dAz22&d@) 

***/


/* table variable block parameters */ 

#define  MAXTBLOCK   40000L            /* used by &dAz14&d@ */ 
#define  MINTBLOCK    5000L            /* used by &dAz14&d@ */ 

/* special variables          */ 

#define  ERR            20L 
#define  MPT           222L 
#define  SUB           224L 
#define  REM           226L 
#define  TRP           228L 
#define  SZE           230L 

/* debug flags (interpreter)  */ 

#define  DEBUGG          1 
#define  MEMSTAT         0          /* 1 = print memory statistics */ 
#define  FASTBYTE        1 


/* other defined constants */ 

#include  "zconst1.h" 
#include  "zconst2.h" 
#include  "zconst3.h" 
#include  "zconst4.h" 
#include  "zconst5.h" 

/* program data structures */ 

typedef union int_or_point  {    /* compiler and interpreter */ 
    long *n; 
    long *(*p); 
    long *(*(*q)); 
}  element; 

typedef union i_or_p  {          /* compiler */ 
    long  *n; 
    long  **p; 
    char  ***cp; 
}  elem; 

typedef struct  {         /* interpreter */ 

    long       access_type;    /* 1, 2, 3, 4, 5, 6, 7, 8                  */
    long       file_type;      /* 1 = file, 2 = directory, 3 = glob       */
    long       num_records;    /* for types 2 and 3 (putf)                */
    long       file_size;      /* (in bytes)                              */
    long       byte_point;     /* pointer to next read/write byte         */
    char      *dir_pointer;    /* for directories; for type 8: --> data   */
    FILE      *fp; 
    int        fd; 
    char       file_name[400]; /* name of file                            */
}  file_data; 

typedef struct  {         /* interpreter */ 

    element   zelk;                  /* elk             */ 
    element   zepr;                  /* epr             */ 
    element   zIPC;                  /* IPC             */ 
    long      zsfcnt;                /* sfcnt           */ 
    long      zprolevel;             /* prolevel        */ 
    long      zb1;                   /* b1              */ 
    long      zoperationflag;        /* operationflag   */ 
    long      zexmode;               /* exmode          */ 
    long     *last_var;              /* for instr 12    */ 
    long      zlnum;                 /*                 */ 
    long      zprocnt;               /*                 */ 
    long      zpronum;               /*                 */ 
    long      zsfindexoff;           /*                 */ 
    long      zprotaboff;            /*                 */ 
    long      zsymtaboff;            /*                 */ 
    long      zexamineflag;          /*                 */ 
    long      zprintflag;            /*                 */ 
    long      zpf2;                  /*                 */ 
    long      zdebugg;               /*                 */ 
    char     *zmaxtemp;              /*                 */ 
    long     *zmemref;               /* dealloc list    */ 
    long     *zpend_write;           /* pending putc's  */ 
    char      zinterfile[100];       /* i-file name     */ 
    char      zsourcefilename[100];  /* from fullfilen  */ 
    char      zprinter_name[40];     /*                 */ 
}  zint_vars; 


/* include function list */ 

#include  "z_flist.h" 

/*  error numbers (compiler) */ 

#define  ZERR1       1  /* label format error                        */ 
#define  ZERR2       2  /* expecting a colon to follow a label       */ 
#define  ZERR3       3  /* double definition of label                */ 
#define  ZERR4       4  /* label out of bounds                       */ 
#define  ZERR5       5  /* missing arguments                         */ 
#define  ZERR6       6  /* unmatched parenthesis                     */ 
#define  ZERR7       7  /* trace was not set for this variable       */ 
#define  ZERR8       8  /* "else" used without "if"                  */ 
#define  ZERR9       9  /* "end" used without "if" or "testfor"      */ 
#define  ZERR10     10  /* comment desig must be preceded by blank   */ 
#define  ZERR11     11  /* trace was not set for this array element  */ 
#define  ZERR12     12  /* improper loop statement format            */ 
#define  ZERR13     13  /* improper repeat statement format          */ 
#define  ZERR14     14  /* expecting a var or a format specifier     */ 
#define  ZERR15     15  /* improper format specifier for input       */ 
#define  ZERR16     16  /* double definition of procedure            */ 
#define  ZERR17     17  /* improper procedure name format            */ 
#define  ZERR18     18  /* expecting "[" character                   */ 
#define  ZERR19     19  /* expecting procedure name                  */ 
#define  ZERR20     20  /* improper return statement format          */ 
#define  ZERR21     21  /* return statement in main program          */ 
#define  ZERR22     22  /* file label must have a value from 1 to 9  */ 
#define  ZERR23     23  /* expecting a blank terminator              */ 
#define  ZERR24     24  /* unexpected extra field or operator        */ 
#define  ZERR25     25  /* "else" used twice with a given "if"       */ 
#define  ZERR26     26  /* nesting error: "else" matches with "loop" */ 
#define  ZERR27     27  /* improper delimiter following relation     */ 
#define  ZERR28     28  /* boolean op must be set off by blank space */ 
#define  ZERR29     29  /* nesting error: "end" matches with "loop"  */ 
#define  ZERR30     30  /* expecting a simple int for loop counter   */ 
#define  ZERR31     31  /* nesting error: "repeat" matches with "if" */ 
#define  ZERR32     32  /* symbol is a predefined function           */ 
#define  ZERR33     33  /* expecting a rel statement at this point   */ 
#define  ZERR34     34  /* improper declaration statement format     */ 
#define  ZERR35     35  /* double definition of variable             */ 
#define  ZERR36     36  /* symbol is an instruction word             */ 
#define  ZERR39     39  /* no space allowed between var and dim      */ 
#define  ZERR40     40  /* unmatched double quote                    */ 
#define  ZERR41     41  /* parameter must be positive                */ 
#define  ZERR42     42  /* "repeat" used without "loop"              */ 
#define  ZERR43     43  /* integer constant is too large             */ 
#define  ZERR44     44  /* symbol format error                       */ 
#define  ZERR45     45  /* nest error(s) listed above                */ 
#define  ZERR46     46  /* undefined symbol                          */ 
#define  ZERR47     47  /* concat op must be set off by blank space  */ 
#define  ZERR48     48  /* unmatched open parenthesis                */ 
#define  ZERR49     49  /* extra closing parenthesis                 */ 
#define  ZERR50     50  /* number of dimensions is greater than 8    */ 
#define  ZERR51     51  /* string subscript format error             */ 
#define  ZERR52     52  /* improper string format                    */ 
#define  ZERR53     53  /* function format error                     */ 
#define  ZERR54     54  /* improper variable type in function        */ 
#define  ZERR55     55  /* wrong number of dimensions                */ 
#define  ZERR56     56  /* expecting a comma                         */ 
#define  ZERR57     57  /* label variables cannot be traced          */ 
#define  ZERR58     58  /* expecting a variable                      */ 
#define  ZERR59     59  /* integer exp not allowed in this context   */ 
#define  ZERR60     60  /* improper integer expression               */ 
#define  ZERR61     61  /* statement must begin with var or len function */ 
#define  ZERR62     62  /* this function not allowed in nested situation */ 
#define  ZERR63     63  /* expecting an equal sign                   */ 
#define  ZERR64     64  /* functions not allowed in this situation   */ 
#define  ZERR65     65  /* procedure name table is full              */ 
#define  ZERR66     66  /* expecting a digit or an open parenthesis  */ 
#define  ZERR67     67  /* access type must be number from 1 to 8    */ 
#define  ZERR68     68  /* expecting a comma or a closing square bracket */ 
#define  ZERR69     69  /* equal sign must be set off by blank space */ 
#define  ZERR70     70  /* bit-string must be specified with 0's and 1's */ 
#define  ZERR71     71  /* dimension of label is not equal to one    */ 
#define  ZERR72     72  /* number of procedures exceeds 100          */ 
#define  ZERR73     73  /* label subscript is out-of-bounds          */ 
#define  ZERR74     74  /* expecting dimension for label variable    */ 
#define  ZERR75     75  /* too many real number constants            */ 
#define  ZERR76     76  /* labels not allowed as i/o variables       */ 
#define  ZERR77     77  /* possible improper format specifier        */ 
#define  ZERR78     78  /* number of levels exceeds 99               */ 
#define  ZERR79     79  /* expecting literal integer argument        */ 
#define  ZERR80     80  /* incomplete loop statement                 */ 
#define  ZERR81     81  /* incomplete array data or missing parenthesis */ 
#define  ZERR82     82  /* incomplete function arg or missing parenthesis */ 
#define  ZERR83     83  /* incomplete string subscript or missing "}" */ 
#define  ZERR86     86  /* expecting a subscript value or a "}"      */ 
#define  ZERR87     87  /* expecting a subscript value               */ 
#define  ZERR88     88  /* expecting a string type                   */ 
#define  ZERR89     89  /* expecting a bit-string type               */ 
#define  ZERR90     90  /* expecting an integer type                 */ 
#define  ZERR91     91  /* expecting a real type variable            */ 
#define  ZERR92     92  /* expecting a closing square bracket        */ 
#define  ZERR93     93  /* expecting a string arg with no string subs */ 
#define  ZERR95     95  /* expecting a single letter to follow &     */ 
#define  ZERR96     96  /* no calling vars allowed in "break" procedure */ 
#define  ZERR97     97  /* expecting a glob argument with no subscripts */ 
#define  ZERR98     98  /* floating point number found               */ 
#define  ZERR99     99  /* no decimal in floating point number       */ 
#define  ZERR100   100  /* set element is a number, not a digit      */ 
#define  ZERR101   101  /* numerical value expected and not found    */ 
#define  ZERR102   102  /* size of symbol table has been exceeded    */ 
#define  ZERR103   103  /* improper format for process               */ 
#define  ZERR104   104  /* improper use of # character               */ 
#define  ZERR105   105  /* undefined label variable                  */ 
#define  ZERR106   106  /* wrong variable type used as a label       */ 
#define  ZERR107   107  /* no string length given                    */ 
#define  ZERR108   108  /* integer value expected but not found      */ 
#define  ZERR110   110  /* expecting setflag arg bbbb (upto 16) or #,b (0,1)*/ 
#define  ZERR111   111  /* size of label array exceeds 256 elements  */ 
#define  ZERR112   112  /* size of memory for constants exceeded     */ 
#define  ZERR113   113  /* main memory exceeds maximum limit         */ 
#define  ZERR114   114  /* improper string length                    */ 
#define  ZERR115   115  /* positive number of dimensions expected, not found */
#define  ZERR117   117  /* wrong number of arguments in function     */ 
#define  ZERR118   118  /* improper function type in this context    */ 
#define  ZERR121   121  /* improper use of delimiter                 */ 
#define  ZERR122   122  /* array variable without subscripts         */ 
#define  ZERR123   123  /* improper delimiter                        */ 
#define  ZERR124   124  /* improper use of ".."                      */ 
#define  ZERR125   125  /* missing blank space                       */ 
#define  ZERR127   127  /* operator must be set off by blank space   */ 
#define  ZERR128   128  /* this function not allowed on LHS of statement */ 
#define  ZERR129   129  /* var leng str func not allowed in relations */ 
#define  ZERR130   130  /* too many floating point subs on this line */ 
#define  ZERR131   131  /* too many integer type subs on this line   */ 
#define  ZERR132   132  /* too many literals, constants and charsets */ 
#define  ZERR133   133  /* argument to len function cannot be a literal string */
#define  ZERR134   134  /* unexpected or improper delimiter          */ 
#define  ZERR135   135  /* subscript constant out of bounds          */ 
#define  ZERR136   136  /* too many string substitutions on this line */ 
#define  ZERR137   137  /* improper delimiter or unmatched parenthesis */ 
#define  ZERR138   138  /* improper use of numerical operator        */ 
#define  ZERR139   139  /* improper use of concatenate operator      */ 
#define  ZERR140   140  /* improper expression format                */ 
#define  ZERR141   141  /* improper terminator for expression        */ 
#define  ZERR142   142  /* relational operator expected and not found */ 
#define  ZERR143   143  /* conflicting data types used in expression */ 
#define  ZERR144   144  /* improper delimiter for numerical format   */ 
#define  ZERR145   145  /* relation operator must be set off by blank space */ 
#define  ZERR146   146  /* this func not allowed as a primary ele in rel */ 
#define  ZERR147   147  /* improper use of bitwise operator          */ 
#define  ZERR148   148  /* array subscript format error              */ 
#define  ZERR149   149  /* relational operator inside numerical expression */ 
#define  ZERR150   150  /* line too long to process                  */ 
#define  ZERR152   152  /* set description: expecting single quote or number */
#define  ZERR153   153  /* set description: expecting matching single quote  */
#define  ZERR154   154  /* set description: expecting num between 0 and 255  */
#define  ZERR155   155  /* set description: improper range specification     */
#define  ZERR156   156  /* set description: expecting ".." delimiter         */
#define  ZERR157   157  /* set description: expecting delimiter or end of set */
#define  ZERR158   158  /* invalid relational operator with character set */ 
#define  ZERR159   159  /* this operator must have set on right hand side */ 
#define  ZERR160   160  /* this operator mot allowed with bit strings */ 
#define  ZERR161   161  /* invalid relational operator with numerical types */ 
#define  ZERR162   162  /* string subscript format error             */ 
#define  ZERR163   163  /* expecting a one-dim str array variable (no subs) */ 
#define  ZERR164   164  /* expecting a one-dim bstr or integer array */ 
#define  ZERR165   165  /* expecting a simple integer variable */
#define  ZERR166   166  /* midiget target string must have length >= 7 */ 
#define  ZERR171   171  /* string subs not allowed with numerical types */ 
#define  ZERR172   172  /* predictable outcome of relation           */ 
#define  ZERR173   173  /* problem with mismatching (), {}, or double quotes */
#define  ZERR174   174  /* improper floating point format            */ 
#define  ZERR175   175  /* improper variable type in this context    */ 
#define  ZERR176   176  /* function format error                     */ 
#define  ZERR177   177  /* improper delimiter for floating point number */ 
#define  ZERR179   179  /* argument to len function must be a variable  */ 
#define  ZERR181   181  /* variable must be a bstr to correspond with set */ 
#define  ZERR182   182  /* bit-string length cannot be set by len    */ 
#define  ZERR183   183  /* length of subscripted string cannot be set by len */
#define  ZERR184   184  /* txt() string func not allowed in concatenations */ 
#define  ZERR185   185  /* bnd() bstr func not allowed in concatenations */ 
#define  ZERR186   186  /* bor() bstr func not allowed in concatenations */ 
#define  ZERR187   187  /* character set not allowed in this context */ 
#define  ZERR188   188  /* expecting a character set or a set function */ 
#define  ZERR189   189  /* this operator not allowed in testfor instruction */ 
#define  ZERR190   190  /* boolean expr not allowed in testfor instr */ 
#define  ZERR191   191  /* expecting one of the 3 ops: '>', '=', or '<' */ 
#define  ZERR192   192  /* incorrect format for else statement       */ 
#define  ZERR193   193  /* "else" used with "testfor" requires a qualifier */ 
#define  ZERR194   194  /* possible nesting error: "else (op)" used with "if" */
#define  ZERR195   195  /* "else" used without "testfor"             */ 
#define  ZERR196   196  /* duplicate case for this level of "testfor" */ 
#define  ZERR197   197  /* no operators allowed in this function field */ 
#define  ZERR198   198  /* expecting an integer type variable        */ 
#define  ZERR199   199  /* table size is not correctly specified     */ 
#define  ZERR200   200  /* undefined table name                      */ 
#define  ZERR201   201  /* this function is not allowed in key or index  */ 
#define  ZERR202   202  /* expecting a string argument representing a key */ 
#define  ZERR203   203  /* expecting a string argument               */ 
#define  ZERR204   204  /* expecting the name of a table             */ 
#define  ZERR205   205  /* expecting a two-dimensional string array  */ 
#define  ZERR206   206  /* size of second string dimension must be two */ 
#define  ZERR207   207  /* string array here must be given ohne subscripts */ 
#define  ZERR208   208  /* expecting the srt (sort) function         */ 
#define  ZERR209   209  /* expecting a string array                  */ 
#define  ZERR210   210  /* size of local symbol table has exceeded maximum */ 
#define  ZERR211   211  /* improper format for autodef               */ 
#define  ZERR213   213  /* string expressions not supported in put statements */
#define  ZERR214   214  /* procedure variables must be enclosed in parens */ 
#define  ZERR215   215  /* procedure variables are expected and not found */ 
#define  ZERR216   216  /* procedure variables are found but not expected */ 
#define  ZERR217   217  /* expecting a comma or a closing parenthesis */ 
#define  ZERR218   218  /* inconsistant numb of vars for this procedure */ 
#define  ZERR219   219  /* inconsistant variable types or dims in proc. call */
#define  ZERR220   220  /* "getvalue" and "passback" not allowed in main prog */
#define  ZERR221   221  /* expecting a comma or a comment delimiter  */ 
#define  ZERR222   222  /* no calling variables in this procedure    */ 
#define  ZERR223   223  /* variable is not in calling list for this proc */ 
#define  ZERR224   224  /* procedures can pass only regular variables */ 
#define  ZERR225   225  /* variable is not locally defined           */ 
#define  ZERR226   226  /* improper format for define statement      */ 
#define  ZERR227   227  /* macro substitution table exceeds maximum size */ 
#define  ZERR228   228  /* adjusted length of imput line is too long */ 
#define  ZERR229   229  /* tables not allowed as i/o variables       */ 
#define  ZERR230   230  /* not enough free memory availabel to run zbex */ 
#define  ZERR234   234  /* more than 8 hexidecimal digits            */ 
#define  ZERR235   235  /* functions in /o must be enclosed in parentheses */ 
#define  ZERR236   236  /* this variable is not an array             */ 
#define  ZERR237   237  /* concatenate operator not allowed inside func */ 
#define  ZERR238   238  /* unexpected or improper delim, or unmatched paren*/ 
#define  ZERR239   239  /* label variables not allowed in relations  */ 
#define  ZERR240   240  /* tables not allowed in relations           */ 
#define  ZERR241   241  /* conflicting data types used in relation   */ 
#define  ZERR242   242  /* unable to find matching "}" in string sub exp */ 
#define  ZERR243   243  /* improper format for ++                    */ 
#define  ZERR244   244  /* improper format for --                    */ 
#define  ZERR245   245  /* ++ and -- may be used with numerical types only */ 
#define  ZERR246   246  /* expecting a label                         */ 
#define  ZERR247   246  /* expecting dimension for variable          */ 
#define  ZERR248   248  /* expecting the RHS of an assignment statement */ 
#define  ZERR249   249  /* 56 character maximum length for proc var names */ 
#define  ZERR250   250  /* 60 character maximum length for variable names */ 
#define  ZERR251   251  /* labels and tables cannot be passed to procedures */ 
#define  ZERR252   252  /* use #endif to close out conditional #if */ 
#define  ZERR253   253  /* #else or #endif used without #if        */ 
#define  ZERR254   254  /* more than one #else associated with a given #if */ 
#define  ZERR255   255  /* more than 32 nested #if conditions */ 
#define  ZERR256   256  /* missing one or more #endif markers */ 
#define  ZERR257   257  /* globs cannot be arrays             */ 
#define  ZERR258   258  /* globs cannot be used in calling procedures  */ 
#define  ZERR259   259  /* glob variable must be followed by ':' and a path name */
#define  ZERR260   260  /* only one glob variable allowed per declaration */
#define  ZERR261   261  /* unable to expand file name to full path   */ 
#define  ZERR262   262  /* unable to open this file           */ 
#define  ZERR263   263  /* this is not a regular file         */ 
#define  ZERR264   264  /* read access denied for this file   */ 
#define  ZERR265   265  /* too many glob file names           */ 


/*  errors and messages (interpreter)   */ 

#define  WERR1      1  /* attempt to divide by integer zero at line = %ld */ 
#define  WERR2      2  /* attempt to divide by real zero at line = %ld    */ 
#define  WERR3      3  /* array sub is out of bounds at line = ...        */ 
#define  WERR4      6  /* string sub is out of bounds at line = ...       */ 
#define  WERR5      9  /* Warning: str sub is out of bounds at line ...   */ 
#define  WERR6     12  /* maximum leng of string has been exceeded ...    */ 
#define  WERR7     15  /* Warning: max leng of str has been exceeded ...  */ 
#define  WERR8     18  /* negative string length for var at line ...      */ 
#define  WERR9     20  /* Warning: neg str length for var at line ...     */ 
#define  WERR10    22  /* attempted seq table access (tget) beyond limit  */ 
#define  WERR11    24  /* index to table is out-of-bounds at line ...     */ 
#define  WERR12    26  /* table no longer efficient for hashing.  line =  */ 
#define  WERR13    28  /* argument to sin(x) at line ... is too large     */ 
#define  WERR14    30  /* argument to cos(x) at line ... is too large     */ 
#define  WERR15    32  /* argument to tan(x) at line ... is too large     */ 
#define  WERR16    34  /* argument to ars(x) at line ... is too large     */ 
#define  WERR17    36  /* argument to arc(x) at line ... is too large     */ 
#define  WERR18    38  /* argument to exx(x) at line ... causes overflow  */ 
#define  WERR19    40  /* argument to lnx(x) at line ... is too large     */ 
#define  WERR20    42  /* argument to sqt(x) at line ... is too large     */ 
#define  WERR21    44  /* length of insertion is not equal to space       */ 
#define  WERR22    46  /* illegal file descriptor value at line =         */ 
#define  WERR23    48  /* unsupported file access requested at line =     */ 
#define  WERR24    50  /* file descriptor is already in use.              */ 
#define  WERR25    56  /* file open for use other than simple getf        */ 
#define  WERR26    61  /* file open for use other than simple putf        */ 
#define  WERR27    66  /* file not open for random read                   */ 
#define  WERR28    71  /* file not open for random write                  */ 
#define  WERR29    76  /* file not open for write instruction             */ 
#define  WERR30    81  /* general read failure                            */ 
#define  WERR31    86  /* general write failure                           */ 
#define  WERR32    91  /* attempt to read/write with a negative offset    */ 
#define  WERR33    97  /* attempt to read/write beyond end of file        */ 
#define  WERR34   103  /* I/O Warning: file rec is > getf input buffer    */ 
#define  WERR35   108  /* I/O Warning: attempt to close an unopened file  */ 
#define  WERR36   113  /* I/O Warning: attempt to put more than 100000 recs*/
#define  WERR37   118  /* I/O Warning: attempt to write more than 5 MB    */ 
#define  WERR38   123  /* Warning: output buffer size exceeded            */ 
#define  WERR39   125  /* maximum size of procedure level table exceeded  */ 
#define  WERR40   127  /* table has expanded beyond available memory      */ 
#define  WMSG41   128  /* Size of links memory = %ld bytes                */ 
#define  WMSG42   129  /* Not enough free memory availabe to run program  */ 
#define  WMSG43   130  /* Size of i-code memory = %ld bytes               */ 
#define  WMSG44   131  /* Size of main memory = %ld bytes                 */ 
#define  WMSG45   132  /* Memory for first table block = %ld bytes        */ 
#define  WMSG46   133  /* Not enough free memory available for tables     */ 
#define  WMSG47   134  /* Size of symbol table (on disc) = %ld bytes      */ 
#define  WMSG48   135  /* Size of procedure name table (on disc) = ...    */ 
#define  WMSG49   136  /* Size of source file index (on disc) = %ld bytes */ 
#define  WMSG50   137  /* Size of max string storage memory = %ld bytes   */ 
#define  WMSG51   138  /* Printer busy or otherwise unavailable           */ 
#define  WMSG52   139  /* Printer in use by another ibex program          */ 
#define  WMSG53   140  /* Invalid intermediate file format                */ 
#define  WMSG54   141  /* Limited memory; try decreasing length of str    */ 
#define  WMSG55   142  /* Unable to open source file: %s                  */ 
#define  WMSG56   143  /* Program aborted at line = %ld                   */ 
#define  WMSG57   144  /* Graphics in use by another zbex program         */ 
#define  WERR58   145  /* Computed length of string exceeds max length    */ 
#define  WERR59   148  /* Dynamic array error                             */ 
#define  WERR60   150  /* Bitplane nubber error in setb/clearb instr      */ 
#define  WERR61   152  /* Max length of temp string has been exceeded     */ 
#define  WMSG62   156  /* Midi in use by another zbex program             */ 
#define  WMSG63   157  /* Unable to contact Music Quest Interface Card    */ 
#define  WMSG64   159  /* Midi not installled on this system              */ 
#define  WMSG65   160  /* Not enough memory for specified midi-send pipe  */ 
#define  WMSG66   162  /* Midi instruction used when midi not open        */ 
#define  WMSG67   164  /* Warning: No action taken on midiclr             */ 
#define  WMSG68   166  /* MCC Command not supported                       */ 
#define  WMSG69   168  /* 1st midipar parameter is out of range           */ 
#define  WMSG70   170  /* 2nd midipar parameter is not positive           */ 
#define  WMSG71   172  /* Initial value of loop counter set outside limits*/ 
#define  WERR72   174  /* sort size exceeds array size                    */
#define  WMSG73   175  /* not enough free memory for sort                 */

/*  instruction numbers */ 

#define  PUTC          25 
#define  PUTP          26 
#define  DPUTC         27 
#define  DPUTP         28 
#define  PUTF          30 

/*  function numbers */ 

#define  RNDI           1 
#define  NOT            2 
#define  ABSI           3 
#define  AND            4 
#define  IOR            5 
#define  XOR            6 
#define  BIT            7 
#define  SHR            8 
#define  SHL            9 
#define  TST           12 
#define  TDX           13 
#define  FIX           14 
#define  LENS          15 
#define  INT           16 
#define  ORS           17 
#define  LENB          19 
#define  BLN           20 
#define  INTEGER_FUNC  20 

#define  FLTI          21 
#define  RNDR          22 
#define  ABSR          23 
#define  DEC           24 
#define  SIN           25 
#define  COS           26 
#define  TAN           27 
#define  ARS           28 
#define  ARC           29 
#define  ART           30 
#define  EXX           31 
#define  LNX           32 
#define  SQR           33 
#define  POW           36 
#define  FLTS          39 
#define  REAL_FUNC     39 

#define  PAD           41 
#define  ZPDS          42 
#define  CHR           43 
#define  CH2           44 
#define  CH4           45 
#define  OCT           46 
#define  CHS1          47 
#define  HEX           48 
#define  CH8           49 
#define  CHS2          50 
#define  CHX           51 

#define  TRMS          55 
#define  MRTS          56 
#define  LCS           57 
#define  UCS           58 
#define  REVS          59 
#define  RPL           60 
#define  DUPS          61 
#define  TXT1          62 
#define  TXT2          63 
#define  TXT3          64 
#define  TXT4          65 
#define  CBY           66 
#define  UPK1          67 
#define  UPK2          68 
#define  STR_FUNC      68 

#define  NPD           70 
#define  ZPDB          71 
#define  CBI           72 
#define  PAK1          73 
#define  PAK2          74 
#define  TRMB          77 
#define  MRTB          78 
#define  REVB          79 
#define  CMP           80 
#define  DUPB          83 
#define  BND           84 
#define  BOR           85 
#define  SRT           87 
#define  LASTFUN       87 
