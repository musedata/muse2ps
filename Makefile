##
## GNU Makefile for compiling muse2ps.
##
## The muse2ps program converts MuseData Stage 2 files or Music Page files 
## (MPG files) into PostScript files of graphical music notation.
##
## muse2ps is a command-line batch-processing version of au-ms-ps.z, which
## is a Z-bex program that runs interactively in the dmuse environment:
##	http://dmuse.ccarh.org
##
## Pre-compiled versions of the program can be found in the bin directory
## for linux, Apple OS X, and Microsoft Windows.
##
## To compile muse2ps, type:
##	make
## The compiled program will be created in src/muse2ps and copied to ./muse2ps.
##
## muse2ps is compiled as a 32-bit binary.  You must have 32-bit libraries
## installed in order to compile.  If you need 32-bit compiling libraries,
## try installing with one of these commands or similar if on a 64-bit computer:
##	sudo apt-get install libc6-dev-i386
##	sudo yum install glibc-devel.i686 glibc.i686
##
## Place this compiled program into a directory in your command path to use, 
## such as /usr/local/bin.  If you are root, you can type:
##	make install
## or otherwise 
##	su make install
## to copy ./muse2ps to the /usr/local/bin directory.
##
## To remove intermediate object files, type:
##	make clean    
##
## To remove intermediate object files as well as the compiled program 
## itself, type:
##	make superclean
##

# Determine if an extension is needed (.exe for Cygiwn or nothing if
# a regular unix environment).
EXT = 
ifneq ($(shell uname),Darwin)
   ifeq ($(shell uname -o),Cygwin)
      EXT = .exe
   endif
endif

all: compile

compile:
	@echo Compling executable: muse2ps$(EXT)
	-(cd src; $(MAKE) ; cp muse2ps$(EXT) ../)
	@echo Executable created: ./muse2ps$(EXT)

install: compile
	cp -i ./muse2ps$(EXT) /usr/local/bin

clean:
	(cd src; $(MAKE) clean)

superclean:
	(cd src; $(MAKE) superclean)
	-rm muse2ps$(EXT)


