/***                         DMUSE PROGRAM 
                           LINUX version 1.00 
            (c) Copyright 1992, 1999, 2007 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 01/17/2008) 
                            (rev. 05/08/2010) 

                  Function Definitions for Ten Windows 
                                                                    ***/

       /***   xfun01.c   Functions accessing disk swap memory ***/

void   my_delay(long n);
                                                             
       /***   xfun07.c   I/O Utilities                        ***/

long   my_make_full_path(char *ss1, char *ss2, char *ss3);  /* xm,7,9 */ 

       /***   xfun09.c   File Program Functions               ***/

long   check_fname(char *name);                             /* 9 */
long   parse_line(char *line, char *args[], long size, 
           long length);                                    /* 9 */ 


       /***   xfun11.c   Program open and close operations    ***/

char  *my_errormsg(int my_errno);                           /* 11 */ 

       /***   xfun12.c   Programs interacting in connect mode ***/

long   send_twline(char *line, long leng);                  /* M,12,zm,z1 
                                            z21,z22,z24,z25,z27,z29,z30 */ 
long   alt_send_twline(char *line, long leng);              /* M,12,zm,z1 
                                            z21,z22,z24,z25,z27,z29,z30 */ 
