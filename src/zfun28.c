/***                         DMUSE PROGRAM 
                           LINUX version 0.00 
            (c) Copyright 1992, 1999, 2007 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 09/18/2007) 
                            (rev. 12/27/2009) 

                 Zbex Interpreter processing functions 
                                                                        ***/ 
#include  "all.h" 

/*** FUNCTION   void Zrel_idgenstr(*(*stradd), f); 

    Purpose:   identify pointer to general type II string 
                 or bit-string 

    Input:    (element  IPC)  union pointer to string in i-code 
               long     f     flag: 1 = process string 
                                    2 = process bit-string 

    Return:    void 

    Output:    long  *(*stradd)   pointer to string variable 

    Error conditions:  array sbuscript error 

    Operation: This function is called to determine the pointer 
               to a general string on the LHS of a con relation 
               statement.               
                                                                    ***/ 
void Zrel_idgenstr(long *(*stradd), long f) 
{ 
    extern element IPC; 
    extern element elk;  /* run-time union pointer to link mem */ 

    element save_IPC; 
    element var_pnt; 
    long    h, off; 

    save_IPC = IPC; 

    var_pnt.n = *IPC.p;       /* tricky code */ 
    h = var_pnt.n - elk.n; 
    IPC.n += 2; 

    if ((h & 1) == 0)  off = 0;      /* simple variable */ 
    else               off = Zcompute_offset(&var_pnt, save_IPC); 
                             /* var_pnt is advanced by this function */ 
    h = *(var_pnt.n + 1);    /* maximum string length */ 
    if (f == 1)        off *= (h + 7) >> 2; 
    else               off *= (h + 63) >> 5; 
    *stradd = *var_pnt.p + off; 
    IPC = save_IPC; 
} 

/*** FUNCTION   void Zrel_idsubstr(*(*s), *len); 

    Purpose:   identify a general string substring (simple/array) in a 
                 relational statement 

    Input:    (element  IPC)  union pointer to string in i-code 

    Return:    void 

    Output:   (element  IPC)  updated union pointer into i-code 
               char    *(*s)  pointer to pointer to starting character 
               long    *len   length of string (-1 if subscript error 
                                has occurred).  A string subscript 
                                warning will be given if bit 8 of the 
                                operation flag is set.  

    Error conditions:  array subscipt error 

    Operation: This function is called to handle strings and substrings 
               in relations.  
                                                             ***/ 

void Zrel_idsubstr(char *(*s), long *len) 
{ 
    extern element IPC; 
    extern element elk;  /* run-time union pointer to link mem */ 

    element pt; 
    element var_pnt; 
    long    h, off; 
    long    subflag, *spoint; 
    long    off1; 

    pt.n = IPC.n; 
    var_pnt.n = *IPC.p++;       /* tricky code */ 
    h = var_pnt.n - elk.n; 
    subflag = *(IPC.n++) & 0xffff; 

    if ((h & 1) == 0)  off = 0;      /* simple variable */ 
    else               off = Zcompute_offset(&var_pnt, pt); 
                             /* var_pnt is advanced by this function */ 
    h = *(var_pnt.n + 1);    /* maximum string length */ 
    off *= (h + 7) >> 2; 
    spoint = *var_pnt.p + off; 

/* determine location and length */ 

    *s = (char *) (spoint + 1); 
    if (subflag == 0)   { 
        *len = *spoint; 
    } 
    else { 
        Zget_sub_offlen(subflag, *spoint, &off1, len, pt); 
        *s += off1; 
    } 
} 

/*** FUNCTION   void Zget_sub_offlen(subflag, slen, *off1, *len, TIPC); 

    Purpose:   get offset and length from string subscripts 

    Input:    (element  IPC)     union pointer to subscripts 
               long     subflag  subscript format 
               long     slen     dynamic length of string 
               element  TIPC     union pointer to string variable 
                                   (for errors) 
    Return:    void 

    Output:   (element  IPC)     updated pointer into i-code 
               long    *off1     first offset  ( >= 0) 
               long    *len      length of substring (-1 if subscript error) 

    Error conditions:  string subscript warning 
                       negative string length warning 
                                                                    ***/ 
void Zget_sub_offlen(long subflag, long slen, long *off1, 
    long *len, element TIPC) 
{ 
    extern element IPC; 

    long    f, g, h, i, j, k; 

    if (subflag == 1) { 
        *off1 = slen - 1; 
        *len  = 1; 
        return; 
    } 
    i = subflag >> 3; 
    j = subflag & 0x07; 
    switch (i) { 
        case 1:                   /* subscripts are literals        */ 
            k = *IPC.n++; 
            if (j > 4)  h = *IPC.n++; 
            break; 
        case 2:                   /* subscripts simple variables    */ 
            k = *(*IPC.p++); 
            if (j > 4)  h = *(*IPC.p++); 
            break; 
        case 3:                   /* subscripts are int expressions */ 
            Zevsub(&k); 
            if (j > 4)  Zevsub(&h); 
            break; 
    } 

    g = -1;          /* error leng */ 
    f = k - 1;       /* most common offset */ 
    switch (j)  { 
        case 2:                   /* {x}    */ 
            if (k > slen || k < 1)  { 
                strsubwarn(k, slen, TIPC, 1L); 
                break; 
            } 
            g = 1; 
            break; 
        case 3:                   /* {x..}  */
            if (k > slen || k < 1)  { 
                strsubwarn(k, slen, TIPC, 1L); 
                break; 
            } 
            g = slen - k + 1; 
            break; 
        case 4:                   /* {1,x}  */
            if (k > slen)  { 
                strsubwarn(k, slen, TIPC, 1L); 
                break; 
            } 
            if (k < 0)     { 
                negstrwarn(k, TIPC); 
                break; 
            } 
            f = 0; 
            g = k; 
            break; 
        case 5:                   /* {x..y} */
            if (k > slen || k < 1)  { 
                strsubwarn(k, slen, TIPC, 1L); 
                break; 
            } 
            if (h > slen || h < 1)  { 
                strsubwarn(h, slen, TIPC, 2L); 
                break; 
            } 
            if ((i = h - k + 1) < 0)  { 
                negstrwarn(i, TIPC); 
                break; 
            } 
            g = h - k + 1; 
            break; 
        case 6:                   /* {x,y}  */
            if (k > slen || k < 1)  { 
                strsubwarn(k, slen, TIPC, 1L); 
                break; 
            } 
            if ((i = k + h - 1) > slen)  { 
                strsubwarn(i, slen, TIPC, 2L); 
                break; 
            } 
            if (h < 0)     { 
                negstrwarn(k, TIPC); 
                break; 
            } 
            g = h; 
            break; 
    } 
    *off1 = f; 
    *len  = g; 
} 

/*** FUNCTION   void Zrel_idsubbitstr(*(*bsw), *bnum, *len); 

    Purpose:   identify a general bit_string substring (simple/array) in a 
                 relational statement 

    Input:    (element   IPC)    union pointer to string in i-code 

    Return:    void 

    Output:   (element   IPC)    updated union pointer into i-code 
               char     *(*bsw)  pointer to pointer to starting character 
               long     *bnum    bit number in bit string word 
               long     *len     length of string (-1 if subscript error 
                                   has occurred).  A string subscript 
                                   warning will be given if bit 8 of the 
                                   operation flag is set.  

    Error conditions:  array subscipt error 

    Operation: This function is called to handle bit-strings and 
               bit-substrings in relations.  
                                                             ***/ 

void Zrel_idsubbitstr(long *(*bsw), long *bnum, long *len) 
{ 
    extern element IPC; 
    extern element elk;  /* run-time union pointer to link mem */ 

    element pt; 
    element var_pnt; 
    long    h, off; 
    long    subflag, *spoint; 
    long    off1; 

    pt.n = IPC.n; 
    var_pnt.n = *IPC.p++;       /* tricky code */ 
    h = var_pnt.n - elk.n; 
    subflag = *(IPC.n++) & 0xffff; 

    if ((h & 1) == 0)  off = 0;      /* simple variable */ 
    else               off = Zcompute_offset(&var_pnt, pt); 
                             /* var_pnt is advanced by this function */ 
    h = *(var_pnt.n + 1);    /* maximum string length */ 
    off *= (h + 63) >> 5; 
    spoint = *var_pnt.p + off; 

/* determine location and length */ 

    *bsw = spoint + 1; 
    if (subflag == 0)   { 
        *len  = *spoint; 
        *bnum = 0; 
    } 
    else { 
        Zget_sub_offlen(subflag, *spoint, &off1, len, pt); 
        h = off1 >> 5; 
        *bsw += h; 
        h <<= 5; 
        *bnum = off1 - h; 
    } 
} 

/*** FUNCTION   long bitcmp(ip1, off1, ip2, off2, slen); 

    Purpose:   compare two bitstrings 

    Input:     long  *ip1   pointer to first word of bitstring 1 
               long  off1   offset in *ip1 to start of bitstring 1 
               long  *ip2   pointer to first word of bitstring 2 
               long  off2   offset in *ip2 to start of bitstring 2 
               long  slen   length of comparison 

    Return:    0 = strings are equal 
               1 = first string is greater 
              -1 = second string is greater 
                                                               ***/ 
long bitcmp(long *ip1, long  off1, long *ip2, long off2, long slen) 
{ 
    long  a, b; 
    long  i, j; 
    unsigned long t1, t2, t3; 

    long c; 
    c = 0; 

    a = 32 - off1; 
    b = 32 - off2; 
    for (i = slen; i > 0; i -= 32)  { 
        if (i > 32)  j = 0; 
        else         j = 32 - i;    /* 0 <= j <= 31 */ 
        if (off1 == 0)  { 
          t1 = *ip1; 
        } 
        else  {     
          t3 = (unsigned long) *(ip1+1); 
          t1 = (*ip1 << off1) + (t3 >> a);  /* 1 <= a <= 31 */ 
        } 
        if (off2 == 0)  { 
          t2 = *ip2; 
        } 
        else  {      
          t3 = (unsigned long) *(ip2+1); 
          t2 = (*ip2 << off2) + (t3 >> b);  /* 1 <= b <= 31 */ 
        } 
        t1 >>= j; 
        t2 >>= j; 
        if (t1 > t2)  return (1); 
        if (t2 > t1)  return (-1); 
        ++ip1; 
        ++ip2; 
    } 
    return (0); 
} 
