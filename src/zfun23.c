/***                         DMUSE PROGRAM 
                           LINUX version 1.02 
         (c) Copyright 1992, 1999, 2007, 2009 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 09/15/2007) 
                            (rev. 04/24/2009) 
                            (rev. 12/27/2009) 

                     Interpreter processing functions 
                                                                        ***/ 
#include  "all.h" 

/*** FUNCTION   void Zevsub(*val); 

    Purpose:   evaluate subscript 

    Input:    (element IPC)  union pointer to subscript in i-code 

    Return:    void 

    Output:   (element  IPC) updated union pointer in i-code 
               long    *val  integer value of subscript 

    Error conditions:  divide by zero 
                                                                   ***/ 

void Zevsub(long *val) 
{ 
    extern element  IPC; 

    long    h, k; 
    long    g; 

    k = *(*IPC.p++);           /* starting value */ 
    h = *(IPC.n++);            /* operator, or zero */ 
    while (h > 0)  { 
        if (h < 9)  { 
            g = *(IPC.n++);    /* next value is constant */ 
        } 
        else  { 
            h -= 8; 
            g = *(*IPC.p++);   /* next value is variable */ 
        } 
        k = int_op(k, g, h, IPC.n); 
        h = *(IPC.n++); 
    } 
    *val = k; 
} 

/*** FUNCTION   long int_op(k, g, h, p); 

    Purpose:   perform operation <h> on <k> with <g> 

    Input:     long  k   first operand 
               long  g   second operand 
               long  h   operation 
               long *p   pointer where error occured (for errors) 

    Return:    long  k   result 

    Error conditions:  divide by zero 
                                                                ***/ 

long int_op(long k, long g, long h, long *p) 
{ 
    extern element elk;       /*  run-time union pointer to link mem */ 
                        
    long          i, j; 
    unsigned long ui; 

    switch (h)  { 
        case 1: 
            k += g; 
            break; 
        case 2: 
            k -= g; 
            break; 
        case 3: 
            k *= g; 
            break; 
        case 4: 
            if (g == 0)  zerodiv(p); 
            j = k / g; 
            i = j * g; 
            *(elk.n + REM) = k - i; 
            k = j; 
            break; 
        case 5: 
            k |= g; 
            break; 
        case 6: 
            k &= g; 
            break; 
        case 7: 
            if (g < 32)  {
                if (g > 0)  k <<= g; 
            } 
            else    k = 0; 
            break; 
        case 8: 
            if (g < 32)  {
                if (g > 0)  {
                    ui = (unsigned long) k; 
                    ui >>= g; 
                    k = ui; 
                } 
            } 
            else    k = 0; 
            break; 
    } 
    return (k); 
} 

/*** FUNCTION   void real_op(*x, y, h, p); 

    Purpose:   perform operation <h> on <x> with <y> 

    Input:     double *x   first operand 
               double  y   second operand 
               long    h   operation 
               long   *p   pointer where error occured (for errors) 

    Return:    void  

    Error conditions:  divide by zero 
                                                                ***/ 

void real_op(double *x, double y, long h, long *p) 
{ 

    switch (h)  { 
        case 1: 
            *x += y; 
            break; 
        case 2: 
            *x -= y; 
            break; 
        case 3: 
            *x *= y; 
            break; 
        case 4: 
            if (y == 0.0)     rzerodiv(p); 
            *x /= y; 
            break; 
    } 
} 

/*** FUNCTION   void Zevint(*val, *xop); 

    Purpose:   evaluate integer variable (simple or array) 

    Input:    (element  IPC) union pointer to integer in i-code 

    Return:    void 

    Output:   (element  IPC) updated union pointer into i-code 
               long    *val  integer value variable 
               long    *xop  next operator (or zero) 

    Error conditions:  subscript error 
                                                                  ***/ 
void Zevint(long *val, long *xop) 
{ 
    extern element IPC; 
    extern element elk;       /* run-time union pointer to link mem */ 

    element pt; 
    element var_pnt; 
    long    h, k, off; 

    pt.n = IPC.n; 

/* determine if this is a simple or an array variable */ 

    var_pnt.n = *IPC.p++;     /* pointer to variable (tricky code) */ 
    h = var_pnt.n - elk.n; 
    k = *var_pnt.n; 
    *xop = *IPC.n++; 

    if ((h & 1) == 0)  *val = k; 
    else {                   /* integer array: k = number of dims */ 
        off = Zcompute_offset(&var_pnt, pt); 
        *val = *(*var_pnt.p+off);  /* value of array element */ 
    } 
} 

/*** FUNCTION   long Zcompute_offset(*var_pnt, TIPC); 

    Purpose:   compute offset to array element 
                 (before multiplication by length) 

    Input:     element *var_pnt  union pointer to variable        
               element  TIPC     union pointer to generating instruction 
                                   (for error reporting) 

    Return:    long     offset 

    Output:    element *var_pnt  union pointer to array parameters beyond 
                                   subscripts (e.g. pointer to main mem) 

    Error conditions: array subscript error 
                                                             ***/ 
long Zcompute_offset(element *var_pnt, element TIPC) 
{ 
    element  pt; 
    long     g, h, i, k; 
    long     off; 

    pt.n = (*var_pnt).n;
    k = *pt.n++;     
    for (i = 0, off = 0; i < k; ++i)  { 
        g = *pt.n++;              /* dimension size */ 
        Zevsub(&h);               /* evaluate subscript */ 
        if (h < 1 || h > g)  suberr(h, g, TIPC.n, *TIPC.p, i); 
        off *= g; 
        off += h - 1; 
    } 
    (*var_pnt).n = pt.n;          /* return advanced var pointer */ 
    return (off); 
} 

/*** FUNCTION   long Zevints(); 

    Purpose:   evaluate group of integers (simple or array) 

    Input:    (element IPC) union pointer to integer in i-code 

    Return:    long    integer value of group 

    Output:   (element IPC) updated union pointer into i-code 

    Error conditions:  subscript error 
                       divide by zero 
                                                                  ***/ 
long Zevints() 
{ 
    extern element IPC; 
    extern element elk;   /* run-time union pointer to link mem */ 

    long    g, h, k, opp; 
    long   *errloc; 

    errloc = IPC.n;       /* save for errors */ 

    Zevint(&k, &opp);     /* starting value */ 

    while (opp > 0)  { 
        if (opp < 9)  {      /* next value is constant */
            g = *(IPC.n++);  /* next value    */ 
            h = *(IPC.n++);  /* next operator */ 
        }
        else { 
            opp -= 8; 
            Zevint(&g, &h); 
        } 
        k = int_op(k, g, opp, errloc); 
        opp = h; 
    } 
    return (k); 
} 

/*** FUNCTION   void Zevreal(*val, *xop); 

    Purpose:   evaluate real variable (simple or array) 

    Input:    (element  IPC) union pointer to real variable in i-code 

    Return:    void 

    Output:   (element  IPC) updated union pointer into i-code 
               double  *val  value of real variable 
               long    *xop  next operator (or zero) 

    Error conditions: subscript error 
                                                            ***/ 

void Zevreal(double *val, long *xop) 
{ 
    extern element IPC; 
    extern element elk;   /* run-time union pointer to link mem */ 

    element  pt; 
    element  var_pnt; 
    double  *x; 
    long     h, off; 

    pt.n = IPC.n; 

/* determine if this is a simple or an array variable */ 

    var_pnt.n = *IPC.p++;       /* pointer to variable (tricky code) */ 
    h = var_pnt.n - elk.n; 
    *xop = *IPC.n++; 

    if ((h & 1) == 0) {  /* simple real number */ 
        x = (double *) var_pnt.n;     /* (*pt.p) */ 
    } 
    else {               /* array variable       */ 
        off = Zcompute_offset(&var_pnt, pt); 
        off <<= 1; 
        x = (double *) (*var_pnt.p+off); 
    } 
    *val = *x;       /* value of array element */ 
} 

/*** FUNCTION   void Zevreals(*val); 

    Purpose:   evaluate group of real variables (simple or array) 

    Input:    (element  IPC) union pointer to real variable in i-code 

    Return:    void 

    Output:   (element  IPC) updated union pointer into i-code 
               long    *val  value of group 

    Error conditions:  subscript error 
                       divide by zero 
                                                             ***/ 

void Zevreals(double *val) 
{ 
    extern element IPC; 

    double *x, y, z; 
    long    h, opp; 
    long   *errloc; 

    errloc = IPC.n; 
    Zevreal(&y, &opp);        /* starting value */ 

    while (opp > 0)  { 
        if (opp < 9)  {     /* next value is constant */ 
            x = (double *) IPC.n; 
            z = *x; 
            IPC.n += 2; 
            h = *IPC.n++;     /* next operator */ 
        } 
        else  { 
            opp -= 8; 
            Zevreal(&z, &h); 
        } 
        real_op(&y, z, opp, errloc); 
        opp = h; 
    } 
    *val = y; 
} 

/*** FUNCTION   void ZidA_str(*(*stradd), *mlen, mode); 

    Purpose:   identify an array string variable 

    Input:    (element  IPC)      union pointer to string in i-code 
               long     mode      1 = array string without subs 
                                  2 = array string with subs 

    Return:    void; 

    Output:   (element  IPC)      updated union pointer into i-code 
               long    *(*stradd) pointer to pointer to string var 
               long    *mlen      length of string 

    Error conditions:  array subscript error 

    Operation: This function is called to get the address of an 
               array string.  For formats without string subscripts 
               (the LHS of statements and certain RHS formats), mode 1 
               is used.  For formats with subscripts (e.g. called 
               from the display instruction), mode 2 is used.  
                                                                   ***/ 

void ZidA_str(long *(*stradd), long *mlen, long mode) 
{ 
    extern element IPC; 

    element  pt; 
    element  var_pnt; 
    long     h, off; 

    pt.n = IPC.n; 
    IPC.n += mode; 

    var_pnt.n = *pt.p;       /* pointer to variable (tricky code) */ 

    off = Zcompute_offset(&var_pnt, pt); 
    h = *(var_pnt.n + 1);    /* maximum string length */ 
    off *= (h + 7) >> 2; 
    *mlen = h; 
    *stradd = *var_pnt.p + off; 
} 

/*** FUNCTION   void Zidgenstr(*(*stradd), *mlen, *off1, *off2, *xop, *spt, f);

    Purpose:   identify a general type II string or bit-string 

    Input:    (element  IPC)      union pointer to string in i-code 
               long     f         flag: 1 = process string 
                                        2 = process bitstring 

    Return:    void 

    Output:   (element  IPC)      updated union pointer into i-code 
               long    *(*stradd) pointer to pointer to string var 
               long    *mlen      maximum length of string 
               long    *off1      offset for start of substring.  If 
                                    there are no subscripts present,     
                                    this argument is set to -1.  
               long    *off2      offset for end of substring (in bounds) 
               long    *xop       next operator (if any) 
               long    *spt       dynamic length of string (used only by read/write)

    Error conditions:   array subscript error 
                        string subscript error 

    Operation: This function is called to handle type II strings on 
               the LHS of statements and to handle strings in get      
               statements.  
                                                                 ***/ 
void Zidgenstr(long *(*stradd), long *mlen, 
    long *off1, long *off2, long *xop, long *spt, long f) 
{ 
    extern element IPC; 
    extern element elk;  /* run-time union pointer to link mem */ 

    element pt; 
    element var_pnt; 
    long    h, off; 
    long    subflag, *spoint; 

    pt.n = IPC.n; 
    var_pnt.n = *IPC.p++;       /* tricky code */ 
    h = var_pnt.n - elk.n; 
    subflag = *IPC.n++; 
    *xop = subflag >> 16; 
    subflag &= 0xffff; 

    if ((h & 1) == 0)  off = 0;      /* simple variable */ 
    else               off = Zcompute_offset(&var_pnt, pt); 
                             /* var_pnt is advanced by this function */ 
    h = *(var_pnt.n + 1);    /* maximum string length */ 
    if (f == 1)        off *= (h + 7) >> 2; 
    else               off *= (h + 63) >> 5; 
    *mlen  = h; 
    spoint = *var_pnt.p + off; 
    *spt = *spoint; 
    *stradd = spoint; 

/* determine location and length of sub-string */ 

    if (subflag == 0)  { 
        *off1 = -1; 
    }
    else { 
        Zget_sub_offsets(subflag, *spoint, off1, off2, pt); 
    } 
} 

/*** FUNCTION   void Zget_sub_offsets(subflag, slen, *off1, *off2, TIPC); 

    Purpose:   get offsets from string subscripts 

    Input:    (element  IPC)     union pointer to subscripts 
               long     subflag  subscript format 
               long     slen     dynamic length of string 
               element  TIPC     union pointer to string variable 
                                   (for errors) 
    Return:    void 

    Output:   (element  IPC)     updated pointer into i-code 
               long    *off1     first offset  ( >= 0) 
               long    *off2     second offset ( < slem) 

    Error conditions:  string subscript error 
                       negative string length 
                                                                    ***/ 
void Zget_sub_offsets(long subflag, long slen, long *off1, 
    long *off2, element TIPC) 
{ 
    extern element IPC; 

    long    h, i, j, k; 

    h = 0;
    k = 0;
    if (subflag == 1) { 
        *off1 = slen - 1; 
        *off2 = *off1; 
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
    switch (j)  { 
        case 2:                   /* {x}    */ 
            if (k > slen || k < 1)  { 
                strsuberr(k, slen, TIPC, 1); 
            } 
            *off1 = k - 1; 
            *off2 = *off1; 
            break; 
        case 3:                   /* {x..}  */
            if (k > slen || k < 1)  { 
                strsuberr(k, slen, TIPC, 1); 
            } 
            *off1 = k - 1; 
            *off2 = slen - 1; 
            break; 
        case 4:                   /* {1,x}  */
            if (k > slen)  { 
                strsuberr(k, slen, TIPC, 2); 
            } 
            if (k < 0)     { 
                negstrlen(k, TIPC); 
            } 
            *off1 = 0; 
            *off2 = k - 1; 
            break; 
        case 5:                   /* {x..y} */
            if (k > slen || k < 1)  { 
                strsuberr(k, slen, TIPC, 1); 
            } 
            if (h > slen || h < 1)  { 
                strsuberr(h, slen, TIPC, 2); 
            } 
            if ((i = h - k + 1) < 0)  { 
                negstrlen(i, TIPC); 
            } 
            *off1 = k - 1; 
            *off2 = h - 1; 
            break; 
        case 6:                   /* {x,y}  */
            if (k > slen || k < 1)  { 
                strsuberr(k, slen, TIPC, 1); 
            } 
            if ((i = k + h - 1) > slen)  { 
                strsuberr(k+h-1, slen, TIPC, 2); 
            } 
            if (h < 0)     { 
                negstrlen(h, TIPC); 
            } 
            *off1 = k - 1; 
            *off2 = k + h - 2; 
            break; 
    } 
} 

/*** FUNCTION   void Zidsubstr(*(*s), *len, *xop, *subval); 

    Purpose:   identify a general substring string (simple/array) 

    Input:    (element  IPC)  union pointer to string in i-code 

    Return:    void 

    Output:   (element  IPC)    updated union pointer into i-code 
               char    *(*s)    pointer to pointer to beginning of substr 
               long    *len     length of substring 
               long    *xop     next operator (if any) 
               long    *subval  subscript of first byte (>= 1) 

    Error conditions: array subscript error 
                      string subscript error 

    Operation: This function is called to handle strings and 
               substrings in relations, and for the RHS 
               of statements 
                                                                ***/ 

void Zidsubstr(char *(*s), long *len, long *xop, long *subval) 
{ 
    extern element IPC; 
    extern element elk;   /* run-time union pointers to link mem */ 

    element pt; 
    element var_pnt; 
    long    h, off;
    long    off1, off2;
    long    subflag, *spoint; 
    char   *rs; 

    pt.n = IPC.n; 
    var_pnt.n = *IPC.p++;     /* tricky code */ 
    h = var_pnt.n - elk.n; 
    subflag = *IPC.n++; 
    *xop = subflag >> 16; 
    subflag &= 0xffff; 

    if ((h & 1) == 0)  off = 0; 
    else               off = Zcompute_offset(&var_pnt, pt); 
                             /* var_pnt is advanced by this function */ 
    h = *(var_pnt.n + 1);    /* maximum string length */ 
    off *= (h + 7) >> 2; 
    spoint = *var_pnt.p + off; 

    rs = (char *) (spoint + 1); 
    if (subflag == 0)  { 
        *len = *spoint; 
        *s = rs; 
        *subval = 1; 
    } 
    else { 
        Zget_sub_offsets(subflag, *spoint, &off1, &off2, pt); 
        *len = off2 - off1 + 1; 
        *s = rs + off1; 
        *subval = off1 + 1; 
    } 
}           

/*** FUNCTION   void ZidA_bstr(*(*stradd), *mlen, mode); 

    Purpose:   identify an array bit-string variable 

    Input:    (element  IPC) union pointer to string in i-code 
               long     mode      1 = array string without subs 
                                  2 = array string with subs 

    Return:    void; 

    Output:   (element  IPC)      updated union pointer into i-code 
               long    *(*stradd) pointer to pointer to bit-string var 
               long    *mlen      length of string 

    Error conditions:  array subscript error 

    Operation: This function is called to get the address of an 
               array bit-string.  For formats without string subscripts 
               (the LHS of statements and certain RHS formats), mode 1 
               is used.  For formats with subscripts (e.g. called 
               from the display instruction), mode 2 is used.  
                                                                   ***/ 

void ZidA_bstr(long *(*stradd), long *mlen, long mode) 
{ 
    extern element IPC; 

    element  pt; 
    element  var_pnt; 
    long     h, off; 

    pt.n = IPC.n; 
    IPC.n += mode; 

    var_pnt.n = *pt.p;       /* pointer to variable (tricky code) */ 

    off = Zcompute_offset(&var_pnt, pt); 
    h = *(var_pnt.n + 1);    /* maximum string length */ 
    off *= (h + 63) >> 5; 
    *mlen = h; 
    *stradd = *var_pnt.p + off; 
} 

/*** FUNCTION   void Zidsubbitstr(*(*bsw), *bnum, *len, *xop); 

    Purpose:   identify a general bitstring (simple/array, full/sub) 

    Input:    (element  IPC)   union pointer to bit-string in i-code 

    Return:    void 

    Output:   (element  IPC)   updated pointer into i-code 
               long    *(*bsw) pointer to pointer to bit-string word 
               long    *bnum   bit number in bit string word 
               long    *len    length of (sub)string 
               long    *xop    next operator (if any) 

    Error conditions:  array subscript error 
                       string subscript error 

    Operation: This function is called to handle bit-strings and sub 
               bit-strings in relations, and for the RHS of statements 

                                                                   ***/ 
void Zidsubbitstr(long *(*bsw), long *bnum, long *len, long *xop) 
{ 
    extern element IPC; 
    extern element elk;   /* run-time union pointers to link mem */ 

    element pt; 
    element var_pnt; 
    long    h, off; 
    long    subflag, *spoint; 
    long    off1, off2; 

    pt.n = IPC.n; 
    var_pnt.n = *IPC.p++;         /* tricky code */ 
    h = var_pnt.n - elk.n; 
    subflag = *IPC.n++; 
    *xop = subflag >> 16; 
    subflag &= 0xffff; 

    if ((h & 1) == 0)  off = 0; 
    else               off = Zcompute_offset(&var_pnt, pt); 
                             /* var_pnt is advanced by this function */ 
    h = *(var_pnt.n + 1);    /* maximum string length */ 
    off *= (h + 63) >> 5; 
    spoint = *var_pnt.p + off; 

    *bsw = spoint + 1; 
    if (subflag == 0)  { 
        *len = *spoint; 
        *bnum = 0;
    } 
    else { 
        Zget_sub_offsets(subflag, *spoint, &off1, &off2, pt); 
        *len = off2 - off1 + 1; 
        h = off1 >> 5; 
        *bsw += h; 
        h <<= 5; 
        *bnum = off1 - h; 
    } 
}           

/*** FUNCTION   void Zevfint(*val, *xop); 

    Purpose:   evaluate function with integer output 

    Input:    (element  IPC) union pointer to int function in i-code 

    Return:    void 

    Output:   (element  IPC) updated union pointer into i-code 
               long    *val  integer value of function 
               long    *xop  next operator (or zero) 
                                                            ***/ 
void Zevfint(long *val, long *xop) 
{ 
    extern element IPC; 
    extern element elk;  /* run-time union pointer to link memory */ 

    static unsigned int seed; 
    static long         init = 0; 
    long                g, h, i, k, func, subval, gg; 
    unsigned long       ui; 
    long               *bsw; 
    double              x, y; 
    char               *s, *ss; 

/* determine function number and next operator   */ 

    k = *IPC.n++; 
    *xop = k >> 16; 
    func = k & 0xffff; 

/* process function  */ 

    switch (func)  { 
        case 0:      /* no function */ 
            Zevint(val, &h); 
            break; 
        case RNDI: 
            if (init == 0)  { 
                init = 1; 
                srand( (unsigned) time( NULL ) ); 
                seed = rand(); 
            } 
            h = Zevints(); 
            if (h == 0)  { 
                seed += rand(); 
                srand(seed); 
                *val = 0; 
                break; 
            } 
            y = 32767.0 / h; 
            x = (double) rand() / y; 
            seed = x; 
            *val = x; 
            break; 
        case NOT: 
            h = Zevints(); 
            *val = ~h; 
            break; 
        case ABSI: 
            h = Zevints(); 
            if (h < 0)  h = -h; 
            if (h < 0)  h = -(h - 1); 
            *val = h; 
            break; 
        case AND: 
            h = Zevints(); 
            k = Zevints(); 
            *val = h & k; 
            break; 
        case IOR: 
            h = Zevints(); 
            k = Zevints(); 
            *val = h | k; 
            break; 
        case XOR: 
            h = Zevints(); 
            k = Zevints(); 
            *val = h ^ k; 
            break; 
        case BIT: 
            h = Zevints(); 
            k = Zevints(); 
            h &= 0x1f; 
            *val = (k >> h) & 1; 
            break; 
        case SHR: 
            h = Zevints(); 
            k = Zevints(); 
            if ((k >> 5) != 0)  { 
                *val = 0; 
            } 
            else { 
                ui = (unsigned long) h; 
                ui >>= k; 
                *val = ui; 
            } 
            break; 
        case SHL: 
            h = Zevints(); 
            k = Zevints(); 
            if ((k >> 5) != 0)  { 
                *val = 0; 
            } 
            else { 
                *val = h << k; 
            } 
            break; 
        case TST: 
            *val = *(*IPC.p + 1);  /* size of table         */ 
            *(*IPC.p + 6) = 1;     /* reset sequence number */ 
            ++IPC.n; 
            break; 
        case TDX: 
            *val = Ztdxfunc(); 
            break; 
        case FIX: 
            Zevreals(&x); 
            *val = x; 
            break; 
        case LENS: 
            Zidsubstr(&s, val, &h, &i); 
            break; 
        case INT: 
            Zidsubstr(&s, &g, &h, &subval); 

            ss = s; 
            gg = 0; 
            h = 1; 
            for (i = 0; i < g && *s == ' '; ++i) ++s; /* skip blanks */ 
            g -= i; 
            if (*s == '-' && g > 0) { 
                h = -1; 
                --g; 
                ++s; 
            } 
            for (k = 0, i = 0; i < g && *s >= '0' && *s <= '9'; ++i) { 
                gg = 1; 
                k *= 10; 
                k += *s - '0'; 
                ++s; 
            } 
            if (gg == 1)  {                /* valid integer */ 
                subval += (s - ss); 
            } 
            *(elk.n + SUB) = subval;      /* set "sub" variable */ 
            *val = k * h; 
            break; 
        case ORS: 
            Zidsubstr(&s, &g, &h, &i); 
            for (k = 0, i = 0; i < g && i < 4; ++i)  { 
                k <<= 8; 
                k += *s & 0xff; 
                ++s; 
            } 
            *val = k; 
            break; 
        case LENB: 
            Zidsubbitstr(&bsw, &g, &h, &i); 
            *val = (h + 7) >> 3; 
            break; 
        case BLN: 
            Zidsubbitstr(&bsw, &g, val, &i); 
            break; 
    } 
} 

/*** FUNCTION   void Zevfreal(*val, *xop); 

    Purpose:   evaluate function with real number output 

    Input:    (element  IPC) union pointer to real function in i-code 

    Return:    void 

    Output:   (element  IPC) updated union pointer into i-code 
               double  *val  real value of function 
               long    *xop  next operator (or zero) 
                                                            ***/ 
void Zevfreal(double *val, long *xop) 
{ 
    extern element IPC; 
    extern element elk;  /* run-time union pointer to link memory */ 

    static unsigned int seed; 
    static long         init = 0; 
    long                g, h, i, k, func, subval, dotflag; 
    long               *pt; 
    double              x, y; 
    char                buff[100]; 
    char               *s, *ss; 
    long                sw; 

/* determine function number and next operator   */ 

    k = *IPC.n++; 
    *xop = k >> 16; 
    func = k & 0xffff; 
    pt = IPC.n; 

/* process function  */ 

    sw = 1; 
    switch (func)  { 
        case 0:      /* no function */ 
            Zevreal(val, &h); 
            break; 
        case FLTI: 
            h = Zevints(); 
            *val = h; 
            break; 
        case RNDR: 
            if (init == 0)  { 
                init = 1; 
                srand( (unsigned) time( NULL ) ); 
                seed = rand(); 
            } 
            Zevreals(&x); 
            if (x == 0.0)  { 
                seed += rand(); 
                srand(seed); 
                *val = 0.0; 
                break; 
            } 
            y = 32767.0 / x; 
            x = (double) rand() / y; 
            seed = x; 
            *val = x; 
            break; 
        case ABSR: 
            Zevreals(&x); 
            if (x < 0.0)  *val = -x; 
            else          *val = x; 
            break; 
        case DEC: 
            Zevreals(&x); 
            if (x >= 0.0) *val = floor(x); 
            else          *val = ceil(x); 
            break; 
        case COS: 
            ++sw; 
        case SIN: 
            Zevreals(&x); 
            if (x > 10000000000.0 || x < -10000000000.0) {
                funcwarn(sw, x, pt); 
                *val = 0.0; 
                break; 
            } 
/* 
            if (sw == 1)  *val = sin(x); 
            else          *val = cos(x); 
*/ 

            if (sw == 1)  *val = my_sincostan(1, x); 
            else          *val = my_sincostan(2, x); 

            break; 
        case TAN: 
            Zevreals(&x); 
            if (x > 6000000000.0 || x < -6000000000.0) {
                funcwarn(3L, x, pt); 
                *val = 0.0; 
                break; 
            } 
/*
            *val = tan(x); 
*/ 
            *val = my_sincostan(3, x); 

            break; 
        case ARC: 
            ++sw; 
        case ARS: 
            Zevreals(&x); 
            if (x > 1.0 || x < -1.0) { 
                funcwarn(sw+3, x, pt); 
                *val = 0.0; 
                break; 
            } 

            if (sw == 1)  *val = my_arcsincos(1,x); 
            else          *val = my_arcsincos(2,x); 
/* 
            if (sw == 1)  *val = asin(x); 
            else          *val = acos(x); 
*/ 
            break; 
        case ART: 
            Zevreals(&x); 
            *val = my_arctan(x); 
            break; 
        case EXX: 
            Zevreals(&x); 
            if (x > 709.0) { 
                funcwarn(6L, x, pt); 
                *val = 1.0e153; 
                break; 
            } 
            *val = my_exp(x); 
            break; 
        case LNX: 
            Zevreals(&x); 
            if (x <= 0.0) { 
                funcwarn(7L, x, pt); 
                *val = 0.0; 
            } 
            else { 
                *val = my_log(x); 
            } 
            break; 
        case SQR: 
            Zevreals(&x); 
            if (x < 0.0) { 
                funcwarn(8L, x, pt); 
                *val = 0.0; 
                break; 
            } 
            *val = my_sqrt(x); 
            break; 
        case POW: 
            Zevreals(&x); 
            Zevreals(&y); 
            if (x < 0.0)   { 
                *val = 0.0; 
                break; 
            } 

            *val = my_pow(x,y); 
            break; 
        case FLTS: 
            Zidsubstr(&s, &g, &h, &subval); 
            *(elk.n + SUB) = subval;           /* set default "sub" variable */
            *val = 0.0;                        /* set defalut *val           */

        /* Basically, in order to introduce the modification of "sub" by 
           this function, this code has been rewritten &dA5-19-93&d@        */ 

        /* (1) determine if string contains valid real number   
                 and also the starting point (s) for that number */ 

            ss = s; 
            for (i = 0; i < g && *ss == ' '; ++i) ++ss;  /* skip blanks */ 
            switch (*ss)  { 
                case '+': 
                    ++i;                               /* skip unitary + */ 
                                /* break missing; tricky code */ 
                case '-': 
                    ++ss; 
                    if (*ss == '.')  ++ss; 
                    break; 
                case '.': 
                    ++ss; 
                    break; 
            } 
            if ((ss - s) >= g)  break;          /* no valid format */ 

            if (*ss >= '0' && *ss <= '9')  {    /* valid format */ 
                subval += i; 
                s += i; 
                g -= i; 
            } 
            else    break; 

        /*  (2) determine string size of "real number" */ 

            if (g > 99)  g = 99; 
            ss = s; 

          /* skip sign */ 

            if (*ss == '-')  ++ss; 

          /* skip leading decimal point */ 

            dotflag = 0; 
            if (*ss == '.')  { 
                ++ss; 
                dotflag = 1; 
            } 

          /* skip integer part of number */ 

            for (i = (ss - s); i < g && *ss >= '0' && *ss <= '9'; ++i)  ++ss; 
            if ((i == g) || ((*ss == '.') && (dotflag == 1))) { 
                subval += i; 
                goto EVALREAL; 
            } 

          /* skip decimal point */ 

            if (*ss == '.')  { 
                ++ss; 
                ++i; 
            } 
            if (i == g) {
                subval += i; 
                goto EVALREAL; 
            } 

          /* skip fractional part of number */ 

            while ((i < g) && (*ss >= '0') && (*ss <= '9'))  { 
                ++i; 
                ++ss; 
            } 

          /* look for exponential part */ 

            if (i > (g - 2) || (*ss != 'e') || 
                    (((*(ss+1) < '0') || (*(ss+1) > '9')) && 
                    (*(ss+1) != '+') && (*(ss+1) != '-'))       )  { 
                subval += i; 
                goto EVALREAL; 
            } 

          /* look for unitary sign in exponential part */ 

            if (((*(ss+1) == '+') || (*(ss+1) == '-')))  { 
                if ((i > (g - 3)) || (*(ss+2) < '0') || (*(ss+2) > '9')) { 
                    subval += i; 
                    goto EVALREAL; 
                } 
                ++i; 
                ++ss; 
            } 

          /* look for number part of exponential part */ 

            i += 2; 
            ss += 2; 
            while (i < g && (*ss >= '0') && (*ss <= '9'))  { 
                ++i; 
                ++ss; 
            } 
            subval += i; 
EVALREAL: 
            memcpy((void *) buff, (const void *) s, (size_t) i); 
            buff[i] = '\0'; 
            *val = atof(buff); 
            *(elk.n + SUB) = subval;           /* set "sub" variable */ 
            break; 
    } 
} 

int matherr(x) 
struct exception *x; 
{ return (1); } 

/*** FUNCTION   long *Zidint(); 

    Purpose:   identify integer variable (simple or array) 

    Input:    (element  IPC)   union pointer to int variable in i-code 

    Return:    long    *ipt    location of integer 
                                 in links or main memory 

    Output:   (element  IPC)   updated union pointer into i-code 



    Error conditions:    subscript error 
                                                                   ***/ 

long *Zidint() 
{ 
    extern element IPC; 
    extern element elk;  /* run-time union pointer to link mem */ 

    element pt; 
    element var_pnt; 
    long    h, off; 
    long   *ipt; 

    pt.n = IPC.n++; 
    var_pnt.n = *pt.p;               /* tricky code */ 
    h = var_pnt.n - elk.n; 

    if ((h & 1) == 0)  ipt = var_pnt.n;      /* simple variable */ 
    else  { 
        off = Zcompute_offset(&var_pnt, pt); 
                             /* var_pnt is advanced by this function */ 
        ipt = *var_pnt.p + off; 
    } 
    return (ipt); 
} 

/*** FUNCTION   void Zidreal(*(*rpt)); 

    Purpose:   identify real variable (simple or array) 

    Input:    (element  IPC)   union pointer to int variable in i-code 

    Return:    void 

    Output:   (element  IPC)   updated union pointer into i-code 
               long    *(*rpt) pointer to location of real   
                                 in links or main memory 

    Error conditions:    subscript error 
                                                                   ***/ 

void Zidreal(double *(*rpt)) 
{ 
    extern element IPC; 
    extern element elk;  /* run-time union pointer to link mem */ 

    element pt; 
    element var_pnt; 
    long    h, off; 

    pt.n = IPC.n; 
    var_pnt.n = *IPC.p++;               /* tricky code */ 
    h = var_pnt.n - elk.n; 

    if ((h & 1) == 0)  *rpt = (double *) var_pnt.n;  /* simple variable */ 
    else  { 
        off = Zcompute_offset(&var_pnt, pt); 
                             /* var_pnt is advanced by this function */ 
        off <<= 1; 
        *rpt = (double *) (*var_pnt.p + off); 
    } 
} 

/*** FUNCTION   long Zgenintex(); 

    Purpose:   evaluate integer expression (lits, vars, funcs) 

    Input:    (element  IPC) union pointer to expression in i-code 

    Return:    long    *val  integer value of expression 

    Output:   (element  IPC) updated union pointer into i-code 

    Special variables:  REM modified by divide 

    Error conditions:   divide by zero 
                                                                 ***/ 

long Zgenintex() 
{ 
    long  k, opp; 
    long  val; 

    Zevfint(&k, &opp); 
    if (opp == 0)  val = k; 
    else           val = Zintex(k, opp); 
    return (val); 
} 

/*** FUNCTION   void Zgenfltex(*val); 

    Purpose:   evaluate real expression (lits, vars, funcs) 

    Input:     none

    Return:    void 

    Output:    double  *val  value of expression 
                    
    Error conditions:   divide by zero 
                                                                 ***/ 

void Zgenfltex(double *val) 
{ 
    long   opp; 
    double x; 

    Zevfreal(&x, &opp); 
    if (opp == 0)          *val = x; 
    else  { 
        Zfltex(val, x, opp); 
    } 
} 

/*** FUNCTION   long Zintex(start, fopp); 

    Purpose:   evaluate int expression (lits, vars, funcs) given a 
                 starting value  (use genintex for general integer 
                 expressions) 

    Input:    (element  IPC)    union pointer to expression in i-code 
               long     start   starting value 
               long     fopp    first operator 

    Return:    long     k       integer value of expression 

    Output:   (element  IPC)    updated union pointer into i-code 


    Error conditions:   divide by zero 
                                                                  ***/ 
long Zintex(long start, long fopp) 
{ 
    extern element IPC; 

    long    *p; 
    long     g, h, k; 

    p = IPC.n; 
    k = start; 
    while (fopp > 0)  { 
        if (fopp < 9)  {        /* next value is a constant */ 
            g = *IPC.n++; 
            h = *IPC.n++;       /* next operator */ 
        } 
        else { 
            if (fopp < 17)  {   /* next value is a variable */ 
                fopp -= 8; 
                Zevint(&g, &h); 
            } 
            else {              /* next value is a function */ 
                fopp -= 16; 
                Zevfint(&g, &h); 
            } 
        } 
        k = int_op(k, g, fopp, p); 
        fopp = h; 
    } 
    return (k); 
} 

/*** FUNCTION   void Zfltex(*val, start, fopp); 

    Purpose:   evaluate real expression (lits, vars, funcs) given a 
                 starting value  (use genfltex for general real   
                 expressions) 

    Input:    (element  IPC)    union pointer to expression in i-code 
               double   start   starting value 
               long     fopp    first operator 

    Return:    void 

    Output:   (element  IPC)    updated union pointer into i-code 
               double  *val     value of expression 

    Error conditions:   divide by zero 
                                                                  ***/ 
void Zfltex(double *val, double start, long fopp) 
{ 
    extern element IPC; 

    long    *p; 
    long     h; 
    double  *x; 
    double   y, z; 

    y = start; 
    p = IPC.n; 
    while (fopp > 0)  { 
        if (fopp < 9)  {        /* next value is a constant */ 
            x = (double *) IPC.n; 
            z = *x; 
            IPC.n += 2; 
            h = *IPC.n++;         /* next operator */ 
        } 
        else { 
            if (fopp < 17)  {   /* next value is a variable */ 
                fopp -= 8; 
                Zevreal(&z, &h); 
            } 
            else {              /* next value is a function */ 
                fopp -= 16; 
                Zevfreal(&z, &h); 
            } 
        } 
        real_op(&y, z, fopp, p); 
        fopp = h; 
    } 
    *val = y; 
} 

/*** FUNCTION   long ZevA_int(); 

    Purpose:   evaluate array integer variable (this differs from evint 
                 in that evint integers come in <pointer,opcode> pairs) 

    Input:    (element  IPC) union pointer to integer in i-code 

    Return:    long          integer value of variable 

    Output:   (element  IPC) updated union pointer into i-code 


    Error conditions:  subscript error 
                                                                  ***/ 
long ZevA_int() 
{ 
    extern element IPC; 

    element pt; 
    element var_pnt; 
    long    k, off; 

    pt.n = IPC.n; 
    var_pnt.n = *IPC.p++;       /* pointer to variable (tricky code) */ 

    off = Zcompute_offset(&var_pnt, pt); 
    k = *(*var_pnt.p+off);  /* value of array element */ 
    return (k); 
} 

/*** FUNCTION   void ZevA_real(*val); 

    Purpose:   evaluate array real variable (this differs from evreal 
                 in that evreal reals come in <pointer,opcode> pairs) 

    Input:    (element  IPC) union pointer to real var in i-code 

    Return:    void 

    Output:   (element  IPC) updated union pointer into i-code 
               double  *val  real value variable 

    Error conditions:  subscript error 
                                                                  ***/ 
void ZevA_real(double *val) 
{ 
    extern element IPC; 

    element pt; 
    element var_pnt; 
    double *x; 
    long    off; 

    pt.n = IPC.n; 
    var_pnt.n = *IPC.p++;       /* pointer to variable (tricky code) */ 

    off = Zcompute_offset(&var_pnt, pt); 
    off <<= 1; 
    x = (double *) (*var_pnt.p+off); 
    *val = *x;                 /* value of array element */ 
} 

/*** FUNCTION   double my_arcsincos(long flag, double x); 

    Purpose:   compute the value of arcsin(x) or arccos(x) 

    Input:     double x:  -1.0 <= x 1.0 
               long flag:  1 = arcsin;  2 = arccos; 

    Return:    If -1.0 <= x <= 1.0, return arcsin(x) or arccos(x) 
               Otherwise, return (0.0) 

                                                                  ***/ 

double my_arcsincos(long flag, double x) 
{ 
    static char first_arc[10000] = { 
0,0,0,0,0,0,0,0,22,203,193,0,78,98,80,63,156,62,50,138,78,98,96,63,200,207,228,
38,119,147,104,63,228,255,244,175,80,98,112,63,68,20,90,223,230,122,116,63,30,
116,91,102,126,147,120,63,60,185,179,137,23,172,124,63,82,56,15,71,89,98,128,
63,145,33,44,220,167,110,130,63,240,142,143,166,247,122,132,63,117,45,153,200,
72,135,134,63,235,116,169,100,155,147,136,63,34,188,33,157,239,159,138,63,70,
77,100,148,69,172,140,63,38,122,212,108,157,184,142,63,67,88,107,164,123,98,144,
63,59,71,104,165,169,104,145,63,78,123,148,202,216,110,146,63,73,18,36,37,9,117,
147,63,157,224,75,198,58,123,148,63,142,123,65,191,109,129,149,63,95,67,59,33,
162,135,150,63,130,109,112,253,215,141,151,63,205,14,25,101,15,148,152,63,168,
37,110,105,72,154,153,63,65,164,169,27,131,160,154,63,199,122,6,141,191,166,155,
63,154,161,192,206,253,172,156,63,138,35,21,242,61,179,157,63,12,40,66,8,128,
185,158,63,126,253,134,34,196,191,159,63,174,17,18,41,5,99,160,63,69,170,45,84,
41,230,160,63,199,200,55,155,78,105,161,63,109,149,210,6,117,236,161,63,137,229,
160,159,156,111,162,63,169,64,70,110,197,242,162,63,189,229,102,123,239,117,163,
63,64,208,167,207,26,249,163,63,93,189,174,115,71,124,164,63,26,49,34,112,117,
255,164,63,128,123,169,205,164,130,165,63,203,189,236,148,213,5,166,63,148,239,
148,206,7,137,166,63,1,228,75,131,59,12,167,63,244,78,188,187,112,143,167,63,
61,202,145,128,167,18,168,63,204,218,120,218,223,149,168,63,231,245,30,210,25,
25,169,63,94,134,50,112,85,156,169,63,198,241,98,189,146,31,170,63,172,157,96,
194,209,162,170,63,216,244,220,135,18,38,171,63,129,108,138,22,85,169,171,63,
147,137,28,119,153,44,172,63,234,229,71,178,223,175,172,63,147,53,194,208,39,
51,173,63,21,76,66,219,113,182,173,63,177,33,128,218,189,57,174,63,174,216,52,
215,11,189,174,63,157,194,26,218,91,64,175,63,171,101,237,235,173,195,175,63,
243,192,180,10,129,35,176,63,74,139,166,47,44,101,176,63,192,179,43,105,216,166,
176,63,41,129,164,187,133,232,176,63,237,225,113,43,52,42,177,63,188,110,245,
188,227,107,177,63,51,109,145,116,148,173,177,63,143,210,168,86,70,239,177,63,
94,70,159,103,249,48,178,63,39,37,217,171,173,114,178,63,38,131,187,39,99,180,
178,63,248,46,172,223,25,246,178,63,80,180,17,216,209,55,179,63,176,94,83,21,
139,121,179,63,28,60,217,155,69,187,179,63,209,31,12,112,1,253,179,63,2,165,85,
150,190,62,180,63,144,49,32,19,125,128,180,63,198,248,214,234,60,194,180,63,20,
254,229,33,254,3,181,63,211,23,186,188,192,69,181,63,0,242,192,191,132,135,181,
63,254,16,105,47,74,201,181,63,90,212,33,16,17,11,182,63,144,121,91,102,217,76,
182,63,204,30,135,54,163,142,182,63,184,197,22,133,110,208,182,63,61,86,125,86,
59,18,183,63,84,161,46,175,9,84,183,63,205,99,159,147,217,149,183,63,29,73,69,
8,171,215,183,63,47,238,150,17,126,25,184,63,50,228,11,180,82,91,184,63,108,179,
28,244,40,157,184,63,14,222,66,214,0,223,184,63,7,227,248,94,218,32,185,63,222,
64,186,146,181,98,185,63,137,120,3,118,146,164,185,63,72,16,82,13,113,230,185,
63,128,150,36,93,81,40,186,63,155,164,250,105,51,106,186,63,228,225,84,56,23,
172,186,63,109,6,181,204,252,237,186,63,240,221,157,43,228,47,187,63,178,74,147,
89,205,113,187,63,110,72,26,91,184,179,187,63,60,239,184,52,165,245,187,63,123,
118,246,234,147,55,188,63,190,55,91,130,132,121,188,63,188,177,112,255,118,187,
188,63,65,139,193,102,107,253,188,63,27,150,217,188,97,63,189,63,24,210,69,6,
90,129,189,63,244,111,148,71,84,195,189,63,87,212,84,133,80,5,190,63,205,154,
23,196,78,71,190,63,196,152,110,8,79,137,190,63,140,224,236,86,81,203,190,63,
86,196,38,180,85,13,191,63,56,217,177,36,92,79,191,63,51,250,36,173,100,145,191,
63,60,75,24,82,111,211,191,63,33,158,18,12,190,10,192,63,32,70,243,129,197,43,
192,63,34,38,252,12,206,76,192,63,67,241,123,175,215,109,192,63,190,6,194,107,
226,142,192,63,114,115,30,68,238,175,192,63,119,243,225,58,251,208,192,63,164,
243,93,82,9,242,192,63,31,147,228,140,24,19,193,63,237,164,200,236,40,52,193,
63,133,177,93,116,58,85,193,63,94,248,247,37,77,118,193,63,132,113,236,3,97,151,
193,63,46,207,144,16,118,184,193,63,83,127,59,78,140,217,193,63,62,173,67,191,
163,250,193,63,43,67,1,102,188,27,194,63,223,235,204,68,214,60,194,63,67,20,0,
94,241,93,194,63,255,236,244,179,13,127,194,63,26,108,6,73,43,160,194,63,153,
78,144,31,74,193,194,63,30,26,239,57,106,226,194,63,138,30,128,154,139,3,195,
63,164,119,161,67,174,36,195,63,183,14,178,55,210,69,195,63,63,156,17,121,247,
102,195,63,140,169,32,10,30,136,195,63,111,146,64,237,69,169,195,63,223,134,211,
36,111,202,195,63,171,140,60,179,153,235,195,63,38,129,223,154,197,12,196,63,
209,26,33,222,242,45,196,63,20,235,102,127,33,79,196,63,234,95,23,129,81,112,
196,63,150,197,153,229,130,145,196,63,91,72,86,175,181,178,196,63,46,246,181,
224,233,211,196,63,115,192,34,124,31,245,196,63,182,125,7,132,86,22,197,63,99,
235,207,250,142,55,197,63,138,175,232,226,200,88,197,63,152,90,191,62,4,122,197,
63,27,105,194,16,65,155,197,63,131,69,97,91,127,188,197,63,230,73,12,33,191,221,
197,63,199,193,52,100,0,255,197,63,221,235,76,39,67,32,198,63,219,251,199,108,
135,65,198,63,60,28,26,55,205,98,198,63,17,112,184,136,20,132,198,63,205,20,25,
100,93,165,198,63,24,36,179,203,167,198,198,63,158,181,254,193,243,231,198,63,
231,224,116,73,65,9,199,63,42,191,143,100,144,42,199,63,38,109,202,21,225,75,
199,63,250,12,161,95,51,109,199,63,2,200,144,68,135,142,199,63,183,208,23,199,
220,175,199,63,136,100,181,233,51,209,199,63,194,205,233,174,140,242,199,63,109,
101,54,25,231,19,200,63,57,149,29,43,67,53,200,63,93,217,34,231,160,86,200,63,
135,194,202,79,0,120,200,63,194,247,154,103,97,153,200,63,104,56,26,49,196,186,
200,63,15,94,208,174,40,220,200,63,123,94,70,227,142,253,200,63,145,77,6,209,
246,30,201,63,79,95,155,122,96,64,201,63,193,233,145,226,203,97,201,63,252,102,
119,11,57,131,201,63,29,119,218,247,167,164,201,63,66,226,74,170,24,198,201,63,
145,154,89,37,139,231,201,63,53,190,152,107,255,8,202,63,104,153,155,127,117,
42,202,63,118,168,246,99,237,75,202,63,202,153,63,27,103,109,202,63,249,79,13,
168,226,142,202,63,208,227,247,12,96,176,202,63,101,166,152,76,223,209,202,63,
41,35,138,105,96,243,202,63,255,33,104,102,227,20,203,63,82,169,207,69,104,54,
203,63,50,0,95,10,239,87,203,63,109,176,181,182,119,121,203,63,177,136,116,77,
2,155,203,63,172,158,61,209,142,188,203,63,49,81,180,68,29,222,203,63,94,74,125,
170,173,255,203,63,198,129,62,5,64,33,204,63,155,62,159,87,212,66,204,63,224,
25,72,164,106,100,204,63,147,0,227,237,2,134,204,63,234,53,27,55,157,167,204,
63,128,85,157,130,57,201,204,63,148,85,23,211,215,234,204,63,66,137,56,43,120,
12,205,63,194,162,177,141,26,46,205,63,168,181,52,253,190,79,205,63,41,57,117,
124,101,113,205,63,99,10,40,14,14,147,205,63,160,110,3,181,184,180,205,63,171,
21,191,115,101,214,205,63,24,28,20,77,20,248,205,63,153,13,189,67,197,25,206,
63,82,231,117,90,120,59,206,63,51,26,252,147,45,93,206,63,77,141,14,243,228,126,
206,63,55,160,109,122,158,160,206,63,104,45,219,44,90,194,206,63,158,140,26,13,
24,228,206,63,71,149,240,29,216,5,207,63,227,160,35,98,154,39,207,63,121,141,
123,220,94,73,207,63,2,192,193,143,37,107,207,63,224,38,193,126,238,140,207,63,
80,60,70,172,185,174,207,63,229,8,31,27,135,208,207,63,5,38,27,206,86,242,207,
63,53,224,5,100,20,10,208,63,83,205,225,133,254,26,208,63,208,135,11,206,233,
43,208,63,152,10,238,61,214,60,208,63,76,31,245,214,195,77,208,63,146,95,141,
154,178,94,208,63,90,54,36,138,162,111,208,63,45,225,39,167,147,128,208,63,119,
113,7,243,133,145,208,63,220,205,50,111,121,162,208,63,129,179,26,29,110,179,
208,63,100,183,48,254,99,196,208,63,177,71,231,19,91,213,208,63,21,173,177,95,
83,230,208,63,22,12,4,227,76,247,208,63,115,102,83,159,71,8,209,63,118,156,21,
150,67,25,209,63,90,110,193,200,64,42,209,63,167,125,206,56,63,59,209,63,149,
78,181,231,62,76,209,63,106,73,239,214,63,93,209,63,233,187,246,7,66,110,209,
63,174,218,70,124,69,127,209,63,161,194,91,53,74,144,209,63,90,122,178,52,80,
161,209,63,147,243,200,123,87,178,209,63,146,12,30,12,96,195,209,63,159,145,49,
231,105,212,209,63,118,62,132,14,117,229,209,63,185,191,151,131,129,246,209,63,
108,180,238,71,143,7,210,63,104,175,12,93,158,24,210,63,224,56,118,196,174,41,
210,63,213,207,176,127,192,58,210,63,153,235,66,144,211,75,210,63,86,253,179,
247,231,92,210,63,137,113,140,183,253,109,210,63,142,177,85,209,20,127,210,63,
42,37,154,70,45,144,210,63,14,52,229,24,71,161,210,63,110,71,195,73,98,178,210,
63,135,203,193,218,126,195,210,63,55,49,111,205,156,212,210,63,141,239,90,35,
188,229,210,63,96,133,21,222,220,246,210,63,233,122,48,255,254,7,211,63,91,99,
62,136,34,25,211,63,132,222,210,122,71,42,211,63,103,154,130,216,109,59,211,63,
228,84,227,162,149,76,211,63,88,221,139,219,190,93,211,63,71,22,20,132,233,110,
211,63,3,247,20,158,21,128,211,63,88,141,40,43,67,145,211,63,60,255,233,44,114,
162,211,63,128,140,245,164,162,179,211,63,129,144,232,148,212,196,211,63,224,
131,97,254,7,214,211,63,58,254,255,226,60,231,211,63,229,183,100,68,115,248,211,
63,170,139,49,36,171,9,212,63,139,120,9,132,228,26,212,63,129,163,144,101,31,
44,212,63,70,89,108,202,91,61,212,63,28,16,67,180,153,78,212,63,153,105,188,36,
217,95,212,63,116,52,129,29,26,113,212,63,88,110,59,160,92,130,212,63,183,69,
150,174,160,147,212,63,163,27,62,74,230,164,212,63,162,133,224,116,45,182,212,
63,145,79,44,48,118,199,212,63,129,125,209,125,192,216,212,63,151,77,129,95,12,
234,212,63,247,57,238,214,89,251,212,63,167,250,203,229,168,12,213,63,126,135,
207,141,249,29,213,63,16,26,175,208,75,47,213,63,162,47,34,176,159,64,213,63,
30,139,225,45,245,81,213,63,11,55,167,75,76,99,213,63,134,135,46,11,165,116,213,
63,66,28,52,110,255,133,213,63,140,226,117,118,91,151,213,63,75,23,179,37,185,
168,213,63,9,73,172,125,24,186,213,63,1,90,35,128,121,203,213,63,43,130,219,46,
220,220,213,63,80,81,153,139,64,238,213,63,28,177,34,152,166,255,213,63,59,231,
62,86,14,17,214,63,113,151,182,199,119,34,214,63,189,197,83,238,226,51,214,63,
122,216,225,203,79,69,214,63,135,154,45,98,190,86,214,63,113,61,5,179,46,104,
214,63,160,91,56,192,160,121,214,63,137,250,151,139,20,139,214,63,227,140,246,
22,138,156,214,63,224,244,39,100,1,174,214,63,107,134,1,117,122,191,214,63,100,
9,90,75,245,208,214,63,233,187,9,233,113,226,214,63,155,84,234,79,240,243,214,
63,235,4,215,129,112,5,215,63,103,123,172,128,242,22,215,63,17,230,72,78,118,
40,215,63,183,244,139,236,251,57,215,63,73,219,86,93,131,75,215,63,63,84,140,
162,12,93,215,63,247,162,16,190,151,110,215,63,34,150,201,177,36,128,215,63,42,
138,158,127,179,145,215,63,169,107,120,41,68,163,215,63,213,185,65,177,214,180,
215,63,255,136,230,24,107,198,215,63,13,133,84,98,1,216,215,63,251,243,122,143,
153,233,215,63,97,184,74,162,51,251,215,63,250,83,182,156,207,12,216,63,56,234,
177,128,109,30,216,63,209,66,51,80,13,48,216,63,88,204,49,13,175,65,216,63,219,
158,166,185,82,83,216,63,128,126,140,87,248,100,216,63,42,222,223,232,159,118,
216,63,39,226,158,111,73,136,216,63,216,98,201,237,244,153,216,63,106,239,96,
101,162,171,216,63,136,208,104,216,81,189,216,63,31,11,230,72,3,207,216,63,23,
99,223,184,182,224,216,63,35,94,93,42,108,242,216,63,130,70,106,159,35,4,217,
63,220,45,18,26,221,21,217,63,10,240,98,156,152,39,217,63,253,53,108,40,86,57,
217,63,149,120,63,192,21,75,217,63,141,3,240,101,215,92,217,63,95,248,146,27,
155,110,217,63,56,81,63,227,96,128,217,63,236,227,13,191,40,146,217,63,241,100,
25,177,242,163,217,63,93,106,126,187,190,181,217,63,237,110,91,224,140,199,217,
63,15,213,208,33,93,217,217,63,245,233,0,130,47,235,217,63,168,232,15,3,4,253,
217,63,37,253,35,167,218,14,218,63,128,71,101,112,179,32,218,63,10,223,253,96,
142,50,218,63,127,213,25,123,107,68,218,63,57,58,231,192,74,86,218,63,107,29,
150,52,44,104,218,63,93,147,88,216,15,122,218,63,181,183,98,174,245,139,218,63,
192,176,234,184,221,157,218,63,195,178,40,250,199,175,218,63,89,3,87,116,180,
193,218,63,200,252,177,41,163,211,218,63,111,17,120,28,148,229,218,63,44,207,
233,78,135,247,218,63,204,226,73,195,124,9,219,63,138,27,221,123,116,27,219,63,
136,110,234,122,110,45,219,63,86,250,186,194,106,63,219,63,127,10,154,85,105,
81,219,63,30,27,213,53,106,99,219,63,116,220,187,101,109,117,219,63,139,54,160,
231,114,135,219,63,223,76,214,189,122,153,219,63,12,130,180,234,132,171,219,63,
134,123,147,112,145,189,219,63,81,37,206,81,160,207,219,63,206,181,193,144,177,
225,219,63,128,177,205,47,197,243,219,63,227,238,83,49,219,5,220,63,72,154,184,
151,243,23,220,63,181,57,98,101,14,42,220,63,206,176,185,156,43,60,220,63,207,
68,42,64,75,78,220,63,123,160,33,82,109,96,220,63,37,216,15,213,145,114,220,63,
184,109,103,203,184,132,220,63,200,84,157,55,226,150,220,63,171,246,40,28,14,
169,220,63,158,54,132,123,60,187,220,63,234,117,43,88,109,205,220,63,30,152,157,
180,160,223,220,63,67,7,92,147,214,241,220,63,35,184,234,246,14,4,221,63,149,
46,208,225,73,22,221,63,208,129,149,86,135,40,221,63,205,96,198,87,199,58,221,
63,167,22,241,231,9,77,221,63,16,143,166,9,79,95,221,63,199,90,122,191,150,113,
221,63,25,180,2,12,225,131,221,63,109,131,216,241,45,150,221,63,216,99,151,115,
125,168,221,63,187,167,221,147,207,186,221,63,103,93,76,85,36,205,221,63,211,
83,135,186,123,223,221,63,81,31,53,198,213,241,221,63,85,30,255,122,50,4,222,
63,64,126,145,219,145,22,222,63,63,64,155,234,243,40,222,63,35,62,206,170,88,
59,222,63,86,47,223,30,192,77,222,63,205,173,133,73,42,96,222,63,9,59,124,45,
151,114,222,63,36,69,128,205,6,133,222,63,232,43,82,44,121,151,222,63,236,69,
181,76,238,169,222,63,194,229,111,49,102,188,222,63,47,95,75,221,224,206,222,
63,108,12,20,83,94,225,222,63,110,83,153,149,222,243,222,63,70,171,173,167,97,
6,223,63,126,161,38,140,231,24,223,63,141,223,220,69,112,43,223,63,77,48,172,
215,251,61,223,63,134,133,115,68,138,80,223,63,124,253,20,143,27,99,223,63,145,
232,117,186,175,117,223,63,238,206,126,201,70,136,223,63,58,118,27,191,224,154,
223,63,91,231,58,158,125,173,223,63,75,116,207,105,29,192,223,63,240,189,206,
36,192,210,223,63,4,186,49,210,101,229,223,63,18,185,244,116,14,248,223,63,56,
182,11,8,93,5,224,63,44,118,78,83,180,14,224,63,255,222,197,29,13,24,224,63,226,
236,246,104,103,33,224,63,181,88,104,54,195,42,224,63,44,155,162,135,32,52,224,
63,253,239,47,94,127,61,224,63,9,89,156,187,223,70,224,63,157,161,117,161,65,
80,224,63,174,97,75,17,165,89,224,63,30,1,175,12,10,99,224,63,15,187,51,149,112,
108,224,63,51,161,110,172,216,117,224,63,46,159,246,83,66,127,224,63,250,125,
100,141,173,136,224,63,81,231,82,90,26,146,224,63,35,105,94,188,136,155,224,63,
19,121,37,181,248,164,224,63,250,119,72,70,106,174,224,63,113,181,105,113,221,
183,224,63,105,115,45,56,82,193,224,63,199,233,57,156,200,202,224,63,4,74,55,
159,64,212,224,63,225,194,207,66,186,221,224,63,21,132,175,136,53,231,224,63,
18,194,132,114,178,240,224,63,199,185,255,1,49,250,224,63,115,180,210,56,177,
3,225,63,122,11,178,24,51,13,225,63,72,44,84,163,182,22,225,63,61,156,113,218,
59,32,225,63,157,252,196,191,194,41,225,63,144,14,11,85,75,51,225,63,40,183,2,
156,213,60,225,63,108,3,109,150,97,70,225,63,122,44,13,70,239,79,225,63,161,155,
168,172,126,89,225,63,147,238,6,204,15,99,225,63,156,251,241,165,162,108,225,
63,222,213,53,60,55,118,225,63,162,209,160,144,205,127,225,63,170,136,3,165,101,
137,225,63,141,222,48,123,255,146,225,63,42,5,254,20,155,156,225,63,21,129,66,
116,56,166,225,63,24,46,216,154,215,175,225,63,192,67,155,138,120,185,225,63,
239,89,106,69,27,195,225,63,126,109,38,205,191,204,225,63,234,228,178,35,102,
214,225,63,7,149,245,74,14,224,225,63,201,197,214,68,184,233,225,63,10,55,65,
19,100,243,225,63,108,37,34,184,17,253,225,63,57,79,105,53,193,6,226,63,90,249,
8,141,114,16,226,63,82,244,245,192,37,26,226,63,71,161,39,211,218,35,226,63,32,
247,151,197,145,45,226,63,161,135,67,154,74,55,226,63,162,132,41,83,5,65,226,
63,72,197,75,242,193,74,226,63,82,203,174,121,128,84,226,63,114,200,89,235,64,
94,226,63,174,163,86,73,3,104,226,63,219,254,177,149,199,113,226,63,22,60,123,
210,141,123,226,63,86,131,196,1,86,133,226,63,11,200,162,37,32,143,226,63,198,
206,45,64,236,152,226,63,244,50,128,83,186,162,226,63,166,108,183,97,138,172,
226,63,105,214,243,108,92,182,226,63,43,179,88,119,48,192,226,63,50,52,12,131,
6,202,226,63,32,127,55,146,222,211,226,63,3,180,6,167,184,221,226,63,131,243,
168,195,148,231,226,63,11,101,80,234,114,241,226,63,20,61,50,29,83,251,226,63,
120,195,134,94,53,5,227,63,214,89,137,176,25,15,227,63,9,130,120,21,0,25,227,
63,173,228,149,143,232,34,227,63,186,87,38,33,211,44,227,63,43,229,113,204,191,
54,227,63,186,209,195,147,174,64,227,63,172,163,106,121,159,74,227,63,178,41,
184,127,146,84,227,63,215,129,1,169,135,94,227,63,137,32,159,247,126,104,227,
63,170,215,236,109,120,114,227,63,188,221,73,14,116,124,227,63,33,213,24,219,
113,134,227,63,103,211,191,214,113,144,227,63,173,104,168,3,116,154,227,63,30,
167,63,100,120,164,227,63,125,42,246,250,126,174,227,63,193,31,64,202,135,184,
227,63,212,76,149,212,146,194,227,63,86,24,113,28,160,204,227,63,131,145,82,164,
175,214,227,63,36,120,188,110,193,224,227,63,161,68,53,126,213,234,227,63,32,
48,71,213,235,244,227,63,188,60,128,118,4,255,227,63,217,61,114,100,31,9,228,
63,137,224,178,161,60,19,228,63,9,180,219,48,92,29,228,63,89,50,138,20,126,39,
228,63,233,200,95,79,162,49,228,63,96,225,1,228,200,59,228,63,123,234,25,213,
241,69,228,63,6,97,85,37,29,80,228,63,237,216,101,215,74,90,228,63,105,6,1,238,
122,100,228,63,66,199,224,107,173,110,228,63,51,44,195,83,226,120,228,63,101,
130,106,168,25,131,228,63,1,93,157,108,83,141,228,63,230,158,38,163,143,151,228,
63,115,132,213,78,206,161,228,63,117,173,125,114,15,172,228,63,42,39,247,16,83,
182,228,63,102,118,30,45,153,192,228,63,215,161,212,201,225,202,228,63,94,60,
255,233,44,213,228,63,148,111,136,144,122,223,228,63,98,6,95,192,202,233,228,
63,188,119,118,124,29,244,228,63,127,241,198,199,114,254,228,63,108,99,77,165,
202,8,229,63,65,138,11,24,37,19,229,63,252,250,7,35,130,29,229,63,49,46,78,201,
225,39,229,63,148,139,238,13,68,50,229,63,147,117,254,243,168,60,229,63,34,85,
152,126,16,71,229,63,164,165,219,176,122,81,229,63,245,0,237,141,231,91,229,63,
156,43,246,24,87,102,229,63,40,33,38,85,201,112,229,63,163,32,177,69,62,123,229,
63,61,185,208,237,181,133,229,63,17,215,195,80,48,144,229,63,20,208,206,113,173,
154,229,63,51,113,59,84,45,165,229,63,140,11,89,251,175,175,229,63,224,129,124,
106,53,186,229,63,31,86,0,165,189,196,229,63,42,183,68,174,72,207,229,63,184,
142,175,137,214,217,229,63,109,143,172,58,103,228,229,63,27,67,173,196,250,238,
229,63,39,25,41,43,145,249,229,63,47,117,157,113,42,4,230,63,199,189,141,155,
198,14,230,63,121,107,131,172,101,25,230,63,232,23,14,168,7,36,230,63,38,141,
195,145,172,46,230,63,64,213,63,109,84,57,230,63,245,73,37,62,255,67,230,63,164,
164,28,8,173,78,230,63,109,14,213,206,93,89,230,63,129,48,4,150,17,100,230,63,
177,68,102,97,200,110,230,63,41,38,190,52,130,121,230,63,100,98,213,19,63,132,
230,63,94,74,124,2,255,142,230,63,245,3,138,4,194,153,230,63,137,155,220,29,136,
164,230,63,212,21,89,82,81,175,230,63,254,129,235,165,29,186,230,63,236,11,135,
28,237,196,230,63,207,14,38,186,191,207,230,63,233,39,202,130,149,218,230,63,
155,73,124,122,110,229,230,63,174,206,76,165,74,240,230,63,216,141,83,7,42,251,
230,63,143,237,175,164,12,6,231,63,18,248,136,129,242,16,231,63,193,111,13,162,
219,27,231,63,177,227,115,10,200,38,231,63,142,196,250,190,183,49,231,63,191,
121,232,195,170,60,231,63,213,118,139,29,161,71,231,63,72,81,58,208,154,82,231,
63,115,214,83,224,151,93,231,63,235,33,63,82,152,104,231,63,26,180,107,42,156,
115,231,63,44,137,81,109,163,126,231,63,74,48,113,31,174,137,231,63,44,227,83,
69,188,148,231,63,249,157,139,227,205,159,231,63,123,55,179,254,226,170,231,63,
173,121,110,155,251,181,231,63,154,58,106,190,23,193,231,63,157,117,92,108,55,
204,231,63,243,100,4,170,90,215,231,63,174,155,42,124,129,226,231,63,3,32,161,
231,171,237,231,63,249,133,67,241,217,248,231,63,114,10,247,157,11,4,232,63,163,
174,170,242,64,15,232,63,227,83,87,244,121,26,232,63,230,215,255,167,182,37,232,
63,97,49,177,18,247,48,232,63,15,141,130,57,59,60,232,63,47,107,149,33,131,71,
232,63,97,189,21,208,206,82,232,63,248,4,58,74,30,94,232,63,194,113,67,149,113,
105,232,63,56,1,126,182,200,116,232,63,45,158,64,179,35,128,232,63,238,64,237,
144,130,139,232,63,222,15,241,84,229,150,232,63,140,128,196,4,76,162,232,63,74,
121,235,165,182,173,232,63,61,115,245,61,37,185,232,63,251,156,125,210,151,196,
232,63,156,253,42,105,14,208,232,63,105,152,176,7,137,219,232,63,253,144,205,
179,7,231,232,63,5,80,77,115,138,242,232,63,134,168,7,76,17,254,232,63,179,253,
224,67,156,9,233,63,92,105,202,96,43,21,233,63,243,226,193,168,190,32,233,63,
37,103,210,33,86,44,233,63,28,32,20,210,241,55,233,63,83,142,172,191,145,67,233,
63,18,178,206,240,53,79,233,63,152,53,187,107,222,90,233,63,221,151,192,54,139,
102,233,63,19,88,59,88,60,114,233,63,196,33,150,214,241,125,233,63,180,249,73,
184,171,137,233,63,109,107,222,3,106,149,233,63,142,183,233,191,44,161,233,63,
204,2,17,243,243,172,233,63,196,133,8,164,191,184,233,63,132,189,147,217,143,
196,233,63,226,156,133,154,100,208,233,63,168,190,192,237,61,220,233,63,129,152,
55,218,27,232,233,63,199,174,236,102,254,243,233,63,44,201,242,154,229,255,233,
63,54,40,109,125,209,11,234,63,167,187,143,21,194,23,234,63,200,89,159,106,183,
35,234,63,164,247,241,131,177,47,234,63,40,226,238,104,176,59,234,63,75,248,14,
33,180,71,234,63,28,230,220,179,188,83,234,63,224,96,245,40,202,95,234,63,45,
100,7,136,220,107,234,63,14,112,212,216,243,119,234,63,62,200,48,35,16,132,234,
63,113,180,3,111,49,144,234,63,192,193,71,196,87,156,234,63,45,5,11,43,131,168,
234,63,87,95,111,171,179,180,234,63,89,193,170,77,233,192,234,63,221,114,7,26,
36,205,234,63,106,89,228,24,100,217,234,63,241,64,181,82,169,229,234,63,170,37,
3,208,243,241,234,63,59,127,108,153,67,254,234,63,52,141,165,183,152,10,235,63,
243,164,120,51,243,22,235,63,228,128,198,21,83,35,235,63,51,145,134,103,184,47,
235,63,249,77,199,49,35,60,235,63,227,138,174,125,147,72,235,63,93,204,121,84,
9,85,235,63,84,158,126,191,132,97,235,63,142,236,42,200,5,110,235,63,163,92,5,
120,140,122,235,63,163,169,173,216,24,135,235,63,115,1,221,243,170,147,235,63,
227,99,102,211,66,160,235,63,152,3,55,129,224,172,235,63,192,168,86,7,132,185,
235,63,174,21,232,111,45,198,235,63,89,109,41,197,220,210,235,63,213,155,116,
17,146,223,235,63,203,192,63,95,77,236,235,63,3,156,29,185,14,249,235,63,1,252,
189,41,214,5,236,63,207,46,238,187,163,18,236,63,250,116,153,122,119,31,236,63,
204,118,201,112,81,44,236,63,216,187,166,169,49,57,236,63,234,36,121,48,24,70,
236,63,87,104,168,16,5,83,236,63,211,144,188,85,248,95,236,63,205,126,94,11,242,
108,236,63,100,108,88,61,242,121,236,63,18,116,150,247,248,134,236,63,6,26,39,
70,6,148,236,63,84,216,59,53,26,161,236,63,7,174,41,209,52,174,236,63,28,177,
105,38,86,187,236,63,140,163,153,65,126,200,236,63,109,139,124,47,173,213,236,
63,61,78,251,252,226,226,236,63,115,79,37,183,31,240,236,63,101,18,49,107,99,
253,236,63,161,223,124,38,174,10,237,63,196,109,143,246,255,23,237,63,244,141,
24,233,88,37,237,63,8,220,241,11,185,50,237,63,135,114,31,109,32,64,237,63,129,
162,208,26,143,77,237,63,120,175,96,35,5,91,237,63,95,143,87,149,130,104,237,
63,211,174,106,127,7,118,237,63,173,185,125,240,147,131,237,63,8,104,163,247,
39,145,237,63,223,79,30,164,195,158,237,63,88,187,97,5,103,172,237,63,239,131,
18,43,18,186,237,63,143,242,7,37,197,199,237,63,204,164,76,3,128,213,237,63,94,
119,31,214,66,227,237,63,0,118,244,173,13,241,237,63,218,208,117,155,224,254,
237,63,162,215,132,175,187,12,238,63,161,250,58,251,158,26,238,63,182,209,234,
143,138,40,238,63,158,41,33,127,126,54,238,63,153,23,166,218,122,68,238,63,163,
19,126,180,127,82,238,63,118,25,235,30,141,96,238,63,134,208,109,44,163,110,238,
63,40,187,198,239,193,124,238,63,35,109,247,123,233,138,238,63,215,201,67,228,
25,153,238,63,65,74,51,60,83,167,238,63,26,75,146,151,149,181,238,63,60,99,115,
10,225,195,238,63,170,194,48,169,53,210,238,63,108,154,109,136,147,224,238,63,
137,141,23,189,250,238,238,63,103,43,104,92,107,253,238,63,235,115,230,123,229,
11,239,63,137,101,104,49,105,26,239,63,181,149,20,147,246,40,239,63,244,211,99,
183,141,55,239,63,237,215,34,181,46,70,239,63,215,250,115,163,217,84,239,63,151,
252,208,153,142,99,239,63,255,212,12,176,77,114,239,63,138,145,85,254,22,129,
239,63,251,63,54,157,234,143,239,63,90,230,152,165,200,158,239,63,181,136,200,
48,177,173,239,63,37,61,115,88,164,188,239,63,131,78,172,54,162,203,239,63,102,
110,238,229,170,218,239,63,213,246,29,129,190,233,239,63,75,60,139,35,221,248,
239,63,74,120,122,116,3,4,240,63,143,75,197,246,157,11,240,63,173,133,247,38,
62,19,240,63,229,140,157,19,228,26,240,63,58,22,128,203,143,34,240,63,176,133,
165,93,65,42,240,63,237,88,83,217,248,49,240,63,161,156,15,78,182,57,240,63,20,
109,162,203,121,65,240,63,73,130,23,98,67,73,240,63,30,200,191,33,19,81,240,63,
222,2,51,27,233,88,240,63,192,128,81,95,197,96,240,63,195,216,69,255,167,104,
240,63,128,183,134,12,145,112,240,63,95,186,216,152,128,120,240,63,215,89,80,
182,118,128,240,63,61,227,83,119,115,136,240,63,193,130,157,238,118,144,240,63,
68,94,61,47,129,152,240,63,174,193,155,76,146,160,240,63,109,93,123,90,170,168,
240,63,232,151,251,108,201,176,240,63,166,242,154,152,239,184,240,63,233,131,
57,242,28,193,240,63,176,133,27,143,81,201,240,63,227,250,235,132,141,209,240,
63,181,107,191,233,208,217,240,63,28,186,22,212,27,226,240,63,119,15,226,90,110,
234,240,63,106,228,131,149,200,242,240,63,27,36,212,155,42,251,240,63,244,107,
35,134,148,3,241,63,56,105,62,109,6,12,241,63,172,85,113,106,128,20,241,63,200,
148,139,151,2,29,241,63,209,114,227,14,141,37,241,63,123,7,90,235,31,46,241,63,
152,61,95,72,187,54,241,63,160,1,246,65,95,63,241,63,212,152,184,244,11,72,241,
63,216,34,221,125,193,80,241,63,223,71,58,251,127,89,241,63,102,21,76,139,71,
98,241,63,217,11,57,77,24,107,241,63,106,95,215,96,242,115,241,63,166,110,178,
230,213,124,241,63,99,113,16,0,195,133,241,63,223,98,248,206,185,142,241,63,6,
42,56,118,186,151,241,63,245,2,107,25,197,160,241,63,39,45,0,221,217,169,241,
63,198,225,65,230,248,178,241,63,225,149,92,91,34,188,241,63,145,140,102,99,86,
197,241,63,57,189,103,38,149,206,241,63,111,18,98,205,222,215,241,63,84,6,90,
130,51,225,241,63,121,161,95,112,147,234,241,63,188,225,151,195,254,243,241,63,
235,142,70,169,117,253,241,63,95,131,216,79,248,6,242,63,32,111,238,230,134,16,
242,63,159,28,104,159,33,26,242,63,150,62,112,171,200,35,242,63,15,207,136,62,
124,45,242,63,46,8,152,141,60,55,242,63,7,0,246,206,9,65,242,63,80,241,122,58,
228,74,242,63,152,59,142,9,204,84,242,63,83,38,54,119,193,94,242,63,5,115,40,
192,196,104,242,63,167,203,219,34,214,114,242,63,101,27,154,223,245,124,242,63,
241,224,147,56,36,135,242,63,211,138,244,113,97,145,242,63,94,239,247,209,173,
155,242,63,113,243,0,161,9,166,242,63,145,116,177,41,117,176,242,63,195,140,3,
185,240,186,242,63,61,72,100,158,124,197,242,63,39,231,207,43,25,208,242,63,202,
199,239,181,198,218,242,63,10,24,58,148,133,229,242,63,160,111,19,33,86,240,242,
63,168,119,242,185,56,251,242,63,31,199,133,191,45,6,243,63,192,31,220,149,53,
17,243,63,126,58,143,164,80,28,243,63,99,87,241,86,127,39,243,63,103,201,61,28,
194,50,243,63,92,188,204,103,25,62,243,63,248,120,74,177,133,73,243,63,217,113,
242,116,7,85,243,63,232,107,206,51,159,96,243,63,198,28,250,115,77,108,243,63,
126,163,235,192,18,120,243,63,45,74,193,171,239,131,243,63,27,11,149,203,228,
143,243,63,78,97,214,189,242,155,243,63,96,251,170,38,26,168,243,63,162,248,86,
177,91,180,243,63,176,107,173,16,184,192,243,63,117,243,137,255,47,205,243,63,
121,84,84,65,196,217,243,63,161,24,143,162,117,230,243,63,200,91,114,249,68,243,
243,63,171,16,148,38,51,0,244,63,21,52,159,21,65,13,244,63,25,149,27,190,111,
26,244,63,147,17,72,36,192,39,244,63,99,103,9,90,51,53,244,63,173,6,240,127,202,
66,244,63,119,169,87,198,134,80,244,63,12,220,163,110,105,94,244,63,34,26,157,
204,115,108,244,63,126,178,242,71,167,122,244,63,64,74,230,93,5,137,244,63,237,
158,38,163,143,151,244,63,247,17,224,197,71,166,244,63,123,161,10,144,47,181,
244,63,30,67,254,233,72,196,244,63,151,43,88,221,149,211,244,63,190,120,61,152,
24,227,244,63,234,8,10,113,211,242,244,63,139,36,125,234,200,2,245,63,48,32,121,
184,251,18,245,63,146,114,111,197,110,35,245,63,214,30,152,56,37,52,245,63,221,
19,26,125,34,69,245,63,245,165,82,74,106,86,245,63,153,26,117,173,0,104,245,63,
81,26,201,20,234,121,245,63,245,195,224,92,43,140,245,63,26,115,54,224,201,158,
245,63,175,3,193,137,203,177,245,63,165,58,54,235,54,197,245,63,250,247,233,87,
19,217,245,63,7,190,131,5,105,237,245,63,104,175,189,154,120,239,245,63,72,154,
83,128,137,241,245,63,246,239,212,184,155,243,245,63,47,119,217,70,175,245,245,
63,72,114,1,45,196,247,245,63,56,198,245,109,218,249,245,63,140,34,104,12,242,
251,245,63,68,42,19,11,11,254,245,63,173,157,186,108,37,0,246,63,51,133,43,52,
65,2,246,63,54,93,60,100,94,4,246,63,241,66,205,255,124,6,246,63,111,34,200,9,
157,8,246,63,155,229,32,133,190,10,246,63,119,164,213,116,225,12,246,63,128,214,
238,219,5,15,246,63,68,133,127,189,43,17,246,63,60,128,165,28,83,19,246,63,232,
145,137,252,123,21,246,63,68,182,95,96,166,23,246,63,154,82,103,75,210,25,246,
63,179,110,235,192,255,27,246,63,134,239,66,196,46,30,246,63,96,211,208,88,95,
32,246,63,148,111,4,130,145,34,246,63,201,175,89,67,197,36,246,63,229,86,89,160,
250,38,246,63,170,65,153,156,49,41,246,63,23,171,188,59,106,43,246,63,145,114,
116,129,164,45,246,63,233,99,127,113,224,47,246,63,79,129,170,15,30,50,246,63,
67,79,209,95,93,52,246,63,142,34,222,101,158,54,246,63,91,112,202,37,225,56,246,
63,131,32,159,163,37,59,246,63,24,226,116,227,107,61,246,63,70,130,116,233,179,
63,246,63,167,69,215,185,253,65,246,63,12,68,231,88,73,68,246,63,225,198,255,
202,150,70,246,63,66,170,141,20,230,72,246,63,209,192,15,58,55,75,246,63,101,
58,23,64,138,77,246,63,188,13,72,43,223,79,246,63,55,101,89,0,54,82,246,63,200,
14,22,196,142,84,246,63,42,239,92,123,233,86,246,63,140,120,33,43,70,89,246,63,
183,36,108,216,164,91,246,63,241,242,90,136,5,94,246,63,166,233,33,64,104,96,
246,63,4,156,11,5,205,98,246,63,178,179,121,220,51,101,246,63,201,126,229,203,
156,103,246,63,52,130,224,216,7,106,246,63,166,16,21,9,117,108,246,63,86,230,
70,98,228,110,246,63,165,201,83,234,85,113,246,63,241,48,52,167,201,115,246,63,
183,237,251,158,63,118,246,63,70,221,218,215,183,120,246,63,55,159,29,88,50,123,
246,63,232,81,46,38,175,125,246,63,49,85,149,72,46,128,246,63,164,19,250,197,
175,130,246,63,136,210,35,165,51,133,246,63,230,136,250,236,185,135,246,63,241,
189,135,164,66,138,246,63,20,111,247,210,205,140,246,63,243,253,152,127,91,143,
246,63,208,38,224,177,235,145,246,63,136,255,101,113,126,148,246,63,178,255,233,
197,19,151,246,63,35,18,83,183,171,153,246,63,91,176,176,77,70,156,246,63,55,
8,60,145,227,158,246,63,113,44,89,138,131,161,246,63,91,80,152,65,38,164,246,
63,98,15,183,191,203,166,246,63,222,192,161,13,116,169,246,63,197,216,116,52,
31,172,246,63,217,85,126,61,205,174,246,63,239,61,63,50,126,177,246,63,9,41,109,
28,50,180,246,63,228,219,243,5,233,182,246,63,207,242,246,248,162,185,246,63,
128,157,211,255,95,188,246,63,213,108,34,37,32,191,246,63,82,51,185,115,227,193,
246,63,81,249,172,246,169,196,246,63,240,5,84,185,115,199,246,63,178,253,71,199,
64,202,246,63,16,24,104,44,17,205,246,63,15,109,219,244,228,207,246,63,53,92,
19,45,188,210,246,63,38,14,206,225,150,213,246,63,92,18,25,32,117,216,246,63,
126,26,84,245,86,219,246,63,250,212,51,111,60,222,246,63,142,232,196,155,37,225,
246,63,162,18,111,137,18,228,246,63,102,106,248,70,3,231,246,63,197,202,136,227,
247,233,246,63,109,101,173,110,240,236,246,63,80,129,92,248,236,239,246,63,43,
103,249,144,237,242,246,63,195,126,88,73,242,245,246,63,216,159,195,50,251,248,
246,63,216,153,254,94,8,252,246,63,200,245,75,224,25,255,246,63,227,245,113,201,
47,2,247,63,228,214,191,45,74,5,247,63,22,87,19,33,105,8,247,63,174,135,222,183,
140,11,247,63,58,237,45,7,181,14,247,63,92,244,174,36,226,17,247,63,100,192,182,
38,20,21,247,63,227,89,73,36,75,24,247,63,179,67,33,53,135,27,247,63,134,125,
183,113,200,30,247,63,176,251,75,243,14,34,247,63,104,156,238,211,90,37,247,63,
138,163,136,46,172,40,247,63,140,198,230,30,3,44,247,63,98,211,195,193,95,47,
247,63,191,253,211,52,194,50,247,63,88,223,208,150,42,54,247,63,230,56,134,7,
153,57,247,63,214,130,223,167,13,61,247,63,18,94,246,153,136,64,247,63,210,246,
33,1,10,68,247,63,21,109,7,2,146,71,247,63,86,88,171,194,32,75,247,63,55,126,
132,106,182,78,247,63,37,214,143,34,83,82,247,63,196,246,101,21,247,85,247,63,
206,12,82,111,162,89,247,63,118,126,106,94,85,93,247,63,31,98,171,18,16,97,247,
63,109,243,18,190,210,100,247,63,118,54,192,148,157,104,247,63,72,254,19,205,
112,108,247,63,254,145,212,159,76,112,247,63,145,50,84,72,49,116,247,63,123,203,
154,4,31,120,247,63,17,33,147,21,22,124,247,63,224,217,59,191,22,128,247,63,244,
203,220,72,33,132,247,63,103,4,65,253,53,136,247,63,20,15,246,42,85,140,247,63,
27,22,145,36,127,144,247,63,157,133,250,64,180,148,247,63,249,247,192,219,244,
152,247,63,204,74,116,85,65,157,247,63,139,221,9,20,154,161,247,63,173,32,75,
131,255,165,247,63,81,201,79,21,114,170,247,63,34,50,5,67,242,174,247,63,16,177,
196,140,128,179,247,63,209,243,250,122,29,184,247,63,57,206,226,158,201,188,247,
63,6,80,86,147,133,193,247,63,62,120,185,253,81,198,247,63,141,119,2,143,47,203,
247,63,18,48,228,4,31,208,247,63,17,136,32,43,33,213,247,63,217,64,9,221,54,218,
247,63,69,98,55,7,97,223,247,63,22,0,131,169,160,228,247,63,80,65,71,217,246,
233,247,63,177,67,1,196,100,239,247,63,229,225,91,178,235,244,247,63,193,197,
190,11,141,250,247,63,216,217,124,90,74,0,248,63,3,144,197,80,37,6,248,63,125,
42,134,206,31,12,248,63,233,34,117,232,59,18,248,63,6,48,147,240,123,24,248,63,
11,29,133,128,226,30,248,63,25,93,74,134,114,37,248,63,64,27,2,84,47,44,248,63,
182,201,177,179,28,51,248,63,38,197,94,0,63,58,248,63,91,100,88,70,155,65,248,
63,113,233,98,109,55,73,248,63,221,146,186,112,26,81,248,63,69,13,238,170,76,
89,248,63,119,116,229,62,216,97,248,63,47,247,24,173,201,106,248,63,78,222,15,
174,48,116,248,63,35,205,17,126,33,126,248,63,45,171,53,235,182,136,248,63,11,
243,74,198,21,148,248,63,146,29,19,16,115,160,248,63,173,2,233,33,32,174,248,
63,42,121,233,236,165,189,248,63,237,236,169,117,15,208,248,63,167,82,1,26,14,
232,248,63,24,45,68,84,251,33,249,63 
}; 
    double y,z; 
    double a,b,c,d; 
    double u,v; 
    double delta; 
    double m,n; 
    double *arc_pnt; 

    long sign; 
    long i,j; 

    arc_pnt = (double *) first_arc; 

    sign = 0; 

    if (x < 0.0)  { 
        x = 0.0 - x; 
        sign = 1; 
    } 
    if (x > 1.0)  return (0.0); 
    if (flag == 1)  { 
        if (x == 0.0)       return (0.0); 
        if (x == 1.0)  { 
            if (sign == 0)  return (1.5707963267948966); 
            else            return (-1.5707963267948966); 
        } 
    } 
    else { 
        if (x == 0.0)       return (1.5707963267948966); 
        if (x == 1.0)  { 
            if (sign == 0)  return (0.0); 
            else            return (3.1415926535897932); 
        }                       
    } 

/* 
&dA &d@   Step 1:  Determine initial interval 
*/ 
    if (x < .979999999999999)  { 
        a = 0.1; 
        j = 100; 
        for (i = 0; i < 10; ++i)  { 
            if (x < a) goto ARS1; 
            a += 0.1; 
            j += 100; 
        } 
ARS1: 
        b = a - 0.1; 
        a = b + 0.01; 
        j -= 90; 
        for (i = 0; i < 10; ++i)  { 
            if (x < a) goto ARS2; 
            a += 0.01; 
            j += 10; 
        } 
ARS2: 
        b = a - 0.01; 
        a = b + 0.001; 
        j -= 9; 
        for (i = 0; i < 10; ++i)  { 
            if (x < a) goto ARS3; 
            a += 0.001; 
            ++j; 
        } 
ARS3: 
        y = a; 
        z = y - 0.001; 
        --j; 
        if (z > 0.0005)  { 
            --j; 
            z -= 0.001; 

            delta = 0.002; 
            a = *(arc_pnt+j); 
            b = *(arc_pnt+j+2); 
        } 
        else { 
            delta = 0.001; 
            a = *(arc_pnt+j); 
            b = *(arc_pnt+j+1); 
        } 

        m = (x - z) * b; 
        n = (y - x) * a; 
        c = (m + n) / delta; 
        d = my_sincostan(1,c); 
    } 
    else  { 
        a = 0.981; 
        j = 10; 
        for (i = 0; i < 20; ++i)  { 
            if (x < a) goto ARS4; 
            a += 0.001; 
            j += 10; 
        } 
ARS4: 
        b = a - 0.001; 
        a = b + 0.0001; 
        j -= 10; 
        for (i = 0; i < 10; ++i)  { 
            if (x < a) goto ARS5; 
            a += 0.0001; 
            ++j; 
        } 
ARS5: 
        y = a; 
        z = y - 0.0001; 
        j += 980; 
        if (j == 980)  { 
            z -= .001; 
            delta = 0.0011; 
            a = *(arc_pnt+j-1); 
            b = *(arc_pnt+j+1); 
        } 
        else { 
            z -= 0.0001; 
            delta = 0.0002; 
            a = *(arc_pnt+j-1); 
            b = *(arc_pnt+j+1); 
        } 

        m = (x - z) * b; 
        n = (y - x) * a; 
        c = (m + n) / delta; 
        d = my_sincostan(1,c); 
    } 

    y = d; 

    a = (2.0 * c + a) / 3.0; 
    z = my_sincostan(1,a); 

    u = x - z; 
    v = y - x; 
    delta = u + v; 

    b = c; 
    m = u * b; 
    n = v * a; 
    c = (m + n) / delta; 

    d = my_sincostan(1,c); 

    if (x < .0001) { 
        goto ARCRET; 
    } 

    y = d; 
    a = (2.0 * c + a) / 3.0; 
    z = my_sincostan(1,a); 

    u = x - z; 
    v = y - x; 
    delta = u + v; 

    b = c; 
    m = u * b; 
    n = v * a; 
    c = (m + n) / delta; 

    d = my_sincostan(1,c); 

    if (x < .1600) { 
        goto ARCRET; 
    } 

    y = d; 

    a = (2.0 * c + a) / 3.0; 
    z = my_sincostan(1,a); 

    u = x - z; 
    v = y - x; 
    delta = u + v; 

    b = c; 
    m = u * b; 
    n = v * a; 
    c = (m + n) / delta; 

    d = my_sincostan(1,c); 

    if (x < .9200) { 
        goto ARCRET; 
    } 

    y = d; 

    a = (2.0 * c + a) / 3.0; 
    z = my_sincostan(1,a); 

    u = x - z; 
    v = y - x; 
    delta = u + v; 

    b = c; 
    m = u * b; 
    n = v * a; 
    c = (m + n) / delta; 

    d = my_sincostan(1,c); 

    if (x < .9990) { 
        goto ARCRET; 
    } 

    y = d; 

    a = (2.0 * c + a) / 3.0; 
    z = my_sincostan(1,a); 

    u = x - z; 
    v = y - x; 
    delta = u + v; 

    b = c; 
    m = u * b; 
    n = v * a; 
    c = (m + n) / delta; 

    d = my_sincostan(1,c); 

    if (x < .9999) { 
        goto ARCRET; 
    } 

    y = d; 

    a = (2.0 * c + a) / 3.0; 
    z = my_sincostan(1,a); 

    u = x - z; 
    v = y - x; 
    delta = u + v; 

    b = c; 
    m = u * b; 
    n = v * a; 
    c = (m + n) / delta; 

    d = my_sincostan(1,c); 

    if (x < .999999) { 
        goto ARCRET; 
    } 

    y = d; 

    a = (2.0 * c + a) / 3.0; 
    z = my_sincostan(1,a); 

    u = x - z; 
    v = y - x; 
    delta = u + v; 

    b = c; 
    m = u * b; 
    n = v * a; 
    c = (m + n) / delta; 

    d = my_sincostan(1,c); 

    if (x < .9999999) { 
        goto ARCRET; 
    } 

    y = d; 

    a = (2.0 * c + a) / 3.0; 
    z = my_sincostan(1,a); 

    u = x - z; 
    v = y - x; 
    delta = u + v; 

    b = c; 
    m = u * b; 
    n = v * a; 
    c = (m + n) / delta; 

    d = my_sincostan(1,c); 

    if (x < .99999999) { 
        goto ARCRET; 
    } 

    y = d; 

    a = (2.0 * c + a) / 3.0; 
    z = my_sincostan(1,a); 

    u = x - z; 
    v = y - x; 
    delta = u + v; 

    b = c; 
    m = u * b; 
    n = v * a; 
    c = (m + n) / delta; 

    d = my_sincostan(1,c); 

    if (x < .999999999) { 
        goto ARCRET; 
    } 

    y = d; 

    a = (2.0 * c + a) / 3.0; 
    z = my_sincostan(1,a); 

    u = x - z; 
    v = y - x; 
    delta = u + v; 

    b = c; 
    m = u * b; 
    n = v * a; 
    c = (m + n) / delta; 

    d = my_sincostan(1,c); 

    if (x < .9999999999) { 
        goto ARCRET; 
    } 

    y = d; 

    a = (2.0 * c + a) / 3.0; 
    z = my_sincostan(1,a); 

    u = x - z; 
    v = y - x; 
    delta = u + v; 

    b = c; 
    m = u * b; 
    n = v * a; 
    c = (m + n) / delta; 

    d = my_sincostan(1,c); 

    if (x < .99999999999) { 
        goto ARCRET; 
    } 

    y = d; 

    a = (2.0 * c + a) / 3.0; 
    z = my_sincostan(1,a); 

    u = x - z; 
    v = y - x; 
    delta = u + v; 

    b = c; 
    m = u * b; 
    n = v * a; 
    c = (m + n) / delta; 

ARCRET: 
    if (sign == 1)  c = 0.0 - c; 
    if (flag == 2)  c = 1.5707963267948966 - c; 
    return (c); 
} 

/*** FUNCTION   double my_arctan(double x); 

    Purpose:   compute the value of arcsinx 

    Input:     double x:  all values        

    Return:    double arctan(x) 
                                                                  ***/ 

double my_arctan(double x) 
{ 
    static char first_arctan[10000] = { 
188,91,85,85,255,255,79,63,188,187,85,85,253,255,95,63,204,132,1,128,251,255,
103,63,183,187,91,85,245,255,111,63,74,25,95,149,245,255,115,63,166,76,24,0,238,
255,119,63,209,47,223,106,227,255,123,63,151,186,187,85,213,255,127,63,76,66,
92,160,225,255,129,63,156,146,241,85,214,255,131,63,194,73,166,139,200,255,133,
63,10,195,132,1,184,255,135,63,112,105,153,119,164,255,137,63,140,231,242,173,
141,255,139,63,116,87,162,100,115,255,141,63,155,114,187,91,85,255,143,63,215,
96,170,169,153,255,144,63,54,230,195,133,134,255,145,63,184,164,56,34,113,255,
146,63,0,167,24,95,89,255,147,63,231,190,117,28,63,255,148,63,92,157,99,58,34,
255,149,63,63,234,247,152,2,255,150,63,54,92,74,24,224,254,151,63,132,208,116,
152,186,254,152,63,214,98,147,249,145,254,153,63,15,133,196,27,102,254,154,63,
18,23,41,223,54,254,155,63,125,126,228,35,4,254,156,63,112,190,28,202,205,253,
157,63,62,143,250,177,147,253,158,63,37,118,169,187,85,253,159,63,126,238,171,
227,137,126,160,63,238,148,155,218,102,254,160,63,97,235,189,178,65,126,161,63,
151,196,46,92,26,254,161,63,223,148,11,199,240,125,162,63,221,125,115,227,196,
253,162,63,80,90,135,161,150,125,163,63,217,201,105,241,101,253,163,63,180,60,
63,195,50,125,164,63,121,255,45,7,253,252,164,63,209,70,94,173,196,124,165,63,
45,59,250,165,137,252,165,63,118,4,46,225,75,124,166,63,187,213,39,79,11,252,
166,63,219,248,23,224,199,123,167,63,42,218,48,132,129,251,167,63,20,20,167,43,
56,123,168,63,186,122,177,198,235,250,168,63,141,39,137,69,156,122,169,63,223,
132,105,152,73,250,169,63,124,89,144,175,243,121,170,63,47,212,61,123,154,249,
170,63,80,151,180,235,61,121,171,63,68,196,57,241,221,248,171,63,253,6,21,124,
122,120,172,63,119,161,144,124,19,248,172,63,44,119,249,226,168,119,173,63,130,
24,159,159,58,247,173,63,60,206,211,162,200,118,174,63,220,164,236,220,82,246,
174,63,9,120,65,62,217,117,175,63,234,253,44,183,91,245,175,63,61,105,6,28,109,
58,176,63,111,193,160,88,42,122,176,63,90,76,151,137,229,185,176,63,167,82,29,
167,158,249,176,63,130,166,103,169,85,57,177,63,49,169,172,136,10,121,177,63,
180,80,36,61,189,184,177,63,89,45,8,191,109,248,177,63,83,111,147,6,28,56,178,
63,77,236,2,12,200,119,178,63,249,36,149,199,113,183,178,63,154,74,138,49,25,
247,178,63,143,68,36,66,190,54,179,63,216,181,166,241,96,118,179,63,154,2,87,
56,1,182,179,63,157,85,124,14,159,245,179,63,201,165,95,108,58,53,180,63,157,
187,75,74,211,116,180,63,169,54,141,160,105,180,180,63,251,146,114,103,253,243,
180,63,147,46,76,151,142,51,181,63,203,78,108,40,29,115,181,63,190,37,39,19,169,
178,181,63,178,215,210,79,50,242,181,63,115,128,199,214,184,49,182,63,179,56,
95,160,60,113,182,63,100,27,246,164,189,176,182,63,13,75,234,220,59,240,182,63,
30,247,155,64,183,47,183,63,61,97,109,200,47,111,183,63,146,226,194,108,165,174,
183,63,15,241,2,38,24,238,183,63,176,36,150,236,135,45,184,63,191,60,231,184,
244,108,184,63,12,37,99,131,94,172,184,63,40,251,120,68,197,235,184,63,150,19,
154,244,40,43,185,63,251,254,57,140,137,106,185,63,75,143,206,3,231,169,185,63,
241,220,207,83,65,233,185,63,242,75,184,116,152,40,186,63,10,145,4,95,236,103,
186,63,205,182,51,11,61,167,186,63,184,34,199,113,138,230,186,63,73,154,66,139,
212,37,187,63,10,72,44,80,27,101,187,63,157,192,12,185,94,164,187,63,195,7,111,
190,158,227,187,63,94,149,224,88,219,34,188,63,106,90,241,128,20,98,188,63,252,
197,51,47,74,161,188,63,50,202,60,92,124,224,188,63,39,225,163,0,171,31,189,63,
220,17,3,21,214,94,189,63,31,245,246,145,253,157,189,63,110,186,30,112,33,221,
189,63,216,44,28,168,65,28,190,63,207,183,147,50,94,91,190,63,6,108,44,8,119,
154,190,63,59,4,144,33,140,217,190,63,2,234,106,119,157,24,191,63,144,58,108,
2,171,87,191,63,120,203,69,187,180,150,191,63,110,47,172,154,186,213,191,63,124,
93,171,76,94,10,192,63,147,196,255,87,221,41,192,63,34,192,177,107,90,73,192,
63,62,43,33,132,213,104,192,63,62,75,175,157,78,136,192,63,15,210,190,180,197,
167,192,63,126,224,179,197,58,199,192,63,130,8,244,204,173,230,192,63,135,79,
230,198,30,6,193,63,180,48,243,175,141,37,193,63,43,159,132,132,250,68,193,63,
80,8,6,65,101,100,193,63,1,86,228,225,205,131,193,63,211,240,141,99,52,163,193,
63,80,194,114,194,152,194,193,63,39,55,4,251,250,225,193,63,101,65,181,9,91,1,
194,63,163,90,250,234,184,32,194,63,54,134,73,155,20,64,194,63,92,83,26,23,110,
95,194,63,101,223,229,90,197,126,194,63,214,215,38,99,26,158,194,63,148,124,89,
44,109,189,194,63,255,161,251,178,189,220,194,63,22,179,140,243,11,252,194,63,
141,179,141,234,87,27,195,63,236,65,129,148,161,58,195,63,164,153,235,237,232,
89,195,63,30,149,82,243,45,121,195,63,213,175,61,161,112,152,195,63,91,8,54,244,
176,183,195,63,108,98,198,232,238,214,195,63,242,40,123,123,42,246,195,63,13,
112,226,168,99,21,196,63,22,247,139,109,154,52,196,63,158,42,9,198,206,83,196,
63,111,38,237,174,0,115,196,63,129,183,204,36,48,146,196,63,249,93,62,36,93,177,
196,63,23,79,218,169,135,208,196,63,47,119,58,178,175,239,196,63,146,123,250,
57,213,14,197,63,127,188,183,61,248,45,197,63,10,87,17,186,24,77,197,63,5,39,
168,171,54,108,197,63,225,200,30,15,82,139,197,63,146,155,25,225,106,170,197,
63,106,194,62,30,129,201,197,63,247,38,54,195,148,232,197,63,216,122,169,204,
165,7,198,63,150,57,68,55,180,38,198,63,116,170,179,255,191,69,198,63,61,226,
166,34,201,100,198,63,20,197,206,156,207,131,198,63,59,8,222,106,211,162,198,
63,217,51,137,137,212,193,198,63,192,164,134,245,210,224,198,63,44,142,142,171,
206,255,198,63,128,251,90,168,199,30,199,63,2,210,167,232,189,61,199,63,144,210,
50,105,177,92,199,63,90,155,187,38,162,123,199,63,140,169,3,30,144,154,199,63,
2,91,206,75,123,185,199,63,243,239,224,172,99,216,199,63,152,140,2,62,73,247,
199,63,208,58,252,251,43,22,200,63,200,235,152,227,11,53,200,63,147,121,165,241,
232,83,200,63,204,168,240,34,195,114,200,63,46,42,75,116,154,145,200,63,41,156,
135,226,110,176,200,63,116,140,122,106,64,207,200,63,162,121,250,8,15,238,200,
63,169,212,223,186,218,12,201,63,114,2,5,125,163,43,201,63,89,93,70,76,105,74,
201,63,184,54,130,37,44,105,201,63,99,216,152,5,236,135,201,63,38,134,108,233,
168,166,201,63,66,127,225,205,98,197,201,63,225,255,221,175,25,228,201,63,143,
66,74,140,205,2,202,63,166,129,16,96,126,33,202,63,191,248,28,40,44,64,202,63,
31,230,93,225,214,94,202,63,25,140,195,136,126,125,202,63,121,50,64,27,35,156,
202,63,227,39,200,149,196,186,202,63,47,195,81,245,98,217,202,63,203,100,213,
54,254,247,202,63,12,120,77,87,150,22,203,63,137,116,182,83,43,53,203,63,105,
223,14,41,189,83,203,63,181,76,87,212,75,114,203,63,162,96,146,82,215,144,203,
63,218,208,196,160,95,175,203,63,194,101,245,187,228,205,203,63,188,251,44,161,
102,236,203,63,103,132,118,77,229,10,204,63,217,7,223,189,96,41,204,63,220,165,
117,239,216,71,204,63,31,151,75,223,77,102,204,63,110,46,116,138,191,132,204,
63,220,217,4,238,45,163,204,63,245,35,21,7,153,193,204,63,227,180,190,210,0,224,
204,63,149,83,29,78,101,254,204,63,230,230,78,118,198,28,205,63,183,118,115,72,
36,59,205,63,16,45,173,193,126,89,205,63,54,87,32,223,213,119,205,63,200,102,
243,157,41,150,205,63,201,242,78,251,121,180,205,63,186,184,93,244,198,210,205,
63,158,157,76,134,16,241,205,63,11,175,74,174,86,15,206,63,46,36,137,105,153,
45,206,63,206,94,59,181,216,75,206,63,77,236,150,142,20,106,206,63,167,134,211,
242,76,136,206,63,107,21,43,223,129,166,206,63,175,174,217,80,179,196,206,63,
13,152,29,69,225,226,206,63,137,71,55,185,11,1,207,63,134,100,105,170,50,31,207,
63,175,200,248,21,86,61,207,63,221,128,44,249,117,91,207,63,255,205,77,81,146,
121,207,63,245,37,168,27,171,151,207,63,118,52,137,85,192,181,207,63,228,219,
64,252,209,211,207,63,42,54,33,13,224,241,207,63,198,74,191,66,245,7,208,63,191,
194,87,177,248,22,208,63,182,101,6,81,250,37,208,63,197,179,120,32,250,52,208,
63,206,74,93,30,248,67,208,63,224,230,99,73,244,82,208,63,145,98,61,160,238,97,
208,63,103,183,155,33,231,112,208,63,46,254,49,204,221,127,208,63,91,111,180,
158,210,142,208,63,98,99,216,151,197,157,208,63,19,83,84,182,182,172,208,63,239,
215,223,248,165,187,208,63,130,172,51,94,147,202,208,63,179,172,9,229,126,217,
208,63,30,214,28,140,104,232,208,63,95,72,41,82,80,247,208,63,103,69,236,53,54,
6,209,63,202,49,36,54,26,21,209,63,9,149,144,81,252,35,209,63,227,25,242,134,
220,50,209,63,156,142,10,213,186,65,209,63,71,229,156,58,151,80,209,63,11,52,
109,182,113,95,209,63,108,181,64,71,74,110,209,63,142,200,221,235,32,125,209,
63,120,241,11,163,245,139,209,63,84,217,147,107,200,154,209,63,175,78,63,68,153,
169,209,63,186,69,217,43,104,184,209,63,132,216,45,33,53,199,209,63,54,71,10,
35,0,214,209,63,77,248,60,48,201,228,209,63,211,120,149,71,144,243,209,63,150,
124,228,103,85,2,210,63,91,222,251,143,24,17,210,63,21,160,174,190,217,31,210,
63,22,235,208,242,152,46,210,63,66,16,56,43,86,61,210,63,58,136,186,102,17,76,
210,63,143,243,47,164,202,90,210,63,237,26,113,226,129,105,210,63,70,239,87,32,
55,120,210,63,250,137,191,92,234,134,210,63,4,45,132,150,155,149,210,63,29,67,
131,204,74,164,210,63,226,95,155,253,247,178,210,63,249,63,172,40,163,193,210,
63,53,201,150,76,76,208,210,63,179,10,61,104,243,222,210,63,254,60,130,122,152,
237,210,63,44,194,74,130,59,252,210,63,249,37,124,126,220,10,211,63,230,29,253,
109,123,25,211,63,82,137,181,79,24,40,211,63,143,113,142,34,179,54,211,63,0,10,
114,229,75,69,211,63,43,176,75,151,226,83,211,63,204,235,7,55,119,98,211,63,236,
110,148,195,9,113,211,63,243,21,224,59,154,127,211,63,178,231,218,158,40,142,
211,63,124,21,118,235,180,156,211,63,42,251,163,32,63,171,211,63,46,31,88,61,
199,185,211,63,157,50,135,64,77,200,211,63,52,17,39,41,209,214,211,63,103,193,
46,246,82,229,211,63,100,116,150,166,210,243,211,63,23,134,87,57,80,2,212,63,
51,125,108,173,203,16,212,63,49,11,209,1,69,31,212,63,86,12,130,53,188,45,212,
63,172,135,125,71,49,60,212,63,10,175,194,54,164,74,212,63,8,223,81,2,21,89,212,
63,5,159,44,169,131,103,212,63,27,161,85,42,240,117,212,63,27,194,208,132,90,
132,212,63,135,9,163,183,194,146,212,63,135,169,210,193,40,161,212,63,224,254,
102,162,140,175,212,63,231,144,104,88,238,189,212,63,118,17,225,226,77,204,212,
63,224,92,219,64,171,218,212,63,220,121,99,113,6,233,212,63,121,153,134,115,95,
247,212,63,12,23,83,70,182,5,213,63,27,120,216,232,10,20,213,63,76,108,39,90,
93,34,213,63,74,205,81,153,173,48,213,63,180,158,106,165,251,62,213,63,3,14,134,
125,71,77,213,63,111,114,185,32,145,91,213,63,216,76,27,142,216,105,213,63,166,
71,195,196,29,120,213,63,178,54,202,195,96,134,213,63,34,23,74,138,161,148,213,
63,78,15,94,23,224,162,213,63,157,110,34,106,28,177,213,63,101,173,180,129,86,
191,213,63,200,108,51,93,142,205,213,63,141,118,190,251,195,219,213,63,2,189,
118,92,247,233,213,63,205,90,126,126,40,248,213,63,202,146,248,96,87,6,214,63,
226,207,9,3,132,20,214,63,222,164,215,99,174,34,214,63,64,204,136,130,214,48,
214,63,21,40,69,94,252,62,214,63,198,193,53,246,31,77,214,63,236,201,132,73,65,
91,214,63,35,152,93,87,96,105,214,63,209,170,236,30,125,119,214,63,254,166,95,
159,151,133,214,63,26,88,229,215,175,147,214,63,206,175,173,199,197,161,214,63,
195,197,233,109,217,175,214,63,109,215,203,201,234,189,214,63,214,71,135,218,
249,203,214,63,99,159,80,159,6,218,214,63,156,139,93,23,17,232,214,63,241,222,
228,65,25,246,214,63,125,144,30,30,31,4,215,63,206,187,67,171,34,18,215,63,161,
160,142,232,35,32,215,63,170,162,58,213,34,46,215,63,77,73,132,112,31,60,215,
63,99,63,169,185,25,74,215,63,248,82,232,175,17,88,215,63,2,117,129,82,7,102,
215,63,37,185,181,160,250,115,215,63,106,85,199,153,235,129,215,63,248,161,249,
60,218,143,215,63,209,24,145,137,198,157,215,63,134,85,211,126,176,171,215,63,
240,20,7,28,152,185,215,63,231,52,116,96,125,199,215,63,247,179,99,75,96,213,
215,63,18,177,31,220,64,227,215,63,67,107,243,17,31,241,215,63,102,65,43,236,
250,254,215,63,209,177,20,106,212,12,216,63,10,90,254,138,171,26,216,63,116,246,
55,78,128,40,216,63,1,98,18,179,82,54,216,63,215,149,223,184,34,68,216,63,8,169,
242,94,240,81,216,63,53,208,159,164,187,95,216,63,58,93,60,137,132,109,216,63,
220,190,30,12,75,123,216,63,109,128,158,44,15,137,216,63,121,73,20,234,208,150,
216,63,104,221,217,67,144,164,216,63,37,27,74,57,77,178,216,63,202,252,192,201,
7,192,216,63,57,151,155,244,191,205,216,63,202,25,56,185,117,219,216,63,232,205,
245,22,41,233,216,63,181,22,53,13,218,246,216,63,170,112,87,155,136,4,217,63,
55,113,191,192,52,18,217,63,98,198,208,124,222,31,217,63,106,54,240,206,133,45,
217,63,92,159,131,182,42,59,217,63,183,246,241,50,205,72,217,63,7,73,163,67,109,
86,217,63,125,185,0,232,10,100,217,63,139,129,116,31,166,113,217,63,126,240,105,
233,62,127,217,63,24,107,77,69,213,140,217,63,37,107,140,50,105,154,217,63,20,
127,149,176,250,167,217,63,141,73,216,190,137,181,217,63,7,129,197,92,22,195,
217,63,92,239,206,137,160,208,217,63,96,113,103,69,40,222,217,63,110,246,2,143,
173,235,217,63,2,128,22,102,48,249,217,63,70,33,24,202,176,6,218,63,166,254,126,
186,46,20,218,63,94,77,195,54,170,33,218,63,11,83,94,62,35,47,218,63,57,101,202,
208,153,60,218,63,244,232,130,237,13,74,218,63,80,82,4,148,127,87,218,63,253,
35,204,195,238,100,218,63,204,238,88,124,91,114,218,63,64,81,42,189,197,127,218,
63,22,247,192,133,45,141,218,63,207,152,158,213,146,154,218,63,59,251,69,172,
245,167,218,63,255,238,58,9,86,181,218,63,33,80,2,236,179,194,218,63,139,5,34,
84,15,208,218,63,150,0,33,65,104,221,218,63,140,60,135,178,190,234,218,63,48,
190,221,167,18,248,218,63,68,147,174,32,100,5,219,63,8,210,132,28,179,18,219,
63,196,152,236,154,255,31,219,63,72,13,115,155,73,45,219,63,108,92,166,29,145,
58,219,63,151,185,21,33,214,71,219,63,58,94,81,165,24,85,219,63,87,137,234,169,
88,98,219,63,252,126,115,46,150,111,219,63,196,135,127,50,209,124,219,63,85,240,
162,181,9,138,219,63,227,8,115,183,63,151,219,63,165,36,134,55,115,164,219,63,
90,153,115,53,164,177,219,63,193,190,211,176,210,190,219,63,23,238,63,169,254,
203,219,63,146,129,82,30,40,217,219,63,218,211,166,15,79,230,219,63,135,63,217,
124,115,243,219,63,153,30,135,101,149,0,220,63,240,201,78,201,180,13,220,63,198,
152,207,167,209,26,220,63,42,224,169,0,236,39,220,63,114,242,126,211,3,53,220,
63,183,30,241,31,25,66,220,63,73,176,163,229,43,79,220,63,41,238,58,36,60,92,
220,63,121,26,92,219,73,105,220,63,249,113,173,10,85,118,220,63,114,43,214,177,
93,131,220,63,54,119,126,208,99,144,220,63,136,126,79,102,103,157,220,63,27,99,
243,114,104,170,220,63,123,62,21,246,102,183,220,63,134,33,97,239,98,196,220,
63,220,19,132,94,92,209,220,63,81,19,44,67,83,222,220,63,92,19,8,157,71,235,220,
63,142,252,199,107,57,248,220,63,251,171,28,175,40,5,221,63,173,242,183,102,21,
18,221,63,24,149,76,146,255,30,221,63,129,74,142,49,231,43,221,63,115,188,49,
68,204,56,221,63,43,134,236,201,174,69,221,63,7,52,117,194,142,82,221,63,241,
66,131,45,108,95,221,63,209,31,207,10,71,108,221,63,245,38,18,90,31,121,221,63,
129,163,6,27,245,133,221,63,218,206,103,77,200,146,221,63,17,208,241,240,152,
159,221,63,79,187,97,5,103,172,221,63,65,145,117,138,50,185,221,63,128,62,236,
127,251,197,221,63,255,154,133,229,193,210,221,63,116,105,2,187,133,223,221,63,
192,86,36,0,71,236,221,63,88,249,173,180,5,249,221,63,180,208,98,216,193,5,222,
63,176,68,7,107,123,18,222,63,248,164,96,108,50,31,222,63,115,40,53,220,230,43,
222,63,164,236,75,186,152,56,222,63,26,245,108,6,72,69,222,63,207,42,97,192,244,
81,222,63,150,91,242,231,158,94,222,63,124,57,235,124,70,107,222,63,52,90,23,
127,235,119,222,63,121,54,67,238,141,132,222,63,115,41,60,202,45,145,222,63,36,
112,208,18,203,157,222,63,196,40,207,199,101,170,222,63,45,82,8,233,253,182,222,
63,60,203,76,118,147,195,222,63,56,82,110,111,38,208,222,63,53,132,63,212,182,
220,222,63,122,220,147,164,68,233,222,63,226,179,63,224,207,245,222,63,67,64,
24,135,88,2,223,63,208,147,243,152,222,14,223,63,123,156,168,21,98,27,223,63,
91,35,15,253,226,39,223,63,13,204,255,78,97,52,223,63,24,20,84,11,221,64,223,
63,76,82,230,49,86,77,223,63,42,182,145,194,204,89,223,63,66,71,50,189,64,102,
223,63,149,228,164,33,178,114,223,63,250,67,199,239,32,127,223,63,124,241,119,
39,141,139,223,63,189,78,150,200,246,151,223,63,89,146,2,211,93,164,223,63,65,
199,157,70,194,176,223,63,38,204,73,35,36,189,223,63,208,82,233,104,131,201,223,
63,131,223,95,23,224,213,223,63,97,200,145,46,58,226,223,63,200,52,100,174,145,
238,223,63,178,28,189,150,230,250,223,63,12,164,193,115,156,3,224,63,37,39,79,
80,196,9,224,63,175,74,251,224,234,15,224,63,192,168,186,37,16,22,224,63,45,66,
130,30,52,28,224,63,57,126,71,203,86,34,224,63,67,42,0,44,120,40,224,63,122,121,
162,64,152,46,224,63,136,4,37,9,183,52,224,63,67,201,126,133,212,58,224,63,94,
42,167,181,240,64,224,63,23,239,149,153,11,71,224,63,230,66,67,49,37,77,224,63,
45,181,167,124,61,83,224,63,234,56,188,123,84,89,224,63,97,36,122,46,106,95,224,
63,208,48,219,148,126,101,224,63,26,122,217,174,145,107,224,63,123,126,111,124,
163,113,224,63,51,30,152,253,179,119,224,63,56,155,78,50,195,125,224,63,229,152,
142,26,209,131,224,63,165,27,84,182,221,137,224,63,168,136,155,5,233,143,224,
63,144,165,97,8,243,149,224,63,28,152,163,190,251,155,224,63,222,229,94,40,3,
162,224,63,228,115,145,69,9,168,224,63,108,134,57,22,14,174,224,63,142,192,85,
154,17,180,224,63,240,35,229,209,19,186,224,63,113,16,231,188,20,192,224,63,218,
67,91,91,20,198,224,63,141,217,65,173,18,204,224,63,51,74,155,178,15,210,224,
63,107,107,104,107,11,216,224,63,125,111,170,215,5,222,224,63,1,229,98,247,254,
227,224,63,150,182,147,202,246,233,224,63,140,42,63,81,237,239,224,63,149,226,
103,139,226,245,224,63,116,219,16,121,214,251,224,63,173,108,61,26,201,1,225,
63,48,72,241,110,186,7,225,63,13,122,48,119,170,13,225,63,34,104,255,50,153,19,
225,63,198,209,98,162,134,25,225,63,126,207,95,197,114,31,225,63,169,210,251,
155,93,37,225,63,47,165,60,38,71,43,225,63,51,105,40,100,47,49,225,63,189,152,
197,85,22,55,225,63,110,5,27,251,251,60,225,63,48,216,47,84,224,66,225,63,223,
144,11,97,195,72,225,63,255,5,182,33,165,78,225,63,106,100,55,150,133,84,225,
63,251,46,152,190,100,90,225,63,68,62,225,154,66,96,225,63,57,192,27,43,31,102,
225,63,225,55,81,111,250,107,225,63,6,125,139,103,212,113,225,63,228,187,212,
19,173,119,225,63,216,116,55,116,132,125,225,63,19,124,190,136,90,131,225,63,
70,249,116,81,47,137,225,63,82,103,102,206,2,143,225,63,253,147,158,255,212,148,
225,63,154,159,41,229,165,154,225,63,191,252,19,127,117,160,225,63,245,111,106,
205,67,166,225,63,99,15,58,208,16,172,225,63,133,66,144,135,220,177,225,63,214,
193,122,243,166,183,225,63,132,150,7,20,112,189,225,63,33,26,69,233,55,195,225,
63,79,246,65,115,254,200,225,63,118,36,13,178,195,206,225,63,113,237,181,165,
135,212,225,63,63,233,75,78,74,218,225,63,180,254,222,171,11,224,225,63,44,99,
127,190,203,229,225,63,56,154,61,134,138,235,225,63,81,117,42,3,72,241,225,63,
138,19,87,53,4,247,225,63,62,225,212,28,191,252,225,63,197,151,181,185,120,2,
226,63,32,61,11,12,49,8,226,63,178,35,232,19,232,13,226,63,231,233,94,209,157,
19,226,63,242,121,130,68,82,25,226,63,113,9,102,109,5,31,226,63,42,25,29,76,183,
36,226,63,184,116,187,224,103,42,226,63,57,50,85,43,23,48,226,63,9,178,254,43,
197,53,226,63,106,158,204,226,113,59,226,63,62,235,211,79,29,65,226,63,181,213,
41,115,199,70,226,63,255,227,227,76,112,76,226,63,1,229,23,221,23,82,226,63,6,
240,219,35,190,87,226,63,111,100,70,33,99,93,226,63,108,233,109,213,6,99,226,
63,166,109,105,64,169,104,226,63,251,38,80,98,74,110,226,63,41,146,57,59,234,
115,226,63,135,114,61,203,136,121,226,63,179,209,115,18,38,127,226,63,75,255,
244,16,194,132,226,63,153,144,217,198,92,138,226,63,78,96,58,52,246,143,226,63,
49,142,48,89,142,149,226,63,210,126,213,53,37,155,226,63,64,219,66,202,186,160,
226,63,190,144,146,22,79,166,226,63,115,208,222,26,226,171,226,63,34,15,66,215,
115,177,226,63,217,4,215,75,4,183,226,63,173,172,184,120,147,188,226,63,102,68,
2,94,33,194,226,63,58,76,207,251,173,199,226,63,127,134,59,82,57,205,226,63,94,
247,98,97,195,210,226,63,140,228,97,41,76,216,226,63,250,212,84,170,211,221,226,
63,144,144,88,228,89,227,226,63,219,31,138,215,222,232,226,63,202,203,6,132,98,
238,226,63,94,29,236,233,228,243,226,63,96,221,87,9,102,249,226,63,27,20,104,
226,229,254,226,63,11,9,59,117,100,4,227,63,153,66,239,193,225,9,227,63,207,133,
163,200,93,15,227,63,12,214,118,137,216,20,227,63,190,116,136,4,82,26,227,63,
22,225,247,57,202,31,227,63,190,215,228,41,65,37,227,63,146,82,111,212,182,42,
227,63,86,136,183,57,43,48,227,63,108,236,221,89,158,53,227,63,139,46,3,53,16,
59,227,63,120,58,72,203,128,64,227,63,187,55,206,28,240,69,227,63,89,137,182,
41,94,75,227,63,138,205,34,242,202,80,227,63,111,221,52,118,54,86,227,63,206,
204,14,182,160,91,227,63,200,233,210,177,9,97,227,63,144,188,163,105,113,102,
227,63,35,7,164,221,215,107,227,63,4,197,246,13,61,113,227,63,241,42,191,250,
160,118,227,63,158,166,32,164,3,124,227,63,106,222,62,10,101,129,227,63,31,177,
61,45,197,134,227,63,161,53,65,13,36,140,227,63,179,186,109,170,129,145,227,63,
166,198,231,4,222,150,227,63,26,23,212,28,57,156,227,63,177,160,87,242,146,161,
227,63,208,142,151,133,235,166,227,63,83,67,185,214,66,172,227,63,75,86,226,229,
152,177,227,63,181,149,56,179,237,182,227,63,55,5,226,62,65,188,227,63,219,221,
4,137,147,193,227,63,197,141,199,145,228,198,227,63,243,183,80,89,52,204,227,
63,247,51,199,223,130,209,227,63,175,13,82,37,208,214,227,63,4,133,24,42,28,220,
227,63,164,13,66,238,102,225,227,63,188,78,246,113,176,230,227,63,182,34,93,181,
248,235,227,63,244,150,158,184,63,241,227,63,140,235,226,123,133,246,227,63,5,
147,82,255,201,251,227,63,16,50,22,67,13,1,228,63,73,159,86,71,79,6,228,63,241,
226,60,12,144,11,228,63,172,54,242,145,207,16,228,63,60,5,160,216,13,22,228,63,
65,234,111,224,74,27,228,63,243,177,139,169,134,32,228,63,225,88,29,52,193,37,
228,63,176,11,79,128,250,42,228,63,214,38,75,142,50,48,228,63,89,54,60,94,105,
53,228,63,141,245,76,240,158,58,228,63,211,78,168,68,211,63,228,63,86,91,121,
91,6,69,228,63,202,98,235,52,56,74,228,63,42,219,41,209,104,79,228,63,122,104,
96,48,152,84,228,63,127,220,186,82,198,89,228,63,135,54,101,56,243,94,228,63,
32,163,139,225,30,100,228,63,222,123,90,78,73,105,228,63,22,71,254,126,114,110,
228,63,160,183,163,115,154,115,228,63,150,172,119,44,193,120,228,63,22,49,167,
169,230,125,228,63,254,123,95,235,10,131,228,63,177,239,205,241,45,136,228,63,
214,25,32,189,79,141,228,63,22,179,131,77,112,146,228,63,225,158,38,163,143,151,
228,63,45,235,54,190,173,156,228,63,54,208,226,158,202,161,228,63,67,176,88,69,
230,166,228,63,98,23,199,177,0,172,228,63,49,187,92,228,25,177,228,63,152,122,
72,221,49,182,228,63,144,93,185,156,72,187,228,63,229,148,222,34,94,192,228,63,
245,121,231,111,114,197,228,63,119,142,3,132,133,202,228,63,57,124,98,95,151,
207,228,63,232,20,52,2,168,212,228,63,206,81,168,108,183,217,228,63,150,83,239,
158,197,222,228,63,21,98,57,153,210,227,228,63,4,236,182,91,222,232,228,63,205,
134,152,230,232,237,228,63,72,238,14,58,242,242,228,63,129,4,75,86,250,247,228,
63,126,209,125,59,1,253,228,63,3,131,216,233,6,2,229,63,81,108,140,97,11,7,229,
63,245,5,203,162,14,12,229,63,129,237,197,173,16,17,229,63,91,229,174,130,17,
22,229,63,123,212,183,33,17,27,229,63,53,198,18,139,15,32,229,63,251,233,241,
190,12,37,229,63,38,147,135,189,8,42,229,63,185,56,6,135,3,47,229,63,40,117,160,
27,253,51,229,63,31,6,137,123,245,56,229,63,69,204,242,166,236,61,229,63,8,203,
16,158,226,66,229,63,94,40,22,97,215,71,229,63,143,44,54,240,202,76,229,63,253,
65,164,75,189,81,229,63,230,244,147,115,174,86,229,63,50,243,56,104,158,91,229,
63,52,12,199,41,141,96,229,63,120,48,114,184,122,101,229,63,132,113,110,20,103,
106,229,63,166,1,240,61,82,111,229,63,186,51,43,53,60,116,229,63,238,122,84,250,
36,121,229,63,148,106,160,141,12,126,229,63,225,181,67,239,242,130,229,63,187,
47,115,31,216,135,229,63,128,202,99,30,188,140,229,63,210,151,74,236,158,145,
229,63,92,200,92,137,128,150,229,63,158,171,207,245,96,155,229,63,183,175,216,
49,64,160,229,63,47,97,173,61,30,165,229,63,189,106,131,25,251,169,229,63,23,
149,144,197,214,174,229,63,185,198,10,66,177,179,229,63,176,3,40,143,138,184,
229,63,99,109,30,173,98,189,229,63,97,66,36,156,57,194,229,63,42,222,111,92,15,
199,229,63,251,184,55,238,227,203,229,63,151,103,178,81,183,208,229,63,24,155,
22,135,137,213,229,63,179,32,155,142,90,218,229,63,138,225,118,104,42,223,229,
63,117,226,224,20,249,227,229,63,208,67,16,148,198,232,229,63,68,65,60,230,146,
237,229,63,151,49,156,11,94,242,229,63,120,134,103,4,40,247,229,63,74,204,213,
208,240,251,229,63,242,169,30,113,184,0,230,63,166,224,121,229,126,5,230,63,182,
75,31,46,68,10,230,63,95,224,70,75,8,15,230,63,145,173,40,61,203,19,230,63,199,
219,252,3,141,24,230,63,204,172,251,159,77,29,230,63,142,123,93,17,13,34,230,
63,233,187,90,88,203,38,230,63,122,250,43,117,136,43,230,63,105,220,9,104,68,
48,230,63,59,31,45,49,255,52,230,63,159,152,206,208,184,57,230,63,62,54,39,71,
113,62,230,63,139,253,111,148,40,67,230,63,144,11,226,184,222,71,230,63,193,148,
182,180,147,76,230,63,200,228,38,136,71,81,230,63,91,94,108,51,250,85,230,63,
3,123,192,182,171,90,230,63,245,202,92,18,92,95,230,63,222,244,122,70,11,100,
230,63,179,181,84,83,185,104,230,63,135,224,35,57,102,109,230,63,84,94,34,248,
17,114,230,63,210,45,138,144,188,118,230,63,71,99,149,2,102,123,230,63,88,40,
126,78,14,128,230,63,218,187,126,116,181,132,230,63,165,113,209,116,91,137,230,
63,100,178,176,79,0,142,230,63,106,251,86,5,164,146,230,63,130,222,254,149,70,
151,230,63,194,1,227,1,232,155,230,63,92,31,62,73,136,160,230,63,118,5,75,108,
39,165,230,63,244,149,68,107,197,169,230,63,86,198,101,70,98,174,230,63,129,159,
233,253,253,178,230,63,153,61,11,146,152,183,230,63,209,207,5,3,50,188,230,63,
66,152,20,81,202,192,230,63,187,235,114,124,97,197,230,63,152,49,92,133,247,201,
230,63,149,227,11,108,140,206,230,63,162,141,189,48,32,211,230,63,185,205,172,
211,178,215,230,63,175,83,21,85,68,220,230,63,15,225,50,181,212,224,230,63,232,
72,65,244,99,229,230,63,169,111,124,18,242,233,230,63,239,74,32,16,127,238,230,
63,98,225,104,237,10,243,230,63,132,74,146,170,149,247,230,63,138,174,216,71,
31,252,230,63,52,70,120,197,167,0,231,63,157,90,173,35,47,5,231,63,24,69,180,
98,181,9,231,63,2,111,201,130,58,14,231,63,152,81,41,132,190,18,231,63,212,117,
16,103,65,23,231,63,58,116,187,43,195,27,231,63,185,244,102,210,67,32,231,63,
123,174,79,91,195,36,231,63,191,103,178,198,65,41,231,63,178,245,203,20,191,45,
231,63,68,60,217,69,59,50,231,63,255,45,23,90,182,54,231,63,229,203,194,81,48,
59,231,63,63,37,25,45,169,63,231,63,127,87,87,236,32,68,231,63,15,142,186,143,
151,72,231,63,50,2,128,23,13,77,231,63,214,250,228,131,129,81,231,63,113,204,
38,213,244,85,231,63,216,216,130,11,103,90,231,63,27,143,54,39,216,94,231,63,
90,107,127,40,72,99,231,63,160,246,154,15,183,103,231,63,192,198,198,220,36,108,
231,63,43,126,64,144,145,112,231,63,202,203,69,42,253,116,231,63,219,106,20,171,
103,121,231,63,199,34,234,18,209,125,231,63,2,199,4,98,57,130,231,63,223,54,162,
152,160,134,231,63,112,93,0,183,6,139,231,63,94,49,93,189,107,143,231,63,198,
180,246,171,207,147,231,63,17,245,10,131,50,152,231,63,210,10,216,66,148,156,
231,63,162,25,156,235,244,160,231,63,248,79,149,125,84,165,231,63,9,231,1,249,
178,169,231,63,160,34,32,94,16,174,231,63,254,80,46,173,108,178,231,63,176,202,
106,230,199,182,231,63,117,242,19,10,34,187,231,63,16,53,104,24,123,191,231,63,
43,9,166,17,211,195,231,63,52,239,11,246,41,200,231,63,52,113,216,197,127,204,
231,63,180,34,74,129,212,208,231,63,147,160,159,40,40,213,231,63,234,144,23,188,
122,217,231,63,227,162,240,59,204,221,231,63,155,142,105,168,28,226,231,63,254,
20,193,1,108,230,231,63,165,255,53,72,186,234,231,63,183,32,7,124,7,239,231,63,
192,82,115,157,83,243,231,63,152,120,185,172,158,247,231,63,60,125,24,170,232,
251,231,63,172,83,207,149,49,0,232,63,206,246,28,112,121,4,232,63,75,105,64,57,
192,8,232,63,107,181,120,241,5,13,232,63,250,236,4,153,74,17,232,63,34,41,36,
48,142,21,232,63,77,138,21,183,208,25,232,63,4,56,24,46,18,30,232,63,209,96,107,
149,82,34,232,63,26,58,78,237,145,38,232,63,5,0,0,54,208,42,232,63,87,245,191,
111,13,47,232,63,85,99,205,154,73,51,232,63,162,153,103,183,132,55,232,63,34,
238,205,197,190,59,232,63,219,188,63,198,247,63,232,63,211,103,252,184,47,68,
232,63,244,86,67,158,102,72,232,63,235,247,83,118,156,76,232,63,11,190,109,65,
209,80,232,63,45,34,208,255,4,85,232,63,146,162,186,177,55,89,232,63,197,194,
108,87,105,93,232,63,123,11,38,241,153,97,232,63,121,10,38,127,201,101,232,63,
112,82,172,1,248,105,232,63,229,122,248,120,37,110,232,63,17,32,74,229,81,114,
232,63,193,226,224,70,125,118,232,63,62,104,252,157,167,122,232,63,42,90,220,
234,208,126,232,63,103,102,192,45,249,130,232,63,247,62,232,102,32,135,232,63,
227,153,147,150,70,139,232,63,25,49,2,189,107,143,232,63,84,194,115,218,143,147,
232,63,252,14,40,239,178,151,232,63,13,220,94,251,212,155,232,63,248,241,87,255,
245,159,232,63,136,28,83,251,21,164,232,63,198,42,144,239,52,168,232,63,221,238,
78,220,82,172,232,63,255,61,207,193,111,176,232,63,71,240,80,160,139,180,232,
63,160,224,19,120,166,184,232,63,171,236,87,73,192,188,232,63,157,244,92,20,217,
192,232,63,46,219,98,217,240,196,232,63,116,133,169,152,7,201,232,63,206,218,
112,82,29,205,232,63,203,196,248,6,50,209,232,63,7,47,129,182,69,213,232,63,27,
7,74,97,88,217,232,63,123,60,147,7,106,221,232,63,94,192,156,169,122,225,232,
63,165,133,166,71,138,229,232,63,192,128,240,225,152,233,232,63,150,167,186,120,
166,237,232,63,103,241,68,12,179,241,232,63,183,86,207,156,190,245,232,63,49,
209,153,42,201,249,232,63,145,91,228,181,210,253,232,63,135,241,238,62,219,1,
233,63,162,143,249,197,226,5,233,63,51,51,68,75,233,9,233,63,54,218,14,207,238,
13,233,63,59,131,153,81,243,17,233,63,73,45,36,211,246,21,233,63,201,215,238,
83,249,25,233,63,110,130,57,212,250,29,233,63,24,45,68,84,251,33,233,63 
}; 
    double y,z; 
    double a,b,c,d; 
    double u,v; 
    double *arc_pnt; 
    double xx,yy; 

    long sign; 
    long flag; 
    long g,h,i,j,k; 

    arc_pnt = (double *) first_arctan; 

    sign = 0; 
    flag = 0; 

    if (x == 0.0)   return (0.0); 
    if (x < 0.0)  { 
        x = 0.0 - x; 
        sign = 1; 
    } 
    if (x == 1.0)  { 
        if (sign == 0)   return (0.7853981633974483); 
        else             return (-0.7853981633974483); 
    } 
    if (x > 1.0)  { 
        flag = 1; 
        x = 1.0 / x; 
    } 
/* 
&dA &d@   Step 1:  determine x0 (xx) , and increment number (h) 
*/ 
    if (x < 0.5)  { 
        i = 0; 
        j = 256; 
        k = 512; 
        a = 0.0; 
        b = 0.25; 
        c = 0.5; 
    } 
    else { 
        i = 512; 
        j = 768; 
        k = 1024; 
        a = 0.5; 
        b = 0.75; 
        c = 1.0; 
    } 
    g = 0; 
ATAN1: 
    if (x == a)  { 
        xx = x; 
        h = i; 
        goto ATAN2; 
    } 
    if (x == b)  { 
        xx = x; 
        h = j; 
        goto ATAN2; 
    } 
    if (x < b)  { 
        if (g > 7)  { 
            xx = a; 
            h = i; 
            goto ATAN2; 
        } 
        c = b; 
        b = (a + c) / 2.0; 
        k = j; 
        j = (i + k) / 2; 
    } 
    else { 
        if (g > 7)  { 
            xx = b; 
            h = j; 
            goto ATAN2; 
        } 
        a = b; 
        b = (a + c) / 2.0; 
        i = j; 
        j = (i + k) / 2; 
    } 
    ++g; 
    goto ATAN1; 
ATAN2: 
/* 
&dA &d@   Step 2:  determine y = arctan(xx) 
*/ 
    if (h == 0)  { 
        y = 0.0; 
    } 
    else { 
        --h; 
        y = *(arc_pnt + h); 
    } 
/* 
&dA &d@                                             (x - xx) 
&dA &d@   Step 3:  determine small argument z = (--------------) 
&dA &d@                                           1 + x * (xx) 
*/ 
    u = x - xx; 
    v = 1.0 + (x * xx); 
    z = u / v; 
/* 
&dA &d@   Step 4:  construct yy = arctan(z)  using series expansion 
*/ 
    d = z * z; 
    yy = 1.0 - (d / 3.0) + (d * d / 5.0); 
    yy *= z; 
/* 
&dA &d@   Step 5:  add small correction to basic arctan 
*/ 
    y += yy; 
/* 
&dA &d@   Step 6:  modify output
*/ 
    if (flag == 1)  { 
        y = 1.5707963267948966 - y; 
    } 
    if (sign == 1)  { 
        y = 0.0 - y; 
    } 
    return (y); 
} 

/*** FUNCTION   double my_sincostan(long flag, double x); 

    Purpose:   compute the value of sinx, cosx, or tanx 

    Input:     long   flag   1 = sin, 2 = cos, 3 = tan.  
               double x.     No limit on the value of x for sin or cos.  
                             For tan x, the value is undefined if cos(x) = 0

    Return:    double sin(x), cos(x) or tan(x) 
                                                                  ***/ 

double my_sincostan(long flag, double x) 
{ 
    static char sin_cos[25200] = { 
0,0,0,0,0,0,0,0,0,0,0,0,0,0,240,63,98,138,33,165,77,98,80,63,108,135,144,243,
254,255,239,63,97,45,177,27,77,98,96,63,71,47,66,206,251,255,239,63,146,228,240,
81,114,147,104,63,89,44,21,144,246,255,239,63,100,212,239,245,74,98,112,63,151,
214,9,57,239,255,239,63,134,169,6,176,219,122,116,63,38,169,32,201,229,255,239,
63,57,240,132,18,107,147,120,63,91,66,90,64,218,255,239,63,138,189,178,216,248,
171,124,63,185,99,183,158,204,255,239,63,198,32,236,94,66,98,128,63,242,241,56,
228,188,255,239,63,237,229,158,62,135,110,130,63,231,244,223,16,171,255,239,63,
8,232,21,233,202,122,132,63,170,151,173,36,151,255,239,63,46,117,245,59,13,135,
134,63,121,40,163,31,129,255,239,63,246,241,225,20,78,147,136,63,193,24,194,1,
105,255,239,63,190,219,127,81,141,159,138,63,32,253,11,203,78,255,239,63,233,
202,115,207,202,171,140,63,97,141,130,123,50,255,239,63,33,117,98,108,6,184,142,
63,124,164,39,19,20,255,239,63,203,87,248,2,32,98,144,63,154,64,253,145,243,254,
239,63,157,184,225,188,59,104,145,63,17,131,5,248,208,254,239,63,134,234,191,
82,86,110,146,63,100,176,66,69,172,254,239,63,41,142,101,179,111,116,147,63,70,
48,183,121,133,254,239,63,106,88,165,205,135,122,148,63,150,141,101,149,92,254,
239,63,148,19,82,144,158,128,149,63,98,118,80,152,49,254,239,63,117,160,62,234,
179,134,150,63,228,187,122,130,4,254,239,63,127,247,61,202,199,140,151,63,132,
82,231,83,213,253,239,63,234,41,35,31,218,146,152,63,214,81,153,12,164,253,239,
63,210,98,193,215,234,152,153,63,158,244,147,172,112,253,239,63,87,232,235,226,
249,158,154,63,200,152,218,51,59,253,239,63,190,28,118,47,7,165,155,63,111,191,
112,162,3,253,239,63,147,127,51,172,18,171,156,63,219,12,90,248,201,252,239,63,
198,174,247,71,28,177,157,63,126,72,154,53,142,252,239,63,204,103,150,241,35,
183,158,63,246,92,53,90,80,252,239,63,192,136,227,151,41,189,159,63,13,88,47,
102,16,252,239,63,194,136,217,148,150,97,160,63,185,106,140,89,206,251,239,63,
110,146,236,74,151,228,160,63,24,233,80,52,138,251,239,63,203,4,149,229,150,103,
161,63,118,74,129,246,67,251,239,63,209,21,61,92,149,234,161,63,71,41,34,160,
251,250,239,63,157,14,79,166,146,109,162,63,42,67,56,49,177,250,239,63,254,75,
53,187,142,240,162,63,230,120,200,169,100,250,239,63,5,63,90,146,137,115,163,
63,111,206,215,9,22,250,239,63,152,109,40,35,131,246,163,63,223,106,107,81,197,
249,239,63,255,114,10,101,123,121,164,63,120,152,136,128,114,249,239,63,117,0,
107,79,114,252,164,63,168,196,52,151,29,249,239,63,183,221,180,217,103,127,165,
63,1,128,117,149,198,248,239,63,153,233,82,251,91,2,166,63,63,126,80,123,109,
248,239,63,141,26,176,171,78,133,166,63,70,150,203,72,18,248,239,63,59,127,55,
226,63,8,167,63,30,194,236,253,180,247,239,63,14,63,84,150,47,139,167,63,247,
30,186,154,85,247,239,63,195,154,113,191,29,14,168,63,40,237,57,31,244,246,239,
63,251,236,250,84,10,145,168,63,44,144,114,139,144,246,239,63,200,170,91,78,245,
19,169,63,165,142,106,223,42,246,239,63,65,100,255,162,222,150,169,63,88,146,
40,27,195,245,239,63,15,197,81,74,198,25,170,63,47,104,179,62,89,245,239,63,254,
148,190,59,172,156,170,63,58,0,18,74,237,244,239,63,140,184,177,110,144,31,171,
63,168,109,75,61,127,244,239,63,122,49,151,218,114,162,171,63,208,230,102,24,
15,244,239,63,91,31,219,118,83,37,172,63,40,197,107,219,156,243,239,63,39,192,
233,58,50,168,172,63,75,133,97,134,40,243,239,63,196,112,47,30,15,43,173,63,241,
198,79,25,178,242,239,63,158,173,24,24,234,173,173,63,248,76,62,148,57,242,239,
63,50,19,18,32,195,48,174,63,93,253,52,247,190,241,239,63,157,94,136,45,154,179,
174,63,59,225,59,66,66,241,239,63,49,110,232,55,111,54,175,63,207,36,91,117,195,
240,239,63,0,66,159,54,66,185,175,63,116,23,155,144,66,240,239,63,54,254,140,
144,9,30,176,63,163,43,4,148,191,239,239,63,95,241,98,247,112,95,176,63,245,246,
158,127,58,239,239,63,213,46,136,75,215,160,176,63,29,50,116,83,179,238,239,63,
244,124,179,136,60,226,176,63,237,184,140,15,42,238,239,63,96,180,155,170,160,
35,177,63,84,138,241,179,158,237,239,63,79,192,247,172,3,101,177,63,90,200,171,
64,17,237,239,63,204,158,126,139,101,166,177,63,35,184,196,181,129,236,239,63,
4,97,231,65,198,231,177,63,239,193,69,19,240,235,239,63,141,43,233,203,37,41,
178,63,21,113,56,89,92,235,239,63,172,54,59,37,132,106,178,63,8,116,166,135,198,
234,239,63,158,206,148,73,225,171,178,63,81,156,153,158,46,234,239,63,221,83,
173,52,61,237,178,63,147,222,27,158,148,233,239,63,112,59,60,226,151,46,179,63,
133,82,55,134,248,232,239,63,40,15,249,77,241,111,179,63,250,50,246,86,90,232,
239,63,241,109,155,115,73,177,179,63,212,221,98,16,186,231,239,63,20,12,219,78,
160,242,179,63,17,212,135,178,23,231,239,63,130,179,111,219,245,51,180,63,190,
185,111,61,115,230,239,63,26,68,17,21,74,117,180,63,254,85,37,177,204,229,239,
63,242,179,119,247,156,182,180,63,9,147,179,13,36,229,239,63,158,15,91,126,238,
247,180,63,39,126,37,83,121,228,239,63,122,122,115,165,62,57,181,63,178,71,134,
129,204,227,239,63,239,46,121,104,141,122,181,63,20,67,225,152,29,227,239,63,
186,126,36,195,218,187,181,63,202,230,65,153,108,226,239,63,58,211,45,177,38,
253,181,63,95,204,179,130,185,225,239,63,175,173,77,46,113,62,182,63,107,176,
66,85,4,225,239,63,137,167,60,54,186,127,182,63,150,114,250,16,77,224,239,63,
172,114,179,196,1,193,182,63,149,21,231,181,147,223,239,63,186,217,106,213,71,
2,183,63,41,191,20,68,216,222,239,63,90,192,27,100,140,67,183,63,29,184,143,187,
26,222,239,63,124,35,127,108,207,132,183,63,74,108,100,28,91,221,239,63,169,25,
78,234,16,198,183,63,144,106,159,102,153,220,239,63,66,211,65,217,80,7,184,63,
218,100,77,154,213,219,239,63,206,154,19,53,143,72,184,63,26,48,123,183,15,219,
239,63,62,213,124,249,203,137,184,63,73,196,53,190,71,218,239,63,56,2,55,34,7,
203,184,63,105,60,138,174,125,217,239,63,91,188,251,170,64,12,185,63,127,214,
133,136,177,216,239,63,138,185,132,143,120,77,185,63,152,243,53,76,227,215,239,
63,49,203,139,203,174,142,185,63,192,23,168,249,18,215,239,63,144,222,202,90,
227,207,185,63,12,234,233,144,64,214,239,63,254,252,251,56,22,17,186,63,143,52,
9,18,108,213,239,63,55,76,217,97,71,82,186,63,95,228,19,125,149,212,239,63,156,
14,29,209,118,147,186,63,146,9,24,210,188,211,239,63,131,163,129,130,164,212,
186,63,61,215,35,17,226,210,239,63,120,135,193,113,208,21,187,63,117,163,69,58,
5,210,239,63,134,84,151,154,250,86,187,63,75,231,139,77,38,209,239,63,132,194,
189,248,34,152,187,63,205,62,5,75,69,208,239,63,83,167,239,135,73,217,187,63,
5,105,192,50,98,207,239,63,49,247,231,67,110,26,188,63,248,71,204,4,125,206,239,
63,246,196,97,40,145,91,188,63,165,224,55,193,149,205,239,63,98,66,24,49,178,
156,188,63,2,91,18,104,172,204,239,63,99,192,198,89,209,221,188,63,254,1,107,
249,192,203,239,63,94,175,40,158,238,30,189,63,127,67,81,117,211,202,239,63,115,
159,249,249,9,96,189,63,97,176,212,219,227,201,239,63,199,64,245,104,35,161,189,
63,116,252,4,45,242,200,239,63,204,99,215,230,58,226,189,63,123,254,241,104,254,
199,239,63,138,249,91,111,80,35,190,63,46,176,171,143,8,199,239,63,224,19,63,
254,99,100,190,63,51,46,66,161,16,198,239,63,212,229,60,143,117,165,190,63,37,
184,197,157,22,197,239,63,212,195,17,30,133,230,190,63,139,176,70,133,26,196,
239,63,2,36,122,166,146,39,191,63,220,156,213,87,28,195,239,63,121,158,50,36,
158,104,191,63,123,37,131,21,28,194,239,63,150,237,247,146,167,169,191,63,186,
21,96,190,25,193,239,63,60,238,134,238,174,234,191,63,211,91,125,82,21,192,239,
63,17,80,78,25,218,21,192,63,237,8,236,209,14,191,239,63,11,19,123,173,91,54,
192,63,20,81,189,60,6,190,239,63,33,99,168,49,220,86,192,63,64,139,2,147,251,
188,239,63,61,245,180,163,91,119,192,63,77,49,205,212,238,187,239,63,63,144,127,
1,218,151,192,63,253,223,46,2,224,186,239,63,36,13,231,72,87,184,192,63,248,86,
57,27,207,185,239,63,36,87,202,119,211,216,192,63,199,120,254,31,188,184,239,
63,221,107,8,140,78,249,192,63,214,74,144,16,167,183,239,63,113,91,128,131,200,
25,193,63,113,245,0,237,143,182,239,63,171,72,17,92,65,58,193,63,197,195,98,181,
118,181,239,63,38,105,154,19,185,90,193,63,221,35,200,105,91,180,239,63,107,5,
251,167,47,123,193,63,161,166,67,10,62,179,239,63,26,121,18,23,165,155,193,63,
213,255,231,150,30,178,239,63,11,51,192,94,25,188,193,63,24,6,200,15,253,176,
239,63,114,181,227,124,140,220,193,63,226,178,246,116,217,175,239,63,3,150,92,
111,254,252,193,63,133,34,135,198,179,174,239,63,22,126,10,52,111,29,194,63,39,
148,140,4,140,173,239,63,201,42,205,200,222,61,194,63,199,105,26,47,98,172,239,
63,38,109,132,43,77,94,194,63,55,40,68,70,54,171,239,63,70,42,16,90,186,126,194,
63,28,119,29,74,8,170,239,63,115,91,80,82,38,159,194,63,238,32,186,58,216,168,
239,63,77,14,37,18,145,191,194,63,245,18,46,24,166,167,239,63,239,100,110,151,
250,223,194,63,73,93,141,226,113,166,239,63,15,150,12,224,98,0,195,63,206,50,
236,153,59,165,239,63,38,237,223,233,201,32,195,63,55,233,94,62,3,164,239,63,
143,202,200,178,47,65,195,63,3,249,249,207,200,162,239,63,176,163,167,56,148,
97,195,63,120,253,209,78,140,161,239,63,25,3,93,121,247,129,195,63,167,180,251,
186,77,160,239,63,168,136,201,114,89,162,195,63,103,255,139,20,13,159,239,63,
177,233,205,34,186,194,195,63,88,225,151,91,202,157,239,63,29,241,74,135,25,227,
195,63,218,128,52,144,133,156,239,63,141,127,33,158,119,3,196,63,20,39,119,178,
62,155,239,63,132,139,50,101,212,35,196,63,237,63,117,194,245,153,239,63,132,
33,95,218,47,68,196,63,12,90,68,192,170,152,239,63,51,100,136,251,137,100,196,
63,217,38,250,171,93,151,239,63,128,140,143,198,226,132,196,63,120,122,172,133,
14,150,239,63,200,233,85,57,58,165,196,63,201,75,113,77,189,148,239,63,245,225,
188,81,144,197,196,63,104,180,94,3,106,147,239,63,166,241,165,13,229,229,196,
63,170,240,138,167,20,146,239,63,80,172,242,106,56,6,197,63,154,95,12,58,189,
144,239,63,98,188,132,103,138,38,197,63,251,130,249,186,99,143,239,63,104,227,
61,1,219,70,197,63,69,255,104,42,8,142,239,63,51,250,255,53,42,103,197,63,163,
155,113,136,170,140,239,63,244,240,172,3,120,135,197,63,241,65,42,213,74,139,
239,63,104,207,38,104,196,167,197,63,189,254,169,16,233,137,239,63,246,180,79,
97,15,200,197,63,67,1,8,59,133,136,239,63,213,216,9,237,88,232,197,63,108,155,
91,84,31,135,239,63,48,138,55,9,161,8,198,63,206,65,188,92,183,133,239,63,70,
48,187,179,231,40,198,63,167,139,65,84,77,132,239,63,147,74,119,234,44,73,198,
63,225,50,3,59,225,130,239,63,237,112,78,171,112,105,198,63,11,20,25,17,115,129,
239,63,175,83,35,244,178,137,198,63,89,46,155,214,2,128,239,63,212,187,216,194,
243,169,198,63,166,163,161,139,144,126,239,63,34,139,81,21,51,202,198,63,108,
184,68,48,28,125,239,63,74,188,112,233,112,234,198,63,200,211,156,196,165,123,
239,63,9,99,25,61,173,10,199,63,119,127,194,72,45,122,239,63,82,172,46,14,232,
42,199,63,209,103,206,188,178,120,239,63,107,222,147,90,33,75,199,63,204,91,217,
32,54,119,239,63,21,89,44,32,89,107,199,63,248,76,252,116,183,117,239,63,172,
149,219,92,143,139,199,63,126,79,80,185,54,116,239,63,76,39,133,14,196,171,199,
63,29,154,238,237,179,114,239,63,245,186,12,51,247,203,199,63,43,134,240,18,47,
113,239,63,174,23,86,200,40,236,199,63,146,143,111,40,168,111,239,63,169,30,69,
204,88,12,200,63,205,84,133,46,31,110,239,63,98,203,189,60,135,44,200,63,231,
150,75,37,148,108,239,63,202,51,164,23,180,76,200,63,123,57,220,12,7,107,239,
63,101,136,220,90,223,108,200,63,178,66,81,229,119,105,239,63,110,20,75,4,9,141,
200,63,62,219,196,174,230,103,239,63,251,61,212,17,49,173,200,63,93,78,81,105,
83,102,239,63,34,134,92,129,87,205,200,63,211,9,17,21,190,100,239,63,25,137,200,
80,124,237,200,63,235,157,30,178,38,99,239,63,93,254,252,125,159,13,201,63,117,
189,148,64,141,97,239,63,210,184,222,6,193,45,201,63,196,61,142,192,241,95,239,
63,233,166,82,233,224,77,201,63,170,22,38,50,84,94,239,63,193,210,61,35,255,109,
201,63,122,98,119,149,180,92,239,63,77,98,133,178,27,142,201,63,4,94,157,234,
18,91,239,63,115,151,14,149,54,174,201,63,148,104,179,49,111,89,239,63,55,208,
190,200,79,206,201,63,239,3,213,106,201,87,239,63,212,134,123,75,103,238,201,
63,83,212,29,150,33,86,239,63,232,81,42,27,125,14,202,63,116,160,169,179,119,
84,239,63,147,228,176,53,145,46,202,63,121,81,148,195,203,82,239,63,156,14,245,
152,163,78,202,63,254,242,249,197,29,81,239,63,147,188,220,66,180,110,202,63,
14,179,246,186,109,79,239,63,244,247,77,49,195,142,202,63,36,226,166,162,187,
77,239,63,77,231,46,98,208,174,202,63,38,243,38,125,7,76,239,63,94,206,101,211,
219,206,202,63,105,123,147,74,81,74,239,63,61,14,217,130,229,238,202,63,168,50,
9,11,153,72,239,63,123,37,111,110,237,14,203,63,6,243,164,190,222,70,239,63,70,
176,14,148,243,46,203,63,12,185,131,101,34,69,239,63,140,104,158,241,247,78,203,
63,168,163,194,255,99,67,239,63,29,38,5,133,250,110,203,63,39,244,126,141,163,
65,239,63,210,222,41,76,251,142,203,63,56,14,214,14,225,63,239,63,172,166,243,
68,250,174,203,63,231,119,229,131,28,62,239,63,251,175,73,109,247,206,203,63,
156,217,202,236,85,60,239,63,125,75,19,195,242,238,203,63,24,254,163,73,141,58,
239,63,133,232,55,68,236,14,204,63,119,210,142,154,194,56,239,63,27,21,159,238,
227,46,204,63,41,102,169,223,245,54,239,63,35,126,48,192,217,78,204,63,241,234,
17,25,39,53,239,63,123,239,211,182,205,110,204,63,231,180,230,70,86,51,239,63,
36,84,113,208,191,142,204,63,112,58,70,105,131,49,239,63,96,182,240,10,176,174,
204,63,67,20,79,128,174,47,239,63,215,63,58,100,158,206,204,63,96,253,31,140,
215,45,239,63,189,57,54,218,138,238,204,63,18,211,215,140,254,43,239,63,240,12,
205,106,117,14,205,63,236,148,149,130,35,42,239,63,30,66,231,19,94,46,205,63,
200,100,120,109,70,40,239,63,232,129,109,211,68,78,205,63,196,134,159,77,103,
38,239,63,4,149,72,167,41,110,205,63,62,97,42,35,134,36,239,63,100,100,97,141,
12,142,205,63,215,124,56,238,162,34,239,63,81,249,160,131,237,173,205,63,107,
132,233,174,189,32,239,63,151,125,240,135,204,205,205,63,20,69,93,101,214,30,
239,63,161,59,57,152,169,237,205,63,37,174,179,17,237,28,239,63,161,158,100,178,
132,13,206,63,39,209,12,180,1,27,239,63,178,50,92,212,93,45,206,63,220,225,136,
76,20,25,239,63,247,164,9,252,52,77,206,63,53,54,72,219,36,23,239,63,195,195,
86,39,10,109,206,63,89,70,107,96,51,21,239,63,186,126,45,84,221,140,206,63,155,
172,18,220,63,19,239,63,245,230,119,128,174,172,206,63,123,37,95,78,74,17,239,
63,35,47,32,170,125,204,206,63,166,143,113,183,82,15,239,63,172,171,16,207,74,
236,206,63,240,235,106,23,89,13,239,63,215,210,51,237,21,12,207,63,85,93,108,
110,93,11,239,63,236,60,116,2,223,43,207,63,243,40,151,188,95,9,239,63,82,164,
188,12,166,75,207,63,12,182,12,2,96,7,239,63,187,229,247,9,107,107,207,63,3,142,
238,62,94,5,239,63,61,0,17,248,45,139,207,63,86,92,94,115,90,3,239,63,125,21,
243,212,238,170,207,63,161,238,125,159,84,1,239,63,206,105,137,158,173,202,207,
63,153,52,111,195,76,255,238,63,86,100,191,82,106,234,207,63,9,64,84,223,66,253,
238,63,150,71,192,119,18,5,208,63,210,68,79,243,54,251,238,63,193,75,92,185,238,
20,208,63,232,152,130,255,40,249,238,63,225,166,41,237,201,36,208,63,78,180,16,
4,25,247,238,63,219,82,30,18,164,52,208,63,22,49,28,1,7,245,238,63,82,91,48,39,
125,68,208,63,96,203,199,246,242,242,238,63,188,221,85,43,85,84,208,63,81,97,
54,229,220,240,238,63,113,9,133,29,44,100,208,63,26,243,138,204,196,238,238,63,
192,31,180,252,1,116,208,63,239,162,232,172,170,236,238,63,249,115,217,199,214,
131,208,63,6,181,114,134,142,234,238,63,135,107,235,125,170,147,208,63,151,143,
76,89,112,232,238,63,253,125,224,29,125,163,208,63,215,186,153,37,80,230,238,
63,38,53,175,166,78,179,208,63,249,224,125,235,45,228,238,63,25,45,78,23,31,195,
208,63,38,206,28,171,9,226,238,63,77,20,180,110,238,210,208,63,129,112,154,100,
227,223,238,63,162,171,215,171,188,226,208,63,32,216,26,24,187,221,238,63,123,
198,175,205,137,242,208,63,13,55,194,197,144,219,238,63,203,74,51,211,85,2,209,
63,65,225,180,109,100,217,238,63,39,49,89,187,32,18,209,63,162,76,23,16,54,215,
238,63,216,132,24,133,234,33,209,63,4,17,14,173,5,213,238,63,235,99,104,47,179,
49,209,63,32,232,189,68,211,210,238,63,70,255,63,185,122,65,209,63,153,173,75,
215,158,208,238,63,180,154,150,33,65,81,209,63,244,94,220,100,104,206,238,63,
249,140,99,103,6,97,209,63,152,27,149,237,47,204,238,63,230,63,158,137,202,112,
209,63,204,36,155,113,245,201,238,63,101,48,62,135,141,128,209,63,178,221,19,
241,184,199,238,63,143,238,58,95,79,144,209,63,73,203,36,108,122,197,238,63,186,
29,140,16,16,160,209,63,101,148,243,226,57,195,238,63,141,116,41,154,207,175,
209,63,177,1,166,85,247,192,238,63,15,189,10,251,141,191,209,63,171,253,97,196,
178,190,238,63,187,212,39,50,75,207,209,63,160,148,77,47,108,188,238,63,141,172,
120,62,7,223,209,63,173,244,142,150,35,186,238,63,24,73,245,30,194,238,209,63,
185,109,76,250,216,183,238,63,150,194,149,210,123,254,209,63,115,113,172,90,140,
181,238,63,246,68,82,88,52,14,210,63,84,147,213,183,61,179,238,63,241,15,35,175,
235,29,210,63,149,136,238,17,237,176,238,63,29,119,0,214,161,45,210,63,49,40,
30,105,154,174,238,63,246,225,226,203,86,61,210,63,229,106,139,189,69,172,238,
63,249,203,194,143,10,77,210,63,37,107,93,15,239,169,238,63,176,196,152,32,189,
92,210,63,36,101,187,94,150,167,238,63,196,111,93,125,110,108,210,63,200,182,
204,171,59,165,238,63,13,133,9,165,30,124,210,63,173,223,184,246,222,162,238,
63,167,208,149,150,205,139,210,63,35,129,167,63,128,160,238,63,1,51,251,80,123,
155,210,63,36,94,192,134,31,158,238,63,236,160,50,211,39,171,210,63,93,91,43,
204,188,155,238,63,177,35,53,28,211,186,210,63,33,127,16,16,88,153,238,63,31,
217,251,42,125,202,210,63,108,241,151,82,241,150,238,63,156,243,127,254,37,218,
210,63,222,251,233,147,136,148,238,63,55,186,186,149,205,233,210,63,186,9,47,
212,29,146,238,63,188,136,165,239,115,249,210,63,226,167,143,19,177,143,238,63,
192,207,57,11,25,9,211,63,213,132,52,82,66,141,238,63,182,20,113,231,188,24,211,
63,173,112,70,144,209,138,238,63,254,241,68,131,95,40,211,63,27,93,238,205,94,
136,238,63,249,22,175,221,0,56,211,63,101,93,85,11,234,133,238,63,23,72,169,245,
160,71,211,63,98,166,164,72,115,131,238,63,233,94,45,202,63,87,211,63,123,142,
5,134,250,128,238,63,53,74,53,90,221,102,211,63,162,141,161,195,127,126,238,63,
4,14,187,164,121,118,211,63,88,61,162,1,3,124,238,63,179,195,184,168,20,134,211,
63,162,88,49,64,132,121,238,63,6,154,40,101,174,149,211,63,9,188,120,127,3,119,
238,63,57,213,4,217,70,165,211,63,154,101,162,191,128,116,238,63,16,207,71,3,
222,180,211,63,225,116,216,0,252,113,238,63,233,246,235,226,115,196,211,63,228,
42,69,67,117,111,238,63,205,209,235,118,8,212,211,63,38,234,18,135,236,108,238,
63,128,250,65,190,155,227,211,63,157,54,108,204,97,106,238,63,149,33,233,183,
45,243,211,63,183,181,123,19,213,103,238,63,124,13,220,98,190,2,212,63,80,46,
108,92,70,101,238,63,148,154,21,190,77,18,212,63,180,136,104,167,181,98,238,63,
62,187,144,200,219,33,212,63,155,206,155,244,34,96,238,63,236,119,72,129,104,
49,212,63,35,43,49,68,142,93,238,63,49,239,55,231,243,64,212,63,212,234,83,150,
247,90,238,63,215,85,90,249,125,80,212,63,149,123,47,235,94,88,238,63,235,246,
170,182,6,96,212,63,178,108,239,66,196,85,238,63,208,51,37,30,142,111,212,63,
207,110,191,157,39,83,238,63,80,132,196,46,20,127,212,63,239,83,203,251,136,80,
238,63,174,118,132,231,152,142,212,63,107,15,63,93,232,77,238,63,181,175,96,71,
28,158,212,63,240,181,70,194,69,75,238,63,205,234,84,77,158,173,212,63,126,125,
14,43,161,72,238,63,5,250,92,248,30,189,212,63,100,189,194,151,250,69,238,63,
43,198,116,71,158,204,212,63,60,238,143,8,82,67,238,63,220,78,152,57,28,220,212,
63,235,169,162,125,167,64,238,63,145,170,195,205,152,235,212,63,155,171,39,247,
250,61,238,63,178,6,243,2,20,251,212,63,185,207,75,117,76,59,238,63,169,167,34,
216,141,10,213,63,243,19,60,248,155,56,238,63,243,232,78,76,6,26,213,63,53,151,
37,128,233,53,238,63,44,61,116,94,125,41,213,63,165,153,53,13,53,51,238,63,38,
46,143,13,243,56,213,63,160,124,153,159,126,48,238,63,248,92,156,88,103,72,213,
63,184,194,126,55,198,45,238,63,12,130,152,62,218,87,213,63,177,15,19,213,11,
43,238,63,53,109,128,190,75,103,213,63,124,40,132,120,79,40,238,63,190,5,81,215,
187,118,213,63,57,243,255,33,145,37,238,63,119,74,7,136,42,134,213,63,44,119,
180,209,208,34,238,63,205,81,160,207,151,149,213,63,194,220,207,135,14,32,238,
63,215,73,25,173,3,165,213,63,137,109,128,68,74,29,238,63,102,120,111,31,110,
180,213,63,47,148,244,7,132,26,238,63,24,59,160,37,215,195,213,63,126,220,90,
210,187,23,238,63,105,7,169,190,62,211,213,63,91,243,225,163,241,20,238,63,195,
106,135,233,164,226,213,63,190,166,184,124,37,18,238,63,143,10,57,165,9,242,213,
63,183,229,13,93,87,15,238,63,71,164,187,240,108,1,214,63,97,192,16,69,135,12,
238,63,132,13,13,203,206,16,214,63,231,103,240,52,181,9,238,63,18,52,43,51,47,
32,214,63,127,46,220,44,225,6,238,63,3,30,20,40,142,47,214,63,100,135,3,45,11,
4,238,63,183,233,197,168,235,62,214,63,214,6,150,53,51,1,238,63,248,205,62,180,
71,78,214,63,20,98,195,70,89,254,237,63,3,26,125,73,162,93,214,63,92,111,187,
96,125,251,237,63,156,53,127,103,251,108,214,63,230,37,174,131,159,248,237,63,
31,161,67,13,83,124,214,63,226,157,203,175,191,245,237,63,142,245,200,57,169,
139,214,63,116,16,68,229,221,242,237,63,168,228,13,236,253,154,214,63,175,215,
71,36,250,239,237,63,242,56,17,35,81,170,214,63,150,110,7,109,20,237,237,63,207,
213,209,221,162,185,214,63,22,113,179,191,44,234,237,63,140,183,78,27,243,200,
214,63,3,156,124,28,67,231,237,63,115,243,134,218,65,216,214,63,23,205,147,131,
87,228,237,63,219,183,121,26,143,231,214,63,234,2,42,245,105,225,237,63,59,76,
38,218,218,246,214,63,245,92,112,113,122,222,237,63,54,17,140,24,37,6,215,63,
137,27,152,248,136,219,237,63,178,128,170,212,109,21,215,63,208,159,210,138,149,
216,237,63,227,45,129,13,181,36,215,63,200,107,81,40,160,213,237,63,97,197,15,
194,250,51,215,63,63,34,70,209,168,210,237,63,52,13,86,241,62,67,215,63,209,134,
226,133,175,207,237,63,232,228,83,154,129,82,215,63,230,125,88,70,180,204,237,
63,157,69,9,188,194,97,215,63,171,12,218,18,183,201,237,63,24,66,118,85,2,113,
215,63,17,89,153,235,183,198,237,63,212,6,155,101,64,128,215,63,203,169,200,208,
182,195,237,63,15,218,119,235,124,143,215,63,73,102,154,194,179,192,237,63,225,
27,13,230,183,158,215,63,179,22,65,193,174,189,237,63,73,70,91,84,241,173,215,
63,234,99,239,204,167,186,237,63,62,237,98,53,41,189,215,63,129,23,216,229,158,
183,237,63,192,190,36,136,95,204,215,63,188,27,46,12,148,180,237,63,234,130,161,
75,148,219,215,63,138,123,36,64,135,177,237,63,2,28,218,126,199,234,215,63,134,
98,238,129,120,174,237,63,134,134,207,32,249,249,215,63,238,28,191,209,103,171,
237,63,67,217,130,48,41,9,216,63,164,23,202,47,85,168,237,63,99,69,245,172,87,
24,216,63,42,224,66,156,64,165,237,63,125,22,40,149,132,39,216,63,156,36,93,23,
42,162,237,63,164,178,28,232,175,54,216,63,177,179,76,161,17,159,237,63,124,154,
212,164,217,69,216,63,178,124,69,58,247,155,237,63,74,105,81,202,1,85,216,63,
125,143,123,226,218,152,237,63,255,212,148,87,40,100,216,63,123,28,35,154,188,
149,237,63,81,174,160,75,77,115,216,63,162,116,112,97,156,146,237,63,196,224,
118,165,112,130,216,63,110,9,152,56,122,143,237,63,194,114,25,100,146,145,216,
63,226,108,206,31,86,140,237,63,164,133,138,134,178,160,216,63,125,81,72,23,48,
137,237,63,201,85,204,11,209,175,216,63,62,138,58,31,8,134,237,63,163,58,225,
242,237,190,216,63,157,10,218,55,222,130,237,63,200,166,203,58,9,206,216,63,137,
230,91,97,178,127,237,63,7,40,142,226,34,221,216,63,97,82,245,155,132,124,237,
63,111,103,43,233,58,236,216,63,247,162,219,231,84,121,237,63,108,41,166,77,81,
251,216,63,133,77,68,69,35,118,237,63,203,77,1,15,102,10,217,63,175,231,100,180,
239,114,237,63,213,207,63,44,121,25,217,63,127,39,115,53,186,111,237,63,90,198,
100,164,138,40,217,63,93,227,164,200,130,108,237,63,195,99,115,118,154,55,217,
63,16,18,48,110,73,105,237,63,34,246,110,161,168,70,217,63,187,202,74,38,14,102,
237,63,67,231,90,36,181,85,217,63,213,68,43,241,208,98,237,63,189,188,58,254,
191,100,217,63,40,216,7,207,145,95,237,63,2,24,18,46,201,115,217,63,208,252,22,
192,80,92,237,63,112,182,228,178,208,130,217,63,50,75,143,196,13,89,237,63,97,
113,182,139,214,145,217,63,252,123,167,220,200,85,237,63,58,62,139,183,218,160,
217,63,34,104,150,8,130,82,237,63,128,46,103,53,221,175,217,63,216,8,147,72,57,
79,237,63,228,111,78,4,222,190,217,63,144,119,212,156,238,75,237,63,86,76,69,
35,221,205,217,63,245,237,145,5,162,72,237,63,21,42,80,145,218,220,217,63,232,
197,2,131,83,69,237,63,189,139,115,77,214,235,217,63,127,121,94,21,3,66,237,63,
93,16,180,86,208,250,217,63,253,162,220,188,176,62,237,63,129,115,22,172,200,
9,218,63,208,252,180,121,92,59,237,63,73,141,159,76,191,24,218,63,144,97,31,76,
6,56,237,63,115,82,84,55,180,39,218,63,246,203,83,52,174,52,237,63,112,212,57,
107,167,54,218,63,222,86,138,50,84,49,237,63,115,65,85,231,152,69,218,63,63,61,
251,70,248,45,237,63,129,228,171,170,136,84,218,63,42,218,222,113,154,42,237,
63,131,37,67,180,118,99,218,63,197,168,109,179,58,39,237,63,83,137,32,3,99,114,
218,63,70,68,224,11,217,35,237,63,210,177,73,150,77,129,218,63,245,103,111,123,
117,32,237,63,242,93,196,108,54,144,218,63,32,239,83,2,16,29,237,63,203,105,150,
133,29,159,218,63,30,213,198,160,168,25,237,63,170,206,197,223,2,174,218,63,71,
53,1,87,63,22,237,63,33,163,88,122,230,188,218,63,243,74,60,37,212,18,237,63,
24,27,85,84,200,203,218,63,118,113,177,11,103,15,237,63,220,135,193,108,168,218,
218,63,25,36,154,10,248,11,237,63,49,88,164,194,134,233,218,63,28,254,47,34,135,
8,237,63,99,24,4,85,99,248,218,63,171,186,172,82,20,5,237,63,83,114,231,34,62,
7,219,63,227,52,74,156,159,1,237,63,138,45,85,43,23,22,219,63,196,103,66,255,
40,254,236,63,75,47,84,109,238,36,219,63,55,110,207,123,176,250,236,63,159,122,
235,231,195,51,219,63,3,131,43,18,54,247,236,63,102,48,34,154,151,66,219,63,206,
0,145,194,185,243,236,63,109,143,255,130,105,81,219,63,21,98,58,141,59,240,236,
63,118,244,138,161,57,96,219,63,44,65,98,114,187,236,236,63,78,218,203,244,7,
111,219,63,56,88,67,114,57,233,236,63,220,217,201,123,212,125,219,63,42,129,24,
141,181,229,236,63,48,170,140,53,159,140,219,63,191,181,28,195,47,226,236,63,
149,32,28,33,104,155,219,63,121,15,139,20,168,222,236,63,160,48,128,61,47,170,
219,63,156,199,158,129,30,219,236,63,65,236,192,137,244,184,219,63,41,55,147,
10,147,215,236,63,211,131,230,4,184,199,219,63,222,214,163,175,5,212,236,63,42,
70,249,173,121,214,219,63,44,63,12,113,118,208,236,63,169,160,1,132,57,229,219,
63,57,40,8,79,229,204,236,63,77,31,8,134,247,243,219,63,216,105,211,73,82,201,
236,63,190,108,21,179,179,2,220,63,135,251,169,97,189,197,236,63,98,82,50,10,
110,17,220,63,107,244,199,150,38,194,236,63,104,184,103,138,38,32,220,63,76,139,
105,233,141,190,236,63,224,165,190,50,221,46,220,63,143,22,203,89,243,186,236,
63,194,64,64,2,146,61,220,63,54,12,41,232,86,183,236,63,7,206,245,247,68,76,220,
63,216,1,192,148,184,179,236,63,179,177,232,18,246,90,220,63,161,172,204,95,24,
176,236,63,229,110,34,82,165,105,220,63,74,225,139,73,118,172,236,63,238,167,
172,180,82,120,220,63,24,148,58,82,210,168,236,63,89,30,145,57,254,134,220,63,
214,216,21,122,44,165,236,63,255,178,217,223,167,149,220,63,210,226,90,193,132,
161,236,63,25,102,144,166,79,164,220,63,218,4,71,40,219,157,236,63,74,87,191,
140,245,178,220,63,55,177,23,175,47,154,236,63,183,197,112,145,153,193,220,63,
167,121,10,86,130,150,236,63,16,16,175,179,59,208,220,63,92,15,93,29,211,146,
236,63,165,180,132,242,219,222,220,63,247,66,77,5,34,143,236,63,115,81,252,76,
122,237,220,63,131,4,25,14,111,139,236,63,54,164,32,194,22,252,220,63,115,99,
254,55,186,135,236,63,121,138,252,80,177,10,221,63,155,142,59,131,3,132,236,63,
164,1,155,248,73,25,221,63,47,212,14,240,74,128,236,63,15,39,7,184,224,39,221,
63,188,161,182,126,144,124,236,63,16,56,76,142,117,54,221,63,38,132,113,47,212,
120,236,63,11,146,117,122,8,69,221,63,164,39,126,2,22,117,236,63,131,178,142,
123,153,83,221,63,185,87,27,248,85,113,236,63,42,55,163,144,40,98,221,63,54,255,
135,16,148,109,236,63,241,221,190,184,181,112,221,63,45,40,3,76,208,105,236,63,
24,133,237,242,64,127,221,63,245,251,203,170,10,102,236,63,59,43,59,62,202,141,
221,63,35,195,33,45,67,98,236,63,104,239,179,153,81,156,221,63,131,229,67,211,
121,94,236,63,41,17,100,4,215,170,221,63,23,234,113,157,174,90,236,63,154,240,
87,125,90,185,221,63,21,119,235,139,225,86,236,63,114,14,156,3,220,199,221,63,
221,81,240,158,18,83,236,63,25,12,61,150,91,214,221,63,248,94,192,214,65,79,236,
63,180,171,71,52,217,228,221,63,20,162,155,51,111,75,236,63,56,208,200,220,84,
243,221,63,1,62,194,181,154,71,236,63,119,125,205,142,206,1,222,63,170,116,116,
93,196,67,236,63,49,216,98,73,70,16,222,63,17,167,242,42,236,63,236,63,38,38,
150,11,188,30,222,63,78,85,125,30,18,60,236,63,36,206,116,212,47,45,222,63,134,
30,85,56,54,56,236,63,20,88,12,163,161,59,222,63,236,192,186,120,88,52,236,63,
18,109,106,118,17,74,222,63,184,25,239,223,120,48,236,63,115,215,156,77,127,88,
222,63,39,37,51,110,151,44,236,63,220,130,177,39,235,102,222,63,113,254,199,35,
180,40,236,63,79,124,182,3,85,117,222,63,205,223,238,0,207,36,236,63,61,242,185,
224,188,131,222,63,101,34,233,5,232,32,236,63,146,52,202,189,34,146,222,63,85,
62,248,50,255,28,236,63,200,180,245,153,134,160,222,63,167,202,93,136,20,25,236,
63,245,5,75,116,232,174,222,63,78,125,91,6,40,21,236,63,223,220,216,75,72,189,
222,63,35,43,51,173,57,17,236,63,4,16,174,31,166,203,222,63,221,199,38,125,73,
13,236,63,178,151,217,238,1,218,222,63,18,102,120,118,87,9,236,63,18,142,106,
184,91,232,222,63,47,55,106,153,99,5,236,63,55,47,112,123,179,246,222,63,115,
139,62,230,109,1,236,63,51,217,249,54,9,5,223,63,238,209,55,93,118,253,235,63,
33,12,23,234,92,19,223,63,122,152,152,254,124,249,235,63,57,106,215,147,174,33,
223,63,185,139,163,202,129,245,235,63,220,183,74,51,254,47,223,63,13,119,155,
193,132,241,235,63,169,219,128,199,75,62,223,63,151,68,195,227,133,237,235,63,
133,222,137,79,151,76,223,63,50,253,93,49,133,233,235,63,180,235,117,202,224,
90,223,63,108,200,174,170,130,229,235,63,224,80,85,55,40,105,223,63,132,236,248,
79,126,225,235,63,47,126,56,149,109,119,223,63,104,206,127,33,120,221,235,63,
79,6,48,227,176,133,223,63,171,241,134,31,112,217,235,63,136,158,76,32,242,147,
223,63,131,248,81,74,102,213,235,63,203,30,159,75,49,162,223,63,198,163,36,162,
90,209,235,63,192,129,56,100,110,176,223,63,229,210,66,39,77,205,235,63,216,228,
41,105,169,190,223,63,230,131,240,217,61,201,235,63,91,136,132,89,226,204,223,
63,98,211,113,186,44,197,235,63,122,207,89,52,25,219,223,63,124,252,10,201,25,
193,235,63,90,64,187,248,77,233,223,63,226,88,0,6,5,189,235,63,43,132,186,165,
128,247,223,63,199,96,150,113,238,184,235,63,152,179,52,157,216,2,224,63,220,
170,17,12,214,180,235,63,104,236,236,218,239,9,224,63,77,236,182,213,187,176,
235,63,215,245,142,11,6,17,224,63,189,248,202,206,159,172,235,63,213,234,163,
46,27,24,224,63,66,194,146,247,129,168,235,63,1,248,180,67,47,31,224,63,95,89,
83,80,98,164,235,63,167,91,75,74,66,38,224,63,255,236,81,217,64,160,235,63,208,
101,240,65,84,45,224,63,116,202,211,146,29,156,235,63,71,120,45,42,101,52,224,
63,110,93,30,125,248,151,235,63,158,6,140,2,117,59,224,63,250,47,119,152,209,
147,235,63,59,150,149,202,131,66,224,63,121,234,35,229,168,143,235,63,91,190,
211,129,145,73,224,63,162,83,106,99,126,139,235,63,28,40,208,39,158,80,224,63,
121,80,144,19,82,135,235,63,134,142,20,188,169,87,224,63,72,228,219,245,35,131,
235,63,143,190,42,62,180,94,224,63,162,48,147,10,244,126,235,63,39,151,156,173,
189,101,224,63,86,117,252,81,194,122,235,63,60,9,244,9,198,108,224,63,115,16,
94,204,142,118,235,63,196,23,187,82,205,115,224,63,58,126,254,121,89,114,235,
63,198,215,123,135,211,122,224,63,34,89,36,91,34,110,235,63,93,112,192,167,216,
129,224,63,204,89,22,112,233,105,235,63,196,26,19,179,220,136,224,63,6,87,27,
185,174,101,235,63,94,34,254,168,223,143,224,63,191,69,122,54,114,97,235,63,184,
228,11,137,225,150,224,63,7,57,122,232,51,93,235,63,154,209,198,82,226,157,224,
63,8,98,98,207,243,88,235,63,5,107,185,5,226,164,224,63,4,16,122,235,177,84,235,
63,65,69,110,161,224,171,224,63,77,176,8,61,110,80,235,63,228,6,112,37,222,178,
224,63,68,206,85,196,40,76,235,63,214,104,73,145,218,185,224,63,79,19,169,129,
225,71,235,63,94,54,133,228,213,192,224,63,218,70,74,117,152,67,235,63,37,77,
174,30,208,199,224,63,80,78,129,159,77,63,235,63,65,157,79,63,201,206,224,63,
20,45,150,0,1,59,235,63,57,41,244,69,193,213,224,63,129,4,209,152,178,54,235,
63,18,6,39,50,184,220,224,63,225,19,122,104,98,50,235,63,81,91,115,3,174,227,
224,63,108,184,217,111,16,46,235,63,8,99,100,185,162,234,224,63,61,109,56,175,
188,41,235,63,216,105,133,83,150,241,224,63,86,203,222,38,103,37,235,63,253,206,
97,209,136,248,224,63,149,137,21,215,15,33,235,63,85,4,133,50,122,255,224,63,
176,124,37,192,182,28,235,63,102,142,122,118,106,6,225,63,51,151,87,226,91,24,
235,63,102,4,206,156,89,13,225,63,120,233,244,61,255,19,235,63,67,16,11,165,71,
20,225,63,163,161,70,211,160,15,235,63,174,110,189,142,52,27,225,63,160,11,150,
162,64,11,235,63,26,239,112,89,32,34,225,63,27,145,44,172,222,6,235,63,205,115,
177,4,11,41,225,63,123,185,83,240,122,2,235,63,226,241,10,144,244,47,225,63,225,
41,85,111,21,254,234,63,84,113,9,251,220,54,225,63,30,165,122,41,174,249,234,
63,1,13,57,69,196,61,225,63,177,11,14,31,69,245,234,63,181,242,37,110,170,68,
225,63,195,91,89,80,218,240,234,63,52,99,92,117,143,75,225,63,34,177,166,189,
109,236,234,63,59,178,104,90,115,82,225,63,56,69,64,103,255,231,234,63,141,70,
215,28,86,89,225,63,12,111,112,77,143,227,234,63,247,153,52,188,55,96,225,63,
57,163,129,112,29,223,234,63,92,57,13,56,24,103,225,63,235,115,190,208,169,218,
234,63,184,196,237,143,247,109,225,63,218,144,113,110,52,214,234,63,41,239,98,
195,213,116,225,63,69,199,229,73,189,209,234,63,249,126,249,209,178,123,225,63,
236,1,102,99,68,205,234,63,162,77,62,187,142,130,225,63,11,73,61,187,201,200,
234,63,215,71,190,126,105,137,225,63,89,194,182,81,77,196,234,63,140,109,6,28,
67,144,225,63,254,176,29,39,207,191,234,63,254,209,163,146,27,151,225,63,144,
117,189,59,79,187,234,63,184,155,35,226,242,157,225,63,16,142,225,143,205,182,
234,63,158,4,19,10,201,164,225,63,226,149,213,35,74,178,234,63,241,89,255,9,158,
171,225,63,201,69,229,247,196,173,234,63,90,252,117,225,113,178,225,63,227,115,
92,12,62,169,234,63,238,95,4,144,68,185,225,63,163,19,135,97,181,164,234,63,56,
12,56,21,22,192,225,63,205,53,177,247,42,160,234,63,65,156,158,112,230,198,225,
63,113,8,39,207,158,155,234,63,149,190,197,161,181,205,225,63,228,214,52,232,
16,151,234,63,75,53,59,168,131,212,225,63,190,9,39,67,129,146,234,63,16,214,140,
131,80,219,225,63,208,38,74,224,239,141,234,63,40,138,72,51,28,226,225,63,40,
209,234,191,92,137,234,63,124,78,252,182,230,232,225,63,2,201,85,226,199,132,
234,63,158,51,54,14,176,239,225,63,201,235,215,71,49,128,234,63,209,93,132,56,
120,246,225,63,15,52,190,240,152,123,234,63,16,5,117,53,63,253,225,63,141,185,
85,221,254,118,234,63,24,117,150,4,5,4,226,63,21,177,235,13,99,114,234,63,107,
13,119,165,201,10,226,63,150,108,205,130,197,109,234,63,92,65,165,23,141,17,226,
63,19,91,72,60,38,105,234,63,19,152,175,90,79,24,226,63,155,8,170,58,133,100,
234,63,151,172,36,110,16,31,226,63,74,30,64,126,226,95,234,63,211,45,147,81,208,
37,226,63,64,98,88,7,62,91,234,63,160,222,137,4,143,44,226,63,157,183,64,214,
151,86,234,63,203,149,151,134,76,51,226,63,122,30,71,235,239,81,234,63,27,62,
75,215,8,58,226,63,231,179,185,70,70,77,234,63,92,214,51,246,195,64,226,63,230,
177,230,232,154,72,234,63,98,113,224,226,125,71,226,63,97,111,28,210,237,67,234,
63,22,54,224,156,54,78,226,63,42,96,169,2,63,63,234,63,119,95,194,35,238,84,226,
63,244,20,220,122,142,58,234,63,166,60,22,119,164,91,226,63,78,59,3,59,220,53,
234,63,237,48,107,150,89,98,226,63,157,157,109,67,40,49,234,63,195,179,80,129,
13,105,226,63,25,35,106,148,114,44,234,63,215,80,86,55,192,111,226,63,196,207,
71,46,187,39,234,63,21,168,11,184,113,118,226,63,105,196,85,17,2,35,234,63,177,
109,0,3,34,125,226,63,149,62,227,61,71,30,234,63,41,106,196,23,209,131,226,63,
145,152,63,180,138,25,234,63,80,122,231,245,126,138,226,63,95,73,186,116,204,
20,234,63,85,143,249,156,43,145,226,63,177,228,162,127,12,16,234,63,202,174,138,
12,215,151,226,63,234,26,73,213,74,11,234,63,170,242,42,68,129,158,226,63,17,
185,252,117,135,6,234,63,98,137,106,67,42,165,226,63,211,168,13,98,194,1,234,
63,217,181,217,9,210,171,226,63,119,240,203,153,251,252,233,63,116,207,8,151,
120,178,226,63,224,178,135,29,51,248,233,63,33,66,136,234,29,185,226,63,130,47,
145,237,104,243,233,63,92,142,232,3,194,191,226,63,96,194,56,10,157,238,233,63,
56,73,186,226,100,198,226,63,2,228,206,115,207,233,233,63,101,28,142,134,6,205,
226,63,121,41,164,42,0,229,233,63,55,198,244,238,166,211,226,63,79,68,9,47,47,
224,233,63,175,25,127,27,70,218,226,63,137,2,79,129,92,219,233,63,129,254,189,
11,228,224,226,63,158,78,198,33,136,214,233,63,26,113,66,191,128,231,226,63,118,
47,192,16,178,209,233,63,171,130,157,53,28,238,226,63,94,200,141,78,218,204,233,
63,46,89,96,110,182,244,226,63,8,89,128,219,0,200,233,63,107,47,28,105,79,251,
226,63,134,61,233,183,37,195,233,63,5,85,98,37,231,1,227,63,63,238,25,228,72,
190,233,63,122,46,196,162,125,8,227,63,240,255,99,96,106,185,233,63,50,53,211,
224,18,15,227,63,164,35,25,45,138,180,233,63,127,247,32,223,166,21,227,63,174,
38,139,74,168,175,233,63,171,24,63,157,57,28,227,63,165,242,11,185,196,170,233,
63,248,80,191,26,203,34,227,63,93,141,237,120,223,165,233,63,174,109,51,87,91,
41,227,63,228,24,130,138,248,160,233,63,31,81,45,82,234,47,227,63,123,211,27,
238,15,156,233,63,172,242,62,11,120,54,227,63,143,23,13,164,37,151,233,63,210,
94,250,129,4,61,227,63,183,91,168,172,57,146,233,63,44,183,241,181,143,67,227,
63,174,50,64,8,76,141,233,63,124,50,183,166,25,74,227,63,76,75,39,183,92,136,
233,63,179,28,221,83,162,80,227,63,127,112,176,185,107,131,233,63,249,214,245,
188,41,87,227,63,75,137,46,16,121,126,233,63,174,215,147,225,175,93,227,63,191,
152,244,186,132,121,233,63,124,170,73,193,52,100,227,63,244,189,85,186,142,116,
233,63,83,240,169,91,184,106,227,63,4,52,165,14,151,111,233,63,119,95,71,176,
58,113,227,63,6,82,54,184,157,106,233,63,134,195,180,190,187,119,227,63,10,139,
92,183,162,101,233,63,127,253,132,134,59,126,227,63,16,110,107,12,166,96,233,
63,198,3,75,7,186,132,227,63,7,166,182,183,167,91,233,63,48,226,153,64,55,139,
227,63,195,249,145,185,167,86,233,63,8,186,4,50,179,145,227,63,250,75,81,18,166,
81,233,63,21,194,30,219,45,152,227,63,64,155,72,194,162,76,233,63,163,70,123,
59,167,158,227,63,253,1,204,201,157,71,233,63,137,169,173,82,31,165,227,63,109,
182,47,41,151,66,233,63,49,98,73,32,150,171,227,63,149,10,200,224,142,61,233,
63,158,253,225,163,11,178,227,63,66,108,233,240,132,56,233,63,115,30,11,221,127,
184,227,63,255,100,232,89,121,51,233,63,252,124,88,203,242,190,227,63,22,154,
25,28,108,46,233,63,52,231,93,110,100,197,227,63,130,204,209,55,93,41,233,63,
203,64,175,197,212,203,227,63,242,216,101,173,76,36,233,63,47,131,224,208,67,
210,227,63,188,183,42,125,58,31,233,63,145,189,133,143,177,216,227,63,222,124,
117,167,38,26,233,63,239,20,51,1,30,223,227,63,242,87,155,44,17,21,233,63,23,
196,124,37,137,229,227,63,45,148,241,12,250,15,233,63,178,27,247,251,242,235,
227,63,90,152,205,72,225,10,233,63,73,130,54,132,91,242,227,63,206,230,132,224,
198,5,233,63,77,116,207,189,194,248,227,63,107,29,109,212,170,0,233,63,27,132,
86,168,40,255,227,63,149,245,219,36,141,251,232,63,9,90,96,67,141,5,228,63,44,
68,39,210,109,246,232,63,103,180,129,142,240,11,228,63,138,249,164,220,76,241,
232,63,139,103,79,137,82,18,228,63,122,33,171,68,42,236,232,63,211,93,94,51,179,
24,228,63,53,227,143,10,6,231,232,63,176,151,67,140,18,31,228,63,90,129,169,46,
224,225,232,63,171,43,148,147,112,37,228,63,234,89,78,177,184,220,232,63,111,
70,229,72,205,43,228,63,65,230,212,146,143,215,232,63,202,42,204,171,40,50,228,
63,18,187,147,211,100,210,232,63,186,49,222,187,130,56,228,63,97,136,225,115,
56,205,232,63,114,202,176,120,219,62,228,63,121,25,21,116,10,200,232,63,94,122,
217,225,50,69,228,63,239,84,133,212,218,194,232,63,48,221,237,246,136,75,228,
63,149,60,137,149,169,189,232,63,225,164,131,183,221,81,228,63,118,237,119,183,
118,184,232,63,189,153,48,35,49,88,228,63,211,159,168,58,66,179,232,63,100,154,
138,57,131,94,228,63,24,167,114,31,12,174,232,63,216,155,39,250,211,100,228,63,
220,113,45,102,212,168,232,63,126,169,157,100,35,107,228,63,217,137,48,15,155,
163,232,63,41,229,130,120,113,113,228,63,229,147,211,26,96,158,232,63,30,135,
109,53,190,119,228,63,237,79,110,137,35,153,232,63,29,222,243,154,9,126,228,63,
241,152,88,91,229,147,232,63,103,79,172,168,83,132,228,63,250,100,234,144,165,
142,232,63,197,86,45,94,156,138,228,63,27,197,123,42,100,137,232,63,143,134,13,
187,227,144,228,63,100,229,100,40,33,132,232,63,179,135,227,190,41,151,228,63,
224,12,254,138,220,126,232,63,188,25,70,105,110,157,228,63,143,157,159,82,150,
121,232,63,216,18,204,185,177,163,228,63,98,20,162,127,78,116,232,63,224,95,12,
176,243,169,228,63,47,9,94,18,5,111,232,63,95,4,158,75,52,176,228,63,179,46,44,
11,186,105,232,63,151,26,24,140,115,182,228,63,135,82,101,106,109,100,232,63,
140,211,17,113,177,188,228,63,26,93,98,48,31,95,232,63,4,119,34,250,237,194,228,
63,175,81,124,93,207,89,232,63,149,99,225,38,41,201,228,63,85,78,12,242,125,84,
232,63,169,14,230,246,98,207,228,63,224,139,107,238,42,79,232,63,131,4,200,105,
155,213,228,63,229,93,243,82,214,73,232,63,71,232,30,127,210,219,228,63,179,50,
253,31,128,68,232,63,5,116,130,54,8,226,228,63,78,147,226,85,40,63,232,63,183,
120,138,143,60,232,228,63,104,35,253,244,206,57,232,63,82,222,206,137,111,238,
228,63,94,161,166,253,115,52,232,63,198,163,231,36,161,244,228,63,44,230,56,112,
23,47,232,63,4,223,108,96,209,250,228,63,112,229,13,77,185,41,232,63,11,189,246,
59,0,1,229,63,90,173,127,148,89,36,232,63,235,129,29,183,45,7,229,63,176,102,
232,70,248,30,232,63,201,136,121,209,89,13,229,63,192,84,162,100,149,25,232,63,
237,67,163,138,132,19,229,63,96,213,7,238,48,20,232,63,194,60,51,226,173,25,229,
63,226,96,115,227,202,14,232,63,224,19,194,215,213,31,229,63,22,138,63,69,99,
9,232,63,18,129,232,106,252,37,229,63,60,254,198,19,250,3,232,63,93,83,63,155,
33,44,229,63,4,133,100,79,143,254,231,63,8,113,95,104,69,50,229,63,132,0,115,
248,34,249,231,63,161,215,225,209,103,56,229,63,54,109,77,15,181,243,231,63,1,
156,95,215,136,62,229,63,239,225,78,148,69,238,231,63,92,234,113,120,168,68,229,
63,215,143,210,135,212,232,231,63,60,6,178,180,198,74,229,63,107,194,51,234,97,
227,231,63,146,74,185,139,227,80,229,63,111,223,205,187,237,221,231,63,180,41,
33,253,254,86,229,63,233,102,252,252,119,216,231,63,108,45,131,8,25,93,229,63,
34,243,26,174,0,211,231,63,248,246,120,173,49,99,229,63,151,56,133,207,135,205,
231,63,19,63,156,235,72,105,229,63,248,5,151,97,13,200,231,63,254,213,134,194,
94,111,229,63,33,68,172,100,145,194,231,63,132,163,210,49,115,117,229,63,20,246,
32,217,19,189,231,63,1,167,25,57,134,123,229,63,242,56,81,191,148,183,231,63,
104,247,245,215,151,129,229,63,248,67,153,23,20,178,231,63,78,195,1,14,168,135,
229,63,116,104,85,226,145,172,231,63,235,80,215,218,182,141,229,63,196,17,226,
31,14,167,231,63,36,254,16,62,196,147,229,63,75,197,155,208,136,161,231,63,143,
64,73,55,208,153,229,63,114,34,223,244,1,156,231,63,127,165,26,198,218,159,229,
63,152,226,8,141,121,150,231,63,3,210,31,234,227,165,229,63,22,217,117,153,239,
144,231,63,244,130,243,162,235,171,229,63,50,243,130,26,100,139,231,63,247,140,
48,240,241,177,229,63,29,56,141,16,215,133,231,63,133,220,113,209,246,183,229,
63,232,200,241,123,72,128,231,63,242,117,82,70,250,189,229,63,134,224,13,93,184,
122,231,63,115,117,109,78,252,195,229,63,187,211,62,180,38,117,231,63,36,15,94,
233,252,201,229,63,34,17,226,129,147,111,231,63,17,143,191,22,252,207,229,63,
27,33,85,198,254,105,231,63,59,89,45,214,249,213,229,63,208,165,245,129,104,100,
231,63,157,233,66,39,246,219,229,63,37,91,33,181,208,94,231,63,53,212,155,9,241,
225,229,63,185,22,54,96,55,89,231,63,12,197,211,124,234,231,229,63,220,199,145,
131,156,83,231,63,54,128,134,128,226,237,229,63,139,119,146,31,0,78,231,63,226,
225,79,20,217,243,229,63,103,72,150,52,98,72,231,63,87,222,203,55,206,249,229,
63,179,118,251,194,194,66,231,63,2,130,150,234,193,255,229,63,73,88,32,203,33,
61,231,63,121,241,75,44,180,5,230,63,154,92,99,77,127,55,231,63,129,105,136,252,
164,11,230,63,159,12,35,74,219,49,231,63,23,63,232,90,148,17,230,63,221,10,190,
193,53,44,231,63,118,223,7,71,130,23,230,63,87,19,147,180,142,38,231,63,26,208,
131,192,110,29,230,63,139,251,0,35,230,32,231,63,203,174,248,198,89,35,230,63,
107,178,102,13,60,27,231,63,163,49,3,90,67,41,230,63,88,64,35,116,144,21,231,
63,18,39,64,121,43,47,230,63,26,199,149,87,227,15,231,63,229,117,76,36,18,53,
230,63,220,129,29,184,52,10,231,63,78,29,197,90,247,58,230,63,33,197,25,150,132,
4,231,63,235,52,71,28,219,64,230,63,198,254,233,241,210,254,230,63,202,236,111,
104,189,70,230,63,244,181,237,203,31,249,230,63,113,141,220,62,158,76,230,63,
28,139,132,36,107,243,230,63,228,119,42,159,125,82,230,63,243,55,14,252,180,237,
230,63,172,37,247,136,91,88,230,63,106,143,234,82,253,231,230,63,222,40,224,251,
55,94,230,63,166,125,121,41,68,226,230,63,31,44,131,247,18,100,230,63,254,7,27,
128,137,220,230,63,173,242,125,123,236,105,230,63,241,76,47,87,205,214,230,63,
99,88,110,135,196,111,230,63,32,132,22,175,15,209,230,63,196,81,242,26,155,117,
230,63,75,254,48,136,80,203,230,63,252,235,167,53,112,123,230,63,70,37,223,226,
143,197,230,63,232,76,45,215,67,129,230,63,247,123,129,191,205,191,230,63,32,
179,32,255,21,135,230,63,75,158,120,30,10,186,230,63,248,117,32,173,230,140,230,
63,53,65,37,0,69,180,230,63,139,5,203,224,181,146,230,63,164,50,232,100,126,174,
230,63,189,234,190,153,131,152,230,63,125,89,34,77,182,168,230,63,70,199,154,
215,79,158,230,63,150,181,52,185,236,162,230,63,182,85,253,153,26,164,230,63,
176,95,128,169,33,157,230,63,121,105,133,224,227,169,230,63,109,137,102,30,85,
151,230,63,226,238,209,170,171,175,230,63,78,125,72,24,135,145,230,63,48,235,
129,248,113,181,230,63,171,158,135,151,183,139,230,63,146,124,52,201,54,187,230,
63,171,105,133,156,230,133,230,63,47,218,136,28,250,192,230,63,66,115,163,39,
20,128,230,63,45,84,30,242,187,198,230,63,36,105,67,57,64,122,230,63,182,83,148,
73,124,204,230,63,196,17,199,209,106,116,230,63,0,91,138,34,59,210,230,63,76,
76,144,241,147,110,230,63,81,5,160,124,248,215,230,63,151,16,1,153,187,104,230,
63,8,7,117,87,180,221,230,63,41,111,123,200,225,98,230,63,160,45,169,178,110,
227,230,63,41,145,97,128,6,93,230,63,186,95,220,141,39,233,230,63,94,184,21,193,
41,87,230,63,33,157,174,232,222,238,230,63,34,63,250,138,75,81,230,63,208,254,
191,194,148,244,230,63,97,152,113,222,107,75,230,63,251,182,176,27,73,250,230,
63,147,79,222,187,138,69,230,63,17,17,33,243,251,255,230,63,176,8,163,35,168,
63,230,63,197,113,177,72,173,5,231,63,46,128,34,22,196,57,230,63,22,87,2,28,93,
11,231,63,250,138,191,147,222,51,230,63,82,88,180,108,11,17,231,63,112,22,221,
156,247,45,230,63,28,38,104,58,184,22,231,63,87,40,222,49,15,40,230,63,118,138,
190,132,99,28,231,63,216,222,37,83,37,34,230,63,195,104,88,75,13,34,231,63,121,
112,23,1,58,28,230,63,208,189,214,141,181,39,231,63,20,44,22,60,77,22,230,63,
218,159,218,75,92,45,231,63,214,120,133,4,95,16,230,63,147,62,5,133,1,51,231,
63,49,214,200,90,111,10,230,63,39,227,247,56,165,56,231,63,221,219,67,63,126,
4,230,63,71,240,83,103,71,62,231,63,205,57,90,178,139,254,229,63,44,226,186,15,
232,67,231,63,39,184,111,180,151,248,229,63,154,78,206,49,135,73,231,63,66,55,
232,69,162,242,229,63,236,228,47,205,36,79,231,63,158,175,39,103,171,236,229,
63,26,110,129,225,192,84,231,63,219,49,146,24,179,230,229,63,184,204,100,110,
91,90,231,63,181,230,139,90,185,224,229,63,6,253,123,115,244,95,231,63,253,14,
121,45,190,218,229,63,237,20,105,240,139,101,231,63,145,3,190,145,193,212,229,
63,12,68,206,228,33,107,231,63,87,53,191,135,195,206,229,63,187,211,77,80,182,
112,231,63,54,45,225,15,196,200,229,63,18,39,138,50,73,118,231,63,15,140,136,
42,195,194,229,63,239,186,37,139,218,123,231,63,185,10,26,216,192,188,229,63,
251,37,195,89,106,129,231,63,243,121,250,24,189,182,229,63,177,24,5,158,248,134,
231,63,105,194,142,237,183,176,229,63,101,93,142,87,133,140,231,63,160,228,59,
86,177,170,229,63,74,216,1,134,16,146,231,63,253,248,102,83,169,164,229,63,118,
135,2,41,154,151,231,63,178,47,117,229,159,158,229,63,234,130,51,64,34,157,231,
63,193,208,203,12,149,152,229,63,153,252,55,203,168,162,231,63,240,59,208,201,
136,146,229,63,105,64,179,201,45,168,231,63,194,232,231,28,123,140,229,63,66,
180,72,59,177,173,231,63,118,102,120,6,108,134,229,63,10,216,155,31,51,179,231,
63,248,91,231,134,91,128,229,63,178,69,80,118,179,184,231,63,225,135,154,158,
73,122,229,63,59,177,9,63,50,190,231,63,112,192,247,77,54,116,229,63,185,232,
107,121,175,195,231,63,125,243,100,149,33,110,229,63,93,212,26,37,43,201,231,
63,123,38,72,117,11,104,229,63,119,118,186,65,165,206,231,63,107,118,7,238,243,
97,229,63,127,235,238,206,29,212,231,63,215,23,9,0,219,91,229,63,27,106,92,204,
148,217,231,63,204,86,179,171,192,85,229,63,35,67,167,57,10,223,231,63,212,150,
108,241,164,79,229,63,169,225,115,22,126,228,231,63,238,82,155,209,135,73,229,
63,253,202,102,98,240,233,231,63,133,29,166,76,105,67,229,63,181,158,36,29,97,
239,231,63,112,160,243,98,73,61,229,63,179,22,82,70,208,244,231,63,229,156,234,
20,40,55,229,63,40,7,148,221,61,250,231,63,114,235,241,98,5,49,229,63,157,94,
143,226,169,255,231,63,254,123,112,77,225,42,229,63,250,37,233,84,20,5,232,63,
183,85,205,212,187,36,229,63,135,128,70,52,125,10,232,63,22,151,111,249,148,30,
229,63,246,171,76,128,228,15,232,63,209,117,190,187,108,24,229,63,106,0,161,56,
74,21,232,63,214,62,33,28,67,18,229,63,119,240,232,92,174,26,232,63,71,86,255,
26,24,12,229,63,48,9,202,236,16,32,232,63,110,55,192,184,235,5,229,63,37,242,
233,231,113,37,232,63,189,116,203,245,189,255,228,63,111,109,238,77,209,42,232,
63,192,183,136,210,142,249,228,63,178,87,125,30,47,48,232,63,29,193,95,79,94,
243,228,63,39,168,60,89,139,53,232,63,134,104,184,108,44,237,228,63,157,112,210,
253,229,58,232,63,186,156,250,42,249,230,228,63,130,221,228,11,63,64,232,63,119,
99,142,138,196,224,228,63,232,53,26,131,150,69,232,63,121,217,219,139,142,218,
228,63,139,219,24,99,236,74,232,63,112,50,75,47,87,212,228,63,216,74,135,171,
64,80,232,63,248,184,68,117,30,206,228,63,240,26,12,92,147,85,232,63,150,206,
48,94,228,199,228,63,177,253,77,116,228,90,232,63,174,235,119,234,168,193,228,
63,186,191,243,243,51,96,232,63,127,159,130,26,108,187,228,63,113,72,164,218,
129,101,232,63,24,144,185,238,45,181,228,63,10,154,6,40,206,106,232,63,86,122,
133,103,238,174,228,63,139,209,193,219,24,112,232,63,216,49,79,133,173,168,228,
63,212,38,125,245,97,117,232,63,253,160,127,72,107,162,228,63,163,236,223,116,
169,122,232,63,219,200,127,177,39,156,228,63,154,144,145,89,239,127,232,63,54,
193,184,192,226,149,228,63,69,155,57,163,51,133,232,63,125,184,147,118,156,143,
228,63,35,176,127,81,118,138,232,63,193,243,121,211,84,137,228,63,166,141,11,
100,183,143,232,63,175,206,212,215,11,131,228,63,59,13,133,218,246,148,232,63,
134,187,13,132,193,124,228,63,82,35,148,180,52,154,232,63,22,67,142,216,117,118,
228,63,99,223,224,241,112,159,232,63,179,4,192,213,40,112,228,63,242,107,19,146,
171,164,232,63,51,182,12,124,218,105,228,63,148,14,212,148,228,169,232,63,225,
35,222,203,138,99,228,63,249,39,203,249,27,175,232,63,127,48,158,197,57,93,228,
63,238,51,161,192,81,180,232,63,55,213,182,105,231,86,228,63,101,201,254,232,
133,185,232,63,150,33,146,184,147,80,228,63,119,154,140,114,184,190,232,63,136,
59,154,178,62,74,228,63,112,116,243,92,233,195,232,63,79,95,57,88,232,67,228,
63,206,63,220,167,24,201,232,63,124,223,217,169,144,61,228,63,77,0,240,82,70,
206,232,63,231,36,230,167,55,55,228,63,229,212,215,93,114,211,232,63,171,174,
200,82,221,48,228,63,217,247,60,200,156,216,232,63,27,18,236,170,129,42,228,63,
180,190,200,145,197,221,232,63,191,250,186,176,36,36,228,63,86,154,36,186,236,
226,232,63,75,42,160,100,198,29,228,63,243,22,250,64,18,232,232,63,152,120,6,
199,102,23,228,63,30,220,242,37,54,237,232,63,156,211,88,216,5,17,228,63,203,
172,184,104,88,242,232,63,103,63,2,153,163,10,228,63,89,103,245,8,121,247,232,
63,23,214,109,9,64,4,228,63,147,5,83,6,152,252,232,63,211,199,6,42,219,253,227,
63,182,156,123,96,181,1,233,63,198,90,56,251,116,247,227,63,122,93,25,23,209,
6,233,63,21,235,109,125,13,241,227,63,22,148,214,41,235,11,233,63,217,234,18,
177,164,234,227,63,69,168,93,152,3,17,233,63,24,226,146,150,58,228,227,63,75,
29,89,98,26,22,233,63,190,110,89,46,207,221,227,63,252,145,115,135,47,27,233,
63,152,68,210,120,98,215,227,63,195,192,87,7,67,32,233,63,72,45,105,118,244,208,
227,63,164,127,176,225,84,37,233,63,66,8,138,39,133,202,227,63,66,192,40,22,101,
42,233,63,196,202,160,140,20,196,227,63,234,143,107,164,115,47,233,63,206,127,
25,166,162,189,227,63,144,23,36,140,128,52,233,63,28,72,96,116,47,183,227,63,
219,155,253,204,139,57,233,63,32,90,225,247,186,176,227,63,43,125,163,102,149,
62,233,63,247,1,9,49,69,170,227,63,151,55,193,88,157,67,233,63,102,161,67,32,
206,163,227,63,253,98,2,163,163,72,233,63,208,175,253,197,85,157,227,63,254,178,
18,69,168,77,233,63,49,186,163,34,220,150,227,63,10,247,157,62,171,82,233,63,
22,99,162,54,97,144,227,63,99,26,80,143,172,87,233,63,149,98,102,2,229,137,227,
63,34,36,213,54,172,92,233,63,73,134,92,134,103,131,227,63,63,55,217,52,170,97,
233,63,69,177,241,194,232,124,227,63,145,146,8,137,166,102,233,63,21,220,146,
184,104,118,227,63,221,144,15,51,161,107,233,63,174,20,173,103,231,111,227,63,
208,168,154,50,154,112,233,63,109,126,173,208,100,105,227,63,14,109,86,135,145,
117,233,63,16,82,1,244,224,98,227,63,50,140,239,48,135,122,233,63,171,221,21,
210,91,92,227,63,214,208,18,47,123,127,233,63,161,132,88,107,213,85,227,63,150,
33,109,129,109,132,233,63,163,191,54,192,77,79,227,63,26,129,171,39,94,137,233,
63,159,28,30,209,196,72,227,63,21,14,123,33,77,142,233,63,196,62,124,158,58,66,
227,63,81,3,137,110,58,147,233,63,112,222,190,40,175,59,227,63,175,183,130,14,
38,152,233,63,49,201,83,112,34,53,227,63,48,158,21,1,16,157,233,63,185,225,168,
117,148,46,227,63,249,69,239,69,248,161,233,63,218,31,44,57,5,40,227,63,87,90,
189,220,222,166,233,63,123,144,75,187,116,33,227,63,202,162,45,197,195,171,233,
63,149,85,117,252,226,26,227,63,2,3,238,254,166,176,233,63,42,166,23,253,79,20,
227,63,234,122,172,137,136,181,233,63,59,206,160,189,187,13,227,63,174,38,23,
101,104,186,233,63,198,46,127,62,38,7,227,63,189,62,220,144,70,191,233,63,188,
61,33,128,143,0,227,63,206,23,170,12,35,196,233,63,247,133,245,130,247,249,226,
63,235,34,47,216,253,200,233,63,58,167,106,71,94,243,226,63,111,237,25,243,214,
205,233,63,34,86,239,205,195,236,226,63,18,33,25,93,174,210,233,63,35,92,242,
22,40,230,226,63,232,131,219,21,132,215,233,63,128,151,226,34,139,223,226,63,
109,248,15,29,88,220,233,63,69,251,46,242,236,216,226,63,132,125,101,114,42,225,
233,63,60,143,70,133,77,210,226,63,127,46,139,21,251,229,233,63,233,111,152,220,
172,203,226,63,40,67,48,6,202,234,233,63,131,206,147,248,10,197,226,63,190,15,
4,68,151,239,233,63,233,240,167,217,103,190,226,63,3,5,182,206,98,244,233,63,
159,49,68,128,195,183,226,63,59,176,245,165,44,249,233,63,198,255,215,236,29,
177,226,63,52,187,114,201,244,253,233,63,16,223,210,31,119,170,226,63,76,236,
220,56,187,2,234,63,192,103,164,25,207,163,226,63,115,38,228,243,127,7,234,63,
156,70,188,218,37,157,226,63,52,105,56,250,66,12,234,63,235,60,138,99,123,150,
226,63,184,208,137,75,4,17,234,63,106,32,126,180,207,143,226,63,204,149,136,231,
195,21,234,63,70,219,7,206,34,137,226,63,231,13,229,205,129,26,234,63,22,108,
151,176,116,130,226,63,43,171,79,254,61,31,234,63,209,229,156,92,197,123,226,
63,114,252,120,120,248,35,234,63,200,111,136,210,20,117,226,63,75,173,17,60,177,
40,234,63,159,69,202,18,99,110,226,63,6,134,202,72,104,45,234,63,69,183,210,29,
176,103,226,63,179,107,84,158,29,50,234,63,239,40,18,244,251,96,226,63,44,96,
96,60,209,54,234,63,10,19,249,149,70,90,226,63,24,130,159,34,131,59,234,63,61,
2,248,3,144,83,226,63,242,12,195,80,51,64,234,63,90,151,127,62,216,76,226,63,
11,89,124,198,225,68,234,63,91,135,0,70,31,70,226,63,144,219,124,131,142,73,234,
63,87,155,235,26,101,63,226,63,148,38,118,135,57,78,234,63,126,176,177,189,169,
56,226,63,14,233,25,210,226,82,234,63,17,184,195,46,237,49,226,63,225,238,25,
99,138,87,234,63,88,183,146,110,47,43,226,63,229,32,40,58,48,92,234,63,157,199,
143,125,112,36,226,63,228,132,246,86,212,96,234,63,39,22,44,92,176,29,226,63,
167,61,55,185,118,101,234,63,42,228,216,10,239,22,226,63,247,138,156,96,23,106,
234,63,202,134,7,138,44,16,226,63,162,201,216,76,182,110,234,63,12,103,41,218,
104,9,226,63,130,115,158,125,83,115,234,63,212,1,176,251,163,2,226,63,129,31,
160,242,238,119,234,63,215,231,12,239,221,251,225,63,159,129,144,171,136,124,
234,63,156,189,177,180,22,245,225,63,243,106,34,168,32,129,234,63,107,59,16,77,
78,238,225,63,183,201,8,232,182,133,234,63,80,45,154,184,132,231,225,63,70,169,
246,106,75,138,234,63,10,115,193,247,185,224,225,63,41,50,159,48,222,142,234,
63,8,0,248,10,238,217,225,63,18,170,181,56,111,147,234,63,100,219,175,242,32,
211,225,63,234,115,237,130,254,151,234,63,214,31,91,175,82,204,225,63,209,15,
250,14,140,156,234,63,176,251,107,65,131,197,225,63,37,27,143,220,23,161,234,
63,214,176,84,169,178,190,225,63,135,80,96,235,161,165,234,63,181,148,135,231,
224,183,225,63,222,135,33,59,42,170,234,63,63,16,119,252,13,177,225,63,94,182,
134,203,176,174,234,63,224,159,149,232,57,170,225,63,142,238,67,156,53,179,234,
63,118,211,85,172,100,163,225,63,73,96,13,173,184,183,234,63,79,78,42,72,142,
156,225,63,199,88,151,253,57,188,234,63,28,199,133,188,182,149,225,63,161,66,
150,141,185,192,234,63,233,7,219,9,222,142,225,63,210,165,190,92,55,197,234,63,
26,238,156,48,4,136,225,63,195,39,197,106,179,201,234,63,98,106,62,49,41,129,
225,63,74,139,94,183,45,206,234,63,185,128,50,12,77,122,225,63,178,176,63,66,
166,210,234,63,85,72,236,193,111,115,225,63,191,149,29,11,29,215,234,63,167,235,
222,82,145,108,225,63,179,85,173,17,146,219,234,63,77,168,125,191,177,101,225,
63,82,41,164,85,5,224,234,63,15,207,59,8,209,94,225,63,232,102,183,214,118,228,
234,63,213,195,140,45,239,87,225,63,79,130,156,148,230,232,234,63,161,253,227,
47,12,81,225,63,241,12,9,143,84,237,234,63,135,6,181,15,40,74,225,63,208,181,
178,197,192,241,234,63,163,123,115,205,66,67,225,63,135,73,79,56,43,246,234,63,
22,13,147,105,92,60,225,63,83,178,148,230,147,250,234,63,252,125,135,228,116,
53,225,63,22,248,56,208,250,254,234,63,99,164,196,62,140,46,225,63,90,64,242,
244,95,3,235,63,69,105,190,120,162,39,225,63,92,206,118,84,195,7,235,63,130,200,
232,146,183,32,225,63,6,3,125,238,36,12,235,63,213,208,183,141,203,25,225,63,
1,93,187,194,132,16,235,63,206,163,159,105,222,18,225,63,174,120,232,208,226,
20,235,63,203,117,20,39,240,11,225,63,52,16,187,24,63,25,235,63,240,141,138,198,
0,5,225,63,125,251,233,153,153,29,235,63,32,70,118,72,16,254,224,63,66,48,44,
84,242,33,235,63,241,10,76,173,30,247,224,63,10,194,56,71,73,38,235,63,173,91,
128,245,43,240,224,63,50,226,198,114,158,42,235,63,66,202,135,33,56,233,224,63,
242,223,141,214,241,46,235,63,62,251,214,49,67,226,224,63,94,40,69,114,67,51,
235,63,200,165,226,38,77,219,224,63,112,70,164,69,147,55,235,63,151,147,31,1,
86,212,224,63,9,227,98,80,225,59,235,63,234,160,2,193,93,205,224,63,248,196,56,
146,45,64,235,63,129,188,0,103,100,198,224,63,251,208,221,10,120,68,235,63,152,
231,142,243,105,191,224,63,202,9,10,186,192,72,235,63,218,53,34,103,110,184,224,
63,22,144,117,159,7,77,235,63,92,205,47,194,113,177,224,63,143,162,216,186,76,
81,235,63,151,230,44,5,116,170,224,63,236,157,235,11,144,85,235,63,94,204,142,
48,117,163,224,63,235,252,102,146,209,89,235,63,214,219,202,68,117,156,224,63,
90,88,3,78,17,94,235,63,114,132,86,66,116,149,224,63,23,103,121,62,79,98,235,
63,229,71,167,41,114,142,224,63,24,254,129,99,139,102,235,63,33,186,50,251,110,
135,224,63,114,16,214,188,197,106,235,63,75,129,110,183,106,128,224,63,86,175,
46,74,254,110,235,63,180,85,208,94,101,121,224,63,29,10,69,11,53,115,235,63,211,
1,206,241,94,114,224,63,73,110,210,255,105,119,235,63,60,98,221,112,87,107,224,
63,139,71,144,39,157,123,235,63,150,101,116,220,78,100,224,63,199,31,56,130,206,
127,235,63,152,12,9,53,69,93,224,63,24,159,131,15,254,131,235,63,255,105,17,123,
58,86,224,63,213,139,44,207,43,136,235,63,132,162,3,175,46,79,224,63,153,202,
236,192,87,140,235,63,218,236,85,209,33,72,224,63,65,94,126,228,129,144,235,63,
159,145,126,226,19,65,224,63,245,103,155,57,170,148,235,63,90,235,243,226,4,58,
224,63,46,39,254,191,208,152,235,63,112,102,44,211,244,50,224,63,181,249,96,119,
245,156,235,63,30,129,158,179,227,43,224,63,172,91,126,95,24,161,235,63,114,203,
192,132,209,36,224,63,147,231,16,120,57,165,235,63,62,231,9,71,190,29,224,63,
74,86,211,192,88,169,235,63,25,136,240,250,169,22,224,63,20,127,128,57,118,173,
235,63,78,115,235,160,148,15,224,63,162,87,211,225,145,177,235,63,219,127,113,
57,126,8,224,63,18,244,134,185,171,181,235,63,102,150,249,196,102,1,224,63,243,
134,86,192,195,185,235,63,108,98,245,135,156,244,223,63,80,97,253,245,217,189,
235,63,87,184,215,109,105,230,223,63,171,242,54,90,238,193,235,63,111,105,136,
60,52,216,223,63,10,201,190,236,0,198,235,63,171,211,245,244,252,201,223,63,247,
144,80,173,17,202,235,63,4,120,14,152,195,187,223,63,134,21,168,155,32,206,235,
63,102,250,192,38,136,173,223,63,87,64,129,183,45,210,235,63,165,33,252,161,74,
159,223,63,161,25,152,0,57,214,235,63,101,215,174,10,11,145,223,63,44,200,168,
118,66,218,235,63,18,40,200,97,201,130,223,63,97,145,111,25,74,222,235,63,203,
66,55,168,133,116,223,63,68,217,168,232,79,226,235,63,87,121,235,222,63,102,223,
63,128,34,17,228,83,230,235,63,16,64,212,6,248,87,223,63,105,14,101,11,86,234,
235,63,216,45,225,32,174,73,223,63,254,92,97,94,86,238,235,63,7,252,1,46,98,59,
223,63,240,236,194,220,84,242,235,63,92,134,38,47,20,45,223,63,169,187,70,134,
81,246,235,63,236,202,62,37,196,30,223,63,72,229,169,90,76,250,235,63,21,234,
58,17,114,16,223,63,175,164,169,89,69,254,235,63,108,38,11,244,29,2,223,63,129,
83,3,131,60,2,236,63,172,228,159,206,199,243,222,63,40,106,116,214,49,6,236,63,
170,171,233,161,111,229,222,63,220,127,186,83,37,10,236,63,67,36,217,110,21,215,
222,63,163,74,147,250,22,14,236,63,76,25,95,54,185,200,222,63,88,159,188,202,
6,18,236,63,131,119,108,249,90,186,222,63,175,113,244,195,244,21,236,63,127,77,
242,184,250,171,222,63,57,212,248,229,224,25,236,63,160,203,225,117,152,157,222,
63,105,248,135,48,203,29,236,63,0,68,44,49,52,143,222,63,151,46,96,163,179,33,
236,63,97,42,195,235,205,128,222,63,5,230,63,62,154,37,236,63,32,20,152,166,101,
114,222,63,227,172,229,0,127,41,236,63,36,184,156,98,251,99,222,63,86,48,16,235,
97,45,236,63,205,238,194,32,143,85,222,63,119,60,126,252,66,49,236,63,230,177,
252,225,32,71,222,63,91,188,238,52,34,53,236,63,147,28,60,167,176,56,222,63,24,
186,32,148,255,56,236,63,69,107,115,113,62,42,222,63,198,94,211,25,219,60,236,
63,166,251,148,65,202,27,222,63,134,242,197,197,180,64,236,63,138,76,147,24,84,
13,222,63,132,220,183,151,140,68,236,63,225,253,96,247,219,254,221,63,254,162,
104,143,98,72,236,63,165,208,240,222,97,240,221,63,69,235,151,172,54,76,236,63,
204,166,53,208,229,225,221,63,197,121,5,239,8,80,236,63,54,131,34,204,103,211,
221,63,5,50,113,86,217,83,236,63,160,137,170,211,231,196,221,63,174,22,155,226,
167,87,236,63,143,254,192,231,101,182,221,63,143,73,67,147,116,91,236,63,71,71,
89,9,226,167,221,63,160,11,42,104,63,95,236,63,180,233,102,57,92,153,221,63,8,
189,15,97,8,99,236,63,96,140,221,120,212,138,221,63,30,221,180,125,207,102,236,
63,95,246,176,200,74,124,221,63,114,10,218,189,148,106,236,63,65,15,213,41,191,
109,221,63,203,2,64,33,88,110,236,63,0,223,61,157,49,95,221,63,49,163,167,167,
25,114,236,63,243,141,223,35,162,80,221,63,238,231,209,80,217,117,236,63,188,
100,174,190,16,66,221,63,146,236,127,28,151,121,236,63,58,204,158,110,125,51,
221,63,249,235,114,10,83,125,236,63,115,77,165,52,232,36,221,63,78,64,108,26,
13,129,236,63,142,145,182,17,81,22,221,63,13,99,45,76,197,132,236,63,184,97,199,
6,184,7,221,63,12,237,119,159,123,136,236,63,30,167,204,20,29,249,220,63,122,
150,13,20,48,140,236,63,214,106,187,60,128,234,220,63,232,54,176,169,226,143,
236,63,208,213,136,127,225,219,220,63,71,197,33,96,147,147,236,63,201,48,42,222,
64,205,220,63,242,87,36,55,66,151,236,63,57,228,148,89,158,190,220,63,176,36,
122,46,239,154,236,63,67,120,190,242,249,175,220,63,180,128,229,69,154,158,236,
63,163,148,156,170,83,161,220,63,170,224,40,125,67,162,236,63,162,0,37,130,171,
146,220,63,177,216,6,212,234,165,236,63,3,163,77,122,1,132,220,63,101,28,66,74,
144,169,236,63,243,129,12,148,85,117,220,63,228,126,157,223,51,173,236,63,250,
194,87,208,167,102,220,63,205,242,219,147,213,176,236,63,235,170,37,48,248,87,
220,63,72,138,192,102,117,180,236,63,209,157,108,180,70,73,220,63,8,119,14,88,
19,184,236,63,227,30,35,94,147,58,220,63,81,10,137,103,175,187,236,63,113,208,
63,46,222,43,220,63,249,180,243,148,73,191,236,63,214,115,185,37,39,29,220,63,
111,7,18,224,225,194,236,63,100,233,134,69,110,14,220,63,189,177,167,72,120,198,
236,63,89,48,159,142,179,255,219,63,141,131,120,206,12,202,236,63,203,102,249,
1,247,240,219,63,44,108,72,113,159,205,236,63,152,201,140,160,56,226,219,63,142,
122,219,48,48,209,236,63,88,180,80,107,120,211,219,63,85,221,245,12,191,212,236,
63,76,161,60,99,182,196,219,63,206,226,91,5,76,216,236,63,76,41,72,137,242,181,
219,63,253,248,209,25,215,219,236,63,184,3,107,222,44,167,219,63,155,173,28,74,
96,223,236,63,107,6,157,99,101,152,219,63,29,174,0,150,231,226,236,63,163,37,
214,25,156,137,219,63,183,199,66,253,108,230,236,63,248,115,14,2,209,122,219,
63,96,231,167,127,240,233,236,63,73,34,62,29,4,108,219,63,211,25,245,28,114,237,
236,63,173,127,93,108,53,93,219,63,153,139,239,212,241,240,236,63,94,249,100,
240,100,78,219,63,8,137,92,167,111,244,236,63,176,26,77,170,146,63,219,63,72,
126,1,148,235,247,236,63,250,140,14,155,190,48,219,63,87,247,163,154,101,251,
236,63,140,23,162,195,232,33,219,63,13,160,9,187,221,254,236,63,153,159,0,37,
17,19,219,63,32,68,248,244,83,2,237,63,42,40,35,192,55,4,219,63,39,207,53,72,
200,5,237,63,11,210,2,150,92,245,218,63,160,76,136,180,58,9,237,63,193,219,152,
167,127,230,218,63,239,231,181,57,171,12,237,63,111,161,222,245,160,215,218,63,
104,236,132,215,25,16,237,63,209,156,205,129,192,200,218,63,78,197,187,141,134,
19,237,63,36,101,95,76,222,185,218,63,217,253,32,92,241,22,237,63,24,175,141,
86,250,170,218,63,58,65,123,66,90,26,237,63,192,76,82,161,20,156,218,63,155,90,
145,64,193,29,237,63,131,45,167,45,45,141,218,63,42,53,42,86,38,33,237,63,6,94,
134,252,67,126,218,63,21,220,12,131,137,36,237,63,36,8,234,14,89,111,218,63,147,
122,0,199,234,39,237,63,215,114,204,101,108,96,218,63,231,91,204,33,74,43,237,
63,41,2,40,2,126,81,218,63,95,235,55,147,167,46,237,63,38,55,247,228,141,66,218,
63,95,180,10,27,3,50,237,63,201,175,52,15,156,51,218,63,94,98,12,185,92,53,237,
63,238,38,219,129,168,36,218,63,241,192,4,109,180,56,237,63,61,116,229,61,179,
21,218,63,198,187,187,54,10,60,237,63,33,140,78,68,188,6,218,63,175,94,249,21,
94,63,237,63,174,127,17,150,195,247,217,63,161,213,133,10,176,66,237,63,154,124,
41,52,201,232,217,63,186,108,41,20,0,70,237,63,40,205,145,31,205,217,217,63,70,
144,172,50,78,73,237,63,20,216,69,89,207,202,217,63,189,204,215,101,154,76,237,
63,139,32,65,226,207,187,217,63,205,206,115,173,228,79,237,63,20,70,127,187,206,
172,217,63,92,99,73,9,45,83,237,63,127,4,252,229,203,157,217,63,135,119,33,121,
115,86,237,63,220,51,179,98,199,142,217,63,172,24,197,252,183,89,237,63,97,200,
160,50,193,127,217,63,106,116,253,147,250,92,237,63,95,210,192,86,185,112,217,
63,166,216,147,62,59,96,237,63,50,126,15,208,175,97,217,63,142,179,81,252,121,
99,237,63,44,20,137,159,164,82,217,63,154,147,0,205,182,102,237,63,138,248,41,
198,151,67,217,63,150,39,106,176,241,105,237,63,95,171,238,68,137,52,217,63,160,
62,88,166,42,109,237,63,133,200,211,28,121,37,217,63,45,200,148,174,97,112,237,
63,143,7,214,78,103,22,217,63,12,212,233,200,150,115,237,63,179,59,242,219,83,
7,217,63,108,146,33,245,201,118,237,63,191,83,37,197,62,248,216,63,222,83,6,51,
251,121,237,63,5,90,108,11,40,233,216,63,87,137,98,130,42,125,237,63,74,116,196,
175,15,218,216,63,53,196,0,227,87,128,237,63,185,227,42,179,245,202,216,63,68,
182,171,84,131,131,237,63,206,4,157,22,218,187,216,63,190,49,46,215,172,134,237,
63,74,79,24,219,188,172,216,63,81,41,83,106,212,137,237,63,30,86,154,1,158,157,
216,63,35,176,229,13,250,140,237,63,93,199,32,139,125,142,216,63,210,249,176,
193,29,144,237,63,43,108,169,120,91,127,216,63,124,90,128,133,63,147,237,63,171,
40,50,203,55,112,216,63,192,70,31,89,95,150,237,63,241,251,184,131,18,97,216,
63,191,83,89,60,125,153,237,63,238,255,59,163,235,81,216,63,37,55,250,46,153,
156,237,63,99,105,185,42,195,66,216,63,42,199,205,48,179,159,237,63,205,135,47,
27,153,51,216,63,146,250,159,65,203,162,237,63,87,197,156,117,109,36,216,63,181,
232,60,97,225,165,237,63,198,166,255,58,64,21,216,63,130,201,112,143,245,168,
237,63,110,203,86,108,17,6,216,63,126,245,7,204,7,172,237,63,26,237,160,10,225,
246,215,63,207,229,206,22,24,175,237,63,2,224,220,22,175,231,215,63,54,52,146,
111,38,178,237,63,181,146,9,146,123,216,215,63,27,155,30,214,50,181,237,63,12,
14,38,125,70,201,215,63,139,245,64,74,61,184,237,63,24,117,49,217,15,186,215,
63,61,63,198,203,69,187,237,63,18,5,43,167,215,170,215,63,149,148,123,90,76,190,
237,63,71,21,18,232,157,155,215,63,170,50,46,246,80,193,237,63,11,23,230,156,
98,140,215,63,69,119,171,158,83,196,237,63,169,149,166,198,37,125,215,63,230,
224,192,83,84,199,237,63,77,54,83,102,231,109,215,63,200,14,60,21,83,202,237,
63,249,183,235,124,167,94,215,63,230,192,234,226,79,205,237,63,112,243,111,11,
102,79,215,63,248,215,154,188,74,208,237,63,41,219,223,18,35,64,215,63,127,85,
26,162,67,211,237,63,58,123,59,148,222,48,215,63,193,91,55,147,58,214,237,63,
75,249,130,144,152,33,215,63,208,45,192,143,47,217,237,63,130,148,182,8,81,18,
215,63,139,47,131,151,34,220,237,63,119,165,214,253,7,3,215,63,166,229,78,170,
19,223,237,63,29,158,227,112,189,243,214,63,166,245,241,199,2,226,237,63,181,
9,222,98,113,228,214,63,234,37,59,240,239,228,237,63,189,140,198,212,35,213,214,
63,172,93,249,34,219,231,237,63,223,228,157,199,212,197,214,63,5,165,251,95,196,
234,237,63,223,232,100,60,132,182,214,63,237,36,17,167,171,237,237,63,139,136,
28,52,50,167,214,63,69,39,9,248,144,240,237,63,170,204,197,175,222,151,214,63,
211,22,179,82,116,243,237,63,235,214,97,176,137,136,214,63,74,127,222,182,85,
246,237,63,215,225,241,54,51,121,214,63,75,13,91,36,53,249,237,63,186,64,119,
68,219,105,214,63,103,142,248,154,18,252,237,63,151,95,243,217,129,90,214,63,
39,241,134,26,238,254,237,63,24,195,103,248,38,75,214,63,8,69,214,162,199,1,238,
63,119,8,214,160,202,59,214,63,135,186,182,51,159,4,238,63,116,229,63,212,108,
44,214,63,26,163,248,204,116,7,238,63,65,40,167,147,13,29,214,63,59,113,108,110,
72,10,238,63,112,183,13,224,172,13,214,63,106,184,226,23,26,13,238,63,228,145,
117,186,74,254,213,63,43,45,44,201,233,15,238,63,192,206,224,35,231,238,213,63,
15,165,25,130,183,18,238,63,84,157,81,29,130,223,213,63,180,22,124,66,131,21,
238,63,16,69,202,167,27,208,213,63,201,153,36,10,77,24,238,63,111,37,77,196,179,
192,213,63,17,103,228,216,20,27,238,63,232,181,220,115,74,177,213,63,101,216,
140,174,218,29,238,63,222,133,123,183,223,161,213,63,186,104,239,138,158,32,238,
63,140,60,44,144,115,146,213,63,33,180,221,109,96,35,238,63,247,152,241,254,5,
131,213,63,202,119,41,87,32,38,238,63,220,113,206,4,151,115,213,63,10,146,164,
70,222,40,238,63,160,181,197,162,38,100,213,63,91,2,33,60,154,43,238,63,61,106,
218,217,180,84,213,63,96,233,112,55,84,46,238,63,49,173,15,171,65,69,213,63,234,
136,102,56,12,49,238,63,112,179,104,23,205,53,213,63,248,67,212,62,194,51,238,
63,80,201,232,31,87,38,213,63,185,158,140,74,118,54,238,63,122,82,147,197,223,
22,213,63,149,62,98,91,40,57,238,63,215,201,107,9,103,7,213,63,42,234,39,113,
216,59,238,63,130,193,117,236,236,247,212,63,82,137,176,139,134,62,238,63,179,
226,180,111,113,232,212,63,35,37,207,170,50,65,238,63,177,237,44,148,244,216,
212,63,247,231,86,206,220,67,238,63,192,185,225,90,118,201,212,63,106,29,27,246,
132,70,238,63,17,53,215,196,246,185,212,63,95,50,239,33,43,73,238,63,174,100,
17,211,117,170,212,63,3,181,166,81,207,75,238,63,108,100,148,134,243,154,212,
63,209,84,21,133,113,78,238,63,218,102,100,224,111,139,212,63,145,226,14,188,
17,81,238,63,45,181,133,225,234,123,212,63,95,80,103,246,175,83,238,63,51,175,
252,138,100,108,212,63,173,177,242,51,76,86,238,63,60,203,205,221,220,92,212,
63,69,59,133,116,230,88,238,63,18,150,253,218,83,77,212,63,74,67,243,183,126,
91,238,63,222,178,144,131,201,61,212,63,64,65,17,254,20,94,238,63,29,219,139,
216,61,46,212,63,10,206,179,70,169,96,238,63,143,222,243,218,176,30,212,63,239,
163,175,145,59,99,238,63,34,163,205,139,34,15,212,63,157,158,217,222,203,101,
238,63,228,36,30,236,146,255,211,63,44,187,6,46,90,104,238,63,242,117,234,252,
1,240,211,63,29,24,12,127,230,106,238,63,102,190,55,191,111,224,211,63,101,245,
190,209,112,109,238,63,68,60,11,52,220,208,211,63,102,180,244,37,249,111,238,
63,109,67,106,92,71,193,211,63,249,215,130,123,127,114,238,63,138,61,90,57,177,
177,211,63,111,4,63,210,3,117,238,63,254,169,224,203,25,162,211,63,145,255,254,
41,134,119,238,63,211,29,3,21,129,146,211,63,167,176,152,130,6,122,238,63,169,
67,199,21,231,130,211,63,118,32,226,219,132,124,238,63,164,219,50,207,75,115,
211,63,73,121,177,53,1,127,238,63,95,187,75,66,175,99,211,63,237,6,221,143,123,
129,238,63,211,205,23,112,17,84,211,63,185,54,59,234,243,131,238,63,80,19,157,
89,114,68,211,63,142,151,162,68,106,134,238,63,99,161,225,255,209,52,211,63,216,
217,233,158,222,136,238,63,201,162,235,99,48,37,211,63,152,207,231,248,80,139,
238,63,94,87,193,134,141,21,211,63,93,108,115,82,193,141,238,63,9,20,105,105,
233,5,211,63,78,197,99,171,47,144,238,63,175,66,233,12,68,246,210,63,41,17,144,
3,156,146,238,63,30,98,72,114,157,230,210,63,72,168,207,90,6,149,238,63,254,5,
141,154,245,214,210,63,161,4,250,176,110,151,238,63,191,214,189,134,76,199,210,
63,203,193,230,5,213,153,238,63,136,145,225,55,162,183,210,63,255,156,109,89,
57,156,238,63,37,8,255,174,246,167,210,63,28,117,102,171,155,158,238,63,247,32,
29,237,73,152,210,63,170,74,169,251,251,160,238,63,226,214,66,243,155,136,210,
63,217,63,14,74,90,163,238,63,60,57,119,194,236,120,210,63,137,152,109,150,182,
165,238,63,189,107,193,91,60,105,210,63,71,186,159,224,16,168,238,63,107,166,
40,192,138,89,210,63,87,44,125,40,105,170,238,63,138,53,180,240,215,73,210,63,
172,151,222,109,191,172,238,63,139,121,107,238,35,58,210,63,246,198,156,176,19,
175,238,63,254,230,85,186,110,42,210,63,156,166,144,240,101,177,238,63,121,6,
123,85,184,26,210,63,194,68,147,45,182,179,238,63,141,116,226,192,0,11,210,63,
78,209,125,103,4,182,238,63,179,225,147,253,71,251,209,63,228,157,41,158,80,184,
238,63,60,18,151,12,142,235,209,63,239,29,112,209,154,186,238,63,60,222,243,238,
210,219,209,63,159,230,42,1,227,188,238,63,124,49,178,165,22,204,209,63,241,174,
51,45,41,191,238,63,104,11,218,49,89,188,209,63,169,79,100,85,109,193,238,63,
254,126,115,148,154,172,209,63,93,195,150,121,175,195,238,63,187,178,134,206,
218,156,209,63,115,38,165,153,239,197,238,63,139,224,27,225,25,141,209,63,36,
183,105,181,45,200,238,63,184,85,59,205,87,125,209,63,126,213,190,204,105,202,
238,63,216,114,237,147,148,109,209,63,107,3,127,223,163,204,238,63,189,171,58,
54,208,93,209,63,171,228,132,237,219,206,238,63,97,135,43,181,10,78,209,63,222,
62,171,246,17,209,238,63,214,159,200,17,68,62,209,63,132,249,204,250,69,211,238,
63,55,162,26,77,124,46,209,63,253,29,197,249,119,213,238,63,146,78,42,104,179,
30,209,63,144,215,110,243,167,215,238,63,219,119,0,100,233,14,209,63,106,115,
165,231,213,217,238,63,216,3,166,65,30,255,208,63,160,96,68,214,1,220,238,63,
17,235,35,2,82,239,208,63,53,48,39,191,43,222,238,63,190,56,131,166,132,223,208,
63,25,149,41,162,83,224,238,63,181,10,205,47,182,207,208,63,44,100,39,127,121,
226,238,63,89,145,10,159,230,191,208,63,66,148,252,85,157,228,238,63,140,15,69,
245,21,176,208,63,36,62,133,38,191,230,238,63,151,218,133,51,68,160,208,63,145,
156,157,240,222,232,238,63,30,90,214,90,113,144,208,63,70,12,34,180,252,234,238,
63,12,8,64,108,157,128,208,63,247,11,239,112,24,237,238,63,132,112,204,104,200,
112,208,63,91,60,225,38,50,239,238,63,204,49,133,81,242,96,208,63,39,96,213,213,
73,241,238,63,63,252,115,39,27,81,208,63,21,92,168,125,95,243,238,63,57,146,162,
235,66,65,208,63,229,54,55,30,115,245,238,63,8,200,26,159,105,49,208,63,92,25,
95,183,132,247,238,63,217,131,230,66,143,33,208,63,76,78,253,72,148,249,238,63,
166,189,15,216,179,17,208,63,147,66,239,210,161,251,238,63,40,127,160,95,215,
1,208,63,27,133,18,85,173,253,238,63,127,199,69,181,243,227,207,63,227,198,68,
207,182,255,238,63,210,48,66,148,54,196,207,63,250,218,99,65,190,1,239,63,82,
183,74,94,119,164,207,63,134,182,77,171,195,3,239,63,244,250,115,21,182,132,207,
63,196,112,224,12,199,5,239,63,120,190,210,187,242,100,207,63,10,67,250,101,200,
7,239,63,71,231,123,83,45,69,207,63,205,136,121,182,199,9,239,63,76,125,132,222,
101,37,207,63,157,191,60,254,196,11,239,63,215,170,1,95,156,5,207,63,45,135,34,
61,192,13,239,63,117,188,8,215,208,229,206,63,80,161,9,115,185,15,239,63,206,
32,175,72,3,198,206,63,1,242,208,159,176,17,239,63,134,104,10,182,51,166,206,
63,95,127,87,195,165,19,239,63,19,70,48,33,98,134,206,63,180,113,124,221,152,
21,239,63,161,141,54,140,142,102,206,63,118,19,31,238,137,23,239,63,235,52,51,
249,184,70,206,63,69,209,30,245,120,25,239,63,26,83,60,106,225,38,206,63,245,
57,91,242,101,27,239,63,158,32,104,225,7,7,206,63,136,254,179,229,80,29,239,63,
18,247,204,96,44,231,205,63,56,242,8,207,57,31,239,63,17,81,129,234,78,199,205,
63,112,10,58,174,32,33,239,63,27,202,155,128,111,167,205,63,214,94,39,131,5,35,
239,63,107,30,51,37,142,135,205,63,74,41,177,77,232,36,239,63,216,42,94,218,170,
103,205,63,233,197,183,13,201,38,239,63,176,236,51,162,197,71,205,63,12,179,27,
195,167,40,239,63,151,129,203,126,222,39,205,63,77,145,189,109,132,42,239,63,
97,39,60,114,245,7,205,63,139,35,126,13,95,44,239,63,244,59,157,126,10,232,204,
63,230,78,62,162,55,46,239,63,28,61,6,166,29,200,204,63,198,26,223,43,14,48,239,
63,115,200,142,234,46,168,204,63,220,176,65,170,226,49,239,63,53,155,78,78,62,
136,204,63,34,93,71,29,181,51,239,63,33,146,93,211,75,104,204,63,225,141,209,
132,133,53,239,63,86,169,211,123,87,72,204,63,176,211,193,224,83,55,239,63,46,
252,200,73,97,40,204,63,115,225,249,48,32,57,239,63,27,197,85,63,105,8,204,63,
102,140,91,117,234,58,239,63,134,93,146,94,111,232,203,63,21,204,200,173,178,
60,239,63,172,61,151,169,115,200,203,63,102,186,35,218,120,62,239,63,118,252,
124,34,118,168,203,63,148,147,78,250,60,64,239,63,91,79,92,203,118,136,203,63,
56,182,43,14,255,65,239,63,59,10,78,166,117,104,203,63,69,163,157,21,191,67,239,
63,61,31,107,181,114,72,203,63,13,254,134,16,125,69,239,63,168,158,204,250,109,
40,203,63,66,140,202,254,56,71,239,63,197,182,139,120,103,8,203,63,247,53,75,
224,242,72,239,63,183,179,193,48,95,232,202,63,167,5,236,180,170,74,239,63,93,
255,135,37,85,200,202,63,46,40,144,124,96,76,239,63,41,33,248,88,73,168,202,63,
211,236,26,55,20,78,239,63,1,190,43,205,59,136,202,63,69,197,111,228,197,79,239,
63,26,152,60,132,44,104,202,63,160,69,114,132,117,81,239,63,214,142,68,128,27,
72,202,63,109,36,6,23,35,83,239,63,159,158,93,195,8,40,202,63,163,58,15,156,206,
84,239,63,196,224,161,79,244,7,202,63,171,131,113,19,120,86,239,63,87,139,43,
39,222,231,201,63,99,29,17,125,31,88,239,63,11,241,20,76,198,199,201,63,26,72,
210,216,196,89,239,63,12,129,120,192,172,167,201,63,152,102,153,38,104,91,239,
63,223,198,112,134,145,135,201,63,30,254,74,102,9,93,239,63,64,106,24,160,116,
103,201,63,101,182,203,151,168,94,239,63,251,46,138,15,86,71,201,63,163,89,0,
187,69,96,239,63,204,244,224,214,53,39,201,63,141,212,205,207,224,97,239,63,58,
183,55,248,19,7,201,63,86,54,25,214,121,99,239,63,114,141,169,117,240,230,200,
63,179,176,199,205,16,101,239,63,41,170,81,81,203,198,200,63,221,151,190,182,
165,102,239,63,115,91,75,141,164,166,200,63,143,98,227,144,56,104,239,63,163,
10,178,43,124,134,200,63,13,170,27,92,201,105,239,63,38,60,161,46,82,102,200,
63,36,42,77,24,88,107,239,63,96,143,52,152,38,70,200,63,41,193,93,197,228,108,
239,63,139,190,135,106,249,37,200,63,253,111,51,99,111,110,239,63,143,158,182,
167,202,5,200,63,16,90,180,241,247,111,239,63,225,30,221,81,154,229,199,63,95,
197,198,112,126,113,239,63,99,73,23,107,104,197,199,63,122,26,81,224,2,115,239,
63,58,66,129,245,52,165,199,63,130,228,57,64,133,116,239,63,176,71,55,243,255,
132,199,63,45,209,103,144,5,118,239,63,12,178,85,102,201,100,199,63,198,176,193,
208,131,119,239,63,117,243,248,80,145,68,199,63,48,118,46,1,0,121,239,63,201,
151,61,181,87,36,199,63,232,54,149,33,122,122,239,63,121,68,64,149,28,4,199,63,
4,43,221,49,242,123,239,63,107,184,29,243,223,227,198,63,56,173,237,49,104,125,
239,63,210,203,242,208,161,195,198,63,213,58,174,33,220,126,239,63,13,112,220,
48,98,163,198,63,203,115,6,1,78,128,239,63,129,175,247,20,33,131,198,63,173,26,
222,207,189,129,239,63,121,173,97,127,222,98,198,63,176,20,29,142,43,131,239,
63,255,165,55,114,154,66,198,63,173,105,171,59,151,132,239,63,187,237,150,239,
84,34,198,63,36,68,113,216,0,134,239,63,206,241,156,249,13,2,198,63,58,241,86,
100,104,135,239,63,177,55,103,146,197,225,197,63,192,224,68,223,205,136,239,63,
12,93,19,188,123,193,197,63,48,165,35,73,49,138,239,63,154,23,191,120,48,161,
197,63,177,243,219,161,146,139,239,63,1,53,136,202,227,128,197,63,23,164,86,233,
241,140,239,63,173,154,140,179,149,96,197,63,229,176,124,31,79,142,239,63,176,
69,234,53,70,64,197,63,79,55,55,68,170,143,239,63,159,74,191,83,245,31,197,63,
60,119,111,87,3,145,239,63,106,213,41,15,163,255,196,63,69,211,14,89,90,146,239,
63,61,41,72,106,79,223,196,63,186,208,254,72,175,147,239,63,88,160,56,103,250,
190,196,63,161,23,41,39,2,149,239,63,240,171,25,8,164,158,196,63,183,114,119,
243,82,150,239,63,11,212,9,79,76,126,196,63,115,207,211,173,161,151,239,63,87,
183,39,62,243,93,196,63,9,62,40,86,238,152,239,63,13,11,146,215,152,61,196,63,
102,241,94,236,56,154,239,63,203,154,103,29,61,29,196,63,57,63,98,112,129,155,
239,63,111,72,199,17,224,252,195,63,236,159,28,226,199,156,239,63,245,11,208,
182,129,220,195,63,173,174,120,65,12,158,239,63,84,243,160,14,34,188,195,63,106,
41,97,142,78,159,239,63,88,34,89,27,193,155,195,63,214,240,192,200,142,160,239,
63,128,210,23,223,94,123,195,63,104,8,131,240,204,161,239,63,220,82,252,91,251,
90,195,63,93,150,146,5,9,163,239,63,230,7,38,148,150,58,195,63,187,227,218,7,
67,164,239,63,96,107,180,137,48,26,195,63,79,92,71,247,122,165,239,63,50,12,199,
62,201,249,194,63,178,142,195,211,176,166,239,63,67,142,125,181,96,217,194,63,
73,44,59,157,228,167,239,63,88,170,247,239,246,184,194,63,67,9,154,83,22,169,
239,63,240,45,85,240,139,152,194,63,162,28,204,246,69,170,239,63,32,251,181,184,
31,120,194,63,51,128,189,134,115,171,239,63,110,8,58,75,178,87,194,63,151,112,
90,3,159,172,239,63,176,96,1,170,67,55,194,63,63,77,143,108,200,173,239,63,229,
34,44,215,211,22,194,63,114,152,72,194,239,174,239,63,22,130,218,212,98,246,193,
63,75,247,114,4,21,176,239,63,46,197,44,165,240,213,193,63,185,49,251,50,56,177,
239,63,216,70,67,74,125,181,193,63,133,50,206,77,89,178,239,63,92,117,62,198,
8,149,193,63,79,7,217,84,120,179,239,63,122,210,62,27,147,116,193,63,146,224,
8,72,149,180,239,63,72,243,100,75,28,84,193,63,163,17,75,39,176,181,239,63,11,
128,209,88,164,51,193,63,179,16,141,242,200,182,239,63,23,52,165,69,43,19,193,
63,211,118,188,169,223,183,239,63,171,221,0,20,177,242,192,63,239,255,198,76,
244,184,239,63,203,93,5,198,53,210,192,63,213,138,154,219,6,186,239,63,28,168,
211,93,185,177,192,63,53,25,37,86,23,187,239,63,197,194,140,221,59,145,192,63,
159,207,84,188,37,188,239,63,68,198,81,71,189,112,192,63,136,245,23,14,50,189,
239,63,82,221,67,157,61,80,192,63,72,245,92,75,60,190,239,63,186,68,132,225,188,
47,192,63,32,92,18,116,68,191,239,63,54,75,52,22,59,15,192,63,53,218,38,136,74,
192,239,63,155,162,234,122,112,221,191,63,147,66,137,135,78,193,239,63,95,146,
209,178,104,156,191,63,51,139,40,114,80,194,239,63,32,109,96,216,94,91,191,63,
246,204,243,71,80,195,239,63,7,93,218,239,82,26,191,63,167,67,218,8,78,196,239,
63,184,174,130,253,68,217,190,63,1,78,203,180,73,197,239,63,9,209,156,5,53,152,
190,63,169,109,182,75,67,198,239,63,187,84,108,12,35,87,190,63,53,71,139,205,
58,199,239,63,52,236,52,22,15,22,190,63,42,162,57,58,48,200,239,63,53,107,58,
39,249,212,189,63,254,104,177,145,35,201,239,63,146,198,192,67,225,147,189,63,
24,169,226,211,20,202,239,63,239,19,12,112,199,82,189,63,210,146,189,0,4,203,
239,63,115,137,96,176,171,17,189,63,124,121,50,24,241,203,239,63,133,125,2,9,
142,208,188,63,88,211,49,26,220,204,239,63,127,102,54,126,110,143,188,63,159,
57,172,6,197,205,239,63,109,218,64,20,77,78,188,63,130,104,146,221,171,206,239,
63,191,142,102,207,41,13,188,63,41,63,213,158,144,207,239,63,7,88,236,179,4,204,
187,63,181,191,101,74,115,208,239,63,174,41,23,198,221,138,187,63,66,15,53,224,
83,209,239,63,171,21,44,10,181,73,187,63,228,117,52,96,50,210,239,63,65,76,112,
132,138,8,187,63,175,94,85,202,14,211,239,63,177,27,41,57,94,199,186,63,177,87,
137,30,233,211,239,63,247,239,155,44,48,134,186,63,246,17,194,92,193,212,239,
63,128,82,14,99,0,69,186,63,137,97,241,132,151,213,239,63,226,233,197,224,206,
3,186,63,118,61,9,151,107,214,239,63,151,121,8,170,155,194,185,63,200,191,251,
146,61,215,239,63,178,225,27,195,102,129,185,63,140,37,187,120,13,216,239,63,
153,30,70,48,48,64,185,63,210,206,57,72,219,216,239,63,190,72,205,245,247,254,
184,63,170,62,106,1,167,217,239,63,87,148,247,23,190,189,184,63,46,27,63,164,
112,218,239,63,19,81,11,155,130,124,184,63,120,45,171,48,56,219,239,63,215,233,
78,131,69,59,184,63,170,97,161,166,253,219,239,63,118,228,8,213,6,250,183,63,
236,198,20,6,193,220,239,63,99,225,127,148,198,184,183,63,111,143,248,78,130,
221,239,63,114,155,250,197,132,119,183,63,107,16,64,129,65,222,239,63,138,231,
191,109,65,54,183,63,33,194,222,156,254,222,239,63,96,180,22,144,252,244,182,
63,223,63,200,161,185,223,239,63,47,10,70,49,182,179,182,63,249,71,240,143,114,
224,239,63,110,10,149,85,110,114,182,63,212,187,74,103,41,225,239,63,141,239,
74,1,37,49,182,63,221,159,203,39,222,225,239,63,167,12,175,56,218,239,181,63,
146,27,103,209,144,226,239,63,64,205,8,0,142,174,181,63,124,121,17,100,65,227,
239,63,250,180,159,91,64,109,181,63,53,39,191,223,239,227,239,63,76,95,187,79,
241,43,181,63,101,181,100,68,156,228,239,63,64,127,163,224,160,234,180,63,198,
215,246,145,70,229,239,63,35,223,159,18,79,169,180,63,34,101,106,200,238,229,
239,63,69,96,248,233,251,103,180,63,84,87,180,231,148,230,239,63,171,250,244,
106,167,38,180,63,76,203,201,239,56,231,239,63,204,188,221,153,81,229,179,63,
11,1,160,224,218,231,239,63,70,203,250,122,250,163,179,63,167,91,44,186,122,232,
239,63,151,96,148,18,162,98,179,63,74,97,100,124,24,233,239,63,212,204,242,100,
72,33,179,63,52,187,61,39,180,233,239,63,102,117,94,118,237,223,178,63,187,53,
174,186,77,234,239,63,188,212,31,75,145,158,178,63,75,192,171,54,229,234,239,
63,6,122,127,231,51,93,178,63,104,109,44,155,122,235,239,63,237,8,198,79,213,
27,178,63,174,114,38,232,13,236,239,63,76,57,60,136,117,218,177,63,209,40,144,
29,159,236,239,63,230,214,42,149,20,153,177,63,159,11,96,59,46,237,239,63,32,
193,218,122,178,87,177,63,0,186,140,65,187,237,239,63,183,234,148,61,79,22,177,
63,244,245,12,48,70,238,239,63,124,89,162,225,234,212,176,63,155,164,215,6,207,
238,239,63,7,38,76,107,133,147,176,63,44,206,227,197,85,239,239,63,116,123,219,
222,30,82,176,63,253,157,40,109,218,239,239,63,22,151,153,64,183,16,176,63,128,
98,157,252,92,240,239,63,106,144,159,41,157,158,175,63,68,141,57,116,221,240,
239,63,131,223,142,191,201,27,175,63,246,178,244,211,91,241,239,63,27,0,148,75,
244,152,174,63,100,139,198,27,216,241,239,63,12,249,65,214,28,22,174,63,120,241,
166,75,82,242,239,63,212,242,43,104,67,147,173,63,60,227,141,99,202,242,239,63,
5,55,229,9,104,16,173,63,221,129,115,99,64,243,239,63,183,47,1,196,138,141,172,
63,164,17,80,75,180,243,239,63,245,102,19,159,171,10,172,63,0,250,27,27,38,244,
239,63,48,134,175,163,202,135,171,63,127,197,207,210,149,244,239,63,175,85,105,
218,231,4,171,63,209,33,100,114,3,245,239,63,252,187,212,75,3,130,170,63,202,
223,209,249,110,245,239,63,87,189,133,0,29,255,169,63,96,243,17,105,216,245,239,
63,39,123,16,1,53,124,169,63,173,115,29,192,63,246,239,63,101,51,9,86,75,249,
168,63,239,154,237,254,164,246,239,63,20,64,4,8,96,118,168,63,137,198,123,37,
8,247,239,63,167,22,150,31,115,243,167,63,2,119,193,51,105,247,239,63,123,71,
83,165,132,112,167,63,7,80,184,41,200,247,239,63,65,125,208,161,148,237,166,63,
106,24,90,7,37,248,239,63,111,124,162,29,163,106,166,63,36,186,160,204,127,248,
239,63,178,34,94,33,176,231,165,63,85,66,134,121,216,248,239,63,92,102,152,181,
187,100,165,63,66,225,4,14,47,249,239,63,213,85,230,226,197,225,164,63,89,234,
22,138,131,249,239,63,9,23,221,177,206,94,164,63,47,212,182,237,213,249,239,63,
221,230,17,43,214,219,163,63,129,56,223,56,38,250,239,63,153,24,26,87,220,88,
163,63,54,212,138,107,116,250,239,63,92,21,139,62,225,213,162,63,91,135,180,133,
192,250,239,63,138,91,250,233,228,82,162,63,41,85,87,135,10,251,239,63,62,126,
253,97,231,207,161,63,0,100,110,112,82,251,239,63,183,36,42,175,232,76,161,63,
107,253,244,64,152,251,239,63,203,9,22,218,232,201,160,63,30,142,230,248,219,
251,239,63,85,251,86,235,231,70,160,63,250,165,62,152,29,252,239,63,75,179,5,
215,203,135,159,63,7,248,248,30,93,252,239,63,230,45,95,198,197,129,158,63,123,
90,17,141,154,252,239,63,147,109,230,181,189,123,157,63,181,198,131,226,213,252,
239,63,244,154,199,182,179,117,156,63,64,89,76,31,15,253,239,63,23,255,46,218,
167,111,155,63,213,81,103,67,70,253,239,63,83,2,73,49,154,105,154,63,86,19,209,
78,123,253,239,63,43,43,66,205,138,99,153,63,209,35,134,65,174,253,239,63,45,
29,71,191,121,93,152,63,132,44,131,27,223,253,239,63,208,151,132,24,103,87,151,
63,214,249,196,220,13,254,239,63,85,117,39,234,82,81,150,63,93,123,72,133,58,
254,239,63,169,169,92,69,61,75,149,63,218,195,10,21,101,254,239,63,64,65,81,59,
38,69,148,63,61,9,9,140,141,254,239,63,250,95,50,221,13,63,147,63,164,164,64,
234,179,254,239,63,0,64,45,60,244,56,146,63,88,18,175,47,216,254,239,63,164,48,
111,105,217,50,145,63,211,241,81,92,250,254,239,63,66,149,37,118,189,44,144,63,
185,5,39,112,26,255,239,63,56,200,251,230,64,77,142,63,225,51,44,107,56,255,239,
63,130,74,75,229,4,65,140,63,75,133,95,77,84,255,239,63,204,226,148,9,199,52,
138,63,42,38,191,22,110,255,239,63,147,225,51,118,135,40,136,63,220,101,73,199,
133,255,239,63,34,180,131,77,70,28,134,63,239,182,252,94,155,255,239,63,87,226,
223,177,3,16,132,63,33,175,215,221,174,255,239,63,93,12,164,197,191,3,130,63,
91,7,217,67,192,255,239,63,222,208,87,86,245,238,127,63,185,155,255,144,207,255,
239,63,46,129,166,9,105,214,123,63,132,107,74,197,220,255,239,63,218,224,235,
233,218,189,119,63,51,153,184,224,231,255,239,63,173,197,223,59,75,165,115,63,
110,106,73,227,240,255,239,63,29,63,116,136,116,25,111,63,11,72,252,204,247,255,
239,63,251,231,101,143,80,232,102,63,16,190,208,157,252,255,239,63,75,102,9,44,
86,110,93,63,177,123,198,85,255,255,239,63,251,155,3,151,18,24,74,63,81,83,221,
244,255,255,239,63,170,94,82,127,35,178,42,191 
}; 
    double y; 
    double w; 
    double a,b,c;
    double xx,yy,zz; 
    double vv; 
    double sinx,cosx,tanx; 
    double sina,cosa; 
    double sinb,cosb; 
    double alt_sina,alt_cosa; 
    double alt_sinb,alt_cosb; 

    long sin_sign; 
    long cos_sign; 
    long ff,gg,hh,ii,jj,kk; 

    double *sincos_pnt; 
    double *dpnt; 

    unsigned char *sp1; 

    sincos_pnt = (double *) sin_cos; 

    sin_sign = 0; 
    cos_sign = 0; 

    sinx = 0.0; 
    cosx = 1.0; 
    alt_sina = 0.0; 
    alt_cosa = 1.0; 
    alt_sinb = 0.0; 
    alt_cosb = 1.0; 

    y = 0.0; 

    if (x < 0.0)  { 
        x = 0.0 - x; 
        sin_sign = 1; 
    } 

    if (x > 6.28318530717958647692528)  { 
        zz = 6.28318530717958647692528; 
        while (zz < x)  { 
            zz *= 2.0; 
        } 
NSINCOS1: 
        if (zz > x)  { 
            zz /= 2.0; 
            goto NSINCOS1; 
        } 
        if ( (zz > 6.0) && (x > 6.28318530717958647692528) )  { 
            x -= zz; 
            goto NSINCOS1; 
        } 
    } 
    if (x < 0.0)  x = 0.0; 

    if (x > 3.14159265358979323846264)  { 
        x -= 3.14159265358979323846264; 
        sin_sign = 1 - sin_sign; 
        cos_sign = 1 - cos_sign; 
        if (x < 0.0)  x = 0.0; 
    } 
    if (x > 1.57079632679489661923132)  { 
        x = 3.14159265358979323846264 - x; 
        cos_sign = 1 - cos_sign; 
        if (x < 0.0)  x = 0.0; 
    } 
    vv = x; 
/* 
&dA &d@   Step 1: deal with special cases: x = 0.0 and x = p1/2 
*/ 
    if (x == 0.0) { 
        if (flag == 1)  return (0.0); 
        if (flag == 2)  { 
            if (cos_sign == 0)  return (1.0); 
            else                return (-1.0); 
        } 
        if (flag == 3)  return (0.0); 
    } 
    if  ( (x > 1.5707963267948964) && (x < 1.5707963267948969) )  { 
        if (flag == 1)  { 
            if (sin_sign == 0)  return (1.0); 
            else                return (-1.0); 
        } 
        if (flag == 2)  return (0.0); 
        if (flag == 3)  return (1.0E308); 
    } 
/* 
&dA &d@   Step 2: determine the primary angles: 
&dA &d@     0.0 < x < p1/2 
&dA &d@     y = 1.57079632679489662 - x; 
*/ 
    if (x < 0.001)  { 
        xx = 0.0; 
        gg = 0; 
    } 
    else  { 
        xx = x * 1000; 
        dpnt = &xx; 
        sp1 = (unsigned char *) dpnt; 
        ii = *(sp1+7); 
        jj = *(sp1+6); 
        ii = *(sp1+7) << 4; 
        jj = *(sp1+6) >> 4; 
        ii += jj;               /* this is the exponent */ 
        jj = *(sp1+6) & 0x0f; 
        jj <<= 8; 
        kk = *(sp1+5); 
        jj += kk; 
        jj += 0x1000; 
        kk = 1035 - ii;         /* kk is the amount of right shift */ 
        hh = jj >> kk; 
        ii = 0; 
        jj = hh; 
        gg = hh; 
        while (jj > 0) { 
            jj >>= 1; 
            ++ii; 
        } 
        jj = 13 - ii; 
        hh <<= jj; 
        hh &= 0x0fff; 
        ii += 1022; 
        for (kk = 0; kk < 6; ++kk)  { 
            *(sp1+kk) = 0; 
        } 
        *(sp1+7) = ii >> 4; 
        ii &= 0x0f; 
        ii <<= 4; 
        *(sp1+6) = (hh >> 8) + ii; 
        *(sp1+5) = hh & 0xff; 
        xx /= 1000.0; 
    } 
    x -= xx; 

    if ( (vv > 0.9) && ( (flag & 0x02) > 0) ) {  
        y = 1.57079632679489665 - vv; 
        if (y < 0.001)  { 
            yy = 0.0; 
            ff = 0; 
        } 
        else  { 
            yy = y * 1000; 
            dpnt = &yy; 
            sp1 = (unsigned char *) dpnt; 
            ii = *(sp1+7); 
            jj = *(sp1+6); 
            ii = *(sp1+7) << 4; 
            jj = *(sp1+6) >> 4; 
            ii += jj;               /* this is the exponent */ 
            jj = *(sp1+6) & 0x0f; 
            jj <<= 8; 
            kk = *(sp1+5); 
            jj += kk; 
            jj += 0x1000; 
            kk = 1035 - ii;         /* kk is the amount of right shift */ 
            hh = jj >> kk; 
            ii = 0; 
            jj = hh; 
            ff = hh; 
            while (jj > 0) { 
                jj >>= 1; 
                ++ii; 
            } 
            jj = 13 - ii; 
            hh <<= jj; 
            hh &= 0x0fff; 
            ii += 1022; 
            for (kk = 0; kk < 6; ++kk)  { 
                *(sp1+kk) = 0; 
            } 
            *(sp1+7) = ii >> 4; 
            ii &= 0x0f; 
            ii <<= 4; 
            *(sp1+6) = (hh >> 8) + ii; 
            *(sp1+5) = hh & 0xff; 
            yy /= 1000.0; 
        } 
        y -= yy; 
        ff <<= 1; 
        alt_sina = *(sincos_pnt + ff); 
        alt_cosa = *(sincos_pnt + ff + 1); 

        w = y * y; 
        a = y; 
        b = w * a / 6.0; 
        c = w * b / 20.0; 
        alt_sinb = a - b + c; 

        a = w / 2.0; 
        b = a * w / 12.0; 
        alt_cosb = 1 - a + b; 
    } 

    gg <<= 1; 
    sina = *(sincos_pnt + gg); 
    cosa = *(sincos_pnt + gg + 1); 

    w = x * x; 
    a = x; 
    b = w * a / 6.0; 
    c = w * b / 20.0; 
    sinb = a - b + c; 

    a = w / 2.0; 
    b = a * w / 12.0; 
    cosb = 1 - a + b; 

    if ( (flag & 0x01) > 0)  { 
        sinx = (sina * cosb) + (sinb * cosa); 
        if (sin_sign == 1)  sinx = 0.0 - sinx; 
    } 
    if ( (flag & 0x02) > 0)  { 
        if (vv > 0.9)  { 
            cosx = (alt_sina * alt_cosb) + (alt_sinb * alt_cosa); 
        } 
        else { 
            cosx = (cosa * cosb) - (sina * sinb); 
        } 
        if (cos_sign == 1)  cosx = 0.0 - cosx; 
    } 
    if (flag == 1)  return (sinx); 
    if (flag == 2)  return (cosx); 
    if (cosx == 0.0)  tanx = 1.0E308; 
    else             tanx = sinx / cosx; 
    return (tanx); 
} 

/*** FUNCTION   double my_exp(double x); 

    Purpose:   compute the value of &dCe&d@ to the &dCx&d@ power    

    Input:     double x.     No limit on the value of x

    Return:    exp(x)
                                                                  ***/ 

double my_exp(double x) 
{ 
    static char exp_val[25200] = { 
186,190,20,136,122,28,4,87,46,133,186,4,101,71,25,110,32,0,168,208,235,242,96,
65,44,102,75,204,63,244,209,66,75,37,202,174,214,4,67,68,205,151,245,44,152,37,
180,69,235,243,132,185,121,87,37,71,186,8,184,85,127,155,150,72,126,155,89,110,
188,242,7,74,24,66,221,197,84,94,121,75,122,187,95,108,125,223,234,76,136,148,
92,198,125,119,92,78,51,104,248,162,176,39,206,79,62,72,204,98,133,241,63,81,
172,113,22,152,64,235,176,82,239,108,251,36,32,236,33,84,65,184,252,176,59,252,
146,85,105,87,20,139,10,191,5,64,174,221,212,184,100,142,29,64,6,177,111,191,
229,21,52,64,88,58,39,46,144,76,75,64,143,51,112,153,56,141,98,64,143,192,144,
86,220,54,121,64,170,221,174,90,136,34,145,64,110,12,71,125,234,73,167,64,130,
15,71,124,21,167,191,64,96,5,149,207,157,130,213,64,127,79,238,136,68,60,237,
64,154,124,211,84,22,222,3,65,85,201,106,145,181,0,27,65,215,5,191,72,172,89,
50,65,135,42,173,175,204,240,72,65,237,52,125,87,43,8,241,63,205,245,182,69,96,
33,242,63,53,88,11,23,184,76,243,63,134,129,62,60,94,139,244,63,245,95,4,118,
145,222,245,63,106,239,219,19,165,71,247,63,16,0,123,71,2,200,248,63,156,6,30,
142,41,97,250,63,70,100,37,49,180,20,252,63,192,227,128,223,85,228,253,63,201,
248,130,97,222,209,255,63,248,220,103,180,157,239,0,64,24,213,27,63,61,7,2,64,
40,43,182,135,229,48,3,64,56,83,78,79,192,109,4,64,119,85,171,2,8,16,240,63,70,
4,96,21,32,32,240,63,119,32,54,72,72,48,240,63,57,222,85,171,128,64,240,63,7,
162,247,78,201,80,240,63,221,16,100,67,34,97,240,63,133,32,244,152,139,113,240,
63,237,39,17,96,5,130,240,63,145,239,52,169,143,146,240,63,246,193,233,132,42,
163,240,63,50,124,202,3,214,179,240,63,140,158,130,54,146,196,240,63,31,93,206,
45,95,213,240,63,157,176,122,250,60,230,240,63,27,103,101,173,43,247,240,63,171,
42,0,8,0,1,240,63,96,85,1,32,0,2,240,63,54,128,4,72,0,3,240,63,85,171,10,128,
0,4,240,63,246,214,20,200,0,5,240,63,96,3,36,32,1,6,240,63,236,48,57,136,1,7,
240,63,1,96,85,0,2,8,240,63,24,145,121,136,2,9,240,63,185,196,166,32,3,10,240,
63,123,251,221,200,3,11,240,63,8,54,32,129,4,12,240,63,23,117,110,73,5,13,240,
63,114,185,201,33,6,14,240,63,239,3,51,10,7,15,240,63 
}; 
    double aa,bb,cc,dd,ff,gg; 
    double xx,yy; 
    double vv; 

    long a,b,c,d,f,g; 
    long flag; 

    double *exp_pnt; 

    exp_pnt = (double *) exp_val; 
    flag = 0; 

    if (x == 0.0)  return (1.0); 
    if (x > 709.783995)  return (1.7e308); 
    if (x < -709.783995) return (1.1e-308); 
    if (x < 0.0)  { 
        x = 0.0 - x; 
        flag = 1; 
    } 
/* 
&dA &d@   Step 1: Determine values of a,b,c,d,f,g 
*/ 
    a = 0; 
    b = 0; 
    c = 0; 
    d = 0; 
    f = 0; 
    g = 0; 
    xx = x; 
    if (xx >= 16.0)   { 
        while (xx >= 256.0)  { 
            xx -= 256.0; 
            ++a; 
        } 
        while (xx >= 16.0)  { 
            xx -= 16.0; 
            ++b; 
        } 
    } 
    while (xx >= 1.0)  { 
        xx -= 1.0; 
        ++c; 
    } 
    while (xx >= 0.0625)  { 
        xx -= 0.0625; 
        ++d; 
    } 
    while (xx >= 0.00390625)  { 
        xx -= 0.00390625;             
        ++f; 
    } 
    while (xx >= 0.000244140625)  { 
        xx -= 0.000244140625; 
        ++g; 
    } 
/* 
&dA &d@   Step 2: Get anchor factors for a,b,c,d,f,g 
*/ 
    aa = 1.0; 
    bb = 1.0; 
    cc = 1.0; 
    dd = 1.0; 
    ff = 1.0; 
    gg = 1.0; 

    if (a > 0)  { 
        --a; 
        aa = *(exp_pnt + a); 
    } 
    if (b > 0)  { 
        b += 1; 
        bb = *(exp_pnt + b); 
    } 
    if (c > 0)  { 
        c += 16; 
        cc = *(exp_pnt + c); 
    } 
    if (d > 0)  { 
        d += 31; 
        dd = *(exp_pnt + d); 
    } 
    if (f > 0)  { 
        f += 46; 
        ff = *(exp_pnt + f); 
    } 
    if (g > 0)  { 
        g += 61; 
        gg = *(exp_pnt + g); 
    } 
/* 
&dA &d@   Step 3: Construct residual factor from xx 
*/ 
    vv = xx * xx * 0.5; 
    yy = 1.0 + xx + vv + (xx * vv / 3.0); 
    if (xx > .0000185)  { 
        yy += (vv * vv / 6.0); 
    } 
/* 
&dA &d@   Step 4: Assemble final value for exp(x) 
*/ 
    yy = yy * aa * bb * cc * dd * ff * gg; 
    if (flag == 1)   yy = 1.0 / yy; 
    return (yy); 
} 

/*** FUNCTION   double my_log(double x); 

    Purpose:   compute the value of ln(x)

    Input:     double x.    x > 0

    Return:    ln(x) 
                                                                  ***/ 

double my_log(double x) 
{ 
    static char exp_val[1000] = { 
46,133,186,4,101,71,25,110,186,190,20,136,122,28,4,87,24,66,221,197,84,94,121,
75,205,151,245,44,152,37,180,69,44,102,75,204,63,244,209,66,32,0,168,208,235,
242,96,65,110,12,71,125,234,73,167,64,88,58,39,46,144,76,75,64,174,221,212,184,
100,142,29,64,105,87,20,139,10,191,5,64,156,6,30,142,41,97,250,63,134,129,62,
60,94,139,244,63,205,245,182,69,96,33,242,63,237,52,125,87,43,8,241,63,237,39,
17,96,5,130,240,63,57,222,85,171,128,64,240,63,70,4,96,21,32,32,240,63,119,85,
171,2,8,16,240,63,1,96,85,0,2,8,240,63,85,171,10,128,0,4,240,63,96,85,1,32,0,
2,240,63 
}; 
    double aa,bb,cc,dd,ee,ff,gg,hh; 
    double xx,yy; 
    double ss,tt,uu,vv,ww; 

    long c; 
    long flag; 

    double *exp_pnt; 

    exp_pnt = (double *) exp_val; 
    flag = 0; 

    if (x == 1.0)  return (0.0); 
/* 
&dA &d@   Step 1: Split off case where .89 < x < 1.11 
*/ 
    if ( (x > .89) && (x < 1.11) )  { 
        xx = x - 1.0; 
        uu = xx * xx; 
        vv = uu * xx; 
        ww = vv * xx; 
        tt = ww * ww; 
        ss = tt * ww; 
        aa = 1.0 - (xx / 2.0); 
        bb = (uu / 3.0) - (vv / 4.0); 
        cc = (ww / 5.0) - (ww * xx / 6.0); 
        dd = (vv * vv / 7.0) - (ww * vv / 8.0); 
        ee = (tt / 9.0) - (tt * xx / 10.0); 
        ff = (tt * uu / 11.0) - (tt * vv / 12.0); 
        gg = (ss / 13.0) - (ss * xx / 14.0); 
        hh = (ss * uu / 15.0) - (ss * vv / 16.0); 
        yy = aa + bb + cc + dd + ee + ff + gg + hh; 
        yy *= xx; 
        return (yy); 
    } 

    if (x < 1.0)  { 
        x = 1 / x; 
        flag = 1; 
    } 
/* 
&dA &d@   Step 2: Express x = e(aa) * xx, where e(1/2048) > xx > 1 
*/ 
    c = 0; 
    bb = 512.0; 
    aa = 0.0; 
    xx = x; 

    while (xx > 1.0005)  { 
        cc = *(exp_pnt + c); 
        ++c; 
        if (xx > cc)  { 
            xx /= cc; 
            aa += bb; 
        } 
        bb /= 2.0; 
    } 
/* 
&dA &d@   Step 3: Verify that x = e(aa) * xx, where e(1/2048) > xx > 1 
*/ 
    vv = my_exp(aa); 
    xx = x / vv; 
    while (xx < 1.0)  {      /* this condition should be "extremely rare" */
        bb *= 2.0;           /* get "last" bb back */ 
        aa -= bb; 
        vv = my_exp(aa); 
        xx = x / vv; 
    } 
/* 
&dA &d@   Step 4: Construct residual factor: yy = ln(xx) 
*/ 
    xx -= 1.0; 
    uu = xx * xx; 
    vv = uu * xx; 
    yy = 1.0 - (xx / 2.0) + (uu / 3.0) - (vv / 4.0); 
    yy *= xx; 
/* 
&dA &d@   Step 5: Assemble final value for exp(x) 
*/ 
    yy += aa; 
    if (flag == 1)   yy = 0.0 - yy; 
    return (yy); 
} 

/*** FUNCTION   double my_sqrt(double x); 

    Purpose:   compute the value of sqrt(x) 

    Input:     double x.    x >= 0 

    Return:    sqrt(x) 
                                                                  ***/ 

double my_sqrt(double x) 
{ 
    double   aa,bb,dd,ee; 
    double   xx,yy; 
    long     kk; 

    if (x <= 0.0)   return (0.0); 
/* 
&dA &d@ Step 1:  Examine the exponent.  put x in the form x = aa * aa * xx, where 
&dA &d@          aa is a power of 2 and 4 > xx > 1.  
*/ 
    aa = 1.0; 
    xx = x; 
    if (xx >= 4.0)  { 
        while (xx >= 16.0)  { 
            xx /= 16.0; 
            aa *= 4.0; 
        } 
        while (xx >= 4.0)  { 
            xx /= 4.0; 
            aa *= 2.0; 
        } 
    } 
    else  { 
        while (xx < 0.25)  { 
            xx *= 16.0; 
            aa /= 4.0; 
        } 
        while (xx < 1.0)  { 
            xx *= 4.0; 
            aa /= 2.0; 
        } 
    } 
/* 
&dA &d@ Step 2:  Reduce the size of xx to 1.21 or less
*/ 
    if (xx > 2.56)  { 
        if (xx > 3.24)  { 
            if (xx > 3.61)  { 
                xx /= 3.61; 
                aa *= 1.9; 
                goto MSQR1; 
            } 
            xx /= 3.24; 
            aa *= 1.8; 
            goto MSQR1; 
        } 
        if (xx > 2.89)  { 
            xx /= 2.89; 
            aa *= 1.7; 
            goto MSQR1; 
        } 
        xx /= 2.56; 
        aa *= 1.6; 
        goto MSQR1; 
    } 
    if (xx > 1.44)  { 
        if (xx > 1.96)  { 
            if (xx > 2.25)  { 
                xx /= 2.25; 
                aa *= 1.5; 
                goto MSQR1; 
            } 
            xx /= 1.96; 
            aa *= 1.4; 
            goto MSQR1; 
        } 
        if (xx > 1.69)  { 
            xx /= 1.69; 
            aa *= 1.3; 
            goto MSQR1; 
        } 
        xx /= 1.44; 
        aa *= 1.2; 
        goto MSQR1; 
    } 
    if (xx > 1.21)  { 
        xx /= 1.21; 
        aa *= 1.1; 
        goto MSQR1; 
    } 
MSQR1: 
/* 
&dA &d@ Step 3:  Run the iteration formula on xx       
*/ 
    yy = xx - 1.0; 
    ee = 2.0 + yy; 
    bb = yy / 2.0; 
    for (kk = 0; kk < 7; ++kk)  { 
        dd = bb * (bb + 2.0) - yy; 
        dd /= ee; 
        bb -= dd; 
    } 
    bb += 1.0; 
    yy = aa * bb; 

    return (yy); 
} 

/*** FUNCTION   double my_pow(double x, double y); 

    Purpose:   compute the value of x to the y power 

    Input:     double x.    x > 0

    Return:    x to the y power, if result is less than 10(308) 
               10(308) othersize 
                                                                  ***/ 

double my_pow(double x, double y) 
{ 
    static double  aa,bb,cc,dd,ee; 

    static double *dpnt; 

    static unsigned long *gpnt1; 
    static unsigned long *gpnt2; 

    static unsigned char *sp1; 

    static long gg,hh,ii,jj,kk,nn; 
    static unsigned char real_num1[8]; 

    if (y == 0)    return (1.0); 
    if (x <= 0.0)  return (0.0); 
    if (y < 0)  { 
        x = 1 / x; 
        y = 0.0 - y; 
    } 

    aa = my_log(x); 
    aa *= y; 
    if (aa > 709.2)  return (1.0e308); 
    bb = my_exp(aa); 
/* 
&dA &d@   This section added to bring integer accuracy up for 
&dA &d@   values between 10(14) and 10(25).  y must be integer < 250 
*/ 
    if (y > 1)  { 
        dd = y; 
        dpnt = &dd; 
        sp1 = (unsigned char *) dpnt; 
        gpnt1 = (unsigned long *) dpnt; 
        gpnt2 = gpnt1 + 1; 

        ii = *(sp1+7); 
        jj = *(sp1+6); 
        jj >>= 4; 
        ii <<= 4; 
        ii += jj; 
        kk = 1075 - ii;     /* kk = number of trailing zeros in the mantissa
                                      in order for y to be an integer */ 
        if (kk < 0)  { 
            kk = 0; 
        } 
        if (kk > 31)  { 
            if (*gpnt1 != 0)  goto YNOINT; 
            kk -= 32; 
            jj = *gpnt2; 
            jj <<= (32 - kk); 
            if (jj != 0)  goto YNOINT; 
        } 
        else  { 
            jj = *gpnt1; 
            jj <<= (32 - kk); 
            if (jj != 0)  goto YNOINT; 
        } 
        bb = 1.0; 
        for (aa = 0.0; aa < y; aa += 1.0)  { 
            bb *= x; 
        } 
        return (bb); 
    } 
YNOINT: 

    cc = bb * 1.000000000000005; 
    ee = bb * 0.999999999999995; 
/* 
&dA &d@   Question: Is there an integer between bb and cc?  
&dA &d@   Answer:  Look at cc, construct (if you can) the next integer 
&dA &d@            that is smaller than cc.  If this is bigger than bb, 
&dA &d@            the answer is "yes" 
*/ 
    dd = cc; 
    dpnt = &cc; 
    sp1 = (unsigned char *) dpnt; 
    gpnt1 = (unsigned long *) dpnt; 
    gpnt2 = gpnt1 + 1; 

    ii = *(sp1+7); 
    jj = *(sp1+6); 
    jj >>= 4; 
    ii <<= 4; 
    ii += jj; 
    kk = 1075 - ii;     /* kk = number of trailing zeros in the mantissa */ 

    sp1 = real_num1; 
    if (kk > 31)  { 
        *sp1 = 0; 
        *(sp1+1) = 0; 
        *(sp1+2) = 0; 
        *(sp1+3) = 0; 

        kk -= 32; 
        hh = *gpnt2; 
        gg = 0xffffffff << kk; 
        hh &= gg; 

        *(sp1+4) = hh & 0xff; 
        *(sp1+5) = (hh & 0xff00) >> 8; 
        *(sp1+6) = (hh & 0xff0000) >> 16; 
        *(sp1+7) = (hh & 0xff000000) >> 24; 
    } 
    else  { 
        hh = *gpnt1; 
        gg = 0xffffffff << kk; 
        hh &= gg; 

        *(sp1)   = hh & 0xff; 
        *(sp1+1) = (hh & 0xff00) >> 8; 
        *(sp1+2) = (hh & 0xff0000) >> 16; 
        *(sp1+3) = (hh & 0xff000000) >> 24; 

        hh = *gpnt2; 

        *(sp1+4) = hh & 0xff; 
        *(sp1+5) = (hh & 0xff00) >> 8; 
        *(sp1+6) = (hh & 0xff0000) >> 16; 
        *(sp1+7) = (hh & 0xff000000) >> 24; 
    } 
    dpnt = (double *) real_num1; 
    dd = *dpnt; 

    if (dd > ee)  bb = dd; 

    for (ii = 0; ii < nn; ++ii)  { 
        bb *= 2.0; 
    } 

    return (bb); 
} 
