##
## GNU Makefile for compiling muse2ps, which is a command-line program
## program that converts MuseData Stage 2 file or Music Page Files (MPG files) 
## into PostScript files of graphical music notation.  
## 
## The muse2ps program is a command-line version of au-ms-ps.z which
## is a Z-bex program run interactively in the dmuse environment:
##    http://dmuse.ccarh.org
##
## Pre-compiled versions of the program can be found in the bin directory.
##
## To compile muse2ps, type:
##	make
## The compiled program will be create in src/muse2ps and copied to ./muse2ps.
## Place this in a directory in your command path to use, such as 
## /usr/local/bin.  Type "make install" if you are root, or "su make install"
## to copy ./muse2ps to /usr/local/bin.
##
## To remove intermediate object files, type:
##	make clean    
## To remove all *.o files used to compile the program as well as the
## compiled program itself, type:
##      make superclean
##

# Determine if an extension is needed (.exe for Cygiwn or nothing if regular
# unix environment).
EXT = 
ifneq ($(shell uname),Darwin)
   ifeq ($(shell uname -o),Cygwin)
      EXT = .exe
   endif
endif

all:
	@echo Compling executable: muse2ps$(EXT)
	-(cd src; $(MAKE) ; cp muse2ps$(EXT) ../)
	@echo Executable created: ./muse2ps$(EXT)

clean:
	(cd src; $(MAKE) clean)

superclean:
	(cd src; $(MAKE) superclean)
	-rm muse2ps$(EXT)

