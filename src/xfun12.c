/***                         DMUSE PROGRAM 
                           LINUX version 0.02 
            (c) Copyright 1992, 1999, 2007 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 10/02/2008) 
                            (rev. 02/07/2009) 
                            (rev. 09/07/2009) 
                            (rev. 12/27/2009) 

           Programs to interact with Ten Windows in Connect Mode 
                                                                        ***/ 

#include  "all.h" 

/*** FUNCTION   long send_twline(line, leng); 

      Purpose:  Send a line of characters to stdout

                char *line   pointer to line to send to blackboard 
                long  leng   length of line to send.  If len = -1, 
                               line is NULL terminated; send entire line 
                               If len = -2, send a '\n' character 
                               after sending line.  

      Return:   long         number of characters sent 

                                                                  ***/ 

long send_twline(char *line, long leng) 
{ 
    char            wk1[20000]; 
    long            n; 

    n = 0; 

    if (leng < 20000)  { 
        if (leng > 0)  { 
            strncpy(wk1, line, leng); 
            wk1[leng] = '\0'; 
        } 
        if (leng == -1)  { 
            strcpy(wk1, line); 
        }                
        if (leng == -2)  { 
            strcpy(wk1, line); 
            strcat(wk1, "\n"); 
        } 

        fputs(wk1, stdout); 
    /*  printf(wk1); */ 
        n = strlen(wk1); 
    } 
    return (n); 
} 

/*** FUNCTION   long alt_send_twline(line, leng); 

      Purpose:  Send a line of characters to stderr 

                char *line   pointer to line to send to blackboard 
                long  leng   length of line to send.  If len = -1, 
                               line is NULL terminated; send entire line 
                               If len = -2, send a '\n' character 
                               after sending line.  

      Return:   long         number of characters sent 

                                                                  ***/ 

long alt_send_twline(char *line, long leng) 
{ 
    char            wk1[20000]; 
    long            n; 

    n = 0; 

    if (leng < 20000)  { 
        if (leng > 0)  { 
            strncpy(wk1, line, leng); 
            wk1[leng] = '\0'; 
        } 
        if (leng == -1)  { 
            strcpy(wk1, line); 
        }                
        if (leng == -2)  { 
            strcpy(wk1, line); 
            strcat(wk1, "\n"); 
        } 

        fputs(wk1, stderr); 
    /*  printf(wk1); */ 
        n = strlen(wk1); 
    } 
    return (n); 
} 
