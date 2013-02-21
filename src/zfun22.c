/***                         DMUSE PROGRAM 
                           LINUX version 1.02 
            (c) Copyright 1992, 1999, 2007, 2009 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 04/24/2009) 
                            (rev. 06/04/2009) 
                            (rev. 09/07/2009) 
                            (rev. 12/27/2009) 
                            (rev. 04/03/2010) 
                            (rev. 05/05/2010) 
                            (rev. 05/08/2010) 

                          Zbex Main Interpreter 
                                                                        ***/ 
#include  "all.h" 

/* conditional assembly     */ 

/*** FUNCTION  void interpret(); 

    Purpose:   top of interpreter          

    Input:     none

    Output:    none 

    Return     void
                                                                     ***/ 

void interpret() 
{ 
    extern zint_vars   ztv;  
    extern long       *prolevel_stack[PROLEVEL][2]; 
    extern long        prolevel_numbers[PROLEVEL]; 
    extern char       *maxtemp; 
    extern long        maxstringlen; 
    extern jmp_buf     sjbuf;    /* set to top of compile loop in this prog */ 

    extern element     elk;  /* run-time union pointer to link memory */ 
    extern element     IPC; 
    extern long        b1; 

    extern long        orbitflag[]; 
    extern long        andbitflag[]; 
    extern long        testbitflag[]; 

    extern char        inter_longjmp;  /* New &dA01/29/07&d@: longjmp alert for interpret */

    char           *sp1, *sp2, *sp3, *sp4; 
    char           *vp2[30], *vp3;              /* pointers for concat */ 

    element         TIPC; 
    element         TIPC2; 
    element         pt;            /* need to keep this */ 

    double         *x, *y, z, w; 

    long            f, g, h, i, j, k; 
    long            jj, kk;       /* kk added &dA04/24/09&d@ */ 
    long            a; 
    unsigned        long ui; 
    long            instr; 
    long            fna; 
    long           *ip1, *ip2, *ip3, *ip4, *ip5, *ip6; 
    long            mlen, slen, flen; 
    long            nxop; 
    long            off1, off2, off3, off4, off5, off6; 
    long           *vid1, *vid2; 
    long            vlen2[30], vpro2[30];     /* concatenation data */ 
    long            v2cnt;          /* number of concatenation elements */ 
    long            xxcnt;          /* element based on the target string */
    long            tset[8]; 
    long            choice; 

/*    ANALYSIS OF CALLS TO VOLITILE FUNCTIONS     

                  ÚÄZcallgetc()          2 Entries  (1 Active) 
                  ÃÄZcallopen()          3 Entries  (1 Active) 
                  ÃÄZcallgetf()          3 Entries  (1 Active) 
     interpret() ÄÅÄZcallputf()          3 Entries  (1 Active) 
                  ÃÄZcallcreate()        3 Entries  (1 Active) 
                  ÀÄZcallreadwrite()     3 Entries  (1 Active) 
*/ 

    k = setjmp(sjbuf);           /* return here after error */ 
    if (inter_longjmp == 1)  { 
        inter_longjmp = 0; 
        goto CTRL_EXIT; 
    } 

/* Initialize these variables to something */ 

    off6 = 0; 
    off5 = 0; 
    ip6  = tset; 
    ip5  = tset; 

/* I. load run-time variables  */ 

    elk.n         = ztv.zelk.n;          /**/ 
/*  ztv.zepr.n    = ztv.zepr.n;            */ 
    IPC.n         = ztv.zIPC.n; 
/*  sfcnt         = ztv.zsfcnt;            */ 
/*  prolevel      = ztv.zprolevel;         */ 
    b1            = ztv.zb1; 
/*  operationflag = ztv.zoperationflag;    */ 
    ip3           = ztv.last_var; 

    maxtemp       = ztv.zmaxtemp;                  /* Bug fix &dA10/18/07&d@ */ 

TOP: 

    instr = *IPC.n; 
    ++IPC.n; 

    switch (instr)  { 
        case 0: 
            msgf0(WMSG56); 
            goto CTRL_EXIT; 
        case 1: 
            ztv.zoperationflag = *IPC.n; 
            break; 
        case 2: 
            jj = *IPC.n; 
            j = jj & 1; 
            jj >>= 1; 
            if (jj > 31 || jj < 0)  k = 0; 
            else                    k = 1 << jj; 
            if (j == 1)  ztv.zoperationflag |= k; 
            else         ztv.zoperationflag &= ~k; 
            break; 
        case 3: 
            goto CTRL_EXIT; 
        case 11: 
            goto TOP; 
        case 12: 
            goto CTRL_EXIT; 
        case 13: 
            goto CTRL_EXIT; 
        case 16: 
            prolevel_stack[ztv.zprolevel][0] = IPC.n + 1; 
            prolevel_numbers[ztv.zprolevel]  = ztv.zpronum; 
            ztv.zprolevel += 1; 
            if (ztv.zprolevel > PROLEVEL)  { 
                procallerr(IPC.n); 
            } 
            IPC.n = *IPC.p; 
            ztv.zpronum = *(IPC.n - 1);   /* entering procedure number # */ 
            goto TOP; 
        case 17: 
            if (*IPC.n != 0)  { 
                *(elk.n + TRP) = *IPC.n; 
                IPC.n = *(elk.p + 1); 
                ztv.zprolevel = 0; 
                ztv.zpronum = -1; 
                goto TOP; 
            } 
            else  { 
                ztv.zprolevel -= 1; 
                IPC.n = prolevel_stack[ztv.zprolevel][0]; 
                ztv.zpronum = prolevel_numbers[ztv.zprolevel]; 
                goto TOP; 
            } 
        case 18: 
            f = *(IPC.n + 1);       /* number of calling variables */ 
            for (h = 0; h < f; ++h)  { 
                *(*IPC.p + (2*h) + 1) = *(IPC.n + h + 2); 
            } 
            prolevel_stack[ztv.zprolevel][0] = IPC.n + f + 2; 
            prolevel_stack[ztv.zprolevel][1] = *IPC.p; 
            prolevel_numbers[ztv.zprolevel]  = ztv.zpronum; 
            ++ztv.zprolevel; 
            if (ztv.zprolevel > PROLEVEL)  { 
                procallerr(IPC.n); 
            } 
            f <<= 1; 
            IPC.n = *IPC.p + f; 
            ztv.zpronum = *(IPC.n - 1 - f);   /* entering procedure number # */
            goto TOP; 
        case 19:                    /* pass argument to procedure */ 
            h = *IPC.n;             /* xdim (16); xcode (8); arg num */ 
            f = h & 0xff; 
            --f; 
            h >>= 8; 
            k = h & 0xff; 
            h >>= 8; 
            ip6 = prolevel_stack[ztv.zprolevel - 1][1] + (f << 1); 
            pass_argument(ip6, k, h, 1); 
            break; 
        case 20:                    /* pass argument to calling environment */ 
            h = *IPC.n;             /* xdim (16); xcode (8); arg num */ 
            f = h & 0xff; 
            --f; 
            h >>= 8; 
            k = h & 0xff; 
            h >>= 8; 
            ip6 = prolevel_stack[ztv.zprolevel - 1][1] + (f << 1); 
            pass_argument(ip6, k, h, 2); 
            break; 
        case 21:                    /* unconditional branch  */ 
            IPC.n = *IPC.p; 
            goto TOP; 
        case 22:                    /* uncon. branch to label var. */ 
            h = *(*IPC.p);             /* diminsion of label */ 
            TIPC.n = IPC.n++; 
            Zevsub(&k); 
            if (k < 1 || k > h)  suberr(k, h, TIPC.n, *TIPC.p, 0); 
            IPC.n = *(*TIPC.q + k); 
            goto TOP; 
        case 23: 
            if (b1 == 0)  { 
                IPC.n = *IPC.p; 
                goto TOP; 
            } 
            ++IPC.n; 
            goto TOP; 
        case 24: 
            if (b1 == 1)  { 
                IPC.n = *IPC.p; 
                goto TOP; 
            } 
            ++IPC.n; 
            goto TOP; 
        case 25: 
            b1 = (b1 + 1) & 1; 
            goto TOP; 
        case 26: 
            IPC.n += (b1 - 2); 
            IPC.n = *IPC.p; 
            goto TOP; 
        case 31:                 /* tget [table] str str (dump table) */ 
            Zinstruction31(); 
            goto TOP; 
        case 32:                 /* tget [table, str] <fp>  */ 
            Zinstruction32(); 
            goto TOP; 
        case 33:                 /* tget [table, int] <fp>  */ 
            Zinstruction33(); 
            goto TOP; 
        case 34:                 /* tput [table, str] <fp>  */ 
            Zinstruction34(); 
            goto TOP; 
        case 35:                 /* tput [table, int] <fp>  */ 
            Zinstruction35(); 
            goto TOP; 
        case 36:                 /* treset [table] (set up for re-use) */ 
            Zinstruction36(); 
            goto TOP; 
        case 41:                 /* loop for i = 1 to # step # */ 
            *(*(IPC.p + 1)) = 1;      /* initialize counter */ 
            if (*(IPC.n + 3) < 1)  { 
                if ((ztv.zoperationflag & 0x400) != 0)  { 
                    errf2(WMSG71, 1, IPC.n, NULL, 0L, 0L, 0L); 
                } 
                IPC.n = *IPC.p;       /* skip loop */ 
                goto TOP; 
            } 
            IPC.n += 4;               /* and go inside loop */ 
            goto TOP; 
        case 42:                 /* loop for i = 1 to S-int step # */ 
            h = *(*(IPC.p+1));        /* h = final value  */ 
            *(*(IPC.p + 2)) = 1;      /* initialize counter */ 
            if (h < 1)  { 
                if ((ztv.zoperationflag & 0x400) != 0)  { 
                    errf2(WMSG71, 1, IPC.n, NULL, 0L, 0L, 0L); 
                } 
                IPC.n = *IPC.p;       /* skip loop */ 
                goto TOP; 
            } 
            *(IPC.n + 4) = h;         /* put in final value */ 
            IPC.n += 5;               /* and go inside loop */ 
            goto TOP; 
        case 43:                 /* loop for i = # to # step # */ 
            k = *(IPC.n + 1);         /* initial value   */ 
            *(*(IPC.p + 2)) = k;      /* initialize counter */ 
            if (k > *(IPC.n + 4))  { 
                if ((ztv.zoperationflag & 0x400) != 0)  { 
                    errf2(WMSG71, 1, IPC.n, NULL, 0L, 0L, 0L); 
                } 
                IPC.n = *IPC.p;       /* skip loop */ 
                goto TOP; 
            } 
            IPC.n += 5;               /* and go inside loop */ 
            goto TOP; 
        case 44:                 /* loop for i = # to S-int step # */ 
            k = *(IPC.n + 1);         /* initial value   */ 
            h = *(*(IPC.p+2));        /* h = final value  */ 
            *(*(IPC.p + 3)) = k;      /* initialize counter */ 
            if (k > h)  { 
                if ((ztv.zoperationflag & 0x400) != 0)  { 
                    errf2(WMSG71, 1, IPC.n, NULL, 0L, 0L, 0L); 
                } 
                IPC.n = *IPC.p;       /* skip loop */ 
                goto TOP; 
            } 
            *(IPC.n + 5) = h;         /* put in final value */ 
            IPC.n += 6;               /* and go inside loop */ 
            goto TOP; 
        case 45:                 /* loop for i = # to # step # */ 
            k = *(*(IPC.p + 1));      /* initial value   */ 
            *(*(IPC.p + 2)) = k;      /* initialize counter */ 
            if (k > *(IPC.n + 4)) { 
                if ((ztv.zoperationflag & 0x400) != 0)  { 
                    errf2(WMSG71, 1, IPC.n, NULL, 0L, 0L, 0L); 
                } 
                IPC.n = *IPC.p;       /* skip loop */ 
                goto TOP; 
            } 
            IPC.n += 5;               /* and go inside loop */ 
            goto TOP; 
        case 46:                 /* loop for i = # to S-int step # */ 
            k = *(*(IPC.p + 1));      /* initial value   */ 
            h = *(*(IPC.p+2));        /* h = final value  */ 
            *(*(IPC.p + 3)) = k;      /* initialize counter */ 
            if (k > h)  { 
                if ((ztv.zoperationflag & 0x400) != 0)  { 
                    errf2(WMSG71, 1, IPC.n, NULL, 0L, 0L, 0L); 
                } 
                IPC.n = *IPC.p;       /* skip loop */ 
                goto TOP; 
            } 
            *(IPC.n + 5) = h;         /* put in final value */ 
            IPC.n += 6;               /* and go inside loop */ 
            goto TOP; 
        case 47:                 /* loop for i = exp to exp step # */ 
            TIPC.n = IPC.n; 
            ip1 = *IPC.p;             /* save jump PC  */ 
            ++IPC.n; 
            k = Zgenintex();     /* get initial value */ 
            h = Zgenintex();     /* get final value   */ 
            *(*IPC.p) = k;            /* initialize counter */ 
            if (k > h)  { 
                if ((ztv.zoperationflag & 0x400) != 0)  { 
                    errf2(WMSG71, 1, TIPC.n, NULL, 0L, 0L, 0L); 
                } 
                IPC.n = ip1;          /* skip loop */ 
                goto TOP; 
            } 
            *(IPC.n + 2) = h;         /* put in final value */ 
            IPC.n += 3;               /* and go inside loop */ 
            goto TOP; 
        case 48:                 /* all remaining loop situations  */ 
            TIPC.n = IPC.n; 
            ip1 = *IPC.p;             /* save jump PC  */ 
            ++IPC.n; 
            k = Zgenintex();     /* get initial value */ 
            h = Zgenintex();     /* get final value   */ 
            i = Zgenintex();     /* get i = step          */ 
            *(*IPC.p) = k;            /* initialize counter */ 
            if (i >= 0)  { 
                if (k > h)  { 
                    if ((ztv.zoperationflag & 0x400) != 0)  { 
                        errf2(WMSG71, 1, TIPC.n, NULL, 0L, 0L, 0L); 
                    } 
                    IPC.n = ip1;          /* skip loop */ 
                    goto TOP; 
                } 
            } 
            else { 
                if (k < h)  { 
                    if ((ztv.zoperationflag & 0x400) != 0)  { 
                        errf2(WMSG71, 1, TIPC.n, NULL, 0L, 0L, 0L); 
                    } 
                    IPC.n = ip1;          /* skip loop */ 
                    goto TOP; 
                } 
            } 
            *(IPC.n + 1) = i;         /* put in step value  */ 
            *(IPC.n + 2) = h;         /* put in final value */ 
            IPC.n += 3;               /* and go inside loop */ 
            goto TOP; 
        case 50:                 /* repeat on b = 1 (to loop) */ 
            if (b1 == 0)  { 
                ++IPC.n; 
                goto TOP; 
            }       /* fall through to case 49  */ 

        case 49:                 /* unconditional repeat (to loop) */ 
            k = *(*IPC.p + 1);      /* k = increment         */ 
            ip1 = *(*IPC.q);        /* ip1 = pointer to counter */ 
            h = *ip1 + k;           /* h = new counter value */ 
            j = *(*IPC.p + 2);      /* j = loop max/min      */ 
            if ((k >= 0 && h <= j) || (k < 0 && h >= j))  { 
                *ip1 = h;            /* update counter        */ 
                IPC.n = *IPC.p + 3;  /* and go inside loop    */ 
                goto TOP; 
            } 
            ++IPC.n; 
            goto TOP; 
        case 51:                 /* open [ , ]  file  */ 

            TIPC.n = IPC.n - 1; 
            h = Zcallopen(1, 0, 1); 
            if (h < 0)  {  /* need an input line */ 
                IPC.n = TIPC.n; 
            } 
            if (h == 2)  { 
                goto CTRL_EXIT; 
            } 
            goto TOP; 
        case 56:                 /* close [ ]         */ 
            Zcallclose(); 
            goto TOP; 
        case 61:                 /* read, write */ 
        case 62: 
        case 63: 
        case 64: 
            choice = instr - 60; 
            TIPC.n = IPC.n - 1; 
            h = Zcallreadwrite(choice, 2); 
            if (h < 0)  {  /* need an input line */ 
                IPC.n = TIPC.n; 
            } 
            
            goto TOP; 
        case 65:                 /* create directory */ 
            TIPC.n = IPC.n - 1; 
            h = Zcallcreate(2); 
            if (h < 0)  {  /* need an input line */ 
                IPC.n = TIPC.n; 
            } 
            goto TOP; 
        case 66: 
            Zcallgetdir(); 
            goto TOP; 
        case 71:                 /* getc             */ 
        case 72:                 /* getc <fp>        */ 
            if (instr == 72)  { 
                jj = *IPC.n;     /* this is the first command word */ 
            } 
            else  { 
                jj = 0; 
            }  

            if ( (jj == 0x15) || (jj == 0x1d) )  {   /* this is the getC instruction */
                h = Zcallgetc(1, 2);   /* line is in "fixed string" */ 
                goto TOP; 
            } 
            if ( (jj == 0x16) || (jj == 0x1e) )  {   /* this is the getd instruction */
                h = Zcallgetc(1, 3);   /* line accessed with localtime() */ 
                goto TOP; 
            } 
            choice = instr - 71; 
            h = Zcallgetc(choice, 0); 
            if (h == 2)  { 
                goto CTRL_EXIT; 
            } 
            goto TOP; 
        case 73:                 /* putc             */ 
            send_twline("\n", -1); 
            goto TOP; 
        case 74:                 /* putc <fp>        */ 
            Zcallputc(0); 
            goto TOP; 
        case 75:                 /* putp <fp>        */ 
            h = Zcallputp(1); 
            goto TOP; 
        case 76:                 /* putp <fp>        */ 
            h = Zcallputp(2); 
            goto TOP; 
        case 77:                 /* getk int         */ 
            *(*IPC.p) = 0; 
            ++IPC.n; 
            goto TOP; 
        case 78:                 /* pute             */ 
            alt_send_twline("\n", -1); 
            goto TOP; 
        case 79:                 /* pute <fp>        */ 
            Zcallputc(1); 
            goto TOP; 
        case 81:                 /* getf <fp>        */ 
        case 82:                 /* getf [#] <fp>    */ 
        case 83:                 /* getf [int] <fp>  */ 
            choice = instr - 80; 
            TIPC.n = IPC.n - 1; 
            h = Zcallgetf(choice, 2); 
            if (h < 0)  {  /* need an input line */ 
                IPC.n = TIPC.n; 
            } 

            /* &dAThe following three lines were added 11-25-92.&d@  
               They are intended to deal with the case where 
               a zbex getf statement encounters an undefined 
               eof AND more than one program is currently 
               running.  In this case (and only in this case) 
               h will have the value of 2 at this point.  The 
               proper thing to do is to terminate the program, 
               which I think these lines will do properly. */ 

            if (h == 2)  {   /* undefined eof */ 
                goto CTRL_EXIT; 
            } 

            
            goto TOP; 
        case 86:                 /* putf <fp>        */ 
        case 87:                 /* putf [#] <fp>    */ 
        case 88:                 /* putf [int] <fp>  */ 
            choice = instr - 85; 
            TIPC.n = IPC.n - 1; 
            h = Zcallputf(choice, 2); 
            if (h < 0)  {  /* need an input line */ 
                IPC.n = TIPC.n; 
            } 
            
            goto TOP; 
        case 91:                 /* bitmode int,int  */ 
            Zcallbitmode(); 
            goto TOP; 
        case 92:                 /* textmode */ 
            goto TOP; 
        case 93:                 /* activate S-str, int,int,int (int,int) */ 
            Zcallactivate(); 
            goto TOP; 
        case 94:                 /* setb S-str, A-bstr, 5 x int */ 
            Zcallsetclearb(1); 
            goto TOP; 
        case 95:                 /* clearb S-str, A-bstr, 5 x int */ 
            Zcallsetclearb(0); 
            goto TOP; 
        case 96:                 /* setb S-str, A-int, 6 x int */ 
            Zcallsetclearb(3); 
            goto TOP; 
        case 97:                 /* clearb S-str, A-int, 6 x int */ 
            Zcallsetclearb(2); 
            goto TOP; 
        case 98:                 /* setup    S-str, int,int,int */ 
            Zcallsetup(); 
            goto TOP; 

        case 99:                 /* dscale2/3/5  S-str, S-str, int,int,int,int,int    */
            Zcalldscale(); 
            goto TOP; 

/*  STRINGS  */ 
        case 101:               /* S-str = "" (0 bytes)               */ 
            *(*(*IPC.q)) = 0; 
            ++IPC.n; 
            goto TOP; 
        case 102:               /* S-str = "...", S-str1 (no subs)    */ 
            ip3 = *(*IPC.q); 
            sp1 = (char *) (ip3 + 1); 
            mlen = *(*IPC.p + 1); 
            ip4  = *(*(IPC.q+1)); 
            slen = *ip4; 
            sp2  = (char *)(ip4+1); 
            if (slen > mlen)  strlenerr(slen, mlen, IPC, 0); 
            *ip3 = slen; 
            memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
            IPC.n += 2; 
            goto TOP; 
        case 103:               /* S-str = A-str1 (no subs)           */ 
            ip3 = *(*IPC.q); 
            sp1 = (char *) (ip3 + 1); 
            mlen = *(*IPC.p + 1); 
            TIPC.n = IPC.n++; 
            ZidA_str(&ip4, &h, 1); 
            slen = *ip4; 
            sp2  = (char *)(ip4+1); 
            if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            *ip3 = slen; 
            memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
            goto TOP; 
        case 104:               /* S-str = S-str{#..}                 */ 
            ip3 = *(*IPC.q); 
            sp1 = (char *) (ip3 + 1); 
            slen = *ip3; 
            h = *(IPC.n+1); 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, IPC, 1); 
            } 
            sp2  = sp1 + h - 1; 
            slen -= h - 1; 
            *ip3 = slen; 
            memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
            IPC.n += 2; 
            goto TOP; 
        case 105:               /* S-str = S-str1{#..}                */ 
            ip3 = *(*IPC.q); 
            sp1 = (char *) (ip3 + 1); 
            mlen = *(*IPC.p + 1); 
            ip4  = *(*(IPC.q+1)); 
            slen = *ip4; 
            sp2 = (char *)(ip4+1); 
            h = *(IPC.n+2); 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, IPC, 1); 
            } 
            sp2  += h - 1; 
            slen -= h - 1; 
            if (slen > mlen)  strlenerr(slen, mlen, IPC, 0); 
            *ip3 = slen; 
            memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
            IPC.n += 3; 
            goto TOP; 
        case 106:               /* S-str = A-str1{#..}                */ 
            ip3 = *(*IPC.q); 
            sp1 = (char *) (ip3 + 1); 
            mlen = *(*IPC.p + 1); 
            TIPC.n = IPC.n++; 
            ZidA_str(&ip4, &h, 1); 
            slen = *ip4++; 
            sp2 = (char *) ip4; 
            h = *IPC.n++; 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, TIPC, 1); 
            } 
            sp2  += h - 1; 
            slen -= h - 1; 
            if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            *ip3 = slen; 
            memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
            goto TOP; 
        case 107:               /* S-str = S-str{S-int..}             */ 
            ip3 = *(*IPC.q); 
            sp1 = (char *) (ip3 + 1); 
            slen = *ip3; 
            h = *(*(IPC.p+1)); 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, IPC, 1); 
            } 
            sp2  = sp1 + h - 1; 
            slen -= h - 1; 
            *ip3 = slen; 
            memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
            IPC.n += 2; 
            goto TOP; 
        case 108:               /* S-str = S-str1{S-int..}            */ 
            ip3 = *(*IPC.q); 
            sp1 = (char *) (ip3 + 1); 
            mlen = *(*IPC.p + 1); 
            ip4  = *(*(IPC.q+1)); 
            slen = *ip4; 
            sp2 = (char *)(ip4+1); 
            h = *(*(IPC.p+2)); 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, IPC, 1); 
            } 
            sp2  += h - 1; 
            slen -= h - 1; 
            if (slen > mlen)  strlenerr(slen, mlen, IPC, 0); 
            *ip3 = slen; 
            memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
            IPC.n += 3; 
            goto TOP; 
        case 109:               /* S-str = A-str1{S-int..}            */ 
            ip3 = *(*IPC.q); 
            sp1 = (char *) (ip3 + 1); 
            mlen = *(*IPC.p + 1); 
            TIPC.n = IPC.n++; 
            ZidA_str(&ip4, &h, 1); 
            slen = *ip4; 
            sp2 = (char *)(ip4+1); 
            h = *(*IPC.p); 
            ++IPC.n; 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, TIPC, 1); 
            } 
            sp2  += h - 1; 
            slen -= h - 1; 
            if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            *ip3 = slen; 
            memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
            goto TOP; 
        case 110:               /* S-str = S-str (//)                 */ 
            ip3 = *(*IPC.q); 
            sp1 = (char *) (ip3 + 1); 
            mlen = *(*IPC.p + 1); 
            TIPC.n = IPC.n++; 
            slen = *ip3; 
            nxop = *IPC.n >> 16; 
            ++IPC.n; 
            sp1 += slen; 
            Zappendstr(sp1, mlen, &slen, nxop, TIPC); 
            *ip3 = slen; 
            goto TOP; 
        case 111:               /* S-str = general string // S-str    */ 
            ip3 = *(*IPC.q); 
            sp1 = (char *) (ip3 + 1); 
            mlen = *(*IPC.p + 1); 
            TIPC.n = IPC.n++; 
            h = *ip3; 
            Zidsubstr(&sp2, &slen, &nxop, &i); 
            if (slen + h > mlen)  strlenerr(slen+h, mlen, TIPC, 0); 
            sp3 = sp1 + slen; 

            if (h > 15)  { 
                ip1 = (long *) (sp3 + h - 4); 
                ip2 = (long *) (sp1 + h - 4); 
                g = (h + 3) >> 2; 
                for (i = 0; i < g; ++i)  { 
                    *ip1-- = *ip2--; 
                } 
                memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
                *ip3 = slen + h; 
                goto TOP; 
            } 

            for (i = h - 1; i >= 0; --i)  { 
                *(sp3+i) = *(sp1+i); 
            } 
            memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
            *ip3 = slen + h; 
            goto TOP; 
        case 112:               /* S-str = general string (//)        */ 
            ip3 = *(*IPC.q); 
            sp1 = (char *) (ip3 + 1); 
            mlen = *(*IPC.p + 1); 
            TIPC.n = IPC.n++; 
            Zidsubstr(&sp2, &slen, &nxop, &i);
            if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            if (sp1 != sp2)  { 
                memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
            } 
            *ip3 = slen; 
            if (nxop == 0)  goto TOP; 
            sp1 += slen; 
            Zappendstr(sp1, mlen, &slen, nxop, TIPC); 
            *ip3 = slen; 
            goto TOP; 
        case 113:               /* S-str = gen str (complex //)       */ 
            TIPC.n = IPC.n; 
            mlen = *(*IPC.p + 1); 
            if (mlen < LENG1)  goto A113A;   /* use copy method */ 
        /* first try the shift method */ 
            vid1 = *(*IPC.q); 
            ++IPC.n; 
            v2cnt = 0; 
            h = 0;                  /* h = target counter */ 
            Zckgenstr(&vid2, &vp3, &k, &nxop); 
            if (vid2 == vid1)  { 
                IPC.n = TIPC.n; 
                goto A113A;  
            } 
            vp2[0] = vp3; 
            vlen2[0] = k; 
            vpro2[0] = 1;           /* process = direct */ 
            ++v2cnt; 
            slen = k;               /* slen = length accumulator */ 
            g = 0;                  /* g = offset in ztv.zmaxtemp     */ 
            xxcnt = -1;             /* no match is possible      */ 
            while (nxop > 0)  { 
                Zckstrx(&vid2, &vp3, &k, &nxop, &j, &g); 
                if (j == 10)  {           /* replace function means we must 
                                                 use copy method */ 
                    IPC.n = TIPC.n; 
                    goto A113A; 
                } 
                if (vid2 == vid1) { 
                    ++h; 
                    if (h > 1)  {         /* more than one occurance of LHS 
                                             means we must use copy method */ 
                        IPC.n = TIPC.n; 
                        goto A113A; 
                    } 
                    xxcnt = v2cnt; 
                } 
                vp2[v2cnt]   = vp3; 
                vlen2[v2cnt] = k; 
                vpro2[v2cnt] = j; 
                ++v2cnt; 
                if (j == 2 || j == 3)  { 
                    if (h > 0)  {         /* use copy method */ 
                        IPC.n = TIPC.n; 
                        goto A113A; 
                    } 
                    if (slen < k)  slen = k; 
                } 
                else  { 
                    slen += k; 
                } 
                if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            } 
        /* put in length */ 
            *vid1++ = slen; 
        /* construct concatenated string: sp1 set at "front end" */ 
            sp1 = (char *) vid1; 
            pcatstr(v2cnt, xxcnt, sp1, vp2, vlen2, vpro2); 
            goto TOP; 
        case 114:               /* S-str = function (//)              */ 
            ip3 = *(*IPC.q); 
            sp1 = (char *) (ip3 + 1); 
            mlen = *(*IPC.p + 1); 
            TIPC.n = IPC.n++; 
            slen = 0; 
            Zappstrfun(sp1, &h, mlen, &slen, &nxop, TIPC); 
            *ip3 = slen; 
            if (nxop == 0)  goto TOP; 
            sp1 += slen; 
            Zappendstr(sp1, mlen, &slen, nxop, TIPC); 
            *ip3 = slen; 
            goto TOP;
        case 115:               /* S-str = function (complex //)      */ 
            TIPC.n = IPC.n; 
            mlen = *(*IPC.p + 1); 
            if (mlen < LENG1)  goto A115A;    /* use copy method */ 
        /* first try the shift method */ 
            vid1 = *(*IPC.q); 
            ++IPC.n; 
        /* (1) check for LHS string as argument to first function */ 
            fna  = *(IPC.n) & 0xffff;        /* function number */ 
            nxop = *(IPC.n) >> 16;           /* and next op     */ 
            ++IPC.n;
            h = 0;                           /* h = target counter */ 
            xxcnt = -1;             /* postulate no match is possible */ 
            switch (fna)  { 
                case TRMS: 
                case MRTS: 
                case LCS: 
                case UCS: 
                case REVS: 
                case DUPS: 
                    pt.n = IPC.n; 
                    Zckgenstr(&vid2, &vp3, &k, &k);       /* 4th variable WAS &nxop
                                                          changed to &k &dA10-26-94&d@  */
                    IPC.n = pt.n; 
                    if (vid2 == vid1)  { 
                        if (fna != REVS)  {  /* use copy method */ 
                            IPC.n = TIPC.n; 
                            goto A115A;  
                        } 
                        else  { 
                            h = 1;         /* target counter = 1 */ 
                            xxcnt = 0;     /* match on first element */ 
                        } 
                    } 
                    break; 
                case RPL:     /* replace function must use copy method */ 
                    IPC.n = TIPC.n; 
                    goto A115A; 
                default: 
                    break; 
            } 
            v2cnt = 0; 
            g = 0; 
            Zckstrfun(fna, &vid2, &vp3, &k, &j, &g); 
            vp2[0] = vp3; 
            vlen2[0] = k; 
            vpro2[0] = j; 
            slen = k;               /* slen = length accumulator */ 
            ++v2cnt; 
            while (nxop > 0)  { 
                Zckstrx(&vid2, &vp3, &k, &nxop, &j, &g); 
                if (j == 10)  {           /* replace function means we must 
                                                 use copy method */ 
                    IPC.n = TIPC.n; 
                    goto A115A; 
                } 
                if (vid2 == vid1) { 
                    ++h; 
                    if (h > 1)  {         /* more than one occurance of LHS 
                                             means we must use copy method */ 
                        IPC.n = TIPC.n; 
                        goto A115A; 
                    } 
                    xxcnt = v2cnt; 
                } 
                vp2[v2cnt]   = vp3; 
                vlen2[v2cnt] = k; 
                vpro2[v2cnt] = j; 
                ++v2cnt; 
                if (j == 2 || j == 3)  { 
                    if (h > 0)  {         /* use copy method */ 
                        IPC.n = TIPC.n; 
                        goto A115A; 
                    } 
                    if (slen < k)  slen = k; 
                } 
                else  { 
                    slen += k; 
                } 
                if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            } 
        /* put in length */ 
            *vid1++ = slen; 
            sp1 = (char *) vid1; 
        /* construct concatenated string: sp1 set at "front end" */ 
            pcatstr(v2cnt, xxcnt, sp1, vp2, vlen2, vpro2); 
            goto TOP; 
        case 116:               /* S-str{S-int} = "x"                 */ 
            ip3 = *(*IPC.q); 
            sp2 = (char *) (ip3 + 1); 
            slen = *ip3; 
            h = *(*(IPC.p+1)); 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, IPC, 1); 
            } 
            sp2 += h - 1; 
            *sp2 = *(IPC.n+2);        /* Intel 386 dependent */ 
            IPC.n += 3;  
            goto TOP;  
        case 117:               /* S-str{...} = str/func (//)         */ 
        case 118:               /* S-str{...} = str/func (complex //) */ 
        case 147:               /* A-str{...} = str/func (//)         */ 
        case 148:               /* A-str{...} = str/func (complex //) */ 
            TIPC.n = IPC.n; 
            if (instr > 130) { 
                ZidA_str(&ip3, &i, 2); 
                IPC.n = TIPC.n; 
            } 
            Zidgenstr(&vid1, &mlen, &off1, &off2, &h, &kk, 1L); 
            sp1 = ztv.zmaxtemp; 
        /* construct insertion in temporary work space */ 
            slen = 0; 
            f = maxstringlen + 0x40000000; 
            Zappstrfun(sp1, &h, f, &slen, &nxop, TIPC); 
            if (nxop != 0) { 
                sp1 += slen; 
                Zappendstr(sp1, f, &slen, nxop, TIPC); 
            } 
        /* check for warning */ 
            f = off2 - off1 + 1; 
            if (slen != f && (ztv.zoperationflag & 0x40) != 0)  { 
                strwarn1(slen, f, TIPC.n, *TIPC.p); 
            } 
        /* check for length exceeding maximum */ 
            k = *vid1 - f + slen; 
            if (k > mlen)  strlenerr(k, mlen, TIPC, 0); 
        /* shift tail end of string           */ 
            if (slen != f) { 
                sp2 = (char *) (vid1 + 1) + off2 + 1; 
                sp1 = sp2 + slen - f; 
                h = *vid1 - off2 - 1; 

                if (slen > f)  { 
                    if (h > 15)  { 
                        ip1 = (long *) (sp1 + h - 4); 
                        ip2 = (long *) (sp2 + h - 4); 
                        g   = h >> 2; 
                        for (i = 0; i < g; ++i)  { 
                            *ip1-- = *ip2--; 
                        } 
                        j = h - (g << 2); 
                        for (i = j - 1; i >= 0; --i) { 
                            *(sp1+i) = *(sp2+i); 
                        } 
                    } 
                    else { 
                        for (i = h - 1; i >= 0; --i)  { 
                            *(sp1+i) = *(sp2+i); 
                        } 
                    } 
                } 
                else  { 
                    memcpy((void *) sp1, (const void *) sp2, (size_t) h); 
                } 

            } 
        /* insert temporary string          */ 
            *vid1 = k; 
            sp1 = (char *) (vid1 + 1) + off1; 
            memcpy((void *) sp1, 
                    (const void *) ztv.zmaxtemp, (size_t) slen); 
            goto TOP; 
        case 119:               /* len(S-str) = exp                   */ 
            ip3 = *(*IPC.q); 
            mlen = *(*IPC.p + 1); 
            TIPC.n = IPC.n++; 
            slen = Zgenintex(); 
            if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            *ip3 = slen; 
            goto TOP; 
        case 131:               /* A-str = "" (0 bytes)               */ 
            ZidA_str(&ip3, &mlen, 1); 
            *ip3 = 0; 
            goto TOP; 
        case 132:               /* A-str = "...", S-str1 (no subs)    */ 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            sp1 = (char *) (ip3 + 1); 
            ip4  = *(*IPC.q); 
            ++IPC.n; 
            slen = *ip4; 
            sp2  = (char *)(ip4+1); 
            if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            *ip3 = slen; 
            memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
            goto TOP; 
        case 133:               /* A-str = A-str1 (no subs)           */ 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            sp1 = (char *) (ip3 + 1); 
            ZidA_str(&ip4, &h, 1); 
            slen = *ip4; 
            sp2  = (char *)(ip4+1); 
            if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            *ip3 = slen; 
            memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
            goto TOP; 
        case 134:               /* A-str = A-str{#..}                 */ 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            sp1 = (char *) (ip3 + 1); 
            slen = *ip3; 
            h = *IPC.n++; 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, TIPC, 1); 
            } 
            sp2  = sp1 + h - 1; 
            slen -= h - 1; 
            *ip3 = slen; 
            memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
            goto TOP; 
        case 135:               /* A-str = S-str1{#..}                */ 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            sp1 = (char *) (ip3 + 1); 
            ip4  = *(*IPC.q); 
            slen = *ip4; 
            sp2 = (char *)(ip4+1); 
            h = *(IPC.n+1); 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, TIPC, 1); 
            } 
            sp2  += h - 1; 
            slen -= h - 1; 
            if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            *ip3 = slen; 
            memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
            IPC.n += 2;  
            goto TOP; 
        case 136:               /* A-str = A-str1{#..}                */ 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            sp1 = (char *) (ip3 + 1); 
            ZidA_str(&ip4, &h, 1); 
            slen = *ip4; 
            sp2 = (char *)(ip4+1); 
            h = *IPC.n++; 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, TIPC, 1); 
            } 
            sp2  += h - 1; 
            slen -= h - 1; 
            if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            *ip3 = slen; 
            memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
            goto TOP; 
        case 137:               /* A-str = A-str{S-int..}             */ 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            sp1 = (char *) (ip3 + 1); 
            slen = *ip3; 
            h = *(*IPC.p); 
            ++IPC.n; 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, TIPC, 1); 
            } 
            sp2  = sp1 + h - 1; 
            slen -= h - 1; 
            *ip3 = slen; 
            memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
            goto TOP; 
        case 138:               /* A-str = S-str1{S-int..}            */ 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            sp1 = (char *) (ip3 + 1); 
            ip4  = *(*IPC.q); 
            slen = *ip4; 
            sp2 = (char *)(ip4+1); 
            h = *(*(IPC.p+1)); 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, TIPC, 1); 
            } 
            sp2  += h - 1; 
            slen -= h - 1; 
            if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            *ip3 = slen; 
            memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
            IPC.n += 2; 
            goto TOP; 
        case 139:               /* A-str = A-str1{S-int..}            */ 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            sp1 = (char *) (ip3 + 1); 
            ZidA_str(&ip4, &h, 1); 
            slen = *ip4++; 
            sp2 = (char *) ip4; 
            h = *(*IPC.p); 
            ++IPC.n; 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, TIPC, 1); 
            } 
            sp2  += h - 1; 
            slen -= h - 1; 
            if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            *ip3 = slen; 
            memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
            goto TOP; 
        case 140:               /* A-str = A-str (//)                 */ 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            sp1 = (char *) (ip3 + 1); 
            slen = *ip3; 
            nxop = *IPC.n >> 16; 
            ++IPC.n; 
            sp1 += slen; 
            Zappendstr(sp1, mlen, &slen, nxop, TIPC); 
            *ip3 = slen; 
            goto TOP; 
        case 141:               /* A-str = general string // A-str    */ 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            sp1 = (char *) (ip3 + 1); 
            h = *ip3; 
            Zidsubstr(&sp2, &slen, &nxop, &i); 
            if (slen + h > mlen)  strlenerr(slen+h, mlen, TIPC, 0); 
            sp3 = sp1 + slen; 

            if (h > 15)  { 
                ip1 = (long *) (sp3 + h - 4); 
                ip2 = (long *) (sp1 + h - 4); 
                g = (h + 3) >> 2; 
                for (i = 0; i < g; ++i)  { 
                    *ip1-- = *ip2--; 
                } 
                memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
                *ip3 = slen + h; 
                goto TOP; 
            } 

            for (i = h - 1; i >= 0; --i)  { 
                *(sp3+i) = *(sp1+i); 
            } 
            memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
            *ip3 = slen + h; 
            goto TOP; 
        case 142:               /* A-str = general string (//)        */ 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            sp1 = (char *) (ip3 + 1); 
            Zidsubstr(&sp2, &slen, &nxop, &i); 
            if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            if (sp1 != sp2)  { 
                memcpy((void *) sp1, (const void *) sp2, (size_t) slen); 
            } 
            *ip3 = slen; 
            if (nxop == 0)  goto TOP; 
            sp1 += slen; 
            Zappendstr(sp1, mlen, &slen, nxop, TIPC); 
            *ip3 = slen; 
            goto TOP; 
        case 143:               /* A-str = gen str (complex //)       */ 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            TIPC2.n = IPC.n; 
            if (mlen < LENG1)  goto A143A;   /* use copy method */ 
        /* first try the shift method */ 
            vid1 = ip3; 
            v2cnt = 0; 
            h = 0;                  /* h = target counter */ 
            Zckgenstr(&vid2, &vp3, &k, &nxop); 
            if (vid2 == vid1)  { 
                IPC.n = TIPC2.n; 
                goto A143A;  
            } 
            vp2[0] = vp3; 
            vlen2[0] = k; 
            vpro2[0] = 1;           /* process = direct */ 
            ++v2cnt; 
            slen = k;               /* slen = length accumulator */ 
            g = 0;                  /* g = offset in ztv.zmaxtemp     */ 
            xxcnt = -1;             /* no match is possible      */ 
            while (nxop > 0)  { 
                Zckstrx(&vid2, &vp3, &k, &nxop, &j, &g); 
                if (j == 10)  {           /* replace function means we must 
                                                 use copy method */ 
                    IPC.n = TIPC2.n; 
                    goto A143A; 
                } 
                if (vid2 == vid1) { 
                    ++h; 
                    if (h > 1)  {         /* more than one occurance of LHS 
                                             means we must use copy method */ 
                        IPC.n = TIPC2.n; 
                        goto A143A; 
                    } 
                    xxcnt = v2cnt; 
                } 
                vp2[v2cnt]   = vp3; 
                vlen2[v2cnt] = k; 
                vpro2[v2cnt] = j; 
                ++v2cnt; 
                if (j == 2 || j == 3)  { 
                    if (h > 0)  {         /* use copy method */ 
                        IPC.n = TIPC2.n; 
                        goto A143A; 
                    } 
                    if (slen < k)  slen = k; 
                } 
                else  { 
                    slen += k; 
                } 
                if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            } 
        /* put in length */ 
            *ip3 = slen; 
        /* construct concatenated string: sp1 set at "front end" */ 
            sp1 = (char *) (ip3 + 1); 
            pcatstr(v2cnt, xxcnt, sp1, vp2, vlen2, vpro2); 
            goto TOP; 
        case 144:               /* A-str = function (//)              */ 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            sp1 = (char *) (ip3 + 1); 
            slen = 0; 
            Zappstrfun(sp1, &h, mlen, &slen, &nxop, TIPC); 
            *ip3 = slen; 
            if (nxop == 0)  goto TOP; 
            sp1 += slen; 
            Zappendstr(sp1, mlen, &slen, nxop, TIPC); 
            *ip3 = slen; 
            goto TOP;
        case 145:               /* A-str = function (complex //)      */ 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            TIPC2.n = IPC.n; 
            if (mlen < LENG1)  goto A145A;    /* use copy method */ 
        /* first try the shift method */ 
            vid1 = ip3; 
        /* (1) check for LHS string as argument to first function */ 
            nxop = *IPC.n++; 
            fna  = nxop & 0xffff;            /* function number */ 
            nxop >>= 16;                     /* and next op     */ 
            h = 0;                           /* h = target counter */ 
            xxcnt = -1;             /* postulate no match is possible */ 

            switch (fna)  { 
                case TRMS: 
                case MRTS: 
                case LCS: 
                case UCS: 
                case REVS: 
                case DUPS: 
                    pt.n = IPC.n; 
                    Zckgenstr(&vid2, &vp3, &k, &k);          /* 4th variable WAS &nxop
                                                             changed to &k &dA10-26-94&d@  */
                    IPC.n = pt.n; 
                    if (vid2 == vid1)  { 
                        if (fna != REVS)  {  /* use copy method */ 
                            IPC.n = TIPC2.n; 
                            goto A145A;  
                        } 
                        else  { 
                            h = 1;         /* target counter = 1 */ 
                            xxcnt = 0;     /* match on first element */ 
                        } 
                    } 
                    break; 
                case RPL:     /* replace function must use copy method */ 
                    IPC.n = TIPC2.n; 
                    goto A145A; 
                default: 
                    break; 
            } 
            v2cnt = 0; 
            g = 0; 
            Zckstrfun(fna, &vid2, &vp3, &k, &j, &g); 
            vp2[0] = vp3; 
            vlen2[0] = k; 
            vpro2[0] = j; 
            slen = k;               /* slen = length accumulator */ 
            ++v2cnt; 
            while (nxop > 0)  { 
                Zckstrx(&vid2, &vp3, &k, &nxop, &j, &g); 
                if (j == 10)  {           /* replace function means we must 
                                                 use copy method */ 
                    IPC.n = TIPC2.n; 
                    goto A145A; 
                } 
                if (vid2 == vid1) { 
                    ++h; 
                    if (h > 1)  {         /* more than one occurance of LHS 
                                             means we must use copy method */ 
                        IPC.n = TIPC2.n; 
                        goto A145A; 
                    } 
                    xxcnt = v2cnt; 
                } 
                vp2[v2cnt]   = vp3; 
                vlen2[v2cnt] = k; 
                vpro2[v2cnt] = j; 
                ++v2cnt; 
                if (j == 2 || j == 3)  { 
                    if (h > 0)  {         /* use copy method */ 
                        IPC.n = TIPC2.n; 
                        goto A145A; 
                    } 
                    if (slen < k)  slen = k; 
                } 
                else  { 
                    slen += k; 
                } 
                if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            } 
        /* put in length */ 
            *ip3 = slen; 
            sp1 = (char *) (ip3 + 1); 
        /* construct concatenated string: sp1 set at "front end" */ 
            pcatstr(v2cnt, xxcnt, sp1, vp2, vlen2, vpro2); 
            goto TOP; 
        case 146:               /* A-str{S-int} = "x"                 */ 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            sp2 = (char *) (ip3 + 1); 
            slen = *ip3; 
            h = *(*IPC.p); 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, TIPC, 1); 
            } 
            sp2 += h - 1; 
            *sp2 = *(IPC.n+1);        /* Intel 386 dependent */ 
            IPC.n += 2; 
            goto TOP;  
        case 149:               /* len(A-str) = exp                   */ 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            slen = Zgenintex(); 
            if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            *ip3 = slen; 
            goto TOP; 

/*  BITSTRS  */ 
        case 201:               /* S-bstr = "" (no bits)              */ 
            *(*(*IPC.q)) = 0; 
            ++IPC.n; 
            goto TOP; 
        case 202:               /* S-bstr = "..." (1 <= len <= 64)    */ 
            ip3 = *(*IPC.q); 
            mlen = *(*IPC.p + 1); 
            slen = *(IPC.n+1); 
            if (slen > mlen)  strlenerr(slen, mlen, IPC, 0); 
            *(ip3+1) = *(IPC.n+2); 
            if (slen > 32)  { 
                *(ip3+2) = *(IPC.n+3); 
            } 
            *ip3 = slen; 
            IPC.n += 4; 
            goto TOP; 
        case 203:               /* S-bstr = [ ]                       */ 
            ip3 = *(*IPC.q); 
            sp1 = (char *) (ip3 + 1); 
            mlen = *(*IPC.p + 1); 
            if (256 > mlen)  strlenerr(256, mlen, IPC, 0); 
            sp2 = (char *) (*(IPC.p+1)); 
            memcpy((void *) sp1, (const void *) sp2, (size_t) 32); 
            *ip3 = 256; 
            IPC.n += 2; 
            goto TOP; 
        case 204:               /* S-bstr = "...", S-bstr1 (no subs)  */ 
            ip3 = *(*IPC.q); 
            sp1 = (char *) (ip3 + 1); 
            mlen = *(*IPC.p + 1); 
            ip4  = *(*(IPC.q+1)); 
            slen = *ip4; 
            sp2  = (char *)(ip4+1); 
            if (slen > mlen)  strlenerr(slen, mlen, IPC, 0); 
            *ip3 = slen; 

        /* &dAThis code is logically incorrect for the Intel x86 processor&d@ 
            h = (slen + 7) >> 3; 
            memcpy((void *) sp1, (const void *) sp2, (size_t) h); 
            &dA    &d@ */ 

        /* &dACorrection added 11-20-92&d@ */ 

            h = (slen + 31) >> 5; 
            h <<= 2;               /* guarenteed to be mult of 4 */ 
            memcpy((void *) sp1, (const void *) sp2, (size_t) h); 

        /*                           */ 

            IPC.n += 2; 
            goto TOP; 
        case 205:               /* S-bstr = A-bstr1 (no subs)         */ 
            ip3 = *(*IPC.q); 
            sp1 = (char *) (ip3 + 1); 
            mlen = *(*IPC.p + 1); 
            TIPC.n = IPC.n++; 
            ZidA_bstr(&ip4, &h, 1L); 
            slen = *ip4; 
            sp2  = (char *)(ip4+1); 
            if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            *ip3 = slen; 

        /* &dAThis code is logically incorrect for the Intel x86 processor&d@   
            h = (slen + 7) >> 3; 
            memcpy((void *) sp1, (const void *) sp2, (size_t) h); 
            &dA    &d@ */ 

        /* &dACorrection added 11-20-92&d@ */ 

            h = (slen + 31) >> 5; 
            h <<= 2;               /* guarenteed to be mult of 4 */ 
            memcpy((void *) sp1, (const void *) sp2, (size_t) h); 

        /*                           */ 

            goto TOP; 
        case 206:               /* S-bstr{#} = "0"                    */ 
            ip3 = *(*IPC.q); 
            h = *(IPC.n+1); 
            slen = *ip3; 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, IPC, 1); 
            } 
            --h; 
            k = h >> 5; 
            h -= k << 5; 
            *(ip3+k+1) &= andbitflag[h];  /* turn off bit h of word k */ 
            IPC.n += 2;  
            goto TOP; 
        case 207:               /* S-bstr{S-int} = "0"                */ 
            ip3 = *(*IPC.q); 
            h = *(*(IPC.p+1)); 
            slen = *ip3; 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, IPC, 1); 
            } 
            --h; 
            k = h >> 5; 
            h -= k << 5; 
            *(ip3+k+1) &= andbitflag[h];  /* turn off bit h of word k */ 
            IPC.n += 2;  
            goto TOP; 
        case 208:               /* S-bstr{sub-exp} = "0"              */ 
            ip3 = *(*IPC.q); 
            TIPC.n = IPC.n++; 
            Zevsub(&h); 
            slen = *ip3; 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, TIPC, 1); 
            } 
            --h; 
            k = h >> 5; 
            h -= k << 5; 
            *(ip3+k+1) &= andbitflag[h];  /* turn off bit h of word k */ 
            goto TOP; 
        case 209:               /* S-bstr{#} = "1"                    */ 
            ip3 = *(*IPC.q); 
            h = *(IPC.n+1); 
            slen = *ip3; 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, IPC, 1); 
            } 
            --h; 
            k = h >> 5; 
            h -= k << 5; 
            *(ip3+k+1) |= orbitflag[h];   /* turn on  bit h of word k */ 
            IPC.n += 2;  
            goto TOP; 
        case 210:               /* S-bstr{S-int} = "1"                */ 
            ip3 = *(*IPC.q); 
            h = *(*(IPC.p+1)); 
            slen = *ip3; 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, IPC, 1); 
            } 
            --h; 
            k = h >> 5; 
            h -= k << 5; 
            *(ip3+k+1) |= orbitflag[h];   /* turn on  bit h of word k */ 
            IPC.n += 2;  
            goto TOP; 
        case 211:               /* S-bstr{sub-exp} = "1"              */ 
            ip3 = *(*IPC.q); 
            TIPC.n = IPC.n++; 
            Zevsub(&h); 
            slen = *ip3; 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, TIPC, 1); 
            } 
            --h; 
            k = h >> 5; 
            h -= k << 5; 
            *(ip3+k+1) |= orbitflag[h];   /* turn on  bit h of word k */ 
            goto TOP; 
        case 212:               /* S-bstr = S-bstr (//)               */ 
            ip3 = *(*IPC.q); 
            mlen = *(*IPC.p + 1); 
            TIPC.n = IPC.n++; 
            slen = *ip3; 
            nxop = *IPC.n >> 16; 
            ++IPC.n; 
            h = slen; 
            k = h >> 5; 
            h -= k << 5; 
            Zappbstr(ip3+k+1, h, mlen, &slen, nxop, TIPC); 
            *ip3 = slen; 
            goto TOP; 
        case 213:               /* S-bstr = general string // S-bstr  */ 
            ip3 = *(*IPC.q); 
            mlen = *(*IPC.p + 1); 
            TIPC.n = IPC.n++; 
            ip1 = ip3 + 1; 
            h = *ip3; 
            Zidsubbitstr(&ip2, &f, &slen, &i); 
            if (slen == 0)  goto TOP; 
            if (slen + h > mlen)  strlenerr(slen+h, mlen, TIPC, 0); 
        /* shift bstr and insert (right to left)  */ 
            if (h > 0)  { 
                k = h >> 5; 
                g = h - (k << 5); 
                ip5 = ip1 + k; 
                off2 = (k << 5) + slen; 
                j = off2 >> 5;         
                off2 -= j << 5;            /* 0 <= off2 <= 31 */ 
                ip4 = ip1 + j; 
                if (off2 + g <= 32) { 
                    --ip5; 
                    --ip4; 
                } 
            /* shift blocks */ 
                a = 32 - off2; 
                while (ip3 >= ip1) { 
                    if (off2 == 0)  { 
                        j = 0; 
                    } 
                    else  { 
                        j = *ip5 << a; 
                    } 
                    ui = *(ip5 + 1); 
                    j += ui >> off2;       /* 0 <= off2 <= 31 */ 
                    *(ip4+1) = j; 
                    --ip4; 
                    --ip5; 
                } 
            /* shift head */ 
                ui = *ip1; 
                j = ui >> off2;            /* 0 <= off2 <= 31 */ 
                *(ip4+1) = 0; 
            } 
        /* insert leading string */ 
            k = 0; 
            work_around_1(ip1, &i, ip2, slen, &k, f, 1); 
            if (h > 0)  { 
                *(ip4 + 1) |= j; 
            } 
            *ip3 = slen + h; 
            goto TOP; 
        case 214:               /* S-bstr = general bstr (//)         */ 
            ip3 = *(*IPC.q); 
            mlen = *(*IPC.p + 1); 
            TIPC.n = IPC.n++; 
            ip1 = ip3 + 1; 
            Zidsubbitstr(&ip2, &f, &slen, &nxop); 
            if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            h = 0; 
            work_around_1(ip1, &i, ip2, slen, &h, f, 1); 
            if (nxop == 0) { 
                *ip3 = slen; 
                goto TOP;
            } 
            ip1 += i; 
            Zappbstr(ip1, h, mlen, &slen, nxop, TIPC); 
            *ip3 = slen; 
            goto TOP; 
        case 215:               /* S-bstr = gen bstr (complex //)     */ 
            TIPC.n = IPC.n; 
            mlen = *(*IPC.p + 1); 
            goto A215A; 
        case 216:               /* S-bstr = function (//)             */ 
            ip3 = *(*IPC.q); 
            ip1 = ip3 + 1; 
            mlen = *(*IPC.p + 1); 
            TIPC.n = IPC.n++; 
            slen = 0; 
            off1 = 0; 
            Zappbfun(ip1, off1, &h, mlen, &slen, &nxop, TIPC); 
            if (nxop == 0) { 
                *ip3 = slen; 
                goto TOP; 
            } 
            off1 += h; 
            k = off1 >> 5; 
            off1 -= k << 5; 
            Zappbstr(ip1+k, off1, mlen, &slen, nxop, TIPC); 
            *ip3 = slen; 
            goto TOP; 
        case 217:               /* S-bstr = function (complex //)     */ 
            TIPC.n = IPC.n; 
            mlen = *(*IPC.p + 1); 
            goto A217A; 
        case 218:               /* S-bstr{...} = bstr/func (//)          */ 
        case 219:               /* S-bstr{...} = bstr/func (complex //)  */ 
        case 248:               /* A-bstr{...} = bstr/func (//)          */ 
        case 249:               /* A-bstr{...} = bstr/func (complex //)  */ 
            TIPC.n = IPC.n; 
            if (instr > 230) { 
                ZidA_bstr(&ip3, &a, 2); 
                IPC.n = TIPC.n; 
            } 
            Zidgenstr(&vid1, &mlen, &off1, &off2, &h, &kk, 2L); 
            ip1 = (long *) ztv.zmaxtemp; 
        /* construct insertion in temporary work space */ 
            slen = 0; 
            off3 = 0; 
            f = maxstringlen << 3; 
            f += 0x40000000;                 /* special flag */ 
            Zappbfun(ip1, off3, &h, f, &slen, &nxop, TIPC); 
            if (nxop != 0) { 
                off3 += h; 
                k = off3 >> 5; 
                off3 -= k << 5; 
                ip1 += k; 
                Zappbstr(ip1, off3, f, &slen, nxop, TIPC); 
            } 
        /* check for warning */ 
            f = off2 - off1 + 1; 
            if (slen != f && (ztv.zoperationflag & 0x40) != 0)  { 
                strwarn1(slen, f, TIPC.n, *TIPC.p); 
            } 
        /* check for length exceeding maximum */ 
            flen = *vid1 - f + slen; 
            if (flen > mlen)  strlenerr(flen, mlen, TIPC, 0); 
        /* shift tail end of string           */ 
            if (slen != f) { 
                off4 = off2 + 1;               /* source      */ 
                off3 = off4 + slen - f;        /* destination */ 
                h    = off4 >> 5; 
                off4 -= h << 5; 
                ip4  = vid1 + 1 + h;           /* source      */ 
                h    = off3 >> 5; 
                off3 -= h << 5;                /* 0 <= off3 <= 31 */ 
                ip3  = vid1 + 1 + h;           /* destination */ 
                h    = *vid1 - off4;           /* length      */ 
                if (slen > f)  { 
                    if (h <= 32)  {   /* use brute force */ 
                        bits_right_shift(ip3, off3, ip4, off4, h); 
                    } 
                    else { 
                        f = 0; 
                        if (off4 != 0)  {   /* strip off leading bits */ 
                            ip5 = ip3; 
                            ip6 = ip4; 
                            off5 = off3; 
                            off6 = off4;    /* save pointers */ 
                            f = 32 - off4;  /* f = len(leading bits)  */ 
                            ++ip4; 
                            off4 = 0; 
                            off3 += f; 
                            if (off3 > 31)  { 
                                off3 -= 32;         /* 0 <= off3 <= 31 */ 
                                ++ip3; 
                            } 
                            h -= f; 
                        } 
                  /* shift bstr (right to left)  */ 
                        k   = h >> 5; 
                        g   = h - (k << 5); 
                        ip2 = ip4 + k; 
                        ip1 = ip3 + k; 
                        if (off3 + g <= 32)  { 
                            --ip1; 
                            --ip2; 
                        } 
                    /* shift blocks */ 
                        a = 32 - off3;              /* 0 <= off3 <= 31 */ 
                        while (ip2 >= ip4) { 
                            if (off3 == 0)  { 
                                j = 0; 
                            } 
                            else  { 
                                j = *ip2 << a; 
                            } 
                            ui   = *(ip2 + 1); 
                            j   += ui >> off3;      /* 0 <= off3 <= 31 */ 
                            *(ip1+1) = j; 
                            --ip1; 
                            --ip2; 
                        } 
                    /* construct and insert head  */ 
                        ui   = *ip4; 
                        j    = ui >> off3;          /* 0 <= off3 <= 31 */ 
                        if (off3 == 0)  { 
                            a = 0; 
                        } 
                        else  { 
                            a = (0xffffffff << (32 - off3)); 
                        } 
                        *(ip1+1) &= a;         /* clear space */ 
                        *(ip1+1) |= j;         /* insert head */ 
                  /* insert leading bits          */ 
                        if (f > 0) { 
                            bits_right_shift(ip5, off5, ip6, off6, f); 
                        } 
                    } 
                } 
                else { 
                    work_around_1(ip3, &i, ip4, h, &off3, off4, 1); 
                } 
            } 
        /* insert temporary string             */ 
            *vid1 = flen; 
            k     = off1 >> 5; 
            off1 -= k << 5; 
            ip1   = vid1 + 1 + k; 
            ip2   = (long *) ztv.zmaxtemp; 
            work_around_1(ip1, &i, ip2, slen, &off1, 0, 1); 
            goto TOP; 
        case 231:               /* A-bstr = "" (no bits)              */ 
            ZidA_bstr(&ip3, &mlen, 1); 
            *ip3 = 0; 
            goto TOP; 
        case 232:               /* A-bstr = "..." (1 <= len <= 64)    */ 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            slen = *IPC.n++; 
            if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            *(ip3+1) = *IPC.n++; 
            if (slen > 32)  { 
                *(ip3+2) = *IPC.n; 
            } 
            ++IPC.n; 
            *ip3 = slen; 
            goto TOP; 
        case 233:               /* A-bstr = [ ]                       */ 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            sp1 = (char *) (ip3 + 1); 
            if (256 > mlen)  strlenerr(256, mlen, TIPC, 0); 
            sp2 = (char *) (*IPC.p); 
            memcpy((void *) sp1, (const void *) sp2, (size_t) 32); 
            ++IPC.n;
            *ip3 = 256; 
            goto TOP; 
        case 234:               /* A-bstr = "...", S-bstr1 (no subs)  */ 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            sp1 = (char *) (ip3 + 1); 
            ip4  = *(*IPC.q++); 
            slen = *ip4; 
            sp2  = (char *)(ip4+1); 
            if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            *ip3 = slen; 

        /* &dAThis code is logically incorrect for the Intel x86 processor&d@ 
            h = (slen + 7) >> 3; 
            memcpy((void *) sp1, (const void *) sp2, (size_t) h); 
            &dA    &d@ */ 

        /* &dACorrection added 11-20-92&d@ */ 

            h = (slen + 31) >> 5; 
            h <<= 2;               /* guarenteed to be mult of 4 */ 
            memcpy((void *) sp1, (const void *) sp2, (size_t) h); 

        /*                           */ 

            goto TOP; 
        case 235:               /* A-bstr = A-bstr1 (no subs)         */ 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            sp1 = (char *) (ip3 + 1); 
            ZidA_bstr(&ip4, &h, 1L); 
            slen = *ip4; 
            sp2  = (char *)(ip4+1); 
            if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            *ip3 = slen; 

        /* &dAThis code is logically incorrect for the Intel x86 processor&d@ 
            h = (slen + 7) >> 3; 
            memcpy((void *) sp1, (const void *) sp2, (size_t) h); 
            &dA    &d@ */ 

        /* &dACorrection added 11-20-92&d@ */ 

            h = (slen + 31) >> 5; 
            h <<= 2;               /* guarenteed to be mult of 4 */ 
            memcpy((void *) sp1, (const void *) sp2, (size_t) h); 

        /*                           */ 

            goto TOP; 
        case 236:               /* A-bstr{#} = "0"                    */ 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            h = *IPC.n++; 
            slen = *ip3; 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, TIPC, 1); 
            } 
            --h; 
            k = h >> 5; 
            h -= k << 5; 
            *(ip3+k+1) &= andbitflag[h];  /* turn off bit h of word k */ 
            goto TOP; 
        case 237:               /* A-bstr{S-int} = "0"                */ 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            h = *(*IPC.p); 
            ++IPC.n; 
            slen = *ip3; 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, TIPC, 1); 
            } 
            --h; 
            k = h >> 5; 
            h -= k << 5; 
            *(ip3+k+1) &= andbitflag[h];  /* turn off bit h of word k */ 
            goto TOP; 
        case 238:               /* A-bstr{sub-exp} = "0"              */ 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            Zevsub(&h); 
            slen = *ip3; 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, TIPC, 1); 
            } 
            --h; 
            k = h >> 5; 
            h -= k << 5; 
            *(ip3+k+1) &= andbitflag[h];  /* turn off bit h of word k */ 
            goto TOP; 
        case 239:               /* A-bstr{#} = "1"                    */ 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            h = *IPC.n++; 
            slen = *ip3; 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, TIPC, 1); 
            } 
            --h; 
            k = h >> 5; 
            h -= k << 5; 
            *(ip3+k+1) |= orbitflag[h];   /* turn on  bit h of word k */ 
            goto TOP; 
        case 240:               /* A-bstr{S-int} = "1"                */ 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            h = *(*IPC.p); 
            ++IPC.n; 
            slen = *ip3; 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, TIPC, 1); 
            } 
            --h; 
            k = h >> 5; 
            h -= k << 5; 
            *(ip3+k+1) |= orbitflag[h];   /* turn on  bit h of word k */ 
            goto TOP; 
        case 241:               /* A-bstr{sub-exp} = "1"              */ 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            Zevsub(&h); 
            slen = *ip3; 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, TIPC, 1); 
            } 
            --h; 
            k = h >> 5; 
            h -= k << 5; 
            *(ip3+k+1) |= orbitflag[h];   /* turn on  bit h of word k */ 
            goto TOP; 
        case 242:               /* A-bstr = A-bstr (//)               */ 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            slen = *ip3; 
            nxop = *IPC.n >> 16; 
            ++IPC.n; 
            h = slen; 
            k = h >> 5; 
            h -= k << 5; 
            Zappbstr(ip3+k+1, h, mlen, &slen, nxop, TIPC); 
            *ip3 = slen; 
            goto TOP; 
        case 243:               /* A-bstr = general string // S-bstr  */ 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            ip1 = ip3 + 1; 
            h = *ip3; 
            Zidsubbitstr(&ip2, &f, &slen, &i); 
            if (slen == 0)  goto TOP; 
            if (slen + h > mlen)  strlenerr(slen+h, mlen, TIPC, 0); 
        /* shift bstr and insert (right to left)  */ 
            if (h > 0)  { 
                k = h >> 5; 
                g = h - (k << 5); 
                ip5 = ip1 + k; 
                off2 = (k << 5) + slen; 
                j = off2 >> 5;         
                off2 -= j << 5;            /* 0 <= off2 <= 31 */ 
                ip4 = ip1 + j; 
                if (off2 + g <= 32) { 
                    --ip5; 
                    --ip4; 
                } 
            /* shift blocks */ 
                a = 32 - off2;             /* 0 <= off2 <= 31 */ 
                while (ip3 >= ip1) { 
                    if (off2 == 0)  { 
                        j = 0; 
                    } 
                    else { 
                        j = *ip5 << a; 
                    } 
                    ui = *(ip5 + 1); 
                    j += ui >> off2;       /* 0 <= off2 <= 31 */ 
                    *(ip4+1) = j; 
                    --ip4; 
                    --ip5; 
                } 
            /* shift head */ 
                ui = *ip1; 
                j = ui >> off2;            /* 0 <= off2 <= 31 */ 
                *(ip4+1) = 0; 
            } 
        /* insert leading string */ 
            k = 0; 
            work_around_1(ip1, &i, ip2, slen, &k, f, 1); 
            if (h > 0)  { 
                *(ip4 + 1) |= j; 
            } 
            *ip3 = slen + h; 
            goto TOP; 
        case 244:               /* A-bstr = general bstr (//)         */ 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            ip1 = ip3 + 1; 
            Zidsubbitstr(&ip2, &f, &slen, &nxop); 
            if (slen > mlen)  strlenerr(slen, mlen, TIPC, 0); 
            h = 0; 
            work_around_1(ip1, &i, ip2, slen, &h, f, 1); 
            if (nxop == 0) { 
                *ip3 = slen; 
                goto TOP;
            } 
            ip1 += i; 
            Zappbstr(ip1, h, mlen, &slen, nxop, TIPC); 
            *ip3 = slen; 
            goto TOP; 
        case 245:               /* A-bstr = gen bstr (complex //)     */ 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            goto A245A; 
        case 246:               /* A-bstr = function (//)             */ 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            ip1 = ip3 + 1; 
            slen = 0; 
            off1 = 0; 
            Zappbfun(ip1, off1, &h, mlen, &slen, &nxop, TIPC); 
            if (nxop == 0) { 
                *ip3 = slen; 
                goto TOP; 
            } 
            off1 += h; 
            k = off1 >> 5; 
            off1 -= k << 5; 
            Zappbstr(ip1+k, off1, mlen, &slen, nxop, TIPC); 
            *ip3 = slen; 
            goto TOP; 
        case 247:               /* A-bstr = function (complex //)     */ 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            goto A247A; 

/*  INTEGERS  */ 
        case 301:               /* S-int = 0                          */ 
            *(*IPC.p) = 0; 
            ++IPC.n; 
            goto TOP; 
        case 302:               /* S-int = 1                          */ 
            *(*IPC.p) = 1; 
            ++IPC.n; 
            goto TOP; 
        case 303:               /* S-int = #                          */ 
            *(*IPC.p) = *(IPC.n+1); 
            IPC.n += 2; 
            goto TOP; 
        case 304:               /* S-int = S-int1                     */ 
            *(*IPC.p) = *(*(IPC.p+1)); 
            IPC.n += 2; 
            goto TOP; 
        case 305:               /* S-int = A-int1                     */ 
            ip3 = *IPC.p; 
            ++IPC.n; 
            *ip3 = ZevA_int(); 
            goto TOP; 
        case 306:               /* S-int = S-int + 1                  */ 
            ++(*(*IPC.p)); 
            ++IPC.n;    
            goto TOP; 
        case 307:               /* S-int = S-int + #                  */ 
            *(*IPC.p) += *(IPC.n+1); 
            IPC.n += 2; 
            goto TOP; 
        case 308:               /* S-int = S-int * #                  */ 
            *(*IPC.p) *= *(IPC.n+1); 
            IPC.n += 2; 
            goto TOP; 
        case 309:               /* S-int = S-int / #                  */ 
            ip3 = *IPC.p; 
            k = *ip3; 
            h = *(IPC.n+1); 
            if (h == 0)      zerodiv(IPC.n+1); 
            j = k / h; 
            *(elk.n + REM) = k - (j * h); 
            *ip3 = j; 
            IPC.n += 2; 
            goto TOP; 
        case 310:               /* S-int = S-int | #                  */ 
            *(*IPC.p) |= *(IPC.n+1); 
            IPC.n += 2; 
            goto TOP; 
        case 311:               /* S-int = S-int & #                  */ 
            *(*IPC.p) &= *(IPC.n+1); 
            IPC.n += 2; 
            goto TOP; 
        case 312:               /* S-int = S-int << #                 */ 
            k = *(IPC.n+1); 
            ip1 = *IPC.p; 
            IPC.n += 2; 
            if (k > 31)  { 
                *ip1 = 0; 
                goto TOP; 
            } 
            if (k >= 0)  { 
                *ip1 <<= k; 
            } 
            goto TOP; 
        case 313:               /* S-int = S-int >> #                 */ 
            k = *(IPC.n+1); 
            ip1 = *IPC.p; 
            IPC.n += 2; 
            if (k > 31)  { 
                *ip1 = 0; 
                goto TOP; 
            } 
            if (k >= 0)  { 
                ui = (unsigned long) *ip1; 
                ui >>= k; 
                *ip1 = ui; 
            } 
            goto TOP; 
        case 314:               /* S-int = S-int <op> #.int.func ...  */ 
            nxop = *IPC.n; 
            ip3 = *(IPC.p+1); 
            IPC.n += 2; 
            *ip3 = Zintex(*ip3, nxop); 
            goto TOP; 
        case 315:               /* S-int = S-int1 + 1                 */ 
            *(*IPC.p) = *(*(IPC.p+1)) + 1; 
            IPC.n += 2; 
            goto TOP; 
        case 316:               /* S-int = S-int1 + #                 */ 
            *(*IPC.p) = *(*(IPC.p+1)) + *(IPC.n+2); 
            IPC.n += 3; 
            goto TOP; 
        case 317:               /* S-int = S-int1 * #                 */ 
            *(*IPC.p) = *(*(IPC.p+1)) * (*(IPC.n+2)); 
            IPC.n += 3; 
            goto TOP; 
        case 318:               /* S-int = S-int1 / #                 */ 
            ip3 = *IPC.p; 
            k = *(*(IPC.p+1)); 
            h = *(IPC.n+2); 
            if (h == 0)      zerodiv(IPC.n+2); 
            j = k / h; 
            *(elk.n + REM) = k - (j * h); 
            *ip3 = j; 
            IPC.n += 3; 
            goto TOP; 
        case 319:               /* S-int = A-int1 + 1                 */ 
            ip3 = *IPC.p; 
            ++IPC.n; 
            *ip3 = ZevA_int(); 
            ++(*ip3); 
            goto TOP; 
        case 320:               /* S-int = A-int1 + #                 */ 
            ip3 = *IPC.p; 
            ++IPC.n; 
            *ip3 = ZevA_int(); 
            *ip3 += *(IPC.n++); 
            goto TOP; 
        case 321:               /* S-int = A-int1 * #                 */ 
            ip3 = *IPC.p; 
            ++IPC.n; 
            *ip3 = ZevA_int(); 
            *ip3 *= *(IPC.n++); 
            goto TOP; 
        case 322:               /* S-int = A-int1 / #                 */ 
            ip3 = *IPC.p; 
            ++IPC.n; 
            k = ZevA_int(); 
            h = *IPC.n; 
            if (h == 0)      zerodiv(IPC.n); 
            j = k / h; 
            *(elk.n + REM) = k - (j * h); 
            *ip3 = j; 
            ++IPC.n; 
            goto TOP; 
        case 323:               /* S-int = # <op> #,int,func ...      */ 
            ip3 = *IPC.p; 
            k = *(IPC.n+1); 
            nxop = *(IPC.n+2); 
            IPC.n += 3; 
            *ip3 = Zintex(k, nxop); 
            goto TOP; 
        case 324:               /* S-int = int1 <op> #,int,func ...   */ 
            ip3 = *IPC.p; 
            ++IPC.n; 
            Zevint(&k, &nxop); 
            *ip3 = Zintex(k, nxop); 
            goto TOP;
        case 325:               /* S-int = func <op> #,int,func ...   */ 
            ip3 = *IPC.p; 
            ++IPC.n; 
            *ip3 = Zgenintex(); 
            goto TOP; 
        case 326:               /* S-int = A-int{#} (constant)        */ 
            *(*IPC.p) = *(*(IPC.p+1)); 
            IPC.n += 2; 
            goto TOP; 
        case 327:               /* S-int = S-int + A-int{#} (const)   */ 
            *(*IPC.p) += *(*(IPC.p+1)); 
            IPC.n += 2; 
            goto TOP; 
        case 328:               /* S-int = S-int - A-int{#} (const)   */ 
            *(*IPC.p) -= *(*(IPC.p+1)); 
            IPC.n += 2; 
            goto TOP; 
        case 329:               /* S-int = S-int1 + A-int{#} (const)  */ 
            *(*IPC.p) = *(*(IPC.p+1)) + *(*(IPC.p+2)); 
            IPC.n += 3; 
            goto TOP; 
        case 330:               /* S-int = S-int1 - A-int{#} (const)  */ 
            *(*IPC.p) = *(*(IPC.p+1)) - *(*(IPC.p+2)); 
            IPC.n += 3; 
            goto TOP; 
        case 331:               /* S-int = A-int1 + A-int{#} (const)  */ 
            ip3 = *IPC.p; 
            ++IPC.n; 
            *ip3 = ZevA_int(); 
            *ip3 += *(*IPC.p); 
            ++IPC.n; 
            goto TOP; 
        case 332:               /* S-int = A-int1 - A-int{#} (const)  */ 
            ip3 = *IPC.p; 
            ++IPC.n; 
            *ip3 = ZevA_int(); 
            *ip3 -= *(*IPC.p); 
            ++IPC.n; 
            goto TOP; 
        case 351:               /* A-int = 0                          */ 
            ip3 = Zidint(); 
            *ip3 = 0; 
            goto TOP; 
        case 352:               /* A-int = 1                          */ 
            ip3 = Zidint(); 
            *ip3 = 1; 
            goto TOP; 
        case 353:               /* A-int = #                          */ 
            ip3 = Zidint(); 
            *ip3 = *IPC.n++; 
            goto TOP; 
        case 354:               /* A-int = S-int1                     */ 
            ip3 = Zidint(); 
            *ip3 = *(*IPC.p); 
            ++IPC.n; 
            goto TOP; 
        case 355:               /* A-int = A-int1                     */ 
            ip3 = Zidint(); 
            *ip3 = ZevA_int(); 
            goto TOP; 
        case 356:               /* A-int = A-int + 1                  */ 
            ip3 = Zidint(); 
            ++(*ip3); 
            goto TOP; 
        case 357:               /* A-int = A-int + #                  */ 
            ip3 = Zidint(); 
            *ip3 += *IPC.n++; 
            goto TOP; 
        case 358:               /* A-int = A-int * #                  */ 
            ip3 = Zidint(); 
            *ip3 *= *IPC.n++; 
            goto TOP; 
        case 359:               /* A-int = A-int / #                  */ 
            ip3 = Zidint(); 
            k = *ip3; 
            h = *IPC.n; 
            if (h == 0)      zerodiv(IPC.n); 
            j = k / h; 
            *(elk.n + REM) = k - (j * h); 
            *ip3 = j; 
            ++IPC.n; 
            goto TOP; 
        case 360:               /* A-int = A-int | #                  */ 
            ip3 = Zidint(); 
            *ip3 |= *IPC.n++; 
            goto TOP; 
        case 361:               /* A-int = A-int & #                  */ 
            ip3 = Zidint(); 
            *ip3 &= *IPC.n++; 
            goto TOP; 
        case 362:               /* A-int = A-int << #                 */ 
            ip3 = Zidint(); 
            k = *IPC.n++; 
            if (k > 31)  { 
                *ip3 = 0; 
                goto TOP; 
            } 
            if (k >= 0)  { 
                *ip3 <<= k; 
            } 
            goto TOP; 
        case 363:               /* A-int = A-int >> #                 */ 
            ip3 = Zidint(); 
            k = *IPC.n++; 
            if (k > 31)  { 
                *ip3 = 0; 
                goto TOP; 
            } 
            if (k >= 0)  { 
                ui = (unsigned long) *ip3; 
                ui >>= k; 
                *ip3 = ui; 
            } 
            goto TOP; 
        case 364:               /* A-int = A-int <op> #.int.func ...  */ 
            nxop = *IPC.n++; 
            ip3 = Zidint(); 
            *ip3 = Zintex(*ip3, nxop); 
            goto TOP; 
        case 365:               /* A-int = S-int1 + 1                 */ 
            ip3 = Zidint(); 
            *ip3 = *(*IPC.p) + 1; 
            ++IPC.n; 
            goto TOP; 
        case 366:               /* A-int = S-int1 + #                 */ 
            ip3 = Zidint(); 
            *ip3 = *(*IPC.p) + *(IPC.n+1); 
            IPC.n += 2; 
            goto TOP; 
        case 367:               /* A-int = S-int1 * #                 */ 
            ip3 = Zidint(); 
            *ip3 = *(*IPC.p) * (*(IPC.n+1)); 
            IPC.n += 2; 
            goto TOP; 
        case 368:               /* A-int = S-int1 / #                 */ 
            ip3 = Zidint(); 
            k = *(*IPC.p); 
            h = *(IPC.n+1); 
            if (h == 0)      zerodiv(IPC.n+1); 
            j = k / h; 
            *(elk.n + REM) = k - (j * h); 
            *ip3 = j; 
            IPC.n += 2; 
            goto TOP; 
        case 369:               /* A-int = A-int1 + 1                 */ 
            ip3 = Zidint(); 
            *ip3 = ZevA_int(); 
            ++(*ip3); 
            goto TOP; 
        case 370:               /* A-int = A-int1 + #                 */ 
            ip3 = Zidint(); 
            *ip3 = ZevA_int(); 
            *ip3 += *(IPC.n++); 
            goto TOP; 
        case 371:               /* A-int = A-int1 * #                 */ 
            ip3 = Zidint(); 
            *ip3 = ZevA_int(); 
            *ip3 *= *(IPC.n++); 
            goto TOP; 
        case 372:               /* A-int = A-int1 / #                 */ 
            ip3 = Zidint(); 
            k = ZevA_int(); 
            h = *IPC.n; 
            if (h == 0)      zerodiv(IPC.n); 
            j = k / h; 
            *(elk.n + REM) = k - (j * h); 
            *ip3 = j; 
            ++IPC.n; 
            goto TOP; 
        case 373:               /* A-int = # <op> #,int,func ...      */ 
            ip3 = Zidint(); 
            k = *IPC.n; 
            nxop = *(IPC.n+1); 
            IPC.n += 2; 
            *ip3 = Zintex(k, nxop); 
            goto TOP; 
        case 374:               /* A-int = int1 <op> #,int,func ...   */ 
            ip3 = Zidint(); 
            Zevint(&k, &nxop); 
            *ip3 = Zintex(k, nxop); 
            goto TOP;
        case 375:               /* A-int = func <op> #,int,func ...   */ 
            ip3 = Zidint(); 
            *ip3 = Zgenintex(); 
            goto TOP; 
        case 376:               /* A-int = A-int{#} (constant)        */ 
            ip3 = Zidint(); 
            *ip3 = *(*IPC.p); 
            ++IPC.n; 
            goto TOP; 
        case 377:               /* A-int = S-int + A-int{#} (const)   */ 
            ip3 = Zidint(); 
            *ip3 += *(*IPC.p); 
            ++IPC.n; 
            goto TOP; 
        case 378:               /* A-int = S-int - A-int{#} (const)   */ 
            ip3 = Zidint(); 
            *ip3 -= *(*IPC.p); 
            ++IPC.n; 
            goto TOP; 
        case 379:               /* A-int = S-int1 + A-int{#} (const)  */ 
            ip3 = Zidint(); 
            *ip3 = *(*IPC.p) + *(*(IPC.p+1)); 
            IPC.n += 2; 
            goto TOP; 
        case 380:               /* A-int = S-int1 - A-int{#} (const)  */ 
            ip3 = Zidint(); 
            *ip3 = *(*IPC.p) - *(*(IPC.p+1)); 
            IPC.n += 2; 
            goto TOP; 
        case 381:               /* A-int = A-int1 + A-int{#} (const)  */ 
            ip3 = Zidint(); 
            *ip3 = ZevA_int(); 
            *ip3 += *(*IPC.p); 
            ++IPC.n; 
            goto TOP; 
        case 382:               /* A-int = A-int1 - A-int{#} (const)  */ 
            ip3 = Zidint(); 
            *ip3 = ZevA_int(); 
            *ip3 -= *(*IPC.p); 
            ++IPC.n; 
            goto TOP; 
        case 391:               /* A-int = srt(A-int1/A-bstr, int)    */ 
            Zinstruction391(); 
            goto TOP; 

/*  REALS  */ 
        case 401:               /* S-real = 0.0                       */ 
            x = (double *) (*IPC.p); 
            ++IPC.n; 
            *x = 0; 
            goto TOP; 
        case 402:               /* S-real = literal real (in-line)    */ 
            x = (double *) (*IPC.p); 
            y = (double *) (IPC.n+1); 
            *x = *y; 
            IPC.n += 3; 
            goto TOP;
        case 403:               /* S-real = S-real1                   */ 
            x = (double *) (*IPC.p); 
            y = (double *) (*(IPC.p+1)); 
            *x = *y; 
            IPC.n += 2; 
            goto TOP;
        case 404:               /* S-real = A-real1                   */ 
            x = (double *) (*IPC.p); 
            ++IPC.n; 
            ZevA_real(x); 
            goto TOP; 
        case 405:               /* S-real = S-real <op> l,r,f ...     */ 
            nxop = *IPC.n; 
            x = (double *) (*(IPC.p+1)); 
            IPC.n += 2; 
            Zfltex(x, *x, nxop); 
            goto TOP; 
        case 406:               /* S-real = lit <op> l,r,f ...        */ 
            x = (double *) (*IPC.p); 
            y = (double *) (IPC.n+1); 
            nxop = *(IPC.n+3); 
            IPC.n += 4; 
            Zfltex(x, *y, nxop); 
            goto TOP; 
        case 407:               /* S-real = real1 <op> l,r,f ...      */ 
            x = (double *) (*IPC.p); 
            ++IPC.n; 
            Zevreal(&z, &nxop); 
            Zfltex(x, z, nxop); 
            goto TOP; 
        case 408:               /* S-real = func <op> l,r,f ...       */ 
            x = (double *) (*IPC.p); 
            ++IPC.n; 
            Zgenfltex(x); 
            goto TOP; 
        case 431:               /* A-real = 0.0                       */ 
            Zidreal(&x); 
            ip3 = (long *) x; 
            *x = 0; 
            goto TOP; 
        case 432:               /* A-real = literal real (in-line)    */ 
            Zidreal(&x); 
            ip3 = (long *) x; 
            y = (double *) (IPC.n); 
            *x = *y; 
            IPC.n += 2; 
            goto TOP;
        case 433:               /* A-real = S-real1                   */ 
            Zidreal(&x); 
            ip3 = (long *) x; 
            y = (double *) (*IPC.p); 
            *x = *y; 
            ++IPC.n; 
            goto TOP;
        case 434:               /* A-real = A-real1                   */ 
            Zidreal(&x); 
            ip3 = (long *) x; 
            ZevA_real(x); 
            goto TOP; 
        case 435:               /* A-real = A-real <op> l,r,f ...     */ 
            nxop = *IPC.n; 
            ++IPC.n; 
            Zidreal(&x); 
            ip3 = (long *) x; 
            Zfltex(x, *x, nxop); 
            goto TOP; 
        case 436:               /* A-real = lit <op> l,r,f ...        */ 
            Zidreal(&x); 
            ip3 = (long *) x; 
            y = (double *) (IPC.n); 
            nxop = *(IPC.n+2); 
            IPC.n += 3; 
            Zfltex(x, *y, nxop); 
            goto TOP; 
        case 437:               /* A-real = real1 <op> l,r,f ...      */ 
            Zidreal(&x); 
            ip3 = (long *) x; 
            Zevreal(&z, &nxop); 
            Zfltex(x, z, nxop); 
            goto TOP; 
        case 438:               /* A-real = func <op> l,r,f ...       */ 
            Zidreal(&x); 
            ip3 = (long *) x; 
            Zgenfltex(x); 
            goto TOP; 

/*  STRING RELATIONS  */ 
        case 501:               /* S-str = ""                         */ 
            if (*(*(*IPC.q)) == 0)  b1 = 1; 
            else                    b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 502:               /* S-str <> ""                        */ 
            if (*(*(*IPC.q)) != 0)  b1 = 1; 
            else                    b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 503:               /* S-str = "x"                        */ 
            b1 = 0; 
            if (*(*(*IPC.q)) == 1)  { 
                sp1 = (char *) (*(*IPC.q) + 1); 
                sp2 = (char *) (IPC.n + 1); 
                if (*sp1 == *sp2)  b1 = 1; 
            } 
            IPC.n += 2; 
            goto TOP; 
        case 504:               /* S-str = "xx"                       */ 
            b1 = 0; 
            if (*(*(*IPC.q)) == 2)  { 
                sp1 = (char *) (*(*IPC.q) + 1); 
                sp2 = (char *) (IPC.n + 1); 
                if (*sp1 == *sp2)  { 
                    if (*(sp1+1) == *(sp2+1))  b1 = 1; 
                } 
            } 
            IPC.n += 2; 
            goto TOP; 
        case 505:               /* S-str = "xxx"                      */ 
            b1 = 0; 
            if (*(*(*IPC.q)) == 3)  { 
                sp1 = (char *) (*(*IPC.q) + 1); 
                sp2 = (char *) (IPC.n + 1); 
                if (memcmp((const void *) sp1, (const void *) sp2, 
                        (size_t) 3) == 0)   b1 = 1; 
            } 
            IPC.n += 2; 
            goto TOP; 
        case 506:               /* S-str = "xxxx"                     */ 
            b1 = 0; 
            if (*(*(*IPC.q)) == 4)  { 
                sp1 = (char *) (*(*IPC.q) + 1); 
                sp2 = (char *) (IPC.n + 1); 
                if (memcmp((const void *) sp1, (const void *) sp2, 
                        (size_t) 4) == 0)   b1 = 1; 
            } 
            IPC.n += 2; 
            goto TOP; 
        case 507:               /* S-str con "x"                      */ 
            b1 = 0; 
            ip3 = *(*IPC.q); 
            slen = *ip3; 
            sp1 = (char *) (ip3 + 1); 
            sp2 = (char *) (IPC.n+1); 
            if ((sp3 = (char *) memchr((const void *) sp1, 
                    *sp2, (size_t) slen)) != NULL)  { 
                b1 = 1; 
                k = sp3 - sp1 + 1; 
                *(elk.n + MPT) = k; 
                *(elk.n + SUB) = k; 
            } 
            IPC.n += 2; 
            goto TOP; 
        case 508:               /* S-str con S-str1                   */ 
            b1 = 0; 
            ip3 = *(*IPC.q); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            ip4 = *(*(IPC.q+1)); 
            IPC.n += 2; 
            k = *ip4; 
            if (k == 0) goto TOP; 
            sp2 = (char *) (ip4 + 1); 
            sp4 = sp1; 
            g = slen - k + 1;          /* g = number of tries */ 
            for (h = 0; h < g;)  { 
                j = g - h;             /* note: somewhat tricky code */ 
                sp3 = sp1 + h; 
                if ((sp3 = (char *) memchr((const void *) (sp1+h), 
                        *sp2, (size_t) j)) != NULL)  { 
                    h = sp3 - sp1 + 1; 
                    if (memcmp((const void *) sp3, 
                            (const void *) sp2, (size_t) k) == 0) { 
                        *(elk.n + MPT) = h; 
                        *(elk.n + SUB) = h + sp1 - sp4; 
                        b1   = 1; 
                        goto TOP; 
                    } 
                } 
                else goto TOP; 
            } 
            goto TOP; 
        case 509:               /* S-str = s (general string)         */ 
            b1 = 0; 
            ip3 = *(*IPC.q); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            ++IPC.n; 
            Zrel_idsubstr(&sp2, &k); 
            if (k == -1)  goto TOP; 
            if (slen == k && memcmp((const void *) sp1, 
                    (const void *) sp2, (size_t) k) == 0)  { 
                b1 = 1; 
            } 
            goto TOP; 
        case 510:               /* S-str <> s (general string)        */ 
            b1 = 1; 
            ip3 = *(*IPC.q); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            ++IPC.n; 
            Zrel_idsubstr(&sp2, &k); 
            if (k == -1)  goto TOP; 
            if (slen == k && memcmp((const void *) sp1, 
                    (const void *) sp2, (size_t) k) == 0)  { 
                b1 = 0; 
            } 
            goto TOP; 
        case 511:               /* S-str con s (general string)       */ 
            b1 = 0; 
            ip3 = *(*IPC.q); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            ++IPC.n; 
            Zrel_idsubstr(&sp2, &k); 
            if (k < 1)  goto TOP; 
            sp4 = sp1; 
            g = slen - k + 1;          /* g = number of tries */ 
            for (h = 0; h < g;)  { 
                j = g - h;             /* note: somewhat tricky code */ 
                sp3 = sp1 + h; 
                if ((sp3 = (char *) memchr((const void *) (sp1+h), 
                        *sp2, (size_t) j)) != NULL)  { 
                    h = sp3 - sp1 + 1; 
                    if (memcmp((const void *) sp3, 
                            (const void *) sp2, (size_t) k) == 0) { 
                        *(elk.n + MPT) = h; 
                        *(elk.n + SUB) = h + sp1 - sp4; 
                        b1   = 1; 
                        goto TOP; 
                    } 
                } 
                else goto TOP; 
            } 
            goto TOP; 
        case 512:               /* S-str con [ ]                      */ 
            b1 = 0; 
            ip3 = *(*IPC.q); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            ip1 = *(IPC.p+1); 
            IPC.n += 2; 
            sp4 = sp1; 
            for (i = 0; i < slen; ++i)  { 
                k = (*sp1 & 0xff) >> 5; 
                j = *sp1 & 0x1f; 
                if ((*(ip1+k) & orbitflag[j]) != 0)  { 
                    *(elk.n + MPT) = i + 1; 
                    *(elk.n + SUB) = sp1 - sp4 + 1; 
                    b1 = 1; 
                    break; 
                } 
                ++sp1; 
            } 
            goto TOP; 
        case 513:               /* S-str in [ ]                       */ 
            b1 = 1; 
            ip3 = *(*IPC.q); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            ip1 = *(IPC.p+1); 
            IPC.n += 2; 
            for (i = 0; i < slen; ++i)  { 
                k = (*sp1 & 0xff) >> 5; 
                j = *sp1 & 0x1f; 
                if ((*(ip1+k) & orbitflag[j]) == 0)  { 
                    b1 = 0; 
                    break; 
                } 
                ++sp1; 
            } 
            goto TOP; 
        case 514:               /* "..." con S-str{#}                 */ 
            b1 = 0; 
            ip3  = *(*IPC.q); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            ip3  = *(*(IPC.q+1)); 
            k    = *ip3; 
            sp2  = (char *) (ip3 + 1); 
            h = *(IPC.n+2); 
            if (h > k || h < 1) { 
                strsubwarn(h, k, IPC, 1); 
                IPC.n += 3; 
                goto TOP; 
            } 
            if ((sp3 = (char *) memchr((const void *) sp1, 
                    *(sp2+h-1), (size_t) slen)) != NULL) { 
                b1 = 1; 
                k = sp3 - sp1 + 1; 
                *(elk.n + MPT) = k; 
                *(elk.n + SUB) = k; 
            } 
            IPC.n += 3; 
            goto TOP; 
        case 515:               /* "..." con S-str{S-int}             */ 
            b1 = 0; 
            ip3  = *(*IPC.q); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            ip3  = *(*(IPC.q+1)); 
            k    = *ip3; 
            sp2  = (char *) (ip3 + 1); 
            h = *(*(IPC.p+2)); 
            if (h > k || h < 1) { 
                strsubwarn(h, k, IPC, 1); 
                IPC.n += 3; 
                goto TOP; 
            } 
            if ((sp3 = (char *) memchr((const void *) sp1, 
                    *(sp2+h-1), (size_t) slen)) != NULL) { 
                b1 = 1; 
                k = sp3 - sp1 + 1; 
                *(elk.n + MPT) = k; 
                *(elk.n + SUB) = k; 
            } 
            IPC.n += 3; 
            goto TOP; 
        case 516:               /* "..." con S-str{sub-exp}           */ 
            b1 = 0; 
            ip3  = *(*IPC.q); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            TIPC.n = IPC.n; 
            ip3  = *(*(IPC.q+1)); 
            IPC.n += 2; 
            k    = *ip3; 
            sp2  = (char *) (ip3 + 1); 
            Zevsub(&h); 
            if (h > k || h < 1) { 
                strsubwarn(h, k, TIPC, 1); 
                goto TOP; 
            } 
            if ((sp3 = (char *) memchr((const void *) sp1, 
                    *(sp2+h-1), (size_t) slen)) != NULL) { 
                b1 = 1; 
                k = sp3 - sp1 + 1; 
                *(elk.n + MPT) = k; 
                *(elk.n + SUB) = k; 
            } 
            goto TOP; 
        case 517:               /* "..." con A-str{#}                 */ 
            b1 = 0; 
            ip3  = *(*IPC.q); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            TIPC.n = IPC.n; 
            ++IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            k    = *ip3; 
            sp2  = (char *) (ip3 + 1); 
            h = *IPC.n; 
            ++IPC.n;
            if (h > k || h < 1) { 
                strsubwarn(h, k, TIPC, 1); 
                goto TOP; 
            } 
            if ((sp3 = (char *) memchr((const void *) sp1, 
                    *(sp2+h-1), (size_t) slen)) != NULL) { 
                b1 = 1; 
                k = sp3 - sp1 + 1; 
                *(elk.n + MPT) = k; 
                *(elk.n + SUB) = k; 
            } 
            goto TOP; 
        case 518:               /* "..." con A-str{S-int}             */ 
            b1 = 0; 
            ip3  = *(*IPC.q); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            TIPC.n = IPC.n; 
            ++IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            k    = *ip3; 
            sp2  = (char *) (ip3 + 1); 
            h = *(*IPC.p); 
            ++IPC.n;
            if (h > k || h < 1) { 
                strsubwarn(h, k, TIPC, 1); 
                goto TOP; 
            } 
            if ((sp3 = (char *) memchr((const void *) sp1, 
                    *(sp2+h-1), (size_t) slen)) != NULL) { 
                b1 = 1; 
                k = sp3 - sp1 + 1; 
                *(elk.n + MPT) = k; 
                *(elk.n + SUB) = k; 
            } 
            goto TOP; 
        case 519:               /* "..." con A-str{sub-exp}           */ 
            b1 = 0; 
            ip3  = *(*IPC.q); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            TIPC.n = IPC.n; 
            ++IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            k    = *ip3; 
            sp2  = (char *) (ip3 + 1); 
            Zevsub(&h); 
            if (h > k || h < 1) { 
                strsubwarn(h, k, TIPC, 1); 
                goto TOP; 
            } 
            if ((sp3 = (char *) memchr((const void *) sp1, 
                    *(sp2+h-1), (size_t) slen)) != NULL) { 
                b1 = 1; 
                k = sp3 - sp1 + 1; 
                *(elk.n + MPT) = k; 
                *(elk.n + SUB) = k; 
            } 
            goto TOP; 
        case 520:               /* S-str{#} in [ ]                    */ 
            b1 = 0; 
            ip3  = *(*IPC.q); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            h = *(IPC.n+1); 
            if (h > slen || h < 1) { 
                strsubwarn(h, slen, IPC, 1); 
                IPC.n += 3; 
                goto TOP; 
            } 
            sp1 += h - 1; 
            ip1 = *(IPC.p+2); 
            k = (*sp1 & 0xff) >> 5; 
            j = *sp1 & 0x1f; 
            if ((*(ip1+k) & orbitflag[j]) != 0)  b1 = 1; 
            IPC.n += 3; 
            goto TOP; 
        case 521:               /* S-str{S-int} in [ ]                */ 
            b1 = 0; 
            ip3  = *(*IPC.q); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            h = *(*(IPC.p+1)); 
            if (h > slen || h < 1) { 
                strsubwarn(h, slen, IPC, 1); 
                IPC.n += 3; 
                goto TOP; 
            } 
            sp1 += h - 1; 
            ip1 = *(IPC.p+2); 
            k = (*sp1 & 0xff) >> 5; 
            j = *sp1 & 0x1f; 
            if ((*(ip1+k) & orbitflag[j]) != 0)  b1 = 1; 
            IPC.n += 3; 
            goto TOP; 
        case 522:               /* S-str{sub-exp} in [ ]              */ 
            b1 = 0; 
            ip3  = *(*IPC.q); 
            TIPC.n = IPC.n; 
            ++IPC.n; 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            Zevsub(&h); 
            if (h > slen || h < 1) { 
                strsubwarn(h, slen, TIPC, 1); 
                ++IPC.n; 
                goto TOP; 
            } 
            sp1 += h - 1; 
            ip1 = *IPC.p; 
            k = (*sp1 & 0xff) >> 5; 
            j = *sp1 & 0x1f; 
            if ((*(ip1+k) & orbitflag[j]) != 0)  b1 = 1; 
            ++IPC.n; 
            goto TOP; 
        case 523:               /* S-str{#} = "x"                     */ 
            b1 = 0; 
            ip3  = *(*IPC.q); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            h = *(IPC.n+1); 
            if (h > slen || h < 1) { 
                strsubwarn(h, slen, IPC, 1); 
                IPC.n += 3; 
                goto TOP; 
            } 
            sp1 += h - 1; 
            sp2 = (char *) (IPC.n+2); 
            if (*sp1 == *sp2)  b1 = 1; 
            IPC.n += 3; 
            goto TOP; 
        case 524:               /* S-str{S-int} = "x"                 */ 
            b1 = 0; 
            ip3  = *(*IPC.q); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            h = *(*(IPC.p+1)); 
            if (h > slen || h < 1) { 
                strsubwarn(h, slen, IPC, 1); 
                IPC.n += 3; 
                goto TOP; 
            } 
            sp1 += h - 1; 
            sp2 = (char *) (IPC.n+2); 
            if (*sp1 == *sp2)  b1 = 1; 
            IPC.n += 3; 
            goto TOP; 
        case 525:               /* S-str{sub-exp} = "x"               */ 
            b1 = 0; 
            ip3  = *(*IPC.q); 
            TIPC.n = IPC.n; 
            ++IPC.n; 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            Zevsub(&h); 
            if (h > slen || h < 1) { 
                strsubwarn(h, slen, TIPC, 1); 
                ++IPC.n; 
                goto TOP; 
            } 
            sp1 += h - 1; 
            sp2 = (char *) IPC.n; 
            if (*sp1 == *sp2)  b1 = 1; 
            ++IPC.n; 
            goto TOP; 
        case 526:               /* A-str{#} in [ ]                    */ 
            b1 = 0; 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            h = *IPC.n; 
            if (h > slen || h < 1) { 
                strsubwarn(h, slen, TIPC, 1); 
                IPC.n += 2; 
                goto TOP; 
            } 
            sp1 += h - 1; 
            ip1 = *(IPC.p+1); 
            k = (*sp1 & 0xff) >> 5; 
            j = *sp1 & 0x1f; 
            if ((*(ip1+k) & orbitflag[j]) != 0)  b1 = 1; 
            IPC.n += 2; 
            goto TOP; 
        case 527:               /* A-str{S-int} in [ ]                */ 
            b1 = 0; 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            h = *(*IPC.p); 
            if (h > slen || h < 1) { 
                strsubwarn(h, slen, TIPC, 1); 
                IPC.n += 2; 
                goto TOP; 
            } 
            sp1 += h - 1; 
            ip1 = *(IPC.p+1); 
            k = (*sp1 & 0xff) >> 5; 
            j = *sp1 & 0x1f; 
            if ((*(ip1+k) & orbitflag[j]) != 0)  b1 = 1; 
            IPC.n += 2; 
            goto TOP; 
        case 528:               /* A-str{sub-exp} in [ ]              */ 
            b1 = 0; 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            Zevsub(&h); 
            if (h > slen || h < 1) { 
                strsubwarn(h, slen, TIPC, 1L); 
                ++IPC.n; 
                goto TOP; 
            } 
            sp1 += h - 1; 
            ip1 = *IPC.p; 
            k = (*sp1 & 0xff) >> 5; 
            j = *sp1 & 0x1f; 
            if ((*(ip1+k) & orbitflag[j]) != 0)  b1 = 1; 
            ++IPC.n; 
            goto TOP; 
        case 529:               /* A-str{#} = "x"                     */ 
            b1 = 0; 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            h = *IPC.n; 
            if (h > slen || h < 1) { 
                strsubwarn(h, slen, TIPC, 1); 
                IPC.n += 2; 
                goto TOP; 
            } 
            sp1 += h - 1; 
            sp2 = (char *) (IPC.n+1); 
            if (*sp1 == *sp2)  b1 = 1; 
            IPC.n += 2; 
            goto TOP; 
        case 530:               /* A-str{S-int} = "x"                 */ 
            b1 = 0; 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            h = *(*IPC.p); 
            if (h > slen || h < 1) { 
                strsubwarn(h, slen, TIPC, 1); 
                IPC.n += 2; 
                goto TOP; 
            } 
            sp1 += h - 1; 
            sp2 = (char *) (IPC.n+1); 
            if (*sp1 == *sp2)  b1 = 1; 
            IPC.n += 2; 
            goto TOP; 
        case 531:               /* A-str{sub-exp} = "x"               */ 
            b1 = 0; 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            Zevsub(&h); 
            if (h > slen || h < 1) { 
                strsubwarn(h, slen, TIPC, 1); 
                ++IPC.n; 
                goto TOP; 
            } 
            sp1 += h - 1; 
            sp2 = (char *)  IPC.n; 
            if (*sp1 == *sp2)  b1 = 1; 
            ++IPC.n; 
            goto TOP; 
        case 532:               /* S-str{S-int,#} = "..." (1 to 8)    */ 
            b1 = 0; 
            ip3  = *(*IPC.q); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            h = *(*(IPC.p+1)); 
            if (h > slen || h < 1) { 
                strsubwarn(h, slen, IPC, 1); 
                IPC.n += 5; 
                goto TOP; 
            } 
            k = *(IPC.n+2); 
            --h; 
            if (h+k > slen) { 
                strsubwarn(h+k, slen, IPC, 2); 
                IPC.n += 5; 
                goto TOP; 
            } 
            sp1 += h; 
            sp2 = (char *) (IPC.n+3); 
            if (memcmp((const void *) sp1, 
                            (const void *) sp2, (size_t) k) == 0) b1 = 1; 
            IPC.n += 5; 
            goto TOP; 
        case 533:               /* A-str{S-int,#} = "..." (1 to 8)    */ 
            b1 = 0; 
            TIPC.n = IPC.n; 
            ZidA_str(&ip3, &mlen, 1); 
            slen = *ip3; 
            sp1  = (char *) (ip3 + 1); 
            h = *(*IPC.p); 
            if (h > slen || h < 1) { 
                strsubwarn(h, slen, TIPC, 1); 
                IPC.n += 4; 
                goto TOP; 
            } 
            k = *(IPC.n+1); 
            --h; 
            if (h+k > slen) { 
                strsubwarn(h+k, slen, TIPC, 2); 
                IPC.n += 4; 
                goto TOP; 
            } 
            sp1 += h; 
            sp2 = (char *) (IPC.n+2); 
            if (memcmp((const void *) sp1, 
                            (const void *) sp2, (size_t) k) == 0) b1 = 1; 
            IPC.n += 4; 
            goto TOP; 
        case 551:               /* s (gen str) = s (gen str)          */ 
            b1 = 0; 
            Zrel_idsubstr(&sp1, &h); 
            Zrel_idsubstr(&sp2, &k); 
            if (h == -1 || k == -1)  goto TOP; 
            if (h != k) goto TOP; 
            if (memcmp((const void *) sp1, (const void *) sp2, 
                    (size_t) k) == 0)   b1 = 1; 
            goto TOP; 
        case 552:               /* s (gen str) > s (gen str)          */ 
            b1 = 0; 
            Zrel_idsubstr(&sp1, &h); 
            Zrel_idsubstr(&sp2, &k); 
            if (h == -1 || k == -1)  goto TOP; 
            j = (h < k) ? h : k; 
            if ((i = memcmp((const void *) sp1, (const void *) sp2, 
                    (size_t) j)) < 0)  goto TOP; 
            if (i > 0 || h > k)         b1 = 1; 
            goto TOP; 
        case 553:               /* s (gen str) < s (gen str)          */ 
            b1 = 0; 
            Zrel_idsubstr(&sp1, &h); 
            Zrel_idsubstr(&sp2, &k); 
            if (h == -1 || k == -1)  goto TOP; 
            j = (h < k) ? h : k; 
            if ((i = memcmp((const void *) sp1, (const void *) sp2, 
                    (size_t) j)) > 0)  goto TOP; 
            if (i < 0 || h < k)         b1 = 1; 
            goto TOP; 
        case 554:               /* s (gen str) <> s (gen str)         */ 
            Zrel_idsubstr(&sp1, &h); 
            Zrel_idsubstr(&sp2, &k); 
            if (h == -1 || k == -1)  { 
                b1 = 0; 
                goto TOP; 
            } 
            b1 = 1; 
            if (h != k) goto TOP; 
            if (memcmp((const void *) sp1, (const void *) sp2, 
                    (size_t) k) == 0)   b1 = 0; 
            goto TOP; 
        case 555:               /* s (gen str) >= s (gen str)         */ 
            b1 = 0; 
            Zrel_idsubstr(&sp1, &h); 
            Zrel_idsubstr(&sp2, &k); 
            if (h == -1 || k == -1)  goto TOP; 
            j = (h < k) ? h : k; 
            if ((i = memcmp((const void *) sp1, (const void *) sp2, 
                    (size_t) j)) < 0)  goto TOP; 
            if (i > 0 || h >= k)        b1 = 1; 
            goto TOP; 
        case 556:               /* s (gen str) <= s (gen str)         */ 
            b1 = 0; 
            Zrel_idsubstr(&sp1, &h); 
            Zrel_idsubstr(&sp2, &k); 
            if (h == -1 || k == -1)  goto TOP; 
            j = (h < k) ? h : k; 
            if ((i = memcmp((const void *) sp1, (const void *) sp2, 
                    (size_t) j)) > 0)  goto TOP; 
            if (i < 0 || h <= k)        b1 = 1; 
            goto TOP; 
        case 557:               /* s (gen str) con s (gen str)        */ 
            b1 = 0; 
            Zrel_idgenstr(&ip3, 1); 
            sp4 = (char *) (ip3 + 1); 
            Zrel_idsubstr(&sp1, &slen); 
            Zrel_idsubstr(&sp2, &k); 
            if (k < 1 || slen < 1)  goto TOP; 
            g = slen - k + 1;          /* g = number of tries */ 
            for (h = 0; h < g;)  { 
                j = g - h;             /* note: somewhat tricky code */ 
                sp3 = sp1 + h; 
                if ((sp3 = (char *) memchr((const void *) (sp1+h), 
                        *sp2, (size_t) j)) != NULL)  { 
                    h = sp3 - sp1 + 1; 
                    if (memcmp((const void *) sp3, 
                            (const void *) sp2, (size_t) k) == 0) { 
                        *(elk.n + MPT) = h; 
                        *(elk.n + SUB) = h + sp1 - sp4; 
                        b1   = 1; 
                        goto TOP; 
                    } 
                } 
                else goto TOP; 
            } 
            goto TOP; 
        case 558:               /* s (gen str) con [  ]               */ 
            b1 = 0; 
            Zrel_idgenstr(&ip3, 1); 
            sp4 = (char *) (ip3 + 1); 
            Zrel_idsubstr(&sp1, &slen); 
            ip1 = *IPC.p; 
            ++IPC.n; 
            if (slen == -1)  goto TOP; 
            for (i = 0; i < slen; ++i)  { 
                k = (*sp1 & 0xff) >> 5; 
                j = *sp1 & 0x1f; 
                if ((*(ip1+k) & orbitflag[j]) != 0)  { 
                    *(elk.n + MPT) = i + 1; 
                    *(elk.n + SUB) = sp1 - sp4 + 1; 
                    b1 = 1; 
                    break; 
                } 
                ++sp1; 
            } 
            goto TOP; 
        case 559:               /* s (gen str) in [  ]                */ 
            b1 = 1; 
            Zrel_idsubstr(&sp1, &slen); 
            ip1 = *IPC.p; 
            ++IPC.n; 
            if (slen == -1)  { 
                b1 = 0; 
                goto TOP; 
            } 
            for (i = 0; i < slen; ++i)  { 
                k = (*sp1 & 0xff) >> 5; 
                j = *sp1 & 0x1f; 
                if ((*(ip1+k) & orbitflag[j]) == 0)  { 
                    b1 = 0; 
                    break; 
                } 
                ++sp1; 
            } 
            goto TOP; 
        case 560:               /* s (gen str) con set(bstr)          */ 
            b1 = 0; 
            Zrel_idgenstr(&ip3, 1); 
            sp4 = (char *) (ip3 + 1); 
            Zrel_idsubstr(&sp1, &slen); 
            Zrel_idsubbitstr(&ip1, &f, &k); 
            if (k == -1 || slen == -1)  goto TOP; 
            for (i = 0; i < 8; ++i)  tset[i] = 0; 
            if (f == 0)  { 
                for (i = 0; i < 8 && k > 31; ++i)  { 
                    tset[i] = *ip1++; 
                    k -= 32; 
                } 
                if (i < 8 && k > 0)  {                /* 0 <= k <= 31 */ 
                    j = 0xffffffff << (32 - k); 
                    tset[i] = j & *ip1; 
                } 
            } 
            else { 
                j = 0; 
                work_around_1(tset, &i, ip1, k, &j, f, 1); 
            } 
            ip1 = tset; 
            for (i = 0; i < slen; ++i)  { 
                k = (*sp1 & 0xff) >> 5; 
                j = *sp1 & 0x1f; 
                if ((*(ip1+k) & orbitflag[j]) != 0)  { 
                    *(elk.n + MPT) = i + 1; 
                    *(elk.n + SUB) = sp1 - sp4 + 1; 
                    b1 = 1; 
                    break; 
                } 
                ++sp1; 
            } 
            goto TOP; 
        case 561:               /* s (gen str) in set(bstr)           */ 
            b1 = 1; 
            Zrel_idsubstr(&sp1, &slen); 
            Zrel_idsubbitstr(&ip1, &f, &k); 
            if (slen == -1 || k == -1)  { 
                b1 = 0; 
                goto TOP; 
            } 
            for (i = 0; i < 8; ++i)  tset[i] = 0; 
            if (f == 0)  { 
                for (i = 0; i < 8 && k > 31; ++i)  { 
                    tset[i] = *ip1++; 
                    k -= 32; 
                } 
                if (i < 8 && k > 0)  { 
                    j = 0xffffffff << (32 - k); 
                    tset[i] = j & *ip1; 
                } 
            } 
            else { 
                j = 0; 
                work_around_1(tset, &i, ip1, k, &j, f, 1); 
            } 
            ip1 = tset; 
            for (i = 0; i < slen; ++i)  { 
                k = (*sp1 & 0xff) >> 5; 
                j = *sp1 & 0x1f; 
                if ((*(ip1+k) & orbitflag[j]) == 0)  { 
                    b1 = 0; 
                    break; 
                } 
                ++sp1; 
            } 
            goto TOP; 
        case 571:               /* S-str (>=<) s (general string)     */ 
            b1 = 2; 
            ip3 = *(*IPC.q); 
            h = *ip3; 
            sp1 = (char *) (ip3 + 1); 
            ++IPC.n; 
            Zrel_idsubstr(&sp2, &k); 
            if (h == -1)  { 
                if (k == -1) b1 = 3; 
                else         b1 = 4; 
                goto TOP; 
            } 
            if (k == -1)     goto TOP; 
            j = (h < k) ? h : k; 
            if ((i = memcmp((const void *) sp1, (const void *) sp2, 
                    (size_t) j)) == 0 && h == k)  { 
                b1 = 3; 
                goto TOP; 
            } 
            if (i > 0)       goto TOP; 
            if (i < 0 || h < k)  b1 = 4; 
            goto TOP; 
        case 572:               /* s (gen str) (>=<) s (gen str)      */ 
            b1 = 2; 
            Zrel_idsubstr(&sp1, &h); 
            Zrel_idsubstr(&sp2, &k); 
            if (h == -1)  { 
                if (k == -1) b1 = 3; 
                else         b1 = 4; 
                goto TOP; 
            } 
            if (k == -1)     goto TOP; 
            j = (h < k) ? h : k; 
            if ((i = memcmp((const void *) sp1, (const void *) sp2, 
                    (size_t) j)) == 0 && h == k)  { 
                b1 = 3; 
                goto TOP; 
            } 
            if (i > 0)       goto TOP; 
            if (i < 0 || h < k)  b1 = 4; 
            goto TOP; 

/*  BITSTRING RELATIONS  */ 
        case 601:               /* S-bstr = ""                        */ 
            if (*(*(*IPC.q)) == 0)  b1 = 1; 
            else                    b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 602:               /* S-bstr <> ""                       */ 
            if (*(*(*IPC.q)) != 0)  b1 = 1; 
            else                    b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 603:               /* S-bstr con "0"                     */ 
            b1 = 0; 
            ip1 = *(*IPC.q) + 1; 
            ++IPC.n; 
            slen = *(ip1-1); 
            for (i = 0; *ip1 == -1 && i < slen-31; ++ip1)  i += 32; 
            for (j = 0; i < slen; ++j)  { 
                if ((*ip1 & orbitflag[j]) == 0)  { 
                    b1 = 1; 
                    *(elk.n + MPT) = i + 1; 
                    *(elk.n + SUB) = i + i; 
                    goto TOP; 
                } 
                ++i; 
            } 
            goto TOP; 
        case 604:               /* S-bstr con "1"                     */ 
            b1 = 0; 
            ip1 = *(*IPC.q) + 1; 
            ++IPC.n; 
            slen = *(ip1-1); 
            for (i = 0; *ip1 == 0 && i < slen-31; ++ip1)  i += 32; 
            for (j = 0; i < slen; ++j)  { 
                if ((*ip1 & orbitflag[j]) != 0)  { 
                    b1 = 1; 
                    *(elk.n + MPT) = i + 1; 
                    *(elk.n + SUB) = i + i; 
                    goto TOP; 
                } 
                ++i; 
            } 
            goto TOP; 
        case 605:               /* S-bstr con S-bstr1                 */ 
            b1 = 0; 
            ip1 = *(*IPC.q) + 1; 
            h = *(ip1-1); 
            ip2 = *(*(IPC.q+1)); 
            IPC.n += 2; 
            k = *ip2++; 
            if (k == 0 || h < k)  goto TOP; 
            g = (*ip2 >> 31) & 1; 
            for (i = 0, j = 0; i < h - k + 1; ++i)  { 
                if ((f = *ip1 & orbitflag[j]) != 0) f = 1; 
                if (f == g)  { 
                    if (bitcmp(ip1, j, ip2, 0, k) == 0) { 
                        b1 = 1; 
                        *(elk.n + MPT) = i + 1; 
                        *(elk.n + SUB) = i + 1; 
                        goto TOP; 
                    } 
                } 
                ++j; 
                if (j == 32)  { 
                    j = 0; 
                    ++ip1; 
                } 
            } 
            goto TOP; 
        case 606:               /* S-bstr{#} = "0"                    */ 
            b1 = 0; 
            ip3 = *(*IPC.q); 
            slen = *ip3++; 
            k = *(IPC.n+1); 
            IPC.n += 2;  
            if (k < 1 || k > slen)  { 
                strsubwarn(k , slen, IPC, 1); 
                goto TOP; 
            } 
            --k; 
            while (k > 31)  { 
                k -= 32; 
                ++ip3; 
            } 
            if ((*ip3 & orbitflag[k]) == 0) b1 = 1; 
            goto TOP; 
        case 607:               /* S-bstr{S-int} = "0"                */ 
            b1 = 0; 
            ip3 = *(*IPC.q); 
            slen = *ip3++; 
            k = *(*(IPC.p+1)); 
            IPC.n += 2; 
            if (k < 1 || k > slen)  { 
                strsubwarn(k , slen, IPC, 1); 
                goto TOP; 
            } 
            --k; 
            while (k > 31)  { 
                k -= 32; 
                ++ip3; 
            } 
            if ((*ip3 & orbitflag[k]) == 0) b1 = 1; 
            goto TOP; 
        case 608:               /* S-bstr{sub-exp} = "0"              */ 
            b1 = 0; 
            TIPC.n = IPC.n; 
            ip3 = *(*IPC.q); 
            ++IPC.n; 
            slen = *ip3++; 
            Zevsub(&k); 
            if (k < 1 || k > slen)  { 
                strsubwarn(k , slen, TIPC, 1); 
                goto TOP; 
            } 
            --k; 
            while (k > 31)  { 
                k -= 32; 
                ++ip3; 
            } 
            if ((*ip3 & orbitflag[k]) == 0) b1 = 1; 
            goto TOP; 
        case 609:               /* S-bstr{#} = "1"                    */ 
            b1 = 0; 
            ip3 = *(*IPC.q); 
            slen = *ip3++; 
            k = *(IPC.n+1); 
            IPC.n += 2; 
            if (k < 1 || k > slen)  { 
                strsubwarn(k , slen, IPC, 1); 
                goto TOP; 
            } 
            --k; 
            while (k > 31)  { 
                k -= 32; 
                ++ip3; 
            } 
            if ((*ip3 & orbitflag[k]) != 0) b1 = 1; 
            goto TOP; 
        case 610:               /* S-bstr{S-int} = "1"                */ 
            b1 = 0; 
            ip3 = *(*IPC.q); 
            slen = *ip3++; 
            k = *(*(IPC.p+1)); 
            IPC.n += 2; 
            if (k < 1 || k > slen)  { 
                strsubwarn(k , slen, IPC, 1); 
                goto TOP; 
            } 
            --k; 
            while (k > 31)  { 
                k -= 32; 
                ++ip3; 
            } 
            if ((*ip3 & orbitflag[k]) != 0) b1 = 1; 
            goto TOP; 
        case 611:               /* S-bstr{sub-exp} = "1"              */ 
            b1 = 0; 
            TIPC.n = IPC.n; 
            ip3 = *(*IPC.q); 
            ++IPC.n; 
            slen = *ip3++; 
            Zevsub(&k); 
            if (k < 1 || k > slen)  { 
                strsubwarn(k , slen, TIPC, 1); 
                goto TOP; 
            } 
            --k; 
            while (k > 31)  { 
                k -= 32; 
                ++ip3; 
            } 
            if ((*ip3 & orbitflag[k]) != 0) b1 = 1; 
            goto TOP; 
        case 612:               /* S-bstr{S-int,#} = "..." (< 33)     */ 
            b1 = 0; 
            ip3 = *(*IPC.q); 
            h = *(*(IPC.p+1)); 
            slen = *ip3++; 
            k = *(IPC.n+2); 
            ip4 = (IPC.n+3); 
            IPC.n += 4; 
            if (h < 1 || h > slen)  { 
                strsubwarn(h, slen, IPC, 1); 
                goto TOP; 
            } 
            --h; 
            if (k + h > slen)  { 
                strsubwarn(k+h, slen, IPC, 2); 
                goto TOP; 
            } 
            ip3 += h >> 5; 
            h &= 0x1f; 
            g = (*ip4 >> 31) & 1; 
            if ((f = *ip3 & orbitflag[h]) != 0) f = 1; 
            if (f == g)  { 
                if (bitcmp(ip3, h, ip4, 0, k) == 0)  b1 = 1; 
            } 
            goto TOP; 
        case 613:               /* S-bstr{sub-exp,#} = "..." (< 33)   */ 
            b1 = 0; 
            TIPC = IPC; 
            ip3 = *(*IPC.q); 
            ++IPC.n; 
            Zevsub(&h); 
            slen = *ip3++; 
            k = *IPC.n; 
            ip4 = (IPC.n+1); 
            IPC.n += 2; 
            if (h < 1 || h > slen)  { 
                strsubwarn(h, slen, TIPC, 1); 
                goto TOP; 
            } 
            --h; 
            if (k + h > slen)  { 
                strsubwarn(k+h, slen, TIPC, 2); 
                goto TOP; 
            } 
            ip3 += h >> 5; 
            h &= 0x1f; 
            g = (*ip4 >> 31) & 1; 
            if ((f = *ip3 & orbitflag[h]) != 0) f = 1; 
            if (f == g)  { 
                if (bitcmp(ip3, h, ip4, 0, k) == 0)  b1 = 1; 
            } 
            goto TOP; 
        case 614:               /* S-bstr{S-int,#} = S-bstr           */ 
            b1 = 0; 
            ip3 = *(*IPC.q); 
            slen = *ip3++; 
            h = *(*(IPC.p+1)); 
            k = *(IPC.n+2); 
            ip4 = *(*(IPC.q+3)); 
            IPC.n += 4; 
            j = *ip4++; 
            if (h < 1 || h > slen)  { 
                strsubwarn(h, slen, IPC, 1); 
                goto TOP; 
            } 
            --h; 
            if (k + h > slen)  { 
                strsubwarn(k+h, slen, IPC, 2); 
                goto TOP; 
            } 
            if (k != j)  goto TOP; 
            ip3 += h >> 5; 
            h &= 0x1f; 
            g = (*ip4 >> 31) & 1; 
            if ((f = *ip3 & orbitflag[h]) != 0) f = 1; 
            if (f == g)  { 
                if (bitcmp(ip3, h, ip4, 0, k) == 0)  b1 = 1; 
            } 
            goto TOP; 
        case 615:               /* S-bstr{sub-exp,#} = S-bstr         */ 
            b1 = 0; 
            TIPC = IPC; 
            ip3 = *(*IPC.q); 
            slen = *ip3++; 
            ++IPC.n; 
            Zevsub(&h); 
            k = *IPC.n; 
            ip4 = *(*(IPC.q+1)); 
            IPC.n += 2; 
            j = *ip4++; 
            if (h < 1 || h > slen)  { 
                strsubwarn(h, slen, TIPC, 1); 
                goto TOP; 
            } 
            --h; 
            if (k + h > slen)  { 
                strsubwarn(k+h, slen, TIPC, 2); 
                goto TOP; 
            } 
            if (k != j)  goto TOP; 
            ip3 += h >> 5; 
            h &= 0x1f; 
            g = (*ip4 >> 31) & 1; 
            if ((f = *ip3 & orbitflag[h]) != 0) f = 1; 
            if (f == g)  { 
                if (bitcmp(ip3, h, ip4, 0, k) == 0)  b1 = 1; 
            } 
            goto TOP; 
        case 616:               /* S-bstr{S-int,#} = A-bstr           */ 
            b1 = 0; 
            TIPC.n = IPC.n; 
            ip3 = *(*IPC.q); 
            slen = *ip3++; 
            h = *(*(IPC.p+1)); 
            k = *(IPC.n+2); 
            IPC.n += 3; 
            ZidA_bstr(&ip4, &j, 1); 
            j = *ip4++; 
            if (h < 1 || h > slen)  { 
                strsubwarn(h, slen, TIPC, 1); 
                goto TOP; 
            } 
            --h; 
            if (k + h > slen)  { 
                strsubwarn(k+h, slen, TIPC, 2); 
                goto TOP; 
            } 
            if (k != j)  goto TOP; 
            ip3 += h >> 5; 
            h &= 0x1f; 
            g = (*ip4 >> 31) & 1; 
            if ((f = *ip3 & orbitflag[h]) != 0) f = 1; 
            if (f == g)  { 
                if (bitcmp(ip3, h, ip4, 0, k) == 0)  b1 = 1; 
            } 
            goto TOP; 
        case 617:               /* S-bstr{sub-exp,#} = A-bstr         */ 
            b1 = 0; 
            TIPC = IPC; 
            ip3 = *(*IPC.q); 
            slen = *ip3++; 
            ++IPC.n; 
            Zevsub(&h); 
            k = *IPC.n; 
            ++IPC.n; 
            ZidA_bstr(&ip4, &j, 1); 
            j = *ip4++; 
            if (h < 1 || h > slen)  { 
                strsubwarn(h, slen, TIPC, 1); 
                goto TOP; 
            } 
            --h; 
            if (k + h > slen)  { 
                strsubwarn(k+h, slen, TIPC, 2); 
                goto TOP; 
            } 
            if (k != j)  goto TOP; 
            ip3 += h >> 5; 
            h &= 0x1f; 
            g = (*ip4 >> 31) & 1; 
            if ((f = *ip3 & orbitflag[h]) != 0) f = 1; 
            if (f == g)  { 
                if (bitcmp(ip3, h, ip4, 0, k) == 0)  b1 = 1; 
            } 
            goto TOP; 
        case 631:               /* A-bstr = ""                        */ 
            ZidA_bstr(&ip1, &mlen, 1); 
            if (*ip1 == 0)  b1 = 1; 
            else            b1 = 0; 
            goto TOP; 
        case 632:               /* A-bstr <> ""                       */ 
            ZidA_bstr(&ip1, &mlen, 1); 
            if (*ip1 != 0)  b1 = 1; 
            else            b1 = 0; 
            goto TOP; 
        case 633:               /* A-bstr con "0"                     */ 
            b1 = 0; 
            ZidA_bstr(&ip1, &mlen, 1); 
            slen = *ip1++; 
            for (i = 0; *ip1 == -1 && i < slen-31; ++ip1)  i += 32; 
            for (j = 0; i < slen; ++j)  { 
                if ((*ip1 & orbitflag[j]) == 0)  { 
                    b1 = 1; 
                    *(elk.n + MPT) = i + 1; 
                    *(elk.n + SUB) = i + i; 
                    goto TOP; 
                } 
                ++i; 
            } 
            goto TOP; 
        case 634:               /* A-bstr con "1"                     */ 
            b1 = 0; 
            ZidA_bstr(&ip1, &mlen, 1); 
            slen = *ip1++; 
            for (i = 0; *ip1 == 0 && i < slen-31; ++ip1)  i += 32; 
            for (j = 0; i < slen; ++j)  { 
                if ((*ip1 & orbitflag[j]) != 0)  { 
                    b1 = 1; 
                    *(elk.n + MPT) = i + 1; 
                    *(elk.n + SUB) = i + i; 
                    goto TOP; 
                } 
                ++i; 
            } 
            goto TOP; 
        case 635:               /* A-bstr con S-bstr1                 */ 
            b1 = 0; 
            ZidA_bstr(&ip1, &mlen, 1); 
            h = *ip1++; 
            ip2 = *(*IPC.q); 
            k = *ip2++; 
            ++IPC.n; 
            if (k == 0 || h < k)  goto TOP; 
            g = (*ip2 >> 31) & 1; 
            for (i = 0, j = 0; i < h - k + 1; ++i)  { 
                if ((f = *ip1 & orbitflag[j]) != 0) f = 1; 
                if (f == g)  { 
                    if (bitcmp(ip1, j, ip2, 0, k) == 0) { 
                        b1 = 1; 
                        *(elk.n + MPT) = i + 1; 
                        *(elk.n + SUB) = i + 1; 
                        goto TOP; 
                    } 
                } 
                ++j; 
                if (j == 32)  { 
                    j = 0; 
                    ++ip1; 
                } 
            } 
            goto TOP; 
        case 636:               /* A-bstr{#} = "0"                    */ 
            b1 = 0; 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            slen = *ip3++; 
            k = *IPC.n; 
            ++IPC.n; 
            if (k < 1 || k > slen)  { 
                strsubwarn(k , slen, TIPC, 1); 
                goto TOP; 
            } 
            --k; 
            while (k > 31)  { 
                k -= 32; 
                ++ip3; 
            } 
            if ((*ip3 & orbitflag[k]) == 0) b1 = 1; 
            goto TOP; 
        case 637:               /* A-bstr{S-int} = "0"                */ 
            b1 = 0; 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            slen = *ip3++; 
            k = *(*IPC.p); 
            ++IPC.n; 
            if (k < 1 || k > slen)  { 
                strsubwarn(k , slen, TIPC, 1); 
                goto TOP; 
            } 
            --k; 
            while (k > 31)  { 
                k -= 32; 
                ++ip3; 
            } 
            if ((*ip3 & orbitflag[k]) == 0) b1 = 1; 
            goto TOP; 
        case 638:               /* A-bstr{sub-exp} = "0"              */ 
            b1 = 0; 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            slen = *ip3++; 
            Zevsub(&k); 
            if (k < 1 || k > slen)  { 
                strsubwarn(k , slen, TIPC, 1); 
                goto TOP; 
            } 
            --k; 
            while (k > 31)  { 
                k -= 32; 
                ++ip3; 
            } 
            if ((*ip3 & orbitflag[k]) == 0) b1 = 1; 
            goto TOP; 
        case 639:               /* A-bstr{#} = "1"                    */ 
            b1 = 0; 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            slen = *ip3++; 
            k = *(IPC.n+1); 
            ++IPC.n; 
            if (k < 1 || k > slen)  { 
                strsubwarn(k , slen, TIPC, 1); 
                goto TOP; 
            } 
            --k; 
            while (k > 31)  { 
                k -= 32; 
                ++ip3; 
            } 
            if ((*ip3 & orbitflag[k]) != 0) b1 = 1; 
            goto TOP; 
        case 640:               /* A-bstr{S-int} = "1"                */ 
            b1 = 0; 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            slen = *ip3++; 
            k = *(*IPC.p); 
            ++IPC.n;
            if (k < 1 || k > slen)  { 
                strsubwarn(k , slen, TIPC, 1); 
                goto TOP; 
            } 
            --k; 
            while (k > 31)  { 
                k -= 32; 
                ++ip3; 
            } 
            if ((*ip3 & orbitflag[k]) != 0) b1 = 1; 
            goto TOP; 
        case 641:               /* A-bstr{sub-exp} = "1"              */ 
            b1 = 0; 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            slen = *ip3++; 
            Zevsub(&k); 
            if (k < 1 || k > slen)  { 
                strsubwarn(k , slen, TIPC, 1); 
                goto TOP; 
            } 
            --k; 
            while (k > 31)  { 
                k -= 32; 
                ++ip3; 
            } 
            if ((*ip3 & orbitflag[k]) != 0) b1 = 1; 
            goto TOP; 
        case 642:               /* A-bstr{S-int,#} = "..." (< 33)     */ 
            b1 = 0; 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            slen = *ip3++; 
            h = *(*IPC.p); 
            k = *(IPC.n+1); 
            ip4 = (IPC.n+2); 
            IPC.n += 3; 
            if (h < 1 || h > slen)  { 
                strsubwarn(h, slen, TIPC, 1); 
                goto TOP; 
            } 
            --h; 
            if (k + h > slen)  { 
                strsubwarn(k+h, slen, TIPC, 2); 
                goto TOP; 
            } 
            ip3 += h >> 5; 
            h &= 0x1f; 
            g = (*ip4 >> 31) & 1; 
            if ((f = *ip3 & orbitflag[h]) != 0) f = 1; 
            if (f == g)  { 
                if (bitcmp(ip3, h, ip4, 0, k) == 0)  b1 = 1; 
            } 
            goto TOP; 
        case 643:               /* A-bstr{sub-exp,#} = "..." (< 33)   */ 
            b1 = 0; 
            TIPC = IPC; 
            ZidA_bstr(&ip3, &mlen, 1); 
            slen = *ip3++; 
            Zevsub(&h); 
            k = *IPC.n; 
            ip4 = (IPC.n+1); 
            IPC.n += 2; 
            if (h < 1 || h > slen)  { 
                strsubwarn(h, slen, TIPC, 1); 
                goto TOP; 
            } 
            --h; 
            if (k + h > slen)  { 
                strsubwarn(k+h, slen, TIPC, 2); 
                goto TOP; 
            } 
            ip3 += h >> 5; 
            h &= 0x1f; 
            g = (*ip4 >> 31) & 1; 
            if ((f = *ip3 & orbitflag[h]) != 0) f = 1; 
            if (f == g)  { 
                if (bitcmp(ip3, h, ip4, 0, k) == 0)  b1 = 1; 
            } 
            goto TOP; 
        case 644:               /* A-bstr{S-int,#} = S-bstr           */ 
            b1 = 0; 
            TIPC = IPC; 
            ZidA_bstr(&ip3, &mlen, 1); 
            slen = *ip3++; 
            h = *(*IPC.p); 
            k = *(IPC.n+1); 
            ip4 = *(*(IPC.q+2)); 
            j = *ip4++; 
            IPC.n += 3; 
            if (h < 1 || h > slen)  { 
                strsubwarn(h, slen, TIPC, 1); 
                goto TOP; 
            } 
            --h; 
            if (k + h > slen)  { 
                strsubwarn(k+h, slen, TIPC, 2); 
                goto TOP; 
            } 
            if (k != j)  goto TOP; 
            ip3 += h >> 5; 
            h &= 0x1f; 
            g = (*ip4 >> 31) & 1; 
            if ((f = *ip3 & orbitflag[h]) != 0) f = 1; 
            if (f == g)  { 
                if (bitcmp(ip3, h, ip4, 0, k) == 0)  b1 = 1; 
            } 
            goto TOP; 
        case 645:               /* A-bstr{sub-exp,#} = S-bstr         */ 
            b1 = 0; 
            TIPC = IPC; 
            ZidA_bstr(&ip3, &mlen, 1); 
            slen = *ip3++; 
            Zevsub(&h); 
            k = *IPC.n; 
            ip4 = *(*(IPC.q+1)); 
            j = *ip4++; 
            IPC.n += 2; 
            if (h < 1 || h > slen)  { 
                strsubwarn(h, slen, TIPC, 1); 
                goto TOP; 
            } 
            --h; 
            if (k + h > slen)  { 
                strsubwarn(k+h, slen, TIPC, 2); 
                goto TOP; 
            } 
            if (k != j)  goto TOP; 
            ip3 += h >> 5; 
            h &= 0x1f; 
            g = (*ip4 >> 31) & 1; 
            if ((f = *ip3 & orbitflag[h]) != 0) f = 1; 
            if (f == g)  { 
                if (bitcmp(ip3, h, ip4, 0, k) == 0)  b1 = 1; 
            } 
            goto TOP; 
        case 646:               /* A-bstr{S-int,#} = A-bstr           */ 
            b1 = 0; 
            TIPC.n = IPC.n; 
            ZidA_bstr(&ip3, &mlen, 1); 
            slen = *ip3++; 
            h = *(*IPC.p); 
            k = *(IPC.n+1); 
            IPC.n += 2; 
            ZidA_bstr(&ip4, &j, 1); 
            j = *ip4++; 
            if (h < 1 || h > slen)  { 
                strsubwarn(h, slen, TIPC, 1); 
                goto TOP; 
            } 
            --h; 
            if (k + h > slen)  { 
                strsubwarn(k+h, slen, TIPC, 2); 
                goto TOP; 
            } 
            if (k != j)  goto TOP; 
            ip3 += h >> 5; 
            h &= 0x1f; 
            g = (*ip4 >> 31) & 1; 
            if ((f = *ip3 & orbitflag[h]) != 0) f = 1; 
            if (f == g)  { 
                if (bitcmp(ip3, h, ip4, 0, k) == 0)  b1 = 1; 
            } 
            goto TOP; 
        case 647:               /* A-bstr{sub-exp,#} = A-bstr         */ 
            b1 = 0; 
            TIPC = IPC; 
            ZidA_bstr(&ip3, &mlen, 1); 
            slen = *ip3++; 
            Zevsub(&h); 
            k = *IPC.n; 
            ++IPC.n; 
            ZidA_bstr(&ip4, &j, 1); 
            j = *ip4++; 
            if (h < 1 || h > slen)  { 
                strsubwarn(h, slen, TIPC, 1L); 
                goto TOP; 
            } 
            --h; 
            if (k + h > slen)  { 
                strsubwarn(k+h, slen, TIPC, 2L); 
                goto TOP; 
            } 
            if (k != j)  goto TOP; 
            ip3 += h >> 5; 
            h &= 0x1f; 
            g = (*ip4 >> 31) & 1; 
            if ((f = *ip3 & orbitflag[h]) != 0) f = 1; 
            if (f == g)  { 
                if (bitcmp(ip3, h, ip4, 0, k) == 0)  b1 = 1; 
            } 
            goto TOP; 
        case 661:               /* bs (gen str) = bs (gen str)        */ 
            b1 = 0; 
            Zrel_idsubbitstr(&ip1, &off1, &h); 
            Zrel_idsubbitstr(&ip2, &off2, &k); 
            if (h == -1 || k == -1)  goto TOP; 
            if (h != k) goto TOP; 
            if (bitcmp(ip1, off1, ip2, off2, k) == 0)  b1 = 1; 
            goto TOP; 
        case 662:               /* bs (gen str) > bs (gen str)        */ 
            b1 = 0; 
            Zrel_idsubbitstr(&ip1, &off1, &h); 
            Zrel_idsubbitstr(&ip2, &off2, &k); 
            if (h == -1 || k == -1)  goto TOP; 
            j = (h < k) ? h : k; 
            if ((i = bitcmp(ip1, off1, ip2, off2, j)) < 0)  goto TOP; 
            if (i > 0 || h > k)         b1 = 1; 
            goto TOP; 
        case 663:               /* bs (gen str) < bs (gen str)        */ 
            b1 = 0; 
            Zrel_idsubbitstr(&ip1, &off1, &h); 
            Zrel_idsubbitstr(&ip2, &off2, &k); 
            if (h == -1 || k == -1)  goto TOP; 
            j = (h < k) ? h : k; 
            if ((i = bitcmp(ip1, off1, ip2, off2, j)) > 0)  goto TOP; 
            if (i < 0 || h < k)         b1 = 1; 
            goto TOP; 
        case 664:               /* bs (gen str) <> bs (gen str)       */ 
            Zrel_idsubbitstr(&ip1, &off1, &h); 
            Zrel_idsubbitstr(&ip2, &off2, &k); 
            if (h == -1 || k == -1)  { 
                b1 = 0; 
                goto TOP; 
            } 
            b1 = 1; 
            if (h != k) goto TOP; 
            if (bitcmp(ip1, off1, ip2, off2, k) == 0)  b1 = 0; 
            goto TOP; 
        case 665:               /* bs (gen str) >= bs (gen str)       */ 
            b1 = 0; 
            Zrel_idsubbitstr(&ip1, &off1, &h); 
            Zrel_idsubbitstr(&ip2, &off2, &k); 
            if (h == -1 || k == -1)  goto TOP; 
            j = (h < k) ? h : k; 
            if ((i = bitcmp(ip1, off1, ip2, off2, j)) < 0)  goto TOP; 
            if (i > 0 || h >= k)         b1 = 1; 
            goto TOP; 
        case 666:               /* bs (gen str) <= bs (gen str)       */ 
            b1 = 0; 
            Zrel_idsubbitstr(&ip1, &off1, &h); 
            Zrel_idsubbitstr(&ip2, &off2, &k); 
            if (h == -1 || k == -1)  goto TOP; 
            j = (h < k) ? h : k; 
            if ((i = bitcmp(ip1, off1, ip2, off2, j)) > 0)  goto TOP; 
            if (i < 0 || h <= k)         b1 = 1; 
            goto TOP; 
        case 667:               /* bs (gen str) con bs (gen str)      */ 
            b1 = 0; 
            Zrel_idgenstr(&ip3, 2); 
            ++ip3; 
            Zrel_idsubbitstr(&ip1, &off1, &h); 
            Zrel_idsubbitstr(&ip2, &off2, &k); 
            if (h <= 0 || k <= 0)     goto TOP; 
            a = (ip1 - ip3); 
            a <<= 5; 
            a += off1; 
            g = (*ip2 >> (31-off2)) & 1;      /* 0 <= off2 <= 31 */ 
            for (i = 0, j = off1; i < h - k + 1; ++i)  { 
                if ((f = *ip1 & orbitflag[j]) != 0) f = 1; 
                if (f == g)  { 
                    if (bitcmp(ip1, j, ip2, off2, k) == 0) { 
                        b1 = 1; 
                        *(elk.n + MPT) = i + 1; 
                        *(elk.n + SUB) = i + 1 + a; 
                        goto TOP; 
                    } 
                } 
                ++j; 
                if (j == 32)  { 
                    j = 0; 
                    ++ip1; 
                } 
            } 
            goto TOP; 
        case 681:               /* bs (gen str) (>=<) bs (gen str)    */ 
            b1 = 2; 
            Zrel_idsubbitstr(&ip1, &off1, &h); 
            Zrel_idsubbitstr(&ip2, &off2, &k); 
            if (h == -1)  { 
                if (k == -1) b1 = 3; 
                else         b1 = 4; 
                goto TOP; 
            } 
            if (k == -1)     goto TOP; 
            j = (h < k) ? h : k; 
            if ((i = bitcmp(ip1, off1, ip2, off2, j)) == 0 && h == k) { 
                b1 = 3; 
                goto TOP; 
            } 
            if (i > 0)       goto TOP; 
            if (i < 0 || h < k)  b1 = 4; 
            goto TOP; 

/*  INTEGER RELATIONS  */ 
        case 701:               /* S-int = 0                          */ 
            if (*(*IPC.p) == 0)  b1 = 1; 
            else                 b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 702:               /* S-int > 0                          */ 
            if (*(*IPC.p) > 0)   b1 = 1; 
            else                 b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 703:               /* S-int < 0                          */ 
            if (*(*IPC.p) < 0)   b1 = 1; 
            else                 b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 704:               /* S-int = 1                          */ 
            if (*(*IPC.p) == 1)  b1 = 1; 
            else                 b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 705:               /* S-int = #                          */ 
            if (*(*IPC.p) == *(IPC.n+1)) b1 = 1; 
            else                         b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 706:               /* S-int > #                          */ 
            if (*(*IPC.p) >  *(IPC.n+1)) b1 = 1; 
            else                         b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 707:               /* S-int < #                          */ 
            if (*(*IPC.p) <  *(IPC.n+1)) b1 = 1; 
            else                         b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 708:               /* S-int <> #                         */ 
            if (*(*IPC.p) != *(IPC.n+1)) b1 = 1; 
            else                         b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 709:               /* S-int >= #                          */ 
            if (*(*IPC.p) >= *(IPC.n+1)) b1 = 1; 
            else                         b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 710:               /* S-int <= #                          */ 
            if (*(*IPC.p) <= *(IPC.n+1)) b1 = 1; 
            else                         b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 711:               /* rem = 0                             */ 
            if (*(elk.n + REM) == 0)     b1 = 1; 
            else                         b1 = 0; 
            goto TOP; 
        case 712:               /* rem > 0                             */ 
            if (*(elk.n + REM) > 0)      b1 = 1; 
            else                         b1 = 0; 
            goto TOP; 
        case 713:               /* mpt = 0                             */ 
            if (*(elk.n + MPT) == *(IPC.n))  b1 = 1; 
            else                             b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 714:               /* S-int = S-int1                     */ 
            if (*(*IPC.p) == *(*(IPC.p+1))) b1 = 1; 
            else                            b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 715:               /* S-int > S-int1                     */ 
            if (*(*IPC.p) >  *(*(IPC.p+1))) b1 = 1; 
            else                            b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 716:               /* S-int < S-int1                     */ 
            if (*(*IPC.p) <  *(*(IPC.p+1))) b1 = 1; 
            else                            b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 717:               /* S-int <> S-int1                    */ 
            if (*(*IPC.p) != *(*(IPC.p+1))) b1 = 1; 
            else                            b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 718:               /* S-int >= S-int1                     */ 
            if (*(*IPC.p) >= *(*(IPC.p+1))) b1 = 1; 
            else                            b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 719:               /* S-int <= S-int1                     */ 
            if (*(*IPC.p) <= *(*(IPC.p+1))) b1 = 1; 
            else                            b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 720:               /* S-int = exp                        */ 
            h = *(*IPC.p); 
            ++IPC.n; 
            k = Zgenintex();              /* RHS */ 
            if (h == k)      b1 = 1; 
            else             b1 = 0; 
            goto TOP; 
        case 721:               /* S-int > exp                        */ 
            h = *(*IPC.p); 
            ++IPC.n; 
            k = Zgenintex();              /* RHS */ 
            if (h > k)       b1 = 1; 
            else             b1 = 0; 
            goto TOP; 
        case 722:               /* S-int < exp                        */ 
            h = *(*IPC.p); 
            ++IPC.n; 
            k = Zgenintex();              /* RHS */ 
            if (h < k)       b1 = 1; 
            else             b1 = 0; 
            goto TOP; 
        case 723:               /* S-int <> exp                       */ 
            h = *(*IPC.p); 
            ++IPC.n; 
            k = Zgenintex();              /* RHS */ 
            if (h != k)      b1 = 1; 
            else             b1 = 0; 
            goto TOP; 
        case 724:               /* S-int >= exp                        */ 
            h = *(*IPC.p); 
            ++IPC.n; 
            k = Zgenintex();              /* RHS */ 
            if (h >= k)      b1 = 1; 
            else             b1 = 0; 
            goto TOP; 
        case 725:               /* S-int <= exp                        */ 
            h = *(*IPC.p); 
            ++IPC.n; 
            k = Zgenintex();              /* RHS */ 
            if (h <= k)      b1 = 1; 
            else             b1 = 0; 
            goto TOP; 
        case 726:               /* S-int = A-int1{#}                  */ 
            if (*(*IPC.p) == *(*(IPC.p+1))) b1 = 1; 
            else                            b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 727:               /* S-int > A-int1{#}                  */ 
            if (*(*IPC.p) >  *(*(IPC.p+1))) b1 = 1; 
            else                            b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 728:               /* S-int < A-int1{#}                  */ 
            if (*(*IPC.p) <  *(*(IPC.p+1))) b1 = 1; 
            else                            b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 729:               /* S-int <> A-int1{#}                 */ 
            if (*(*IPC.p) != *(*(IPC.p+1))) b1 = 1; 
            else                            b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 730:               /* S-int >= A-int1{#}                  */ 
            if (*(*IPC.p) >= *(*(IPC.p+1))) b1 = 1; 
            else                            b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 731:               /* S-int <= A-int1{#}                  */ 
            if (*(*IPC.p) <= *(*(IPC.p+1))) b1 = 1; 
            else                            b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 732:               /* S-int > len(S-str)                  */ 
            if (*(*IPC.p) > *(*(*(IPC.q+1))))  b1 = 1; 
            else                               b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 733:               /* S-int < len(S-str)                  */ 
            if (*(*IPC.p) < *(*(*(IPC.q+1))))  b1 = 1; 
            else                               b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 734:               /* S-int >= len(S-str)                  */ 
            if (*(*IPC.p) >= *(*(*(IPC.q+1)))) b1 = 1; 
            else                               b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 735:               /* S-int <= len(S-str)                  */ 
            if (*(*IPC.p) <= *(*(*(IPC.q+1)))) b1 = 1; 
            else                               b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 736:               /* bit(#,S-int) = 0                     */ 
            k = *IPC.n; 
            k &= 0x1f; 
            h = *(*(IPC.p+1)); 
            if ((testbitflag[k] & h) == 0)  b1 = 1; 
            else                            b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 737:               /* bit(#,S-int) = 1                     */ 
            k = *IPC.n; 
            k &= 0x1f; 
            h = *(*(IPC.p+1)); 
            if ((testbitflag[k] & h) != 0)  b1 = 1; 
            else                            b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 738:               /* len(S-str) > #                       */ 
            if (*(*(*IPC.q)) > *(IPC.n+1))   b1 = 1; 
            else                             b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 751:               /* A-int = 0                            */ 
            ip1 = Zidint(); 
            if (*ip1 == 0)            b1 = 1; 
            else                      b1 = 0; 
            goto TOP; 
        case 752:               /* A-int > 0                            */ 
            ip1 = Zidint(); 
            if (*ip1 > 0)             b1 = 1; 
            else                      b1 = 0; 
            goto TOP; 
        case 753:               /* A-int < 0                            */ 
            ip1 = Zidint(); 
            if (*ip1 < 0)             b1 = 1; 
            else                      b1 = 0; 
            goto TOP; 
        case 754:               /* A-int = 1                            */ 
            ip1 = Zidint(); 
            if (*ip1 == 1)            b1 = 1; 
            else                      b1 = 0; 
            goto TOP; 
        case 755:               /* A-int = #                            */ 
            ip1 = Zidint(); 
            if (*ip1 == *IPC.n)       b1 = 1; 
            else                      b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 756:               /* A-int > #                            */ 
            ip1 = Zidint(); 
            if (*ip1 > *IPC.n)        b1 = 1; 
            else                      b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 757:               /* A-int < #                            */ 
            ip1 = Zidint(); 
            if (*ip1 < *IPC.n)        b1 = 1; 
            else                      b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 758:               /* A-int <> #                           */ 
            ip1 = Zidint(); 
            if (*ip1 != *IPC.n)       b1 = 1; 
            else                      b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 759:               /* A-int >= #                           */ 
            ip1 = Zidint(); 
            if (*ip1 >= *IPC.n)       b1 = 1; 
            else                      b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 760:               /* A-int <= #                           */ 
            ip1 = Zidint(); 
            if (*ip1 <= *IPC.n)       b1 = 1; 
            else                      b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 761:               /* A-int = S-int1                       */ 
            ip1 = Zidint(); 
            if (*ip1 == *(*IPC.p))    b1 = 1; 
            else                      b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 762:               /* A-int > S-int1                       */ 
            ip1 = Zidint(); 
            if (*ip1 > *(*IPC.p))     b1 = 1; 
            else                      b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 763:               /* A-int < S-int1                       */ 
            ip1 = Zidint(); 
            if (*ip1 < *(*IPC.p))     b1 = 1; 
            else                      b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 764:               /* A-int <> S-int1                      */ 
            ip1 = Zidint(); 
            if (*ip1 != *(*IPC.p))    b1 = 1; 
            else                      b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 765:               /* A-int >= S-int1                      */ 
            ip1 = Zidint(); 
            if (*ip1 >= *(*IPC.p))    b1 = 1; 
            else                      b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 766:               /* A-int <= S-int1                      */ 
            ip1 = Zidint(); 
            if (*ip1 <= *(*IPC.p))    b1 = 1; 
            else                      b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 767:               /* A-int = exp                          */ 
            ip1 = Zidint(); 
            k = Zgenintex();              /* RHS */ 
            if (*ip1 == k)            b1 = 1; 
            else                      b1 = 0; 
            goto TOP; 
        case 768:               /* A-int > exp                          */ 
            ip1 = Zidint(); 
            k = Zgenintex();              /* RHS */ 
            if (*ip1 > k)             b1 = 1; 
            else                      b1 = 0; 
            goto TOP; 
        case 769:               /* A-int < exp                          */ 
            ip1 = Zidint(); 
            k = Zgenintex();              /* RHS */ 
            if (*ip1 < k)             b1 = 1; 
            else                      b1 = 0; 
            goto TOP; 
        case 770:               /* A-int <> exp                         */ 
            ip1 = Zidint(); 
            k = Zgenintex();              /* RHS */ 
            if (*ip1 != k)            b1 = 1; 
            else                      b1 = 0; 
            goto TOP; 
        case 771:               /* A-int >= exp                         */ 
            ip1 = Zidint(); 
            k = Zgenintex();              /* RHS */ 
            if (*ip1 >= k)            b1 = 1; 
            else                      b1 = 0; 
            goto TOP; 
        case 772:               /* A-int <= exp                         */ 
            ip1 = Zidint(); 
            k = Zgenintex();              /* RHS */ 
            if (*ip1 <= k)            b1 = 1; 
            else                      b1 = 0; 
            goto TOP; 
        case 781:               /* exp = exp1                           */ 
            h = Zgenintex();              /* LHS */ 
            k = Zgenintex();              /* RHS */ 
            if (h == k)               b1 = 1; 
            else                      b1 = 0; 
            goto TOP; 
        case 782:               /* exp > exp1                           */ 
            h = Zgenintex();              /* LHS */ 
            k = Zgenintex();              /* RHS */ 
            if (h > k)                b1 = 1; 
            else                      b1 = 0; 
            goto TOP; 
        case 783:               /* exp < exp1                           */ 
            h = Zgenintex();              /* LHS */ 
            k = Zgenintex();              /* RHS */ 
            if (h < k)                b1 = 1; 
            else                      b1 = 0; 
            goto TOP; 
        case 784:               /* exp <> exp1                          */ 
            h = Zgenintex();              /* LHS */ 
            k = Zgenintex();              /* RHS */ 
            if (h != k)               b1 = 1; 
            else                      b1 = 0; 
            goto TOP; 
        case 785:               /* exp >= exp1                          */ 
            h = Zgenintex();              /* LHS */ 
            k = Zgenintex();              /* RHS */ 
            if (h >= k)               b1 = 1; 
            else                      b1 = 0; 
            goto TOP; 
        case 786:               /* exp <= exp1                          */ 
            h = Zgenintex();              /* LHS */ 
            k = Zgenintex();              /* RHS */ 
            if (h <= k)               b1 = 1; 
            else                      b1 = 0; 
            goto TOP; 
        case 791:               /* S-int (>=<) #                        */ 
            b1 = 2; 
            h = *(*IPC.p); 
            k = *(IPC.n+1); 
            IPC.n += 2; 
            if (h == k)  { 
                b1 = 3; 
                goto TOP; 
            } 
            if (h < k)  b1 = 4; 
            goto TOP; 
        case 792:               /* S-int (>=<) S-int1                   */ 
            b1 = 2; 
            h = *(*IPC.p); 
            k = *(*(IPC.p+1)); 
            IPC.n += 2; 
            if (h == k)  { 
                b1 = 3; 
                goto TOP; 
            } 
            if (h < k)  b1 = 4; 
            goto TOP; 
        case 793:               /* A-int (>=<) #                        */ 
            b1 = 2; 
            ip1 = Zidint(); 
            h = *ip1; 
            k = *IPC.n; 
            ++IPC.n; 
            if (h == k)  { 
                b1 = 3; 
                goto TOP; 
            } 
            if (h < k)  b1 = 4; 
            goto TOP; 
        case 794:               /* A-int (>=<) S-int1                   */ 
            b1 = 2; 
            ip1 = Zidint(); 
            h = *ip1; 
            k = *(*IPC.p); 
            ++IPC.n; 
            if (h == k)  { 
                b1 = 3; 
                goto TOP; 
            } 
            if (h < k)  b1 = 4; 
            goto TOP; 
        case 795:               /* exp (>=<) exp1                       */ 
            b1 = 2; 
            h = Zgenintex();              /* LHS */ 
            k = Zgenintex();              /* RHS */ 
            if (h == k)  { 
                b1 = 3; 
                goto TOP; 
            } 
            if (h < k)  b1 = 4; 
            goto TOP; 

/*  REAL RELATIONS  */ 
        case 801:               /* S-real = 0.0                         */ 
            x = (double *)  (*IPC.p); 
            if (*x == 0)               b1 = 1; 
            else                       b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 802:               /* S-real > 0.0                         */ 
            x = (double *)  (*IPC.p); 
            if (*x > 0)                b1 = 1; 
            else                       b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 803:               /* S-real < 0.0                         */ 
            x = (double *)  (*IPC.p); 
            if (*x < 0)                b1 = 1; 
            else                       b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 804:               /* S-real = literal (in-line)           */ 
            x = (double *)  (*IPC.p); 
            y = (double *)  (IPC.n+1); 
            if (*x == *y)              b1 = 1; 
            else                       b1 = 0; 
            IPC.n += 3; 
            goto TOP; 
        case 805:               /* S-real > literal (in-line)           */ 
            x = (double *)  (*IPC.p); 
            y = (double *)  (IPC.n+1); 
            if (*x > *y)               b1 = 1; 
            else                       b1 = 0; 
            IPC.n += 3; 
            goto TOP; 
        case 806:               /* S-real < literal (in-line)           */ 
            x = (double *)  (*IPC.p); 
            y = (double *)  (IPC.n+1); 
            if (*x < *y)               b1 = 1; 
            else                       b1 = 0; 
            IPC.n += 3; 
            goto TOP; 
        case 807:               /* S-real <> literal (in-line)          */ 
            x = (double *)  (*IPC.p); 
            y = (double *)  (IPC.n+1); 
            if (*x != *y)              b1 = 1; 
            else                       b1 = 0; 
            IPC.n += 3; 
            goto TOP; 
        case 808:               /* S-real >= literal (in-line)          */ 
            x = (double *)  (*IPC.p); 
            y = (double *)  (IPC.n+1); 
            if (*x >= *y)              b1 = 1; 
            else                       b1 = 0; 
            IPC.n += 3; 
            goto TOP; 
        case 809:               /* S-real <= literal (in-line)          */ 
            x = (double *)  (*IPC.p); 
            y = (double *)  (IPC.n+1); 
            if (*x <= *y)              b1 = 1; 
            else                       b1 = 0; 
            IPC.n += 3; 
            goto TOP; 
        case 810:               /* S-real = S-real1                     */ 
            x = (double *)  (*IPC.p); 
            y = (double *)  (*(IPC.p+1)); 
            if (*x == *y)              b1 = 1; 
            else                       b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 811:               /* S-real > S-real1                     */ 
            x = (double *)  (*IPC.p); 
            y = (double *)  (*(IPC.p+1)); 
            if (*x > *y)               b1 = 1; 
            else                       b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 812:               /* S-real < S-real1                     */ 
            x = (double *)  (*IPC.p); 
            y = (double *)  (*(IPC.p+1)); 
            if (*x < *y)               b1 = 1; 
            else                       b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 813:               /* S-real <> S-real1                    */ 
            x = (double *)  (*IPC.p); 
            y = (double *)  (*(IPC.p+1)); 
            if (*x != *y)              b1 = 1; 
            else                       b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 814:               /* S-real >= S-real1                    */ 
            x = (double *)  (*IPC.p); 
            y = (double *)  (*(IPC.p+1)); 
            if (*x >= *y)              b1 = 1; 
            else                       b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 815:               /* S-real <= S-real1                    */ 
            x = (double *)  (*IPC.p); 
            y = (double *)  (*(IPC.p+1)); 
            if (*x <= *y)              b1 = 1; 
            else                       b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 816:               /* S-real = real exp                    */ 
            x = (double *)  (*IPC.p); 
            ++IPC.n; 
            Zgenfltex(&z); 
            if (*x == z)               b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 817:               /* S-real > real exp                    */ 
            x = (double *)  (*IPC.p); 
            ++IPC.n; 
            Zgenfltex(&z); 
            if (*x > z)                b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 818:               /* S-real < real exp                    */ 
            x = (double *)  (*IPC.p); 
            ++IPC.n; 
            Zgenfltex(&z); 
            if (*x < z)                b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 819:               /* S-real <> real exp                   */ 
            x = (double *)  (*IPC.p); 
            ++IPC.n; 
            Zgenfltex(&z); 
            if (*x != z)               b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 820:               /* S-real >= real exp                   */ 
            x = (double *)  (*IPC.p); 
            ++IPC.n; 
            Zgenfltex(&z); 
            if (*x >= z)               b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 821:               /* S-real <= real exp                   */ 
            x = (double *)  (*IPC.p); 
            ++IPC.n; 
            Zgenfltex(&z); 
            if (*x <= z)               b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 831:               /* A-real = 0.0                         */ 
            Zidreal(&x); 
            if (*x == 0)               b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 832:               /* A-real > 0.0                         */ 
            Zidreal(&x); 
            if (*x > 0)                b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 833:               /* A-real < 0.0                         */ 
            Zidreal(&x); 
            if (*x < 0)                b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 834:               /* A-real = literal (in-line)           */ 
            Zidreal(&x); 
            y = (double *)  (IPC.n); 
            if (*x == *y)              b1 = 1; 
            else                       b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 835:               /* A-real > literal (in-line)           */ 
            Zidreal(&x); 
            y = (double *)  (IPC.n); 
            if (*x > *y)               b1 = 1; 
            else                       b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 836:               /* A-real < literal (in-line)           */ 
            Zidreal(&x); 
            y = (double *)  (IPC.n); 
            if (*x < *y)               b1 = 1; 
            else                       b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 837:               /* A-real <> literal (in-line)          */ 
            Zidreal(&x); 
            y = (double *)  (IPC.n); 
            if (*x != *y)              b1 = 1; 
            else                       b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 838:               /* A-real >= literal (in-line)          */ 
            Zidreal(&x); 
            y = (double *)  (IPC.n); 
            if (*x >= *y)              b1 = 1; 
            else                       b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 839:               /* A-real <= literal (in-line)          */ 
            Zidreal(&x); 
            y = (double *)  (IPC.n); 
            if (*x <= *y)              b1 = 1; 
            else                       b1 = 0; 
            IPC.n += 2; 
            goto TOP; 
        case 840:               /* A-real = S-real1                     */ 
            Zidreal(&x); 
            y = (double *)  (*IPC.p); 
            if (*x == *y)              b1 = 1; 
            else                       b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 841:               /* A-real > S-real1                     */ 
            Zidreal(&x); 
            y = (double *)  (*IPC.p); 
            if (*x > *y)               b1 = 1; 
            else                       b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 842:               /* A-real < S-real1                     */ 
            Zidreal(&x); 
            y = (double *)  (*IPC.p); 
            if (*x < *y)               b1 = 1; 
            else                       b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 843:               /* A-real <> S-real1                    */ 
            Zidreal(&x); 
            y = (double *)  (*IPC.p); 
            if (*x != *y)              b1 = 1; 
            else                       b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 844:               /* A-real >= S-real1                    */ 
            Zidreal(&x); 
            y = (double *)  (*IPC.p); 
            if (*x >= *y)              b1 = 1; 
            else                       b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 845:               /* A-real <= S-real1                    */ 
            Zidreal(&x); 
            y = (double *)  (*IPC.p); 
            if (*x <= *y)              b1 = 1; 
            else                       b1 = 0; 
            ++IPC.n; 
            goto TOP; 
        case 846:               /* A-real = real exp                    */ 
            Zidreal(&x); 
            Zgenfltex(&z); 
            if (*x == z)               b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 847:               /* A-real > real exp                    */ 
            Zidreal(&x); 
            Zgenfltex(&z); 
            if (*x > z)                b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 848:               /* A-real < real exp                    */ 
            Zidreal(&x); 
            Zgenfltex(&z); 
            if (*x < z)                b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 849:               /* A-real <> real exp                   */ 
            Zidreal(&x); 
            Zgenfltex(&z); 
            if (*x != z)               b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 850:               /* A-real >= real exp                   */ 
            Zidreal(&x); 
            Zgenfltex(&z); 
            if (*x >= z)               b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 851:               /* A-real <= real exp                   */ 
            Zidreal(&x); 
            Zgenfltex(&z); 
            if (*x <= z)               b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 861:               /* real exp = real exp1                 */ 
            Zgenfltex(&w); 
            Zgenfltex(&z); 
            if (w == z)                b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 862:               /* real exp > real exp1                 */ 
            Zgenfltex(&w); 
            Zgenfltex(&z); 
            if (w > z)                 b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 863:               /* real exp < real exp1                 */ 
            Zgenfltex(&w); 
            Zgenfltex(&z); 
            if (w < z)                 b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 864:               /* real exp <> real exp1                */ 
            Zgenfltex(&w); 
            Zgenfltex(&z); 
            if (w != z)                b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 865:               /* real exp >= real exp1                */ 
            Zgenfltex(&w); 
            Zgenfltex(&z); 
            if (w >= z)                b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 866:               /* real exp <= real exp1                */ 
            Zgenfltex(&w); 
            Zgenfltex(&z); 
            if (w <= z)                b1 = 1; 
            else                       b1 = 0; 
            goto TOP; 
        case 881:               /* S-real (>=<) literal                 */ 
            b1 = 2; 
            x = (double *) (*IPC.p); 
            y = (double *) (IPC.n+1); 
            IPC.n += 3; 
            if (*x == *y)  { 
                b1 = 3; 
                goto TOP; 
            } 
            if (*x < *y)  b1 = 4; 
            goto TOP; 
        case 882:               /* A-real (>=<) literal                 */ 
            b1 = 2; 
            Zidreal(&x); 
            y = (double *) (IPC.n); 
            IPC.n += 2; 
            if (*x == *y)  { 
                b1 = 3; 
                goto TOP; 
            } 
            if (*x < *y)  b1 = 4; 
            goto TOP; 
        case 883:               /* real exp (>=<) real exp1             */ 
            b1 = 2; 
            Zgenfltex(&w); 
            Zgenfltex(&z); 
            if (w == z)  { 
                b1 = 3; 
                goto TOP; 
            } 
            if (w < z)  b1 = 4; 
            goto TOP; 

        case 901:               /* midistart                            */ 
            goto TOP; 
        case 902:               /* midistop                             */ 
            goto TOP; 
        case 903:               /* midiput  <string>                    */ 
            Zcallmidiput(); 
            goto TOP; 
        case 904:               /* midiget  <int-var>                   */ 
            Zcallmidiget(); 
            goto TOP; 
        case 905:               /* miditime <int-var>                   */ 
            *(*IPC.p) = 0; 
            ++IPC.n; 
            goto TOP; 
        case 906:               /* getx int                             */ 
            *(*IPC.p) = 0; 
            ++IPC.n; 
            goto TOP; 
    } 
    ++IPC.n; 
    goto TOP; 



/*  MORE STRINGS  */ 

A113A: 
    ++IPC.n; 
    ip3 = *(*TIPC.q); 
A143A:             
    sp3 = ztv.zmaxtemp;            /* temporary target is maxtemp */ 
    Zidsubstr(&sp2, &slen, &nxop, &i); 
    if (slen > mlen)           strlenerr(slen, mlen, TIPC, 0); 
    if (slen > maxstringlen)   strlenerr(slen, maxstringlen, TIPC, 1); 
    memcpy((void *) sp3, (const void *) sp2, (size_t) slen); 
    sp3 += slen; 
    i = maxstringlen + 0x3fffffff; 
    Zappendstr(sp3, i, &slen, nxop, TIPC); 
    if (slen > mlen)           strlenerr(slen, mlen, TIPC, 0); 
    sp1 = (char *) (ip3 + 1);           
    memcpy((void *) sp1, (const void *) ztv.zmaxtemp, (size_t) slen); 
                                                        /* final  result */ 
    *ip3 = slen; 
    goto TOP; 

A115A: 
    ++IPC.n; 
    ip3 = *(*TIPC.q); 
A145A:             
    sp3 = ztv.zmaxtemp;            /* temporary target is maxtemp */ 
    slen = 0; 
    i = maxstringlen + 0x3fffffff; 
    Zappstrfun(sp3, &h, i, &slen, &nxop, TIPC); 
    if (slen > mlen)           strlenerr(slen, mlen, TIPC, 0); 
    sp3 += slen; 
    Zappendstr(sp3, i, &slen, nxop, TIPC); 
    if (slen > mlen)           strlenerr(slen, mlen, TIPC, 0); 
    sp1 = (char *) (ip3 + 1);           
    memcpy((void *) sp1, (const void *) ztv.zmaxtemp, (size_t) slen); 
                                                        /* final  result */ 
    *ip3 = slen; 
    goto TOP; 

/*  MORE BITSTRINGS  */ 

A215A: 
    ip3 = *(*IPC.q); 
    ++IPC.n; 
A245A: 
    ip1 = (long *) ztv.zmaxtemp; 
    Zidsubbitstr(&ip2, &f, &slen, &nxop); 
    if (slen > mlen)            strlenerr(slen, mlen, TIPC, 0); 
    j = maxstringlen << 3; 
    if (slen > j)   strlenerr(slen, j, TIPC, 2); 
    off1 = 0; 
    work_around_1(ip1, &i, ip2, slen, &off1, f, 1L); 
    ip1 += i; 
    j += 0x40000000; 
    Zappbstr(ip1, off1, j, &slen, nxop, TIPC); 
    if (slen > mlen)            strlenerr(slen, mlen, TIPC, 0); 

/* &dAThis code is logically incorrect for the Intel x86 processor&d@ 
    k = (slen + 7) >> 3; 
    sp1  = (char *) (ip3 + 1); 
    memcpy((void *) sp1, (const void *) ztv.zmaxtemp, (size_t) k); 
    &dA    &d@ */ 

/* &dACorrection added 11-20-92&d@ */ 

    k = (slen + 31) >> 5; 
    k <<= 2;               /* guarenteed to be mult of 4 */ 
    sp1  = (char *) (ip3 + 1); 
    memcpy((void *) sp1, (const void *) ztv.zmaxtemp, (size_t) k); 

/*                           */ 

    *ip3 = slen; 
    goto TOP; 

A217A: 
    ip3 = *(*IPC.q); 
    ++IPC.n; 
A247A: 
    ip1 = (long *) ztv.zmaxtemp; 
    slen = 0; 
    off1 = 0; 
    j = (maxstringlen << 3) + 0x40000000; 
    Zappbfun(ip1, off1, &h, j, &slen, &nxop, TIPC); 
    if (slen > mlen)            strlenerr(slen, mlen, TIPC, 0); 
    off1 += h; 
    k = off1 >> 5; 
    off1 -= k << 5; 
    ip1 += k; 
    Zappbstr(ip1, off1, j, &slen, nxop, TIPC); 
    if (slen > mlen)            strlenerr(slen, mlen, TIPC, 0); 

/* &dAThis code is logically incorrect for the Intel x86 processor&d@ 
    k = (slen + 7) >> 3; 
    sp1  = (char *) (ip3 + 1); 
    memcpy((void *) sp1, (const void *) ztv.zmaxtemp, (size_t) k); 
    &dA    &d@ */ 

/* &dACorrection added 11-20-92&d@ */ 

    k = (slen + 31) >> 5; 
    k <<= 2;               /* guarenteed to be mult of 4 */ 
    sp1  = (char *) (ip3 + 1); 
    memcpy((void *) sp1, (const void *) ztv.zmaxtemp, (size_t) k); 

/*                           */ 

    *ip3 = slen; 
    goto TOP; 

CTRL_EXIT: 

    zcleanup(); 
    return; 
} 
