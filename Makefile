## Makefile for compiling the muse2ps program which is a command-line program
## that converts MuseData stage 2 file or music page files into PostScript 
## files of graphical music notation.  The muse2ps program is a stripped-down
## version of the dmuse program (http://dmuse.ccarh.org> with a non-intractive
## version of zbex programs for typeseting music within dmuse.
##
## Type:
##	make
## to compile muse2ps in the src directory (and then copy into this directory)
##
## Or type:
##	make clean    
## to remove all *.o files used to compile the program, or type:
##      make superclean
## to also remove the compiled program.
##

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

