/***                         DMUSE PROGRAM 
                           LINUX version 0.00                  
            (c) Copyright 1992, 1999, 2007 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 09/26/2007) 
                            (rev. 12/27/2009) 

                   Zbex Interpreter Graphics Functions                
                                                                        ***/ 
#include  "all.h" 

/*** FUNCTION   void Zcallbitmode(); 

    Purpose:   execute the bitmode instruction called by 
                 the Interpreter.   bitmode int-exp,int1,int2 

                                                                 ***/ 
void Zcallbitmode() 
{ 
    extern element  IPC; 

    long         x; 

/* (1) get operation number */ 

    x = Zgenintex(); 

/* (2) set graphics size (column and row)  */ 

    ++IPC.n; 
    ++IPC.n; 
    return; 
} 

/*** FUNCTION   void Zcallactivate();

    Purpose:   process the activate instruction 
                 called from the Z Interpreter 

    Input:     void 

    Return:    void

    Format and Operation: 

      The instruction is followed by a string variable and three type II 
      integer expressions.  The string variable is designated as the       
      source for one of the four color Pixmaps.  The sixth byte of the 
      string indicates the bitmap plane to which the data is to be 
      written.  

      activate S-str,int1,int2,int3; 

                                                                 ***/ 

void Zcallactivate() 
{ 
    extern element  IPC; 

    long            x; 

/* get string argument  */ 

    ++IPC.n; 

/* get integer arguments */ 

    x  = Zgenintex(); 
    x  = Zgenintex(); 
    x  = Zgenintex(); 

    return; 
} 

/*** FUNCTION   void Zcallsetup(); 

    Purpose:   process the setup instruction 

    Input:     void 

    Return:    void

    Format and Operation: 

      The instruction is followed by a string variable and three type 
      II integer expressions.  The string variable is set up for use by 
      the activate and set/clearb instructions.  The first two integer 
      expressions supplied by the instruction indicate the size <x,y> 
      of the bitmap array.  The <x> coordinate is expressed in BYTES, 
      not bits.  The <y> coordinate is expressed in rows.  The third 
      integer expression, p, determines the number of scatch planes.  
      The product of x, y and p must be greater than zero.  

      The string variable, S-str, will serve as the source for writing 
      data to a bitmap plane.  This instruction initializes the data      
      portion of S-str to zeros.

      The actual setup procedure works as follows:  The first two bytes 
      of S-str will contain <x>; the next two bytes will contain <y>; 
      and the fifth byte will contain <p>.  The map, itself, will be 
      stored starting at byte 21.  This is because bytes 6--10 are 
      reserved for activation data, and bytes 11-20 are reserved for 
      for boundary parameters.  

      The bitmap represented by S-str need not have the same dimensions 
      as the screen; it may be larger or smaller in either dimension.  
      Only that portion of the bitmap lying within the color Pixmap's 
      dimensions will be written to the designated Pixmap.


    Summary: 

      S-str variable:  bytes 1-5: array parameters 
                         bytes 1-2 (m) = number of BYTES in row (horz dim) 
                         bytes 3-4 (n) = number of rows (vert dim) 
                            byte 5 (p) = number of "scratch planes" 

                       bytes 11-18: left, top, right, bottom boundarys 
                         bytes 11-12 = left boundary (x1) 
                         bytes 13-14 = top  boundary (y1) 
                         bytes 15-16 = right  boundary (x2) 
                         bytes 17-18 = bottom boundary (y2) 

                       bytes 19-20: unused 

                       If m*n*p + 20 > len(S-str), length error occurs 
                       If m*n*p = 0, S-str is invalid as a byte array 

                                                                 ***/ 
void Zcallsetup() 
{ 
    extern element  IPC; 

    element         pt; 
    long            mlen, slen; 
    long            x, y, p; 
    long            i; 
    long           *ip1; 
    char           *sp1; 
    unsigned char  *usp1; 

    pt = IPC; 

/* get string argument  */ 

    ip1 = *(*IPC.q); 
    usp1 = (unsigned char *) (ip1 + 1); 
    mlen = *(*IPC.p + 1); 
    ++IPC.n; 

/* get integer arguments */ 

    x  = Zgenintex(); 
    y  = Zgenintex(); 
    p  = Zgenintex(); 

/* check for proper length of bitmap string */ 

    i = x * y * p; 
    if (i <= 0)  { 
        dynamicarrayerr(pt.n, i); 
    } 
    slen = i + 20; 
    if (slen > mlen) { 
        calcstrlenerr(slen, mlen, pt); 
    } 
    *ip1 = slen; 

/* set string to zeros over functional length */ 

    sp1 = (char *) usp1; 
    for (i = 0; i < slen; ++i)  { 
        *sp1++ = 0; 
    } 

/* set bitmap array parameters */ 

    *usp1++ = x >> 8; 
    *usp1++ = x & 0xff; 
    *usp1++ = y >> 8; 
    *usp1++ = y & 0xff; 
    *usp1++ = p;
    usp1 += 5; 
    *usp1++ = 0x3f; 
    *usp1++ = 0; 
    *usp1++ = 0x3f; 
    *usp1++ = 0; 
    *usp1++ = 0; 
    *usp1++ = 0; 
    *usp1++ = 0; 
    *usp1++ = 0; 

    return; 
} 

/*** FUNCTION   void Zcalldscale(); 

    Purpose:   process the dscale2, dscale3 and dscale5 instructions 
                 called from the Z Interpreter.  

    Input:     void 

    Return:    void

    Format:               

      The instruction is followed by a two string variables and five 
      integer variables.  

                                                                 ***/ 
void Zcalldscale() 
{ 
    extern element  IPC; 

    long            x; 

/* get first string argument  */ 

    ++IPC.n; 

/* get second string argument  */ 

    ++IPC.n; 

/* get integer arguments */ 

    x  = Zgenintex(); 
    x  = Zgenintex(); 
    x  = Zgenintex(); 
    x  = Zgenintex(); 
    x  = Zgenintex(); 

    return; 
} 

/*** FUNCTION   void Zcallsetclearb(long f); 

    Purpose:   process the setb and clearb instructions 

    Input:     long  f  bit 0  0 = clear 
                               1 = set 
                        bit 1  0 = use A-bstr for pattern 
                               1 = use A-int  for pattern 

    Return:    void

    Format and Operation: 

      These instructions come in two formats: one using a bit-string 
      array as a source, and the other using an integer array as a 
      source.  The operation of the instruction under each of these 
      formats is slightly different.  The only difference between setb 
      and clearb is that setb turns bits on and clearb turns bits off.  

      The first variable is intended to act as <p> independent bitmap 
      planes, corresponding to the third dimension specified in byte 5 
      S-str (see diagram).  The second variable is a one dimensional 
                               bitstring array, A-bstr(q), or a one 
              S-str(m,n,p)     dimensional integer array, A-int(q).  
            pÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿  This variable functions as a source for 
            ÚÁÄÄÄÄÄÄÄÄÄÄÄÄÄ¿³  a set of bitmats (see 2nd diagram).  
          .ÚÁÄÄÄÄÄÄÄÄÄÄÄÄÄ¿³³ 
         .ÚÁÄÄÄÄÄÄÄÄÄÄÄÄÄ¿³³³  Now we can describe the action of the 
        .ÚÁÄÄÄÄÄÄÄÄÄÄÄÄÄ¿³³³³  command.  Let's talk about setb.  This 
       3ÚÁÄÄÄÄÄÄÄÄÄÄÄÄÄ¿³³³³³  instruction is used to turn on some bits 
      2ÚÁÄÄÄÄÄÄÄÄÄÄÄÄÄ¿³³³³³³  in S-str.  Which bits and where?  The 
     1ÚÁÄÄÄÄÄÄÄÄÄÄÄÄÄ¿³³³³³ÃÙ  values of the integers answer these ques- 
      ³             ³³³³³ÃÙ   tions.  The first two integers are the 
      ³ÅÄ m bytes Ä³³³³ÃÙ   <x,y> offset in S-str where the pattern 
      ³ ³            ³³³ÃÙ   will start.  Notice that <x> is given as a 
      ³n rows        ³³ÃÙ   BIT offset, not a byte offset.  <0,0> is the 
      ³ ³            ³ÃÙ   top lefthand corner of S-str.  The meaning of 
      ³             ÃÙ   the remaining variables depends on the format.  
      ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   In the case of the first format type (using a 
                        bit-string source, the third integer is the height 
        A-bstr(q)      (vertical dimension) of the "box" to be copied to 
        ÚÄÄÄÄÄÄÄ¿     S-str.  The fourth integer is the width (horizontal 
        ³       ³    dimension) measured in BITs.  This is the maximum 
        ³       ³   width of this particular gliph image in A-bstr.  The 
        ÃÄÄÄÄÄÄÄ´   fifth integer is the dimension number in A-str(q) of 
        ÃÄÄÄÄÄÄÄ´   the first bitstring to copy.  Notice that since this 
        ÃÄÄÄÄÄÄÄ´   number is a subscript, it follows the rules of 
        ³       ³   subscripts, e.g., it cannot be less than one.  The 
        ³       ³   sixth integer is a value from 1 to <p> and is the 
        ÃÄÄÄÄÄÄÄ´   plane to which the copy should be made.  
        ³       ³ 
        ÀÄÄÄÄÄÄÄÙ   This technique will allow us to store entire fonts in 
                    long, bitstring arrays.  To select a glyph for copy- 
      ing, we simply need to know the beginning dimension number and the 
      number of rows (height).  The fact that we have <p> planes to write 
      in means that we can build up complex notations such as music from a 
      series of glyphs.  It also means that we can selectively turn on and 
      off various glyphs, without disturbing other glyphs.  For example, 
      we could turn off a music note and turn it back on in another 
      location, without disturbing the music lines.  

      The operation of the second format (using an A-int source) is 
      slightly more complicated, but for certain kinds of tasks, it is 
      more streamline and faster.  The idea is that if we are using these 
      instructions to turn on and off letters of a font, much of the 
      information about the letters is known and can therefore be put 
      directly in the integer array.  In this case, the first and second 
      integers (represent the <x,y> position) are simple variables, not 
      expressions, as in the first format.  The first variable <x> may be 
      modified by this instruction.  The third integer expression is 
      an offset to an address inside the A-int.  The fourth integer is 
      a value from 1 to <p> and is the plane to which the copy should be 
      made.  

      More explanation needs to be given to the third integer expression.
      This number acts like a font number.  For example, the number 97 might 
      point to a small 'a'.  This would mean that the 97-th entry in A-int 
      would contain the offset to the data for the 'a'.  In effect, this 
      offset would be the equivalent of the fifth integer in the first 
      format.  The first two integers of the data block for the letter 'a' 
      are  reserved for data about the letter.  The first integer contains 
      the following information: 

        high order byte: height of the box (equivalent of third integer) 
                 byte 2: width of the box (equivalent of fourth integer) 
                 byte 1: horz offset (signed)  added to <x> 
         low order byte: vert offset (signed)  added to <y> 

         NOTE: Because the vertical offset is seldom a large positive 
               number and for large fonts can be less than -128, we 
               will interpret the vertical offset byte as follows: 

                            0 to 80 is positive 
                           81 to 255 is negative 

               This will permit fonts up to 174 dots in height.  

      The second integer contains the following: 

        high order byte: increment to <x> following exectution of instruction 

      The data for the letter 'a' follow.  Note that the number of integers 
      required per row will depend on the width of the box (given in byte 2).  
      If the width is 32 or less, one integer per row is required; 64 or 
      less, two integers per row are required; etc.  One can see that the 
      integer array. A-int, must be constructed fairly carefully by the 
      user programmer.  The payoff, however, is much greater speed at run 
      time for applications that intend to put fonts down on the screen 
      in a linear fashion.  

      setb is used to turn bits on; clearb is used to turn bits off.  
      The exact mechanism will depend on whether bits are being set or 
      cleared.  In the first case, the specified plane needs to be OR-ed 
      to plane 1 and to the designated bitmap plane.  In the second case, 
      all of the planes 2 and higher need to be OR-ed together and the 
      result placed in plane 1 and written to the designated bitmap plane.

      In the DOS version of this function, if the destination variable, 
      S-str, were activated (i.e., S-str{1} = 1, 2, 3, or 4), a write 
      to the designated bitmap plane would take place.  This mechanism   
      is not efficient however in the X Window system, because it 
      involves an X communication with the server.  Instead, the setb/ 
      clearb function records the outer limits of any change in the 
      change rectangle, bytes 11 to 18 of the S-str.  

    Summary: 

      S-str variable:  bytes 1-5: array parameters 
                         bytes 1-2 (m) = number of BYTES in row (horz dim) 
                         bytes 3-4 (n) = number of rows (vert dim) 
                            byte 5 (p) = number of "scratch planes" 

                       bytes 6-10: activation parameters 
                         byte 6 = bitmap plane designator 
                                     0 = no plane designated; S-str inactive.  
                                1 to 4 = designated plane; S-str active 
                         bytes 7-8  (x) = x offset of last activation command 
                         bytes 9-10 (y) = y offset of last activation command 

                       bytes 11-18: left, top, right, bottom boundaries 
                           of the change rectangle 
                         bytes 11-12 = left boundary (x1) 
                         bytes 13-14 = top  boundary (y1) 
                         bytes 15-16 = right  boundary (x2) 
                         bytes 17-18 = bottom boundary (y2) 

                       bytes 19-20: unused 

                       If m*n*p + 20 > len(S-str), length error occurs 
                       If m*n*p = 0, S-str is invalid as a byte array 

      setb/clearb S-str,A-bstr,int1,int2,int3,int4,int5,int6; 

               A-bstr(q) = collection of bitmap images strung together 
                             one below the next 
                    int1 = horizontal offset expressed in BITS for 
                             destination of bitmap image in S-str 
                    int2 = vertical offset expressed in ROWS for 
                             destination of bitmap image in S-str 
                    int3 = height of bitmap image to be transferred 
                            (width is the individual lengths of the  
                             bitstrings) 
                    int4 = width of bitmap image to be transferred 
                                                           
                    int5 = starting row (dimension) in A-bstr(q) for 
                             the bitmap image 
                    int6 = destination plane in S-str 

      setb/clearb S-str,A-int,S-int1,S-int2,int3,int4: 

                A-int(q) = collection of bitmap images strung together 
                             one below the next 
                  S-int1 = horizontal offset expressed in BITS for 
                             destination of bitmap image in S-str 
                  S-int2 = vertical offset expressed in ROWS for 
                             destination of bitmap image in S-str 
                    int3 = address in A-int for offset to bitmap data 
                             At offset address, first integer contains: 
                             ÚÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
                             ³height³width ³local h. offset³local v. offset³ 
                             ÀÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
                             Second integer contains: 
                             ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
                             ³increment to <x>³        |   zeros  |        ³ 
                             ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 

                    int4 = destination plane in S-str 


          If byte 6 of S-str is 1,2,3 or 4 (S-str is activated), then 
          setb/clearb will update (leave the same or make larger) the 
          x,y rectangle representing the area of change in the S-str 
          since the last fluch ( (activate(S-str,0,0,-1) ) instruction.  

                                                                 ***/ 
void Zcallsetclearb(long f) 
{ 
    extern element  IPC; 

    element         pt; 
    long            setf, intf; 
    long            mlen, slen; 
    long            bsoff; 
    long            len; 
    long            x, y, p; 
    long            height, width, start, asubmax; 
    long            oldp; 
    long            h, i, j, k; 
    long           *tip1, *tip2;
    unsigned long  *tip3, *tip4; 
    long            rows, bytes, planes; 
    long            a, b, c, d; 
    unsigned long   uc, ud; 
    long            s_x1, s_x2, s_y1, s_y2;    /* effected box in S-str */ 
    long            x1, x2, y1, y2;            /* boundaries of byte array */ 
    char           *sp1, *sp2, *sp3; 
    unsigned char  *usp1; 
    long           *xadd; 
    long            voffset; 
    long            local_xoff, local_yoff; 
    long            xinc; 

    pt = IPC; 

    setf = (f & 0x01); 
    intf = (f & 0x02); 

    xinc = 0; 
    xadd = &xinc; 

/* get string argument  */ 

    tip1 = *(*IPC.q); 
    usp1 = (unsigned char *) (tip1 + 1); 
    mlen = *(*IPC.p + 1); 
    ++IPC.n; 

/* get source argument for bitmap array */ 

    if (intf == 0)  {          /* A-bstr */ 
        tip2 = *(*IPC.q + 2); 
        bsoff = (*(*IPC.p + 3) + 63) >> 5;    /* 32 bit words */ 
    } 
    else  {                    /* A-int  */ 
        tip2 = *(*IPC.q + 2); 
        bsoff = 1;      /* this is actually set later 32 bit words */ 
    } 
    asubmax = *(*IPC.p + 1); 
    ++IPC.n; 

    if (intf == 0)  { 

        x = Zgenintex();      /* get horz offset for dest of bitmap image */ 
        y = Zgenintex();      /* get vert offset for dest of bitmap image */ 
        height = Zgenintex(); /* get height of bitmap image */ 
        width = Zgenintex();  /* get width of bitmap image (in bits) */ 
        start = Zgenintex();  /* get starting row in source array */ 
        p = Zgenintex();      /* get destination plane */ 
        local_xoff = 0; 
        local_yoff = 0; 

    /* check range of start */ 
        if (start < 1 || start > asubmax) { 
            suberr(start, asubmax, (pt.n+1), *(pt.p+1), 0); 
        } 
        i = height - 1 + start; 
        if (i > asubmax)  { 
            suberr(i, asubmax, (pt.n+1), *(pt.p+1), 0); 
        } 

        --start;              /* convert to C-style subscript */ 
    /* set start address for bit-string */ 
        tip3 = (unsigned long*)(tip2 + (start*bsoff)); 
    } 
    else { 
        xadd = *IPC.p; 
        ++IPC.n; 
        x = *xadd;            /* get horz offset for dest of bitmap image */ 
        y = *(*IPC.p);        /* get vert offset for dest of bitmap image */ 
        ++IPC.n; 
        voffset = Zgenintex();/* get offset to data in A-int */ 
        p = Zgenintex();      /* get destination plane */ 

        if (voffset < 1 || voffset > asubmax) { 
            suberr(voffset, asubmax, (pt.n+1), *(pt.p+1), 0); 
        } 
        --voffset;            /* convert to C-style subscript */ 
        start = *(tip2 + voffset); 
        if (start < 1 || start > asubmax) { 
            suberr(start, asubmax, (pt.n+1), *(pt.p+1), 0); 
        } 
        --start;              /* convert to C-style subscript */ 
        i = *(tip2 + start); 
        height = i >> 24; 
        height &= 0xff;       /* get height of bitmap image */ 
        width  = i >> 16; 
        width  &= 0xff;       /* get width of bitmap image (in bits) */ 
        bsoff = (width + 31) >> 5; 

        local_xoff = i >> 8; 
        local_xoff &= 0xff; 
        if (local_xoff > 0x7f)  local_xoff |= 0xffffff00; 
        local_yoff = i & 0xff; 
        if (local_yoff >   80)  local_yoff |= 0xffffff00; 

    /* check range of start */ 
        i = height - 1; 
        i *= bsoff; 
        i += start + 2; 
        if (i >= asubmax)  { 
            suberr(i, asubmax, (pt.n+1), *(pt.p+1), 0); 
        } 

        ++start; 
        i = *(tip2 + start); 
        xinc = i >> 24; 
        xinc &= 0xff;           /* increment to x parameter afterwards */ 
        ++start; 
    /* set start address for integer array */ 
        tip3 = (unsigned long*)(tip2 + start); 
    } 

/* get bitmap array parameters */ 

    bytes   = *(usp1) << 8; 
    bytes  += *(usp1+1); 
    rows    = *(usp1+2) << 8; 
    rows   += *(usp1+3); 
    planes  = *(usp1+4); 

    oldp    = *(usp1+5); 
    x1      = ((*(usp1+10) & 0xff) << 8) + (*(usp1+11) & 0xff); 
    y1      = ((*(usp1+12) & 0xff) << 8) + (*(usp1+13) & 0xff); 
    x2      = ((*(usp1+14) & 0xff) << 8) + (*(usp1+15) & 0xff); 
    y2      = ((*(usp1+16) & 0xff) << 8) + (*(usp1+17) & 0xff); 

/* check for proper length of bitmap string */ 

    i = bytes * rows * planes; 
    if (i <= 0)  { 
        dynamicarrayerr(pt.n, i); 
    } 
    slen = i + 20; 
    if (slen > mlen) { 
        calcstrlenerr(slen, mlen, pt); 
    } 
    *tip1 = slen; 

/* check to see that the plane number is legal */ 

    if (p <= 0 || p > planes)  { 
        planenumerr(p, planes, pt.n); 
    } 

/* increment original x, and add local offset to x and y */ 

    if (intf != 0)  { 
        *xadd = x + xinc; 
        x += local_xoff; 
        y += local_yoff; 
    } 

/* check projection onto S-str */ 

    if (x < 0)  x = 0; 
    if (y < 0)  y = 0; 

    j = bytes << 3; 
    if (x >= j)     return; 
    if (y >= rows)  return; 

    if ((k = x + width - 1 - j) > 0)       width -= k; 
    if ((k = y + height - 1 - rows) > 0)  height -= k; 

/* set box limits on S-str */ 

    s_x1 = x >> 3;                 /* measured in bytes */ 
    s_x2 = (x + width + 7) >> 3;   /* outer limit */ 
    s_y1 = y;                      /* measured in rows  */ 
    s_y2 = y + height;             /* outer limit */ 

/* (1) set/clear bits on designated bitplane */ 

    len = 0; 
    if (intf != 0)  len = width; 

    a = x & 0x07;                   /* 0 <= a < 8: start bit in first byte */ 

    sp1 = (char *) (usp1 + 20); 
    sp2 = sp1 + (p - 1) * bytes * rows; /* you are on the proper bit-plane */ 
    sp2 += y * bytes;                   /* you are on the proper row */ 

    for (i = 0; i < height; ++i) { 
        tip4 = tip3; 
        sp3 = sp2 + s_x1;               /* you are at the proper first byte */ 
        if (intf == 0)  { 
            len = (long) *tip4++;    /* A-bstr */ 
            if (len > width)  len = width; 
        } 

        b = (x + len - 1) & 0x07; /* 0 <= b < 8: end bit in last byte */ 
        c = 0xff << (7 - b); 
        c &= 0xff;                /* c = last byte mask */ 
        d = (x + len + 7) >> 3;   /* d = byte beyond last byte */ 

        uc = *tip4 >> a; 
        if (a == 0)  ud = 0; 
        else { 
            ud = *tip4 << (32 - a); 
        } 
        for (h = 24, j = s_x1; j < d; ++j)  { 
            if (h < 0) { 
                h = 24; 
                ++tip4; 
                uc = *tip4 >> a; 
                uc += ud; 
                if (a == 0)  ud = 0; 
                else { 
                    ud = *tip4 << (32 - a); 
                } 
            } 
            k = (long) (uc >> h); 
            h -= 8; 
            if (j == d - 1)  k &= c;      /* k = last byte */ 
            else             k &= 0xff;   /* k = non-last byte */ 

            /* You've got the byte.  Now, where does it go, and what 
               do you do with it?                                  */ 

            if (setf == 1) *sp3 |= k;        /* turn the bits on */ 
            else           *sp3 &= (~k);     /* turn the bits off */ 
            ++sp3; 
        } 

        tip3 += bsoff;      /* move source row */ 
        sp2  += bytes;      /* move dest   row */ 
    } 

/* (2) Insure that bitplane 1 properly reflects the above change */ 

    if (p > 1)  { 
        if (setf == 1)  { 
            sp2 = sp1 + (p - 1) * bytes * rows; /* active bit-plane */ 
            sp2 += y * bytes;                   /* and proper row */ 
            sp3 = sp1 + y * bytes; 
            for (i = 0; i < height; ++i) { 
                for (j = s_x1; j < s_x2; ++j)  { 
                    *(sp3+j) |= *(sp2+j);       /* OR bytes to plane 1 */ 
                } 
                sp2 += bytes;      /* move source row */ 
                sp3 += bytes;      /* move dest   row */ 
            } 
        } 
        else { 
            sp3 = sp1 + y * bytes; 
            for (i = 0; i < height; ++i) { 
                for (j = s_x1; j < s_x2; ++j)  { 
                    *(sp3+j) = 0;               /* zero space on plane 1 */ 
                } 
                sp3 += bytes;      /* move dest   row */ 
            } 
            for (k = 1; k < p; ++k) {           /* build up plane 1 again */ 
                sp2 = sp1 + k * bytes * rows; /* bit-plane (k+1) */ 
                sp2 += y * bytes;             /* and proper row  */ 
                sp3 = sp1 + y * bytes; 
                for (i = 0; i < height; ++i) { 
                    for (j = s_x1; j < s_x2; ++j)  { 
                        *(sp3+j) |= *(sp2+j);       /* OR bytes to plane 1 */ 
                    } 
                    sp2 += bytes;      /* move source row */ 
                    sp3 += bytes;      /* move dest   row */ 
                } 
            } 
        } 
    } 

/* (3) Now possibly expand the size of the modified rectangle in S-str */ 

    if ((oldp < 1) || (oldp > 4))  { 
    /*  printf("returning because oldp = %d\n", oldp);  getch();  */ 
        return;    /* S-str inactive */ 
    } 

    if (s_x1 < x1)  { 
        *(usp1+10) = s_x1 >> 8; 
        *(usp1+11) = s_x1 & 0xff; 
    } 
    if (s_y1 < y1)  { 
        *(usp1+12) = s_y1 >> 8; 
        *(usp1+13) = s_y1 & 0xff; 
    } 
    if (s_x2 > x2)  { 
        *(usp1+14) = s_x2 >> 8; 
        *(usp1+15) = s_x2 & 0xff; 
    } 
    if (s_y2 > y2)  { 
        *(usp1+16) = s_y2 >> 8; 
        *(usp1+17) = s_y2 & 0xff; 
    } 

    return; 
} 
