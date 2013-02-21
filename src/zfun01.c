/***                         DMUSE PROGRAM 
                           LINUX version 0.02 
            (c) Copyright 1992, 1999, 2007 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 09/13/2007) 
                            (rev. 12/27/2009) 

                    Zbex I/O interface subroutines 
                                                                        ***/ 

#include  "all.h" 


/*** FUNCTION  long my_getline(s, limit); 

    Purpose:   get line from terminal

    Input:     char  *s        pointer to buffer for line 
               long   limit    maximum length of line accepted 

    Return:         >0: length of line (including \n character) 
                    -1: suspend operation (Shift-pad *, or window change) 
                    -2: line returned with !! at beginning 
                    -3: F9 pressed while zbex was waiting for input 

    Operation: Under normal operation, the function returns a line 
               read from the current window.  The line will always 
               be terminated by '\n' and '\0'.  This means that the 
               maximum data in the line will be (limit-2) bytes in 
               length.  The line may contain highlight control sequences 
               (i.e., <esc>&d<letter>) if there were highlights in the 
               line.  The length returned includes the '\n' character.  

               Abnormal conditions are as follows: 

               (-1) The user typed Shift-(pad *) to disconnect the 
               window from the program, the user typed (pad-<number>) 
               to change windows.  The calling program will have to 
               decide how to handle this situation.  

               (-2) A line was entered of length 2 or more, with the 
               first two characters being "!!".  This signals the 
               user's desire to terminate the current program, but to 
               stay in connect mode.  

               (longjmp to closeout) The user wants to exit TenX altogether.  

                                                                     ***/ 

long my_getline(char *s, long limit) 
{ 
    char  *sp1; 
    char   wk1[500]; 

    long   k; 

    sp1 = wk1;

    fgets(sp1, 400, stdin); 
    wk1[398] = '\0'; 
    k = strlen(wk1); 
    if (k >= limit)   wk1[limit-1] = '\0'; 
    k = strlen(wk1); 

    strcpy(s, wk1); 
    k = strlen(s); 

    if ( (wk1[0] == '!')  &&  (wk1[1] == '!')  )  { 
        k = -2; 
    } 
    return (k); 
} 

/*** FUNCTION  long trmline(s):

    Purpose:   Identify the last non-blank and non-newline  character in 
                 a line.  

    Input:     char  *s   = pointer to line.  It is assumed that that last 
                            character in the line before the sentinal is \n.  

    Output:    Function returns the length of a "trimmed" line, i.e. the 
               length up to the last non-blank character, not including 
               the '\n' charcter.  Return is (0) if the line is all blanks 
               (or zero blanks) up to the '\n' character.  
                                                                     ***/ 

long trmline(char *s)
{ 
    long i;

    for (i = 0; s[i] != '\n'; ++i) ;  /* find first newline character */ 
    for (i -= 1; i >= 0 && (s[i] == ' '); --i) ; 
    ++i; 
    return (i); 
} 

/*** FUNCTION  void error(s1, s2): 

    Purpose:   Report on failure to open file for reading 

    Input:     s1 -> "Can't open %s" 
               s2 -> file name 

    Operation: Called when attempt to open file returns with an error.  
               Prints local error message and system error message.  

                                                                     ***/ 
void error(char *s1, char *s2) 
{
    char  wk1[200]; 
    char *sp1; 

    sprintf(wk1, s1, s2); 
    alt_send_twline(wk1, -1); 

    sp1 = my_errormsg(errno); 
    sprintf(wk1, " (%s)", sp1); 
    alt_send_twline(wk1, -1); 

    alt_send_twline("\n", 1); 
    return; 
} 

/*** FUNCTION  void terminate_ww(); 

    Purpose:   Terminate program                           

    Input:     none

    Output:    none

    Note:      This function is probably superfluous, but for the time 
               being, it is harmless.  It keeps the code from being 
               cluttered with a lot of longjmps.  
                                                                     ***/ 

void terminate_ww() 
{
    extern jmp_buf     sjbuf; 
    extern char        inter_longjmp;  /* New &dA01/29/07&d@: longjmp alert for interpret */

    inter_longjmp = 1; 
    longjmp(sjbuf, 2);          /* return killflag = 2 */ 
} 
