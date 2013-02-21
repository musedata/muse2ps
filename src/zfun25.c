/***                         DMUSE PROGRAM 
                           LINUX version 1.02 
            (c) Copyright 1992, 1999, 2007, 2009 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 10/03/2008) 
                            (rev. 02/07/2009) 
                            (rev. 04/24/2009) 
                            (rev. 12/27/2009) 
                            (rev. 02/12/2010) 
                            (rev. 04/29/2010) 
                            (rev. 05/05/2010) 
                            (rev. 05/08/2010) 

                     Zbex Interpreter I/O routines 
                                                                        ***/ 
#define  INTELBUG1    0 

#include  "all.h" 

/*** FUNCTION   long Zcallgetc(f, linecode); 

    Purpose:   process call to getc 

    Input:     long     f          flag 0 = getc   1 = getc <format> 
               long     linecode:  0 = line is waiting in ttyline 
                                   1 = use my_getline (free to spin) 
                                   2 = "fixed string" as input 
                                   3 = time string as input 

    Return:    long    0 = normal 
                       1 = change window or disconnect 
                       2 = terminate (!!) 

    Output:    none
                                                                 ***/ 

long Zcallgetc(long f, long linecode) 
{ 
    extern char     ttyline[]; 
    extern char     fixed_string[]; 
    extern time_t   currenttime; 

    char     wk1[820]; 
    char    *sp1; 
    long     g; 

    if (linecode == 2)  { 
        strcpy(ttyline, fixed_string); 
        g = strlen(ttyline); 
        Zline_input(ttyline, g); 
        return (0); 
    } 
    if (linecode == 3)  { 
        currenttime = time(NULL); 
        strcpy(ttyline, asctime(localtime (&currenttime) )); 
        g = strlen(ttyline); 
        if (ttyline[g-1] == '\n')  { 
            --g; 
            ttyline[g] = '\0'; 
        } 
        Zline_input(ttyline, g); 
        return (0); 
    } 

    sp1 = wk1;

    fgets(sp1, 800, stdin); 
    wk1[798] = '\0'; 
    strcpy(ttyline, wk1); 

    g = strlen(ttyline); 

    if (g == 0)  return (1); 

/* Deal here with bang bang */ 

/*  if ( (ttyline[0] == '!') && (ttyline[1] == '!') )  return (2);  */ 

    if (f == 1)  { 

        --g;                        /* here is where you cut off '\n' */ 
/* 
        if (ttyline[g-1] == ' ')  { 
            --g;                       cut off last blank, if present   
        } 
*/ 
        Zline_input(ttyline, g); 
    } 
    return (0); 
} 

/*** FUNCTION   void Zcallputc(long f); 

    Purpose:   process call to putc 

    Input:     long f    0 = putc 
                         1 = pute 

    Return:    void 

    Output:    none
                                                                 ***/ 

void Zcallputc(long f) 
{ 
    extern char    bigbuf[]; 

    long     g; 
    long     pnt; 

    pnt = 0; 
    Zline_output(bigbuf, &pnt, &g); 

    if (f == 0)   { 
        send_twline(bigbuf, pnt); 
        if (g == 1)  send_twline("\n", 1); 
    } 
    else { 
        alt_send_twline(bigbuf, pnt); 
        if (g == 1)  alt_send_twline("\n", 1); 
    } 

    return; 
} 

/*** FUNCTION   long Zcallputp(long f); 

    Purpose:   process call to putp 

    Input:     long   f   1 = simple putp 
                          2 = putp <fp>    (data) 

    Return:    long   0 = normal 
                      1 = terminate Zbex program 

    Output:    none
                                                                 ***/ 

long Zcallputp(long f) 
{ 
    long         g; 
    long         pnt; 
    char         prntbuf[20000]; 
         
    if (f == 2) { 
        Zline_output(prntbuf, &pnt, &g); 
    } 
    return (0); 
} 

/*** FUNCTION   void Zline_input(line, g); 

    Purpose:   process input from pointer  IPC 

    Input:     char    *line input buffer 
               long     g    length of buffer 

    Return:    void

    Output:    none
                                                                 ***/ 

void Zline_input(char *line, long g) 
{ 
    extern element  IPC; 

    long            e, h, i, j, k; 
    long            kk;               /* New &dA04/24/09&d@ */ 
    long            a; 
    long            mlen, slen; 
    long            bufoff; 
    long            off1, off2; 
    long           *pt1; 
    double         *x; 
    char           *rs; 
    long            sw; 
    

    bufoff = 0; 

A:  j = *IPC.n; 
    k = j & 0xff;                 /* command byte   */ 

    if (k == 0x15)   k = 0x11;    /* adjust command byte in the getC case */
    if (k == 0x16)   k = 0x11;    /* adjust command byte in the getd case */
    if (k == 0x1d)   k = 0x19;    /* adjust command byte in the getC case */
    if (k == 0x1e)   k = 0x19;    /* adjust command byte in the getd case */

    j >>= 8;                      /* auxiliary byte */ 
    ++IPC.n; 

    sw = 1; 
    switch (k)  { 
        case 18: 
            ++sw; 
        case 17:                  /* get simple string */ 
            a = *(*IPC.p+1); 
            if (a > g - bufoff)   a = g - bufoff;  /* don't 
                           read beyond the end of the given string */ 
            if (sw == 1) { 
                memcpy ((void *) (*(*IPC.q)+1), (void *) (line+bufoff), 
                        (size_t) a); 
            } 
            else { 
                a = get_bstr(line+bufoff, (*(*IPC.q)+1), 0L, a);
            } 
            *(*(*IPC.q)) = a; /* actual number of bytes or bits read */ 
            goto C; 
        case 19: 
            a = get_int(line+bufoff, &h, g-bufoff); 
            *(*IPC.p) = h;
            goto C; 
        case 20: 
            x = (double *) (*IPC.p); 
            a = get_real(line+bufoff, x, g-bufoff); 
            goto C; 
        case 26: 
            ++sw; 
        case 25: 
            Zidgenstr(&pt1, &mlen, &e, &off2, &i, &kk, sw); 
            if (e == -1)  {   /* no string subscripts */ 
                off1 = 0; 
                off2 = mlen - 1; 
            } 
            else off1 = e; 
            slen = off2 - off1 + 1; 
            if (slen > g - bufoff)  { /* don't read beyond the end 
                                         of the given string */ 
                slen = g - bufoff; 
                off2 = off1 + slen - 1; 
            } 
            if (sw == 1)  { 
                h = off2+1; 
                rs = (char *) (pt1 + 1); 
                memcpy((void *) (rs + off1), (void *) (line + bufoff), 
                        (size_t) slen); 
                a = slen; 
            } 
            else { 
                a = get_bstr(line+bufoff, pt1+1, off1, off2); 
                h = off1 + a; 
            } 
            if (e == -1)           *pt1 = h; /* set length */ 
            else { 
                if (*pt1 < h)      *pt1 = h; /* adj length */ 
            } 
            goto B; 
        case 27: 
            pt1 = Zidint(); 
            a = get_int(line+bufoff, pt1, g-bufoff); 
            goto B; 
        case 28: 
            Zidreal(&x); 
            a = get_real(line+bufoff, x, g-bufoff); 
            goto B; 
        case 33: 
            bufoff = j - 1; 
            if (bufoff > g) bufoff = g; 
            goto A; 
        case 49: 
            h = Zgenintex(); 
            if (h < 1) h = 1; 
            bufoff = h - 1; 
            goto A; 
        case 112: 
            break; 
    } 
    return; 

C:  ++IPC.n; 
B:  bufoff += a; 
    goto A; 
} 

/*** FUNCTION   long get_bstr(*sp, *ip, off1, off2); 

    Purpose:   get bit-string input from input line 

    Input:     char  *sp   pointer to first character of input string 
               long  *ip   pointer to first word of bit-string 
               long   off1 offset to first bit to be filled 
               long   off2 offset of last bit to be filled (if there 
                        are bits to put there) 

    Return:    long   actual number of bits loaded into bit string 

    Operation: This function will successively examine the bytes of 
               *sp, and as long as they are 0's or 1's these will be 
               loaded into the bit-string *ip, starting at offset off1, 
               but not exceeding offset off2. The maximum number 
               of bits to load is (off2-off1+1), but the actual number   
               may be less than this.  The actual number loaded is 
               the value returned by the function.  
                                                                  ***/ 
long get_bstr(char *sp, long *ip, long off1, long off2) 
{ 
    extern long andbitflag[]; 
    extern long orbitflag[]; 

    long   i, j, a, n;

    j = off1 >> 5; 
    ip += j;             /* ip pointer to starting word */ 
    j <<= 5; 
    n = off1 - j;        /* n = normalized first offset */ 
    for (i = off1, a = 0; i <= off2; ++i)  { 
        switch (*sp++) { 
            case '0': 
                *ip &= andbitflag[n]; 
                break; 
            case '1': 
                *ip |= orbitflag[n]; 
                break; 
            default: 
                a = 1; 
                break; 
        } 
        if (a == 1) break; 
        ++n; 
        if (n == 32) { 
            n = 0; 
            ++ip; 
        } 
    } 
    a = i - off1; 
    return (a); 
} 

/*** FUNCTION   long get_int(*sp, *ip, n); 

    Purpose:   get integer input from input line 

    Input:     char  *sp   pointer to first character of input string 
               long   n    number of available bytes to read 

    Return:    long   actual number of bytes read from input string 

    Output:    long  *ip   value of integer read 

    Operation: This function will successively examine the bytes of 
               *sp as follows.  First skip all blanks and commas.  Then 
               look for either a decimal or a hexidecimal number.  Keep 
               reading numbers until format changes or until <n> bytes 
               are read.  Convert result to integer.  The actual number 
               of bytes read is the value returned by the function.  

                                                                  ***/ 
long get_int(char *sp, long *ip, long n) 
{ 
    long  a, h, i, m; 
    static long c1 = 'a' - 10; 
    static long c2 = 'A' - 10; 

    m = 0; 

    for (i = 0; ( (i < n) && (*sp == ' ' || *sp == ',') ); ++i) ++sp; 

/* try for hexidecimal representation first */ 

    if ( (i < n-1) && (*sp == '0') && (*(sp+1) == 'x') ) { 
        i += 2; 
        while (i < n)  { 
            a = 0; 
            if (*sp >= '0' && *sp <= '9') a = *sp - '0'; 
            else 
            if (*sp >= 'a' && *sp <= 'f') a = *sp - c1; 
            else 
            if (*sp >= 'A' && *sp <= 'F') a = *sp - c2; 
            if (a != 0)  { 
                m <<= 4; 
                m += a; 
                ++sp; 
                ++i; 
            } 
            else break; 
        } 
    } 
    else { 

/* try for decimal representation */ 

        h = 1; 
        if (*sp == '-' && i < n) { 
            ++i; 
            ++sp; 
            h = -1; 
        } 
        for (; ( (i < n) && (*sp >= '0') && (*sp <= '9') ); ++i) { 
            m *= 10; 
            m += *sp++ - '0'; 
        } 
        m *= h; 
    } 
    *ip = m; 
    return (i); 
} 

/*** FUNCTION   long get_real(*sp, *rp, n); 

    Purpose:   get real input from input line 

    Input:     char  *sp   pointer to first character of input string 
               long   n    number of available bytes to read 

    Return:    long   actual number of bytes read from input string 

    Output:    long  *rp   value of real variable read 

    Operation: This function will successively examine the bytes of 
               *sp as follows.  First skip all blanks and commas.  Then 
               look for number in floating point format.  Keep reading 
               numbers until format changes or until <n> bytes are read.  
               Convert result to real.  The actual number of bytes read 
               is the value returned by the function.  

                                                                  ***/ 
long get_real(char *sp, double *rp, long n) 
{ 
    long   c, f, i; 
    double x; 
    char  *fsp, *lsp;    /* first sp; last sp */ 
    char   tch; 
    char  *sp2, *sp3; 

    fsp = sp; 
    lsp = sp+n; 

    c = 1; 
    f = 0; 

    for (; ( (sp < lsp) && (*sp == ' ' || *sp == ',') ); ++sp) ; 

    if (*sp == '-' && sp < lsp)  ++sp; 
    if (*sp == '.' && sp < lsp)  { 
        f = 1; 
        ++sp; 
    } 
    sp2 = sp; 
A: 
    while ( (*sp >= '0') && (*sp <= '9') && (sp < lsp) )  ++sp; 
    if (sp == sp2) { 
        c = 0; 
        goto CON; 
    } 
    if (sp == lsp)  goto CON; 
    if (*sp == '.') { 
        if (f == 1) goto CON; 
        ++sp; 
        f = 1; 
        goto A;
    } 
    if (*sp == 'e' || *sp == 'E') { 
        sp2 = sp + 1; 
        if (*sp2 == '+' || *sp2 == '-') ++sp2; 
        sp3 = sp2; 
        while (*sp2 >= '0' && *sp2 <= '9' && sp2 < lsp) ++sp2; 
        if (sp2 > sp3)  { 
            sp = sp2; 
        } 
    } 
CON: 
    i = 0; 
    if (c == 0) x = 0.0; 
    else { 
        tch = *sp; 
        *sp = '\0';           /* temporary end to string  */ 
        if (sscanf(fsp, "%lf", &x) == 0)  x = 0.0; 
        *sp = tch;            /* restore former character */ 
        i = sp - fsp; 
    } 

    *rp = x; 
    return (i); 
} 

/*** FUNCTION   void Zline_output(*line, *bpt, *outf); 

    Purpose:   process output from pointer IPC 

    Input:     char    *line output buffer 
               long    *bpt  current offset in output buffer 

    Return:    void

    Output:    long    *bpt  updated pointer in output buffer 
               long    *outf output flag (1 = put out) 
                                                                 ***/ 

void Zline_output(char *line, long *bpt, long *outf) 
{ 
    extern element  IPC; 
    extern long     orbitflag[]; 
    extern long     andbitflag[]; 

    static char fms[] = "%.0f"; 

    long            wid, fra, flx, cur, hxf; 

    long            a, f, h, i, j, k; 
    long            kk;                 /* New &dA04/24/09&d@ */ 
    long            m, n, p; 
    long            mlen, slen; 
    long            bufstart, bufpnt, bufmax; 
    long            off1, off2; 
    long           *pt1; 
    long           *loc; 
    double         *x; 
    char            temp[400]; 
    
    char           *rs, *sp1; 
    long            sw; 

    wid = 1;         /* width convention            */ 
    fra = 0;         /* integer decimal convention  */ 
    flx = 2;         /* floating point convention   */ 
    cur = 0;         /* currency convention         */ 
    hxf = 0;         /* hexidecimal flag            */ 
    loc = IPC.n; 

    bufstart = *bpt; 
    bufpnt   = bufstart; 
    bufmax   = bufstart; 

A:  j = *IPC.n; 
    k = j & 0xff;           /* command byte   */ 
    j >>= 8;                /* auxiliary byte */ 
    ++IPC.n; 

    sw = 1; 
    switch (k)  { 
        case 17:            /* put simple string */ 
            --sw; 
        case 18:            /* put simple bit-string */ 
            pt1 = *(*IPC.q); 
            ++IPC.n; 
            slen = *pt1++; 
            off1 = 0; 
            goto D1718; 
        case 19: 
            pt1 = *IPC.p++; 
            goto D19; 
        case 20: 
            x = (double *) (*IPC.p++); 
            goto D20; 
        case 25: 
            --sw; 
        case 26: 
            Zidgenstr(&pt1, &mlen, &off1, &off2, &i, &kk, sw+1); 
            if (off1 == -1)  {   /* no subscripts */ 
                off1 = 0; 
                off2 = *pt1 - 1; 
            } 
            slen = off2 - off1 + 1; 
            ++pt1; 
            goto D1718; 
        case 27: 
            pt1 = Zidint(); 
            goto D19; 
        case 28: 
            Zidreal(&x); 
            goto D20; 
        case 32:                              /* hex format */ 
            hxf = 1; 
            goto A; 
        case 49: 
            j = Zgenintex(); 
        case 33:                              /* tab */ 
            if (j < 1)  j = 1; 
            if (bufpnt > bufmax) bufmax = bufpnt; 
            bufpnt = bufstart + j - 1; 
            if (bufpnt > OUTLEN)  { 
                outwarn1(loc); 
                bufpnt = OUTLEN; 
            } 
            for (i = bufmax; i < bufpnt; ++i) { 
                *(line + i) = ' '; 
            } 
            goto A; 
        case 50: 
            j = Zgenintex(); 
        case 34:                              /* width */ 
            if (j < 1)   j = 1; 
            if (j > 200) j = 200; 
            wid = j; 
            goto A; 
        case 51: 
            j = Zgenintex(); 
        case 35:                              /* fractional integer */ 
            if (j < 0)   j = 0; 
            if (j > 9)   j = 9; 
            hxf = 0;    /* hex flag to 0 */ 
            fra = j; 
            goto A; 
        case 52: 
            j = Zgenintex(); 
        case 36:                              /* fixed decimal      */ 
            if (j < 0)   j = 0; 
            if (j > 9)   j = 9; 
            flx = j; 
            goto A; 
        case 53: 
            j = Zgenintex(); 
        case 37:                              /* floating decimal   */ 
            if (j < 0)   j = 0; 
            if (j > 9)   j = 9; 
            flx = j + 10; 
            goto A; 
        case 54: 
            j = Zgenintex(); 
        case 38:                              /* currency modifier  */ 
            if (j < 0)   j = 0; 
            if (j > 4)   j = 0; 
            cur = j; 
            goto A; 
        case 55: 
            j = Zgenintex(); 
        case 39:                              /* output byte        */ 
            if (bufpnt < OUTLEN) { 
                *(line + bufpnt) = (char) j; 
                ++bufpnt; 
            } 
            else outwarn1(loc); 
            goto A; 
        case 64: 
            slen = j; 
            if (slen > OUTLEN - bufpnt)  { 
                outwarn1(loc); 
                slen = OUTLEN - bufpnt;  /* don't write beyond buffer */ 
            } 
            memcpy((void *) (line + bufpnt), (void *) IPC.n,
                    (size_t) slen); 
            bufpnt += slen; 
            IPC.n += (j + 3) >> 2; 
            goto A; 
        case 80: 
            slen = j; 
            if (slen > OUTLEN - bufpnt)  { 
                outwarn1(loc); 
                slen = OUTLEN - bufpnt;  /* don't write beyond buffer */ 
            } 
            for (i = 0; i < slen; ++i)  {
                *(line+bufpnt) = ' '; 
                ++bufpnt; 
            } 
            goto A; 
        case 96: 
            --sw; 
        case 112: 
            *outf = sw; 
            *bpt  = (bufpnt > bufmax) ? bufpnt : bufmax; 
            break; 
    } 
    return; 

D1718: 
    if (slen > OUTLEN - bufpnt)  { 
        outwarn1(loc); 
        slen = OUTLEN - bufpnt;  /* don't write beyond buffer */ 
    } 
  /* strings */ 
    if (sw == 0) { 
        rs = (char *) pt1; 
        rs += off1; 
        memcpy((void *) (line + bufpnt), (void *) rs, (size_t) slen); 
    } 
  /* bit-strings */ 
    else { 
        j = off1 >> 5; 
        pt1 += j;               /* first word of bit-string */ 
        j <<= 5; 
        n = off1 - j;           /* normalized first offset  */ 
        sp1 = line + bufpnt; 
        for (i = 0; i < slen; ++i)  { 
            if ((*pt1 & orbitflag[n++]) != 0)  *sp1 = '1'; 
            else                               *sp1 = '0'; 
            ++sp1; 
            if (n == 32) { 
                n = 0; 
                ++pt1; 
            } 
        } 
    } 
    bufpnt += slen; 
    goto A; 
D19:                    /* put out an integer */ 
    h = *pt1; 
    if (hxf > 0)  { 
        sprintf(temp, "%x", (unsigned int) h); 
        i = strlen(temp); 
        memcpy((void *) (temp+200-i), (void *) temp, (size_t) i); 
    } 
    else { 
        f = 0; 
        a = 0; 
        if (h < 0)  { 
            if (h == 0x80000000)  { 
                h = 0x7fffffff; 
                a = 1; 
            } 
            else  h = -h; 
            f = 1; 
        } 
        i = 0; 
        if (fra == 0) m = 0; 
        else          m = fra + 1; 
        while (i <= m || h > 0)  { 
            j = h / 10; 
            p = j;              /* save j */ 
            j *= 10; 
            h -= j; 
            h += '0'; 
            h += a;             /* cludge to take care of 0x80000000 */ 
            a = 0; 
            temp[199-i] = (char) h; 
            ++i; 
            if (i == fra) { 
                temp[199-i] = '.'; 
                ++i; 
            } 
            h = p;              /* new value for h = oldh / 10 */ 
        } 
        switch (cur)  { 
            case 0: 
                break; 
            case 1: 
                temp[199-i] = '$'; 
                ++i; 
                break; 
            case 2: 
                temp[199-i] = 156; 
                ++i; 
                break; 
            case 3: 
                temp[199-i] = 157; 
                ++i; 
                break; 
            case 4: 
                temp[199-i] = 'M'; 
                ++i; 
                temp[199-i] = 'D'; 
                ++i; 
                break; 
        } 
        if (f == 1)  { 
            temp[199-i] = '-'; 
            ++i; 
        } 
    } 

    while (i < wid) { 
        temp[199-i] = ' '; 
        ++i; 
    } 
    slen = i; 
    if (slen > OUTLEN - bufpnt)  { 
        outwarn1(loc); 
        slen = OUTLEN - bufpnt;  /* don't write beyond buffer */ 
    } 
    memcpy((void *) (line + bufpnt), (void *) (temp+200-i), 
            (size_t) slen); 
    bufpnt += slen; 
    goto A; 
D20:                            /* put out a real number */ 
    f = flx; 
    h = f / 10; 
    h *= 10; 
    f -= h; 
    f += '0';                   /* number for format string */ 
    fms[2] = f; 
    if (h == 0)  fms[3] = 'f'; 
    else         fms[3] = 'e'; 
    k = sprintf(temp, fms, *x); 
  /* add leading blanks, if field width so indicates */ 
    if ((slen = wid - k) > 0)  {
        if (slen > OUTLEN - bufpnt)  { 
            outwarn1(loc); 
            slen = OUTLEN - bufpnt;   
        } 
        for (i = 0; i < slen; ++i)  { 
            *(line + bufpnt) = ' '; 
            ++bufpnt; 
        } 
    } 
  /* load actual number */ 
    slen = k; 
    if (slen > OUTLEN - bufpnt)  { 
        outwarn1(loc); 
        slen = OUTLEN - bufpnt; 
    } 
    memcpy((void *) (line + bufpnt), (void *) temp, (size_t) slen); 
    bufpnt += slen; 
    goto A; 
} 

/*** FUNCTION   long Zcallopen(f, x, linecode); 

    Purpose:   process call to open 

    Input:     long      f          type of open instruction 
                                    1 = open [int,int] str (instr 51) 
                                    ...  
                                    6 = (implied open) [x,1] <get str> 
                                    7 = (implied open) [x,2] <get str> 

               long      x          requested file descriptor number 
                                      (used in implied open) 

               long      linecode:  0 = line is waiting in ttyline 
                                    1 = use my_getline (free to spin) 
                                    2 = if my_getline, return (-1) and wait 

    Operation: If the zoperationflag has bit 12 set, and if this is 
               is a normal call to open a file or a directory (f = 1), 
               then failure to open for any reason will produce a 
               normal return (0), and will set the Zbex special variable 
               to one of these positive values: 

                 1  =  cannot expand to full file name   
                 2  =  file already open somewhere else   
                 3  =  cannot open the file at all   
                 4  =  not a file or a directory   
                 5  =  unable to read directory   
                 6  =  read access on file is denied   
                 7  =  cannot open file for writing   
                 3  =  cannot open the file at all   
                 8  =  writing allowed only on regular files   
                 9  =  read/write access on file is denied   
                 10 =  write access on file is denied   
                 11 =  cannot create new file   

               A successful open will set the special variable err = 0 

               This allows the Zbex program to continue uninterrupted.  
               In this situation, the program should test the special  
               variable err; otherwise, a later attempt to read or write 
               the file/directory may result in a termination error.  

               If this is not a normal call, or if bit 12 of the 
               zoperationflag is clear, a failure to open will cause 
               the Zbex program to prompt the user for another file 
               name.  

    Return:    long   -1 = wait for line to be entered 
                       0 = normal 
                       1 = change window or disconnect 
                       2 = terminate (!!) 

    Output:    none
                                                                 ***/ 

long Zcallopen(long f, long x, long linecode) 
{ 
    extern element     IPC; 
    extern file_data   fdata[]; 
    extern long        files_avail; 
    extern element     elk; 
    extern char        ttyline[]; 

    extern zint_vars  *ztv;  

    FILE               *fopen(); 

    int                 local_errno; 

    file_data          *fdt; 

    long                g, h, i, j, kk; 
    long               *pt; 
    char               *sp1; 
    char                temp[400]; 
    char                tempa[400];              /* New &dA02/07/09&d@ */ 
    struct stat         buf; 

    char                wk1[400]; 
    char                wk2[400]; 
    char                wk3[400]; 
    char                set_error; 
    long                locf; 
    long               *vid1; 
     
    locf = f; 

    pt = IPC.n; 

    if ((ztv->zoperationflag & 0x800) != 0)  set_error = 1; 
    else                                     set_error = 0; 

    fdt = fdata; 

/*  check call type 
        locf = 1   open [int,int] string 
        locf = 6   (implied) open [x,1] <get string> 
        locf = 7   (implied) open [x,2] <get string> 
*/ 
    if (locf > 5)   { 
        h = x - 1; 
        fdt += h; 
        kk = locf - 5;     /* 1 or 2 */ 
        goto Q; 
    } 

    if ( (locf == 1) && (set_error == 1) ) { 
        *(elk.n + ERR) = 0;          /* start by assuming success */ 
    } 

/*  get descriptor parameter  */ 

    pt = IPC.n; 
    h = Zgenintex(); 
    if (h < 1 || h > 9)  fileerr1(pt, h); 
    --h; 
    fdt += h; 

/*  get access type parameter */ 

    pt = IPC.n; 
    kk = Zgenintex(); 
    if (kk < 1 || kk > 8)  fileerr2(pt, h); 
      
/*  deal with globs right here */ 

    if (kk == 8)  { 

    /*  check for already open file  */ 

        if (fdt->access_type != 0)  { 
            fileerr3(pt, fdt->file_name, (h+1), 
                    fdt->access_type); 
        } 

        Zidgenstr(&vid1, &i, &j, &h, &h, &h, 1L); 
        sp1 = (char *) vid1; 

        fdt->access_type = kk;                    /* set file open flag */ 
        strcpy(fdt->file_name, "glob variable");  /* file name is blank */ 
        fdt->file_type = 3;                       /* glob      */ 
        fdt->num_records = 0;
        fdt->file_size = i; 
        fdt->dir_pointer = sp1; 
        fdt->byte_point = 0; 
        *(elk.n + SZE) = i;                       /* set the sze variable */
        return (0); 
    } 

/*  get name of file to be opened */ 

    Zidsubstr(&sp1, &i, &j, &j); 
    strncpy(wk3, sp1, (size_t) i); 

/*  remove trailing blanks from name (precautionary) */ 

    while (i > 0 && wk3[i-1] == ' ') --i; 
    wk3[i] = '\0'; 
    if (i == 0)  { 
        alt_send_twline("File name is null string\n", -1); 
        goto Q; 
    } 

PROCESS: 

/*  expand to full file name */ 

    if (my_make_full_path(temp, wk2, wk3) == -1)  { 
        if ( (i = strlen(wk3)) < 50  )  { 
            sprintf(wk1, "Cannot expand %s to a valid file name\n", wk3); 
        } 
        else  { 
            strcpy(wk1, "Invalid file name\n"); 
        } 
        alt_send_twline(wk1, -1); 

        if ( (locf == 1) && (set_error == 1) ) { 
            *(elk.n + ERR) = 1;      /* cannot expand to full file name */ 
            return (0); 
        } 
        goto Q; 
    } 

/*  check for file already open  */ 

    for (j = 0; j < 9; ++j)  { 
        if (fdata[j].access_type > 1)  { 
            if (strcmp(fdata[j].file_name, temp) == 0)  { 
                sprintf(wk1, "Unable to open file  %s\n", wk2); 
                alt_send_twline(wk1, -1); 
                alt_send_twline( 
                "A temporary lock has been put on this file, because it\n" 
                        , -1); 
                sprintf(wk1, 
                "is currently open in window %d for putf or write.\n", (int) i);
                alt_send_twline(wk1, -1); 

                if ( (locf == 1) && (set_error == 1) ) { 
                    *(elk.n + ERR) = 2;     /* file already open somewhere else */
                    return (0); 
                } 
                goto Q; 
            } 
        } 
    } 

/*  check for limit of open files */ 

    if (files_avail <= 0)  { 
        alt_send_twline( 
        "Attempt to open more that the maximum number of files\n", -1); 
        alt_send_twline( 
        "for this system.  Program terminated.\n", -1); 
        return (2); 
    } 

/*  check for already open file  */ 

    if (fdt->access_type != 0)  { 
        fileerr3(pt, fdt->file_name, (h+1), 
                fdt->access_type); 
    } 

/* type 1 access */ 

    if (kk == 1) { 

        strcpy(tempa, temp);                   /* New &dA02/07/09&d@ */ 

        if (stat(tempa, &buf) == -1)  { 
            local_errno = errno; 
            sprintf(wk1, "Can't open %s for getf access", wk2); 
            alt_send_twline(wk1, -1); 
            sp1 = my_errormsg(local_errno); 
            sprintf(wk1, "  (%s)", sp1); 
            alt_send_twline(wk1, -1); 
            alt_send_twline("\n", 1); 

            if ( (locf == 1) && (set_error == 1) ) { 
                *(elk.n + ERR) = 3;     /* cannot open the file at all */ 
                return (0); 
            } 
            goto Q; 
        } 
        if ( (S_ISDIR(buf.st_mode) == 0) && (S_ISREG(buf.st_mode) == 0)  )  {
            sprintf(wk1, "Can't open %s for getf access\n", wk2); 
            alt_send_twline(wk1, -1); 
            sprintf(wk1, "  (Not a directory or a regular file\n"); 
            alt_send_twline(wk1, -1); 

            if ( (locf == 1) && (set_error == 1) ) { 
                *(elk.n + ERR) = 4;     /* not a file or a directory */ 
                return (0); 
            } 
            goto Q; 
        } 

        if (S_ISDIR(buf.st_mode) != 0)   { 
            alt_send_twline("File name is a directory\n", -1); 
            goto Q; 
        } 
        else { 
            fdt->file_type = 1;   /* regular file */ 

            strcpy(tempa, temp);               /* New &dA02/07/09&d@ */ 

            if ((fdt->fp = fopen(tempa, "r")) == NULL) { 
                sprintf(wk1, "Read access denied: %s\n", wk2); 
                alt_send_twline(wk1, -1); 

                if ( (locf == 1) && (set_error == 1) ) { 
                    *(elk.n + ERR) = 6;     /* read access on file is denied */
                    return (0); 
                } 
                goto Q; 
            } 
        } 
    } 

/* type 2 and type 3 access */ 

    if (kk == 2 || kk == 3)  { 

        strcpy(tempa, temp);                   /* New &dA02/07/09&d@ */ 

        if (stat(tempa, &buf) == -1)  { 
            local_errno = errno; 

            if (local_errno == ENOENT)  { 
                if (locf == 7)  { 
                    sprintf(wk1, "(New file)\n"); 
                    alt_send_twline(wk1, -1); 
                } 
                goto RR; 
            } 
            sprintf(wk1, "Can't open %s for putf access", wk2); 
            alt_send_twline(wk1, -1); 

            sp1 = my_errormsg(local_errno); 
            sprintf(wk1, "  (%s)", sp1); 
            alt_send_twline(wk1, -1); 
            alt_send_twline("\n", 1); 

            if ( (locf == 1) && (set_error == 1) ) { 
                *(elk.n + ERR) = 3;     /* cannot open the file at all */ 
                return (0); 
            } 
            goto Q; 
        } 

        if (S_ISREG(buf.st_mode) == 0)  { 
            sprintf(wk1, "Can't open %s for putf access\n", wk2); 
            alt_send_twline(wk1, -1); 
            sprintf(wk1, " (Not a regular file)\n"); 
            alt_send_twline(wk1, -1); 

            if ( (locf == 1) && (set_error == 1) ) { 
                *(elk.n + ERR) = 7;     /* cannot open file for writing */ 
                return (0); 
            } 
            goto Q; 
        } 

        if (kk == 3)  { 
            fdt->file_type = 1;   /* regular file */ 

            strcpy(tempa, temp);               /* New &dA02/07/09&d@ */ 

            if ((fdt->fp = fopen(tempa, "a")) == NULL)  { 
                sprintf(wk1, "Write access denied:  %s\n", wk2); 
                alt_send_twline(wk1, -1); 

                if ( (locf == 1) && (set_error == 1) ) { 
                    *(elk.n + ERR) = 7;     /* cannot open file for writing */
                    return (0); 
                } 
                goto Q; 
            } 
            fdt->num_records = (long) buf.st_size / 60 + 1; 
            goto RRR; 
        } 

    /*  type 2 access or type 3 access with new file */ 

RR: 
        fdt->file_type = 1;     /* regular file */ 

        strcpy(tempa, temp);                   /* New &dA02/07/09&d@ */ 

        if ((fdt->fp = fopen(tempa, "w")) == NULL)  { 
            sprintf(wk1, "Write access denied:  %s\n", wk2); 
            alt_send_twline(wk1, -1); 

            if ( (locf == 1) && (set_error == 1) ) { 
                *(elk.n + ERR) = 11;     /* cannot create new file */ 
                return (0); 
            } 
            goto Q; 
        } 
        fdt->num_records = 0; 
    } 

/* type 4 access    */ 
 
    if (kk == 4)  { 

        strcpy(tempa, temp);                   /* New &dA02/07/09&d@ */ 

        if (stat(tempa, &buf) == -1)  { 
            local_errno = errno; 

            sprintf(wk1, "Can't open %s for read access", wk2); 
            alt_send_twline(wk1, -1); 

            sp1 = my_errormsg(local_errno); 
            sprintf(wk1, "  (%s)", sp1); 
            alt_send_twline(wk1, -1); 
            alt_send_twline("\n", 1); 

            if ( (locf == 1) && (set_error == 1) ) { 
                *(elk.n + ERR) = 3;     /* cannot open the file at all */ 
                return (0); 
            } 
            goto Q; 
        } 

        if (S_ISREG(buf.st_mode) == 0)  { 
            sprintf(wk1, "Can't open %s for read access", wk2); 
            alt_send_twline(wk1, -1); 
            sprintf(wk1, " (Not a regular file)\n"); 
            alt_send_twline(wk1, -1); 

            if ( (locf == 1) && (set_error == 1) ) { 
                *(elk.n + ERR) = 8;     /* writing allowed only on regular files */
                return (0); 
            } 
            goto Q; 
        } 

        fdt->file_type = 1;   /* regular file */ 

        strcpy(tempa, temp);                   /* New &dA02/07/09&d@ */ 

        if ((fdt->fd = open(tempa, O_RDONLY)) == -1)  { 
            sprintf(wk1, "Read access denied:  %s\n", wk2); 
            alt_send_twline(wk1, -1); 

            if ( (locf == 1) && (set_error == 1) ) { 
                *(elk.n + ERR) = 9;     /* read/write access on file is denied */
                return (0); 
            } 
            goto Q; 
        } 
        fdt->file_size = (long) buf.st_size; 
        *(elk.n + SZE) = (long) buf.st_size; 

        fdt->byte_point = 0; 
    } 

/* type 5 access    */ 
 
    if (kk == 5)  { 

        strcpy(tempa, temp);                   /* New &dA02/07/09&d@ */ 

        if (stat(tempa, &buf) == -1)  { 
            local_errno = errno; 

            sprintf(wk1, "Can't open %s for read/write access", wk2); 
            alt_send_twline(wk1, -1); 

            sp1 = my_errormsg(local_errno); 
            sprintf(wk1, "  (%s)", sp1); 
            alt_send_twline(wk1, -1); 
            alt_send_twline("\n", 1); 

            if ( (locf == 1) && (set_error == 1) ) { 
                *(elk.n + ERR) = 3;     /* cannot open the file at all */ 
                return (0); 
            } 
            goto Q; 
        } 

        if (S_ISREG(buf.st_mode) == 0)  { 
            sprintf(wk1, "Can't open %s for read/write access", wk2); 
            alt_send_twline(wk1, -1); 
            sprintf(wk1, " (Not a regular file)\n"); 
            alt_send_twline(wk1, -1); 

            if ( (locf == 1) && (set_error == 1) ) { 
                *(elk.n + ERR) = 8;     /* writing allowed only on regular files */
                return (0); 
            } 
            goto Q; 
        } 

        fdt->file_type = 1;   /* regular file */ 

        strcpy(tempa, temp);                   /* New &dA02/07/09&d@ */ 

        if ((fdt->fd = open(tempa, O_RDWR)) == -1)  { 
            sprintf(wk1, "Read/write access denied:  %s\n", wk2); 
            alt_send_twline(wk1, -1); 

            if ( (locf == 1) && (set_error == 1) ) { 
                *(elk.n + ERR) = 9;     /* read/write access on file is denied */
                return (0); 
            } 
            goto Q; 
        } 
        fdt->file_size = (long) buf.st_size; 
        *(elk.n + SZE) = (long) buf.st_size; 

        fdt->byte_point = 0; 

    } 

/* type 6 and type 7 access  */ 

    if (kk == 6 || kk == 7)  { 

        strcpy(tempa, temp);                   /* New &dA02/07/09&d@ */ 

        if (stat(tempa, &buf) != 0)   { 
            local_errno = errno; 

            if (local_errno == ENOENT)   { 
                if ((fdt->fd = creat(tempa, (U_USE | G_USE | O_USE)  )) == -1) {
                    sprintf(wk1, "Write access denied:  %s\n", wk2); 
                    alt_send_twline(wk1, -1); 

                    if ( (locf == 1) && (set_error == 1) ) { 
                        *(elk.n + ERR) = 11;     /* cannot create new file */
                        return (0); 
                    } 
                    goto Q; 
                } 
                fdt->file_size = 0; 
                goto RR67; 
            } 
            sprintf(wk1, "Can't open %s for write access", wk2); 
            alt_send_twline(wk1, -1); 

            sp1 = my_errormsg(local_errno); 
            sprintf(wk1, "  (%s)", sp1); 
            alt_send_twline(wk1, -1); 
            alt_send_twline("\n", 1); 

            if ( (locf == 1) && (set_error == 1) ) { 
                *(elk.n + ERR) = 3;     /* cannot open the file at all */ 
                return (0); 
            } 
            goto Q; 
        } 

        if (S_ISREG(buf.st_mode) == 0)  { 
            sprintf(wk1, "Can't open %s for write access", wk2); 
            alt_send_twline(wk1, -1); 
            sprintf(wk1, " (Not a regular file)\n"); 
            alt_send_twline(wk1, -1); 

            if ( (locf == 1) && (set_error == 1) ) { 
                *(elk.n + ERR) = 8;     /* writing allowed only on regular files */
                return (0); 
            } 
            goto Q; 
        } 

        if (kk == 6)  { 
            if ((fdt->fd = creat(tempa, (U_USE | G_USE | O_USE)  )) == -1) {
                sprintf(wk1, "Write access denied:  %s\n", wk2); 
                alt_send_twline(wk1, -1); 

                if ( (locf == 1) && (set_error == 1) ) { 
                    *(elk.n + ERR) = 10;    /* write access on file is denied */
                    return (0); 
                } 
                goto Q; 
            } 
            fdt->file_size = 0; 
        } 
        if (kk == 7)  { 

            strcpy(tempa, temp);               /* New &dA02/07/09&d@ */ 

            if ((fdt->fd = open(tempa, O_WRONLY | O_APPEND)) == -1)  { 
                sprintf(wk1, "Write access denied:  %s\n", wk2); 
                alt_send_twline(wk1, -1); 

                if ( (locf == 1) && (set_error == 1) ) { 
                    *(elk.n + ERR) = 10;    /* write access on file is denied */
                    return (0); 
                } 
                goto Q; 
            } 
            fdt->file_size = (long) buf.st_size; 
        } 
RR67: 
        fdt->file_type = 1;            /* regular file */ 
        *(elk.n + SZE) = fdt->file_size; 
        fdt->byte_point = 0; 
    } 

RRR: 
    fdt->access_type = kk;          /* set file open flag */ 
    strcpy(fdt->file_name, temp);   /* save name of file  */ 
    --files_avail;                  /* decrease number of available slots */ 
    return (0); 

Q: 
    if (kk == 1) sprintf(wk1, "Input File %ld?\n", h+1); 
    if (kk == 2) sprintf(wk1, "Output File %ld?\n", h+1); 
    if (kk == 3) sprintf(wk1, "Append to Output File %ld?\n", h+1); 
    if (kk == 4) sprintf(wk1, "Read only File %ld?\n", h+1); 
    if (kk == 5) sprintf(wk1, "Read/Write File %ld?\n", h+1); 
    if (kk == 6) sprintf(wk1, "Write File %ld?\n", h+1); 
    if (kk == 7) sprintf(wk1, "Append to Write File %ld?\n", h+1); 
    alt_send_twline(wk1, -1); 

    if (linecode == 2)    { 
        return (-1); 
    } 
    else  { 
        if (linecode == 1)   { 
A: 
            g = my_getline(ttyline, TTYZ); 

            if (g == -3)  goto A; 
            if (g < 0)  { 
                return (0-g); 
            } 
        } 
        else { 
            g = strlen(ttyline); 
            if (g == 0)  return (-1); 
        } 
    } 

    strcpy(wk3, ttyline); 

    if ((g = trmline(wk3)) == 0) {     /* null line entered */ 
        if (linecode == 1)  goto Q; 
        return (-1);                   /* else wait for another line */ 
    } 

    wk3[g] = '\0'; 
    if (linecode == 0)  { 
        linecode = 2; 
    } 

    goto PROCESS; 
} 

/*** FUNCTION   long Zcallgetf(f, linecode); 

    Purpose:   process call to getf 

    Input:     long      f          type of getf instruction 
                                    1 = getf <fp>        (instruction 81) 
                                    2 = getf [#] <fp>)   (instruction 82) 
                                    3 = getf [int] <fp>  (instruction 83) 

               long      linecode:  0 = line is waiting in ttyline 
                                    1 = use my_getline (free to spin) 

    Return:    long   -1 = wait for line to be entered 
                       0 = normal 
                       1 = change window or disconnect 
                       2 = end of program (eof without branch address) 
                             or short termination (!!) 

    Output:    none

                                                                 ***/ 
long Zcallgetf(long f, long linecode) 
{ 
    extern element     IPC; 
    extern zint_vars  *ztv;  
    extern file_data   fdata[]; 
    extern element     elk;        /* run-time union pointer to 
                                      link memory  */ 
    extern char        bigbuf[]; 

    file_data         *fdt; 

    long               g, h, i, k; 
    long              *pt; 
    long              *eofx; 

    long               vv; 

    fdt = fdata; 
    pt = IPC.n; 
    h = 0; 

    vv = f; 

    switch (vv)  { 
        case 1:      /* attempt to open file1 for type 1 get */ 
            k = fdt->access_type; 
            if (k > 1) {  /* file open for other things */ 
                fileerr4(pt, fdt->file_name, 1L, k, 1L); 
            } 
            if (k == 0)   { 
                i = Zcallopen(6, 1, linecode); 
                if (i != 0) return (i); 
            } 
            h = 1; 
            break; 
        case 2: 
            h = *IPC.n++; 
            break; 
        case 3: 
            h = Zgenintex(); 
            break; 
    } 

/*  attempt to get next record from file */ 

    if (h < 1 || h > 9)  fileerr1(pt, h); 
    --h; 
    fdt += h; 

    if (fdt->access_type == 0)   { 
        i = Zcallopen(6, h+1, linecode); 
        if (i != 0)   return (i); 
    } 
    else { 
        if (fdt->access_type != 1)  { 
            fileerr4(pt, fdt->file_name, (h+1), 
                    fdt->access_type, 1); 
        } 
    } 

    if (fgets(bigbuf, (int) BUFZ, fdt->fp) == NULL)  { 
        eofx = *(elk.p + 2 + h); 
        if (eofx == ztv->zepr.n)  { 
            return (2);    /* end of program */ 
        } 
        IPC.n = eofx; 
        return (0);                        /* branch to eofx */ 
    } 

    if ((g = strlen((const char *) bigbuf)) == BUFZ-1)  { 
        filewarn1(pt, fdt->file_name, (h+1), 
                fdt->access_type); 
    } 

    if (g > 0)   { 
        if (g > 1)   { 
            if (bigbuf[g-2] == 13)  --g;        /* remove CR */ 
        } 
        --g;                                    /* remove \n */ 
    } 

    Zline_input(bigbuf, g); 

    return (0); 
} 

/*** FUNCTION   long Zcallputf(f, linecode); 

    Purpose:   process call to putf 

    Input:     long      f          type of getf instruction 
                                    1 = putf <fp>        (instruction 86) 
                                    2 = putf [#] <fp>)   (instruction 87) 
                                    3 = putf [int] <fp>  (instruction 88) 

               long      linecode:  0 = line is waiting in ttyline 
                                    1 = use my_getline (free to spin) 

    Return:    long   -1 = wait for line to be entered 
                       0 = normal 
                       1 = change window or disconnect 
                       2 = short termination (!!) 

    Output:    none
                                                                 ***/ 

long Zcallputf(long f, long linecode) 
{ 
    extern element     IPC; 
    extern file_data   fdata[]; 
    extern char        bigbuf[]; 

    file_data         *fdt; 

    long               g, h, i, k; 
    long               pnt; 
    long              *pt; 

    long               vv; 
        
    fdt = fdata; 
    pt = IPC.n; 
    h = 0; 

    vv = f; 

    switch (vv) { 
        case 1:      /* attempt to open file2 for type 2 put */ 

            k = (fdt+1)->access_type; 
            if (k != 0 && k != 2 && k != 3)  { 
                /* file open for other than simple putf */ 
                fileerr4(pt, (fdt+1)->file_name, 2L, k, 2L); 
            } 
            
            if (k == 0)  { 
                i = Zcallopen(7, 2, linecode); 
                if (i != 0) return (i); 
            } 
            h = 2; 
            break; 
        case 2: 
            h = *IPC.n++; 
            break; 
        case 3: 
            h = Zgenintex(); 
            break; 
    } 

/*  attempt to put next record to file */ 

    if (h < 1 || h > 9)  fileerr1(pt, h); 
    --h; 
    fdt += h; 

    if (fdt->access_type == 0)  { 
        i = Zcallopen(7, h+1, linecode); 
        if (i != 0)  return (i); 
    } 
    else { 
        if (    fdt->access_type != 2  && 
                fdt->access_type != 3       )  { 
            fileerr4(pt, fdt->file_name, (h+1), 
                    fdt->access_type, 2); 
        } 
    } 

    pnt = 0; 
    Zline_output(bigbuf, &pnt, &g); 
    if (g == 1)  { 
        bigbuf[pnt++] = 13; 
        bigbuf[pnt++] = '\n'; 
    } 
    bigbuf[pnt] = '\0'; 

    if (fdt->num_records == MAXSIZE)  { 
        i = filewarn3(pt, fdt->file_name, (h+1), 1, linecode); 
        if (i != 0)  return (i); 
    } 
    fputs(bigbuf, fdt->fp); 
    ++(fdt->num_records); 
    return (0); 
} 

/*** FUNCTION   void Zcallclose(); 

    Purpose:   process call to close 

    Input:     none

    Return:    void 

    Output:    none
                                                                 ***/ 

void Zcallclose() 
{ 
    extern element     IPC; 
    extern file_data   fdata[]; 
    extern long        files_avail; 

    file_data  *fdt; 

    char   wk1a[400]; 
    long   h, j; 
    long  *pt; 

/*  get descriptor parameter */ 

    fdt = fdata; 
    pt = IPC.n; 
    h = Zgenintex(); 
    if (h < 1 || h > 9)  fileerr1(pt, h); 
    --h; 
    fdt += h; 
    j = fdt->access_type; 

/*  check for file not open */ 

    if (j == 0)  { 
        filewarn2(pt, fdt->file_name, (h+1)); 
        return; 
    } 

    if (j >= 1 && j <= 3)  { 
        fclose(fdt->fp); 
    } 
    if (j >= 4 && j <= 7)  { 
        close(fdt->fd); 
    } 
    fdt->access_type = 0; 

    if (fdt->file_type == 3)  { 
        return; 
    } 

    if (fdt->file_type == 2)  { 

        strcpy(wk1a, fdt->file_name);          /* New &dA02/07/09&d@ */ 

        unlink(wk1a); 
    } 
    ++files_avail;   /* increase number of available file slots */ 

    return; 
} 

/*** FUNCTION   long Zcallcreate(linecode); 

    Purpose:   process call to createdir 

    Input:     long      linecode:  0 = line is waiting in ttyline 
                                    1 = use my_getline (free to spin) 

    Return:    long   -1 = wait for line to be entered 
                       0 = normal 
                       1 = change window or disconnect 
                       2 = short termination (!!) 

    Output:    none
                                                                 ***/ 

long Zcallcreate(long linecode) 
{ 
    extern char     ttyline[]; 

    static struct stat  buf; 
    long            g, i, j; 

    char           *sp1; 
    char            temp[LINELEN]; 
    char            temp1[LINELEN]; 
    char            temp2[LINELEN]; 
    char            wk2[LINELEN]; 
    char            wk1[400]; 
    char            wk1a[400];                    /* New &dA02/07/09&d@ */ 

/*  get name of directory to be created */ 

    Zidsubstr(&sp1, &i, &j, &j); 
    memcpy(temp, sp1, (size_t) i); 
    temp[i] = '\0'; 

/*  try to make directory */ 

PROCESS: 

    if (my_make_full_path(temp1, wk2, temp) == -1)  { 
        sprintf(wk1, "%s cannot be expanded to a full path\n", temp); 
        alt_send_twline(wk1, -1); 
        goto Q; 
    } 

    strcpy(wk1a, temp1);                       /* New &dA02/07/09&d@ */ 

    if (access(wk1a, F_OK) == 0)  { 
        sprintf(wk1, "Error: %s already exists", wk2); 
        alt_send_twline(wk1, -1); 
        goto Q; 
    } 

    strcpy(temp, temp1); 

    for (i = strlen(temp1); ( (i > 0) && (temp1[i] != '/') ); --i)  ; 

    sp1 = temp1 + i;                 /* sp1 -> last '/' */ 
    if (i > 0)   temp1[i] = '\0';    /* temp1 is parent directory */ 
    ++sp1; 
    strcpy(temp2, sp1);              /* temp2 is local name    */ 

    if (check_fname(temp2) < 0)  {           /* New &dA10/03/08&d@: rhs changed from 2 to 0 */
        sprintf(wk1, "%s is not valid as a directory name\n", temp2); 
        alt_send_twline(wk1, -1); 
        goto Q; 
    } 

    strcpy(wk1a, temp1);                       /* New &dA02/07/09&d@ */ 

    if (access(wk1a, F_OK) == -1)  { 
        if (errno == ENOENT)  { 
            sprintf(wk1, "Directory to %s does not exist\n", temp2); 
        } 
        else   { 
            sprintf(wk1, "Cannot access directory to %s\n", temp2); 
        } 
        alt_send_twline(wk1, -1); 
        goto Q; 
    } 

    if (stat(wk1a, &buf) != 0)   { 
        if (errno == ENOENT)  { 
            sprintf(wk1, "Directory to %s does not exist\n", temp2); 
        } 
        else   { 
            sprintf(wk1, "Cannot access directory to %s\n", temp2); 
        } 
        alt_send_twline(wk1, -1); 
        goto Q; 
    } 

    if (S_ISDIR(buf.st_mode) == 0)  { 
        sprintf(wk1, "No parent directory to %s", temp2); 
        alt_send_twline(wk1, -1); 
        goto Q; 
    } 

    strcpy(wk1a, temp1);                       /* New &dA02/07/09&d@ */ 

    if (access(wk1a, (R_OK | W_OK | X_OK) ) == -1)  { 
        sprintf(wk1, "No permission to read or alter directory to %s\n", temp2);
        alt_send_twline(wk1, -1); 
        goto Q; 
    } 

    strcpy(wk1a, temp);                        /* New &dA02/07/09&d@ */ 

#ifdef MINGW
    if (mkdir(wk1a) != 0)  { 
        return (0); 
    } 
#else
    if (mkdir(wk1a, (U_USE | G_USE | O_USE) ) != 0)  { 
        return (0); 
    } 
#endif
    return (0); 
Q: 
    sprintf(wk1, "New Directory?\n"); 
    alt_send_twline(wk1, -1); 

    if (linecode == 2)  { 
        return (-1); 
    } 
    else  { 
        if (linecode == 1)  { 
A: 
            g = my_getline(ttyline, TTYZ); 
            if (g == -3)  goto A; 
            if (g < 0)   { 
                return (0-g); 
            } 
        } 
        else { 
            g = strlen(ttyline); 
            if (g == 0)  return (-1); 
        } 
    } 
    strcpy(temp, ttyline); 

    if ((g = trmline(temp)) == 0) {    /* null line entered */ 
        if (linecode == 1)  goto Q; 
        return (-1);                   /* else wait for another line */ 
    } 

    if (linecode == 0)  { 
        linecode = 2; 
    } 
    temp[g] = '\0'; 
    goto PROCESS; 
} 

/*** FUNCTION   long Zcallreadwrite(f, linecode); 

    Input:     long        f: type of instruction 
                                 1 = read [int] str       (instr 61) 
                                 2 = read [int,int] str   (instr 62) 
                                 3 = write [int] str      (instr 63) 
                                 4 = write [int,int] str  (instr 64) 


               long      linecode:  0 = line is waiting in ttyline 
                                    1 = use my_getline (free to spin) 

    Return:    long   -1 = wait for line to be entered 
                       0 = normal 
                       1 = change window or disconnect 
                       2 = short termination (!!) 

    Output:    none
                                                                 ***/ 
long Zcallreadwrite(long f, long linecode) 
{ 
    extern element     IPC; 
    extern file_data   fdata[]; 

    file_data          *fdt; 

    long               e, g, h, i, j, k, p; 
    long               kk;              /* New (dynmaic length) &dA04/24/09&d@ */ 
    long              *pt; 
    long               off1, off2; 
    long              *pt1; 
    long               mlen, slen; 
    char              *rs; 
    char              *sp1; 
        
/*  get descriptor parameter  */ 

    fdt = fdata; 
    pt = IPC.n; 
    h = Zgenintex(); 
    if (h < 1 || h > 9)  fileerr1(pt, h); 
    --h; 
    fdt += h; 

/*  get access type for this descriptor  */ 

    j = fdt->access_type; 

/*  get byte parameter  */ 

    if (f == 2 || f == 4)  { 
        k = Zgenintex(); 
        --k; 
    } 
    else  { 
        k = fdt->byte_point; 
    } 
    if (k < 0)  { 
        fileerr5(pt, fdt->file_name, (h+1), j, (k+1), 1L); 
    } 

/*  check instruction permission  */ 

    if (  (f == 1 || f == 2) && j != 5 && j != 4 && j != 8)  { 
        fileerr4(pt, fdt->file_name, (h+1), j, 3L); 
    } 
    if (  (f == 4) && j != 5  )  { 
        fileerr4(pt, fdt->file_name, (h+1), j, 4L); 
    } 
    if (  (f == 3) && j != 5 && j != 6 && j != 7  )  { 
        fileerr4(pt, fdt->file_name, (h+1), j, 5L); 
    } 

/*  get name of input/output variable */ 

    Zidgenstr(&pt1, &mlen, &e, &off2, &i, &kk, 1L); 
    if (e == -1)  {  /* no subscripts */ 
        off1 = 0; 
        if (f == 1 || f == 2) {    /* read */ 
            off2 = mlen - 1; 
        } 
        else {                     /* write */ 
            off2 = *pt1 - 1; 
        } 
    } 
    else off1 = e; 
    slen = off2 - off1 + 1; 

/*  check to see if read/write range is legal */ 

    if ( (j == 4) || (j == 5) || (j == 8) )  { 
        g = fdt->file_size - k;   /* remaining space */ 
        if (g < 1)  { 
            fileerr5(pt, fdt->file_name, (h+1), j, (k+1), 2L); 
        } 
        if (kk > g)    kk = g; 

/* if this is a glob, do the read right here */ 

         if (j == 8)  { 
            sp1 = fdt->dir_pointer + k; 
            fdt->byte_point += kk; 
            rs = (char *) (pt1 + 1); 
            rs += off1; 
            for (i = 0; i < kk; ++i)  { 
                *(rs+i) = *(sp1+i); 
            } 
            return (0); 
        } 

/* position byte pointer  */ 

        lseek( fdt->fd, (off_t) k, SEEK_SET); 
    } 

/* perform I/O   */ 

    rs = (char *) (pt1 + 1); 
    rs += off1; 

  /* case 1: read */ 

    if (f == 1 || f == 2)  { 
        if ( (p = my_readall( fdt->fd, rs, (size_t) kk) ) == -1) { 
            fileerr5(pt, fdt->file_name, (h+1), j, 0L, 3L); 
        } 
    /*  fdt->byte_point += p;       replaced by line below  &dA04/24/09&d@ */ 
        fdt->byte_point = (k + p); 
        return (0); 
    } 

  /* case 2: write */ 

    if (j == 5)  { 
        if ( (p = my_writeall( fdt->fd, rs, (size_t) slen) ) == -1) { 
            fileerr5(pt, fdt->file_name, (h+1), j, 0L, 4L); 
        } 
        return (0); 
    } 

    if (fdt->file_size >= MAXBSIZE)   { 

        i = filewarn3(pt, fdt->file_name, (h+1), 2, linecode); 
        if (i != 0)  return (i); 

        if ( (p = my_writeall( fdt->fd, rs, (size_t) slen) ) == -1) { 
            fileerr5(pt, fdt->file_name, (h+1), j, 0L, 4L); 
        } 
        fdt->file_size = -100000000;   /* disable further warnings */ 
    } 
    else { 
        if ( (p = my_writeall( fdt->fd, rs, (size_t) slen) ) == -1) { 
            fileerr5(pt, fdt->file_name, (h+1), j, 0L, 4L); 
        } 
        fdt->file_size += p; 
    } 

    return (0); 
} 

/*** FUNCTION   void Zcallgetdir(); 

    Purpose:   Process the getdir instruction 

    Input:     void

    Return:    void  

    Errors:    string length exceeded 
                                                                 ***/ 
void Zcallgetdir() 
{ 
    extern element     IPC; 

    element     TIPC; 
    long        e, i; 
    long        kk;                           /* New &dA04/24/09&d@ */ 
    long       *pt1; 
    long        mlen; 
    long        off2; 
    char       *rs;  
    char        wk1[400]; 

    TIPC.n = IPC.n; 
        
/*  get name of output variable */ 

    Zidgenstr(&pt1, &mlen, &e, &off2, &i, &kk, 1L); 

/* get full name of current directory */ 

    getcwd(wk1, 399); 

    i = strlen(wk1); 
    if (i > mlen) { 
        strlenerr(i, mlen, TIPC, 0); 
    } 
    *pt1 = i; 
    rs = (char *) (pt1 + 1); 
    strncpy(rs, wk1, i); 
    return; 
} 
