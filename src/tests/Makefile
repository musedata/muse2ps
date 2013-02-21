## Makefile for test runs of muse2ps.  You must compile muse2ps first.
## Results of tests can be compared to files in the pdf/ directory.
## 
## Creation Date: Fri Dec 17 21:07:40 PST 2010
## Last Modified: Sat Dec 18 21:05:40 PST 2010
## Filename:      ...muse2ps/tests/Makefile
## 
## Description:   To run all tests, type:
##			make
##                To create PDF files for all tests, type:
##			make pdf
##		  To tidy up the files in this directory, type:
##		        make clean
##		  This will remove all of the *.ps files and *.pdf files.
##

# DIR = directory location of executable program
DIR = ..
# PROG is the name of the executable program to run.
PROG = muse2ps

# EXT: Add .exe to program name if running in Cygwin:
EXT  = 
ifneq ($(shell uname),Darwin)
   ifeq ($(shell uname -o),Cygwin)
      EXT = .exe
   endif
endif

TEST1 = bach-bwv852-1
TEST2 = beethoven-sym5-4
TEST3 = beethoven-sym9
TEST4 = bach-bwv846-1

PS2PDFOPTS = -sPAPERSIZE=letter 
# The following options are useful if to embed fonts in file (not necessary
# in these cases, since the files already have the dmuse fonts embedded).
#PS2PDFOPTS += -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress

##########################################################################
##
## Targets
##

# The default target (because it is specified first): run all three tests.
all: wtc1p1 wtc1p7 sym5 sym9

program:
	@if test ! -e $(DIR)/$(PROG)$(EXT); \
	  then echo "Compiling $(DIR)/$(PROG)$(EXT)"; \
	     (cd $(DIR); make); \
	fi

# J.S. Bach Well-tempered Clavier, BWV 852, prelude
# Options: z21 = music size 21
#          j   = right-justify last system on last page.
#          P   = embed intermediate MPG data within output PostScript data.
wtc1p7: program
	cat $(TEST1).md2 | $(DIR)/$(PROG)$(EXT) =z21jP > $(TEST1).ps
	-ps2pdf $(PS2PDFOPTS) $(TEST1).ps 


# Beethoven symphony no. 5, 4th movement
# Options: z14 = music size 14
#          j   = right-justify last system on last page.
#          f   = inter-staff vertical fill.
sym5: program
	cat $(TEST2).md2 | $(DIR)/$(PROG)$(EXT) =z14jf > $(TEST2).ps
	-ps2pdf $(PS2PDFOPTS) $(TEST2).ps 


# Beethoven symphony no. 9
# Options: p = input data is MPG format (not MuseData stage 2)
sym9: program
	cat $(TEST3).iff | $(DIR)/$(PROG)$(EXT) =p > $(TEST3).ps
	-ps2pdf $(PS2PDFOPTS) $(TEST3).ps 

# Bach WTC1, prelude 1 in C major
# Options are embedded in comments at the top of the file
wtc1p1: program
	cat $(TEST4).md2 | $(DIR)/$(PROG)$(EXT) > $(TEST4).ps
	-ps2pdf $(PS2PDFOPTS) $(TEST4).ps 


# Type "make clean" to erase all .o files.
clean:
	-rm -f *.ps *.pdf

