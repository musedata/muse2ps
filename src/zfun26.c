/***                         DMUSE PROGRAM 
                           LINUX version 1.02 
         (c) Copyright 1992, 1999, 2007, 2009 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 09/18/2007) 
                            (rev. 04/24/2009) 
                            (rev. 12/27/2009) 

                  Zbex Interpreter processing functions 
                                                                      ***/ 
#include  "all.h" 

/* compile options   */ 

#define STRINGS    1 
#define BITSTRS    1

#if STRINGS 

/*** FUNCTION   void Zappendstr(sp1, mlen, *slen, nxop, TIPC); 

    Purpose:   process multiple string concatenations 

    Input:    (element   IPC)    union pointer to subscript in i-code 
               char     *sp1     point at which to begin appending 
               long      mlen    maximum length of target string 
               long     *slen    pointer to current length of target string 
               long      nxop    first appending operator 
               element   TIPC    union pointer to LHS variable in i-code 

    Return:    void               

    Output:   (element   IPC)    updated union pointer in i-code 
               long     *slen    final length of target string 

                                                                 ***/ 
void Zappendstr(char *sp1, long mlen, long *slen, 
    long nxop, element TIPC) 
{ 
    extern element IPC; 

    long    f, h, i, k; 
    long    inc, tslen; 
    char   *sp2; 
    long     maxf; 

    maxf = mlen >> 30; 
    maxf &= 0x03; 
    mlen &= 0x3fffffff; 

    tslen = *slen; 

/* appending loop */ 

APP: 

    switch (nxop)  { 
        case 0: 
            *slen = tslen; 
            return; 
        case 24:                  /* // "" ...   Possible problem (not kosher) */
                                  /* this corrects a compile bug with a kludge */
            nxop = *(IPC.n) >> 16; 
            IPC.n += 1; 
            goto APP; 
        case 25:                  /* // "x" ...                */ 
            ++tslen; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            *sp1++ = *IPC.n;         /* I386 dependent */ 
            nxop = *(IPC.n+1) >> 16; 
            IPC.n += 2; 
            goto APP; 
        case 26:                  /* // "xx" ...               */ 
        case 27:                  /* // "xxx" ...              */ 
        case 28:                  /* // "xxxx" ...             */ 
            f = nxop - 24; 
            tslen += f; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            sp2 = (char *) IPC.n; 
            for (i = 0; i < f; ++i)  { 
                *(sp1+i) = *(sp2+i); 
            } 
            nxop = *(IPC.n+1) >> 16; 
            IPC.n += 2; 
            sp1 += f; 
            goto APP; 
        case 29:                  /* // "xxxxx" ...            */ 
        case 30:                  /* // "xxxxxx" ...           */ 
        case 31:                  /* // "xxxxxxx" ...          */ 
        case 32:                  /* // "xxxxxxxx" ...         */ 
            f = nxop - 24; 
            tslen += f; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            sp2 = (char *) IPC.n; 
            for (i = 0; i < f; ++i)  { 
                *(sp1+i) = *(sp2+i); 
            } 
            nxop = *(IPC.n+2) >> 16; 
            IPC.n += 3; 
            sp1 += f; 
            goto APP; 
        case 33:                  /* // chr(#) ...             */ 
            ++tslen; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            *sp1 = *IPC.n; 
            ++sp1; 
            nxop = *(IPC.n+1) >> 16; 
            IPC.n += 2; 
            goto APP; 
        case 34:                  /* // chr(S-int) ...         */ 
            ++tslen; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            *sp1 = *(*IPC.p); 
            ++sp1; 
            nxop = *(IPC.n+1) >> 16; 
            IPC.n += 2; 
            goto APP; 
        case 35:                  /* // chs(S-int) ...         */ 
        case 36:                  /* // chs(A-int(#)) ...      */ 
            h = *(*IPC.p); 
            nxop = *(IPC.n+1) >> 16; 
            IPC.n += 2; 
            goto A2; 
        case 37:                  /* // chs(A-int) ...         */ 
            Zevint(&h, &nxop); 
            nxop >>= 16; 
            goto A2; 
        case 38:                  /* // pad(#) ...             */ 
            h = *IPC.n; 
            nxop = *(IPC.n+1) >> 16; 
            IPC.n += 2; 
            if (h > mlen)  strlenerr(h, mlen, TIPC, maxf); 
            f = h - tslen; 
            if (f > 0)  { 
                tslen = h; 
                memset((void *) sp1, (int) ' ', (size_t) f); 
                sp1 += f; 
            } 
            goto APP; 
        case 39:                  /* // pad(S-int) ...         */ 
            h = *(*IPC.p); 
            nxop = *(IPC.n+1) >> 16; 
            IPC.n += 2; 
            if (h > mlen)  strlenerr(h, mlen, TIPC, maxf); 
            f = h - tslen; 
            if (f > 0)  { 
                tslen = h; 
                memset((void *) sp1, (int) ' ', (size_t) f); 
                sp1 += f; 
            } 
            goto APP; 
        case 40:                  /* // general string ...     */ 
            Zidsubstr(&sp2, &h, &nxop, &i); 
            tslen += h; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            memcpy((void *) sp1, (void *) sp2, (size_t) h); 
            sp1 += h; 
            goto APP; 
        case 41:                  /* // function ...           */ 
            Zappstrfun(sp1, &inc, mlen, &tslen, &nxop, TIPC); 
            sp1 += inc; 
            goto APP; 
    } 
A2: 
    k = mlen - tslen; 
    int_to_ascii(h, k, sp1, &f); 
    tslen += f; 
    if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
    sp1 += f; 
    goto APP; 
} 

/*** FUNCTION   void Zappstrfun(sp1, *inc, mlen, *slen, *nxop, TIPC); 

    Purpose:   append a function at point sp1 of a string 

    Input:    (element   IPC)    union pointer to subscript in i-code 
               char     *sp1     point at which to begin appending 
               long      mlen    maximum length of target string 
               long     *slen    pointer to current length of target string 
               element   TIPC    union pointer to LHS variable in i-code 

    Return:    void 

    Output:   (element   IPC)    updated union pointer in i-code 
               long     *inc     increment to sp1 
               long     *slen    final length of target string 
               long     *nxop    next appending operator 
                                                                ***/ 
void Zappstrfun(char *sp1, long *inc, long mlen, 
    long *slen, long *nxop, element TIPC) 
{ 
    extern element  IPC; 
    extern long     orbitflag[]; 
    extern element  elk;        /* run-time union pointer to link mem */ 

    long     f, g, h, i, j, k, m, r; 
    long     a, b; 
    long     width; 
    long    *tip, *tip2, fna; 
    char    *sp2, *sp3; 
    char     temp[400];
    double   y; 
    unsigned long t, tt; 
    unsigned long tset[8]; 
    long     sw, tslen; 
    long     maxf; 

    maxf = mlen >> 30; 
    maxf &= 0x03; 
    mlen &= 0x3fffffff; 

/* get function number and next operator */ 

    tslen = *slen; 
    h = *IPC.n++; 
    *nxop = h >> 16; 
    fna = h & 0xffff; 

    sw = 1; 
    switch (fna)  { 
        case 0: 
            Zidsubstr(&sp2, &h, &k, &i); 
            tslen += h; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            memcpy((void *) sp1, (void *) sp2, (size_t) h); 
            *inc = h; 
            break;
        case ZPDS: 
            sw = 0; 
        case PAD: 
            h = Zevints(); 
            if (h > mlen)  strlenerr(h, mlen, TIPC, maxf); 
            f = h - tslen; 
            if (f > 0)  { 
                tslen = h; 
                if (sw == 1) sw = ' '; 
                memset((void *) sp1, (int) sw, (size_t) f); 
                *inc = f; 
            } 
            else *inc = 0; 
            break;
        case CH4: 
            sw += 2; 
        case CH2: 
            sw += 1; 
        case CHR: 
            h = Zevints(); 
            tslen += sw; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            *inc = sw; 
            sp1 += sw; 
            for (i = 0; i < sw; ++i)  { 
                --sp1; 
                *sp1 = h; 
                h >>= 8; 
            } 
            break;
        case HEX: 
            ++sw; 
        case OCT: 
            k = mlen - tslen; 
            i = Zint_to_hexoct(k, sp1, sw); 
            tslen += i; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            *inc = i; 
            break;
        case CHS1:
            h = Zevints(); 
            k = mlen - tslen; 
            int_to_ascii(h, k, sp1, &f); 
            tslen += f; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            *inc = f; 
            break;
        case CH8: 
            Zevreals(&y); 
            tslen += 8; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            sp2 = (char *) &y; 
            memcpy((void *) sp1, (void *) sp2, (size_t) 8); 
            *inc = 8; 
            break;
        case CHX: 
            sw = 0; 
        case CHS2:
            k = Zreal_to_ascii(temp, sw); 
            tslen += k; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            memcpy((void *) sp1, (void *) temp, (size_t) k); 
            *inc = k; 
            break;
        case MRTS: 
            sw = 0; 
        case TRMS: 
            Zidsubstr(&sp2, &h, &k, &i); 
            if (sw == 1)  { 
                for (sp3 = sp2 + h; h > 0; --h)  { 
                    --sp3; 
                    if (*sp3 != ' ')  break; 
                } 
            } 
            else { 
                for (i = 0; i < h; ++i)  { 
                    if (*sp2 == ' ')  ++sp2; 
                    else              break; 
                } 
                h -= i; 
            } 
            tslen += h; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            if (sp1 != sp2)  { 
                memcpy((void *) sp1, (void *) sp2, (size_t) h); 
            } 
            *inc = h; 
            break;
        case LCS: 
            sw = 0; 
        case UCS: 
            Zidsubstr(&sp2, &h, &k, &i); 
            tslen += h; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            for (i = 0; i < h; ++i)  { 
                *sp1++ =  (char) case_convert((unsigned char) *sp2++, sw); 
            } 
            *inc = h; 
            break;
        case REVS: 
            Zidsubstr(&sp2, &h, &k, &i); 
            tslen += h; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            for (i = 0, sp2 += h-1; i < h; ++i)  {
                *sp1++ = *sp2--; 
            } 
            *inc = h; 
            break;
        case RPL: 
            Zidsubstr(&sp2, &h, &k, &i); 
          /* determine m = number of replacement checks */ 
            k = *(*IPC.p + 1); 
            tip = *(*IPC.q + 3); 
            width = (*(*IPC.p + 4) + 7) / 4; 
            ++IPC.n; 
            for (m = 0, j = 0; m < k; ++m)  { 
                if (*(tip+j) == 0)  {  /* null string */ 
                    break; 
                } 
                j += 2 * width;        /* advance in string array */ 
            } 
          /* process string: where str{} matches A, substitute B */ 
            b = 0;                     /* offset in output (LHS) string */ 
            for (i = 0; i < h; ++i)  { 
                for (a = 0, j = 0; a < m; ++a)  { 
                    f = *(tip+j);                    /* length of A */ 
                    if (i + f - 1 < h)  {   
                        if (memcmp((void *) (sp2+i), (void *) (tip+j+1), 
                                (size_t) f) == 0)  { 
                            g = *(tip+width+j);      /* length of B */ 
                            if (tslen + b + g > mlen)  { 
                                strlenerr(tslen+b+g, mlen, TIPC, maxf); 
                            } 
                            memcpy((void *) (sp1+b), (void *) (tip+j+width+1), 
                                    (size_t) g); 
                            b += g - 1; 
                            i += f - 1; 
                            goto RPL1; 
                        } 
                    } 
                    j += 2 * width; 
                } 
                if (tslen+b+1 > mlen)  strlenerr(tslen+b+1, mlen, TIPC, maxf); 
                *(sp1+b) = *(sp2+i);                 /* no substitutions */ 
RPL1: 
                ++b; 
            } 
            tslen += b; 
            *inc = b; 
            break;
        case DUPS: 
            Zidsubstr(&sp2, &h, &k, &i); 
            k = Zevints(); 
            if (k < 0)  k = 0; 
            tslen += h * k; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            if (h == 1)  { 
                memset((void *) sp1, (int) *sp2, (size_t) k); 
            } 
            else { 
                for (f = 0; f < k; ++f)  { 
                    memcpy((void *) sp1, (void *) sp2, (size_t) h); 
                    sp1 += h; 
                } 
            } 
            *inc = h * k; 
            break;
        case TXT1: 
            ++sw;            /* sw will be 4 */ 
        case TXT2: 
            ++sw;            /* sw will be 3 */ 
        case TXT3: 
            ++sw;            /* sw will be 2 */ 
        case TXT4: 
            Zidsubstr(&sp2, &g, &j, &i); 
            if (sw > 2) { 
                Zidsubbitstr(&tip, &k, &h, &j); 
                if (k == 0 && h >= 256)  {  /* 99% of the time */ 
                    for (i = 0; i < 8; ++i)  { 
                        tset[i] = *(tip+i); 
                    } 
                } 
                else  { 
                    f = h / 32;              /* number of "full" words */ 
                    r = 32 - k;              /* 0 <= k <= 31 */ 
                    for (i = 0; i <= f; ++i) { 
                        t = (unsigned long) *(tip+1); 
                        if (r == 32)  t = 0; 
                        else          t >>= r; 
                        tset[i] = (*tip << k) | t; 
                        ++tip; 
                    } 
                    m = (f + 1) * 32 - h;    /* number of dead bits 
                                                          in last word */ 
                    tset[f] >>= m; 
                    tset[f] <<= m; 
                    for (i = f+1; i < 8; ++i)  { 
                        tset[i] = 0; 
                    } 
                } 
                tip = (long *) tset; 
                sw -= 2; 
            } 
            else { 
                tip = *IPC.p; 
                ++IPC.n; 
            } 
            if (sw == 2)  { 
                tip2 = Zidint(); 
            } 
            else  { 
                tip2 = elk.n + MPT; 
            } 
            f = (maxf << 30) + mlen; 
            do_txt(sp1, f, sp2, g, tip, tip2, inc, TIPC); 
            tslen += *inc; 
            break;
        case CBY:   /* convert bit string (with subs) to string */ 
            Zidsubbitstr(&tip, &k, &h, &j); 
            g = (h + 7) / 8; 
            m = (g * 8) - h;                    /* number of dead bits */ 
            tslen += g; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            *inc = g; 
            h = (h + 31) / 32;             /* number of full words */ 
            r = 32 - k; 
            for (i = 0; i < h; ++i)  { 
                j = *tip << k;             /* 0 <= k <= 31 */ 
                ++tip; 
                t = (unsigned long) *tip; 
                if (r == 32)    t = 0; 
                else            t >>= r; 
                j |= t; 
                for (f = 24, t = 0xff000000; f >= 0 && g > 0; f -= 8)  { 
                    tt = j & t; 
                    *sp1++ = tt >> f;
                    t >>= 8; 
                    --g; 
                } 
            } 
            r = 0xff << m; 
            --sp1;  
            *sp1 &= r;                     /* clear the dead bits */ 
            break;
        case UPK1: 
        case UPK2: 
            Zidsubbitstr(&tip, &k, &h, &j); 
            tslen += h; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            temp[0] = 'x'; 
            temp[1] = ' '; 
            if (fna == UPK1)  { 
                Zidsubstr(&sp2, &j, &g, &i); 
                if (j > 2) j = 2; 
                memcpy((void *) temp, (void *) sp2, (size_t) j); 
            } 
            for (i = 0; i < h; ++i)  { 
                if ((*tip & orbitflag[k]) != 0)  *sp1 = temp[0]; 
                else                             *sp1 = temp[1]; 
                ++sp1; 
                ++k; 
                if (k == 32)  { 
                    k = 0; 
                    ++tip; 
                } 
            } 
            *inc = h; 
            break;
    } 
    *slen = tslen; 
} 

/*** FUNCTION   void Zckgenstr(*vid, *sp2, *slen, *nxop); 

    Purpose:   get information on next general string/substring 

    Input:     none

    Return:    void 

    Output:    long      **vid    pointer to run-time string length 
                                    (a.k.a. variable id) 
               char      **sp2    pointer to string/substring in main mem 
               long       *slen   length of string/substring 
               long       *nxop   next concatenate operator 

                                                               ***/ 
void Zckgenstr(long *(*vid), char *(*sp2), long *slen, long *nxop) 
{ 
    char *tsp; 
    long *tip; 
    long  off1, off2; 
    long  h; 
    long  kk;                    /* New &dA04/24/09&d@ */ 

    Zidgenstr(vid, &h, &off1, &off2, nxop, &kk, 1L); 
    tip = *vid + 1; 
    tsp = (char *) tip; 
    if (off1 < 0)  { 
        *slen = *(*vid); 
        *sp2 = tsp; 
    } 
    else  { 
        *slen = off2 - off1 + 1; 
        *sp2 = tsp + off1; 
    } 
} 

/*** FUNCTION   void Zckgenbstr(*vid, *wip, *boff, *slen, *nxop); 

    Purpose:   get information on next general bit-string or
                 bit-substring 

    Input:     none

    Return:    void 

    Output:    long      **vid    pointer to run-time string length 
                                    (a.k.a. variable id) 
               long      **wid    pointer to (pointer to) first word of 
                                    bit-string or bit-substring 
               long       *boff   offset in first word to beginning of
                                    string 
               long       *slen   length of string/substring 
               long       *nxop   next concatenate operator 

                                                               ***/ 
void Zckgenbstr(long *(*vid), long *(*wip), long *boff, 
    long *slen, long *nxop) 
{ 
    long *tip; 
    long  off1, off2; 
    long  h; 
    long  kk;                    /* New &dA04/24/09&d@ */ 

    Zidgenstr(vid, &h, &off1, &off2, nxop, &kk, 2L); 
    tip = *vid + 1; 
    if (off1 < 0)  { 
        *slen = *(*vid); 
        *wip  = tip; 
        *boff = 0; 
    } 
    else  { 
        *slen = off2 - off1 + 1; 
        *wip  = tip + (off1 >> 5); 
        *boff = off1 & 0x1f; 
    } 
} 

/*** FUNCTION   void Zckstrx(*vid, *sp2, *slen, *nxop, *proc, *toff); 

    Purpose:   get processing information for concatenate element 

    Input:    (element   IPC)  union pointer to subscript 
               long     *nxop  current concatenate operator 
               long     *toff  offset in maxtemp for temporary storage 

    Return:    void 

    Output:   (element   IPC)  updated union pointer in i-code 
               long    **vid   pointer to run-time string length 
                                 (a.k.a. variable id) 
               char    **sp2   pointer to string/substring in main mem 
               long     *slen  length of string/substring 
               long     *nxop  next concatenate operator 
               long     *proc  transition process 

                               1 = direct transfer 
                               2 = add blanks 
                               3 = add zeros 
                               4 = convert to lower case 
                               5 = convert to upper case 
                               6 = reverse and transfer 
                               7 = convert bit-string to bytes 
                               8 = unpack bit-string 
                               9 = direct transfer and duplicate 
                              10 = replace function (fatal to the 
                                     shift method) 

               long     *toff  updated offset in maxtemp 

               Note: In processes 7, 8 and 9, extra information must be 
               packed into the process flag.  

               In the case of processes 7 and 8, the source data is not a 
               string, but rather a bit-string.  Normally it takes three 
               parameters to represent a bit string: two to represent the 
               starting point (word pointer and offset), and one to 
               represent the length.  We may represent the word pointer 
               in sp2.  The offset (0 <= off1 <= 31) may be represented
               in bits 15-8 of the process flag.  We need to keep the 
               meaning slen constant, since this describes the size of 
               output string; but we may use the information in slen to 
               "reconstruct" the length of the source bit-string.  For 
               process 8, this is simple, since the final length in bytes 
               is the number of bits in the source.  For process 7, slen 
               will give us the number of bytes which will hold the
               original string, but we will need to know the number of 
               bits (0 <= dead bits <= 7) in the last byte which will be 
               "dead bits."  We may store this number in bits 23-16 of  
               the process flag.  For process 8, we also need to the two 
               bytes for representing bit-on and bit-off information in  
               the source.  These two bytes may be stored in bits 31-16 
               of the process flag.  

               For process 9, we need to know the number of times to 
               duplicate the source string.  This number may be stored 
               in bits 31-8 of the process flag.  

    Operation: 

        Element type     Action 
        ÄÄÄÄÄÄÄÄÄÄÄÄ     ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
        general string   sp2 -> string               *proc = 1 
        dup gen string   sp2 -> string (n times)     *proc = 9 
        pad function     sp2 is not relevant         *proc = 2 
        zpd function     sp2 is not relevant         *proc = 3 
        chr function     sp2 -> result in temp       *proc = 1 
        ch2 function     sp2 -> result in temp       *proc = 1 
        ch4 function     sp2 -> result in temp       *proc = 1 
        oct function     sp2 -> result in temp       *proc = 1 
        chs function     sp2 -> result in temp       *proc = 1 
        hex function     sp2 -> result in temp       *proc = 1 
        ch8 function     sp2 -> result in temp       *proc = 1 
        chx function     sp2 -> result in temp       *proc = 1 
        trm function     sp2 -> string (new length)  *proc = 1 
        mrt function     sp2 -> string (new start)   *proc = 1 
        lcs function     sp2 -> string               *proc = 4 
        ucs function     sp2 -> string               *proc = 5 
        rpl function     sp2 is not relevant         *proc = 10 
        rev function     sp2 -> string               *proc = 6 
        dup function     sp2 -> string (n times)     *proc = 9 
        cby function     sp2 -> bit string           *proc = 7 
        upk function     sp2 -> bit string           *proc = 8 

                                                               ***/ 

void Zckstrx(long *(*vid), char *(*sp2), long *slen, 
    long *nxop, long *proc, long *toff) 
{ 
    extern element IPC; 
    extern char  *maxtemp; 
    extern long   maxstringlen; 

    long    *pseudovid = (long *) NULL; 
    long     f, g, h, k; 
    long     fna; 

    *vid = pseudovid; 

    if (*nxop < 33)  {            /* cases 25 to 32:  */ 
        f = *nxop - 21; 
        g = f >> 2;              /* g = 1 or 2       */ 
        *sp2 = (char *) IPC.n; 
        IPC.n += g; 
        f -= 3; 
        *nxop = *IPC.n >> 16; 
        ++IPC.n; 
        *slen = f; 
        *proc = 1;
        return; 
    } 

    *sp2 = maxtemp + *toff; 

    switch (*nxop)  { 
        case 33: 
            *(*sp2) = *IPC.n; 
            *slen = 1; 
            *nxop = *(IPC.n+1) >> 16; 
            IPC.n += 2; 
            *proc = 1; 
            ++(*toff); 
            break; 
        case 34: 
            *(*sp2) = *(*IPC.p); 
            *slen = 1; 
            *nxop = *(IPC.n+1) >> 16; 
            IPC.n += 2; 
            *proc = 1; 
            ++(*toff); 
            break; 
        case 35: 
        case 36: 
            h = *(*IPC.p); 
            *nxop = *(IPC.n+1) >> 16; 
            IPC.n += 2; 
            goto B2; 
        case 37: 
            Zevint(&h, nxop); 
            *nxop >>= 16; 
            goto B2; 
        case 38: 
            *slen = *IPC.n; 
            *nxop = *(IPC.n+1) >> 16; 
            IPC.n += 2; 
            *proc = 2; 
            break; 
        case 39: 
            *slen = *(*IPC.p); 
            *nxop = *(IPC.n+1) >> 16; 
            IPC.n += 2; 
            *proc = 2; 
            break; 
        case 40: 
            Zckgenstr(vid, sp2, slen, nxop); 
            *proc = 1; 
            break; 
        case 41: 
            h = *IPC.n; 
            *nxop = h >> 16; 
            fna = h & 0xffff; 
            if (fna == RPL)  { 
                *proc = 10; 
                break; 
            } 
            ++IPC.n; 
            Zckstrfun(fna, vid, sp2, slen, proc, toff); 
            break; 
    } 
    if (maxstringlen - *toff < 320)  *proc = 10; 
    return;    
B2: 
    k = 0x7fffffff; 
    int_to_ascii(h, k, *sp2, &f);    /* do the job */ 
    *slen = f; 
    *proc = 1; 
    *toff += f; 
    if (maxstringlen - *toff < 320)  *proc = 10; 
    return; 
} 

/*** FUNCTION   void Zckstrfun(fna, *vid, *sp2, *slen, *proc, *toff); 

    Purpose:   get processing information for concatenated 
                 string function 

    Input:     long       fna   function number 
               long      *toff  offset in maxtemp for temporary storage 

    Return:    void 

    Output:    long     **vid   pointer to run-time string length 
                                  (a.k.a. variable id) 
               long     **sp2   pointer to output string/substring 
               long      *slen  length of string/substring 
               long      *proc  process operator (see ckstrx) 
               long      *toff  updated offset in maxtemp 

    Operation: 

        Element type     Action 
        ÄÄÄÄÄÄÄÄÄÄÄÄ     ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
        general string   sp2 -> string               *proc = 1 
        dup gen string   sp2 -> string (n times)     *proc = 9 
        pad function     sp2 is not relevant         *proc = 2 
        zpd function     sp2 is not relevant         *proc = 3 
        chr function     sp2 -> result in temp       *proc = 1 
        ch2 function     sp2 -> result in temp       *proc = 1 
        ch4 function     sp2 -> result in temp       *proc = 1 
        oct function     sp2 -> result in temp       *proc = 1 
        chs function     sp2 -> result in temp       *proc = 1 
        hex function     sp2 -> result in temp       *proc = 1 
        ch8 function     sp2 -> result in temp       *proc = 1 
        chx function     sp2 -> result in temp       *proc = 1 
        trm function     sp2 -> string (new length)  *proc = 1 
        mrt function     sp2 -> string (new start)   *proc = 1 
        lcs function     sp2 -> string               *proc = 4 
        ucs function     sp2 -> string               *proc = 5 
        rpl function     sp2 is not relevant         *proc = 10 
        rev function     sp2 -> string               *proc = 6 
        dup function     sp2 -> string (n times)     *proc = 9 
        cby function     sp2 -> bit string           *proc = 7 
        upk function     sp2 -> bit string           *proc = 8 

                                                               ***/ 

void Zckstrfun(long fna, long *(*vid), char *(*sp2), 
    long *slen, long *proc, long *toff) 
{ 
    extern char    *maxtemp; 

    char      *sp3, *sp4; 
    char       temp[2]; 
    long       f, g, h, i, j, k, m; 
    unsigned long t; 
    long      *wip, bitoff; 
    long      *pseudovid = (long *) NULL; 
    double     y; 
    long       sw, tslen; 

    *vid = pseudovid; 
    *sp2 = maxtemp + *toff; 
    *proc = 1; 
    sw = 1; 
    tslen = *slen; 

    switch (fna)  { 
        case PAD: 
            sw = 0; 
        case ZPDS: 
            h = Zevints(); 
            *proc = sw + 2; 
            break; 
        case CH4: 
            sw += 2; 
        case CH2: 
            sw += 1; 
        case CHR: 
            h = Zevints(); 
            tslen = sw; 
            *toff += sw; 
            sp3 = *sp2 + sw; 
            for (i = 0; i < sw; ++i)  { 
                --sp3; 
                *sp3 = h; 
                h >>= 8; 
            } 
            break; 
        case HEX: 
            ++sw; 
        case OCT: 
            i = Zint_to_hexoct(1000, *sp2, sw); 
            tslen = i; 
            *toff += i; 
            break; 
        case CHS1:
            h = Zevints(); 
            k = 0x7fffffff; 
            int_to_ascii(h, k, *sp2, &f);    /* do the job */ 
            tslen = f; 
            *toff += f; 
            break; 
        case CH8: 
            Zevreals(&y); 
            sp4 = (char *) &y; 
            memcpy((void *) *sp2, (void *) sp4, (size_t) 8); 
            tslen += 8; 
            *toff += 8; 
            break; 
        case CHX: 
            sw = 0; 
        case CHS2:
            k = Zreal_to_ascii(*sp2, sw); 
            tslen = k; 
            *toff += k; 
            break; 
        case MRTS: 
            sw = 0; 
        case TRMS: 
            Zckgenstr(vid, sp2, &h, &k); 
            if (sw == 1)  { 
                for (sp3 = *sp2 + h; h > 0; --h)  { 
                    --sp3; 
                    if (*sp3 != ' ')  break; 
                } 
            } 
            else { 
                for (i = 0; i < h; ++i)  { 
                    if (*(*sp2) == ' ')  ++(*sp2); 
                    else                 break; 
                } 
                h -= i; 
            } 
            tslen = h; 
            break; 
        case REVS: 
            ++sw; 
        case UCS: 
            ++sw; 
        case LCS: 
            Zckgenstr(vid, sp2, &h, &k); 
            tslen = h; 
            *proc = sw + 3; 
            break; 
        case DUPS: 
            Zckgenstr(vid, sp2, &h, &k); 
            k = Zevints(); 
            if (k < 0)  k = 0; 
            else if (k > 0x7fffff) k = 0x7fffff; 
            tslen = h * k; 
            *proc = (k << 8) + 9; 
            break; 
        case CBY:   /* convert bit string (with subs) to string */ 
            Zckgenbstr(vid, &wip, &bitoff, &h, &k); 
            *sp2 = (char *) wip; 
            g = (h + 7) / 8; 
            m = (g * 8) - h;               /* m = number of dead bits */ 
            bitoff += m << 8; 
            bitoff <<= 8; 
            *proc = 7 + bitoff; 
            tslen = g; 
            break; 
        case UPK1: 
        case UPK2: 
            Zckgenbstr(vid, &wip, &bitoff, &h, &k); 
            *sp2 = (char *) wip; 
            temp[0] = 'x'; 
            temp[1] = ' '; 
            if (fna == UPK1)  { 
                Zidsubstr(&sp3, &j, &g, &i); 
                if (j > 2) j = 2; 
                memcpy((void *) temp, (void *) sp2, (size_t) j); 
            } 
            t = temp[0];
            t <<= 8;
            t += temp[1]; 
            t <<= 8; 
            t += bitoff; 
            t <<= 8; 
            *proc = t + 8; 
            tslen = h; 
            break; 
    } 

    *slen = tslen; 
} 

/*** FUNCTION   void int_to_ascii(h, mlen, sp1, len); 

    Purpose:   construct ascii string from int value 

    Input:     long    h         integer value (input) 
               long    mlen      maximum length allowed 
               char   *sp1       location to write axcii output 

    Output:    long   *len       (proposed) length of output string 

    Return:    void

    Operation: If the proposed length exceeds the maximum length, the 
               function returns without constructing the string.  

                                                                 ***/ 

void int_to_ascii(long h, long mlen, char *sp1, long *len) 
{ 
    long   f, g, i; 
    unsigned long t, u, v; 

    f = 0; 
    if (h < 0)  { 
        h = -h; 
        ++f; 
    } 
    if (h == 0)  i = 1; 
    else { 
        for (i = 0, t = h; t > 0; t /= 10)  ++i; 
    } 
    g = i + f;              /* proposed length */ 
    *len = g; 
    if (g > mlen)  { 
        return; 
    } 
    if (f == 1)   *sp1++ = '-'; 
    for (u = h, sp1 += i; i > 0; --i)  { 
        --sp1; 
        v = u + '0'; 
        u /= 10; 
        t = u * 10; 
        v -= t; 
        *sp1 = v; 
    } 
    return; 
} 

/*** FUNCTION   long Zreal_to_ascii(sp1, mode); 

    Purpose:   construct ascii string from real value 

    Input:     char    *sp1       location to write axcii output 
               long     mode      1 = fixed; 0 = floating 

    Output:    none

    Return:    long    length of output 

                                                                 ***/ 

long Zreal_to_ascii(char *sp1, long mode) 
{ 
    double  y; 
    long    f, h, i, k; 

    Zevreals(&y); 
    h = Zevints(); 
    if (h < 0) h = 0; 
    if (h > 9) h = 9; 
    f = 0; 
    if (h == 0)  { 
        y += .5; 
        f = 1; 
        h = 1; 
    } 
    if (mode == 1)  { 
        k = sprintf(sp1, "%.*f", (int) h, y); 
    } 
    else { 
        k = sprintf(sp1, "%.*e", (int) h, y); 
        if (f == 1) { 
            sp1 += k - 4; 
            for (i = 0; i < 4; ++i)  { 
                *(sp1-1) = *sp1; 
                ++sp1; 
            } 
        } 
    } 
    k -= f; 
    return (k); 
} 

/*** FUNCTION   long Zint_to_hexoct(max, sp1, mode); 

    Purpose:   construct ascii string representing int value 
                 in HEX/OCT format 

    Input:     long     max       maximum length allowed 
               char    *sp1       location to write axcii output 
               long     mode      2 = HEX; 1 = OCT 

    Output:    none

    Return:    long     length of constructed string 

    Operation: If resulting string will exceed the max length,    
                 construction will not take place 
                                                                 ***/ 

long Zint_to_hexoct(long max, char *sp1, long mode) 
{ 
    long   f, h, i, k, g; 
    unsigned long t; 

    mode += 2; 
    f = 1 << mode; 
    --f; 
    h = Zevints(); 
    t = (unsigned long) h; 
    if (t == 0) i = 1; 
    else  { 
        for (i = 0; t > 0; t >>= mode)  ++i; 
    } 

    if (i <= max) { 
        for (sp1 += i, t = (unsigned long) h, g = i; g > 0; --g)  { 
            --sp1; 
            k = t & f; 
            if (k < 10)  *sp1 = k + '0'; 
            else         *sp1 = k - 10 + 'a'; 
            t >>= mode;
        } 
    } 
    return (i); 
} 

/*** FUNCTION   void pcatstr(cnt, xnt, sp1, vp2, vlen2, vpro2); 

    Purpose:   perform string concatenation from tables 
                 vp2, vlen2, and vpro2 

    Input:     long  cnt     number of elements 
               long  xnt     element which must be done first, because 
                               it involves target string 
               char *sp1     pointer to first byte of target string 
               char *vp2[]   array of pointers to RHS strings 
               long *vlen2[] array of lengths for RHS strings 
               long *vpro2[] array of transition processes 

    Return:    void

    Output:    none returned 
               string concatenation performed 

    Transition processes: 

               1 = direct transfer 
               2 = add blanks 
               3 = add zeros 
               4 = convert to lower case 
               5 = convert to upper case 
               6 = reverse and transfer 
               7 = convert bit-string to bytes 
               8 = unpack bit-string 
               9 = direct transfer and duplicate 

               Note: In processes 7, 8 and 9, extra information must be 
               packed into the process flag.  

               In the case of processes 7 and 8, the source data is not a 
               string, but rather a bit-string.  Normally it takes three 
               parameters to represent a bit string: two to represent the 
               starting point (word pointer and offset), and one to 
               represent the length.  We may represent the word pointer 
               in sp2.  The offset (0 <= off1 <= 31) may be represented
               in bits 15-8 of the process flag.  We need to keep the 
               meaning slen constant, since this describes the size of 
               output string; but we may use the information in slen to 
               "reconstruct" the length of the source bit-string.  For 
               process 8, this is simple, since the final length in bytes 
               is the number of bits in the source.  For process 7, slen 
               will give us the number of bytes which will hold the
               original string, but we will need to know the number of 
               bits (0 <= dead bits <= 7) in the last byte which will be 
               "dead bits."  We may store this number in bits 23-16 of  
               the process flag.  For process 8, we also need to the two 
               bytes for representing bit-on and bit-off information in  
               the source.  These two bytes may be stored in bits 31-16 
               of the process flag.  

               For process 9, we need to know the number of times to 
               duplicate the source string.  This number may be stored 
               in bits 31-8 of the process flag.  

                                                                  ***/ 
void pcatstr(long cnt, long xnt, char *sp1, char *vp2[], 
    long vlen2[], long vpro2[]) 
{ 
    extern long     orbitflag[]; 

    long            f, g, h, i, j, k, r, s; 
    long            m, n, p; 
    unsigned long   t, tt; 
    long            shift; 
    long           *ip1, *ip2; 
    char           *sp3, *sp4; 
    char            c, d; 
    long            sw; 

/* process xnt element first */ 

    if (xnt < 0)  goto CC;   /* no fragment of target in RHS */ 
         
    for (i = 0, j = 0; i < xnt; ++i)  { 
        f = vpro2[i]; 
        g = vlen2[i]; 
        if (f != 2 && f != 3) j += g; 
        else  if (j < g)      j = g; 
    } 

  /* case 1: fragment is being moved to the left or is stationary 
             action = concatenate normally                       */ 

    shift = j + sp1 - vp2[xnt]; 
    if (shift <= 0 && vpro2[xnt] != 6)  { 
        xnt = -1; 
        goto CC; 
    } 

  /* case 2: fragment is being moved to the right
             action = concatenate first and backwards            */ 

    sp3 = sp1 + j; 
    sp4 = vp2[xnt]; 
    h = vlen2[xnt]; 

    s = vpro2[xnt] & 0xff; 
    sw = 1; 
    switch (s)  { 
        case 1:                       /* direct transfer */ 
            j = h - 1; 
#if FASTBYTE 
            if (h > 15)  { 
                ip1 = (long *) (sp3 + h - 4); 
                ip2 = (long *) (sp4 + h - 4); 
                g = h >> 2; 
                for (i = 0; i < g; ++i)  { 
                    *(ip1-i) = *(ip2-i); 
                } 
                g <<= 2; 
                j -= g; 
            } 
#endif 
            while (j >= 0)  { 
                *(sp3+j) = *(sp4+j); 
                --j; 
            } 
            break; 
        case 4:                       /* LCS function */ 
            sw = 0; 
        case 5:                       /* UCS function */ 
            sp3 += h; 
            sp4 += h; 
            for (i = h; i > 0; --i) { 
                --sp3; 
                --sp4; 
                *sp3 = case_convert((unsigned char) *sp4, sw); 
            } 
            break; 
        case 6:                       /* REV function */ 
            if (shift <= 0)  { 
                sp4 += h - 1; 
                for (i = 0; i < -shift && i < h; ++i)  { 
                    *(sp3+i) = *(sp4-i); 
                } 
                g = (h + i) / 2; 
                for (; i < g; ++i)  { 
                    c = *(sp4-i); 
                    *(sp4-i) = *(sp3+i); 
                    *(sp3+i) = c; 
                } 
                break; 
            } 
            sp3 += h - 1; 
            for (i = 0; i < shift && i < h; ++i)  { 
                *(sp3-i) = *(sp4+i); 
            } 
            g = (h + i) / 2; 
            for (; i < g; ++i)  { 
                c = *(sp4+i); 
                *(sp4+i) = *(sp3-i); 
                *(sp3-i) = c; 
            } 
            break; 
        case 9:                       /* DUP function */ 
            g = vpro2[xnt] >> 8; 
            g &= 0x7fffff;                    /* g = number of reps */ 
            k = h / g; 
            for (i = k - 1; i >= 0; --i)  {   /* first rep of dup */ 
                *(sp3+i) = *(sp4+i); 
            } 
            sp4 = sp3;          /* source for further dups */ 
            sp3 += k;           /* destination for further dups */ 
            for (f = 1; f < g; ++f)  { 
                memcpy((void *) sp3, (void *) sp4, (size_t) k); 
                sp3 += k; 
            } 
            break; 
    } 

CC: 
    for (n = 0, j = 0; n < cnt; ++n)  { 
        if (n == xnt)  { 
            j += vlen2[n];      /* this part of string is done already */ 
            continue; 
        } 
        sp3 = sp1 + j; 
        sp4 = vp2[n]; 
        h = vlen2[n]; 
        s = vpro2[n]; 
        k = s >> 8; 

        s &= 0xff; 
        sw = 0; 
        switch (s) { 
            case 1:                   /* direct transfer */ 
                memcpy((void *) sp3, (void *) sp4, (size_t) h); 
                j += h; 
                break; 
            case 2:                   /* PAD function    */ 
                sw = ' '; 
            case 3:                   /* ZPD function    */ 
                g = h - j; 
                j = h; 
                memset((void *) sp3, (int) sw, (size_t) g);
                break; 
            case 5:                   /* UCS function    */ 
                sw = 1; 
            case 4:                   /* LCS function    */ 
                for (i = 0; i < h; ++i) { 
                    *sp3++ = case_convert((unsigned char) *sp4++, sw); 
                } 
                j += h; 
                break; 
            case 6:                   /* REV function    */ 
                sp3 += h - 1; 
                for (i = 0; i < h; ++i) { 
                    *(sp3-i) = *(sp4+i); 
                } 
                j += h; 
                break; 
            case 7:                   /* CBY function    */ 
                ip1 = (long *) sp4; 
                m = k >> 8;           /* m = number of dead bits */ 
                k &= 0x1f;            /* k = initial offset      */ 
                j += h; 
                g = h;                /* save output length      */ 
                h *= 8; 
                h -= m;               /* h = bitstring length    */ 
                h += 31; 
                h >>= 5;              /* h = number of full words */ 
                r = 32 - k; 
                for (i = 0; i < h; ++i)  { 
                    p = *ip1 << k;             /* 0 <= k <= 31 */ 
                    ++ip1; 
                    t = (unsigned long) *ip1; 
                    if (r == 32)    t = 0; 
                    else            t >>= r; 
                    p |= t; 
                    for (f = 24, t = 0xff000000; f >= 0 && g > 0; f -= 8)  { 
                        tt = p & t; 
                        *sp3++ = tt >> f; 
                        t >>= 8; 
                        --g; 
                    } 
                } 
                r = 0xff << m; 
                --sp3; 
                *sp3 &= r;                     /* clear the dead bits */ 
                break; 
            case 8:                   /* UPK function    */ 
                ip1 = (long *) sp4; 
                m = k >> 8;           
                d = m & 0xff;         /* byte for representing 0 */ 
                m >>= 8; 
                c = m;                /* byte for representing 1 */ 
                k &= 0x1f;            /* k = initial offset      */ 
                j += h; 
                for (i = 0; i < h; ++i)  { 
                    if ((*ip1 & orbitflag[k]) != 0)  *sp3 = c; 
                    else                             *sp3 = d; 
                    ++sp3; 
                    ++k; 
                    if (k == 32)  { 
                        k = 0; 
                        ++ip1; 
                    } 
                } 
                break; 
            case 9:                   /* DUP function */ 
                k &= 0x7fffff;                /* k = number of reps */ 
                g = h / k;                    /* g = length of segment */ 
                for (f = 0; f < k; ++f)  { 
                    memcpy((void *) sp3, (void *) sp4, (size_t) g); 
                    sp3 += g; 
                } 
                break; 
        } 
    } 
    return; 
} 

/*** FUNCTION   void do_txt(sp1, mlen, sp2, g, *tip, *tip2, inc, TIPC); 

    Purpose:   perform the string txt function 

    Input:     char   *sp1   output string 
               long    mlen  maximum length of output string 
               char   *sp2   input string 
               long    g     run-time length of input string 
               long   *tip   pointer to test set 
               long   *tip2  pointer to subscript value 
               element TIPC  union pntr to LHS var in i-code (for errors) 

    Return:    void

    Output:    output string constructed 
               long   *inc   length of resultant string 
               long   *tip2  pointer advanced 

    Operation: Starting at subscript i = *tip2 of input string sp2 
                 if i < 1, i = 1 
                 j = 0   length of output_string 
                 goto A 
               (A) if i > len(input_string)  goto C 
                 if input_string{i} in set *tip 
                   ++i; goto A 
                 else goto B 
               (B) if ++j > mlen  --> strlenerr 
                 output_string{j} = input_string{i++} 
                 if i > len(input_string) or input_string{i} in *tip 
                   goto C 
                 else goto B 
               (C) j = final length of output_string 
                 *tip2 = i; 
                 return 
                                                              ***/ 
void do_txt(char *sp1, long mlen, char *sp2, long g, long *tip, 
    long *tip2, long *inc, element TIPC) 
{ 
    extern long orbitflag[]; 
    long   h, i, j, k, m; 
    long   maxf; 

    maxf = mlen >> 30; 
    maxf &= 0x03; 
    mlen &= 0x3fffffff; 

    i = *tip2; 
    if (i < 1) i = 1; 
    j = 0; 
    --sp1;          /* adjust pointers because we */ 
    --sp2;          /* are using zbex subscripts  */ 
    m = 0;                                 /* mode flag */ 
A: 
    if (i > g)  goto C; 
    k = *(sp2+i); 
    h = k & 0x1f; 
    k >>= 5; 
    if ((*(tip+k) & orbitflag[h]) != 0) {  /* byte is member of set */ 
        if (m == 0)  { 
            ++i; 
            goto A; 
        } 
        goto C; 
    } 
    m = 1;                                 /* change mode */ 
    ++j; 
    if (j > mlen)  strlenerr(j, mlen, TIPC, maxf); 
    *(sp1+j) = *(sp2+i); 
    ++i; 
    goto A; 
C: 
    *inc = j; 
    *tip2 = i; 
} 

#endif 

#if BITSTRS 

/*** FUNCTION   void Zappbstr(ip, off, mlen, *slen, nxop, TIPC); 

    Purpose:   process multiple bit string concatenations 

    Input:     long    *ip    pointer to word at which to begin appending 
               long     off   offset within word at which to begin 
               long     mlen  maximum length of target string (+ flag) 
               long    *slen  pointer to current length of target string 
               long     nxop  first appending operator 
               element  TIPC  union pntr to LHS var in i-code (for errors) 

    Return:    void 

    Output:    long    *slen  final length of target string 
                                                                 ***/
void Zappbstr(long *ip, long off, long mlen, long *slen, 
    long nxop, element TIPC) 
{ 
    long     f, h, k; 
    long     inc; 
    long    *ip2; 
    long     xop; 
    long     maxf; 

    xop  = nxop; 

    maxf = mlen >> 30; 
    maxf &= 0x03; 
    maxf <<= 1;              /* maxf = 0 or 2 */ 
    mlen &= 0x3fffffff; 

/* appending loop */ 
 
BAPP:

    switch (xop)  { 
        case 0: 
            return; 
        case 40: 
            Zidsubbitstr(&ip2, &f, &h, &xop); 
            *slen += h; 
            if (*slen > mlen)  strlenerr(*slen, mlen, TIPC, maxf); 
            k = off; 
            work_around_1(ip, &inc, ip2, h, &k, f, 1L);
            off = k; 
            ip += inc; 
            goto BAPP; 
        case 41: 
            Zappbfun(ip, off, &inc, mlen, slen, &xop, TIPC); 
            off += inc; 
            k = off >> 5; 
            ip += k; 
            k <<= 5; 
            off -= k; 
            goto BAPP;
    } 
    return; 
} 

/*** FUNCTION   void Zappbfun(ip, off, *inc, mlen, *slen, *nxop, TIPC); 

    Purpose:   append a function at point ip of a bit-string          

    Input:    (element  IPC) union pointer to subscript in i-code 
               long    *ip   pointer to word at which to begin appending 
               long     off  offset within word at which to begin 
               long     mlen maximum length of target string (+ flag) 
               long    *slen pointer to current length of target string 
               element  TIPC union pntr to LHS var in i-code (for errors) 

    Return:    void

    Output:   (element  IPC) updated union pointer in i-code 
               long    *inc  increment to offset (un-modularized) 
               long    *slen final length of target string 
               long    *nxop next appending operator 

                                                                ***/ 

void Zappbfun(long *ip, long off, long *inc, long mlen, 
    long *slen, long *nxop, element TIPC) 
{ 
    extern element  IPC; 
    extern long     orbitflag[]; 
    extern long     andbitflag[]; 

    long            f, g, h, i, j, k, n; 
    long            a, b, c, d; 
    unsigned long   t; 
    long           *ip2, *ip3, *ip4, fna; 
    char           *sp2, *sp3; 
    long            tslen; 
    long            maxf; 
    unsigned char   sw; 
     
    maxf = mlen >> 30; 
    maxf &= 0x03; 
    maxf <<= 1;              /* maxf = 0 or 2 */ 
    mlen &= 0x3fffffff; 

/* get function number and next operator */ 

    h = *IPC.n++; 
    *nxop = h >> 16; 
    fna = h & 0xffff; 

    tslen = *slen; 
    sw = 0;           

    switch (fna) { 
        case 0:            /* simple transfer */ 
            Zidsubbitstr(&ip2, &f, &h, &n); 
            tslen += h; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            *inc = h; 
            k = off; 
            work_around_1(ip, &a, ip2, h, &k, f, 1L);
            break; 
        case NPD:          /* pad with ones   */ 
            sw = 1; 
        case ZPDB:         /* pad with zeros  */ 
            h = Zevints(); 
            if (h > mlen)  strlenerr(h, mlen, TIPC, maxf); 
            g = h - tslen; 
            if (g > 0)  { 
                tslen = h; 
                *inc  = g; 
                k = 32 - off;        /* 0 <= off <= 31 */ 
                t = 0xffffffff; 
                if (sw == 0) { 
                    if (k == 32)   t = 0; 
                    else           t <<= k; 
                    *ip &= t;        /* zero word from offset to end */ 
                    t = 0; 
                } 
                else { 
                    t >>= off; 
                    *ip |= t;        /* set one's from offset to end */ 
                    t = 0xffffffff; 
                } 
                g -= k; 
                if (g > 0)  { 
                    ++ip; 
                    g += 31;
                    g >>= 5;         /* number of words to alter */ 
                    for (i = 0; i < g; ++i) { 
                        *(ip+i) = t; 
                    } 
                } 
            } 
            else *inc = 0; 
            break; 
        case CBI:          /* convert string to bit-string */ 
            Zidsubstr(&sp2, &h, &k, &i); 
            h <<= 3; 
            tslen += h; 
            *inc = h;          /* added &dA03/08/97&d@  */ 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
          /* tricky code, but it works! */ 
            f = 24; 
            while (h > 0) { 
                if (f >= 32)  t = 0; 
                else          t = *sp2 << f; 
                t >>= off;                          /* 0 <= off <= 31 */ 
                if (off == 0)  { 
                    *ip = 0; 
                } 
                else  { 
                    *ip &= (0xffffffff << (32 - off));  /* clear space */ 
                } 
                *ip |= t;                           /* add bits    */ 
                k = (f > off) ? f : off; 
                off += 32 - k;     /* (32-k) bits added to target  */ 
                f += 32 - k; 
                if (off == 32)  { 
                    off = 0; 
                    ++ip; 
                } 
                if (f == 32)  { 
                    f = 24; 
                    ++sp2; 
                } 
                h -= 32 - k; 
            } 
            break; 
        case PAK2:         /* construct bit-string from "on-off" string */ 
            sw = 'x'; 
        case PAK1: 
            Zidsubstr(&sp2, &h, &g, &i); 
            tslen += h; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            if (sw != 'x')  { 
                Zidsubstr(&sp3, &j, &g, &i); 
                if (j > 0) sw = *sp3; 
                else       sw = 'x'; 
            } 
            *inc = h; 
            while (h > 0)  { 
                if (*sp2 == sw)  *ip |= orbitflag[off]; 
                else             *ip &= andbitflag[off]; 
                ++sp2; 
                ++off; 
                if (off == 32) { 
                    off = 0; 
                    ++ip; 
                } 
                --h; 
            } 
            break; 
        case MRTB:         /* skip initial zeros and transfer */ 
            sw = 1; 
        case TRMB:         /* trim zeros and transfer */ 
            Zidsubbitstr(&ip2, &f, &h, &n); 
            if (h == 0) { 
                *inc = 0; 
                break; 
            } 
            if (sw == 0) { 
                g = f + h - 1;   /* g --> last bit in source string */ 
                k = g >> 5; 
                ip3 = ip2 + k;   /* --> last word */ 
                k <<= 5; 
                g -= k;          /* g = offset off last bit */ 
                while (h > 0)  {
                    if ((*ip3 & orbitflag[g]) != 0) break; 
                    --g; 
                    if (g < 0)  { 
                        g = 31; 
                        --ip3; 
                    } 
                    --h; 
                } 
            } 
            else { 
                for (i = 0; i < h; ++i)  { 
                    if ((*ip2 & orbitflag[f]) != 0) break; 
                    ++f; 
                    if (f == 32)  { 
                        f = 0; 
                        ++ip2; 
                    } 
                } 
                h -= i; 
            } 
            tslen += h; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            *inc = h; 
            if (ip != ip2 || off != f) { 
                k = off; 
                work_around_1(ip, &a, ip2, h, &k, f, 1L);
            } 
            break; 
        case REVB:         /* reverse string and transfer */ 
            sw = 1; 
        case CMP:          /* complement and transfer */ 
            Zidsubbitstr(&ip2, &f, &h, &n); 
            if (h == 0)  { 
                *inc = 0; 
                break; 
            } 
            tslen += h; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            *inc = h; 
            if (sw == 0)  {       /* case CMP */ 
                k = off; 
                work_around_1(ip, &a, ip2, h, &k, f, 2L);
                break; 
            } 
            g = f + h - 1;   /* g --> last bit in source string */ 
            k = g >> 5; 
            ip3 = ip2 + k;   /* --> last word */ 
            k <<= 5; 
            g -= k;          /* g = offset off last bit */ 
            while (h > 0)  {
                if ((*ip3 & orbitflag[g]) == 0) { 
                    *ip &= andbitflag[off];      /* turn bit off */ 
                } 
                else { 
                    *ip |= orbitflag[off];       /* turn bit on  */ 
                } 
                ++off; 
                if (off == 32)  { 
                    off = 0; 
                    ++ip; 
                } 
                --g; 
                if (g < 0) { 
                    g = 31; 
                    --ip3; 
                } 
                --h; 
            } 
            break; 
        case DUPB: 
            Zidsubbitstr(&ip2, &f, &h, &n); 
            k = Zevints(); 
            if (k < 0)   k = 0; 
            tslen += h * k; 
        /*  *inc  += h * k;  ERROR found &dA03/08/97&d@  */ 
            *inc  = h * k; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            b = k; 
            for (i = 0; i < b; ++i) { 
                k = off; 
                work_around_1(ip, &a, ip2, h, &k, f, 1L);
                off = k; 
                ip += a; 
            } 
            break; 
        case BND:          /* "and" bit-strings and transfer */ 
            sw = 1; 
        case BOR:          /* "or" bit-strings and transfer */ 
    /* (1) get strings */ 
            Zidsubbitstr(&ip2, &f, &h, &n); 
            Zidsubbitstr(&ip3, &g, &k, &n); 
    /* (2) switch if second is longer */ 
            if (k > h)  { 
                ip4 = ip2;  ip2 = ip3;  ip3 = ip4; 
                i = h;      h = k;      k = i; 
                i = f;      f = g;      g = i; 
            } 
    /* (3) set parameters for operation  */ 
            if (sw == 1) { 
                c = 3; 
                d = k; 
            } 
            else { 
                c = 4; 
                d = h; 
            } 
    /* (4) copy first string into dest (with 2nd len, if BND) */ 
            tslen += h; 
            if (tslen > mlen)  strlenerr(tslen, mlen, TIPC, maxf); 
            *inc = h; 
            i = off; 
            work_around_1(ip, &a, ip2, d, &i, f, 1L);
    /* (4a) if BND, fill out rest of dest (to 1st len) with zeros */ 
            if (sw == 1) { 
                ip4 = ip + a; 
                h -= k; 
                work_around_1(ip4, &a, ip2, h, &i, f, 5L);
            } 
    /* (5) "and"/"or" second string into dest */ 
            i = off; 
            work_around_1(ip, &a, ip3, k, &i, g, c);
            break; 
    } 
    *slen = tslen; 
    return; 
} 

/*** FUNCTION   void work_around_1(*ip1, *inc1, *ip2, len, *off1, off2, opf); 

    Purpose:   transfer a bit-string according to specified operation 

    Input:     long  *ip1   pointer to destination word 
               long  *ip2   pointer to source word 
               long   len   length of transfer (source string) 
               long  *off1  pointer to offset value in dest word 
               long   off2  offset value in source word 
               long   opf   operation flag 
                              1 = direct transfer 
                              2 = invert and transfer 
                              3 = "and" bits with destination 
                              4 = "or"  bits with destination 
                              5 = zero  bits in destination 
                                    (source not used) 

    Return:    void 

    Output:    long  *inc1  increment to ip1 
               long  *off1  new offset value in dest word 
                                                                 ***/ 

void work_around_1(long *ip1, long *inc1, long *ip2, long len, 
    long *off1, long off2, long opf) 
{ 
    long          h, k; 
    long          a, b, c, d; 
    unsigned long t; 

    c = 32; 
    *inc1 = 0; 
    while (len > 0)  { 
 
    /* (1) construct bit substring in word t */ 

        if (opf == 1 || opf == 3 || opf == 4)  { 
            t = *ip2 << off2;   /* 32 - off2 = max number of source 
                                               bits in this pass */ 
        } 
        else { 
            t = (~(*ip2)) << off2; 
        } 
        t >>= *off1;            /* 32 - *off1 = max amount of space 
                                         in target for this pass */ 
    /* (2) construct space mask for t */ 

        h = (off2 > *off1) ? off2 : *off1; 
        k = c - len; 
        if (h < k)  h = k; 
        k = c - h;              /* add k bits to target */ 

        a = 0xffffffff; 
        b = a; 
        d = c - *off1; 
        if (d == 32)  a = 0; 
        else          a <<= d; 
        b <<= d - k; 
        a |= ~b;        /* mask bits are "on" outside effected area */ 

    /* (3) insert t into target */ 

        switch (opf) { 
            case 1: 
            case 2:             /* transfer */ 
                *ip1 &= a; 
                t &= ~a; 
                *ip1 |= t; 
                break; 
            case 3:             /* and */ 
                t |= a; 
                *ip1 &= t; 
                break; 
            case 4:             /* or */ 
                t &= ~a; 
                *ip1 |= t; 
                break; 
            case 5:             /* simple zero dest */ 
                *ip1 &= a; 
                break; 
        } 

    /* (4) increment offsets by k */ 

        *off1 += k; 
        off2 += k; 
        if (*off1 == c) { 
            *off1 = 0; 
            ++ip1; 
            ++(*inc1); 
        } 
        if (off2 == c) { 
            off2 = 0; 
            ++ip2; 
        } 
        len -= k; 
    } 
} 

/*** FUNCTION   void bits_right_shift(*ip1, off1, *ip2, off2, len); 

    Purpose:   shift <len> bits at location (ip2,off2) right to 
                 location (ip1, off1) 

    Input:     long  *ip1  pointer to destination word 
               long   off1 offset value in dest word 
               long  *ip2  pointer to source word 
               long   off2 offset value in source word 
               long   len  number of bits to shift (max is 32) 

                                                                ***/ 
void bits_right_shift(long *ip1, long off1, long *ip2, long off2, long len) 
{ 
    extern long orbitflag[]; 
    extern long andbitflag[]; 

    long i; 

    off2 += len - 1; 
    if (off2 > 31) { 
        off2 -= 32; 
        ++ip2; 
    } 
    off1 += len - 1; 
    if (off1 > 31) { 
        off1 -= 32; 
        ++ip1; 
    } 
    for (i = 0; i < len; ++i) { 
        if ((*ip2 & orbitflag[off2]) != 0) *ip1 |= orbitflag[off1]; 
        else                               *ip1 &= andbitflag[off1]; 
        --off2; 
        if (off2 < 0) { 
            off2 = 31; 
            --ip2; 
        } 
        --off1; 
        if (off1 < 0) { 
            off1 = 31; 
            --ip1; 
        } 
    } 
} 

#endif 
