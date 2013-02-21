/***                         DMUSE PROGRAM 
                           LINUX version 0.00 
            (c) Copyright 1992, 1999, 2007 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 09/18/2007) 
                            (rev. 02/07/2009) 
                            (rev. 12/27/2009) 

          Zbex Interpreter Examine Mode + Argument Passing 
                                                                        ***/ 
#include  "all.h" 

/*** FUNCTION   void pass_argument(EPT, xcode, xdim, opflg);    

    Purpose:   pass an argument to or from a procedure

    Input:     long   *var      pointer to location in i-code where 
                                  local variable link address is stored 
                                  calling variable link address is stored 
                                  at var+1.  
               long    xcode    type of variable 
               long    xdim     dimension of variable 
               long    opflg    operation flag   1 = pass argument to 
                                                       procedure 
                                                 2 = pass argument to 
                                                       calling environment 

    Return:    void

    Output:    none
                                                                ***/ 

void pass_argument(long *var, long xcode, long xdim, long opflg) 
{ 
    extern element IPC; 

    element source, destination; 
    char   *sp1, *sp2; 
    long    slen, mlen; 
    long   *ip1, *ip2, *ip3, *ip4; 
    long    h, i, j, k; 
    long    soff, doff; 

/* determine source and destination pointers */ 

    if (opflg == 2)  { 
        source.n = var; 
        destination.n = var+1; 
    } 
    else { 
        source.n = var+1; 
        destination.n = var; 
    } 

/* transfer variable  */ 

    if (xdim == 0)  { 
        switch (xcode)  { 
            case 1: 
                slen = *(*(*source.q)); 
                mlen = *(*destination.p+1); 
                if (slen > mlen)  { 
                    strlenerr2(slen, mlen, IPC.n, *destination.p); 
                } 
                sp1 = (char *) (*(*destination.q) + 1); 
                sp2 = (char *) (*(*source.q) + 1); 
                memcpy((void *) sp1, (void *) sp2, (size_t) slen); 
                *(*(*destination.q)) = slen; 
                break; 
            case 2: 
                slen = *(*(*source.q)); 
                mlen = *(*destination.p+1); 
                if (slen > mlen)  { 
                    strlenerr2(slen, mlen, IPC.n, *destination.p); 
                } 
                ip1 = (*(*destination.q) + 1); 
                ip2 = (*(*source.q) + 1); 
                h = (slen + 31) / 32; 
                for (i = 0; i < h; ++i)  { 
                   *ip1++ = *ip2++; 
                } 
                *(*(*destination.q)) = slen; 
                break; 
            case 4: 
                *(*destination.p+1) = *(*source.p+1); 
            case 3: 
                *(*destination.p) = *(*source.p); 
                break; 
        } 
    } 
    else { 
        for (i = 0, j = 1; i < xdim; ++i)  { 
            j *= (*(*source.p+1+i)); 
        } 
        switch (xcode)  { 
            case 1: 
                soff = *(*source.p     +xdim+2); 
                soff = (soff + 7) / 4; 
                mlen = *(*destination.p+xdim+2); 
                doff = (mlen + 7) / 4; 
                ip1  = *(*destination.q + xdim + 1); 
                ip2  = *(*source.q      + xdim + 1); 
                for (i = 0; i < j; ++i)  { 
                    slen = *ip2; 
                    sp1 = (char *) (ip1+1); 
                    sp2 = (char *) (ip2+1); 
                    if (slen > mlen)  { 
                        strlenerr2(slen, mlen, IPC.n, *destination.p); 
                    } 
                    memcpy((void *) sp1, (void *) sp2, (size_t) slen); 
                    *ip1 = slen; 
                    ip1 += doff; 
                    ip2 += soff; 
                } 
                break; 
            case 2: 
                soff = *(*source.p     +xdim+2); 
                soff = (soff + 63) / 32; 
                mlen = *(*destination.p+xdim+2); 
                doff = (mlen + 63) / 32; 
                ip1  = *(*destination.q + xdim + 1); 
                ip2  = *(*source.q      + xdim + 1); 
                for (i = 0; i < j; ++i)  { 
                    slen = *ip2; 
                    ip3 = ip1 + 1; 
                    ip4 = ip2 + 1; 
                    if (slen > mlen)  { 
                        strlenerr2(slen, mlen, IPC.n, *destination.p); 
                    } 
                    h = (slen + 31) / 32; 
                    for (k = 0; k < h; ++k)  { 
                       *ip3++ = *ip4++; 
                    } 
                    *ip1 = slen; 
                    ip1 += doff; 
                    ip2 += soff; 
                } 
                break; 
            case 4: 
                j <<= 1; 
            case 3: 
                ip1 = *(*destination.q + xdim + 1); 
                ip2 = *(*source.q      + xdim + 1); 
                for (i = 0; i < j; ++i)  { 
                    *ip1++ = *ip2++; 
                } 
                break; 
        } 
    } 
    return; 
} 
