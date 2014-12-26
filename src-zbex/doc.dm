
         Documentation for constructing the muse2ps program 
       ------------------------------------------------------ 

&dEI. Prologue&d@ 

So I hate to say it, but there seems to be very little documentation on 
how to construct the muse2ps command-line program.  Searching through 
the diary, I see that we implemented three &dCnew&d@ zbex instructions as part 
of the development process: getC, getd, and pute.  These instructions are 
fully documented in the &dChelp&d@ file.  

  1) &dCpute&d@   In Dmuse, pute is the same as putc; but in the terminal
     environment, pute sends output not to stdout but to stderr.  
     This distinction is necessary, because in the terminal environment, 
     stdout is redirected to an output file.  And we don't want error 
     messages going into that file.  

  2) &dCgetd&d@   This gets a time stamp string from Linux.  Handy and consistant.

  3) &dCgetC&d@   This instruction gets the &dClast entered value&d@ of the -c 
     command_line variable.  For example, try this program: 

zz 
Current Library is j:/release/internet/linux/muse2ps.dir/workfiles 
Program file?  

Input program from terminal.  
     str line.80 
     getC line 
     putc ~line 
     run 
** S=4, P=10, L=240, M=431 ** 
=z18fj 
Ready for program 

     The last entered command-line option was apparently '=z18fj' 

     Now try the program, using the command: zz -c'Hello World' 

zz -c'Hello World' 
Current Library is j:/release/internet/linux/muse2ps.dir/workfiles 
Program file?  

Input program from terminal.  
     str line.80 
     getC line 
     putc ~line 
     run 
** S=4, P=10, L=240, M=431 ** 
Hello World 
Ready for program 

&dEII.  The compile process for muse2ps&d@ 

1) get au-ms-ps in the form you want.  

   Library: j:/release/internet/linux/muse2ps/workfiles 

   To to this, you need to get the program running.  Verify that 
   it does the right thing.  Then make the modifications you 
   want, and check it again.  You are not done, yet.  You then 
   need to make the modifications in the procedures (this makes 
   it permanent), and run the makefile program.  Re-load 
   au-ms-ps to verify that the changes were made.  

   My technique for doing this is to make changes in au-ms-ps 
   and put the result in save.tmp   Then I run the makefile.z 
   program to construct reconstruct the old au-ms-ps.  I run 
   the &dCdiff&d@ program on these two, and then progressively 
   remove differences by updating the various procedure 
   files, and going through the process again.  
                  
2) The au-ms-ps program compiles to the Dmuse environment 
   version.  To get it ready for muse2ps, you need to change 
   the DMUSE define value to "0"   &dEImportant&d@.  

3) run zcmp to get the .w form of au-ms-ps 

4) run bytecomp.z on au-ms-ps.w --> temp1 

5) run dictcomp.z on temp1 --> small 

6) run tostring.z on small --> screen output 

7) Now switch to the c:/home/wbh/develop/m2ps library 

8) The file to fix here is zfun32.c   In addition to copying 
   the large string from (5), you will need insert the size 
   number in two places:  1) in the memcpy instruction at 
   the end, and 2) where the "size" variable is set (approx.  
   line 175).  

9) Now you are ready to compile the executable muse2ps program.  
   Do this by running "make".  

10) The command for running the program looks like this: 

    cat <source file> | ./muse2ps '=<command options>' > <output file> 

11) The command for viewing the output is this: 

    gs -sDEVICE=x11 -r100 <output file> 

    The -r option is for resolution.  
