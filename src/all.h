/***                         DMUSE PROGRAM 
                           LINUX version 1.00 
            (c) Copyright 1992, 1999, 2007 by Walter B. Hewlett 
                           all rights reserved 
                            (rev. 03/18/2007) 
                            (rev. 12/27/2009) 

                           Top of Include list 
                                                                  ***/

/*  X include files  */

// #include  <X11/Xlib.h>
// #include  <X11/Xutil.h>

/*** global includes ***/ 

/* 

&dA#include  <stk.h>         &d@       
&dA#include  <i32.h>         
&dA#include  <conio.h>       
&dA#include  <direct.h>      
&dA#include  <dos.h>         
&dA#include  <graph.h>       
&dA#include  <io.h>          
&dA#include  <process.h>     

#include  <ec.h>

*/ 

// #include  <alsa/asoundlib.h> 

#include  <unistd.h> 
#include  <string.h>      
#include  <sys/stat.h>
#include  <sys/types.h> 
#include  <sys/time.h>

#ifndef MINGW
   #include  <sys/wait.h> 
#endif
#ifdef MINGW
   #include <windows.h>
   #define sleep(x) Sleep(x)
   #undef TEXT
#endif

#include  <time.h>        
#include  <limits.h> 
#include  <stdio.h>       
#include  <stdarg.h> 
#include  <stdlib.h>      
#include  <stddef.h>
#include  <ctype.h>       
#include  <errno.h>       
#include  <fcntl.h>       
#include  <assert.h>  
#include  <signal.h>      
#include  <float.h> 
#include  <math.h>        
#include  <setjmp.h>      
#include  <memory.h>      

#ifdef APPLEMAC
   #include  <sys/malloc.h>
#else
   #include <malloc.h>
#endif

/*** application includes ***/ 

#include  "bboard.h" 
#include  "zdef.h" 
#include  "ddef.h" 

/*** version includes ***/ 

#include  "version.h" 
#include  "musprint.h" 
