/***                         DMUSE PROGRAM 
                           LINUX version 0.00 
            (c) Copyright 1992, 1999, 2007 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 09/19/2007) 
                            (rev. 12/27/2009) 

             Z Compiler: Utility and space saving functions 
                                                                        ***/ 
#include  "all.h" 

/*** FUNCTION  char *read_digits(sp1, n, *v); 

    Purpose:   Read <n> digits from string pointed to by sp1.  Return 
                 integer value in *v

    Input:     char *sp1    pointer to byte
               long  n      number of digits to read

    Output:    long *v      integer value of number read

    Return:    char *       updated pointer  (sp1 + n)
                                                                 ***/ 

char *read_digits(char *sp1, long n, long *v) 
{ 
    long    i, j;

    for (i = 0, j = 0; i < n; ++i)  { 
        j *= 10; 
        j += *sp1; 
        j -= '0'; 
        ++sp1; 
    }
    *v = j;
    return (sp1);
} 

/*** FUNCTION  char *construct_digits(sp1, len, n); 

    Purpose:   Construct a string of digits of length <len> with decimal 
                 value of <n> 

    Input:     char *sp1    pointer to output string 
               long  len    number of digits to construct
               long  n      decimal value of digits

    Return:    pointer beyond last digit constructed 


                                                                 ***/ 

char *construct_digits(char *sp1, long len, long n) 
{ 
    long   i;
    char  *ss; 

    for (ss = sp1 + len - 1, i = 0; i < len; ++i)  {
        *ss-- = n % 10 + '0'; 
        n /= 10; 
    } 
    return (sp1 + len);
} 

/*** FUNCTION   char case_convert(c, mode); 

    Purpose:   convert character to upper or lower case 

    Input:     unsigned char   c       character to convert 
               long            mode    0 = convert to lower case
                                       1 = convert to upper case 

    return:    unsigned char   converted character 

    Operation: routine converts not only stardard ASCII alpha characters 
               but also alpha characters with accents.  The WBH extensions 
               to the IBM extended ASCII characters are used.  

                                                                 ***/ 
unsigned char case_convert(unsigned char c, long  mode) 
{ 
    static unsigned char ctable0[] =              /* convert to lower */ 
       {135, 129, 130, 131, 132, 133, 134, 135, 
        136, 137, 138, 139, 140, 141, 132, 134, 
        130, 145, 145, 147, 148, 149, 150, 151, 
        152, 148, 129, 155, 156, 157, 158, 159, 
        160, 161, 162, 163, 164, 164, 166, 167, 
        168, 169, 170, 171, 172, 173, 174, 175, 
        176, 177, 178, 179, 180, 181, 182, 183, 
        184, 185, 186, 187, 188, 189, 190, 191, 
        192, 193, 194, 195, 196, 197, 198, 199, 
        200, 201, 202, 203, 204, 205, 206, 207, 
        208, 209, 210, 211, 212, 213, 214, 215, 
        216, 217, 218, 219, 220, 221, 222, 223, 
        131, 133, 160, 136, 137, 138, 140, 141, 
        161, 139, 147, 149, 162, 150, 151, 163, 
        152, 241, 241, 243, 243, 245, 245, 247, 
        249, 249, 250, 251, 251, 253, 254, 255}; 

    static unsigned char ctable1[] =              /* convert to upper */ 
       {128, 154, 144, 224, 142, 225, 143, 128, 
        227, 228, 229, 233, 230, 231, 142, 143, 
        144, 146, 146, 234, 153, 235, 237, 238, 
        240, 153, 154, 155, 156, 157, 158, 159, 
        226, 232, 236, 239, 165, 165, 166, 167, 
        168, 169, 170, 171, 172, 173, 174, 175, 
        176, 177, 178, 179, 180, 181, 182, 183, 
        184, 185, 186, 187, 188, 189, 190, 191, 
        192, 193, 194, 195, 196, 197, 198, 199, 
        200, 201, 202, 203, 204, 205, 206, 207, 
        208, 209, 210, 211, 212, 213, 214, 215, 
        216, 217, 218, 219, 220, 221, 222, 223, 
        224, 225, 226, 227, 228, 229, 230, 231, 
        232, 233, 234, 235, 236, 237, 238, 239, 
        240, 240, 242, 244, 244, 246, 246, 247, 
        248, 248, 250, 252, 252, 253, 254, 255}; 

    unsigned char a; 

    if (mode == 0)  { 
        if (c < 128)  { 
            if (c >= 'A' && c <= 'Z')  { 
                a = c + 32; 
            } 
            else a = c; 
        } 
        else { 
            c -= 128; 
            a = ctable0[c]; 
        } 
    } 
    else { 
        if (c < 128)  { 
            if (c >= 'a' && c <= 'z')  { 
                a = c - 32; 
            } 
            else a = c; 
        } 
        else { 
            c -= 128; 
            a = ctable1[c]; 
        } 
    } 
    return (a); 
} 
