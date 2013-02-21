/***                         DMUSE PROGRAM 
                           LINUX version 0.00
            (c) Copyright 1992, 1999, 2007 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 01/29/2007) 
                            (rev. 02/07/2009) 
                            (rev. 09/07/2009) 
                            (rev. 12/27/2009) 
                            (rev. 02/12/2010) 
                            (rev. 04/04/2010) 

                Z Compiler and Interpreter: Communication 
                                                                        ***/ 
#include  "all.h" 

/*** SUBROUTINE  ssize_t my_writeall(int fd, const void *buf, size_t nbyte);

    Purpose:   keep calling write(fd, buf, n)  until all nbytes are written 
               or a write error occurs.  Ignor EINTR (signal).  

    Input:     int      fd     file descriptor 
               void    *buf    pointer to byte stream 
               size_t   nbyte  length of byte stream 

    Return     ssize_t  >= 0:  number of bytes written 
                          -1:  write failed 

    Code source:  Rochkind: Advanced Unix Programming, pp. 95-96 

                                                                  ***/ 

ssize_t my_writeall(int fd, const void *buf, size_t nbyte)  
{ 
    ssize_t nwritten = 0, n; 

    do { 
        if ((n = write(fd, &((const char *) buf)[nwritten], 
                   (nbyte - nwritten) )) == -1)  { 
            if (errno == EINTR)   continue; 
            else                  return (-1); 
        } 
        nwritten += n; 
    }  while (nwritten < nbyte); 

    return (nwritten); 
} 


/*** SUBROUTINE  ssize_t my_readall(int fd, void *buf, size_t nbyte); 

    Purpose:   keep calling read(fd, buf, n)  until all nbytes are read        
               or a read error occurs.  Ignor EINTR (signal).  

    Input:     int      fd     file descriptor 
               void    *buf    pointer to byte stream 
               size_t   nbyte  length of byte stream 

    Return     ssize_t  >= 0:  number of bytes read    
                          -1:  read failed 

    Code source:  Rochkind: Advanced Unix Programming, p. 97.  

                                                                  ***/ 

ssize_t my_readall(int fd, void *buf, size_t nbyte) 
{ 
    ssize_t nread = 0, n; 

    do { 
        if ((n = read(fd, &((char *) buf)[nread], 
                   (nbyte - nread) )) == -1)  { 
            if (errno == EINTR)   continue; 
            else                  return (-1); 
        } 
        if (n == 0)   return (nread); 

        nread += n; 
    }  while (nread < nbyte); 

    return (nread); 
} 


/*** SUBROUTINE  long byte_write(ss, n, fd); 

    Purpose:   write <n> bytes to file opened with file descriptor <fd> 

    Input:     char    *ss    pointer to byte stream 
               long     n     length of byte stream 
               int      fd    file descriptor 

    Return     long     0 = write succeeded 
                        1 = write failed 

                                                                  ***/ 

long byte_write(char *ss, long n, int fd) 
{ 
    char          nbuffer[4];
    unsigned int  wsize; 
    long         *ip1;

    ip1 = (long *) nbuffer; 
    *ip1 = n; 

    if (my_writeall(fd, nbuffer, 4) == -1)  return (1); 

    while (n > 0)  { 
        if (n > 64000L)  wsize = 64000;
        else             wsize = (unsigned int) n;
        n -= wsize; 

        if (my_writeall(fd, ss, wsize) == -1)  return (1); 

        ss += 64000; 
    } 
    return (0); 
} 

/*** FUNCTION  long zload(mode, wwprog); 

    Purpose:   load and fixup zbex program data 

    Input:     long   mode     1 = called from "zz" 
                               2 = called from "ww" 
                               3 = called from "ww" with program ready 

               char  *wwprog   pointer to "ww" program (mode 3) 

    Output:    none

    Return:    long  -1: window change or disconnect 
                     -2: !! (zbex not running) 
                     -3: zbex running 

    Operation: The zload function may be called from two locations.  It may 
               be called after zcmp as part of the complete "zz" call, or 
               it may be called separately by the "ww" call.  There are 
               some minor differences between these cases as described  
               below: 

               I. Called after zcmp as part of "zz":  In this case, a compile 
               has just been completed and all information is currently in 
               memory.  The information is located in the following data 
               areas: 

               Data name                    Size              Location 
               ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ           ÄÄÄÄÄÄÄÄÄÄÄÄÄ     ÄÄÄÄÄÄÄÄÄÄ 
               Link memory (words)          *links            links 
               I-code (words)               PC                porg 
               Main memory size             (word)            maincnt 
               Link memory fixup (words)    *linksfix         linksfix 
               I-code fixup (words)         *icfix            icfix 
               Compiler symbol table (b)    *(long *)symtab   symtab 
               Procedure name table (b)     procnt            protab 
               Source index                 sfcnt             sfindex 
               examine flag                 byte              examineflag 
               print flag                   byte              printflag 
               name of source file          zascii            zfullfilename 
               # program lines              (word)            sscnt 
               maximum string length        (word)            maxstringlen 

               To convert this information to "standard form", the 
               following tasks must be accomplished.  

               1. The Compiler symbol table, the Procedure name table and 
               the Source index must be written to a temporary i-code.  
               The name of this file is known, "c:\DISP\zbex\ti0(x).ww" 
               (x = 0 to 9), but the file must be created.  After the data 
               is written, the file will be closed, but the variables: 
               zsfindexoff, zprotaboff, zsymtaboff and zsourcefilename[] 
               will be recorded in ztv for when the interpreter is 
               called.  The i-file is opened by the interpreter only if 
               this data is needed (i.e., in examine mode or by the error 
               handler).  

               2. After the three tables are safely stored, their memory 
               space needs to be recovered.  

               II. Called by "ww":  In this case, all of the input comes 
               from the i-file.  The function needs to ask for, get, and 
               open this file.  

               At this point, the two cases may proceed in parallel, with 
               some minor differences.  

               3. The links memory needs to be allocated (re-allocated) 
               and loaded.  In the "zz" case, we have the data in memory, 
               but it is in a space which is too large.  It needs to be 
               transferred to a new location.  After this operation is 
               complete, the former "links" space may be recovered.  

               4. The i-code memory needs to be allocated (re-allocated) 
               and loaded.  In the "zz" case, we have the data in memory, 
               but it is in a space which is too large.  It needs to be 
               transferred to a new location.  After this operation is 
               complete, the former "porg" space may be recovered.  

               5. At this point, the memory for main-memory must be 
               allocated.  The fixup processes need the location of 
               this memory block.  

               6. Now the links and i-code blocks can be fixed up.  The 
               information for this will come either from the i-file (ww) 
               or from memory (zz).  

           &dANew&d@ 7. The new variable type "glob" requires links fixup and 
               some additional action.  The (zz) and (ww) cases are slightly
            &dA.&d@  different.  This is known as type-5 fixup.  

            &dA.&d@  (zz) case: The location pointed to by the type-5 fixup contains
               an offset in the gfile_names[] array.  This is the full file 
            &dA.&d@  name of the source for the glob.  The name and access have been
               checked, but the data has not yet been acquired.  For each 
            &dA.&d@  glob (fixup), there needs to be a malloc of the appropriate 
               size (found in offset address + 1 of links).  The file needs 
            &dA.&d@  to be open, read, and stored in this location.  The pointer 
               to this data (top address of malloc) needs to be stored in 
            &dA.&d@  links at the fixup point.  

            &dA.&d@  (ww) case: The location pointed to by the type-5 fixup contains
               an offset in the (ww) file, itself.  The data is in the i-code
            &dA.&d@  file, appended below everything else.  For each (fixup), there
               needs to be a malloc of the appropriate size (found in offset
            &dA.&d@  address + 1 of links).  The data then needs to be transferred
               (i.e., read using lseek) from the (ww) file and stored in this
            &dA.&d@  location.  The pointer to this data (top address of malloc) 
               needs to be stored in links at the fixup point.  
            &dA.&d@  
               If there are (n) globs, there will be (n) mallocs.  The only 
            &dA.&d@  difference in these two processes is the action required to 
               fill these mallocs (i.e., get the data).  The malloc variables
            &dA.&d@  need to be pushed onto the zmem stack, so that memory can be 
               recovered when the Zbex program (interpreter) terminates.  

               8. The "ww" case needs to get the symbol table, procedure 
               table and source index offsets and the related size 
               variables.  These have already been acquired by the "zz" case.  

               9. Initialize IPC and fdata.access_type 

                     IPC.n = epr.n + 1; 
                     for (ii = 0; ii < 9; ++ii)  { 
                         fdata[ii].access_type = 0; 
                     } 

              10. Store zbex variables in ztv structure 

                     ztv.zelk.n                   = elk.n; 
                     ztv.zepr.n                   = epr.n; 
                     ztv.zIPC.n                   = IPC.n; 
                     ztv.zsfcnt                   = sfcnt; 
                     ztv.zprolevel                = 0; 
                     ztv.zb1                      = 0; 
                     ztv.zoperationflag           = 0; 
                     ztv.zexmode                  = 0; 
                     ztv.zlnum                    = lnum; 
                     ztv.zprocnt                  = procnt; 
                     ztv.zsfindexoff              = sfindexoff; 
                     ztv.zprotaboff               = protaboff; 
                     ztv.zsymtaboff               = symtaboff; 
                     ztv.zexamineflag             = examineflag; 
                     ztv.zprintflag               = printflag; 
                     ztv.zpf2                     = 0; 
                     ztv.zdebugg                  = 0; 
                     ztv.zmaxtemp                 = maxtemp; 
                     strcpy( 
                     ztv.zsourcefilename, zfullfilename); 
                     strcpy( 
                     ztv.zprinter_name, printer_name); 

                                                                     ***/ 

long zload(long mode, char *wwprog) 
{ 
    extern file_data   fdata[]; 
    extern zint_vars   ztv; 

    extern long  *links; 

    extern long   PC; 
    extern long   maincnt; 
    extern long   procnt; 

    extern long   sfcnt; 
    extern long   examineflag; 
    extern long   graphicsflag; 
    extern long   midiflag; 
    extern long   printflag; 
    extern char   zfullfilename[]; 
    extern long   sscnt; 
    extern long   maxstringlen; 

    extern long   global_maxstrlen; 
    extern long   sfindexoff;     /* offset to sfindex table in IM file   */ 
    extern long   protaboff;      /* offset to proc name table in IM file */ 
    extern long   symtaboff;      /* offset to symbol table in IM file    */ 

    extern element   IPC; 
    extern element   elk, epr;    /* run-time union pointers to link 
                                                       memory and i-code  */ 
    extern long  *mainmem;
    extern char  *maxtemp;
    extern long   lnum;           /* ?? not sure why this is here         */ 
    extern long   memstat;        /* 1 = print memory stats               */ 
/*  extern int    sourcefd;          file descriptor for source file      */

    char          interfile[LZ]; 
    char          s[LZ]; 
    char         *ss; 

    long          imfoff;          /* offset in IM file */ 
    long          errornum; 
    long          a,b,c,d; 
    long          g,i,j,k,t; 
    long          n; 
    long          ret; 
    long         *ip1, *ip2; 

    ip1 = (long *) s; 
    ztv.zmemref                = NULL;      /* reset list pointers */ 
    ztv.zpend_write            = NULL; 
    ret = -2; 
    c = *ip1; 

    errornum = 0; 
    if (no_read(0, s, 46) != 46)  goto M2Error;     /* discard header */ 
    imfoff = 46; 

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³   II. transfer information       ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/ 
 
/*  (1) load links memory   */ 

    errornum = 1; 
    if (no_read(0, s, 4) != 4) goto M2Error; 
    imfoff += 4; 
    k = *ip1 >> 2; 

    if ((elk.n = (long *) calloc((size_t) k, (size_t) sizeof(long))) 
            == NULL){ 
        msgf0(WMSG42); 
        goto M2TERM; 
    } 
    if (zmem_push(elk.n) == 1)  goto M2TERM; 

    if (no_read(0, (char *) elk.n, (unsigned int) *ip1) != *ip1)  { 
        goto M2Error; 
    } 
    imfoff += *ip1; 

    if (memstat == 1)  { 
        msgf1(WMSG41, k * 4); 
    } 

/*  (2) load intermediate code */ 

    errornum = 2; 
    if (no_read(0, s, 4) != 4) goto M2Error; 
    imfoff += 4; 
    PC = *ip1 >> 2; 

    if ((epr.n = (long *) calloc((size_t) PC, (size_t) sizeof(long))) 
            == NULL)  { 
        msgf0(WMSG42); 
        goto M2TERM; 
    } 
    if (zmem_push(epr.n) == 1)  goto M2TERM; 

    if (no_read(0, (char *) epr.n, (unsigned int) *ip1) != *ip1)  { 
        goto M2Error; 
    } 
    imfoff += *ip1; 

    if (memstat == 1)  { 
        msgf1(WMSG43, PC * 4); 
    } 

/* look for termination */ 

/*  (3) allocate memory */ 

    errornum = 3; 
    if (no_read(0, s, 4) != 4) goto M2Error; 
    imfoff += 4; 
    maincnt = *ip1; 

    if ((mainmem = (long *) calloc(maincnt, (size_t) sizeof(long))) 
            == NULL)  { 
        msgf0(WMSG42); 
        goto M2TERM; 
    } 
    if (zmem_push(mainmem) == 1)  goto M2TERM; 

    if (memstat == 1)  { 
        msgf1(WMSG44, maincnt * 4); 
    } 

/*  (4) fixup links memory     */ 

    errornum = 4; 
    if (no_read(0, s, 4) != 4) goto M2Error; 
    imfoff += 4; 
    n = *ip1; 
    if (no_read(0, s, 4) != 4) goto M2Error; 
    imfoff += 4; 

    n -= 4; 
    a = *ip1;                  /* a = size of fixup table + 1 */ 
    if (a > 1)  { 
        if (mode == 1) ++ip1; 
        else  { 
            if (no_read(0, s, 4) != 4) goto M2Error; 
            imfoff += 4; 
        } 
        n -= 4; 
        b = 1; 
        c = *ip1; 
        d = c & 0xffffff; 
        c >>= 24; 
    } 
    else d = -1; 
    k = *(elk.n);
    for (i = 0; i < k; ++i)  {   /* this code assumes links and links-fix are in sync */
        if (i == d)  { 
            switch (c)   {
                case 1: 
                    *(elk.p+i) = *(elk.n+i) + mainmem; 
                    break; 
                case 2: 
                    *(elk.p+i) = *(elk.n+i) + epr.n; 
                    break; 
                case 3: 
                    *(elk.p+i) = *(elk.n+i) + elk.n; 
                    break; 
                case 4: 
                    if (memstat == 1)  { 
                        msgf1(WMSG45, (*(elk.n+i+1) + 1) * 4); 
                    } 

                    if ((*(elk.p+i) =
                            (long *) calloc( 
                                            (size_t) (*(elk.n+i+1) + 1),
                                            (size_t) sizeof (long)
                                           ) 
                            ) == NULL)  { 
                        msgf0(WMSG46); 
                        goto TERM; 
                    } 
                    if (zmem_push( *(elk.p+i) ) == 1)  goto TERM; 
                    break; 
     /* &dANew&d@ */  case 5:     /* &dA02/10/10&d@ */ 
                    t = *(elk.n+i); 

                 /* t contains the current contents of Link.  In the (ww) case,
                    this is the offset in (ww) to the glob data.  The size 
                    of the glob should be in *(elk.n+i+1)  */ 

                    j = *(elk.n+i+1); 
                    g = j + 4; 
                    g >>= 2;     /* space in words */ 

                    if ((ip2 = (long *) calloc(g, (size_t) sizeof(long))) 
                            == NULL)  { 
                        msgf0(WMSG42); 
                        goto M2TERM; 
                    } 
                    if (zmem_push(ip2) == 1)  goto M2TERM; 

                    *(elk.p+i) = ip2; 

                    ss = (char *) ip2; 

                    no_read2(1, ss, t); 
                /* 
                    if (lseek(ifd2, t, SEEK_SET) == -1L)  { 
                        goto M2Error; 
                    } 
                    if (my_readall(ifd2, (char *) ss, (size_t) j) != j) goto M2Error;
                */ 

                    if (no_read2(0, (char *) ss, j) != j) goto M2Error; 

                    break; 

                default: 
                    errornum = 5; 
                    goto M2Error; 
            } 
            ++b; 
            if (b < a)  { 
                if (mode == 1) ++ip1; 
                else  { 
                    if (no_read(0, s, 4) != 4) goto M2Error; 
                    imfoff += 4; 
                } 
                n -= 4; 
                c = *ip1; 
                d = c & 0xffffff; 
                c >>= 24; 
            } 
        } 
    } 
    if (n != 0)  { 
        if (mode == 1)  goto M1TERM; 
        errornum = 5; 
        goto M2Error; 
    } 

/* look for termination a second time */ 

/*  (5) fixup i-code          */ 

    errornum = 6; 
    if (no_read(0, s, 4) != 4) goto M2Error; 
    imfoff += 4; 
    n = *ip1; 
    if (no_read(0, s, 4) != 4) goto M2Error; 
    imfoff += 4; 

    n -= 4; 
    a = *ip1;                  /* a = size of fixup table + 1 */ 
    if (a > 1)  { 
        if (mode == 1) ++ip1; 
        else  { 
            if (no_read(0, s, 4) != 4) goto M2Error; 
            imfoff += 4; 
        } 
        n -= 4; 
        b = 1; 
        c = *ip1; 
        d = c & 0xffffff; 
        c >>= 24; 
    } 
    else d = -1; 
    for (i = 0; i < PC; ++i)  { 
        if (i == d)  { 
            switch (c)   {
                case 1: 
                    *(epr.p+i) = *(epr.n+i) + elk.n; 
                    break; 
                case 2: 
                    t = *(epr.n+i); 
                    j = t & 0xfffff; 
                    t >>= 20;   
                    t &= 0xfff; 

                    *(epr.p+i) = *(elk.p+j+2) + t - 1;  /* "+ mainmem" is 
                                                 already added in links 
                                                 fixup (Comment 11-16-92) */ 
                    break; 
                case 3: 
                    *(epr.p+i) = *(epr.n+i) + epr.n; 
                    break; 
                case 4: 
                    *(epr.p+i) = *(epr.n+i) + mainmem; 
                    break; 
                default: 
                    errornum = 7; 
                    goto M2Error; 
            } 
            ++b; 
            if (b < a)  { 
                if (mode == 1) ++ip1; 
                else  { 
                    if (no_read(0, s, 4) != 4) goto M2Error; 
                    imfoff += 4; 
                } 
                n -= 4; 
                c = *ip1; 
                d = c & 0xffffff; 
                c >>= 24; 
            } 
        } 
    } 
    if (n != 0)  { 
        if (mode == 1)  goto M1TERM; 
        errornum = 7; 
        goto M2Error; 
    } 
    if (mode == 2)  { 

/*  (6) record offset to compiler symbol table and read size */ 
      
        errornum = 8; 
        symtaboff = imfoff + 4; 
        if (no_read(0, s, 4) != 4) goto M2Error; 
        imfoff += 4; 
        imfoff += *ip1; 

        no_read(1, s, imfoff); 
/* 
        if (lseek(ifd, imfoff, SEEK_SET) == -1L)  { 
            goto M2Error; 
        } 
*/ 

/*  (7) read procnt, record offset to procedure name table and read size */ 

        errornum = 9; 
        if (no_read(0, s, 4) != 4) goto M2Error; 
        imfoff += 4; 
        procnt = *ip1; 
        protaboff = imfoff + 4; 
        if (no_read(0, s, 4) != 4) goto M2Error; 
        imfoff += 4; 
        imfoff += *ip1; 

        no_read(1, s, imfoff); 
/* 
        if (lseek(ifd, imfoff, SEEK_SET) == -1L)  { 
            goto M2Error; 
        } 
*/ 

/*  (8) record offset to source index table and read size */ 

        errornum = 10; 
        sfindexoff = imfoff + 4; 
        if (no_read(0, s, 4) != 4) goto M2Error; 
        imfoff += 4; 
        sfcnt = *ip1 >> 2;     /* word length of source index table */ 
        imfoff += *ip1; 

        no_read(1, s, imfoff); 
/* 
        if (lseek(ifd, imfoff, SEEK_SET) == -1L)  { 
            goto M2Error; 
        } 
*/ 

/*  (9) load other information */ 

        errornum = 11; 
        if (no_read(0, s, 1) != 1) goto M2Error; 
        imfoff += 1; 
        examineflag  = *s & 0x01; 
        graphicsflag = *s & 0x02; 
        midiflag     = *s & 0x0c;   /* capture both parts of midiflag */ 

        if (no_read(0, s, 1) != 1) goto M2Error; 
        imfoff += 1; 
        printflag = *s & 0xff; 

        errornum = 12; 
        if (no_read(0, s, 4) != 4) goto M2Error; 
        imfoff += 4; 
        if (*ip1 > 0) { 
            if (no_read(0, zfullfilename, (unsigned int) *ip1) != *ip1)  { 
                goto M2Error; 
            } 
        } 
        else zfullfilename[0] = '\0'; 
        imfoff += *ip1; 

        errornum = 13; 
        if (no_read(0, s, 4) != 4) goto M2Error; 
        imfoff += 4; 
        sscnt = *ip1; 

        errornum = 14; 
        if (no_read(0, s, 4) != 4) goto M2Error; 
        imfoff += 4; 
        maxstringlen = *ip1; 

    } 

  /* allocate storage for maximum length string */ 

    if (memstat == 1)  { 
        msgf1(WMSG50, maxstringlen); 
    } 
    if (maxstringlen > global_maxstrlen)  maxstringlen = global_maxstrlen; 

    if (maxstringlen > 0) { 
        if (maxstringlen < 600)  maxstringlen = 600;  /* for details */ 

        if ((maxtemp = (char *) malloc((size_t) maxstringlen)) == NULL)  { 
            msgf0(WMSG54);    /* "Limited memory; try decr len of longest str */
            goto TERM; 
        } 
        if (zmem_push( (long *) maxtemp) == 1)  goto TERM; 
    } 

/* 
   (13) print statistics 

    sprintf(wk1, 
        "** S=%ld, P=%ld, L=%ld, M=%ld **\n", sscnt, PC, *elk.n, maincnt); 
    send_twline(wk1, -1); 
*/ 

/* 
   (14) try to open source code file 

    if (zfullfilename[0] != '\0') { 

        if((sourcefd = open(zfullfilename, O_RDONLY)) == -1) { 
            ss = get_msg_string(WMSG55); 
            error(ss, zfullfilename);  / * "Unable to open source file: %s" * / 
            zfullfilename[0] = '\0'; 
        } 
        close(sourcefd); 
    } 
*/ 


/* (15) closeout */ 

  /* 1. Initialize IPC and fdata.access_type  */ 

    IPC.n = epr.n + 1; 
    for (i = 0; i < 9; ++i)  { 
        fdata[i].access_type = 0; 
    } 

  /* 2. Store zbex variables in ztv structure  */ 

    ztv.zelk.n         = elk.n; 
    ztv.zepr.n         = epr.n; 
    ztv.zIPC.n         = IPC.n; 
    ztv.zsfcnt         = sfcnt; 
    ztv.zprolevel      = 0; 
    ztv.zb1            = 0; 
    ztv.zoperationflag = 0; 
    ztv.zexmode        = 0; 
    ztv.zlnum          = lnum; 
    ztv.zprocnt        = procnt; 
    ztv.zpronum        = -1; 
    ztv.zsfindexoff    = sfindexoff; 
    ztv.zprotaboff     = protaboff; 
    ztv.zsymtaboff     = symtaboff; 
    ztv.zexamineflag   = examineflag; 
    ztv.zprintflag     = printflag; 
    ztv.zpf2           = 0; 
    ztv.zdebugg        = 0; 
    ztv.zmaxtemp       = maxtemp; 
    strcpy(ztv.zinterfile, interfile); 
    strcpy(ztv.zsourcefilename, zfullfilename); 
    strcpy(ztv.zprinter_name, "none"); 

/* look for termination a third time */ 

  /* 3. Set flag showing zbex running in this window */ 

  /* 
    if (mode == 1)  free((void *) links);  / * free links memory (at last) * /
    else  { 
        close(ifd); 
        close(ifd2);   
        ifd  = -1; 
        ifd2 = -1; 
    } 
  */ 

    return (-3); 
 
TERM: 
    if (mode == 1)  goto M1TERM; 
    else            goto M2TERM; 

M2Error: 

    msgf0(WMSG53);    /* "Invalid intermediate file format" */ 

M2TERM: 
    zmem_free(); 
    return (ret); 

M1TERM: 

    zmem_free(); 
    free((void *) links);        /* free all allocated memory */ 
    return (ret); 
} 

/*** FUNCTION  void zcleanup() 

    Purpose:   exit zbex gracefully 

    Input:     none 

    Output:    none

    Return:    void

    Operation: List of tasks.  

               1. Close all files opened by zbex.  Increase the 
                  files_avail variable.  Unlink all possible temporary 
                  files 

               2. Recover all memory allocated by zbex 

               3. Purge the pending write list and recover memory 

                                                                     ***/ 

void zcleanup() 
{ 
    extern file_data   fdata[]; 

    extern long        files_avail; 
 
    char     wk1a[400];                    /* New &dA02/07/09&d@ */ 
    long     i, j; 

/* 1. Close all files opened by zbex.  Increase the files_avail 
      variable.  Unlink all possible temporary files  */ 

    for (i = 0; i < 9; ++i)  { 
        j = fdata[i].access_type; 

      /* be sure that all files are closed */ 

        switch (j) { 
            case 1: 
            case 2: 
            case 3: 
                fclose(fdata[i].fp); 
                ++files_avail; 
                break; 
            case 5: 
            case 6: 
            case 7: 
                close(fdata[i].fd); 
                ++files_avail; 
                break; 
        } 
        if (fdata[i].file_type == 2) { 

            strcpy(wk1a, fdata[i].file_name);             /* New &dA02/07/09&d@ */

            unlink(wk1a); 
        } 
        fdata[i].access_type = 0;   /* file closed */ 
    } 

/* 2. Recover all memory allocated by zbex  */ 

    zmem_free(); 

    return; 
} 

/*** FUNCTION  long zmem_push(long *newadd); 

    Purpose:   push a new calloc/malloc address onto the zmemref stack 

    Input:     long          *newadd    address to add to stack 

    Output:    none

    Return     long   0 = success 
                      1 = failure 

    Structure of push stack 

    ÚÄÄÄÄÄÄÄÄ¿   AÚÄÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
    ³   x    ³    ³  ³   NULL    ³  memloc    ³    To Add: 
    ÀÄÄÄÅÄÄÄÄÙ    ³  ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ 
        ³         ÀÄÄÄÄÄÄÄÄÄ¿                        1. c = B 
        ÀÄÄÄÄÄÄÄÄBÄÄÚÄÄÄÄÄÄÅÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
        |            ³      b    ³  memloc    ³      2. x = C 
        |         Ú ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ 
        |         À Ä Ä Ä Ä ¿ 
        À Ä Ä Ä  CÄÄÚÄÄÄÄÄÄ|ÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
                     ³      c    ³            ³ 
                     ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ 
                                                                     ***/ 

long zmem_push(long *newadd) 
{ 
    extern zint_vars   ztv; 
    element     ip1; 

    if ((ip1.n = (long *) calloc((size_t) 2, (size_t) sizeof (long))) 
            == NULL)  { 
        alt_send_twline("Out of memory\n", -1); 
        return (1); 
    } 
    *ip1.p = (long *) ztv.zmemref;    /* 1.  -> previous block */ 
    ztv.zmemref = ip1.n;              /* top -> current block  */ 
    ++ip1.n; 
    *ip1.p = (long *) newadd;        /* 2.  -> new calloc/malloc address */ 
    return (0); 
} 

/*** FUNCTION  void zmem_free(); 

    Purpose:   free up all calloc/malloc address for this window 

    Input:     none

    Output:    none

    Return     void
                                                                     ***/ 
void zmem_free() 
{ 
    extern zint_vars   ztv; 

    element     ip1; 
    long       *ip2; 

    ip1.n = ztv.zmemref;       /* pointer to start of chain */ 
    while (ip1.n != NULL)  { 
        ip2 = *(ip1.p + 1);    /* block to free */ 
        free((void *) ip2); 
        ip2 = ip1.n; 
        ip1.n = *ip1.p;        /* pointer to next link in chain (or NULL) */ 
        free((void *) ip2);    /* free up this link */ 
    } 
} 

/*** FUNCTION  void zmem_free_addr(add_pt); 

    Purpose:   free up a specific calloc/malloc address for this window 

    Input:     long           *add_pt 

    Output:    none

    Return     void
                                                                     ***/ 
void zmem_free_addr(long *add_pt) 
{ 
    extern zint_vars   ztv; 

    element     ip1, ip3; 
    long       *ip2; 

    ip1.n = ztv.zmemref;       /* pointer to start of chain */ 
    if (ip1.n != NULL)   { 
        ip2 = *(ip1.p + 1);    /* address of block to look at 
                                                  for possible freeing */ 
        if (ip2 == add_pt)  { 
            free((void *) ip2);      /* free memory */ 
            ip2 = ip1.n;       /* address of this link space (2 words) */ 
            ip1.n = *ip1.p;    /* pointer to next link in chain (or NULL) */ 
            ztv.zmemref = ip1.n; 
            free((void *) ip2);       /* free up this link space */ 
            return; 
        } 
        ip3.n = ip1.n;         /* save pointer to this link space */ 
        ip1.n = *ip1.p;        /* pointer to next link in chain (or NULL) */ 
    } 
    else return; 

    while (ip1.n != NULL)  { 
        ip2 = *(ip1.p + 1);    /* address of block to look at 
                                                  for possible freeing */ 
        if (ip2 == add_pt)  { 
            free((void *) ip2); 
            ip2 = ip1.n;       /* address of this link space (2 words) */ 
            ip1.n = *ip1.p;    /* pointer to next link in chain (or NULL) */ 
            *ip3.p = ip1.n; 
            free((void *) ip2);       /* free up this link space */ 
            return; 
        } 
        ip3.n = ip1.n;         /* save pointer to this link space */ 
        ip1.n = *ip1.p;        /* pointer to next link in chain (or NULL) */ 
    } 
} 

/*** FUNCTION  long no_read(int flag, char *out, long size); 

    Purpose:   Read the next (size) bytes from the global string ww_prog 

    Input:     int flag:   0 = read; 1 = lseek         
               long size = number of bytes to no_read 

    Output:    In char *out 

    Return     number of bytes no_read 
                                                                     ***/ 
long no_read(int flag, char *out, long size) 
{ 
    extern unsigned char  *ww_prog_pnt;   /* must be global */ 

    static long pnter = 0; 
    long i;  

    if (flag == 0)  {                      /* this is a read */ 
        for (i = 0; i < size; ++i) { 
            *(out+i) = *(ww_prog_pnt + pnter); 
            ++pnter; 
        } 
        return (size); 
    } 
    pnter = size; 
    return (0); 
} 

/*** FUNCTION  long no_read2(int flag, char *out, long size); 

    Purpose:   Read the next (size) bytes from the global string ww_prog 

    Input:     int flag:   0 = read; 1 = lseek         
               long size = number of bytes to no_read 

    Output:    In char *out 

    Return     number of bytes no_read 
                                                                     ***/ 
long no_read2(int flag, char *out, long size) 
{ 
    extern unsigned char  *ww_prog_pnt;   /* must be global */ 

    static long pnter = 0; 
    long i; 

    if (flag == 0)  {                      /* this is a read */ 
        for (i = 0; i < size; ++i) { 
            *(out+i) = *(ww_prog_pnt + pnter); 
            ++pnter; 
        } 
        return (size); 
    } 
    pnter = size; 
    return (0); 
} 
