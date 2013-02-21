/***                         DMUSE PROGRAM 
                           LINUX version 0.02 
            (c) Copyright 1992, 1999, 2007 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 12/05/2008) 
                            (rev. 02/07/2009) 
                            (rev. 12/27/2009) 
                            (rev. 01/23/2010) 

                   Program open and close operations 
                          Interrupt Handlers 
                                                                        ***/ 

#define   TRANS_SIZE       6
#define   FINAL_SIZE  850000 

#include  "all.h" 

 
/*** FUNCTION   char *my_errormsg(my_errno); 

      Purpose:  Construct a string from an error number    

      Input:    int my_errno:   error number 

      Return:   pointer to a string (guarenteed) 
                                                                   ***/

char *my_errormsg(int my_errno) 
{
    extern char    sys_error_message[]; 

    char          *sp1; 
    static char   *messages[34] = 
      /*  1 */         {"(EPERM): Operation not permitted", 
      /*  2 */          "(ENOENT): No such file or directory", 
      /*  3 */          "(ESRCH): No such process", 
      /*  4 */          "(EINTR): Interrupted system call", 
      /*  5 */          "(EIO): I/O error", 
      /*  6 */          "(ENXIO): No such device or address", 
      /*  7 */          "(E2BIG): Argument list too long", 
      /*  8 */          "(ENOEXEC): Exec format error", 
      /*  9 */          "(EBADF): Bad file number", 
      /* 10 */          "(ECHILD): No child processes", 
      /* 11 */          "(EAGAIN): Try again", 
      /* 12 */          "(ENOMEM): Out of memory", 
      /* 13 */          "(EACCES): Permission denied", 
      /* 14 */          "(EFAULT): Bad address", 
      /* 15 */          "(ENOTBLK): Block device required", 
      /* 16 */          "(EBUSY): Device or resource busy", 
      /* 17 */          "(EEXIST): File exists", 
      /* 18 */          "(EXDEV): Cross-device link", 
      /* 19 */          "(ENODEV): No such device", 
      /* 20 */          "(ENOTDIR): Not a directory", 
      /* 21 */          "(EISDIR): Is a directory", 
      /* 22 */          "(EINVAL): Invalid argument", 
      /* 23 */          "(ENFILE): File table overflow", 
      /* 24 */          "(EMFILE): Too many open files", 
      /* 25 */          "(ENOTTY): Not a typewriter", 
      /* 26 */          "(ETXTBSY): Text file busy", 
      /* 27 */          "(EFBIG): File too large", 
      /* 28 */          "(ENOSPC): No space left on device", 
      /* 29 */          "(ESPIPE): Illegal seek", 
      /* 30 */          "(EROFS): Read-only file system", 
      /* 31 */          "(EMLINK): Too many links", 
      /* 32 */          "(EPIPE): Broken pipe", 
      /* 33 */          "(EDOM): Math argument out of domain of func", 
      /* 34 */          "(ERANGE): Math result not representable"}; 
                          
    sp1 = sys_error_message; 
    if ( (my_errno > 0) && (my_errno) < 35)  { 
        sprintf(sp1, "   Error %d %s\n", my_errno, messages[my_errno]); 
    } 
    else  { 
        sprintf(sp1, "   Error %d (unknown): No message available\n", my_errno);
    } 
    return (sp1); 
} 
