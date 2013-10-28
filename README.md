muse2ps -- Command-line typesetting program for MuseData files.
=================================================================

The muse2ps program is a command-line version of the autoset, mskpage
and pspage programs which usually are run inside of the dmuse editor
using the built-in zbex language interpreter.  The muse2ps program
contains a stand-alone interpreter for these zbex programs, along
with the fonts necessary to print music as PostScript files.

See the [main webpage for muse2ps](http://muse2ps.ccarh.org) for
detailed documentation on running the program.

The [bin] directory contains pre-compiled version of dmuse for
linux, OS X and Windows.

Printing from online data
===========================

Sample data can be found in the [src/tests] directory.  Online
data is available for several repertories:

| Composer | Repertory | MPG | MuseData |
| ---- | :---: | :---: | -------- |
| Beethoven | String Quartets | [all](https://github.com/musedata/beethoven-quartets/tree/master/pages-score) | [all](https://github.com/musedata/beethoven-quartets/tree/master/stage2) |
| Corelli | Opp. 1&ndash;6 | [op.&nbsp;1](https://github.com/musedata/corelli/tree/master/op1/pages-score), [op.&nbsp;2](https://github.com/musedata/corelli/tree/master/op2/pages-score), [op.&nbsp;3](https://github.com/musedata/corelli/tree/master/op3/pages-score), [op.&nbsp;4](https://github.com/musedata/corelli/tree/master/op4/pages-score), [op.&nbsp;5](https://github.com/musedata/corelli/tree/master/op5/pages-score) [op.&nbsp;6](https://github.com/musedata/corelli/tree/master/op6/pages-score) | [op.&nbsp;1](https://github.com/musedata/corelli/tree/master/op1/musedata) [op.&nbsp;2](https://github.com/musedata/corelli/tree/master/op3/musedata) [op.&nbsp;3](https://github.com/musedata/corelli/tree/master/op3/musedata) [op.&nbsp;4](https://github.com/musedata/corelli/tree/master/op4/musedata) [op.&nbsp;5](https://github.com/musedata/corelli/tree/master/op5/musedata) [op.&nbsp;6](https://github.com/musedata/corelli/tree/master/op6/musedata) |


As an example web-based application of muse2ps, you could print
Beethoven's first quartet from data downloaded directly from the
web with this musesp2.  Muse2ps outputs PostScript data, so you
will need software to convert PostScript into PDF.  The ps2pdf
program which is part of [GhostScript](http://en.wikipedia.org/wiki/Ghostscript) software package typically 
comes included on linux operating systems, and can be downloaded
for free on other computer platforms.

Using [wget](http://en.wikipedia.org/wiki/Wget) to download data on linux computers:

wget -O- https://raw.github.com/musedata/beethoven-quartets/master/pages-score/beethoven-op018n1.pag | muse2ps =p | ps2pdf -sPAPERSIZE=letter - - > beethoven-op018n1.pdf

Or with [curl](http://en.wikipedia.org/wiki/CURL) on Apple OS X computers:

curl https://raw.github.com/musedata/beethoven-quartets/master/pages-score/beethoven-op018n1.pag | muse2ps =p | ps2pdf -sPAPERSIZE=letter - - > beethoven-op018n1.pdf

The `=p` option for muse2ps will set the input data type to "Music Page Files". 
This format of MuseData has already been typeset for printing.  The muse2ps 
program can also typeset "Stage 2" MuseData files, although the layout will 
be totally automatic and not as polished as printing the Music Page files.
Here are examples of printing the first movement of Beethoven's first string
quartet:

wget -O- https://raw.github.com/musedata/beethoven-quartets/master/musedata/beethoven-op018n1-01.msd| muse2ps =z16j | ps2pdf -sPAPERSIZE=letter - - > beethoven-op018n1-msd.pdf

curl https://raw.github.com/musedata/beethoven-quartets/master/musedata/beethoven-op018n1-01.msd| muse2ps =z16j | ps2pdf -sPAPERSIZE=letter - - > beethoven-op018n1-msd.pdf

In this case the muse2ps options `=z16j` mean typeset at size 16 (16 pixels 
between staff lines) and right justify the last system of music.

