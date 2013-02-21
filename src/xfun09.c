/***                         DMUSE PROGRAM 
                           LINUX version 0.02 
            (c) Copyright 1992, 1999, 2007 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 04/11/2007) 
                            (rev. 02/06/2009) 
                            (rev. 09/10/2009) 
                            (rev. 12/27/2009) 

                    Ten Windows File Program Module 
                                                                        ***/ 

#define   FLIMIT        3555 
#define   NAME_MAX        80

#include  "all.h" 

/*** FUNCTION   long check_fname(char *name): 

       Purpose: check validity of file name

       Input:   char  name    name to check

       Output:  long  s = 0    name valid for file 
                      s = -1   name not allowed in Dmuse 

                                                          ***/
long check_fname(char *name)
{
    long i, k;
    char c;

    k = strlen(name); 

    for (i = 0; i < k; ++i)  { 
        c = *(name + i); 

        if ( ( (c >= 'A') && (c <= 'Z') )  || 
             ( (c >= 'a') && (c <= 'z') )  || 
             ( (c >= '0') && (c <= '9') )  || 
               (c == '@') || (c == '_')    || 
               (c == '~') || (c == '=')    || 
               (c == '.') || (c == '#')    || 
               (c == '-') || (c == '!')    )  ;    /* '!' added &dA02/07/09&d@ */ 
        else  { 
            return (-1); 
        } 
    } 
    return (0); 
}

/*** FUNCTION   long parse_line(*line, *args[], size, length) 

       Purpose: Parse a line into a set of argument variables.  

       Input:   char  *line      line to parse 
                char  *args[]    array of pointers 
                long   size      size of array 
                long   length    length of each array element 

       Output;  long   number of arguments found 

       Operation: line must be NULL terminated or \n terminated. 
                  It is assumed that the first character of line 
                  is non-blank.  Otherwise, the first argument will 
                  be the null string.  If the line is of length 0, 
                  the number of arguments will be zero.  
                                                          ***/

long parse_line(char *line, char *args[], long size, long length) 
{ 
    long  n, i; 
    char *sp1, *sp2; 

    for (sp1 = line, n = 0; n < size && *sp1 != '\n' && *sp1 != '\0'; ++n) { 
        sp2 = args[n]; 
        for (i = 0; *sp1 != ' '  && *sp1 != '\n' && 
                    *sp1 != '\0' && i < length-1; ++i)  { 
            *sp2++ = *sp1++; 
        } 
        *sp2 = '\0'; 
        while (*sp1 == ' ') ++sp1; 
    } 
    return (n); 
} 
