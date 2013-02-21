/***                         DMUSE PROGRAM 
                           LINUX version 1.00 
            (c) Copyright 1992, 1999, 2007 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 01/06/2008) 
                            (rev. 02/07/2009) 
                            (rev. 06/04/2009) 
                            (rev. 02/12/2010) 
                            (rev. 04/02/2010) 

                              Main Module 
                                                                        ***/ 

#define  VERSION      1 
#define  SUB_VERSION  0 

/*** 

This program is a merger of the ten-windows environment with the zbex 
compiler and interpreter.  It is designed to run native on i386 type 
machines.  This version has been redesigned to run under the X Window 
system in the linux operating system.

The three main programs being merged here each have their own set of 
global variables.  Also, they have their own set of auxiliary files 
(funxx.c files).  These will have to be renamed according to the  
application.  
                                                                  ***/ 
                                                                       
/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³            Include statements                ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/ 

#include  "all.h" 

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³            Define statements                 ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/ 


/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³            Global variables                  ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/ 

/***  I.   General Program variables   ***/ 

    /*  general communication control variables   */ 

jmp_buf sjbuf; 
jmp_buf close_out; 
long  killflag;
long  errorflag;

char  ttyline[TTYZ];    /* memory specifically for terminal I/O: 4800 bytes */ 


/***  II.  Ten Windows environment     ***/ 

    /* global data areas which are allocated or assigned at setup time */ 

char       *mal_pnt;         /* pointer to byte "ls" listing space 540000 b */


    /* global variables for the general environment   */ 

unsigned char  a_window = 0;       /* active window   0 ... 29            */

/***  III.  Zbex Compiler and Interpreter        ***/ 

    /*      global variables used by compiler and interpreter    
    ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/ 

element elk, epr;         /*  union pointers to link memory and i-code */ 

long  PC;                 /* program counter (program size)            */ 
char  zfullfilename[LZ];  /* full file name of input file              */ 
long  sfcnt;              /* counter in source index table             */ 
long  lnum;               /* line number                               */ 
long  procnt;             /* number of procedures in table             */ 
long  sscnt;              /* source statement counter                  */ 
long  examineflag;        /* 0 = activated; 1 = de-activated           */ 
long  graphicsflag;       /* 0 = no graphics; 2 = graphics present     */ 
long  midiflag;           /* 0 = no midi; 4 = midi present             */ 
long  maxstringlen;       /* length of longest allocated string        */ 
long  global_maxstrlen;   /* longest maxstringlen allowed              */ 
long  maincnt;            /* offset counter into main memory           */ 
long  printflag;          /* printer usage flag (set if putp is used)  */ 
long  orbitflag[32]; 
long  andbitflag[32]; 
long  testbitflag[32]; 


char fnames[] = "088rndnotabsandiorxorbitshrshlnot\
nottsttdxfixlenintorsnotlenbln\
fltrndabsdecsincostanarsarcart\
exxlnxsqtnotnotpownotnotfltnot\
padzpdchrch2ch4octchshexch8chs\
chxnotnotnottrmmrtlcsucsrevrpl\
duptxttxttxttxtcbyupkupknotnpd\
zpdcbipakpaknotnottrmmrtrevcmp\
notnotdupbndborsetsrtsrt   "; 
                                 /* input types for functions */ 
char fin_type[] = "03333333330\
0994111022\
3444444444\
4440040010\
3333333347\
7000111111\
1888826203\
3111002222\
002222320";
                                 /* output types for functions */ 
char fout_type[] = "03333333330\
0333333033\
4444444444\
4440040040\
1111111111\
1000111111\
1111111102\
2222002222\
002228330";
                                 /* number of arguments for functions */ 
char farg_num[] = "01112222220\
0121111011\
1111111111\
1110020010\
1111111112\
2000111112\
2323212101\
1121001111\
002221220";

    /*      global variables for Zbex compiler       
    ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/ 

int   zfd;

long main_max;            /* maximum size of main memory               */ 

long *links;              /* top of LINKS memory                       */ 
long *linksfix;           /* top of LINKS fixup table                  */ 

char *labtab;             /* top of label name table                   */ 
long *labadd;             /* top of label data (address) table         */ 
long  labcnt;             /* number of labels in table                 */ 

char *symtab;             /* top of compiler symbol table              */ 
char *locsymtab;          /* top of compiler local symbol table        */ 
long *tradd;              /* top of trace table                        */ 

char  gfile_names[GFN_SIZE]; 
long  gfile_point; 
long  gfile_cnt; 

char *protab;             /* top of procedure name table               */ 
long *proadd;             /* top of procedure address table            */ 
long  prodefcnt;          /* number of defined procedures              */ 
char *protab_pointer;     /* pointer to current procedure data structure */

long *dsttab;             /* top of duplicate storage table            */ 
char *subtab;             /* top of macro substitution table           */ 
double *rtab;             /* top of temporary floating point table     */ 
long  rtabcnt;            /* counter in temporary floating point table */ 

long *porg;               /* intermediate code origin                  */ 
long  tpc;                /* working pointer in intermediate code      */ 
long *icfix;              /* top of IC fixup table                     */ 

long *sfindex;            /* top of source index table                 */ 
long dsfindex[60];        /* run time sfindex sliding array            */ 

long *rel_icode;          /* top of relation i-code array              */ 
long *rel_fixup;          /* top of fixup array for *rel_icode         */ 
long  t_icode[TEMPICZ];   /* temporary intermediate code storage       */ 
long  t_minifixup[TEMPICZ]; 
                          /* fixup array for temp_icode                */ 
long  t_icode1[TEMPICZ]; 
long  t_minifixup1[TEMPICZ]; 

long *temp_icode;         /* pointer to t_icode                        */ 
long *temp_minifixup;     /* pointer to t_minifixup                    */ 
long *temp_icode1;        /* pointer to t_icode1                       */ 
long *temp_minifixup1;    /* pointer to t_minifixup1                   */ 

char *source_line;        /* pointer to source statement               */ 
char *reduced_string;     /* pointer for reduced codes                 */ 
char  zlevel_string[99];  /* level flags (used by labels and by control) */ 

long  zlevel_array[99][3];/* storage of control fixup addresses         */ 

long  autodef = 0;        /* autodef flag                          */ 
long  zlevel = 1;         /* nexting and label level               */ 
long  mptlnkadd;          /* offset in link memory of mpt variable */ 
long  sublnkadd;          /* offset in link memory of sub variable */ 
long  remlnkadd;          /* offset in link memory of rem variable */ 
long  errlnkadd;          /* offset in link memory of err variable */ 
long  cflag;              /* checklab process flag                 */ 
long  pflag;              /* procedure section flag                */ 
long  inlinelen = LZ-1;   /* maximum length of source line         */ 

time_t currenttime; 
int   errfh;
long  debugg; 
long  zinflag;            /* compiler input source flag            */ 
char  debugp; 

char  zcomp_longjmp = 0;  /* New &dA01/29/07&d@: longjmp alert for zcomp */ 

    /*   global variables for Zbex interpreter.  
    ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/ 

char  inter_longjmp = 0;  /* New &dA01/29/07&d@: longjmp alert for interpret */ 
long  Addline_cnt   = 0;  /* New &dA02/01/07&d@ */ 
char  fixed_string[300];

    /*   arrays of thirty variables or groups of variables     */ 

file_data   fdata[9];              /* data for file i/o (init access_type)*/
long *prolevel_stack[PROLEVEL][2];         /* procedure return address stack */
long  prolevel_numbers[PROLEVEL];          /* procedure numbers              */
zint_vars   ztv;                           /* interpreter variables          */


    /*   variables which are copied each time from ztv  */ 

element elk, epr;              /* pointers to link memory and i-code  */ 
element IPC;                   /* interpreter IPC                     */ 
long    prolevel = 0;          /* procedure level pointer             */ 
long    b1 = 0;                /* conditional branch flag             */ 
long    operationflag = 0;     /* nexting and label level             */ 
/* long    sfcnt;                 counter in source index table       */ 


    /* variables copied to ztv and used from there      */ 

long    lnum;                  /* number of lines                     */ 
long    procnt;                /* number of procedures in table       */ 
long    sfindexoff;            /* offset to sfindex table in IM file  */ 
long    protaboff;             /* offset to proc name table in IM file*/ 
long    symtaboff;             /* offset to symbol table in IM file   */ 
long   *mainmem;               /* pointer to main memory (run time)   */ 
char   *maxtemp;               /* pointer to maxtemp storage          */ 
long    pf2;                   /* printer file id (needs revising)    */ 
long    debugg;                /*                                     */ 


    /* global variables or variables used locally           */ 

long    files_avail;           /* number of files available for z to open */ 

char   *wtfile;                /* temporary pointer to file name      */ 
long    memstat = MEMSTAT;     /* flag for printing mem stats         */ 
char    bigbuf[BUFZ];          /* buffer for large temporary storage  */ 

int     sourcefd;              /* file descriptor for source file     */ 
int     ifd;                   /* file descriptor for intermediate file */ 
/*  int     msgfd;                file descriptor for message file      */ 

long    mvsfindex[50];         /* movable section of source file index */ 

long    zpipemem[(ZPIPEZ+1)*20]; 
long   *zpipe_point;           /* pointer to zpipemem  &dA11-01-96&d@        */ 
                               /* pipe memory          &dA11-01-96&d@        */ 


/***   Variables added for Linux X-windows operation        ***/ 

char    sys_error_message[80]; 
long    follow_links;      /* follow links flag set in INIT: values = 0(=N), 1(=Y) */
unsigned long   my_all_ones, my_all_zeros; 


/***   Variables related to the onboard au-ms-ps program    ***/ 

unsigned long  bigbitout[1000000];    /* must be global */ 
unsigned char  ww_prog[10000000];     /* must be global */ 
unsigned char  botstring[4000000];    /* must be global */ 
unsigned char  botout[4000000];       /* must be global */ 
unsigned long  *bigbitout_pnt;        /* must be global */ 
unsigned char  *ww_prog_pnt;          /* must be global */ 
unsigned char  *botstring_pnt;        /* must be global */ 
unsigned char  *botout_pnt;           /* must be global */ 

/***   END of global varible declaration   ***/ 

int main(int argc, char *argv[]) 
{
    long            g,i,k; 
    unsigned long   u; 
    long           *ip1; 
    char           *sp1; 

    bigbitout_pnt = bigbitout;  
    ww_prog_pnt   = ww_prog; 
    botstring_pnt = botstring; 
    botout_pnt    = botout; 

/* read command line */ 

    fixed_string[0] = '\0'; 
    if (argc > 1)  { 
        strcpy(fixed_string, argv[1]); 
    } 


/* establish mechanism for aborting program */ 

    if ((k = setjmp(close_out)) > 0)   goto CLOSE_OUT; 

/* &dANew initialize program&d@ */

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³  allocate global data areas for File Operations       ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/ 
                                                 
    if ( (ip1 = (long *) malloc( (size_t) 540000) ) == NULL)  { 
        return (-1); 
    } 
    sp1 = (char *) ip1; 
    mal_pnt = sp1;                      /* pointer to "ls" listing space     */
    files_avail = 1000; 
    global_maxstrlen = 10000000; 

    zpipe_point = zpipemem; 
    ip1 = zpipemem; 
    for (i = 0; i < 20; ++i)  { 
        *ip1 = 0;             /* pipe length = 0 */ 
        ip1 += (ZPIPEZ+1); 
    } 

    a_window = 0;             /* starting window number */ 
    main_max = 0x5000000; 

/* setup for zbex */ 

  /* set up bitflags */ 

    u = 0x80000000; 
    g  = 1; 
    for (i = 0; i < 32; ++i)  { 
        orbitflag[i]   = u; 
        andbitflag[i]  = ~u; 
        testbitflag[i] = g; 
        u >>= 1; 
        g <<= 1; 
    } 

    k = get_ww(); 
    if (k == -1)   goto CLOSE_OUT; 

    k = zload(2, (char *) ww_prog); 

    interpret();    

/*  send_twline("Ready for program\n", -1); */ 
    goto CLOSE_OUT; 

CLOSE_OUT:

    exit (0);
}
