
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³D* 28. printslur_screen (ori,snum,x,y,mode,sitflag)            ³ 
&dA &d@³                                                               ³ 
&dA &d@³    Purpose: read slur data from bigslur, compile and          ³ 
&dA &d@³                send slur to screen                            ³ 
&dA &d@³                                                               ³ 
&dA &d@³   Input:  ori    case: 1,2,3 or 4                             ³ 
&dA &d@³           snum   slur number                                  ³ 
&dA &d@³           x      x location                                   ³ 
&dA &d@³           y      y location                                   ³ 
&dA &d@³           mode   1 = display, 0 = clear (cancel)              ³ 
&dA &d@³        sitflag   situation flag                               ³ 
&dA &d@³                                                               ³ 
&dA &d@³          bit 5:   continuous slur      broken slur            ³ 
&dA &d@³                                                               ³ 
&dA &d@³          bits 8-15:  size of break (0 to 255 dots, centered)  ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure printslur_screen (ori,snum,x,y,mode,sitflag) 
        str pfile.100,pointer.6,data.500
&dA &d@       bstr bt.2500(250)                  &dAThis is now global&d@ 
        int snum,ori 
        int offset,datalen,nrows 
        int slen,srise 
        int bulge 
        int t1,t2 
        int x,y,maxn 
        int dpnt,sdpnt 
        int code,cnt,ndata(2),kdata(2) 
        int mode,sitflag 
        int broksize                                /* &dA03/15/97&d@  &dIOK&d@ 
        real rx 
        int scx2                                    /* added &dA11/29/09&d@ 

        str sbt.800
* 
        getvalue ori,snum,x,y,mode,sitflag 
        if bit(5,sitflag) = 1                       /* &dA03/15/97&d@  &dIOK&d@ 
          broksize = sitflag >> 8 
        else 
          broksize = 0 
        end 
        sitflag &= 0x01 

        if snum < 24 or snum >= 144000 
          snum = 1000000 
          passback snum 
          return 
        end 

        perform construct_bigslur_element (ori,notesize,snum,srise,nrows,slen,bulge)
        maxn = slen 

        if bulge > 127                 /* added &dA01/03/05&d@ 
          bulge = 0 
        end 

        slen += bulge                  /* added &dA11-19-92&d@ 
        if bulge > 0 
          x -= bulge 
        end 

        t1 = 0                         /* look for vert shift 
        if ori = 1
          t1 = nrows - 1
        else 
          if ori = 2
            t1 = nrows - 1 - srise
          else
            if ori = 3
              t1 = srise
            end
          end
        end
        y = y - t1   

    /* move screen cursor to point <x,y> 

        scx = x 
        scy = y 

        if sitflag = 1 
          t2 = maxn / gapsize 
          if bit(0,t2) = 0 
            --t2 
          end 
&dA 
&dA &d@           xxxxxxxxxxx....xxxx....xxxx....xxxx....xxxx....xxxxxxxxxxx 
&dA &d@                  |               odd number                 | 
&dA &d@          t2 = largest odd number of intervals that will fit inside maxn 
&dA 
          t2 *= gapsize 
          t1 = maxn - t2 
          t1 >>= 1             /* initial correction 
          bt(250) = dup("1",t1) // dotted{1,t2} // dup("1",t1+10)   /* mask 

          loop for t1 = 1 to nrows 
            bt(t1) = bnd(bt(t1),bt(250)) 
          repeat 
        end 

        if broksize > 0                               /* &dA03/15/97&d@  &dIOK&d@ 
          t2 = maxn - broksize >> 1 
          if t2 < 0 
            t2 = 0 
          end 
          t1 = maxn - t2 - t2 
          bt(250) = dup("1",t2) // dup("0",t1) // dup("1",t2) 
          loop for t1 = 1 to nrows 
            bt(t1) = bnd(bt(t1),bt(250)) 
          repeat 
        end 

        ++st_cnt 
        tput [ST,st_cnt] Calling for a slur at <~scx ,~scy > 
        ++st_cnt 
        tput [ST,st_cnt] : 

        loop for t1 = 1 to nrows 
          sbt = upk(bt(t1)) 
          ++st_cnt 
          tput [ST,st_cnt] ~sbt 
        repeat 
        ++st_cnt 
        tput [ST,st_cnt] : 
&dA 
&dA &d@   &dA01/05/09&d@ Code below added back to POSTSCRIPT case, because we need the 
&dA &d@            "dots" to determine the bounding box.  mode is always = 1 
&dA 
        setb gstr,bt,scx,scy,nrows,maxn,1,3 
      return 
