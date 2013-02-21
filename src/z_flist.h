/***                         DMUSE PROGRAM 
                           LINUX version 1.00 
            (c) Copyright 1992, 1999, 2007 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 03/18/2007) 
                            (rev. 06/04/2009) 
                            (rev. 09/05/2009) 
                            (rev. 04/03/2010) 
                            (rev. 05/08/2010) 

                  Function Definitions for Zbex Compiler 
                                                                        ***/ 

       /***   zfun01.c   I/O interface subroutines                ***/

long   my_getline(char *s, long limit);                     /* M,zm,21,24,25 */
long   trmline(char *s);                                    /* M,zm,21,25 */
void   error(char *s1, char *s2);                           /* zm,21 */ 
void   terminate_ww();                                      /* 24,32 */ 


       /***   zfun21.c   Communication                            ***/ 

ssize_t my_writeall(int fd, const void *buf, size_t nbyte); /* 21,25 */ 
ssize_t my_readall(int fd, void *buf, size_t nbyte);        /* 25 */ 
long   byte_write(char *ss, long n, int fd);                /* 21,30 */
long   zload(long mode, char *wwprog);                      /* M,zm */ 
void   zcleanup();                                          /* M */ 
long   zmem_push(long *newadd);                             /* 21,27 */ 
void   zmem_free();                                         /* 21,27 */ 
void   zmem_free_addr(long *add_pt);                        /* 27 */ 
long   no_read(int flag, char *out, long size); 
long   no_read2(int flag, char *out, long size); 


       /***   zutil.c    Utility and space saving functions       ***/ 

char  *read_digits(char *sp1, long n, long *v);        /* 3,5,6,12,15,24 */ 
char  *construct_digits(char *sp1, long len, long n);  /* 14,24 */ 
unsigned char case_convert(unsigned char c, long mode);     /* 26,x4 */ 

/***                         Interpreter                                ***/ 


       /***   zfun22.c   Interpreter                              ***/ 

void   interpret();                                         /* M */ 


       /***   zfun23.c                                            ***/ 

void   Zevsub(long *val);                                   /* 22,23,28 */ 
long   int_op(long k, long g, long h, long *p);             /* 23 */ 
void   real_op(double *x, double y, long h, long *p);       /* 23 */ 
void   Zevint(long *val, long *xop);                        /* 22,23,26 */ 
long   Zcompute_offset(element *var_pnt, element TIPC);     /* 23,28 */ 
long   Zevints();                                           /* 23,26 */ 
void   Zevreal(double *val, long *xop);                     /* 22,23 */ 
void   Zevreals(double *val);                               /* 23,26 */ 
void   ZidA_str(long *(*stradd), long *mlen, long mode);    /* 22 */ 
void   Zidgenstr(long *(*stradd), long *mlen, long *off1, 
               long *off2, long *xop, long *spt, long f);   /* 22,25,26,27 */
void   Zget_sub_offsets(long subflag, long slen, 
               long *off1, long *off2, element TIPC);       /* 23 */ 
void   Zidsubstr(char *(*s), long *len, long *xop, 
               long *subval);                               /* 22,23,25,26,27 */
void   ZidA_bstr(long *(*stradd), long *mlen, long mode);   /* 22 */ 
void   Zidsubbitstr(long *(*bsw), long *bnum, 
               long *len, long *xop);                       /* 22,23,26 */ 
void   Zevfint(long *val, long *xop);                       /* 23 */ 
void   Zevfreal(double *val, long *xop);                    /* 23 */ 
/* int    matherr(struct exception *x); */ 
long  *Zidint();                                            /* 22,25,26 */ 
void   Zidreal(double *(*rpt));                             /* 22,25 */ 
long   Zgenintex();                                         /* 22,25,27 */ 
void   Zgenfltex(double *val);                              /* 22 */ 
long   Zintex(long start, long fopp);                       /* 22,23 */ 
void   Zfltex(double *val, double start, long fopp);        /* 22,23 */ 
long   ZevA_int();                                          /* 22 */ 
void   ZevA_real(double *val);                              /* 22 */ 
double my_arcsincos(long flag, double x); 
double my_arctan(double x); 
double my_sincostan(long flag, double x); 
double my_exp(double x); 
double my_log(double x); 
double my_sqrt(double x); 
double my_pow(double x, double y); 


       /***   zfun24.c   Message handling routines                ***/ 

void   zerodiv(long *loc);                                  /* 22,23 */ 
void   rzerodiv(long *loc);                                 /* 23 */ 
void   suberr(long a, long b, long *loc, long *lnk, 
               long i);                                     /* 22,23 */ 
void   strsuberr(long a, long b, element TIPC, long i);     /* 22,23 */ 
void   strsubwarn(long a, long b, element TIPC, long i);    /* 22,28 */ 
void   strlenerr(long a, long b, element TIPC, long maxf);  /* 22,26 */ 
void   strlenerr2(long a, long b, long *loc, long *lnk);    /* 29 */ 
void   calcstrlenerr(long a, long b, element TIPC);         /* 31 */ 
void   dynamicarrayerr(long *loc, long n);                  /* 31 */ 
void   planenumerr(long a, long b, long *loc);              /* 31 */ 
void   strlenwarn(long a, long b, long *loc, long *lnk); 
void   negstrlen(long a, element TIPC);                     /* 23 */ 
void   negstrwarn(long a, element TIPC);                    /* 28 */ 
void   tgeterr1(long *loc);                                 /* 27 */ 
void   tgeterr2(long a, long b, long *loc);                 /* 27 */ 
void   tputerr1(long a, long b, long *loc);                 /* 27 */ 
void   funcwarn(long a, double val, long *loc);             /* 23 */ 
void   strwarn1(long a, long b, long *loc, long *lnk);      /* 22 */ 
void   fileerr1(long *loc, long n);                         /* 25 */ 
void   fileerr2(long *loc, long n);                         /* 25 */ 
void   fileerr3(long *loc, char *name, long k, long n);     /* 25 */ 
void   fileerr4(long *loc, char *name, long k, long n, 
               long f);                                     /* 25 */ 
void   fileerr5(long *loc, char *name, long k, long n, 
               long x, long f);                             /* 25 */ 
void   filewarn1(long *loc, char *name, long k, long n);    /* 25 */ 
void   filewarn2(long *loc, char *name, long k);            /* 25 */ 
long   filewarn3(long *loc, char *name, long k, long f, 
               long linecode);                              /* 25 */ 
void   outwarn1(long *loc);                                 /* 25 */ 
void   procallerr(long *loc);                               /* 22 */ 
void   mem_err(); 
char  *get_msg_string(int msg);                             /* 21,24 */ 
char  *get_source_line(long *loc, long *n);                 /* 24 */ 
void   get_lineidx(long *ipc, long oldn, long *n, 
               long *p);                                    /* 24,25 */ 
void   get_sfindex(long *lowi);                             /* 24 */ 
void   get_varstat(long *loc, char *(*vname), 
               char *(*vtype));                             /* 24 */ 
void   msgf0(int n);                                        /* 21,22,24 */ 
void   msgf1(int n, long k);                                /* 21 */ 
void   errf1(int n);                                        /* 24 */ 
void   errf2(int n, int format, long *loc, long *var, 
               long v1, long v2, long v3);                  /* 24 */ 

void   errf3(int n, long *loc, double x);                   /* 24 */ 
void   errf4(int n, int format, long *loc, char *fname, 
               long v1, long v2, long v3);                  /* 24 */ 
void   print_source_line(char *s, long n);                  /* 24 */ 


       /***   zfun25.c                                            ***/ 

long   Zcallgetc(long f, long linecode);                    /* 22 */ 
void   Zcallputc(long f);                                   /* 22 */ 
long   Zcallputp(long f);                                   /* 22 */ 
void   Zline_input(char *line, long g);                     /* 25,27 */ 
long   get_bstr(char *sp, long *ip, long off1, long off2);  /* 25 */ 
long   get_int(char *sp, long *ip, long n);                 /* 25 */ 
long   get_real(char *sp, double *rp, long n);              /* 25 */ 
void   Zline_output(char *line, long *bpt, long *outf);     /* 25,27 */ 
long   Zinstruction12(long *ip3);                           /* 22 */ 
long   instruction13();                                     /* 22 */ 
long   Zcallopen(long f, long x, long linecode);            /* 22,25 */ 
long   Zcallgetf(long f, long linecode);                    /* 22 */ 
long   Zcallputf(long f, long linecode);                    /* 22 */ 
void   Zcallclose();                                        /* 22 */ 
long   Zcallcreate(long linecode);                          /* 22 */ 
long   Zcallreadwrite(long f, long linecode);               /* 22 */ 
void   Zcallgetdir();                                       /* 22 */ 
/*long   check_fname(char *name); (in xfun09.c)                25 */ 


       /***   zfun26.c                                            ***/ 

void   Zappendstr(char *sp1, long mlen, 
               long *slen, long nxop, element TIPC);        /* 22 */ 
void   Zappstrfun(char *sp1, long *inc, 
               long mlen, long *slen, long *nxop, 
               element TIPC);                               /* 22,26 */ 
void   Zckgenstr(long *(*vid), char *(*sp2), 
               long *slen, long *nxop);                     /* 22,26 */ 
void   Zckgenbstr(long *(*vid), long *(*wip), 
               long *boff, long *slen, long *nxop);         /* 26 */ 
void   Zckstrx(long *(*vid), char *(*sp2), long *slen, 
               long *nxop, long *proc, long *toff);         /* 22 */ 
void   Zckstrfun(long fna, long *(*vid), char *(*sp2), 
               long *slen, long *proc, long *toff);         /* 22,26 */ 
void   int_to_ascii(long h, long mlen, char *sp1, 
               long *len);                                  /* 26 */ 
long   Zreal_to_ascii(char *sp1, long mode);                /* 26 */ 
long   Zint_to_hexoct(long max, char *sp1, long mode);      /* 26 */ 
void   pcatstr(long cnt, long xnt, char *sp1, char *vp2[], 
               long vlen2[], long vpro2[]);                 /* 22 */ 
void   do_txt(char *sp1, long mlen, char *sp2, long g, 
               long *tip, long *tip2, long *inc, 
               element TIPC);                               /* 26 */ 
void   Zappbstr(long *ip, long off, long mlen, 
               long *slen, long nxop, element TIPC);        /* 22 */ 
void   Zappbfun(long *ip, long off, long *inc, long mlen, 
               long *slen, long *nxop, element TIPC);       /* 22,26 */ 
void   work_around_1(long *ip1, long *inc1, long *ip2, 
               long len, long *off1, long off2, long opf);  /* 22,26 */ 
void   bits_right_shift(long *ip1, long off1, long *ip2, 
               long off2, long len);                        /* 22 */ 


       /***   zfun27.c                                            ***/ 

void   Zinstruction31();                                    /* 22 */ 
void   Zinstruction32();                                    /* 22 */ 
void   Zinstruction33();                                    /* 22 */ 
void   get_table_data(element pt, long tbz, long h, 
               long *ip1, long *ip2, long max1, long max2, 
               long mode);                                  /* 27 */ 
void   get_tdata_fast(long *ip1, long *ip2, long len, 
               long max);                                   /* 27 */ 
void   get_tdata_slow(long *ip1, long len, long max, 
               element pt, long h, long tbz);               /* 27 */ 
void   compute_hash(char *sp1, long len, long mtz, 
               long *k1, long *k2);                         /* 27,x4 */ 
long   Ztdxfunc();                                          /* 23 */ 
void   Zinstruction34();                                    /* 22 */ 
void   Zinstruction35();                                    /* 22 */ 
void   write_table_data(element pt, long tbz, long h, 
               char *sp1, char *sp2, long len1, long len2, 
               long *xfwpoint, long mode);                  /* 27 */ 
void   write_tdata_slow(char *sp1, long len, element pt, 
               long h, long tbz, long mode);                /* 27 */ 
void   Zinstruction36();                                    /* 22 */ 
void   Zinstruction391();                                   /* 22 */ 


       /***   zfun28.c                                            ***/ 

void   Zrel_idgenstr(long *(*stradd), long f);              /* 22 */ 
void   Zrel_idsubstr(char *(*s), long *len);                /* 22 */ 
void   Zget_sub_offlen(long subflag, long slen, 
               long *off1, long *len, element TIPC);        /* 28 */ 
void   Zrel_idsubbitstr(long *(*bsw), 
               long *bnum, long *len);                      /* 22 */ 
long   bitcmp(long *ip1, long off1, long *ip2, long off2, 
               long slen);                                  /* 22 */ 


       /***   zfun29.c                                            ***/ 

void   pass_argument(long *var, long xcode, long xdim, 
               long opflg);                                 /* 22 */ 


       /***   zfun31.c                                            ***/ 

void   Zcallbitmode();                                      /* 22 */ 
void   Zcallactivate();                                     /* 22 */ 
void   Zcallsetup();                                        /* 22 */ 
void   Zcallsetclearb(long f);                              /* 22 */ 
void   Zcalldscale();                                       /* 22 */ 

       /***   zfun32.c   Midi functions                           ***/ 

void   Zcallmidiput();                                      /* 22 */ 
void   Zcallmidiget();                                      /* 22 */ 
long   get_bit_value(long *bpt, long n); 
long   dcompbot(long insize); 
long   get_ww(); 
void   load_big(); 
