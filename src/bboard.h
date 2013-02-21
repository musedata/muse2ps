/***                         DMUSE PROGRAM 
                           LINUX version 0.02 
            (c) Copyright 1992, 1999, 2007 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 03/18/2007) 
                            (rev. 12/27/2009) 

                     Structions and Other Definitions 
                      for the Ten Windows section of 
                              DMUSE PROGRAM 
                                                                     ***/ 

typedef short MY_BOOL; 
#define FALSE           0 
#define TRUE            1

#define TEXT            0 
#define GRAPHICS        1

#define KEYPIPEZ        0x100

#define   U_USE         (S_IRUSR | S_IWUSR | S_IXUSR) 
#define   G_USE         (S_IRGRP | S_IWGRP | S_IXGRP) 
#define   O_USE         (S_IROTH | S_IWOTH | S_IXOTH) 

#define   R_USE         (S_IRUSR | S_IRGRP | S_IROTH) 
#define   W_USE         (S_IWUSR | S_IWGRP | S_IWOTH) 
#define   X_USE         (S_IXUSR | S_IXGRP | S_IXOTH) 

/* display colors   &dAOLD&d@ 
&dK 
&dK &d@ #define WIND_TLE         0x30   / * title line of window: black on terq * /
&dK &d@ #define SEL_HL           0x71   / * select highlight: blue on gray      * /
&dK &d@ #define SEL_SHAD         0x41   / * select shadow: blue on red          * /
&dK &d@ #define DIAL_BDR         0x40   / * dialog border: black on red         * /
&dK &d@ #define BOX_HL           0x40   / * box colors: black on red            * /
&dK &d@ #define WIND_TXT         0x07   / * normal window text: gray on black   * /
&dK &d@ #define DIAL_TXT         0x17   / * text inside dialog; gray on blue    * /
&dK &d@ #define INVERSE          0x70   / * inverse display                     * /
&dK &d@ #define DIRECT           0x07   / * direct  display                     * /
&dK &d@ #define SEL_HL2          0x51   / * select highlight2: blue on marune   * /
&dK 
*/ 

#define N_FONTS             6 

/* number of windows    */ 

#define NUMWIN             31 
#define MAXWIN             31 
#define HELPWIN            30 

/* maximum number of pages per window */ 

#define MPPW             5000    /* max number of pages per window   */ 
                                 /* (increased from 3000 &dA03/28/99&d@    */ 
#define PMPPW            4950    /* practical value of MPPW          */ 
                                 /* (increased from 2950 &dA03/28/99&d@    */ 
#define WSWPBUF    (5 * MPPW) 


/* offsets on swap disk */ 

#define FDISK  (NUMWIN * 1000)   /* beginning of free disk area      */ 
#define FDZ             10000    /* max number of free disk blocks   */ 
#define PDAMEM (FDISK + (FDZ * 4)) 
                                 /* beginning of wpa memory on disk  */ 
#define BBMEM   (PDAMEM + (NUMWIN * WSWPBUF)) 
                                 /* beginning of bb memory on disk   */ 

/* page parameters */ 

#define NPG                48    /* number of pages in memory        */
#define NEARLY_FULL        20    /* initial pages are 20/23 full     */
#define BLKS_PAGE          23    /* number of blocks in a page       */
#define N4096            4096    /* number of bytes on a page        */
#define BLK_SIZE          176    /* number of bytes in a block       */
#define FREEZE         MAXWIN    /* increment to freeze the active page */ 

/* space parameters */ 

#define MAX_CURS          959    /* maximum cursor position          */
#define H_JUMP              1    /* size of horizontal scroll jump   */
#define D_RMARG            75    /* default rmarg                    */
#define D_LMARG             0    /* defautl lmarg                    */
#define COLS               68    /* number of columns in dialog box  */
#define CELL_SIZE           2    /* size of the display CELL         */ 
#define MAX_DIAL_PP        42    /* maximum number of dialog pages   */ 

/* other parameters */ 

#define CR                 13    /* carriage return                  */
#define WPARZ            1000    /* size of ww data structure        */
#define TAB_SIZE            9    /* size of (un-used) block tab space*/
#define TMEMSIZE         2000    /* size of work array, tmem         */
#define TOTAL_MODES        13    /* maximum number of display modes  */ 

#define MAXDIRZ           260    /* maximum length of directory name */ 
#define TITLESP           180    /* space for window title           */ 
#define MAXFNAMEZ         300    /* maximum path length              */ 
#define W_EXTRAZ          856-MAXDIRZ-MAXFNAMEZ-TITLESP 
#define SH_SCREEN_BUF   98000    /* size of shadow screen buffer   &dA12/09/06&d@  */
#define SH_COLUMNS        240    /* number of columns in sh_dspbuf &dA12/05/08&d@  */
#define SH_ROWS           200    /* number of rows in sh_dspbuf    &dA12/05/08&d@  */
#define MAXFINAM           60    /* maximum file name length       &dA03/29/07&d@  */
#define MINWINCOLS         40    /* min numb of cols for full window &dA03/30/07&d@ */
#define MINWINROWS         15    /* min numb of rows for full window &dA03/30/07&d@ */

/* #pragma noalign (s_cell)  */ 

typedef struct s_cell  {
    unsigned char chr;         /* character */
    unsigned char att;         /* attribute */
} CELL;                                  

/* #pragma noalign (dsp_com)  */  

typedef struct dsp_com  { 
    short       scroll_dx;      /* horiz, neg = left               */ 
    short       scroll_dy;      /* vert,  neg = up                 */ 
    short       xpos;           /* pos = upper left for scroll     */ 
    short       ypos;           /*                                 */ 
    short       xpos2;          /* pos2 = lower right for scroll   */ 
    short       ypos2;          /*                                 */ 
} DSP_COM;    /* size = 12 bytes */ 

/* #pragma noalign (j_char) */

typedef struct j_char  { 
    unsigned char flg;         /* print character flag */ 
    unsigned char att;         /* attribute */
    long          jx;          /* horiz column  */ 
    long          jy;          /* vert  row     */ 
} J_CHAR; 

/* #pragma noalign (bb_block) */

typedef struct bb_block {
    unsigned char   lmarg;      /* left margin; 0 to 250              */ 
    unsigned char   rmarg;      /* right margin 0 to 250              */ 
    unsigned char   line_len;   /* length of word_wrap line: 0 to 254 */
    unsigned char   g_flag;     /* bits 7-4 = b_bnum; 3-0 = g_size    */ 
    short           max_len;    /* real length of line: 0 to 960      */ 
    unsigned char   format;     /* indent, etc.                       */ 
    unsigned char   tabs[9];    /* unused space                       */ 
    CELL            data[80];   /* block data */
} BB_BL;      /* size = 16 + 2 * 80  = 176 bytes */

typedef struct bb_page {
    long            lasttime;        /* last time this page was accessed   */
    short           swap_num;        /* disk swap number for this page     */
    MY_BOOL         modified;        /* page modified?                     */
    char            prev_page;       /* page number of previous page       */
    char            next_page;       /* page number of next page           */
    char            act_flag;        /* active page flag: 0 to 9; -1 = non */
    char            last_block;      /* block number of last group on page */
    char            extra_space[36]; /* brings struct size up to 4096      */
    BB_BL           block[BLKS_PAGE];     /* blocks */
} BB_PG;      /* size = 48 + 23 * 176 = 4096 bytes */

/* #pragma noalign (ww) */

typedef struct ww  {
    unsigned short  pda_freepnt;   /* pointer to next free pda location */ 
    unsigned short  pda_crntpnt;   /* pointer to current pda location   */ 
    long            line_num;      /* current line number for this wind */ 
    long            last_line;     /* last line number for this window  */ 
    short           cursor_pos;    /* cursor position on current line   */
    short           cursor_h;      /* horz position of cursor in window */
    unsigned char   cursor_v;      /* vert position of cursor in window */
    unsigned char   mode_flag;     /* mode flags for this window        */
    char            act_block;     /* active block (line) for this wind */
    unsigned char   w_font;        /* font number for this window       */ 
    unsigned char   w_crnt_attr;   /* current text attribute            */ 
    char            w_cdir[MAXDIRZ+1]; 
                                   /* current directory for this window */ 
    char            w_ofile[MAXFNAMEZ+1]; 
                                   /* original file for this window     */ 
    char            w_ctitle[TITLESP+1]; 
                                   /* current title for this window     */ 
    unsigned char   w_tabs[120];   /* current tabs for this window      */
    char            w_extra[856-MAXDIRZ-MAXFNAMEZ-TITLESP]; 
                                   /* extra space                       */ 
} WW;         /* size = 1000 bytes */ 

/* #pragma noalign (sv) */

typedef struct sv  { 
    long            save_size; 
    long            tic_time;
    short           disk_num; 
    short           freedp;
    unsigned char   a_window;
    char            marg_mode;
} SV;         /* size = 14 bytes */

/* #pragma noalign (gg) */

typedef struct gg {
    short           rank;
    char            name[9]; 
    char            extn[3];
    long            size;
} GG;

/* #pragma noalign (nber) */

typedef struct nber {
    short           flags;
    short           set[5];
    long            fraction;
} NBER;

/* #pragma noalign (p_config) */

typedef struct p_config  { 
    long printer_code;     /* 0 = none 
                              1 = LaserJet III                      */ 
    long port;             /* 
                                    0 = LPT0 
                                    1 = LPT1 
                                    2 = LPT2 
                                    3 = LPT3 
                                    4 = invalid code                */  
    long top_line; 
    long number_of_lines; 
    long line_spacing; 
    long left_margin;      /* in units of 100th of an inch          */ 
    long number_of_copies; 
    long orientation;      /* 0 = portrait; 1 = landscape           */ 
    char font[160];        /* 4 x name string or a control string */ 
    char font_ctrlstr[160];   /* 4 x actual font control strings */ 
    char font_ctrlstra[160];  /* 4 x actual font control strings (alt) */ 
} PR_CON; 

typedef struct org_dir  { 
    long  date_time; 
    long  size; 
    char  ftype; 
    char  name[11]; 
    char  exten[4]; 
    unsigned short name_ext; 
    unsigned short exten_ext; 
    short order; 
    short xsize; 
} ORG_DIR;            /* size = 32 bytes */ 

typedef struct dir_dat  { 
    short  extension; 
    char   line[69];    /* NULL terminated string, max leng = 68 bytes */ 
    char   xxx;         /* flag  0 = directory, 1 = file, 2 = total, 3 = link, 4 = other */
} DIR_DAT;            /* size = 72 bytes */ 

typedef struct field_siz  { 
    short  x1; 
    short  x2; 
    short  y1; 
    short  y2; 
} FIELD_SIZ;          /* size = 8 bytes */ 


#include  "tw_flist.h" 
