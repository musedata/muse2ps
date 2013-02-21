/***                         DMUSE PROGRAM 
                           LINUX version 0.02 
            (c) Copyright 1992, 1999, 2007 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 07/25/2007) 
                            (rev. 12/27/2007) 

                          CONSTANT DEFINITIONS 
                             Display Program 
                                                                        ***/ 

/* include function list */ 

#include  "d_flist.h" 


#define  UP                 0 
#define  DOWN               1 
#define  SUPERSIZE         64 
#define  SUPERMAX          50 
#define  MAX_BNOTES        32 
#define  DOT_CHAR          44 

#define  MY_PIXWIDTH     1600 
#define  MY_BPIXWIDTH     200 
#define  MY_PIXHEIGHT    1200 

typedef struct tiff_dat  { 
    char           t_comp[64]; 
    char           t_work[64]; 
    char           t_repr[64]; 
    char           t_reso[64]; 
    char           t_notz[64]; 
    char           t_sub_name[64]; 
    long           t_sub_num; 
    long           t_page_num; 
} TIFF_DAT;   /* size = 392 bytes */ 
