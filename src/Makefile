## Makefile for compiling the muse2ps program which is a command-line program
## that converts MuseData stage 2 file or music page files into PostScript 
## files of graphical music notation.  The muse2ps program is a stripped-down
## version of the dmuse program (http://dmuse.ccarh.org> with a non-intractive
## version of zbex programs for typeseting music within dmuse.
##
## The muse2ps program has been compiled using this makefile and tested 
## on these operating systems:
##   * Linux
##   * Apple OS X (10.4 and higher)
##   * Windows 7, Windows XP compiled natively with MinGW (http://www.mingw.org)
##   * Windows, using cygwin (http://www.cygwin.com)
## 
## Creation Date: Thu Dec 16 23:48:27 PST 2010
## Last Modified: Mon Dec 20 08:01:10 PST 2010
## Filename:      ...muse2ps/Makefile
## 
## Instructions:  To compile the muse2ps executable type:
##			make
##		  This will compile all *.c files in the directory
##		  to create the muse2ps program.
##
##		  To tidy up the files in this directory, type:
##		        make clean
##		  This will remove all of the *.o files.  To also delete
##                the compiled executable file, then type:
##			make superclean
##

# PROG is the name of the executable program to compile.
PROG = muse2ps

# TARGETDIR specifies where the location of the dmuse executable should
# be copied after the program has been compiled. (used in "make install")
TARGETDIR = ../../bin

# One object file is to be created for each .c file in the directory:
# x*.c   = X-windows program files.
# z*.c   = Zbex interpreter program files.
# d*.c   = Display program files (Not present in muse2ps code)
# main.c = contains main() function for dmuse program.
OBJS = $(notdir $(patsubst %.c,%.o,$(wildcard *.c)))

# -m32:  dmuse must use a 32-bit archtecture.
# -Wall: generate a very detailed list of compiler warnings.
CFLAGS = -Wall -m32

# Automatic identification of the OS architecture.  If the command:
#     uname
# Returns "Darwin", then the computer is an Apple OS X computer;
# otherwise, the computer will be assumed to be a linux computer.
# The APPLEMAC preprocessor variable should be defined when compiling
# on an Apple OS X computer; otherwise, it should remain undefined.

LIBS = -lm
# Add the --static option for more portable compiled program.  For static 
# compiling using libm.a, you might need to run this linux command as root:
#    yum install glibc-static
#LIBS += --static
ENV  =

ifeq ($(shell uname),Darwin)
   ENV = MACOSX_DEPLOYMENT_TARGET=10.4
   CFLAGS += -DAPPLEMAC
endif

# EXT is the executable's extension (usually blank except for Windows)
EXT    =
PFLAGS = 
ifneq ($(shell uname),Darwin)
   ifeq ($(shell uname -o),Cygwin)
      EXT = .exe
      # In Cygwin, the program will exit with a "Segmentation fault" error
      # if the stack memory is not increased (due to the large variable in
      # the stack in the load_big() function in zfun32.c):
      PFLAGS += -Wl,--stack,32123123
   endif
endif

COMPILER = $(ENV) gcc

# MinGW (Minimal GNU for Windows) settings for compiling for Microsoft 
# Windows.  The program compiles and runs in Windows, but has a stack 
# overflow error (0xc00000fd), presumably from zfun32.c's load_big() 
# function.  Add the gcc option "-Wl,--stack,32123123" to increase the
# stack memory allocation.  With the increased stack memory, the program
# runs properly without a stack overflow error.
#COMPILER = i686-pc-mingw32-gcc
#LIBS     =
#CFLAGS   = -Wall -m32 -DMINGW 
#PFLAGS   = -Wl,--stack,32123123
#EXT      = .exe

.PHONY: $(PROG)$(EXT) tests

##########################################################################
##
## Targets
##

# The default target (because it is specified first): compile dmuse and 
# then copy the executable into the bin directory.
all: $(PROG)$(EXT)

# Create the executable:
$(PROG)$(EXT): $(OBJS)
	-rm $(PROG)$(EXT)
	$(COMPILER) $(CFLAGS) $(PFLAGS) -o $(PROG)$(EXT) \
              $(OBJS)  $(LIBS) &&  strip $(PROG)$(EXT) 

# Type "make install" to copy the program to the main bin directory.
install:
	@if test -d $(TARGETDIR); \
	  then cp $(PROG)$(EXT) $(TARGETDIR); \
	  echo "Copying $(PROG)$(EXT) executable to $(TARGETDIR)"; \
	  else echo "Not installing $(PROG)$(EXT) in $(TARGETDIR) since directory does not exist"; \
	fi

# Type "make clean" to erase all .o files.
clean:
	-rm -f *.o

# Type "make superclean" to erase all .o files and main executable program
superclean: clean
	-rm -f $(PROG)$(EXT)
	-(cd tests; $(MAKE) clean)

# Create PostScript files using the compiled program:
test: tests
tests: 
	(cd tests; $(MAKE))


# Do not optimize the compilation of xfun11.c [Explain why here].
xfun11.o: xfun11.c 
	$(COMPILER) $(CFLAGS) -O0 -c xfun11.c 

# Default compiling target: how to compile a .o file from a .c file
# if no explicit rule is given.  -O3 option means turn on compiler 
# optimizations (Levels 1 through 3):
%.o: %.c
	$(COMPILER) $(CFLAGS) -O3 -c $<


##########################################################################
##
## File Dependencies
##
## The following list was created with the following command in the bash shell:
##    for i in *.c; do cc -MM $i; echo ""; done
##
## If you are using a csh shell (such as tcsh), the syntax would be:
##    foreach i (*.c); cc -MM $i; echo ""; end
##
## If the file dependencies change significantly, you should run the above
## command and replace the contents below this line with the new dependencies.
##

main.o: main.c all.h bboard.h tw_flist.h zdef.h zconst1.h zconst2.h \
 zconst3.h zconst4.h zconst5.h z_flist.h ddef.h d_flist.h version.h \
 musprint.h

xfun01.o: xfun01.c all.h bboard.h tw_flist.h zdef.h zconst1.h zconst2.h \
 zconst3.h zconst4.h zconst5.h z_flist.h ddef.h d_flist.h version.h \
 musprint.h

xfun07.o: xfun07.c all.h bboard.h tw_flist.h zdef.h zconst1.h zconst2.h \
 zconst3.h zconst4.h zconst5.h z_flist.h ddef.h d_flist.h version.h \
 musprint.h

xfun09.o: xfun09.c all.h bboard.h tw_flist.h zdef.h zconst1.h zconst2.h \
 zconst3.h zconst4.h zconst5.h z_flist.h ddef.h d_flist.h version.h \
 musprint.h

xfun11.o: xfun11.c all.h bboard.h tw_flist.h zdef.h zconst1.h zconst2.h \
 zconst3.h zconst4.h zconst5.h z_flist.h ddef.h d_flist.h version.h \
 musprint.h

xfun12.o: xfun12.c all.h bboard.h tw_flist.h zdef.h zconst1.h zconst2.h \
 zconst3.h zconst4.h zconst5.h z_flist.h ddef.h d_flist.h version.h \
 musprint.h

zfun01.o: zfun01.c all.h bboard.h tw_flist.h zdef.h zconst1.h zconst2.h \
 zconst3.h zconst4.h zconst5.h z_flist.h ddef.h d_flist.h version.h \
 musprint.h

zfun21.o: zfun21.c all.h bboard.h tw_flist.h zdef.h zconst1.h zconst2.h \
 zconst3.h zconst4.h zconst5.h z_flist.h ddef.h d_flist.h version.h \
 musprint.h

zfun22.o: zfun22.c all.h bboard.h tw_flist.h zdef.h zconst1.h zconst2.h \
 zconst3.h zconst4.h zconst5.h z_flist.h ddef.h d_flist.h version.h \
 musprint.h

zfun23.o: zfun23.c all.h bboard.h tw_flist.h zdef.h zconst1.h zconst2.h \
 zconst3.h zconst4.h zconst5.h z_flist.h ddef.h d_flist.h version.h \
 musprint.h

zfun24.o: zfun24.c all.h bboard.h tw_flist.h zdef.h zconst1.h zconst2.h \
 zconst3.h zconst4.h zconst5.h z_flist.h ddef.h d_flist.h version.h \
 musprint.h

zfun25.o: zfun25.c all.h bboard.h tw_flist.h zdef.h zconst1.h zconst2.h \
 zconst3.h zconst4.h zconst5.h z_flist.h ddef.h d_flist.h version.h \
 musprint.h

zfun26.o: zfun26.c all.h bboard.h tw_flist.h zdef.h zconst1.h zconst2.h \
 zconst3.h zconst4.h zconst5.h z_flist.h ddef.h d_flist.h version.h \
 musprint.h

zfun27.o: zfun27.c all.h bboard.h tw_flist.h zdef.h zconst1.h zconst2.h \
 zconst3.h zconst4.h zconst5.h z_flist.h ddef.h d_flist.h version.h \
 musprint.h

zfun28.o: zfun28.c all.h bboard.h tw_flist.h zdef.h zconst1.h zconst2.h \
 zconst3.h zconst4.h zconst5.h z_flist.h ddef.h d_flist.h version.h \
 musprint.h

zfun29.o: zfun29.c all.h bboard.h tw_flist.h zdef.h zconst1.h zconst2.h \
 zconst3.h zconst4.h zconst5.h z_flist.h ddef.h d_flist.h version.h \
 musprint.h

zfun31.o: zfun31.c all.h bboard.h tw_flist.h zdef.h zconst1.h zconst2.h \
 zconst3.h zconst4.h zconst5.h z_flist.h ddef.h d_flist.h version.h \
 musprint.h

zfun32.o: zfun32.c all.h bboard.h tw_flist.h zdef.h zconst1.h zconst2.h \
 zconst3.h zconst4.h zconst5.h z_flist.h ddef.h d_flist.h version.h \
 musprint.h

zutil.o: zutil.c all.h bboard.h tw_flist.h zdef.h zconst1.h zconst2.h \
 zconst3.h zconst4.h zconst5.h z_flist.h ddef.h d_flist.h version.h \
 musprint.h

