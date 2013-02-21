Readme for dmuse2ps.
Thu Jan 20 15:28:14 PST 2011
=======================================

The dmuse2ps program is a command-line version of the autoset.z,
mskpage.z and pspage.z zbex programs which are usually run within the
dmuse editor.  The muse2ps program packages these three programs into
a non-interactive form for use in batch processing on the command-line.
The program reads MuseData stage2 files or Music Page Files from standard
input and converts them into PostScript file data of graphical musical
notation which is sent to standard output.

To compile dmuse2ps, type this command in the same directory as this REAME file:
    make

Once the program has been compiled, you can go into the tests/ directory
and type "make" to create PostScript/PDF files for the test input files.
Example correct output of dmuse2ps can be found in tests/pdf.


When inputting MuseData stage 2 files, each input file (which contains 
one part), should be ended by:

/eof

The "/eof" marker is used specifically by muse2ps to locate the end of the 
current file (part).  The very last line of input to muse2ps should be "//".
So the end of the last part file send to muse2ps should look like this:

/eof
//


When inputing MPG (Music PaGe) files you must specify the "P" option:
     cat work.mpg | muse2ps =P > work.ps

If you are inputing multiple MPG files (each MPG file represents one page
of a score or part), add the letter "P" on a line by itself after the 
single-page MPG content.



Downloading and online documentation
===========================================================================

Online documetation for muse2ps is maintainted at the website:
    http://muse2ps.ccarh.org
The most recent and detailed documentation for the program is found there.

The most recent code for muse2ps should be downloadable with either of these
two commands in a unix terminal:
   wget http://www.ccarh.org/softare/muse2ps/muse2ps.tar.bz2
   curl http://www.ccarh.org/software/muse2ps/muse2ps.tar.bz2 -o muse2ps.tar.bz2     
The code can be unpacked and compiled with the commands:
   tar xvjf muse2ps.tar.bz2
   cd muse2ps
   make



List of options for muse2ps
===========================================================================

Options can be given to muse2ps.  For example, "z21" is the option which
sets the music size to 21 (21 pixels at 300 dpi between staves):
     cat work.md2 | muse2ps =z21 > work.ps
Note that the option string starts with an equals sign (=) and multiple
options can follow the equals sign, without spaces between the options.
For complicated options which contains spaces or other characters which
the command will try to process, enclose the option string (including the
initial equals sign in single or double quotes.

Below is a list of the options which muse2ps understands.  The online
documentation (http://muse2ps.ccarh.org contains a more detailed list
of the options).  Options are given as the first argument to the program,
staring with an equals sign (=) and followed by the options in any order,
with no spaces between the options.  For example, to set the music size
to 18 and right-justify the last system on the last page, use the option
string =z21j:
    cat file.md2 | muse2ps =z21j > file.ps

In option strings such as "=c<#>", replace <#> with an integer.

1.  =c<#>  compression factor:  This is measured as a percentage
             of the default.  100 = no compression.

2.  =d<#>  putc Diagnostics and Error Messages.
             bit 0 of #:  ON = print error messages
             bit 1 of #:  ON = print all diagnostics
             bit 2 of #:  ON = print diagnostics from autoset
             bit 3 of #:  ON = print diagnostics from mskpage
             bit 4 of #:  ON = print diagnostics from pspage
             no number = 0x01: print error messages

3.  =F     fill pages to the bottom by adding to the
             intersystem space only.  Default is don't change
             the vertical spacings.

4.  =f     fill pages to the bottom by proportionally
             stretching all spacings.  Default is don't change
             the vertical spacings.

5.  =g<#>  grand staff intra-space measured in multiples
             of leger lines times 10.  The default is 100,
             which is 10 leger lines.

6.  =h<#>  alter the minimum allowed space between notes.
             This is measured as a percentage of the default.
             100 = no change.

7.  =j     right justify the last system.  The default is
             NOT to right justify.

8.  =l<#>  length of a page.  Distance is measured dots, at
             300 dots to the inch.  Default is 2740 dots.  The
             default starting height is 120 dots.  This will not
             be lowered, but may be raised to accommodate a
             longer page.

9.  =m<#>  left margin, measured in at 300 dots/inch.  The
             default is 200 dots

10. =n<#>  maximum number of systems on a page.  The default
             is no maximum.

11. =Q<#>  duration which is assigned the minimum distance
               1 = whole notes
              ...   . . .
               8 = eighth notes
              16 = sixteenth notes, etc

12. =s^string^  custom left-hand spine.  If the format is
             incorrect for any reason, the program will revert
             to the default.  example:
             	=s^[(....)][(..)](.)[({..}..)]^

13. =t<#>  top of page.  Default is 120 dots

14. =v<#,#,#...#>  custom spacings.  If the format is incorrect
             for any reason, the program will revert to the default.
             example:

             =v192,192,192,208,192,192,208,176,176,176,200

15, =w<#>  system width, measured in at 300 dots/inch.  The
             default is 2050 dots

16. =x     defeat all part inclusion suggestions in the data

17. =y     defeat all line control suggestions in the data

18. =z<#>  notesize: choices are 6,14,16,18,21.  14 is the default.

19.  =M     include a listing of the MuseData source files in the
             Trailer section of the file

20.  =P     include listings of the page specific i-files, which are
             the source of the .ps files

21.  =p     The source is a concatinated set of page specific i-files
             (also called .mpg files), not a set of Musedate files.

22.  =G^group-name^ group name to process.  The default is "score"

23.  =E     /END = /eof

Added to muse2ps program Jan 2011:

24.  =C^string^ The composer name to place on the top right of the first
            page.

25.  =T^string^ The title to place at the top of the first page

26.  =u^string^ The sub-title to place below the title at the top of the
            first page.


Embedded options
===========================================================================

The default options can be overridden by changing them in the option string
given to muse2ps as the first argument on the command line.  In addition, 
these options can be stored with comments at the beginning of the standard
input data stream to muse2ps.  Single line comments in MuseData stage2 files
start with an at sign (@) in the first column of the line.  To make a
muse2ps option comment, start the comment with "@muse2psv1=" then an optional
size setting for which the option is applicable, followed by another equals
sign (=), and the option string as would be given on the commandline.
Options can be split onto multiple lines, and probably should not exceed
80 characters per line (or at the very most, 900 characters).

Here is an example set of formatting options which are placed at the start
of the standard input  (top of the MuseData stage2 file):

@muse2psv1==z18 
@muse2psv1==T^Bach Chorale^u^bwv-277^C^J.S. Bach (1685-1750)^ 
@muse2psv1=z14=v200,155,155,155j 
@muse2psv1=z18=v240,195,195,195j 
@muse2psv1=z21=v300,230,230,230j 

The first line states that the default size to print the music is in 18
(unless a different sizes is given on the command line argument to muse2ps).
The second line states that the title "Bach Chorale" should be printed
as the title on the top of the first page, the sub-title should be
"bwv-277" printed underneath the main title (both centered horizontally
on the page), and the composer to list at the top left of the first system
of music is "J.S. Bach (1685-1750).

The last three lines of the option comments control the spacing between
staves and systems on the page, depending on what music size the score
is being printed in.


Unpackmpg PERL program
===========================================================================

A helper program called "unpackmpg" is included in the source code.  This 
program will extract music page file data embeded into the PostScript file
as comments with the "=P" option to muse2ps.

collatemd2 PERL program
===========================================================================

Another helper program called "collatemd2" is included in the source code.  
This program can be used to concatenate multiple MuseData stage2 files into
a single file or data stream which can be used as input to muse2ps.  For
example, if the individual MuseData stage2 files for a string quartet
are: 01, 02, 03, and 04, then you can run muse2ps like this:
    collatemd2 01 02 03 04 | muse2ps =j | ps2pdf - > quartet.pdf


Workfiles directory: autoset.z, mskpage.z and pspage.z
===========================================================================

The sub-directory "workfiles" contains programs used to generate the
file zfun32.c.  These are intended for reference and not intended for
a general user to compile into a new version of the program.   Not all
necessary files are included (fonts are loaded from a separate location
by the compiling program).  The .q files in the workfiles directory are
assembled into zbex programs (ending in .z).  The .w files are binary
compiled versions of .z files.

These .q/.z program files are not used directly by muse2ps, nor when
compiling muse2ps, but are pre-compiled into zbex executable code within
zfun32.c.  The muse2ps is essentially a non-interactive version of dmuse
(see http://dmuse.ccarh.org).  The dmuse program is a text editor which
also has a built-in zbex language interpreter.  The intepreter portion
of dmuse has been extracted for non-interactive use in dmuse2ps.


dmuse2html: convert from Dmuse text file to HTML 
===========================================================================

A helper PERL program called dmuse2html is included which will convert
from a Dmuse text file into an HTML file.  This is useful for converting the
source code into HTML files to view the color codes marking the comments.

Example usage:
    ./dmuse2html main.c > main.html



