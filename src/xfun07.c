/***                         DMUSE PROGRAM 
                           LINUX version 0.02 
            (c) Copyright 1992, 1999, 2007 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 02/15/2008) 
                            (rev. 02/07/2009) 
                            (rev. 12/27/2009) 
                            (rev. 03/17/2010) 

                             I/O  Utilities 
                                                                        ***/ 

#define   TRANS_SIZE       6
#define   MN400          400 

#include  "all.h" 

/*** FUNCTION   long my_make_full_path(char *ss1, char *ss2, char *ss3); 

      Purpose:  Expand internal path to Linux path            

      Input:    char *ss3      internal path

      Output:   char *ss1      fully expanded path 
                char *ss2      expanded path starting with disk name 

      Return:   -1:  unable to expand this path 
                 0:  successful expansion 

                                                            ***/ 

long my_make_full_path(char *ss1, char *ss2, char *ss3) 
{ 
    char            wk1[400]; 
    char            wk2[450]; 
    char            wk5[950]; 
    long            k; 

    strncpy(wk1, ss3, 390); 
    wk1[380] = '\0'; 
    k = strlen(wk1); 
    if (k > 308)  { 
        return (-1); 
    }   

    if (wk1[0] == '/')   {            /* input arg was full path name */ 
        strcpy(ss1, wk1); 
        strcpy(ss2, wk1); 
        return (0); 
    } 

    if (getcwd(wk2, 400) == NULL) { 
        return (-1); 
    } 
    sprintf(wk5, "%s/%s", wk2, wk1); 

    k = strlen(wk5); 
    if (k > 308)  { 
        return (-1); 
    }   

    strcpy(ss1, wk5); 
    strcpy(ss2, wk5); 
    return (0); 
} 
