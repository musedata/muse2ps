/***                         DMUSE PROGRAM 
                           LINUX version 1.02 
         (c) Copyright 1992, 1999, 2007, 2009 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 09/18/2007) 
                            (rev. 04/24/2009) 
                            (rev. 12/27/2009) 
                            (rev. 03/05/2010) 
                            (rev. 04/03/2010) 
                            (rev. 11/27/2010) 

                  Zbex Interpreter processing functions 
                                                                        ***/ 
#include  "all.h" 

/***              Description of the Table variable 

The table variable starts with seven parameters in links memory.  These 
are:   
    1. maximum table size 
    2. current table size 
    3. pointer to index (in main memory) 
    4. pointer to first data block (allocated with calloc at run time) 
    5. table block size (a constant) 
    6. next free word in the data block 
    7. offset to next data group 

Parameters 6 and 7 are cumulative offsets, i.e. they may be many times 
the block size.  In order to get to the right block, we have to go down 
a "chain", subtracting the block size from the offset for each link in 
the chain we pass.  The blocks are "forward chained" together by means of 
a pointer in the first word of the block (the NULL pointer means that this 
is the last block in the chain).  When a block is full, calloc is called to 
get a new block, and the new (direct memory) pointer is placed in word 0 
of the block.  Data in the blocks is stored in variable length groups.  
The structure of these groups is as follows: 

    word 1:       high order bytes (bits 31--8) 
                    Length of this table entry (in words) 
                  low order byte   (bits 7--0) 
                    Length of key (in bytes) 

    words 2--x:   Key    (x = (keylen+3)/4 + 1) 

    word x+1:     Length of record (in bytes) 

    word x+2--:   Record 

This representation would be entirely stable, if not for the fact that 
the record size is allowed to change dynamically at run-time.  If the 
record gets smaller, this presents no problem, but if the record expands, 
it may exceed the space that was originally allocated for it.  When this 
happens, the record length word (x+1) is set to -1, and the first word 
of record storage (word x+2) is used to store a new global offset to 
an extended data group.  The extended data group is structured as 
follows: 

    word 1:       high order bytes (bits 31--8) 
                    Length of this table entry (in words) 
                  low order byte   (bits 7--0) = 0xff 

    word 2:       Length of extended record 

    word 3--:     Space for extended record 

If the record is expanded further, this space is abandoned for new space.  
No garbage collection is attempted, an admitted shortcoming in this 
implementation.  

There are three ways table variable data may be accessed: (1) sequential 
access, (2) access by key, and (3) access by index number.  

1. Sequential access.  

The important parameter here is #7, the offset to the next data group.  
This variable is initialized to the first group by the table stat 
instruction.  This instruction also gives the total number of table 
entries.  Successive calls by the sequential access instruction will 
then retrieve successive <key,record> data pairs.  It is up to the 
user not to make more sequential access calls than there are groups 
in the table.  The sequential access call starts with the offset to 
the next group in the data.  Since this group may in fact be an extend 
data group (from some previous data group), the routine must first 
check the Key length byte.  If it is 0xff, the group should be skipped.  
By the way, this also provides a mechanism for "removing" a data group 
from the set.  

2. Access by key 

Given a certain key, the program can calculate a hash number, which can 
be used as an offset into the table index.  The table index contains 
cumulative offsets into the database.  Because of the way hash tables 
work, the key in the data group needs to be check against the source 
key.  If they are different, the index needs to be incremented by the 
secondary hash value and a new index value tried, etc.  

3. Access by index number 

This feature is used mainly to implement a variable record length, 
random access file in memory.  The index is the record number.  

Retrieving data from the database must be done with caution, since it 
is possible that a data group may extend over one or more blocks.  
When this happens, the extraction process is more involved, since we 
must check after every word to see if we have reached the end of the 
data block.  
                                                                ***/ 

/*** FUNCTION   void Zinstruction31(); 

    Purpose:   process instruction 31: sequential access of data 

    Input:    (element  IPC)  union pointer to table address in i-code 

    Return:    void 

    Output:   (element  IPC)  updated union pointer in i-code 

                                                               ***/ 
void Zinstruction31() 
{ 
    extern element IPC; 

    element pt; 
    element savept;      
    element TIPC; 
    long    g, h, i, k; 
    long    kk;                        /* New &dA04/24/09&d@ */ 
/*  long    mtz, ctz;  */ 
    long              tbz, xfw, xdg;   /* table parameters  */ 
    long    mlen1, mlen2, nxop; 
    long   *ip1, *ip2; 
    long   *xdgpoint; 

/*  (1) get program data */ 

/*  mtz =    *(*IPC.p + 0);      maximum table size       */ 
/*  ctz =    *(*IPC.p + 1);      current table size       */ 
/*  tix =    *(*IPC.q + 2);      pointer to index         */ 
    pt.n =   *(*IPC.q + 3);   /* pointer to first block   */ 
    savept.n = pt.n;                                            
    tbz =    *(*IPC.p + 4);   /* table block size         */ 
    xfw =    *(*IPC.p + 5);   /* next free word           */ 
    xdgpoint = *IPC.p + 6; 
    xdg =    *xdgpoint;          /* next data group          */ 
    TIPC.n = IPC.n++; 
    Zidgenstr(&ip1, &mlen1, &i, &i, &nxop, &kk, 1L); 
    Zidgenstr(&ip2, &mlen2, &i, &i, &nxop, &kk, 1L); 

/*  (2) skip extended records */ 

    while (1) { 
        if (xdg == xfw)  { 
            tgeterr1(TIPC.n);  /* report on attempt to sequentially 
                                  access data beyond last data group */ 
        } 
        h = xdg; 
        while (h > tbz)  {     /* skip to correct block */ 
            pt.n = *(pt.p); 
            h -= tbz; 
        } 
        k = *(pt.n + h); 
        g = k & 0xff;          /* g = byte length of key */ 
        k >>= 8; 
        *xdgpoint += k;        /* update sequential pointer */ 
        if (g != 0xff)  break; 
        xdg += k; 
        pt.n = savept.n;       /* adding this code &dA04/16/06&d@ */ 
    } 

/*  (3) move key and record to target strings.  
          pt changed to savept in function below &dA04/16/06&d@ */ 

    get_table_data(savept, tbz, xdg, ip1, ip2, mlen1, mlen2, 3); 

    return; 
} 

/*** FUNCTION   void Zinstruction32(); 

    Purpose:   process instruction 32 tget [table, str] str 
                 (data access by key) 

    Input:    (element   IPC)  union pointer to table address in i-code 

    Return:    void 

    Output:   (element   IPC)  updated union pointer in i-code 

                                                                  ***/ 
void Zinstruction32() 
{ 
    extern element IPC; 
    extern char    bigbuf[]; 

    element   pt; 
    element   savept; 
    long      g, h, i; 
    long      k1, k2; 
/*  long           ctz,      xfw, xdg; */ 
    long      mtz,      tbz;              /* table parameters  */
    long      mlen1, nxop; 
    long     *tix; 
    long     *ip1, *ip2; 
    char     *sp1; 

/*  (1) get program data  */ 

    mtz =    *(*IPC.p + 0);   /* maximum table size       */ 
/*  ctz =    *(*IPC.p + 1);      current table size       */ 
    tix =    *(*IPC.q + 2);   /* pointer to index         */ 
    pt.n =   *(*IPC.q + 3);   /* pointer to first block   */ 
    savept.n = pt.n; 
    tbz =    *(*IPC.p + 4);   /* table block size         */ 
/*  xfw =    *(*IPC.p + 5);      next free word           */ 
/*  xdg =    *(*IPC.p + 6);      next data group          */ 
    ++IPC.n; 
    Zidsubstr(&sp1, &mlen1, &nxop, &i); 

/*  (2) compute hash index from key   */ 

    compute_hash(sp1, mlen1, mtz, &k1, &k2); 

/*  (3) search for key in data  */ 

I32search: 

    h = *(tix + k1); 
    pt.n = savept.n; 

    if (h == 0)  {              /* key not present  */ 
        Zline_input(bigbuf, 0); 
                                /* return null data */ 
        return; 
    } 

    ip1 = (long *) bigbuf; 
    get_table_data(pt, tbz, h, ip1, ip1, 256, 256, 1L); 

    g = *ip1++; 
    if ( ( (g != mlen1) || (memcmp( (char *) sp1, (char *) ip1, (size_t) g) ) ) != 0)  {
        k1 += k2; 
        k1 = k1 % mtz;    /* secondary hash */ 
        goto I32search; 
    } 

/*  (4) get record */           /* you may want to fix this somewhat */ 
                                   /* (omit bigbuf step) */ 
    ip2 = (long *) bigbuf; 
    get_table_data(pt, tbz, h, ip2, ip2, 256, (long) BUFZ, 2); 
    g = *ip2++; 
    Zline_input((char *)ip2, g); 
    return; 
} 

/*** FUNCTION   void Zinstruction33(); 

    Purpose:   process instruction 33 tget [table,int] str 
                 (access by index number) 

    Input:    (element IPC)   union pointer to table address in i-code 

    Return:    void 

    Output:   (element IPC)   updated union pointer in i-code 

                                                                  ***/ 
void Zinstruction33() 
{ 
    extern element IPC; 
    extern char    bigbuf[]; 

    element  pt; 
    element  TIPC; 
    long      g, h, k; 
/*  long           ctz,      xfw, xdg; */ 
    long      mtz,      tbz;              /* table parameters  */
    long     *tix; 
    long     *ip2; 
     
/*  (1) get program data  */ 

    mtz =    *(*IPC.p + 0);   /* maximum table size       */ 
/*  ctz =    *(*IPC.p + 1);      current table size       */ 
    tix =    *(*IPC.q + 2);   /* pointer to index         */ 
    pt.n =   *(*IPC.q + 3);   /* pointer to first block   */ 
    tbz =    *(*IPC.p + 4);   /* table block size         */ 
/*  xfw =    *(*IPC.p + 5);      next free word           */ 
/*  xdg =    *(*IPC.p + 6);      next data group          */ 
    TIPC.n = IPC.n++; 
    k = Zgenintex(); 
    --k;                         /* adjust key to fit table */ 

/*  (2) check range of index */ 

    if (k < 0 || k >= mtz)  { 
        tgeterr2(k, mtz, TIPC.n);  /* index out of range */ 
    } 

    h = *(tix + k); 

    if (h == 0)  {               /* record not present  */ 
        Zline_input(bigbuf, 0); 
                                 /* return null data    */ 
        return; 
    } 

/*  (3) get record */           /* you may want to fix this somewhat */ 
                                   /* (omit bigbuf step) */ 
    ip2 = (long *) bigbuf; 
    get_table_data(pt, tbz, h, ip2, ip2, 256, (long) BUFZ, 2); 

    g = *ip2++; 
    Zline_input((char *) ip2, g); 

    return; 
} 

/*** FUNCTION   void get_table_data(pt, tbz, h, ip1, ip2, max1, max2, mode); 

    Purpose:   get data from table 

    Input:     element pt     union pointer to first table block; 
               long    tbz    table block size 
               long    h      global offset to desired group 
               long    max1   maximum length allowed for key (bytes)  
               long    max2   maximum length allowed for record (bytes) 
               long    mode   1 = get key only 
                              2 = get record only 
                              3 = get key and record 

    Output     long   *ip1    destination for key 
               long   *ip2    destination for record 

    Return:    void
                                                                 ***/ 

void get_table_data(element pt, long tbz, long h, long *ip1, long *ip2, 
    long max1, long max2, long mode) 
{ 
    element savept; 
    long    f, g, k; 
    long   *ip3; 
    long    save_h; 

    savept.n = pt.n; 
    while (h > tbz)  {     /* skip to correct block */ 
        pt.n = *(pt.p); 
        h -= tbz; 
    } 
    ip3 = pt.n + h;        /* pointer to group */ 
    k = *ip3++; 
    g = k & 0xff;          /* g = byte length of key */ 
    f = g + 7; 
    f >>= 2;               /* f = increment to record part of group */ 
    k >>= 8;               /* k = size of group      */ 

    if (h + k - 1 <= tbz)  { 

  /* case I: data group inside one block */ 

        if ((mode & 1) != 0)  {      /* get key */ 
            get_tdata_fast(ip1, ip3, g, max1); 
        } 
        if ((mode & 2) != 0)  {      /* get record */ 
            ip3 = pt.n + h + f; 
            g = *ip3++; 
            if (g >= 0)  { 
                get_tdata_fast(ip2, ip3, g, max2); 
            } 
            else { 
                h = *ip3;            /* new global offset */ 
                goto EXT; 
            } 
        } 
    } 
    else { 

  /* case II: data group spans more than one block */ 

        save_h = h; 
        if ((mode & 1) != 0)  {      /* get key */ 
            ++h; 
            get_tdata_slow(ip1, g, max1, pt, h, tbz); 
        } 
        if ((mode & 2) != 0)  {      /* get record */ 

            h = save_h;              /* Need to add this &dA04/16/06&d@  */ 
            h += f; 

            while (h > tbz) { 
                pt.n = *(pt.p); 
                h -= tbz; 
            } 
            g = *(pt.n + h++); 

            if (g >= 0)  { 
                get_tdata_slow(ip2, g, max2, pt, h, tbz); 
            } 
            else { 
                if (h > tbz) { 
                    pt.n = *(pt.p); 
                    h -= tbz; 
                } 
                h = *(pt.n + h);     /* new global offset */ 

                goto EXT; 
            } 
        } 
    } 
    return; 

EXT: 
    pt.n = savept.n; 
    while (h > tbz)  {     /* skip to correct block */ 
        pt.n = *(pt.p); 
        h -= tbz; 
    } 
    ip3 = pt.n + h;        /* pointer to group */ 
    k = *ip3++; 
    k >>= 8; 
    if (h + k - 1 <= tbz)  { 

  /* case I: extended record is inside one block */ 

        g = *ip3++; 
        if (g >= 0)  { 
            get_tdata_fast(ip2, ip3, g, max2); 
        } 
    } 
    else { 

  /* case II: extended record spans more than one block */ 

        ++h; 
        if (h > tbz) { 
            pt.n = *(pt.p); 
            h -= tbz; 
        } 
        g = *(pt.n + h++); 
        if (g >= 0)  { 
            get_tdata_slow(ip2, g, max2, pt, h, tbz); 
        } 
    } 
    return; 
} 

/*** FUNCTION   void get_tdata_fast(ip1, ip2, len, max); 

    Purpsose:  transfer data from within a single block 

    Input:     long  *ip1   destination 
               long  *ip2   pointer to data to transfer 
               long   len   length in bytes 
               long   max   maximum length to transfer 
                                                               ***/ 
void get_tdata_fast(long *ip1, long *ip2, long len, long max) 
{ 
    long i; 

    if (len > max) len = max; 
    *ip1++ = len;   /* record length */
    len += 3; 
    len >>= 2;     /* convert len to word length */ 
    for (i = 0; i < len; ++i) { 
        *ip1++ = *ip2++; 
    } 
} 

/*** FUNCTION   void get_tdata_slow(ip1,len, max, pt, h, tbz); 

    Purpsose:  transfer data spanning multiple blocks 

    Input:     long   *ip1   destination 
               long    len   length in bytes 
               long    max   maximum length to transfer 
               element pt    pointer to current block; 
               long    h     current offset within block; 
               long    tbz   block size 
                                                               ***/ 
void get_tdata_slow(long *ip1, long len, long max, element pt, 
    long h, long tbz) 
{ 
    long i; 

    if (len > max) len = max; 
    *ip1++ = len;  /* record length */ 
    len += 3; 
    len >>= 2;     /* convert len to word length */ 
    for (i = 0; i < len; ++i) { 
        if (h > tbz)  { 
            pt.n = *(pt.p); 
            h -= tbz;           /* min(h) = 1 */ 
        } 
        *ip1++ = *(pt.n + h++); 
    } 
} 

/*** FUNCTION   void compute_hash(*sp1, len, mtz, *k1, *k2); 

    Purpose:   compute hash numbers k1 and k2 

    Input:     char  *sp1   pointer to key 
               long   len   length of key 
               long   mtz   maximum table size 

    Output:    long  *k1    primary hash number 
               long  *k2    secondary hash number 
                                                            ***/ 

void compute_hash(char *sp1, long len, long mtz, long *k1, long *k2) 
{ 
    long   a, b, f, h, i; 
    long  *ip1; 

    ip1 = (long *) sp1; 
    if (len > 0) { 
        h = len >> 2; 
        for (i = 0, a = 0; i < h; ++i)  { 
            a += *ip1++; 
        } 
        f = (len & 0x03); 
        f <<= 3; 
        i = 1 << f; 
        --i;                  /* i = mask is Intel 386 dependent */ 
        a += *ip1 & i; 
        a *= 0x9e43a7b9; 
        b = a >> 4; 
        b &= 0x3fff; 
        *k2 = b | 1; 
        a >>= 18; 
        a &= 0x3fff; 
        *k1 = a % mtz; 
    } 
    else { 
        *k1 = 0; 
        *k2 = 1; 
    } 
} 

/*** FUNCTION   long Ztdxfunc(); 

    Purpose:   retrieve index value for given key 

    Input:    (element IPC)   union pointer to table address in i-code 

    Return:    long           index value (0 = key not present) 

    Output:   (element IPC)   updated union pointer in i-code 

                                                                  ***/ 

long Ztdxfunc() 
{ 
    extern element IPC; 

    element  pt; 
    element  savept; 
    long     g, h; 
    long     k1, k2; 
/*  long           ctz,      xfw, xdg; */ 
    long      mtz,      tbz;              /* table parameters  */
    long      mlen1, nxop; 
    long     *tix; 
    char     *sp1; 
    long      temp[70]; 
    long     *ip1; 
    long      val; 

/*  (1) get program data  */ 

    mtz =    *(*IPC.p + 0);   /* maximum table size       */ 
/*  ctz =    *(*IPC.p + 1);      current table size       */ 
    tix =    *(*IPC.q + 2);   /* pointer to index         */ 
    pt.n =   *(*IPC.q + 3);   /* pointer to first block   */ 
    savept.n = pt.n; 
    tbz =    *(*IPC.p + 4);   /* table block size         */ 
/*  xfw =    *(*IPC.p + 5);      next free word           */ 
/*  xdg =    *(*IPC.p + 6);      next data group          */ 
    ++IPC.n; 
    Zidsubstr(&sp1, &mlen1, &nxop, &h); 

/*  (2) compute hash index from key   */ 

    compute_hash(sp1, mlen1, mtz, &k1, &k2); 

/*  (3) search for key in data */ 

TDXsearch: 

    h = *(tix + k1); 
    pt.n = savept.n; 

    if (h != 0)  { 
        ip1 = temp; 
        get_table_data(pt, tbz, h, ip1, ip1, 256, 256, 1L); 

        g = *ip1++; 

        if ( ( (g != mlen1) || (memcmp( (char *) sp1, (char *) ip1, (size_t) g) ) ) != 0)  {
            k1 += k2; 
            k1 = k1 % mtz;    /* secondary hash */ 
            goto TDXsearch; 
        } 
        val = k1 + 1; 
    } 
    else  val = 0;    /* if key not present, return value of 0 */ 
    return (val); 
} 

/*** FUNCTION   void Zinstruction34(); 

    Purpose:   process instruction 34  tput [table, str] str 

    Input:    (element IPC)  union pointer to table address in i-code 

    Return:    void 

    Output:   (element IPC)  updated union pointer in i-code 

                                                                ***/ 
void Zinstruction34() 
{ 
    extern element IPC; 
    extern char    bigbuf[]; 

    element  pt; 
    element  savept; 
    element  pt2; 
    element  TIPC; 
    long     f, g, h, k; 
    long     k1, k2; 
/*  long                          xdg; */ 
    long      mtz, ctz, tbz, xfw;         /* table parameters  */ 
    long      mlen1, mlen2, nxop; 
    long     *tix; 
    long     *ip1; 
    long     *xfwpoint, *ctzpoint; 
    long      temp[70]; 
    char     *sp1, *sp2; 

/*  (1) get program data  */ 

    mtz =    *(*IPC.p + 0);   /* maximum table size       */ 
    ctzpoint = *IPC.p + 1; 
    ctz =    *ctzpoint;          /* current table size       */ 
    tix =    *(*IPC.q + 2);   /* pointer to index         */ 
    pt.n =   *(*IPC.q + 3);   /* pointer to first block   */ 
    savept.n = pt.n; 
    tbz =    *(*IPC.p + 4);   /* table block size         */ 
    xfwpoint = *IPC.p + 5; 
    xfw =    *xfwpoint;          /* next free word           */ 
/*  xdg =    *(*IPC.p + 6);      next data group          */ 

    TIPC.n = IPC.n++; 
    if ((ctz * 10) / 9 > mtz)  { 
        tputerr1(ctz, mtz, TIPC.n);  /* to much data in table */ 
    } 
    Zidsubstr(&sp1, &mlen1, &nxop, &h); 
    if (mlen1 > 127)  mlen1 = 127; 

    mlen2 = 0; 
    Zline_output(bigbuf, &mlen2, &g); 
    sp2 = bigbuf; 

/*  (2) compute hash index from key */ 

    compute_hash(sp1, mlen1, mtz, &k1, &k2); 

/*  (3) search for key in data */ 

I34search: 

    h = *(tix + k1); 
    pt.n = savept.n; 

#if DEBUG 
/* 
printf("hash number = %ld, offset = %ld\n", k1, h); 
getch(); 
*/ 
#endif 

    if (h == 0)  goto I34new;   /* key not present, new entry  */ 

    ip1 = temp;
    get_table_data(pt, tbz, h, ip1, ip1, 256, 256, 1L); 

    g = *ip1++; 

    if ( ( (g != mlen1) || (memcmp( (char *) sp1, (char *) ip1, (size_t) g) ) ) != 0)  {
        k1 += k2; 
        k1 = k1 % mtz;    /* secondary hash */ 
        goto I34search; 
    } 

/*  (4) write data to table */ 

    write_table_data(pt, tbz, h, sp2, sp2, mlen2, mlen2, xfwpoint, 0); 
    return; 

I34new: 

    *(tix + k1) = xfw; 
    h = xfw; 
    pt.n = savept.n; 
    while (h > tbz)  { 
        pt.n = *(pt.p); 
        h -= tbz; 
    } 

    k = (mlen1 + 7) / 4 + (mlen2 + 15) / 4; 

    *xfwpoint += k;    /* update pointer to free byte */ 

    if (h + k > tbz) {   /* new block(s) must be added  */ 
        f = h + k; 
        pt2.p = pt.p; 
        while (f > tbz)  { 
            if ((*(pt2.p) = (long *) calloc ((unsigned long) (tbz + 1),
                    (size_t) sizeof (long))) == NULL)  { 
                mem_err();   /* not enough free memory for tables */ 
            } 

            if (zmem_push( *(pt2.p) ) == 1)  { 
                mem_err();   /* not enough free memory for tables */ 
            } 
            pt2.n = *(pt2.p); 
            f -= tbz; 
        } 
    } 

    *ctzpoint += 1;     /* increment current size  */ 

    write_table_data(savept, tbz, xfw, sp1, sp2, mlen1, mlen2, xfwpoint, 1L); 
    return; 
} 

/*** FUNCTION   void Zinstruction35(); 

    Purpose:   process instruction 35  tput [table, int] str

    Input:    (element IPC)  union pointer to table address in i-code 

    Return:    void 

    Output:   (element IPC)  updated union pointer in i-code 

                                                                ***/ 
void Zinstruction35() 
{ 
    extern element IPC; 
    extern char    bigbuf[]; 

    element  pt; 
    element  savept; 
    element  pt2; 
    element  TIPC; 
    long     f, g, h, k; 
    long     k1; 
/*  long           ctz,           xdg; */ 
    long      mtz,      tbz, xfw;         /* table parameters  */ 
    long      mlen2; 
    long     *tix; 
    long     *xfwpoint, *ctzpoint; 
    char     *sp2; 

/*  (1) get program data  */ 

    mtz =    *(*IPC.p + 0);   /* maximum table size       */ 
    ctzpoint = *IPC.p + 1; 
/*  ctz =    *ctzpoint;             current table size       */ 
    tix =    *(*IPC.q + 2);   /* pointer to index         */ 
    pt.n =   *(*IPC.q + 3);   /* pointer to first block   */ 
    savept.n = pt.n; 
    tbz =    *(*IPC.p + 4);   /* table block size         */ 
    xfwpoint = *IPC.p + 5; 
    xfw =    *xfwpoint;          /* next free word           */ 
/*  xdg =    *(*IPC.p + 6);      next data group          */ 

    TIPC.n = IPC.n++; 
    k1 = Zgenintex(); 
    --k1;                   /* adjust key to fit table */

    mlen2 = 0; 
    Zline_output(bigbuf, &mlen2, &g); 
    sp2 = bigbuf; 

/*  (2) check range of key   */ 

    if (k1 < 0 || k1 >= mtz)  { 
        tgeterr2(k1, mtz, TIPC.n);
    } 

    h = *(tix + k1); 

    if (h == 0)  {             /* data group not present */ 
        goto I35new;           /* new entry              */ 
    } 

/*  (3) write data to table */ 

    write_table_data(pt, tbz, h, sp2, sp2, 0, mlen2, xfwpoint, 0); 
    return; 

I35new: 

    *(tix + k1) = xfw; 
    h = xfw; 
    pt.n = savept.n; 
    while (h > tbz)  { 
        pt.n = *(pt.p); 
        h -= tbz; 
    } 
    k = (mlen2 + 19) / 4; 
    *xfwpoint += k;            /* update pointer to free byte  */ 

    if (h + k > tbz) {   /* new block(s) must be added  */ 
        f = h + k; 
        pt2.p = pt.p; 
        while (f > tbz)  { 
            if ((*(pt2.p) = (long *) calloc ((unsigned long) (tbz + 1), 
                    (size_t) sizeof (long))) == NULL)  { 
                mem_err();   /* not enough free memory for tables */ 
            } 

            if (zmem_push( *(pt2.p) ) == 1)  { 
                mem_err();   /* not enough free memory for tables */ 
            } 
            pt2.n = *(pt2.p); 
            f -= tbz; 
        } 
    } 

    *ctzpoint += 1;     /* increment current size  */ 

    write_table_data(savept, tbz, xfw, sp2, sp2, 0, mlen2, xfwpoint, 1L); 
    return; 
} 

/*** FUNCTION   void write_table_data(pt, tbz, h, sp1, 
                         sp2, len1, len2, xfwpoint, mode); 

    Purpose:   write data to table 

    Input:     element pt       union pointer to first table block; 
               long    tbz      table block size 
               long    h        global offset to desired group 
               char   *sp1      pointer to key 
               char   *sp2      pointer to record 
               long    len1     length of key (in butes) 
               long    len2     length of record (bytes) 
               long   *xfwpoint pointer to next free word (global offset) 
               long    mode     0 = write record only 
                                1 = write key and record (new entry) 

    Output:    long   *xfwpoint next free word (if new space needed) 

    Return:    void
                                                                 ***/ 

void write_table_data(element pt, long tbz, long h, char *sp1, 
    char *sp2, long len1, long len2, long *xfwpoint, long mode) 
{ 
    element savept; 
    element pt2; 
    long    f, g, i, k; 
    long   *ip1, *ip3; 
    long    space; 

    savept.n = pt.n; 
    while (h > tbz)  {     /* skip to correct block */ 
        pt.n = *(pt.p); 
        h -= tbz; 
    } 

/*  (1) get length of data group */ 

    if (mode == 1) { 
        f = (len1 + 7) / 4; 
        k = f + (len2 + 15) / 4; 
        space = len2;
    }
    else { 
        k = *(pt.n + h); 
        g = k & 0xff;          /* g = byte length of key */ 
        f = g + 7; 
        f >>= 2;               /* f = increment to record part of group */ 
        k >>= 8;               /* k = size of group      */ 
        space = (k - f - 1) << 2;  /* space in bytes         */ 
    } 

    if (h + k - 1 <= tbz)  { 

  /* case I: data group inside one block */ 

        if (mode == 1)  { 
            ip1 = pt.n + h; 
            *ip1++ = (k << 8) + len1; 
            memcpy((void *) ip1, (void *) sp1, (size_t) len1); /* key */  
        } 

      /* store record */ 

        ip1 = pt.n + h + f; 
        if (mode == 0 && *ip1 == -1) {  /* already in extended mode */ 
            ++ip1;        /* save pointer to extension */ 
            h = *ip1; 
            goto EXT1; 
        } 
        if (len2 <= space)  {    /* record will fit */ 
            *ip1++ = len2; 
            memcpy((void *) ip1, (void *) sp2, (size_t) len2); 
        } 
        else {                   /* happens only in case: mode = 0 */ 
            *ip1++ = -1; 
            *ip1 = *xfwpoint; 
            goto EXT2; 
        } 
    } 
    else { 

  /* Case II: new data stradles blocks (new blocks have already been added
             for the case where there is a new entry: i.e., for mode = 1 */ 

        if (mode == 1)  { 
            *(pt.n + h) = (k << 8) + len1;  /* lengths */ 
            ++h; 
            if (h > tbz)  { 
                pt.n = *(pt.p); 
                h -= tbz; 
            } 
            ip1 = (long *) sp1; 
            g = len1 + 3; 
            g >>= 2;            /* g = word length of key */ 
            for (i = 0; i < g; ++i)  { 
                *(pt.n + h) = *ip1++; 
                ++h; 
                if (h > tbz)  { 
                    pt.n = *(pt.p); 
                    h -= tbz; 
                } 
            } 
        } 
        else { 
            h += f; 
            while (h > tbz)  { 
                pt.n = *(pt.p); 
                h -= tbz; 
            } 
        } 

     /* store record */ 

        ip1 = pt.n + h; 
        if (mode == 0 && *ip1 == -1) {  /* already in extended mode */ 
            ++h; 
            if (h > tbz)  { 
                pt.n = *(pt.p); 
                h -= tbz; 
            } 
            ip1 = pt.n + h;    /* save pointer to extension */ 
            h = *ip1; 
            goto EXT1; 
        } 
        if (len2 <= space)  { 
            write_tdata_slow(sp2, len2, pt, h, tbz, 1L); 
        } 
        else {                 /* happens only when mode = 0 */ 
            *(pt.n + h) = -1; 
            ++h; 
            if (h > tbz)  { 
                pt.n = *(pt.p); 
                h -= tbz; 
            } 
            *(pt.n + h) = *xfwpoint; 
            goto EXT2; 
        } 
    } 
    return; 

EXT1: /* (mode = 0, only) Try to store record in present extension */ 

    pt.n = savept.n; 
    while (h > tbz)  {     /* skip to correct block */ 
        pt.n = *(pt.p); 
        h -= tbz; 
    } 
    ip3 = pt.n + h;        /* pointer to group */ 
    k = *ip3++; 
    k >>= 8; 
    space = (k - 2) << 2;  /* subtract 2 words (group leng, rec leng) */ 
    if (len2 > space)  {   /* record will not fit, need new extension */ 
        *ip1 = *xfwpoint;  /* write pointer in original space */ 
        goto EXT2; 
    } 

    if (h + k - 1 <= tbz)  { 

  /* case I: extended record is inside one block */ 

        *ip3++ = len2; 
        memcpy((void *) ip3, (void *) sp2, (size_t) len2); 
    } 
    else { 

  /* case II: extended record spans more than one block */ 

        ++h; 
        if (h > tbz) { 
            pt.n = *(pt.p); 
            h -= tbz; 
        } 
        write_tdata_slow(sp2, len2, pt, h, tbz, 1L); 
    } 
    return; 

EXT2: /* (here only when mode = 0) */ 

    pt.n = savept.n; 
    h = *xfwpoint; 
    while (h > tbz)  {     /* skip to correct block */ 
        pt.n = *(pt.p); 
        h -= tbz; 
    } 
    k = (len2 + 23) / 4;   /* length for new group */ 
    *xfwpoint += k;        /* increment free word pointer */ 

/* At this point, you &dNmust&d@ check to see if new blocks should be added 
                                            &dAcode added 01-21-93&d@      */ 

    if (h + k > tbz) {   /* new block(s) must be added  */ 
        f = h + k; 
        pt2.p = pt.p; 
    
        while (f > tbz)  { 
            if ((*(pt2.p) = (long *) calloc ((unsigned long) (tbz + 1), 
                    (size_t) sizeof (long))) == NULL)  { 
                mem_err();   /* not enough free memory for tables */ 
            } 

            if (zmem_push( *(pt2.p) ) == 1)  { 
                mem_err();   /* not enough free memory for tables */ 
            } 
            pt2.n = *(pt2.p); 
            f -= tbz; 
        } 
    } 

    ip3 = pt.n + h;        /* pointer to group */ 
    i = k << 8; 
    i += 0xff;             /* extended group flag */ 
    *ip3++ = i; 
    if (h + k - 1 <= tbz)  { 

  /* case I: extended record is inside one block */ 

        *ip3++ = len2; 
        memcpy((void *) ip3, (void *) sp2, (size_t) len2); 
    } 
    else { 

  /* case II: extended record spans more than one block */ 

        ++h; 
        if (h > tbz) { 
            pt.n = *(pt.p); 
            h -= tbz; 
        } 
        write_tdata_slow(sp2, len2, pt, h, tbz, 1L); 
    } 
    return; 
} 

/*** FUNCTION   void write_tdata_slow(sp1, len, pt, h, tbz, mode); 

    Purpsose:  write record to table when group spans multiple blocks 

    Input:     long   *sp1   source string 
               long    len   length in bytes 
               element pt    pointer to current block; 
               long    h     current offset within block; 
               long    tbz   block size 
               long    mode  0 = don't store length (case: key) 
                             1 = store length (case: record) 

                                                               ***/ 
void write_tdata_slow(char *sp1, long len, element pt, long h, long tbz, 
    long mode) 
{ 
    long  g, i; 
    long *ip1; 

    if (mode == 1)  *(pt.n + h) = len; 
    ip1 = (long *) sp1; 
    g = len + 3; 
    g >>= 2;            /* g = word length of data */ 
    for (i = 0; i < g; ++i)  { 
        ++h; 
        if (h > tbz)  { 
            pt.n = *(pt.p); 
            h -= tbz; 
        } 
        *(pt.n + h) = *ip1++; 
    } 
} 

/*** FUNCTION   void Zinstruction36(); 

    Purpose:   process instruction 36  reset [table] 

    Input:    (element IPC)   union pointer to table address in i-code 

    Return:    void 

    Output:   (element IPC)   updated union pointer in i-code 
                                                                ***/ 
void Zinstruction36() 
{ 
    extern element IPC; 

    element pt;
    element save_pt; 
    element save2_pt; 
    long    i; 
/*  long           ctz, tbz, xfw, xdg; */
    long      mtz;                        /* table parameters  */ 
    long     *tix; 
    long     *ip1, *ip2, *ip3; 
    long     *xfwpoint, *ctzpoint, *xdgpoint; 

/*  (1) get program data  */ 

    mtz =    *(*IPC.p + 0);   /* maximum table size       */ 
    ctzpoint = *IPC.p + 1; 
/*  ctz =    *ctzpoint;             current table size       */ 
    tix =    *(*IPC.q + 2);   /* pointer to index         */ 
    pt.n =   *(*IPC.q + 3);   /* pointer to first block   */ 
/*  tbz =    *(*IPC.p + 4);      table block size         */ 
    xfwpoint = *IPC.p + 5; 
/*  xfw =    *xfwpoint;             next free word           */ 
    xdgpoint = *IPC.p + 6; 
/*  xdg =    *(*IPC.p + 6);      next data group          */ 

    ++IPC.n; 

/*  (2) free storage space for this table  */ 

/* This code is being added on &dA01-21-93&d@.  It is supposed to selectively 
      "purge" the specific table blocks from the memory recovery chain. */ 

    save_pt.n = pt.n;       /* need this so we can "restart" at FREE_MORE */
    ip2 = pt.n; 

/* 
&dA &d@   Note:  The reason this was rewritten is that we need to delete on 
&dA &d@          a LIFO basis, because of the nature of the push-down storage 
&dA &d@          stack of zmem_push.  
*/ 

FREE_MORE: 

    pt.n = save_pt.n;       /* setup for "restart" */ 
    ip1 = *(pt.p); 
    ip3 = NULL;             /* this insures that the process will stop */ 
    while (ip1 != NULL)  { 
        ip3 = *(pt.p);          /* this will be last non-NULL pointer  */ 
        save2_pt.n = pt.n;      /* need this to set "next block" pointer to NULL */
        pt.n = *(pt.p); 
        ip1 = *(pt.p); 
    } 
    if (ip3 != NULL)  {         /* next block to remove */ 
        zmem_free_addr(ip3); 
        *(save2_pt.p) = NULL;             /* replace source of "ip3" with NULL */
        goto FREE_MORE;                   /* cycle back for more deletes       */
    } 

/*  *(pt.p) = NULL;  This was a bug; replaced with line below &dA09-30-93&d@ */ 

    *ip2 = 0; 

/*  (3) clear index table in main memory  */ 

    for (i = 0; i < mtz; ++i)  { 
        *(tix + i) = 0; 
    } 

/*  (4) reset table parameters */ 

    *ctzpoint = 0;            /* current table size = 0 */ 
    *xfwpoint = 1;            /* next free word     = 1 */ 
    *xdgpoint = 1;            /* next data group    = 1 */ 

    return; 
} 

/*** FUNCTION   void Zinstruction391(); 

    Purpose:   process instruction 391  A-int = srt(A-int1 or A-bstr, int) 

    Input:    (element IPC)   union pointer to table address in i-code 

    Return:    void 

    Output:   (element IPC)   updated union pointer in i-code 
                                                                ***/ 
void Zinstruction391() 
{ 
    extern element IPC; 

    element pt; 
    element var_pnt; 
    element TIPC; 

    long    dsize1; 
    long    dsize2; 
    long    i,k; 
    unsigned long    j; 
    unsigned long   *ip1; 
    unsigned long   *ip2; 
    unsigned long   *ip3; 
    long    sort_fun; 
    long    max_bstr_len; 
    long    nxop; 
    long    sort_size; 
    long    sort_size1; 

    unsigned long    p1,p2,p3,p4,p5; 
    unsigned long    pp1,pp2; 
    unsigned long    t1; 
    unsigned long    gg,hh,kk; 

    max_bstr_len = 0; 
    TIPC.n = IPC.n; 
/* 
&dA &d@   Step 1: Get size of dimension and address of output array 
*/ 
    pt.n = IPC.n++; 
    var_pnt.n = *pt.p;               /* tricky code */ 
    k = *var_pnt.n++;                /* number of dimensions */ 
    dsize1 = *var_pnt.n++;           /* dimension size */ 
    ip1 = (unsigned long *) *var_pnt.p; 
/* 
&dA &d@   Step 2: Determine type of sort function
*/ 
    sort_fun = *(IPC.n++); 
/* 
&dA &d@   Step 3: Get size of dimension and address of input array 
*/ 
    if (sort_fun == 87)   { 
        pt.n = IPC.n++; 
        var_pnt.n = *pt.p;               /* tricky code */ 
        k = *var_pnt.n++;                /* number of dimensions */ 
        dsize2 = *var_pnt.n++;           /* dimension size */ 
        ip2 = (unsigned long *) *var_pnt.p; 
    } 
    else   { 
        pt.n = IPC.n++; 
        ++IPC.n; 
        var_pnt.n = *pt.p;               /* tricky code */ 
        k = *var_pnt.n++;                /* number of dimensions */ 
        dsize2 = *var_pnt.n++;           /* dimension size */ 

        ip2 = (unsigned long *) *var_pnt.p++; 
        max_bstr_len = *(var_pnt.n); 
    } 
/* 
&dA &d@   Step 4: Get the sort size and check for overrun
*/ 
    Zevint(&k, &nxop); 
    sort_size = Zintex(k, nxop); 

    if ( (sort_size > dsize1) || (sort_size > dsize2) ) { 
        errf2(WERR72, 1, (TIPC.n - 1) , NULL, 0L, 0L, 0L); 
        terminate_ww(); 
    } 
/* 
&dA &d@   Step 5: Zero the output and load with sequence of increasing integers 
*/ 
    for (i = 0; i < dsize1; ++i)  { 
        *(ip1 + i) = 0; 
    } 
    if (sort_size < 2)  { 
        if (sort_size == 1)  { 
            *ip1 = 1; 
        } 
        return; 
    } 
/* 
&dA &d@   Step 6: Get auxillary memory for sort
*/ 
    if (sort_fun == 88)  return;   /* leave the bstr implementation 'till later */

    if ( (ip3 = (unsigned long *) calloc ( (unsigned long) (sort_size + 2), 
            (size_t) sizeof (long) ) ) == NULL)  { 
        errf2(WMSG73, 1, (TIPC.n - 1) , NULL, 0L, 0L, 0L);  /* not enough free memory */
        return; 
    } 
    for (i = 0; i < sort_size; ++i)  { 
        *(ip1 + i) = i; 
    } 
/* 
&dA &d@   &dEHere is where the radix sort begins&d@  
&dA &d@  
&dA &d@   Radix sort; Step 1: Sort pairs of elements.  Don't use the auxillary buffer.
*/ 
    for (i = 0; i < (sort_size - 1); i += 2)  { 
        j = i + 1; 
        if ( *(ip2 + *(ip1+i)) < *(ip2 + *(ip1+j)) )  { 
            k = *(ip1+i); 
            *(ip1+i) = *(ip1+j); 
            *(ip1+j) = k; 
        } 
    } 

    sort_size1 = sort_size + 1; 
/* 
&dA &d@   Radix sort loop 
*/ 
    for (gg = 2; gg < 31; ++gg)  { 
        hh = 1 << gg;              /* block size */ 
        if (hh >= (sort_size * 2))  goto DONE; 

        p3 = 0; 
        p1 = 0;                     /*   first half counter   */ 
        t1 = hh >> 1; 
        p2 = t1;                    /*   second half counter  */ 
        p4 = p1 + hh;               /*   second half limit    */ 
        p5 = p4 - t1;               /*   first half limit     */ 

        for (kk = 0; kk < sort_size; kk += hh)   { 
            pp1 = p1; 
            pp2 = p2; 
A1: 
            if ( *(ip2 + *(ip1+p1)) <= *(ip2 + *(ip1+p2)) )  { 
                *(ip3 + p3++) = *(ip1+p2++); 
                if ( (p2 < p4) && (p2 < sort_size) )  goto A1; 

                while ( (p1 < p5) && (p1 < sort_size) )  { 
                    *(ip3 + p3++) = *(ip1+p1++); 
                } 
                goto END1; 
            } 
            if ( *(ip2 + *(ip1+p2)) <= *(ip2 + *(ip1+p1)) )  { 
                *(ip3 + p3++) = *(ip1+p1++); 
                if ( (p1 < p5) && (p1 < sort_size) )  goto A1; 

                while ( (p2 < p4) && (p2 < sort_size) )  { 
                    *(ip3 + p3++) = *(ip1+p2++); 
                } 
                goto END1; 
            } 
END1: 
            p1 = pp1 + hh; 
            p2 = pp2 + hh; 
            p4 += hh; 
            p5 += hh; 

            if (p2 >= sort_size)  { 
                while (p1 < sort_size)  { 
                    *(ip3 + p3++) = *(ip1+p1++); 
                } 
                kk = sort_size; 
            } 
        } 
        for (kk = 0; kk < sort_size; ++kk)  { 
            *(ip1+kk) = *(ip3+kk); 
        } 
    } 
DONE: 
    for (kk = 0; kk < sort_size; ++kk)  { 
        *(ip1+kk) = *(ip1+kk) + 1; 
    } 
    free((void *) ip3); 

    return; 
} 
