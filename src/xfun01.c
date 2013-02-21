/***                         DMUSE PROGRAM 
                           LINUX version 0.02 
            (c) Copyright 1992, 1999, 2007 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 03/28/2007) 
                            (rev. 12/27/2009) 

                      Functions Accessing Disk Swap Memroy 
                                                                        ***/ 
#include  "all.h" 

/*** FUNCTION   void my_delay(long n):

      Purpose:  Delay <n> seconds.

      Input:    long  n   number of tenths of seconds to delay

      Return    void

      Implicit variables changed?  (none)

                                                              ***/
void my_delay(long n)
{
    long  a,b,c; 
    a = n / 10; 
    b = a * 10; 
    c = n - b; 
    c *= 100000; 
    if (a > 0)  sleep(a); 
    if (c > 0)  usleep(c); 
    return;
}
