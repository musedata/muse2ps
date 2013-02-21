/***                         DMUSE PROGRAM 
                           LINUX version 0.00 
            (c) Copyright 1992, 1999, 2007 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 09/15/2007) 
                            (rev. 02/07/2009) 
                            (rev. 12/27/2009) 

                 Zbex Interpreter message handling routines 
                                                                        ***/ 
#include  "all.h" 

/*** 
                          Discussion of Error types 
                        컴컴컴컴컴컴컴컴컴컴컴컴컴컴� 
There are four basic types of error messages.  These types are sufficiently 
different so as to merit their own error handling functions.  Within some 
of these types, there are different error formats.  Each of these will 
require its own print statement.  The error messages themselves may be 
stored in an error message file, and read when required.  This procedure 
will save about 5000 bytes.  

The four basic format types, together with their sub-types are listed below: 

Type I:    Put out a simple error message.  No parameters.  

           Call format:  errf1(ERR#);          

           Return:       always terminate 

Type II:   Put out message which includes the line number, and may include 
           a variable name (and type), and from 0 to 3 additional integer 
           parameters 

           Call format:   errf2(ERR#, format, loc, variable #, val1, val2, val3);

           Sub-formats:   1    line# 
                          2    line#, value 
                          3    line#, value, value 
                          4    variable and type, line#, value, value 
                          5    value, variable and type, line# 
                          6    value, variable and type, line#, value, value 
                          7    value, value, variable and type, line# 

           Return:        yes 

Type III:  Put out message with real value and line number 

           Call format:   errf3(ERR#, loc, real value); 

           Sub-formats:   none 

           Return:        yes 


Type IV:   Put out message with string value, line number and from 1 to 3 
           integer values 

           Call format:   errf4(ERR#, format, loc, str val, val1, val2, val3); 

           Sub-formats:   0    string value, line# 
                          1    string value, value1, line# 
                          2    string value, value1, value2, line# 
                          3    string value, value1, value2, value3, line# 

           Return:        yes

                            General Message types 
                        컴컴컴컴컴컴컴컴컴컴컴컴컴컴� 
There are two basic message types.  

Type I:    Simply put out a simple message.  No parameters.  

           Call format:  msgf0(MSG#); 

           Return:       always 

Type II:   Simply put out a message with one integer parameter.  

           Call format:  msgf1(MSG#, val); 

           Return:       always 
                                                                      ***/ 

/*** FUNCTION  void zerodiv(*loc); 

    Purpose:   report on attempt to divide by integer 0 

    Input:     long   *loc      location in program 

    Return:    none

    Operation: type II, format 1 
                                                                     ***/ 

void zerodiv(long *loc) 
{ 
    errf2(WERR1, 1, loc, NULL, 0L, 0L, 0L); 
    terminate_ww(); 
} 

/*** FUNCTION  void rzerodiv(*loc); 

    Purpose:   report on attempt to divide by real 0.0 

    Input:     long   *loc      location in program 

    Return:    none

    Operation: type II, format 1 
                                                                     ***/ 

void rzerodiv(long *loc) 
{ 
    errf2(WERR2, 1, loc, NULL, 0L, 0L, 0L); 
    terminate_ww(); 
} 

/*** FUNCTION  void suberr(a, b, *loc, *lnk, i); 

    Purpose:   report on array subscript error           

    Input:     long    a        subscript value 
               long    b        maximum value  
               long   *loc      location in program 
               long   *lnk      location of offending array variable 
               long    i        subscript number - 1 

    Return:    none

    Operation: type II, format 6 
                                                                     ***/ 

void suberr(long a, long b, long *loc, long *lnk, long i) 
{ 
    errf2(WERR3, 6, loc, lnk, i+1, a, b); 
    terminate_ww(); 
} 

/*** FUNCTION  void strsuberr(a, b, TIPC, i); 

    Purpose:   report on string subscript error 

    Input:     long    a        subscript value 
               long    b        maximum value  
               element TIPC     union pointer to offending string var 
               long    i        subscript number    

    Return:    none

    Operation: type II, format 6 
                                                                     ***/ 

void strsuberr(long a, long b, element TIPC, long i) 
{ 
    errf2(WERR4, 6, TIPC.n, *TIPC.p, i, a, b); 
    terminate_ww(); 
} 

/*** FUNCTION  void strsubwarn(a, b, TIPC, i); 

    Purpose:   give warning on string subscript error 

    Input:     long    a        subscript value 
               long    b        maximum value  
               element TIPC     union pointer to offending string var 
               long    i        subscript number    

    Return:    yes 

    Operation: type II, format 6 
                                                                     ***/ 

void strsubwarn(long a, long b, element TIPC, long i) 
{ 
    extern zint_vars   ztv; 

    if ((ztv.zoperationflag & 0x0100) != 0)  { 
        errf2(WERR5, 6, TIPC.n, *TIPC.p, i, a, b); 
    } 
    return; 
} 

/*** FUNCTION  void strlenerr(a, b, TIPC, maxf); 

    Purpose:   report on maximum size of string exceeded 

    Input:     long    a        attempted length 
               long    b        maximum allowed length 
               element TIPC     union pointer to LHS variable in i-code 
               long    maxf     0 = report normal string length error 
                                1 = report maxstringlen exceeded 
                                2 = report maxstringlen exceeded for bstr 

    Return:    none

    Operation: type II, format 4    
                                                                     ***/ 

void strlenerr(long a, long b, element TIPC, long maxf) 
{ 
    switch (maxf)  { 
        case 0: 
            errf2(WERR6, 4, TIPC.n, *TIPC.p, a, b, 0); 
            break; 
        case 2: 
            a = (a + 7) >> 3; 
            b >>= 3; 
        case 1: 
            errf2(WERR61, 4, TIPC.n, *TIPC.p, a, b, 0); 
            break; 
    } 
    terminate_ww(); 
} 

/*** FUNCTION  void strlenerr2(a, b, *loc, *lnk); 

    Purpose:   report on maximum size of string exceeded 

    Input:     long    a        attempted length 
               long    b        maximum allowed length 
               long   *loc      location in program 
               long   *lnk      location of offending array variable 

    Return:    none

    Operation: type II, format 4    
                                                                     ***/ 

void strlenerr2(long a, long b, long *loc, long *lnk) 
{ 
    errf2(WERR6, 4, loc, lnk, a, b, 0); 
    terminate_ww(); 
} 

/*** FUNCTION  void calcstrlenerr(a, b, TIPC); 

    Purpose:   report on calculated length of string exceeding max length 

    Input:     long    a        calculated length 
               long    b        maximum allowed length 
               element TIPC     union pointer to LHS variable in i-code 

    Return:    none

    Operation: type II, format 4    
                                                                     ***/ 

void calcstrlenerr(long a, long b, element TIPC) 
{ 
    errf2(WERR58, 4, TIPC.n, *TIPC.p, a, b, 0); 
    terminate_ww(); 
} 

/*** FUNCTION  void dyanmicarrayerr(*loc, n); 

    Purpose:   report on illegal dynamic array parameters            

    Input:     long   *loc      location in program 
               long    n        value of product of array parameters 

    Return:    none

    Operation: type II, format 2 
                                                                     ***/ 

void dynamicarrayerr(long *loc, long n) 
{ 
    errf2(WERR59, 2, loc, NULL, n, 0L, 0L); 
    terminate_ww(); 
} 

/*** FUNCTION  void planenumerr(a, b, *loc); 

    Purpose:   report on plane number out of range     

    Input:     long    a        attempted plane number 
               long    b        maximum legal plane number 
               long   *loc      location in program 

    Return:    none

    Operation: type II, format 3 
                                                                     ***/ 

void planenumerr(long a, long b, long *loc) 
{ 
    errf2(WERR60, 3, loc, NULL, a, b, 0L); 
    terminate_ww(); 
} 

/*** FUNCTION  void strlenwarn(a, b, *loc, *lnk); 

    Purpose:   give warning on maximum size of string exceeded 

    Input:     long    a        attempted length 
               long    b        maximum allowed length 
               long   *loc      location in program 
               long   *lnk      location of offending array variable 

    Return:    yes 

    Operation: type II, format 4 
                                                                     ***/ 

void strlenwarn(long a, long b, long *loc, long *lnk) 
{ 
    extern zint_vars  ztv; 

    if ((ztv.zoperationflag & 0x0100) != 0)  { 
        errf2(WERR7, 4, loc, lnk, a, b, 0L); 
    } 
    return; 
} 

/*** FUNCTION  void negstrlen(a, TIPC); 

    Purpose:   report on negative string subscript error 

    Input:     long    a        reported string length 
               element TIPC     union pointer to string variable 

    Return:    none

    Operation: type II, format 5 
                                                                     ***/ 

void negstrlen(long a, element TIPC) 
{ 
    errf2(WERR8, 5, TIPC.n, *TIPC.p, a, 0L, 0L); 
    terminate_ww(); 
} 

/*** FUNCTION  void negstrwarn(a, TIPC); 

    Purpose:   give warning on negative string subscript error 

    Input:     long    a        reported string length 
               element TIPC     union pointer to offending string var 

    Return:    yes 

    Operation: type II, format 5 
                                                                     ***/ 

void negstrwarn(long a, element TIPC) 
{ 
    extern zint_vars   ztv;  

    if ((ztv.zoperationflag & 0x0100) != 0)  { 
        errf2(WERR9, 5, TIPC.n, *TIPC.p, a, 0L, 0L); 
    } 
    return; 
} 

/*** FUNCTION  void tgeterr1(*loc); 

    Purpose:   report on attempt to sequentially get a data group 
                 beyond the end of a table 

    Input:     long   *loc      location in program 

    Return:    none

    Operation: type II, format 1 
                                                                     ***/ 

void tgeterr1(long *loc) 
{ 
    errf2(WERR10, 1, loc, NULL, 0L, 0L, 0L); 
    terminate_ww(); 
} 

/*** FUNCTION  void tgeterr2(a, b, *loc); 

    Purpose:   report on index to table out-of-bounds

    Input:     long    a        index value    
               long    b        maximum value  
               long   *loc      location in program 

    Return:    none

    Operation: type II, format 3 
                                                                     ***/ 

void tgeterr2(long a, long b, long *loc) 
{ 
    errf2(WERR11, 3, loc, NULL, a, b, 0L); 
    terminate_ww(); 
} 

/*** FUNCTION  void tputerr1(a, b, *loc); 

    Purpose:   report on size of table exceeding 90% of max 

    Input:     long    a        current size 
               long    b        maximum size 
               long   *loc      location in program 

    Return:    none

    Operation: type II, format 3 
                                                                     ***/ 

void tputerr1(long a, long b, long *loc) 
{ 
    errf2(WERR12, 3, loc, NULL, a, b, 0L); 
    terminate_ww(); 
} 

/*** FUNCTION  void funcwarn(a, val, *loc); 

    Purpose:   report on problem with real function argument    

    Input:     long    a        type of function  (problem) 
                                컴컴컴컴컴컴컴컴  컴컴컴컴컴컴컴컴컴 
                                  1 = sin         arg too big 
                                  2 = cos         arg too big 
                                  3 = tan         arg too big 
                                  4 = ars         arg too big 
                                  5 = arc         arg too big 
                                  6 = exx         arg causes overflow 
                                  7 = lnx         arg out of range 
                                  8 = sqt         arg out of range 

               double  val      current value of argument 
               long   *loc      location in program 

    Return:    yes 

    Operation: type III 
                                                                     ***/ 

void funcwarn(long a, double val, long *loc) 
{ 
    extern zint_vars   ztv;  

    int    n; 
    --a; 
    a *= 2; 
    n = WERR13 + a; 
    if ((ztv.zoperationflag & 0x0080) != 0)  { 
        errf3(n, loc, val); 
    } 
    return; 
} 

/*** FUNCTION  void strwarn1(a, b, *loc, *lnk); 

    Purpose:   give warning on insertion of length being different from 
                 space for insertion 

    Input:     long    a        length of insertion 
               long    b        space for insertion   
               long   *loc      location in program 
               long   *lnk      location of offending array string variable 

    Return:    yes 

    Operation: type II, format 7 
                                                                     ***/ 

void strwarn1(long a, long b, long *loc, long *lnk) 
{ 
    extern zint_vars   ztv;  

    if ((ztv.zoperationflag & 0x0040) != 0)  { 
        errf2(WERR21, 7, loc, lnk, a, b, 0L); 
    } 
    return; 
} 

/*** FUNCTION  void fileerr1(*loc, n); 

    Purpose:   report on descriptor less than 1 or greater than 9 

    Input:     long   *loc      location in program 
               long    n        value of descriptor 

    Return:    none

    Operation: type II, format 2 
                                                                     ***/ 

void fileerr1(long *loc, long n) 
{ 
    errf2(WERR22, 2, loc, NULL, n, 0L, 0L); 
    terminate_ww(); 
} 

/*** FUNCTION  void fileerr2(*loc, n); 

    Purpose:   report on attempt to open file for anything other than 
                 getf, putf, read or write 

    Input:     long   *loc      location in program 
               long    n        type of access requested 

    Return:    none

    Operation: type II, format 2 
                                                                     ***/ 

void fileerr2(long *loc, long n) 
{ 
    errf2(WERR23, 2, loc, NULL, n, 0L, 0L); 
    terminate_ww(); 
} 

/*** FUNCTION  void fileerr3(*loc, *name, k, n); 

    Purpose:   report on attempt to open file that is already open for 
                 access type n             

    Input:     long   *loc      location in program 
               char   *name     name of open file 
               long    k        descriptor number 
               long    n        type of access of open file 

    Return:    none

    Operation: type IV, format 2 
                                                                     ***/ 

void fileerr3(long *loc, char *name, long k, long n) 
{ 
    errf4(WERR24, 2, loc, name, k, n, 0L); 
    terminate_ww(); 
} 

/*** FUNCTION  void fileerr4(*loc, *name, k, n, f); 

    Purpose:   report on attempt to access files in ways for which the 
                 file was not open, on general read/write failure 

    Input:     long   *loc      location in program 
               char   *name     name of open file 
               long    k        descriptor number 
               long    n        type of access of open file 
               long    f        situation 

        f = 1:  report on attempt to get a record from a file 
                  not open for getf 
        f = 2:  report on attempt to put a record to a file 
                  not open for putf 
        f = 3:  report on attempt to read from a file       
                  not open for reading 
        f = 4:  report on attempt to write randomly to a file 
                  not open for random writing 
        f = 5:  report on attempt to write to a file     
                  not open for writing 
        f = 6:  report on general read failure 
               
        f = 7:  report on general write failure


    Return:    none

    Operation: type IV, format 2 
                                                                     ***/ 

void fileerr4(long *loc, char *name, long k, long n, long f) 
{ 
    int    h; 
    --f; 
    f *= 5; 
    h = WERR25 + f; 
    errf4(h, 2, loc, name, k, n, 0L); 
    terminate_ww(); 
} 

/*** FUNCTION  void fileerr5(*loc, *name, k, n, x, f); 

    Purpose:   report on various specific failures in read/write attempts      

    Input:     long   *loc      location in program 
               char   *name     name of open file 
               long    k        descriptor number 
               long    n        type of access of open file 
               long    x        attempted byte offset 
               long    f        situation 

        f = 1:  report on attempt to read/write with a negative 
                  offset            
        f = 2:  report on attempt to read/write beyond the end 
                  of a fixed file  

    Return:    none

    Operation: type IV, format 3 
                                                                     ***/ 

void fileerr5(long *loc, char *name, long k, long n, long x, long f) 
{ 
    int    h; 
    --f; 
    f *= 6; 
    h = WERR32 + f; 
    errf4(h, 3, loc, name, k, n, x); 
    terminate_ww(); 
} 

/*** FUNCTION  void filewarn1(*loc, *name, k, n); 

    Purpose:   give warning that getf was not able to get an entire record 

    Input:     long   *loc      location in program 
               char   *name     name of open file 
               long    k        descriptor number 
               long    n        type of access of open file 

    Return:    yes 

    Operation: type IV, format 2 
                                                                     ***/ 

void filewarn1(long *loc, char *name, long k, long n) 
{ 
    errf4(WERR34, 1, loc, name, k, n, 0L); 
    return; 
} 

/*** FUNCTION  void filewarn2(*loc, *name, k); 

    Purpose:   give warning that an attempt was made to close a file      
                 which had not been opened or had already been closed 

    Input:     long   *loc      location in program 
               char   *name     name of file (if there is one) 
               long    k        descriptor number 

    Return:    yes 

    Operation: type IV, format 1 
                                                                     ***/ 

void filewarn2(long *loc, char *name, long k) 
{ 
    errf4(WERR35, 1, loc, name, k, 0L, 0L); 
    return; 
} 

/*** FUNCTION  long filewarn3(*loc, *name, k, f, linecode); 

    Purpose:   give warning that number of records put into a file  
                 exceeds the normal maximum 

    Input:     long   *loc      location in program 
               char   *name     name of file (if there is one) 
               long    k        descriptor number 
               long    f        situation 
                                f = 1:  give warning that number 
                                        of records exceeds 50000 
                                f = 2:  give warning that number 
                                        of bytes exceeds 5MB 

               long      linecode:  0 = line is waiting in ttyline 
                                    1 = use my_getline (free to spin) 
                                    2 = if my_getline, return (-1) and wait 

    Return:    long   -1 = wait for line to be entered 
                       0 = normal 
                       1 = change window or disconnect 
                       2 = terminate (!!) 

    Operation: type IV, format 1 
                                                                     ***/ 

long filewarn3(long *loc, char *name, long k, long f, long linecode) 
{ 
    extern char  ttyline[]; 
    extern zint_vars   ztv;  

    int          h; 
    long         g; 
                     
    if ((ztv.zoperationflag & 0x0200) != 0)  { 
        return (0); 
    }   

    --f; 
    f *= 5; 
    h = WERR36 + f; 
    errf4(h, 1, loc, name, k, 0, 0); 

    if (linecode == 2)   { 
        return (-1); 
    } 
    else  { 
        if (linecode == 1)   { 
            g = my_getline(ttyline, TTYZ); 
            if (g < 0)  { 
                return (0-g); 
            } 
        } 
    } 
    return (0); 
} 

/*** FUNCTION  void outwarn1(*loc); 

    Purpose:   give warning that output buffer size was exceeded; data 
                 was lost on output 

    Input:     long   *loc      location in program 

    Return:    yes 

    Operation: type II, format 1 
                                                                     ***/ 

void outwarn1(long *loc) 
{ 
    errf2(WERR38, 1, loc, NULL, 0L, 0L, 0L); 
} 

/*** FUNCTION  void procallerr(*loc); 

    Purpose:   report on maximum size of procedure level table exceeded 

    Input:     long   *loc      location in program 

    Return:    none 

    Operation: type II, format 1 
                                                                     ***/ 

void procallerr(long *loc) 
{ 
    errf2(WERR39, 1, loc, NULL, 0L, 0L, 0L); 
    terminate_ww(); 
} 

/*** FUNCTION  void mem_err(); 

    Purpose:   report on failure of memory allocation in table processing 
                 program 

    Input:     none 

    Return:    none 

    Operation: type I 
                                                                     ***/ 

void mem_err() 
{ 
    errf1(WERR40); 
} 

/*** FUNCTION  char *get_msg_string(int msg); 

    Purpose:   construct message string (null terminated) from message number               

    Input:     int    message number 

    Return:    char  *(pointer to message string) 

    Operation: type I 
                                                                     ***/ 

char *get_msg_string(int msg) 
{ 
    char         message[320]; 
    char         msgbuf[101]; 
    char        *ss, *sp1; 
    long         i, q, j; 
    long         ii; 

    static char rtmsg[201][90] = { 

"...", 
"001 057 Run-time error: attempt to divide by integer zero                              x",
"002 064 Run-time error: attempt to divide by floating point zero                       x",
"003 162 Run-time error: array subscript %ld of %s variable: %s                         x",
"    126   is out of bounds                                                             x",
"    044   subscript = %ld, upper limit = %ld                                           x",
"004 163 Run-time error: string subscript %ld of %s variable: %s                        x",
"    126   is out of bounds                                                             x",
"    047   subscript = %ld, current length = %ld                                        x",
"005 163 Warning: string subscript number %ld of %s variable: %s                        x",
"    126   is out of bounds                                                             x",
"    047   subscript = %ld, current length = %ld                                        x",
"006 157 Run-time error: maximum length of %s variable: %s                              x",
"    127   has been exceeded                                                            x",
"    054   attempted length = %ld, maximum length = %ld                                 x",
"007 150 Warning: maximum length of %s variable: %s                                     x",
"    127   has been exceeded                                                            x",
"    054   attempted length = %ld, maximum length = %ld                                 x",
"008 152 Run-time error: negative string length = %ld                                   x",
"    029   for %s variable: %s                                                          x",
"009 165 Warning: negative string length = %ld for %s variable: %s                      x",
"    019   (warning)                                                                    x",
"010 171 Run-time error: attempted sequential table access (tget) beyond                x",
"    025   last data group                                                              x",
"011 155 Run-time error: index to table is out-of-bounds                                x",
"    041   index = %ld, maximum size = %ld                                              x",
"012 162 Run-time error: table no longer efficient for hashing.                         x",
"    054   current table size = %ld, maximum size = %ld                                 x",
"013 148 Warning: argument to sin(x) (x = %le) is                                       x",
"    080   too large to produce an accurate result.  A value of zero is returned.       x",
"014 148 Warning: argument to cos(x) (x = %le) is                                       x",
"    080   too large to produce an accurate result.  A value of zero is returned.       x",
"015 148 Warning: argument to tan(x) (x = %le) is                                       x",
"    080   too large to produce an accurate result.  A value of zero is returned.       x",
"016 145 Warning: argument to ars(x) (x = %le)                                          x",
"    074   is out of range for this function.  A value of zero is returned.             x",
"017 145 Warning: argument to arc(x) (x = %le)                                          x",
"    074   is out of range for this function.  A value of zero is returned.             x",
"018 152 Warning: argument to exx(x) (x = %le) causes                                   x",
"    076   an overflow result.  A value of 10 to the 153rd power is returned.           x",
"019 145 Warning: argument to lnx(x) (x = %le)                                          x",
"    074   is out of range for this function.  A value of zero is returned.             x",
"020 145 Warning: argument to sqt(x) (x = %le)                                          x",
"    074   is out of range for this function.  A value of zero is returned.             x",
"021 186 Warning: length of insertion (%ld bytes) is not equal to the space (%ld bytes) x",
"    037   provided in %s variable: %s                                                  x",
"022 156 Run-time error: illegal file descriptor value                                  x",
"    057   descriptor = %ld, value must be between 1 and 9                              x",
"023 157 Run-time error: unsupported file access requested                              x",
"    086   requested access = %ld, supported access types are 1, 2, 3, 4, 5, 6, 7 and 8 x",
"024 180 Run-time I/O error: open statement references a file descriptor which is       x",
"    125   already in use.                                                              x",
"    126     File name:  %s                                                             x",
"    135     Descriptor number:  %ld                                                    x",
"    129     Access type:  %ld                                                          x",
"    023     (I/O error)                                                                x",
"025 168 Run-time I/O error: file open for use other than simple getf                   x",
"    126     File name:  %s                                                             x",
"    135     Descriptor number:  %ld                                                    x",
"    129     Access type:  %ld                                                          x",
"    023     (I/O error)                                                                x",
"026 168 Run-time I/O error: file open for use other than simple putf                   x",
"    126     File name:  %s                                                             x",
"    135     Descriptor number:  %ld                                                    x",
"    129     Access type:  %ld                                                          x",
"    023     (I/O error)                                                                x",
"027 157 Run-time I/O error: file not open for random read                              x",
"    126     File name:  %s                                                             x",
"    135     Descriptor number:  %ld                                                    x",
"    129     Access type:  %ld                                                          x",
"    023     (I/O error)                                                                x",
"028 158 Run-time I/O error: file not open for random write                             x",
"    126     File name:  %s                                                             x",
"    135     Descriptor number:  %ld                                                    x",
"    129     Access type:  %ld                                                          x",
"    023     (I/O error)                                                                x",
"029 163 Run-time I/O error: file not open for write instruction                        x",
"    126     File name:  %s                                                             x",
"    135     Descriptor number:  %ld                                                    x",
"    129     Access type:  %ld                                                          x",
"    023     (I/O error)                                                                x",
"030 148 Run-time I/O error: general read failure                                       x",
"    126     File name:  %s                                                             x",
"    135     Descriptor number:  %ld                                                    x",
"    129     Access type:  %ld                                                          x",
"    023     (I/O error)                                                                x",
"031 149 Run-time I/O error: general write failure                                      x",
"    126     File name:  %s                                                             x",
"    135     Descriptor number:  %ld                                                    x",
"    129     Access type:  %ld                                                          x",
"    023     (I/O error)                                                                x",
"032 172 Run-time I/O error: attempt to read/write with a negative offset               x",
"    126     File name:  %s                                                             x",
"    135     Descriptor number:  %ld                                                    x",
"    129     Access type:  %ld                                                          x",
"    139     Attempted byte offset:  %ld                                                x",
"    023     (I/O error)                                                                x",
"033 168 Run-time I/O error: attempt to read/write beyond end of file                   x",
"    126     File name:  %s                                                             x",
"    135     Descriptor number:  %ld                                                    x",
"    129     Access type:  %ld                                                          x",
"    139     Attempted byte offset:  %ld                                                x",
"    023     (I/O error)                                                                x",
"034 165 I/O Warning: file record is larger than getf input buffer                      x",
"    126     File name:  %s                                                             x",
"    135     Descriptor number:  %ld                                                    x",
"    129     Access type:  %ld                                                          x",
"    023     (I/O error)                                                                x",
"035 174 I/O Warning: attempt to close a file which has already been closed             x",
"    129   or was never opened                                                          x",
"    126     File name:  %s                                                             x",
"    135     Descriptor number:  %ld                                                    x",
"    023     (I/O error)                                                                x",
"036 169 I/O Warning: attempt to put more than 100,000 records in a file                x",
"    126     File name:  %s                                                             x",
"    135     Descriptor number:  %ld                                                    x",
"    023     (I/O error)                                                                x",
"    056 enter \"!!\" to stop program;  <return> = continue                               x",
"037 169 I/O Warning: attempt to write more than 6 Megabytes to a file                  x",
"    126     File name:  %s                                                             x",
"    135     Descriptor number:  %ld                                                    x",
"    023     (I/O error)                                                                x",
"    056 enter \"!!\" to stop program;  <return> = continue                               x",
"038 165 Warning: output buffer size exceeded; data long on output                      x",
"    019   (Warning)                                                                    x",
"039 177 Run-time error: maximum size of procedure level table has been exceed          x",
"    038   (too many nested procedures)                                                 x",
"040 078 Run-time error: table has expanded beyond the size of available memory         x",
"041 040 Size of links memory = %ld bytes                                               x",
"042 055 Not enough free memory available to run program                                x",
"043 041 Size of i-code memory = %ld bytes                                              x",
"044 039 Size of main memory = %ld bytes                                                x",
"045 048 Memory for first table block = %ld bytes                                       x",
"046 051 Not enough free memory available for tables                                    x",
"047 050 Size of symbol table (on disc) = %ld bytes                                     x",
"048 058 Size of procedure name table (on disc) = %ld bytes                             x",
"049 055 Size of source file index (on disc) = %ld bytes                                x",
"050 053 Size of max string storage memory = %ld bytes                                  x",
"051 076 Unable to run program.  Printer is busy or is otherwise unavailable.           x",
"052 071 Unable to run program.  Printer in use by another zbex program.                x",
"053 068 Invalid intermediate file format; possibly an older version.                   x",
"054 063 Limited memory; try decreasing length of longest string                        x",
"055 038 Unable to open source file: %s                                                 x",
"056 046 Goto undefined label; program aborted.                                         x",
"057 072 Unable to run program.  Graphics in use by another zbex program.               x",
"058 158 Run-time error: computed length of %s variable: %s                             x",
"    147   exceeds the maximum available length.                                        x",
"    053   computed length = %ld, maximum length = %ld                                  x",
"059 165 Run-time error: dynamic array parameters are out of range                      x",
"    043   product of three parameters = %ld                                            x",
"060 156 Run-time error: bitplane number is out-of-bounds                               x",
"    074   bitplane number = %ld, number of planes in string variable = %ld             x",
"061 176 Run-time error: maximum length of temporary string variable has been           x",
"    144   exceeded while constructing %s: %s                                           x",
"    154   attempted length = %ld, maximum length = %ld                                 x",
"    075   Increase maximum length of temporary string variable in init file            x",
"062 068 Unable to run program.  Midi in use by another zbex program.                   x",
"063 167 Unable to contact the Music Quest Interface Card.  Possible                    x",
"    027   misconfiguration.                                                            x",
"064 066 Unable to run program.  Midi not installed on this system.                     x",
"065 163 Unable to open the midi interface.  Check to see if the                        x",
"    073   midi interface is connected.  Wait 10 seconds after connecting.              x",
"066 157 Unable to execute instruction because midi is not                              x",
"    029   open at this point.                                                          x",
"067 173 There is a problem with the midi interface.  The midiopen failed.              x",
"    022   (Midi error)                                                                 x",
"068 174 Warning: MCC Command %s not inplemented in TENW.  No action taken.             x",
"    019   (Warning)                                                                    x",
"069 164 Warning: first argument to midipar = %d is out of range.                       x",
"    040   Acceptable values are 0 to 16.                                               x",
"070 165 Warning: second argument to midipar = %d is out of range.                      x",
"    033   Value must be positive.                                                      x",
"071 161 Warning: initial value of loop counter is set outside                          x",
"    022   loop limits.                                                                 x",
"072 052 Run-time error: sort size exceeds array size                                   x",
"073 060 Run-time limitation: not enough free memory for sort                           x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
"                                                                                       x",
};                         

    sp1 = message; 
    ii = msg; 

    message[0] = '\0'; 
    q = 1; 
    j = 0; 

    while (q) { 
        strcpy(msgbuf, rtmsg[ii]); 
        ++ii;   
        ss = read_digits(msgbuf+4, 3, &i); 

        q = i / 100; 
        i = i % 100; 
        msgbuf[i++] = '\n'; 
        msgbuf[i] = '\0'; 

        strcat(message, msgbuf+8); 
    } 
    return (sp1); 
} 

/*** FUNCTION  char *get_source_line(*loc, *n); 

    Purpose:   Get the line number and a pointer to the line which generated 
                 the i-code instruction at loc.  

    Input:     long *loc    location in i-code        

    Output:    long *n      line number which generated instruction 

    Return:    char *       pointer to source line, or to null string 

                                                                 ***/ 

char *get_source_line(long *loc, long *n) 
{ 
    extern zint_vars   ztv; 

    char         sourceline[LZ]; 
    long         linenum, linepnt; 
    char        *sp1; 

    sourceline[0] = '\0'; 
    linenum = 0;
    linepnt = 0;

    *n = linenum; 
    sp1 = sourceline; 
    return (sp1); 
} 

/*** FUNCTION  void get_varstat(*loc, *(*vname), *(*vtype)); 

    Purpose:   Get variable name and type from link location number 

    Input:     long *loc       pointer to variable in link memory 

    Output:    char *(*vname)  pointer to variable name 
               char *(*vtype)  pointer to type 

    Return:    void

    Operation: The offset address for the variable in the symbol table is 
               at link location (n-1).  The desired information can be 
               found in the symbol table.  

                 Structure of symbol table record: 

           byte      (x) bytes     3-bytes     byte   byte  2-bytes 
        旼컴컴컴컫컴컴컴컴컴컴컴쩡컴컴컴컴컴컫컴컴컴쩡컴컴컫컴컴컴커 
        � length � ** symbol ** 쿹ink address� dim  � code � trace � 
        읕컴컴컴컨컴컴컴컴컴컴컴좔컴컴컴컴컴컨컴컴컴좔컴컴컨컴컴컴켸 

    type of data:  symbol name, variable id number, type of variable and 
                     number of dimensions 

        There are two ways a variable may be referenced: by symbol name, 
        and by address in link memory.  At run time, we will want to get 
        quickly from one reference type to another.  The circular path for 
        doing this is shown below.  

        Symbol name --> (symbol table) --> Link address (offset) 
        Link address --> (variable tag) --> Address in symbol table 

                                                                 ***/ 

void get_varstat(long *loc, char *(*vname), char *(*vtype)) 
{ 
    static char   symbol_name[70] = {""}; 
    static char   symbol_type[6] = {""};

    *vname = symbol_name; 
    *vtype = symbol_type; 
} 

/*** FUNCTION  void msgf0(n); 

    Purpose:   Process message with no parameters    

    Input:     int   n      message number            

    Output:    none     

    Return:    void         
                                                                        ***/ 

void msgf0(int n)
{ 
    char  *ss; 

    ss = get_msg_string(n); 
    alt_send_twline(ss, -1); 
    return; 
} 

/*** FUNCTION  void msgf1(n, k); 

    Purpose:   Process message with one (long) integer parameter 

    Input:     int   n      message number            
               long  k      integer paramter 

    Output:    none     

    Return:    void         
                                                                        ***/ 

void msgf1(int n, long k) 
{ 
    extern char     ttyline[]; 

    char  *ss; 

    ss = get_msg_string(n); 
    sprintf(ttyline, ss, k); 
    alt_send_twline(ttyline, -1); 
    return; 
} 

/*** FUNCTION  void errf1(n); 

    Purpose:   Process error message in type I format 

    Input:     int   n      error number              

    Output:    none     

    Return:    terminate  
                                                                        ***/ 

void errf1(int n) 
{ 
    msgf0(n); 
    terminate_ww(); 
} 

/*** FUNCTION  void errf2(n, format, *loc, *var, v1, v2, v3); 

    Purpose:   Process error message in type II format 

    Input:     int   n        error number 
               int   format   print format: 

                          1    line# 
                          2    line#, val1 
                          3    line#, val1, val2 
                          4    vtype, vname, line#, val1, val2 
                          5    val1, vtype, vname, line# 
                          6    val1, vtype, vname, line#, val2, val3 
                          7    val1, val2, vtype, vname, line# 

               long *loc      approximate IPC value where error occured    
               long *var      pointer to variable in link memory 
               long  v1       integer parameter 
               long  v2       integer parameter 
               long  v3       integer parameter 

    Output:    none     

    Return:    yes          
                                                                        ***/ 

void errf2(int n, int format, long *loc, long *var, 
    long v1, long v2, long v3) 
{ 
    extern char     ttyline[]; 

    char   *fs;              /* format string, for printing */ 
    char   *vname;           /* pointer to variable name    */ 
    char   *vtype;           /* pointer to variable type    */ 
    char   *source_line;     /* pointer to source line      */ 
    char    dummy[100];

    long    line_num;        /* source line number */ 

/* (1) get parameters as needed: format string, line number, source line 
                                            variable name and type       */ 
    vname = dummy;
    vtype = dummy;
    line_num = 0;
    fs = get_msg_string(n);                        /* get format string     */

    source_line = get_source_line(loc, &line_num); /* get pointer to source  
                                                   line and get line number */ 
    if (format > 3) { 
        get_varstat(var, &vname, &vtype);          /* var name and type     */ 
    } 

/* (2) print error message */ 

    switch (format) { 
        case 1: 
            sprintf(ttyline, fs); 
            break; 
        case 2: 
            sprintf(ttyline, fs, v1); 
            break; 
        case 3: 
            sprintf(ttyline, fs, v1, v2); 
            break; 
        case 4: 
            sprintf(ttyline, fs, vtype, vname, v1, v2); 
            break; 
        case 5: 
            sprintf(ttyline, fs, v1, vtype, vname); 
            break; 
        case 6: 
            sprintf(ttyline, fs, v1, vtype, vname, v2, v3); 
            break; 
        case 7: 
            sprintf(ttyline, fs, v1, v2, vtype, vname); 
            break; 
    } 

    alt_send_twline(ttyline, -1); 

} 

/*** FUNCTION  void errf3(n, *loc, x); 

    Purpose:   Process error message in type III format 

    Input:     int    n        error number 
               long  *loc      approximate IPC value where error occured    
               double x        floating point value 

    Output:    none     

    Return:    yes          
                                                                        ***/ 

void errf3(int n, long *loc, double x) 
{ 
    extern char     ttyline[]; 

    char   *fs;              /* format string, for printing */ 
    char   *source_line;     /* pointer to source line      */ 

    long    line_num;        /* source line number */ 

/* (1) get parameters as needed: format string, line number, source line 
                                            variable name and type       */ 

    line_num = 0;
    fs = get_msg_string(n);                        /* get format string     */

    source_line = get_source_line(loc, &line_num); /* get pointer to source  
                                                   line and get line number */ 

/* (2) print error message */ 

    sprintf(ttyline, fs, x, line_num); 
    alt_send_twline(ttyline, -1); 

} 

/*** FUNCTION  void errf4(n, format, *loc, *fname, v1, v2, v3); 

    Purpose:   Process error message in type II format 

    Input:     int   n        error number 
               int   format   print format: 

                          0    fname, line# 
                          1    fname, val1, line# 
                          2    fname, val1, val2, line# 
                          3    fname, val1, val2, val3, line# 

               long *loc      approximate IPC value where error occured    
               long *fname    file name
               long  v1       integer parameter 
               long  v2       integer parameter 
               long  v3       integer parameter 

    Output:    none     

    Return:    yes          
                                                                        ***/ 

void errf4(int n, int format, long *loc, char *fname, 
    long v1, long v2, long v3) 
{ 
    extern char     ttyline[]; 

    char   *fs;              /* format string, for printing */ 
    char   *source_line;     /* pointer to source line      */ 

    long    line_num;        /* source line number */ 

/* (1) get parameters as needed: format string, line number, source line 
                                            variable name and type       */ 

    line_num = 0;
    fs = get_msg_string(n);                        /* get format string     */

    source_line = get_source_line(loc, &line_num); /* get pointer to source  
                                                   line and get line number */ 

/* (2) print error message */ 

    switch (format) { 
        case 0: 
            sprintf(ttyline, fs, fname, line_num); 
            break; 
        case 1: 
            sprintf(ttyline, fs, fname, v1, line_num); 
            break; 
        case 2: 
            sprintf(ttyline, fs, fname, v1, v2, line_num); 
            break; 
        case 3: 
            sprintf(ttyline, fs, fname, v1, v2, v3, line_num); 
            break; 
    } 
    alt_send_twline(ttyline, -1); 

} 
