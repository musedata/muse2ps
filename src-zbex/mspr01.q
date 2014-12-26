
&dA &d@ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
&dA &d@³M*  1. my_mskpage                                               ³ 
&dA &d@³                                                                ³ 
&dA &d@³    Input: from table Z(400000)                                 ³ 
&dA &d@³                                                                ³ 
&dA &d@³    Output: pages directory                                     ³ 
&dA &d@³                                                                ³ 
&dA &d@ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
      procedure my_mskpage 
        str file.280,line2.480,temp2.480 
        str line3.480,tline.480,tline2.180 
        str outlib.400 
        str linepiece.480(5) 
        str htype.1,xbyte.10(32) 

        int t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13 
        int savet3,lastk,delta_e,mdf 
        int a3,a4,a8,a10 
        int q1,q2 
        int f2,f4,f5,f13 
        int nflg1,rflag(40) 
        int tarr2(32),tarr3(32),tarr5(32,2) 
        int adjarr(300,4),adjarc,pdist,larc2 
        int textflag,stopflag 
        int endflag,firstpt,prev_point,point_adv 
        int saverec,endbarrec,backloc(32),uxstart(32),nuxstop(32) 
        int savenoby(32),textlen,newbarnum,cdincf(32),ndincf(32),oldcdincf 
        int rmarg,supermap(32,N_SUPER),superpnt(32,N_SUPER) 
        int sq(32),sobx2,saved_sobx2 
        int sitflag,tspan,page,sysh,syslen,sysy 
        int bolddist(32),dv3,olddv1(32),oldcdv,cdv_adv,backtxobrec 
        int syscnt,new_syscnt(80),maxsystems,firstbarflag 
        int sysbarpar(400,5),old_sysbarpar(400,2),sav_sysbarpar(400,5) 
        int mcnts(5000),mcnt,mspace(2000),mspace2(20000) 
        int deadspace,old_extra,average_extra 
        int new_start_look,start_sys 
        int half_back,conttie(32),trec 
        int single_meas,sv_mainyp 
        int y1p,y2p,y3p 
        int c18,c19 

        table T(30000) 

        str abbr.40(200) 
        int point,oldmp2,oldmpoint,barpar(40,3),barcount 
        int barnum,delta,rest7,bottom_sq,tf11 
        int tsq(32),tvst(32),tnotesize(32)
        int recflag(400000),abbr_cnt,current_recf 
        int type1_dflag(32),type2_dflag(32) 
        int save_type1_dflag(32),save_type2_dflag(32) 
        int sys_jflag 
        int new_maxsystems(80),section_cnt 
        int max_larc 
        int xx(6) 
        int new_direct(100,2) 
        int save_direct(100,2) 
        int new_dircnt 
        int save_dircnt 
        int icnt 
&dA 
&dA &d@   Start Program Code 
&dA 
        icnt = 0 
        cjtype = "" 
        mtfont = 31 
        cdv = 0 
        backtxobrec = 0 
        saved_sobx2 = 100 
LIBQ2: 
        outlib = "pages" 
&dA 
&dA &d@  Transfer source files to X table 
&dA 
        t11 = 0 
        abbr_cnt = 0 

        f12 = 0 
        ++icnt 
        tget [Z,icnt] line 
        if line con "******" 
          ++f12 
        end 
TOP: 
        current_recf = 0 
        ++t11 
        f(f12,1) = t11 
        ++icnt 
        tget [Z,icnt] line 
&dA 
&dA &d@    Set line flag 
&dA 
        f(f12,15) = 1 
        if line{1} = "l" 
          f(f12,15) = 2 
        end 
&dA     
        vst(f12)  = int(line{3..})            /* vertical offset to second staff (or 0)
        f(f12,9)  = int(line{sub..})          /* vertical offset to text line
        f(f12,14) = int(line{sub..})          /* note size 

        if sub <= len(line) 
          line = line{sub..} 
          line = mrt(line)                    /* part name 
        else 
          line = "" 
        end 
        tput [Z,t11] ~line 
        recflag(t11) = current_recf 
&dA 
&dA &d@    This code insures that the movement name doesn't get printed twice 
&dA 
        ++icnt 
        tget [Z,icnt] line 
        if line{3} = "D" 
          ++icnt 
          tget [Z,icnt] line 
        else 
          line = line // pad(80) 
          ++t11 
          tput [Z,t11] ~line 
          recflag(t11) = current_recf 
        end 

        c1 = 0 
        loop 
          if icnt = zcnt 
            goto EOTAZ 
          end 
          ++icnt 
          tget [Z,icnt] line 
          if line con "******" 
            f(f12,2) = t11 
            if c1 = 0 
              c1 = 1 
            end 
            f(f12,13) = c1 
&dA 
&dA &d@   This code is put in to insure that searches do not extend beyond the end 
&dA &d@       of a particular i-file 
&dA &d@                                                                             
            ++t11 
            line = "   "            /* dummy line, beginning with " " 
            tput [Z,t11] ~line 
            recflag(t11) = 0          /* rec flag is 0 

            ++f12 
            goto TOP 
          end 
          line = line // "   " 
          if line{1} = "T" 
            c2 = int(line{3..}) 
            if line{sub} = "|" 
              c2 = int(line{sub+1..}) 
            end 
            c2 = int(line{sub..}) 
            if c1 < c2 
              c1 = c2 
            end 
          end 
&dA 
&dA &d@    Code to deal with Tags 
&dA 
          if line{1} = "Y"                      /* This is a tag.  Don't store it.
            if line{3} = "P"                    /*   abbr part name 
              if line{5} = "0" 
                current_recf &= 0xff00          /* turn off abbr flag completely
              else 
                ++abbr_cnt 
                abbr(abbr_cnt) = line{5..} 
                current_recf &= 0xff00          /* turn off any previous pointer
                current_recf += abbr_cnt        /*   and store new pointer 
              end 
            end 
            if line{3} = "U"                    /*   line control code 
              c3 = int(line{5}) 
              current_recf &= 0x00ff            /* turn off any previous control code
              current_recf += (c3 << 8)         /*   and store new code 
            end 
          else 
            ++t11 
            tput [Z,t11] ~line 
            recflag(t11) = current_recf           /* Flag every record 
          end 
        repeat 
EOTAZ: 
        f(f12,2) = t11 
        if c1 = 0 
          c1 = 1 
        end 
        f(f12,13) = c1 
&dA 
&dA &d@   This code is put in to insure that searches do not extend beyond the end 
&dA &d@       of a particular i-file 
&dA &d@                                                                             
        ++t11 
        line = "   "              /* dummy line, beginning with " " 
        tput [Z,t11] ~line 
        recflag(t11) = 0            /* rec flag is 0 
        f11 = f12 

        perform parameter_init 
&dA 
&dA &d@  Check for snode = 10000  at end of each part 
&dA 
        loop for f12 = 1 to f11 
          tget [Z,f(f12,2)] line .t5 t1 dvar1 t1 t1 t1 
          if t1 <> 10000 
            if (Debugg & 0x01) > 0 
              pute Error: Part ~f12 does not end properly 
            end 
            tmess = 39 
            perform dtalk (tmess) 
          end 
        repeat 
&dA 
&dA &d@   Set up mechanism for page specific output 
&dA 
        perform pageform_init 

REALWORK: 

        if justflag = 3 
          loop for t9 = 1 to maxsystems 
            old_sysbarpar(t9,1) = sysbarpar(t9,1) 
            old_sysbarpar(t9,2) = sysbarpar(t9,2) 
          repeat 
        end 

        new_dircnt = 0            /* New &dA11/21/07&d@ 
        save_dircnt = 0           /* New &dA11/21/07&d@ 
        mnum = 1 
        sys_count = 1 
        syscnt = 0 
        savet3 = 0 
        mcnt   = 0 
        deadspace = 0 
        stopflag  = 0 
        endflag   = 0 
        f4        = 0 
        adj_space = YES 

        loop for t9 = 1 to 32 
          conttie(t9) = 0 
        repeat 
        loop for t9 = 1 to f11 
          f(t9,5)   = 0 
          f(t9,7)   = 0 
          f(t9,8)   = 0 
          f(t9,11)  = 0 
          mkey(t9)  = 0 
&dA 
&dA &d@   initialize superpnt(.,N_SUPER), supermap(.,N_SUPER), superdata(.,N_SUPER,SUPERSIZE)
&dA &d@   drec(.), savenoby(.), nuxstop(.), dxoff(.) 
&dA &d@   dyoff(.), uxstart(.), backloc(.), xbyte(.) 
&dA 
          loop for t10 = 1 to N_SUPER     
            superpnt(t9,t10) = 0 
            supermap(t9,t10) = 0 
            loop for t7 = 1 to SUPERSIZE 
              superdata(t9,t10,t7) = 0 
            repeat 
          repeat 
          drec(t9)      = 0 
          savenoby(t9)  = 0 
          nuxstop(t9)   = 0 
          dxoff(t9)     = 0 
          dyoff(t9)     = 0 
          uxstart(t9)   = 0 
          backloc(t9)   = 0 
          xbyte(t9)     = "**********"{1,f(f12,13)} 
        repeat 

        sp = hxpar(3) + hxpar(9) 
        loop for t9 = 1 to f11 
          sq(t9) = psq(t9) 
        repeat 
        if justflag < 2 
          page = 0 
          treset [Y] 
          mainyp = 0 
          sv_mainyp = 0 
        end 
&dK &d@       if tacetline <> "" 
&dK &d@         if justflag < 2 
&dK &d@           ++mainyp 
&dK &d@           tput [Y,mainyp] X 46 1200C ~sq(1)  ~tacetline 
&dK &d@         end 
&dK &d@         loop for t9 = 1 to f11 
&dK &d@           sq(t9) += 150 
&dK &d@         repeat 
&dK &d@       end 
&dK &d@       if justflag < 2 
&dK &d@         ++mainyp 
&dK &d@         if len(mvtline) > 3 
&dK &d@           if mvtline{1,3} = "(c)" 
&dK &d@             mvtline = mvtline{4..} 
&dK &d@             tput [Y,mainyp] X 46 1200C ~sq(1)  ~mvtline 
&dK &d@           else 
&dK &d@             tput [Y,mainyp] X 46 575 ~sq(1)  ~mvtline 
&dK &d@           end 
&dK &d@         else 
&dK &d@           tput [Y,mainyp] X 46 575 ~sq(1)  ~mvtline 
&dK &d@         end 
&dK &d@       end 
&dK &d@       loop for t9 = 1 to f11 
&dK &d@         sq(t9) += 120                   /* This moves system down to accommodate mvtline
&dK &d@       repeat 

        sysy = sq(1) 
        sysh = sq(f11) - sq(1) + mvpar(f11,8) + vst(f11) 
        bottom_sq = sq(f11) 
        sys_bottom = sq(f11) + vst(f11) 
&dA 
&dA &d@  1. initialize variables   
&dA 
        ldist = sp 
        loop for f12 = 1 to f11 
          rec = f(f12,1) + 1 
          f(f12,4) = rec 
          f(f12,6) = rec 
          f(f12,10) = 0 
          olddist(f12) = 0 
        repeat 
        pdist = 0 
        larc = 0 
        barcount = 0 
        loop for t9 = 1 to 40 
          rflag(t9) = 0 
        repeat 
        textflag = 0 
        barnum = 0 
        oldbarnum = 0 
        newbarnum = 0 
        gbarflag = 0 
        f13 = 0 
&dA 
&dA &d@  2. Start initial system   
&dA 
&dA &d@     A. Generate entries in marr for mclef, mkey and time 
&dA &d@            signatures in that order  (snode = 6913) 
&dA 
        syslen = hxpar(4) - sp 
        marc = 0 
        perform setckt 
        firstpt = ldist - sp 
&dA 
&dA &d@     B. Transfer marr to larr
&dA 
        loop for t9 = 1 to marc 
          ++larc 
          loop for t10 = 1 to MARR_PARS 
            larr(larc,t10) = marr(t9,t10) 
          repeat 
        repeat 
        marc = 0 
        deadspace = ldist 

        stopflag = 0 
        sys_jflag = 0 
        mcnts(syscnt+1) = mcnt 
&dA 
&dA &d@     C. Jump over code that sets up to print pages 2ff.  
&dA &d@          Jump to section that begins reading input 
&dA &d@          data to construct the next measure (III-5).  
&dA 
        goto CF 

&dA                                            
&dA &d@ 
&dA &d@  I. General music system loop (big loop) 
&dA 
&dA &d@    1. Check to see if there is more music.  
&dA &d@         Jump to process end if not.  (FINE) 
&dA &d@                                               
CHH: 
        sys_jflag = 0 
        mcnts(syscnt+1) = mcnt 
        loop for f12 = 1 to f11 
          rec = f(f12,5) 
          perform save3                   /* oby not used here 
          if line{1} = "J" and jtype = "M" and snode = 10000 
            f(f12,8) = 1 
          end 
        repeat 

        perform endcheck (endflag) 
        if endflag = 1 
          if justflag > 0 
            sysbarpar(syscnt,5) = sysbarpar(syscnt,1) 
          end 
          goto FINE 
        end 
&dA 
&dA &d@    2. Determine location of new system.          
&dA 
&dA &d@       Note: We can make a preliminary determination of the vertical 
&dA &d@       size of the new system, but we will not know the final vertical  
&dA &d@       size until we have typeset the system and have performed the 
&dA &d@       the optional removal of "totally resting" lines.  
&dA 
        sq(1) = bottom_sq + vst(f11) + intersys 
        sp = hxpar(3) 

        loop for t9 = 2 to f11 
          if w(1) = 0                                   /* use default spacings
            if f(t9-1,9) = 0 
              sq(t9) = sq(t9-1) + mvpar(t9-1,14) 
            else 
              sq(t9) = sq(t9-1) + mvpar(t9-1,11) 
            end 
          else 
            sq(t9) = sq(t9-1) + w(t9-1) 
          end 
          if f(t9-1,12) = 2 
            sq(t9) += vst(t9-1) 
          end 
        repeat 

        sysy = sq(1) 
        sysh = sq(f11) - sq(1) + mvpar(f11,8) + vst(f11) 
        syslen = hxpar(4) - sp 
        bottom_sq = sq(f11) 
        if justflag < 2 
          old_sys_bottom = sys_bottom 
        end 
        sys_bottom = sq(f11) + vst(f11) 
&dA 
&dA &d@    3. Compute space for new mclef and mkey 
&dA 
        perform clefkeyspace (f5) 
        deadspace = ldist 
&dA 
&dA &d@    4. Initialize music system (line) variables 
&dA 
        hxpar(8) = ldist + hxpar(7) 
        line2 = pad(80) 
        loop for f12 = 1 to f11 
          uxstart(f12) = hxpar(8) 
          backloc(f12) = hxpar(8) 
          olddist(f12) = bolddist(f12) 
          f(f12,6) = f(f12,5)     /* record at new measure of music for part(.)
          f(f12,4) = f(f12,5) 
          f(f12,10) = f(f12,7)    /* multiple rest counter for part(.) 
        repeat 
        pdist = ldist - sp 
        f13 = 1 
        larc = 0 
        marc = 0 
        barcount = 0 
        loop for t9 = 1 to 40 
          rflag(t9) = 0 
        repeat 
        textflag = 0 
        oldbarnum = barnum 
        stopflag = 0 
        if justflag < 2 
          firstsys = FALSE 
        end 

&dA                                                                       
&dA 
&dA &d@  II. Read measures until ldist > hxpar(4), or until end of data.  
&dA 
&dA &d@      Read data one measure at a time.  The definition of a complete 
&dA &d@    measure is when the space node = 6913.   There may be several 
&dA &d@    objects in this position, including clef, key, and time changes, 
&dA &d@    and also some super-objects.  All of these must be read and the 
&dA &d@    distances included in the "measure".  If the last object is not 
&dA &d@    a bar line, the next object must be checked and the distance to 
&dA &d@    it used as a temporary negative adjustment to the potential length 
&dA &d@    of the line (so that there will be space for the last object).  
&dA 
&dA &d@      When the addition of a measure distance to the total distance 
&dA &d@    on a line results in a line overflow, we have two choices: (1) 
&dA &d@    we may try to condense the longer line to fit, or (2) we may 
&dA &d@    try to expand the shorter line (i.e. minus the last measure) to 
&dA &d@    fit.  This decision and the resulting processes are in section 
&dA &d@    III of the process.  
&dA 
&dA &d@      We must first establish which parts are active in this measure.  
&dA &d@    This is also a good time to look for the terminating mark in all 
&dA &d@    parts.  

CF: 
        rmarg = hxpar(4) 
        false_rmarg = rmarg 
        f2 = 0 
        nflg1 = 0xffffffff 
        loop for f12 = 1 to f11 
          notesize = f(f12,14) 
          if f(f12,10) = 0        /* first temporary multiple rest counter 
            rec = f(f12,6) 
CR: 
            perform save3                 /* oby not used here 
            ++rec 
            if line{1,3} = "J S" and f11 > 1 
              if "467" con line{5}                 /*  multiple rests and whole rests
                if mpt = 1 
                  f(f12,10) = snode 
                else 
                  f(f12,10) = 1 
                end 
CP: 
                perform save3             /* oby not used here 
                if line{1,3} <> "J B" 
                  ++rec 
                  goto CP 
                end 
&dA 
&dA &d@  reset olddist(.) to bar line after rest.  This reset occurs only  
&dA &d@  for those parts where f(f12,10) (rest-counter) > 0.  Note: at the 
&dA &d@  point where we start looking at this part again, i.e. the counter 
&dA &d@  is changing from 1 to 0, we must typeset the concluding bar line  
&dA &d@  and check to see if there are any addition 6913 type nodes,   
&dA &d@  e.g., time or key changes, which would have to be included on 
&dA &d@  this line.  
&dA 
                olddist(f12) = dvar1 
                f(f12,6) = rec 
                goto CQ 
              end 
            end 
            if line{1} = "J" 
              if snode = 10000 
                f(f12,8) = 1 
              end 
              goto CQ 
            end 
            goto CR 
          end 
CQ: 
        repeat 
* 
        perform endcheck (endflag) 
        if endflag = 1 
          if justflag > 0 
            ++syscnt 
            sysbarpar(syscnt,1) = barcount 
            sysbarpar(syscnt,2) = rmarg - ldist 
            sysbarpar(syscnt,5) = barcount 
          end 
          if justflag <> 1 
            goto CG 
          else 
            goto CE 
          end 
        end 
&dA 
&dA &d@  endcheck checks all values of f(.,8); they must be either all 0   
&dA &d@     or all 1 

&dA 
&dA &d@  Check for whole rests in all parts  
&dA 
        loop for f12 = 1 to f11 
          if f(f12,10) = 0 
            goto CC 
          end 
        repeat 
&dA 
&dA &d@  If no branch, then whole rest is in all parts,  
&dA 
&dA &d@     0) check for forced termination 
&dA 
        if sysbarpar(syscnt+1,3) = barcount and barcount > 0 
          delta = rmarg - ldist 
*   put in larr entry for terminating bar line 
          ++larc 
          larr(larc,MNODE_TYPE)  = 18                 /* New &dA05/25/03&d@ 
          larr(larc,ACT_FLAG)    = 0xffffffff         /*  "     " 
          larr(larc,M_ADJ)       = adj_space          /*  "     " 
          goto CE 
        end 
&dA 
&dA &d@     1) increment ldist, check for overflow 
&dA 
        ldist += hxpar(6) 

        if ldist > false_rmarg 
*   put in larr entry for terminating bar line 
          ++larc 
          larr(larc,MNODE_TYPE)  = 18 
          larr(larc,ACT_FLAG)    = 0xffffffff 
          larr(larc,M_ADJ)       = adj_space 
          goto CE 
        end 

        ++mcnt 
        mspace(mcnt) = ldist 
&dA 
&dA &d@     2) check to see if this is the last measure of general rest.  If 
&dA &d@          so, then we will want to look for additional objects such as 
&dA &d@          clefs, key changes, etc. beyond the terminating bar line.  
&dA &d@          The code to do this is at CCV.  
&dA 
        a1 = 0 
        loop for f12 = 1 to f11 
          if f(f12,10) = 1 
            a1 = hxpar(6) 
            ndincf(f12) = 0 
          end 
        repeat 
        if a1 > 0 
          f2 = 1 
          --mcnt 
          goto CCV 
        end 
&dA 
&dA &d@     3) recompute delta 
&dA 
        delta = rmarg - ldist 
&dA 
&dA &d@     4) advance record pointer and bolddist; decrement f(.,10) 
&dA 
        loop for f12 = 1 to f11 
          f(f12,5) = f(f12,6) 
          bolddist(f12) = olddist(f12) 
          --f(f12,10) 
        repeat 
&dA 
&dA &d@     5) increment barcount, set empty bar flag for this bar, zero marc 
&dA 
        ++barcount 
        ++barnum 
        rflag(barcount) = hxpar(6) 
&dA 
&dA &d@     6) branch; if delta = 0, go to print, else get next measure 
&dA 
        if delta = 0 
*   put in larr entry for terminating bar line 
          ++larc 
          larr(larc,MNODE_TYPE)  = 18                 /* New &dA05/25/03&d@ 
          larr(larc,ACT_FLAG)    = 0xffffffff         /*  "     " 
          larr(larc,M_ADJ)       = adj_space          /*  "     " 
          if justflag > 0 
            ++syscnt 
            sysbarpar(syscnt,1) = barcount 
            sysbarpar(syscnt,2) = 0 
            sysbarpar(syscnt,5) = 0                  /* New &dA05/28/05&d@ 
          end 
          goto CG 
        end 
        goto CF 

&dAÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ&d@ 
 
&dA 
&dA &d@  At this point we have established that there is at least one active 
&dA &d@  part in the measure.  We now have a well-defined task.  We must look 
&dA &d@  through the active parts (where f(.,10) = 0) for the object(s) which 
&dA &d@  has (have) the next smallest division number.  We are concerned 
&dA &d@  here with objects that need to "line up".  These objects we 
&dA &d@  call "proper" objects and include: 
&dA 
&dA &d@     1. regular notes, cue notes, figures, isolated objects (NRQFI) 
&dA &d@     2. bar lines                                           (B) 
&dA &d@     3. key signatures, time signatures                     (KT) 
&dA 
&dA &d@  For purposes of determining position and space, we can skip over 
&dA &d@  those types of objects in a part that do not have to line up, but 
&dA &d@  the distances through these objects to the line-up type objects 
&dA &d@  must be taken into account.  The objects that do not have to 
&dA &d@  line up are called "passing" objects and include: 
&dA 
&dA &d@     1. clef signs                           (C) 
&dA &d@     2. directives                           (D) 
&dA &d@     3. grace notes                          (G) 
&dA &d@     4. symbols                              (S) 
&dA &d@     5. marks                                (M) 
&dA 
&dA &d@  Clef signs actually get special treatment.  If they follow a 
&dA &d@  bar line and have snode = 6913, they are classified as proper 
&dA &d@  objects; otherwise they are passing objects and their position 
&dA &d@  is determined by the next proper object in the part.  
&dA 
&dA &d@  Our search will cover all objects with snode < 6913.  When 
&dA &d@  snode = 6913, we are at the end of a controlling measure.  This 
&dA &d@  situation will be covered later in the program.  
&dA 
&dA &d@  There is one anomaly which should be mentioned.  We may encounter 
&dA &d@  a non-controlling bar line in the middle of our search.  In this  
&dA &d@  case, we will generate two nodes with the same snode number.  
&dA &d@  These can be differentiated by the node type (marr(.,MNODE_TYPE)).   (&dA05/25/03&d@)
&dA 
CC: 
        loop for f12 = 1 to f11 
          f(f12,5) = f(f12,6)         /* set the "beginning of measure" pointers
          bolddist(f12) = olddist(f12) 
          cdincf(f12) = 0 
          ndincf(f12) = 0 
        repeat 
        oldcdincf = 0 
        loop for t11 = 1 to 32 
          tdist(t11,1) = 0 
        repeat 
&dA 
&dA &d@  Set tarr array for active parts in this measure.  
&dA &d@  Set textflag = 1, if any active parts are parts which contain text. 
&dA 
        loop for f12 = 1 to f11 
          tarr(f12) = f(f12,10) 
          if f(f12,10) = 0 and f(f12,9) > 0 
            textflag = 1 
          end 
        repeat 
&dA 
&dA 
&dA &d@  CHECK POINT:   When a new node is identified, the distance to that  
&dA &d@  node must be added to all the olddist(.) variables, not just to   
&dA &d@  parts in the node.  Then if the next node is generate by part(s) 
&dA &d@  not in this set (the case which we define as syncopation), you won't 
&dA &d@  get some huge distance between these nodes.  This, however, leads 
&dA &d@  to another problem.  The distance to this next node may become very 
&dA &d@  small, or even negative.   We need to set some minimum distance 
&dA &d@  for this node; also, we need to identify this node with a new type, 
&dA &d@  because it will have its own rules for adding distance.  The type 
&dA &d@  shall be 20 + note type that would be generated by the increment 
&dA &d@  in divisions, or in the case of tuplets, the type shall be 40.  
&dA &d@  The minimum distance in the case of syncopation shall be determined 
&dA &d@  in the following manner.  
&dA 
&dA &d@                 Spacing of Syncopated Nodes 
&dA &d@                 ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA 
&dA &d@  Definition:  A node is syncopated when it contains no parts which 
&dA &d@     were also contained in the previous node.  
&dA 
&dA &d@  To compute the minimum distance to a syncopated node: 
&dA 
&dA &d@    1) determine the duration of all of the nodes coming into this 
&dA &d@       node 
&dA 
&dA &d@          To do this, we will have to look ahead to the next node 
&dA &d@          in every active part and read field 8, the preceding 
&dA &d@          duration parameter.  This information can be collected 
&dA &d@          at the time we are putting the objects for the node 
&dA &d@          together, since this process requires that we look at 
&dA &d@          objects up to the point where the node number changes.  
&dA &d@          When this change does occur, the value of dincf will be 
&dA &d@          the duration of this node in this part.  
&dA 
&dA &d@    2) the shortest such duration becomes the "controlling duration" 
&dA 
&dA &d@    3) the space occupied by the node generating the controlling 
&dA &d@       duration becomes the "controlling space" 
&dA 
&dA &d@          The space is the advance in the x-coordinate for this 
&dA &d@          node.  This we will have to determine at the time the 
&dA &d@          syncopation is discovered.  At least we will already 
&dA &d@          know the controlling duration and therefore the part 
&dA &d@          which must be examined.  We must look forward to the 
&dA &d@          first &dDproper&d@ object which has a new node number.  
&dA 
&dA &d@    4) determine the ratio between the duration advance to this 
&dA &d@       node and the controlling duration (always less than 1) 
&dA 
&dA &d@          The duration advance for a particular node can only be 
&dA &d@          computed by keeping track of the duration advances for 
&dA &d@          all active parts from the previous controlling bar line 
&dA &d@          (bar line with snode = 6913).  We must assume that all 
&dA &d@          active parts will have a node at the beginning of the 
&dA &d@          measure, even if it is a rest.  
&dA 
&dA &d@    5) the minimum distance is this ratio times the controlling space 
&dA 
&dA &d@    Note:  syncopated nodes should be reasonably rare in the music 
&dA &d@           we are currently working with.  
&dA 
&dA 
&dA &d@    &dENOTE&d@: The following loop, which occupies about 400 lines, 
&dA &d@            uses a tricky exit mechanism 
&dA 
        t13 = 0 
        loop 
          t8 = 0 
&dA 
&dA &d@  Find the parts which constitute the next node (less than 6913) in 
&dA &d@    measure.  Set tarr2(.) = 1 for these parts. 
&dA 
          t12 = 20000 
          loop for f12 = 1 to f11 
            notesize = f(f12,14) 
            tarr2(f12) = 0 
            if tarr(f12) = 0       /* i.e. if part is active and not at end of measure
              rec = f(f12,6) 
CTT: 
              perform save3               /* oby not used here 
              ++rec 
              if line{1} = "Q" 
                stopflag = 1 
                goto CTT 
              end 
              if line{1} = "J"     /* this is what you are looking for (next object)
                if snode < t12 
                  t12 = snode 
                  loop for t9 = 1 to f12 
                    tarr2(t9) = 0 
                  repeat 
                end 
                if snode = t12 
                  tarr2(f12) = 1 
                end 
                if snode = 6913 
                  ++t8 
                  tarr(f12) = 1        /* end of measure for this part 
                  tarr2(f12) = 0 
                end 
                goto CSS 
              end 
              goto CTT 
            else 
              ++t8 
            end 
CSS: 
          repeat 
&dA 
&dA &d@  Check for end of measure; if so, set value for rflag(barcount) = 0  
&dA 
          if t8 = f11 
            a1 = 0 
            goto CCV       /* this is the exit for the measure loop 
          end 
&dA 
&dA &d@  establish minimum ndincf for active parts coming into this node 
&dA 
          t4 = 20000 
          t5 = 0 
          loop for f12 = 1 to f11 
            if tarr(f12) = 0 and ndincf(f12) < t4 
              t4 = ndincf(f12) 
              t5 = f12 
            end 
          repeat 
&dA 
&dA &d@  Determine values of marr for this node  
&dA 
          ++marc 
          marr(marc,PRE_DIST)    = 0 
          marr(marc,MNODE_TYPE)  = 17 
          marr(marc,SNODE)       = t12 
          marr(marc,ACT_FLAG)    = 0 
          marr(marc,M_ADJ)       = adj_space 
          marr(marc,MARR_TEMP)   = 3           /* New &dA02/09/07&d@  &dE3 = unset&d@ */

          loop for t11 = 1 to 32 
            tdist(t11,1) = 0 
          repeat 
          t11 = 0 
          t6 = 0                           /* WARNING: very tricky code 
          t7 = 0 
          loop for f12 = 1 to f11 
            notesize = f(f12,14) 
            rec = f(f12,6) 
            if tarr2(f12) = 1 

&dA &d@  update the cumulative distance increment flag for this part 
&dA &d@    and set marr(marc,TIME_NUM); also check to see accumulation is correct.  New &dA05/25/03

              cdincf(f12) += ndincf(f12) 
              if t6 = 0 
                t6 = cdincf(f12) 
                marr(marc,TIME_NUM) = t6 - oldcdincf            /* New &dA05/25/03
                oldcdincf = t6 
              else 
                if t6 <> cdincf(f12) 
                  if (Debugg & 0x01) > 0 
                    pute Error: Problem in accumulation of durations 
                    pute Suspected location: part ~f12   measure ~marc  in this system
                    pute or possibly bar ~barnum  in the music.  
                    pute 
                  end 
                  tmess = 40 
                  perform dtalk (tmess) 
                end 
              end 
CT: 
              perform save3               /* oby not used here 
              ++rec 
              if line{1} = "J" 
                if f11 = 1 and jtype = "S" and ntype >= 4 
                  if ntype = 4 
                    marr(marc,MARR_TEMP) = 1           /* multiple rest flag
                  end 
                else 
                  if "TCGMSD" con jtype 
                    goto CT 
                  end 
                end 
&dA 
&dA &d@  if part with min ndincf is also current, compute controlling space  
&dA 
                if f12 = t5 
                  t7 = dvar1 - olddv1(f12) 
                end 
                olddv1(f12) = dvar1 
                t9 = dvar1 - olddist(f12) 
&dA 
&dA &d@    /* Code added &dA02/25/97&d@.  I think this is where we must correct for 
&dA &d@         for extra distance put in by AUTOSET but not used.  
&dA 
                if snode = 1 and conttie(f12) = 0 
                  trec = rec 
                  t2 = 0 - f(f12,14)      /* t2 = -notesize 
CTa: 
                  tget [Z,trec] temp4 .t3 t1 
                  if "TKkWC" con temp4{1}         /* "C" added &dA12/18/10&d@ 
                    if temp4{1} = "k" and t2 > t1 
                      t2 = t1 
                    end 
                    ++trec 
                    goto CTa 
                  end 
                  t2 += f(f12,14)      /* t2 is possibly negative 
                  t9 += t2             /* remove this "dead" space 
                end 
&dA 
&dA &d@    End of &dA02/25/97&d@ addition.  Let's hope it works!  
&dA 
&dA &d@      t9  could possibly be too small, or negative, if the node is  
&dA &d@      syncopated.  We won't be able to compute this until this  
&dA &d@      loop is finished  
&dA 
                if "CKTDBSFIM" con jtype    /* only K,B,F and I are left, actually
                  if mpt < 5 
                    ntype = 13 + mpt 
                  else 
                    ntype = 17 
                  end 
                end 
                if ntype < marr(marc,MNODE_TYPE) 
                  if marr(marc,MNODE_TYPE) = 18 
                    if (Debugg & 0x01) > 0 
                      pute Error: Non-controlling bar line error at ~barnum 
                    end 
                    tmess = 41 
                    perform dtalk (tmess) 
                  end 
                  marr(marc,MNODE_TYPE) = ntype 
                  if f11 = 1 
&dA 
&dA &d@   Code modification &dA02/09/07&d@:  0 will be "sticky" 
&dA 
                    if ntype = 9 and cflag = 1 
                      marr(marc,MARR_TEMP) = 2 
                    else 
                      marr(marc,MARR_TEMP) = 0 
                    end 
&dA 
&dA                              

                  end 
                end 
                if t9 > marr(marc,PRE_DIST) 
                  marr(marc,PRE_DIST) = t9 
                end 
                ++t11 
                tdist(t11,1) = f12 
                tdist(t11,2) = dvar1 
&dA 
&dA &d@   If this node is not a non-controlling bar line (ntype = 18), we  
&dA &d@   must look further in this file for additional proper objects 
&dA &d@   (notes, figures, rests, cues) on this node.  The purpose is to 
&dA &d@   find the smallest ntype.  We must also advance f(f12,6) to the first 
&dA &d@   record beyond the last object in the node.  rec will also point  
&dA &d@   beyond the last object in the node and at or before the next object  
&dA &d@   beyond the node  
&dA 
                f(f12,6) = rec 
                if ntype <> 18 
CR2: 
                  perform save3         /* oby not used here 
                  if line{1} <> "J" 
                    ++rec 
                    goto CR2 
                  end 
                  if snode = marr(marc,SNODE)               /* New &dA05/25/03&d@ 
                    if "CKTDBSFIM" con jtype 
                      if mpt < 5 
                        ntype = 13 + mpt 
                      else 
                        ntype = 17 
                      end 
                    end 
                    if ntype < marr(marc,MNODE_TYPE)        /* New &dA05/25/03&d@ 
                      marr(marc,MNODE_TYPE) = ntype         /*  "      " 
&dA         
&dA 
&dA &d@   Code modification &dA02/09/07&d@:  Be sure to set (marc,MARR_TEMP) 
&dA &d@                                to 0, if this is a regular node 
&dA 
                      if f11 = 1 
                        if ntype = 9 and cflag = 1 
                        else 
                          marr(marc,MARR_TEMP) = 0 
                        end 
                      end 
&dA 
&dA         &d@ End of modification 

                    end 
                    ++rec 
                    f(f12,6) = rec 
                    goto CR2 
                  end 
                end 
                goto CS 
              else 
                if line{1} = " " 
                  line = trm(line) 
                  if line = "" 
                    if (Debugg & 0x01) > 0 
                      pute A search for Bar line was unsuccessful in part ~f12 .
                      pute Measure number = ~barnum .  Try checking durations, especially
                      pute those used in "back" records.  
                    end 
                    tmess = 42 
                    perform dtalk (tmess) 
                  end 
                end 
              end 
              goto CT 
            end 
&dA 
&dA &d@   We must also determine the new values for ndincf(.) for notes  
&dA &d@   in this node (for all active parts, if first pass (t13 = 0)).  
&dA 
CS: 
            if tarr(f12) = 0 
              if t13 = 1 
                if tarr2(f12) = 0 
                  goto CS2 
                end 
              else 
                t13 = 1 
              end 
CR3: 
              perform save3               /* oby not used here 
              ++rec 
              if line{1} = "J" 
                ndincf(f12) = dincf 
              else 
                goto CR3 
              end 
            end 
CS2: 
          repeat 
&dA 
&dA &d@    Code added &dA02/09/07&d@:  If marr(marc,MARR_TEMP) is unset, set it to 0 
&dA 
          if marr(marc,MARR_TEMP) = 3 
            marr(marc,MARR_TEMP) = 0 
          end 

&dA 
&dA &d@   Before going on to the next node, we must: 
&dA 
&dA &d@     1) Compute node flag(s) and determine if this node is 
&dA &d@          syncopated or not.  
&dA 
          t1 = 0x80000000 
          t2 = 0 
          loop for f12 = 1 to f11 
            if tarr2(f12) = 1 
              t2 |= t1 
            end 
            t1 >>= 1 
          repeat 
          t11 = 0 
          if t2 & nflg1 = 0 
            t11 = 1 
          end 
          nflg1 = t2 
&dA 
&dA &d@     2) If syncopated node, compute minimum value for marr(marc,PRE_DIST). 
&dA &d@          Minimum distance is determined by algorithm described   
&dA &d@          earlier.  Also the type for the previous node needs to be   
&dA &d@          recomputed, based on the elapsed duration.  If this duration  
&dA &d@          is 576 multiplied or divided by a power of 2, then the  
&dA &d@          newtype will be the type of the duration + 20.  Otherwise 
&dA &d@          the type will be 40.  
&dA 
          if t11 = 1 
&dA 
&dA &d@   t4 is controlling duration 
&dA &d@   t5 is part with controlling duration 
&dA &d@   if t7 > 0, t7 is controlling space; otherwise, compute it now  
&dA 
            if t7 = 0 
              rec = f(t5,6) 
DS: 
              perform save3               /* oby not used here 
              ++rec 
              if line{1} = "J" 
                if "CGMS" con jtype 
                  goto DS 
                end 
                t7 = dvar1 - olddv1(t5) 
              else 
                goto DS 
              end 
            end 
&dA 
&dA &d@   t7 is controlling space    
&dA 
            t7 = t7 * marr(marc,TIME_NUM) / t4 
            if marr(marc,PRE_DIST) < t7 
              marr(marc,PRE_DIST) = t7 
            end 
*   compute new ntype 
            t5 = t4 / 9 
            if rem = 0 
              loop for t3 = 1 to 11 
                t5 >>= 1 
              repeat while t5 > 0 
              marr(marc-1,MNODE_TYPE) = t3 + 20 
            else 
              marr(marc-1,MNODE_TYPE) = 40 
            end 
          end 
&dA 
&dA &d@     3) Adjust olddist(.) for parts where f(f12,10) = 0 
&dA 
          perform adjolddist 
&dA 
&dA &d@     4) Increment ldist 
&dA 
          ldist += marr(marc,PRE_DIST) 
&dA 
&dA &d@  Proceed to next node (&dEEnd of tricky loop&d@) 
&dA 
        repeat 
&dA 
&dA &d@  Decrease multiple rest counters; save f(.,10) in case ldist > rmarg 
&dA 
CCV: 
        loop for f12 = 1 to f11 
          tarr3(f12) = f(f12,10) 
          if f(f12,10) > 0 
            --f(f12,10) 
          end 
        repeat 
&dA 
&dA &d@  Now is the time to deal with nodes with snode = 6913.  This includes  
&dA &d@  types G,S,M,C,D,B,K,T (not N,R,Q,F,I).  The first proper object-node  
&dA &d@  will always be a type B (bar line).  Types B,K,T will generate proper 
&dA &d@  object-nodes.  Type C will generate a proper node if it follows 
&dA &d@  the bar line. 
&dA 
&dA &d@   Look at bar 
&dA 
        ++marc 
        marr(marc,PRE_DIST)    = 0 
        marr(marc,MNODE_TYPE)  = 18 
        marr(marc,SNODE)       = 6913 
        marr(marc,ACT_FLAG)    = 0xffffffff 
        marr(marc,M_ADJ)       = adj_space 
        marr(marc,MARR_TEMP)   = 0 

&dA 
&dA &d@     I think this is the point where we need to set a new value for adj_space.
&dA &d@     Basically, the normal condition is for adj_space = YES; but if a terminating
&dA &d@     barline object in one of the active parts has a print suggestion that 
&dA &d@     indicates that the next measure must not have its spaces altered in the
&dA &d@     line adjustment process, then the adj_space flag must be set to NO.  
&dA 
        adj_space = YES 
        t6 = 0 
        loop for f12 = 1 to f11 
          notesize = f(f12,14) 
          if f(f12,10) = 0 
            if ndincf(f12) > 0 
              cdincf(f12) += ndincf(f12) 
              if t6 = 0 
                t6 = cdincf(f12) 
                marr(marc,TIME_NUM) = t6 - oldcdincf 
              else 
                if t6 <> cdincf(f12) 
                  if (Debugg & 0x01) > 0 
                    pute Error: Problem in accumulation at bar line ~barnum 
                  end 
                  tmess = 43 
                  perform dtalk (tmess) 
                end 
              end 
            end 
            rec = f(f12,6) 
DT1:        perform save3 
            ++rec 
            if line{1,3} = "J B" 
              t9 = dvar1 - olddist(f12) 
              if t9 > marr(marc,PRE_DIST) 
                marr(marc,PRE_DIST) = t9 
              end 
              olddist(f12) = dvar1 
              f(f12,6) = rec 

              if oby >= 1000000 
                t1 = oby / 1000000 
                if t1 = 1 or t1 = 3 
                  adj_space = NO 
                end 
                if t1 = 10 
                  sys_jflag = barcount + 1 
                end 
              end 

            else 
              goto DT1 
            end 
          end 
        repeat 
&dA 
&dA &d@   Adjust distances 
&dA 
        loop for f12 = 1 to f11 
          if f(f12,10) > 0 
            olddist(f12) += marr(marc,PRE_DIST) 
          end 
        repeat 
        ldist += marr(marc,PRE_DIST) 
&dA 
&dA &d@   Look for clef, key, time signature in 6913 type node 
&dA 
        perform setckt 
&dA 
&dA &d@   Check length, branch back, or proceed  
&dA 
        ++mcnt 
        mspace(mcnt) = ldist 
        if ldist > false_rmarg 
          goto CK 
        end 
&dA 
&dA &d@   Transfer marr to larr  
&dA 

&dA                                                         
&dA 
&dA &d@     New code added &dA10/31/08&d@ to deal with an obscure situation that 
&dA &d@     arrises from the new feature (for parts) that allows multiple rests 
&dA &d@     to be broken into smaller units.  A multiple rest generates a single 
&dA &d@     marr(.,.) entry (a bar line with 0 space), which under normal 
&dA &d@     conditions is transferred to larr(.,.).  And normally there would be 
&dA &d@     real musical notes following this barline.  However, when a multiple 
&dA &d@     rest is broken into smaller units, a second 0 space barline follows 
&dA &d@     the first.  This creates a problem later in the code because this 
&dA &d@     extra bar is "double counted," i.e., it is counted as part of the 
&dA &d@     multiple rest (handled one way), and as a measure with musical 
&dA &d@     notes (handled another way).  Put another way, the larr(.,.) array 
&dA &d@     has too many bar lines in it, so the data in the last measure is 
&dA &d@     not processed, causing a misalignment of pointers.  
&dA 
&dA &d@     The "fix" used here is to skip the tranfer of marr(.,.) to larr(.,.) 
&dA &d@     when marc = 1, and the space parameter of the previous larr(.,.) 
&dA &d@     entry is 0 (as it is for the last bar of a multiple rest).  I 
&dA &d@     have not checked to see if there are other situations which 
&dA &d@     produce this condition -- a possible new problem.  
&dA 

        if marc = 1 and larc > 0 and larr(larc,1) = 0 and larr(larc,2) = 18 
          goto NO_TRANS 
        end 
&dA 
&dA                                                         

        loop for t9 = 1 to marc 
          ++larc 
          loop for t10 = 1 to MARR_PARS 
            larr(larc,t10) = marr(t9,t10) 
          repeat 
        repeat 
&dA 
&dA &d@   Adjust delta and counters  
&dA 

NO_TRANS:                                /* New label &dA10/13/08&d@ 

        delta = rmarg - ldist 

        ++barcount 
        ++barnum 
*  a1 is set earlier; normal case, a1 = 0, for end of G.P. a1 = hxpar(6) 
        rflag(barcount) = a1 
        loop for f12 = 1 to f11 
          if delta = 0 
            bolddist(f12) = olddist(f12) 
            f(f12,5) = f(f12,6) 
          end 
          if stopflag = 1 
            bolddist(f12) = olddist(f12) 
            f(f12,5) = f(f12,6) 
          end 
        repeat 
        if delta = 0 
          if justflag > 0 
            ++syscnt 
            sysbarpar(syscnt,1) = barcount 
            sysbarpar(syscnt,2) = 0 
            sysbarpar(syscnt,5) = sys_jflag 
          end 
          goto CG 
        end 

        if sysbarpar(syscnt+1,3) = barcount and barcount > 0 
          loop for f12 = 1 to f11 
            bolddist(f12) = olddist(f12) 
            f(f12,5) = f(f12,6) 
          repeat 
          goto CE 
        end 

        if stopflag = 1 
          goto CCE 
        end 
        marc = 0 
        goto CF 
&dA 
&dA &d@   This is where the program jumps back to get another measure 
&dA 
&dA                                                                  

&dA                                                                  
&dA 
&dA &d@   At this point, we have added too much music to a line (ldist > false_rmarg)
&dA 
&dA &d@   Provisional transfer of marr to larr (to text "squeezing") 
&dA 
CK: 
        larc2 = larc 
        loop for t9 = 1 to marc 
          ++larc2 
          loop for t10 = 1 to MARR_PARS 
            larr(larc2,t10) = marr(t9,t10) 
          repeat 
        repeat 

&dA 
&dA &d@  III. Compute new distances  
&dA 
&dA &d@    Compute new distances for object nodes on a line.  This 
&dA &d@    is where we determine how to right justify the line.  It 
&dA &d@    is also where we decide whether or not to "squeeze" 
&dA &d@    an extra measure onto the line or not.  
&dA 
&dA &d@    larc = number of object-nodes on the line   
&dA &d@    larc2 = number of object-nodes on extended line   
&dA 
&dA &d@   A. General calculations:  Identify shortest duration in       
&dA &d@        extended line and determine quantity and location        
&dA &d@        of smallest distances                                    
&dA 
&dA &d@      First, we need to know how many barlines are in this line 
&dA &d@        of music.  Specifically, if there is only one, then we 
&dA &d@        must allow space modifications irrespective of whether 
&dA &d@        a print suggestion asked that there be none.  
&dA 
        c2 = 0 
        single_meas = NO 
        loop for c1 = 1 to larc2 
          if larr(c1,MNODE_TYPE) = 18 
            ++c2 
          end 
        repeat 
        if c2 = 1 
          single_meas = YES 
        end 

        a1 = larc2 
        a2 = 0 
        perform getsmall (t5,t11,delta_e,mdf) 

        if single_meas = NO 
          loop for c1 = 1 to scnt2 
            small(c1) = small2(c1) 
          repeat 
          scnt = scnt2 
        end 
&dA 
&dA &d@   B. If there is no text, determine shortest adjustable distance         
&dA &d@        between notes and the number of notes that have this distance.    
&dA &d@        If an additional measure can be accommodated by decreasing        
&dA &d@        this distance by x%, then this should be done.                    
&dA 
        if textflag = 0 
*  scnt = number of notes with smallest distance   

          t2 = t5 * scnt / 15       /* allows for about 6.6% compression 
          t3 = ldist - rmarg 
          if t3 <= t2 and t3 > 0 
            savet3 = t3 
&dA 
&dA &d@      &dETry&d@ to accommodate additional measure by compressing shortest notes 
&dA 
            ++barcount 
            rflag(barcount) = 0 
            larc = larc2 
            loop for f12 = 1 to f11 
              bolddist(f12) = olddist(f12) 
              f(f12,5) = f(f12,6) 
            repeat 
&dA 
&dA &d@  small(.) contains the node numbers where the distance may be decreased 
&dA &d@  scnt = number of candidate nodes 
&dA &d@  t5 = shortest distance 
&dA &d@  t1 = alternation flag for deleting space in type-40 syncopated pairs 
&dA &d@  t2 = distance subtraction flag 
&dA &d@  t3 = distance to subtract 
&dA 
            t1 = 0 
            t2 = 0 
            loop 
              t10 = 1 
              loop for t9 = 2 to larc 
                if t9 = small(t10) 
                  if t10 < scnt 
                    ++t10 
                  end 
                  if larr(t9-1,MNODE_TYPE) < 40 
                    if larr(t9,PRE_DIST) > t5 
                      t2 = 1 
                    else 
                      goto CPB 
                    end 
                    --larr(t9,PRE_DIST) 
                  else 
                    if t2 = 0 
                      goto CPB 
                    end 
                    if t1 = 0 
                      --larr(t9,PRE_DIST) 
                    else 
                      --larr(t9-1,PRE_DIST) 
                    end 
                  end 
                  --t3 
                  if t3 = 0                       /* Success!  Go lay out music at CG
                    if justflag > 0 
                      ++syscnt 
                      sysbarpar(syscnt,1) = barcount 
                      sysbarpar(syscnt,2) = 0 - savet3 
                      sysbarpar(syscnt,5) = sys_jflag 
                    end 
                    goto CG 
                  end 
                end 
CPB:          repeat 
              if t1 = 0 
                t1 = 1 
              else 
                t1 = 0 
              end 
              if t2 = 0 
                --t5 
                t2 = 1 
              else 
                t2 = 0 
              end 
            repeat 
          end 
        end 
&dA 
&dA &d@     Since the effort to squeeze an extra measure onto a line has 
&dA &d@     failed at this point, we must restore the earlier values of 
&dA &d@     f(.,10), which were advanced when we added the bar line to 
&dA &d@     the last (prospective) measure.  
&dA 
CCE: 
        loop for f12 = 1 to f11 
          f(f12,10) = tarr3(f12) 
        repeat 

        --mcnt              /* delete length from list 

&dA 
&dA &d@   If f2 = 1, then we tried unsuccessfully to add an extra measure  
&dA &d@        of general rest.  We must now add a larr entry for the  
&dA &d@        terminating bar line  
&dA 
        if f2 = 1 
          ++larc 
          larr(larc,MNODE_TYPE)  = 18                 /* New &dA05/25/03&d@ 
          larr(larc,ACT_FLAG)    = 0xffffffff         /*  "     " 
          larr(larc,M_ADJ)       = adj_space          /*  "     " 
        end 

&dA &d@  
&dA &d@   C. Assign delta (extra space) to various nodes within line.    
&dA &d@                                                                  
&dA &d@      a. Try to assign delta to multiple measure rests or whole   
&dA &d@           measure rests                                          
&dA &d@  
CE: 
        if justflag > 0 
          ++syscnt 
          sysbarpar(syscnt,1) = barcount 
          sysbarpar(syscnt,2) = delta 
          sysbarpar(syscnt,5) = sys_jflag 
        end 
&dA 
&dA &d@   Look for multiple measure rests 
&dA 
        if f11 = 1 
          t12 = 0 
          loop for c1 = 1 to larc 
            if larr(c1,MARR_TEMP) = 1 
              ++t12 
            end 
          repeat 
          if t12 > 0 
            t1 = delta / t12 + 1 
            if t1 <= MAGIC1 
              loop for c1 = 1 to larc 
                if larr(c1,MARR_TEMP) = 1 
                  if t1 > delta 
                    t1 = delta 
                  end 
                  larr(c1,PRE_DIST) += t1 
                  delta -= t1 
                end 
              repeat 
              goto CG 
            else 
              t1 = MAGIC1 
              if t1 > delta                 /* should never happen, but just to be safe
                t1 = delta 
              end 
              loop for c1 = 1 to larc 
                if larr(c1,MARR_TEMP) = 1 
                  larr(c1,PRE_DIST) += t1 
                  delta -= t1 
                end 
              repeat 
            end 
          end 
        end 
&dA 
&dA &d@   Look for single measure rests 
&dA 
        if f11 = 1 
          t12 = 0 
          loop for c1 = 1 to larc 
            if larr(c1,MARR_TEMP) = 2 
              ++t12 
            end 
          repeat 
          if t12 > 0 
            t1 = delta / t12 + 1 
            t2 = hxpar(6) * 4 / barcount 
            if t1 > t2 
              t1 = t2 
            end 
            loop for c1 = 1 to larc 
              if larr(c1,MARR_TEMP) = 2 
                if t1 > delta 
                  t1 = delta 
                end 
                larr(c1,PRE_DIST) += t1 
                delta -= t1 
                if delta = 0 
                  goto CG 
                end 
              end 
            repeat 
          end 
        end 

        t12 = 0 
        loop for t10 = 1 to barcount 
          if rflag(t10) > 0 
            ++t12 
          end 
        repeat 
        if t12 > 0 
          t1 = delta / t12 + 1 
          t2 = hxpar(6) * 2 / barcount 
          if t1 > t2 
            t1 = t2 
          end 
          loop for t10 = 1 to barcount 
            if rflag(t10) > 0 
              if t1 > delta 
                t1 = delta 
              end 
              rflag(t10) += t1 
              delta -= t1 
              if delta = 0 
                goto CG 
              end 
            end 
          repeat 
        end 
&dA &d@                                                             
&dA &d@      b. Try to assign delta to notes larger than smallest   
&dA 
&dA &d@    1. construct adjarr, compute maximum possible adjustment  
&dA 
&dA &d@    We need to know how many barlines are in this line of music.  
&dA &d@    Specifically, if there is only one, then we must allow space 
&dA &d@    modifications irrespective of whether a print suggestion asked 
&dA &d@    that there be none.  
&dA 
        c2 = 0 
        single_meas = NO 
        loop for c1 = 1 to larc 
          if larr(c1,MNODE_TYPE) = 18 
            ++c2 
          end 
        repeat 
        if c2 = 1 
          single_meas = YES 
        end 

        a1 = larc 
        a2 = 1 
        perform getsmall (t5,t11,delta_e,mdf) 

        if single_meas = NO 
          loop for c1 = 1 to scnt2 
            small(c1) = small2(c1) 
          repeat 
          scnt = scnt2 
        end 
&dA 
&dA &d@  t11 = ntype for shortest node on line 
&dA &d@  t5  = smallest standard internode distance 
&dA 
&dA &d@    Smallest standard internode distance is sometimes not relevent, especially
&dA &d@    in the case where there is text underlay.  Let us also look at the median 
&dA &d@    of the distances for the shortest node on the line 
&dA 
        t10 = 0 
        loop for t9 = 1 to larc - 1 
          if larr(t9,MNODE_TYPE) = t11 
            ++t10 
            adjarr(t10,1) = larr(t9+1,PRE_DIST) 
          end 
        repeat 
        a1 = t10 
        loop for t9 = 1 to a1 - 1 
          loop for t10 = t9 + 1 to a1 
            if adjarr(t9,1) < adjarr(t10,1) 
              t3 = adjarr(t9,1) 
              adjarr(t9,1) = adjarr(t10,1) 
              adjarr(t10,1) = t3 
            end 
          repeat 
        repeat 
        a1 = a1 + 1 >> 1 
        t7 = adjarr(a1,1) 
        if t7 > (t5 * 5 / 4) 
          t5 = t7 
        end 

        adjarc = 0 
        if t11 > 6 
          t1 = t11 + 1 
        else 
          t1 = t11 
        end 

        loop for t9 = 2 to larc 
          if larr(t9,MNODE_TYPE) = 18 and larr(t9-1,MNODE_TYPE) < t1 
            goto CD 
          end 
          if larr(t9,TIME_NUM) > 0 
            dv3 = larr(t9,TIME_NUM) * 10 / mdf 
            if dv3 > 10 
&dA 
&dA &d@     Code modification &dA12/11/03&d@ 
&dA 
&dA &d@     Note &dA04/12/10&d@ The code below is ridiculous and absurd and is 
&dA &d@       being replaced by some "magic" numbers that do the same thing.  
&dA 
&dK &d@             rx = flt(dv3) 
&dK &d@             rx = rx / 10.0 
&dK &d@             ry = lnx(rx) / lnx(2.0) 
&dK &d@             rz = pow(1.5,ry) 
&dK &d@             rz *= 10.0 
&dK &d@             dv3 = fix(rz) 

              if dv3 < 80 
                c18 = dv3 - 10 + 1 
                c19 = ors("AABBCCDDEEFFFGGHHHIIJJJKKKLLLMMMNNNOOOPPPPQQQRRRRSSSTTTTUUUUVVVVWWWWXX"{c18}) - 55
              else 
                if dv3 < 515 
                  c18 = dv3 - 75 / 10 + 1 
                  c19 = ors("!$&(*,.024679;<>@ACDFGIJKMNPQRSUVWYZ[\]_`abc"{c18})
                else 
                  c19 = dv3 - 515 / 10 + 100 
                end 
              end 
              dv3 = c19 
&dA      

              t3 = dv3 * t5 / 10                 /* maximum final distance 
&dA 
&dA &d@   Case: node is preceded by adjustable distance (larr(i,TIME_NUM) > 0);      
&dA &d@         duration preceding node (larr(i,TIME_NUM)) is greater than min. dur. 
&dA &d@         t3 = amount by which duration may be increased  
&dA 
              if t3 > 0 
                if larr(t9,M_ADJ) = YES 
                  ++adjarc 
                  adjarr(adjarc,1) = t9 
                  adjarr(adjarc,2) = t3 
                  adjarr(adjarc,3) = 0 
                end 
              end 
            end 
          end 
CD: 
        repeat 
&dA 
&dA &d@    2. compute adjarr(.,3) = current largest distance for nodes similar to this one.
&dA 
&dA &d@    First, determine maximum PRE_DIST for each TIME_NUM 
&dA 
        t4 = 0 
        loop for t9 = 1 to adjarc 
          t1 = adjarr(t9,1) 
          t2 = larr(t1,PRE_DIST) 
          t3 = larr(t1,TIME_NUM) 
          t10 = 0 
          if t4 > 0 
            loop for t10 = 1 to t4 
              if tarr5(t10,1) = t3 
                if tarr5(t10,2) < t2 
                  tarr5(t10,2) = t2 
                end 
                t10 = 1000 
              end 
            repeat 
          end 
          if t10 < 1000 
            ++t4 
            tarr5(t4,1) = t3 
            tarr5(t4,2) = t2 
          end 
        repeat 
&dA 
&dA &d@    Second, sort by increasing TIME_NUM, smallest first 
&dA 
        loop for t9 = 1 to t4 - 1 
          loop for t10 = t9 + 1 to t4 
            if tarr5(t9,1) > tarr5(t10,1) 
              t3 = tarr5(t9,1) 
              tarr5(t9,1) = tarr5(t10,1) 
              tarr5(t10,1) = t3 
              t3 = tarr5(t9,2) 
              tarr5(t9,2) = tarr5(t10,2) 
              tarr5(t10,2) = t3 
            end 
          repeat 
        repeat 
&dA 
&dA &d@    Third, make sure that increasing TIME_NUM has increasing distance 
&dA 
        loop for t9 = 1 to t4 - 1 
          t1 = tarr5(t9,2) * 5 / 4 
          if tarr5(t9+1,2) < t1 
            tarr5(t9+1,2) = t1 
          end 
        repeat 
&dA 
&dA &d@    Fourth, assign the various maximums to their respective adjarr(.,3) 
&dA 
        loop for t9 = 1 to adjarc 
          t1 = adjarr(t9,1) 
          t2 = larr(t1,TIME_NUM) 
&dA 
&dA &d@   &dA07/14/04&d@  The code below appears to contain a minor bug.  It appears to be
&dA &d@             possible for tarr5(.,2) = 0, in which case, adjarr(.,3) should also
&dA &d@             be zero.  I think the purpose of the test condition below the loop 
&dA &d@             is to flag the case where &dEno match&d@ was found in the loop, in which
&dA &d@             case adjarr(.,3) would also be zero.  We need to have another way
&dA &d@             to flag this condition.  
&dA 
          t12 = 0                              /* new test flag 
          loop for t10 = 1 to t4 
            if tarr5(t10,1) = t2 
              adjarr(t9,3) = tarr5(t10,2) 
              t12 = 1 
            end 
          repeat 

&dA     &d@ End of &dA07/14/04&d@ code change 

        repeat 

&dA                                                    
&dA 
&dA &d@     &dA11/06/08&d@  There is a corner case I don't understand yet.  It can result 
&dA &d@               in delta being 0 at this point, which leads to code failure.
&dA &d@               To avoid this, I include the following code.  The problem 
&dA &d@               of the corner case still exists, however.  
&dA 
        if delta = 0 
          goto CG 
        end 
&dA 
&dA                                                    


        t12 = 0 
        loop for t9 = 1 to adjarc 
          t1 = adjarr(t9,1)                        /* larr index for t9-th adjarr element
          t12 += (adjarr(t9,3) - larr(t1,PRE_DIST)) 
        repeat 
&dA &d@            
&dA &d@    3. determine adjarr(.,4) = distances to add to bring all nodes 
&dA &d@                                 up to the "largest in class" 
&dA 
        if t12 < delta 
          t12 = delta 
        end 
        t7 = delta 
        loop for t9 = 1 to adjarc 
          t1 = adjarr(t9,1)                        /* larr index for t9-th adjarr element
          dvar1 = (adjarr(t9,3) - larr(t1,PRE_DIST)) * t7 / t12 
          adjarr(t9,4) = dvar1 
          delta -= dvar1 
        repeat 
        loop for t9 = 1 to adjarc 
          if delta = 0 
            t9 = adjarc 
          else 
            ++adjarr(t9,4) 
            --delta 
          end 
        repeat 
&dA &d@            
&dA &d@    4. if delta is still > 0, try increasing adjarr(.,4) up to allowed maximum
&dA 
        if delta > 0 
          t12 = 0 
          loop for t9 = 1 to adjarc 
            t1 = adjarr(t9,1)                        /* larr index for t9-th adjarr element
            t2 = (adjarr(t9,2) - larr(t1,PRE_DIST) - adjarr(t9,4)) 
            if t2 > 0 
              t12 += t2 
            end 
          repeat 

          if t12 < delta 
            t12 = delta 
          end 
          t7 = delta 
          loop for t9 = 1 to adjarc 
            t1 = adjarr(t9,1)                        /* larr index for t9-th adjarr element
            t2 = (adjarr(t9,2) - larr(t1,PRE_DIST) - adjarr(t9,4)) 
            if t2 > 0 
              dvar1 = t2 * t7 / t12 
              adjarr(t9,4) += dvar1 
              delta -= dvar1 
            end 
          repeat 
          loop for t9 = 1 to adjarc 
            if delta = 0 
              t9 = adjarc 
            else 
              ++adjarr(t9,4) 
              --delta 
            end 
          repeat 
        end 
&dA 
&dA &d@    5. add distance   
&dA 
        loop for t9 = 1 to adjarc 
          t7 = adjarr(t9,1) 
          larr(t7,PRE_DIST) += adjarr(t9,4)             /* New &dA12/11/03&d@ 
        repeat 
        if delta = 0 
          goto CG 
        end 

&dA &d@                                                         
&dA &d@      c. Assign distance to smallest notes               
&dA &d@   
&dA &d@       small(.) = node numbers where distance can be added 
&dA &d@       scnt = number of such nodes 
&dA &d@       t1 = alternation flag for incerting space in type 40 syncopated nodes
&dA &d@       t2 = addition flag 
&dA &d@       t5 = smallest internote distance 
&dA &d@       delta_e = difference between smallest distance and next smallest distance
&dA &d@       delta = distance to subtract 
&dA 
        t1 = 0 
        t2 = 0 
        t12 = delta_e + 1 / 2                           /* New &dA10/14/07&d@ 
        if t12 < 3 
          t12 = 3 
        end 

        if scnt > 0 
          loop for t7 = 1 to t12          /* Limit to loop is new &dA10/14/07&d@ 
            t10 = 1 
            loop for t9 = 2 to larc 
              if t9 = small(t10) 
                if t10 < scnt 
                  ++t10 
                end 
                if larr(t9-1,MNODE_TYPE) < 40            /* New &dA05/25/03&d@ 
                  if larr(t9,PRE_DIST) > t5              /*  "     " 
                    goto CPE 
                  else 
                    t2 = 1 
                  end 
                  ++larr(t9,PRE_DIST)                    /* New &dA05/25/03&d@ 
                else 
                  if t2 = 0 
                    goto CPE 
                  end 
                  if t1 = 0 
                    ++larr(t9,PRE_DIST)                  /* New &dA05/25/03&d@ 
                  else 
                    ++larr(t9-1,PRE_DIST)                /* New &dA05/25/03&d@ 
                  end 
                end 
                --delta 
                if delta = 0 
                  goto CG 
                end 
              end 
CPE:        repeat 
            if t1 = 0 
              t1 = 1 
            else 
              t1 = 0 
            end 
            if t2 = 0 
              t2 = 1 
              ++t5 
            else 
              t2 = 0 
            end 
          repeat 
        end 
&dA &d@                                                        
&dA &d@      d. Assign remaining distance wherever you can     
&dA 
        loop 
          loop for t9 = 2 to larc 
            if larr(t9,TIME_NUM) > 0                   /* New &dA05/25/03&d@ 
              ++larr(t9,PRE_DIST)                      /*  "     " 
              --delta 
              if delta = 0 
                goto CG 
              end 
            end 
          repeat 
        repeat 

&dA 
&dA &d@ &dEÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿&d@ 
&dA &d@ &dE³                                                            ³&d@ 
&dA &d@ &dE³ Distances are computed.  Now it is time to read the        ³&d@ 
&dA &d@ &dE³ file the second time and typeset the music                 ³&d@ 
&dA &d@ &dE³                                                            ³&d@ 
&dA &d@ &dE³               PRINT OUT THE MUSIC                          ³&d@ 
&dA &d@ &dEÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ&d@ 
&dA 
&dA &d@   Compute offsets for bar lines and values of larc for bar lines 
&dA 
&dA &d@         barcount = number of bars in a line  
&dA &d@         barpar(.,1) = horizontal length of measure 
&dA &d@         barpar(.,2) = value of larc2 for bar-node at end of measure  
&dA &d@         barpar(.,3) = bar type (ntype) at end of measure 
&dA 
&dA &d@     &dA12/17/03&d@ 
&dA 
&dA &d@     At this point, the larr(larc,.) array is fixed and ready for 
&dA &d@     use.  
&dA 
&dA &d@     New &dA11/02/07&d@.  We need to correct a "corner" case here.  When the last item
&dA &d@       object in a line is a key change or a time change, the program places this
&dA &d@       beyond the end of the line.  I'm not sure why this happens, and it would be
&dA &d@       complicated to try to fix.  But there is an easy solution here.  Simply 
&dA &d@       figure out the space needed, and subtract it from the various larr nodes.
&dA &d@       While we are at it, the distance between the last bar line and the time
&dA &d@       change is sometimes excessive.  So let's set this to the standard distance
&dA &d@       as well.  Keep an eye on this change, however; there may be exceptions to
&dA &d@       this fix.  
&dA 
CG: 
        t10 = 0 
        loop for t9 = 1 to larc 
          t10 += larr(t9,PRE_DIST) 
        repeat 
        if chr(larr(larc,MNODE_TYPE)) in [14..16] 
          t9 = rmarg - false_rmarg 
          if larr(larc,MNODE_TYPE) = 15 
            t9 -= (hxpar(5) / 2) 
          end 
          if larr(larc,MNODE_TYPE) = 16 
            t9 -= (hxpar(13) / 2) 
          end 
          if larr(larc,PRE_DIST) > hxpar(7) and larr(larc-1,MNODE_TYPE) = 18
            t6 = larr(larc,PRE_DIST) - hxpar(7) 
            if t6 > t9 
              t6 = t9 
            end 
            larr(larc,PRE_DIST) -= t6 
            t9 -= t6 
          end 

          t6 = t9 
          t3 = 7 
          loop 
            loop for t7 = 2 to larc 
              t11 = larr(t7,PRE_DIST) * t9 * 10 / t10 
              if t11 < 10 and t11 > t3 
                t11 = 10 
              end 
              t11 /= 10 
              if rem > 5 
                ++t11 
              end 
              larr(t7,PRE_DIST) -= t11 
              t6 -= t11 
              if t6 <= 0 
                goto END_CORRECT 
              end 
            repeat 
            --t3 
          repeat 
        end 
END_CORRECT: 
&dA 
&dA &d@     &dA12/17/03&d@ 
&dA 
&dA &d@     At this point, the cumulative larr array can be initialized.  
&dA &d@              
        if endflag = 1 and justflag <> 1 
          c4 = ldist - sp - pdist 
        else 
          c4 = syslen - pdist 
        end 

        mspace(mcnt) += deadspace * 100000 

        if endflag = 1 and justflag <> 1 
          t9 = ldist - sp 
        else 
          t9 = syslen 
        end 
        if justflag < 2 
          sv_mainyp = mainyp 
          ++mainyp 
          y1p = mainyp 
          tput [Y,mainyp] S 0 ~sp  ~sysy  ~t9  ~sysh  ~f11  "~syscode " 
        end 

        loop for t9 = 1 to barcount 
          barpar(t9,3) = 0 
        repeat 
&dA 
&dA &d@   First handle special case of entire system of rests 
&dA 
        if larc = 0 
          loop for t9 = 1 to barcount 
            barpar(t9,1) = rflag(t9) 
            barpar(t9,2) = 1 
          repeat 
          goto CG2 
        end 
&dA 
&dA &d@   Normal case: notes in at least one part in system 
&dA 
        larc2 = 1 
        t4 = 0 
&dA 
&dA &d@   Handle special case of beginning of piece 
&dA 
        if f(1,4) = 2 
          loop for t10 = larc2 to larc 
            if larr(t10,SNODE) = 6913 and larr(t10,MNODE_TYPE) <> 18 
              t4 += larr(t10,PRE_DIST) 
            else 
              larc2 = t10 
              goto CG4 
            end 
          repeat 
        end 
CG4: 
        loop for t9 = 1 to barcount 
          if rflag(t9) > 0 
            barpar(t9,1) = rflag(t9) + t4 
            barpar(t9,2) = larc2 
            t4 = 0 
          else 
            if t9 > 1 and rflag(t9-1) > 0 
              ++larc2 
            end 
            t3 = 0 
            loop for t10 = larc2 to larc 
&dA 
&dA &d@  Exit sequence:  either you run out of 6913 nodes, or you hit another  
&dA &d@                  bar line (i.e. with a multiple rest in between).  
&dA 
              if t3 = 1 
                if larr(t10,SNODE) <> 6913 
                  larc2 = t10 
                  goto CG3 
                else 
                  if larr(t10,MNODE_TYPE) = 18 
                    larc2 = t10 
                    goto CG3 
                  end 
                end 
              end 
* 
              t4 += larr(t10,PRE_DIST) 
              if larr(t10,MNODE_TYPE) = 18 and larr(t10,SNODE) = 6913 
                t3 = 1 
                barpar(t9,2) = t10 
                barpar(t9,1) = t4 
                t4 = 0 
              end 
            repeat 
          end 
CG3: 
        repeat 
&dA 
&dA &d@   Reset record pointers, set up second whole measure rest array  
&dA &d@ 
CG2: 
        loop for f12 = 1 to f11 
          f(f12,6) = f(f12,4) 
          f(f12,11) = f(f12,7) 
        repeat 

        if justflag > 0 
          sysbarpar(syscnt,4) = sysbarpar(syscnt,2) + barpar(barcount,1) 
        end 
&dA 
&dA &d@    If f13 = 0 (and justflag < 2), check to see if part names 
&dA &d@    need to be backed up.  Compute pn_left 
&dA 
        if f13 = 0 and justflag < 2 and f11 > 1 
          c1 = 0 
          loop for f12 = 1 to f11 
            notesize = f(f12,14) 
            rec = f(f12,1) 
            tget [Z,rec] line 
            if line <> "" 
              if line{1} = "!" 
                temp = line{2,2} 
                line = line // pad(4) 
                line = line{4..} 
              else 
                temp = chs(mtfont) 
              end 
              c5 = int(temp) 
              perform spacepar (c5) 
              if len(line) <= NAMELEN 
                line = trm(line) 
                c2 = 0 
                loop for c3 = 1 to len(line) 
                  c2 += spc(ors(line{c3})) 
                repeat 
                if c1 < c2 
                  c1 = c2 
                end 
              else 
                line = line // " " 
                t10 = 0 
FLL: 
                t7 = 0 
                loop for t11 = 1 to len(line) 
                  if line{t11} = " " 
                    if t11 > NAMELEN 
                      if t7 > 0 
                        t11 = t7 
                      end 
                      ++t10 
                      linepiece(t10) = trm(line{1,t11}) 
                      line = mrt(line{t11..}) 
                      goto FLL 
                    else 
                      t7 = t11 
                    end 
                  end 
                repeat 
                line = trm(line) 
                if len(line) > 0 and t10 < 5 
                  ++t10 
                  linepiece(t10) = line 
                end 
                loop for t11 = 1 to t10 
                  c2 = 0 
                  loop for c3 = 1 to len(linepiece(t11)) 
                    c2 += spc(ors(linepiece(t11){c3})) 
                  repeat 
                  if c1 < c2 
                    c1 = c2 
                  end 
                repeat 
              end 
            end 
          repeat 

          c2 = maxnotesize << 1 
          if c1 > hxpar(9) - c2 
            pn_left = c1 - hxpar(9) + c2 
          else 
            pn_left = 0 
          end 
        end 

&dA 
&dA &d@   Loop through parts one at a time and print out.  Set delta 
&dA &d@      to total number of bars for this line.  We will use barcount 
&dA &d@      as the exit indicator for each part.  
&dA 
&dA &d@   There are certain variables which are used only to print parts.  
&dA &d@     The variables and their storage locations are listed below.  
&dA 
&dA &d@           Variable 
&dA &d@          ÄÄÄÄÄÄÄÄÄÄ 
&dA &d@           superpnt(32,N_SUPER) 
&dA &d@           supermap(32,N_SUPER) 
&dA &d@           superdata(32,N_SUPER,SUPERSIZE) 
&dA &d@           drec(32) 
&dA &d@           savenoby(32) 
&dA &d@           nuxstop(32) 
&dA &d@           dxoff(32) 
&dA &d@           dyoff(32) 
&dA &d@           uxstart(32) 
&dA &d@           backloc(32) 
&dA &d@           xbyte(32) 
&dA 
        delta = barcount 
        loop for f12 = 1 to f11 
          if justflag < 2        /* Fixing a bug in the TAKEOUT system  &dA12/22/05
            type1_dflag(f12) = save_type1_dflag(f12) 
            type2_dflag(f12) = save_type2_dflag(f12) 
          end 
          t9 = f(f12,15) 
          lbyte = "Ll"{t9} 

          notesize = f(f12,14) 
          firstbarflag = 0 
          dxoff(f12) = 10000 
&dA 
&dA &d@    a. Set up Line record.  If f13 = 0, put objects for instrument      
&dA &d@       names; else, print clef, key, time-sig and other information.    
&dA 
          t9 = sq(f12) - sysy 
          if f13 = 0 
            xbyte(f12)    = "**********"{1,f(f12,13)} 
            if justflag < 2 
              ++mainyp 
#if CONTINUO 
              tput [Y,mainyp] ~lbyte  ~t9  ~f(f12,9)  0 0 0 ~xbyte(f12)  ~vst(f12)  ~f(f12,14)  -200
#else 
              tput [Y,mainyp] ~lbyte  ~t9  ~f(f12,9)  0 0 0 ~xbyte(f12)  ~vst(f12)  ~f(f12,14)  0
#endif 
            end 
&dA 
&dA &d@       print instrument name 
&dA 
            if f11 > 1 
              rec = f(f12,1) 
              tget [Z,rec] line 
              if line <> "" 
                if line{1} = "!" 
                  temp = line{2,2} 
                  line = line // pad(4) 
                  line = line{4..} 
                else 
                  temp = chs(mtfont) 
                end 
                x = 0 - hxpar(9) - pn_left 
                if len(line) <= NAMELEN 
                  y = mvpar(f12,6) 
                  if justflag < 2 
                    ++mainyp 
                    tput [Y,mainyp] J D 0 ~x  ~y  1 6913 0 0 
                  end 
                  line = trm(line) 
                  if justflag < 2 
                    ++mainyp 
                    tput [Y,mainyp] W 0 0 ~temp  ~line 
                  end 
                else 
                  y = mvpar(f12,9) 
                  line = line // " " 
                  t10 = 0 
FIXLINE: 
                  t7 = 0 
                  loop for t11 = 1 to len(line) 
                    if line{t11} = " " 
                      if t11 > NAMELEN 
                        if t7 > 0 
                          t11 = t7 
                        end 
                        ++t10 
                        y -= mvpar(f12,3) 
                        linepiece(t10) = trm(line{1,t11}) 
                        line = mrt(line{t11..}) 
                        goto FIXLINE 
                      else 
                        t7 = t11 
                      end 
                    end 
                  repeat 
                  line = trm(line) 
                  if len(line) > 0 and t10 < 5 
                    ++t10 
                    y -= mvpar(f12,3) 
                    linepiece(t10) = line 
                  end 
                  if justflag < 2 
                    ++mainyp 
                    tput [Y,mainyp] J D 0 ~x  ~y  ~t10  6913 0 0 
                  end 
                  y = 0 
                  loop for t11 = 1 to t10 
                    if justflag < 2 
                      ++mainyp 
                      tput [Y,mainyp] W 0 ~y  ~temp  ~linepiece(t11) 
                    end 
                    y += mvpar(f12,6) 
                  repeat 
                end 
              end 
            end 
          else 
            if justflag < 2 
              ++mainyp 
              xx(1) = f(f12,9) 
              xx(2) = dyoff(f12) 
              xx(3) = uxstart(f12) 
              xx(4) = backloc(f12) 
              xx(5) = vst(f12) 
              xx(6) = f(f12,14) 
#if CONTINUO 
              tput [Y,mainyp] ~lbyte  ~t9  ~xx(1)  ~xx(2)  ~xx(3)  ~xx(4)  ~xbyte(f12)  ~xx(5)  ~xx(6)  -200
#else 
              tput [Y,mainyp] ~lbyte  ~t9  ~xx(1)  ~xx(2)  ~xx(3)  ~xx(4)  ~xbyte(f12)  ~xx(5)  ~xx(6)  0
#endif 
&dA 
&dA &d@      This code added &dA01/06/04&d@ to implement abbreviated part names 
&dA 
              c4 = f(f12,6) 
              c2 = recflag(c4) & 0xff 
              if c2 > 0 
                temp = abbr(c2) 
                c5 = int(temp) 
                temp = temp{sub..} 
                temp = mrt(temp) 
&dA 
&dA &d@      New &dA01/29/09&d@: Adding code to deal with grand staff 
&dA 
                c7 = 0 
                temp = temp // pad(4) 
                if temp{1,3} = "(g)"           /* special case of grand staff
                  c7 = vst(f12) >> 1 
                  temp = temp{4..} 
                end 
                temp = trm(temp) 

                perform spacepar (c5) 
                if temp con "/" 
                  temp2 = temp{mpt+1..} 
                  temp  = temp{1,mpt-1} 
                else 
                  temp2 = "" 
                end 
                c2 = 0 
                loop for c3 = 1 to len(temp) 
                  if temp{c3} = "_" 
                    temp{c3} = " " 
                  end 
                  if temp{c3,2} = "\0" 
                    ++c3 
                  else 
                    c2 += spc(ors(temp{c3})) 
                  end 
                repeat 
                c4 = 0 
                if temp2 <> "" 
                  loop for c3 = 1 to len(temp2) 
                    if temp2{c3} = "_" 
                      temp2{c3} = " " 
                    end 
                    if temp2{c3,2} = "\0" 
                      ++c3 
                    else 
                      c4 += spc(ors(temp2{c3})) 
                    end 
                  repeat 
                end 
                if c4 > c2 
                  c2 = c4 
                end 

                c4 = notesize * 3 + c7              /* c7 is New &dA01/29/09&d@ 

                c3 = maxnotesize << 1 
                c2 += c3 
                ++mainyp 
                if temp2 = "" 
                  tput [Y,mainyp] J D 0 -~c2  ~c4  1 6913 0 0 
                  ++mainyp 
                  tput [Y,mainyp] W 0 0 ~c5  ~temp 
                else 
                  c7 = 0 
                  loop while temp2{1} = " " 
                    c7 += spc(32) 
                    temp2 = temp2{2..} 
                  repeat 

                  c6 = c4 >> 1 
                  tput [Y,mainyp] J D 0 -~c2  ~c4  1 6913 0 0 
                  ++mainyp 
                  tput [Y,mainyp] W 0 -~c6  ~c5  ~temp 
                  ++mainyp 
                  tput [Y,mainyp] J D 0 -~c2  ~c4  1 6913 0 0 
                  ++mainyp 
                  tput [Y,mainyp] W ~c7  ~c6  ~c5  ~temp2 
                end 
              end 
            end 

&dA                         
&dA 
&dA &d@   New &dA05/06/08&d@.  If the beginning of an ending superobject has been thrown over
&dA &d@                  to a new page, then a mark for this superobject must be placed
&dA &d@                  at the beginning of the line.  &dEclefkey&d@ is the best place to do
&dA &d@                  this.  The flags will be superdata(.,.,5) and superdata(.,.,7).
&dA &d@                  The magic number 123456 is used to signal an ending superobject,
&dA &d@                  and 2 is the value of superdata(.,.,5) which signals that the 
&dA &d@                  ending was thrown over from the previous measure.  supernum is
&dA &d@                  used as the flag for clefkey to typeset a mark.  
&dA 
            supernum = 0 
            loop for t10 = 1 to N_SUPER            /* N_SUPER is New &dA02/01/09
              if superdata(f12,t10,5) = 2 and superdata(f12,t10,7) = 123456 
                supernum = supermap(f12,t10) 
              end 

              if superdata(f12,t10,6) = 234567     /* New &dA06/09/08&d@ magic number for dashes
                superdata(f12,t10,7) = 1           /* New &dA06/09/08&d@ 
              end                                  /* New &dA06/09/08&d@ 

            repeat 
&dA 
&dA                         &d@  End of &dA05/06/08&d@ addition 

            perform clefkey  

&dA                        
&dA 
&dA &d@     New code &dA11/21/07&d@; Typeset directives thrown from previous systme 
&dA 
            if save_dircnt > 0 and justflag < 2 
              loop for c12 = 1 to save_dircnt 
                if save_direct(c12,1) = f12 
                  c13 = save_direct(c12,2) 
                  tget [Z,c13] line2 .t5 c14 c15 c16 c17 
                  if bit(1,c14) = 1 
                    goto LKJ01 
                  end 
                  if bit(2,c14) = 1 
                    goto LKJ01 
                  end 
                  if bit(3,c14) = 1 and f12 = f11 
                    goto LKJ01 
                  end 
                  goto LKJ02 
LKJ01: 
                  c11 = c13 - 1 
LKJ03: 
                  tget [Z,c11] line3 .t5 t6 t6 
                  if line3{1,3} <> "J B" and c11 > 1 
                    --c11 
                    goto LKJ03 
                  end 
                  t5 = c15 - t6           /* This is the horizontal offset (I think)
                  line2 = line2{1,4} // chs(c14) // " " // chs(t5) // " " // chs(c16) // " " // chs(c17) // " 6913 0 0"
                  ++c13 
                  tget [Z,c13] line3 
                  ++mainyp 
                  tput [Y,mainyp] ~line2 
                  ++mainyp 
                  tput [Y,mainyp] ~line3 

                end 
LKJ02: 
              repeat 
            end 
&dA 
&dA                        &d@  End of &dA11/21/07&d@ addition 

          end 
* 
&dA 
&dA &d@    b. Check for multiple rests running over from previous line.        
&dA &d@         Also initialize certain variables.                             
&dA 
          barnum = oldbarnum 
          larc2 = 0 
          rec = f(f12,6) 
          crec = 0 
          csnode = 6913 
          point = pdist 
          prev_point = point 
          point_adv = 0 
          oldmpoint = point 
          if f13 = 1 
            oldmp2 = point 
          else 
            oldmp2 = firstpt 
          end 

          last_jtype = " "               /* added &dA11/25/06&d@ 

          barcount = 0 
          if f(f12,11) > 0 
            rest7 = 0                    /* added &dA12/24/03&d@ 
&dA 
&dA &d@     This code was formerly the procedure "do_wholerests" 
&dA 
            loop 
              t1 = f(f12,12) 
              if t1 = 1                             /* t1 = 1 means don't print rest
                goto DOR_POINT1 
              end 
              x = point + oldmpoint + barpar(barcount+1,1) / 2 - notesize 
              y = mvpar(f12,4) 
              if t1 = 0 
                if justflag < 2 
                  ++mainyp 
                  if rest7 = 1                      /* added &dA12/24/03&d@ "Q" is an internal flag
                    tput [Y,mainyp] Q R 9 ~x  ~y  46 1 0 0 
                  else 
                    tput [Y,mainyp] J R 9 ~x  ~y  46 1 0 0 
                  end 
                end 
                goto DOR_POINT1 
              end 
              if justflag < 2 
                ++mainyp 
                if rest7 = 1                        /* added &dA12/24/03&d@ "Q" is an internal flag
                  tput [Y,mainyp] Q R 9 ~x  ~y  2 1 0 0 
                else 
                  tput [Y,mainyp] J R 9 ~x  ~y  2 1 0 0 
                end 
                ++mainyp 
                tput [Y,mainyp] K 0 0 46 
                ++mainyp 
                tput [Y,mainyp] K 0 ~vst(f12)  46 
              end 
DOR_POINT1: 
              ++barnum 
              --f(f12,11) 
              if f(f12,11) > 0 
                ++barcount 
                point = oldmpoint + barpar(barcount,1) 
                oldmpoint = point 
                oldmp2 = point 
                if barcount = delta 
                  f(f12,6) = rec 
                  return 
                end 
              end 
            repeat while f(f12,11) > 0 
&dA 
&dA                                    

            if barcount = delta 
              goto CW 
            end 
          end 
&dA 
&dA &d@    c. Process the data for each part.  Compute new x-position for all  
&dA &d@       objects.  Collect information on super objects; these may have   
&dA &d@       to be split at the end of line.  Determine where to stop looking 
&dA &d@       (this has turned out to be a problem area for this program).     
&dA 
          if justflag < 2 
            type1_dflag(f12)  = ON 
            type2_dflag(f12)  = OFF 
          end 
CZ: 
          tget [Z,rec] line .t3 jtype c2 c2 c2 c2 snode  
&dA 
&dA &d@    New code added &dA01/06/04&d@ to deal with line control flags 
&dA 
          if justflag < 2 
            c2 = recflag(rec) >> 8 
            if c2 <> 1 
              type1_dflag(f12) = OFF 
            end 
            if c2 = 2 
              type2_dflag(f12) = ON 
            end 
&dA 
&dA &d@      Fixing a bug in the TAKEOUT system  &dA12/22/05&d@ 
&dA 
            save_type1_dflag(f12) = type1_dflag(f12) 
            save_type2_dflag(f12) = type2_dflag(f12) 
          end 
&dA   
          ++rec 

          if line{1} = "Q" 
            goto CZ 
          end 
&dA 
&dA &d@ Process multiple rests and whole rests 
&dA 
          if line{1,3} = "J S" and "467" con line{5} and f11 > 1 
            --rec 
            perform save3                 /* oby not used here 
            ++rec 
&dA 
&dA &d@   a) check for underlines  
&dA 
            c9 = 0 
            loop for c8 = 1 to f(f12,13) 
              if f(f12,9) > 0 and "_,.;:!?" con xbyte(f12){c8} 
                if mpt > 1 
                  c9 = 1 
                end 
                y = sq(f12) + f(f12,9) 
                xbyte(f12){c8} = "*" 
              end 
            repeat 
&dA 
&dA &d@   b) process rest(s) 
&dA 
            if barcount = delta 
              f(f12,11) = 0 
              f(f12,6) = rec - 1 
              f(f12,5) = rec - 1 
              goto CW 
            end 
            rest7 = 0 
            if ntype = 4 
              f(f12,11) = snode 
            else 
              f(f12,11) = 1 
&dA 
&dA &d@     Added &dA12/24/03&d@ for optional staff lines 
&dA 
              if ntype = 7 
                rest7 = 1 
              end 
&dA   
            end 
            loop 
              tget [Z,rec] line 
              ++rec 
            repeat while line{1,3} <> "J B" 
            --rec 
&dA 
&dA &d@     This code was formerly the procedure "do_wholerests" 
&dA 
            loop 
              t1 = f(f12,12) 
              if t1 = 1                             /* t1 = 1 means don't print rest
                goto DOR_POINT2 
              end 
              x = point + oldmpoint + barpar(barcount+1,1) / 2 - notesize 
              y = mvpar(f12,4) 
              if t1 = 0 
                if justflag < 2 
                  ++mainyp 
                  if rest7 = 1                      /* added &dA12/24/03&d@ "Q" is an internal flag
                    tput [Y,mainyp] Q R 9 ~x  ~y  46 1 0 0 
                  else 
                    tput [Y,mainyp] J R 9 ~x  ~y  46 1 0 0 
                  end 
                end 
                goto DOR_POINT2 
              end 
              if justflag < 2 
                ++mainyp 
                if rest7 = 1                        /* added &dA12/24/03&d@ "Q" is an internal flag
                  tput [Y,mainyp] Q R 9 ~x  ~y  2 1 0 0 
                else 
                  tput [Y,mainyp] J R 9 ~x  ~y  2 1 0 0 
                end 
                ++mainyp 
                tput [Y,mainyp] K 0 0 46 
                ++mainyp 
                tput [Y,mainyp] K 0 ~vst(f12)  46 
              end 
DOR_POINT2: 
              ++barnum 
              --f(f12,11) 
              if f(f12,11) > 0 
                ++barcount 
                point = oldmpoint + barpar(barcount,1) 
                oldmpoint = point 
                oldmp2 = point 
                if barcount = delta 
                  f(f12,6) = rec 
                  return 
                end 
              end 
            repeat while f(f12,11) > 0 
&dA 
&dA                                                  

            if barcount = delta 
              goto CW 
            end 
            goto CZ 
          end 
&dA 
&dA &d@         O B J E C T S  
&dA &d@         ÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA 
&dA &d@  We must compute the new obx for this object.  To do this, we  
&dA &d@  will use the information the larr array.  We must be reminded   
&dA &d@  at this point about the kinds of nodes which are in the larr  
&dA &d@  array.  The larr array locates objects of type N,R,Q,F,I,B,K,T. 
&dA &d@  In addition, type C generates a larr node, if it follows a  
&dA &d@  B type node and has snode = 6913.  The value of snode for the   
&dA &d@  larr nodes in a particular measure is always non-decreasing.  
&dA &d@  In general, the value increases with each node.  Exceptions 
&dA &d@  are as follows:  1) At the end of a measure, there may be   
&dA &d@  several nodes with snode = 6913.  The first of these is   
&dA &d@  always a B type.  Those that follow may include C,K, and T  
&dA &d@  types in that order.  2) It can happen that there is a  
&dA &d@  non-controlling bar line in the middle of a measure.  In this 
&dA &d@  case, the bar line (B) will have the same larr(.,SNODE) value      (&dA05/25/03&d@)
&dA &d@  as the next node.  There can be several proper objects with 
&dA &d@  the same snode value in a node, e.g. F and N types are  
&dA &d@  commonly found together.  In this case, the type for the  
&dA &d@  node is the first time encountered in the part.  It is  
&dA &d@  important when reading the part to realize that there &dDwill not&d@  
&dA &d@  be a new larr node for each proper object encountered.  New 
&dA &d@  larr nodes are generated &dDonly&d@ by:  1) an advance in snode,  
&dA &d@  2) a type N,R,Q,F,I following a type B, when snode < 6913,  
&dA &d@  3) a C and/or K and/or T after a type B, when snode = 6913. 
&dA &d@  Grace notes (G), symbols (S), directives (D), and marks (M) 
&dA &d@  will always take their position from the proper object that 
&dA &d@  follows.  It still isn't clear to me whether marks or symbols 
&dA &d@  can have their own unique snode number.   
&dA 
&dA &d@  To sum all of this up, it is very important that the reading  
&dA &d@  and interpreting of objects in the intermediate file not get    
&dA &d@  out of phase with the nodes in larr.  If this happens, the  
&dA &d@  positions of objects will become messed up. 
&dA 
*  
          if line{1} = "J" 
            if jtype = "M" and snode = 10000 
              if (Debugg & 0x01) > 0 
                pute Error: Unexpected end of file for part ~f12 
              end 
              tmess = 44 
              perform dtalk (tmess) 
            end 
            --rec 
*  Get the remaining object related parameters 
            perform save3          /* oby will be used; it will be modified as needed
&dA 
&dA &d@  Compute the new obx.  
&dA 
&dA &d@    Case I: controlling bar line  
&dA 
&dA &d@      New &dA05/25/03&d@  Remove any measure print suggestions here (also &dA05/28/05&d@)
&dA 
            if jtype = "B" and snode = 6913 
              if oby >= 1000000 
                c9 = oby / 1000000 
                oby = rem 
                sub = 5 
                c8 = int(line{sub..})      /* bar number 
                c7 = int(line{sub..})      /* obx 
                c6 = int(line{sub..})      /* oby 
                line = "J B " // chs(c8) // " " // chs(c7) // " " // chs(oby) // line{sub..}
              end 

              if oby >= 1000 
                oby -= 1000                /* convert to proper bar flag (double etc.)
              end 
              firstbarflag = 1 
              csnode = 6913 
              oldcdv = cdv                                                 /* New &dA12/19/03
              perform getcontrol (barnum) 
              ++barcount 
              if oby > 0 and barnum < ntype 
                barnum = ntype 
              end 
              f4 = 0 
              if barcount = delta 
                f4 = 1 
                endbarrec = rec + 1 
              end 
              point = oldmpoint + barpar(barcount,1) 
              prev_point = point 
              point_adv = 0 
              half_back = point - oldmp2 / 2 
              larc2 = barpar(barcount,2) 
              oldmpoint = point 
              oldmp2 = point 
              obx = 0                                   /* differential obx 
              goto DE 
            end 
&dA 
&dA &d@    Case II: everything else  
&dA 
            a1 = crec 
            oldcdv = cdv 
            perform getcontrol (barnum) 

&dA      
&dA 
&dA &d@    New &dA01/29/09&d@ 
&dA 
&dA &d@    Fixing the object order problem.  Here we impose the special 
&dA &d@    condition that getcontrol should not be allowed to "back up" when 
&dA &d@    dealing with grace notes at the end of a measure.  
&dA 
            if a1 > crec and csnode = 6913 
              if jtype = "G" or jtype = "C" 
                crec = a1 
                cdv = oldcdv 
              end 
            end 
&dA      
            cdv_adv = cdv - oldcdv 
            obx = dvar1 - cdv                           /* differential obx 
            if crec <> a1 
              prev_point = point 
              t9 = larc2 + 1 

              max_larc = 300 

              loop for larc2 = t9 to max_larc 
                point += larr(larc2,PRE_DIST) 
                if larr(larc2,SNODE) = csnode 
                  a10 = larr(larc2,MNODE_TYPE) 
                  if a10 < 12 or a10 > 20 or a10 = cntype 
                    goto DE 
                  end 
                end 
              repeat 
&dA 
&dA &d@      Adding a second filter that relaxes the condition for success (&dA01/18/04&d@)
&dA 
              point = prev_point           /* since you are trying again, get old value of point
              loop for larc2 = t9 to max_larc 
                point += larr(larc2,PRE_DIST) 
                if larr(larc2,SNODE) = csnode 
                  a10 = larr(larc2,MNODE_TYPE) 
                  if csnode = 6913 and a10 = 18 
                    goto DE 
                  end 
                end 
              repeat 
&dA   
            else 
              goto DE 
            end 
            if (Debugg & 0x01) > 0 
              pute Logical error in finding node in part ~f12  at bar ~barnum
            end 
            tmess = 45 
            perform dtalk (tmess) 
&dA 
&dA &d@    differential obx and point now determined 
&dA 
DE: 
            point_adv = point - prev_point 
            obx += point 
            ++rec 
            if jtype = "N" and f(f12,9) > 0    /* text only 

&dA     Code added 2-8-93                             

&dA &d@    There was a problem with the continuation line not stopping  
&dA &d@    when it was supposed to after a carry over from a previous measure.  
&dA &d@    The problem occured only when the stopping note was the first in 
&dA &d@    the new bar.  I was not able to completely understand the logic 
&dA &d@    of the code using nuxstop, but I was able to determine that the 
&dA &d@    value of nuxstop had been set in the previous system of music 
&dA &d@    and was greater than rmarg.  I therefore introduced a new variable 
&dA &d@    called &dAfirstbarflag&d@, which is 0 when setting the first bar on a 
&dA &d@    line, and 1 otherwise.  I think the problem may occur only when            
&dA &d@    nuxstop > rmarg and firstbarflag = 0.  Therefore, in this case I 
&dA &d@    have reset nuxstop to the expected value of sp+obx+mhpar(f12,2).  

              if firstbarflag = 0 and nuxstop(f12) > rmarg 
                nuxstop(f12) = sp + obx + mhpar(f12,2) 
              end 

&dA     End of code added 2-8-93                      &d@ 

              if savenoby(f12) = oby 
                nuxstop(f12) = sp + obx + mhpar(f12,2) 
              else 
                nuxstop(f12) = sp + obx + mhpar(f12,2) 
              end 

              savenoby(f12) = oby 
            end 
            if "Rr" con jtype and cflag = 1            /* New &dA10/15/07&d@ 
              obx = oldmpoint - oldmp2 + barpar(barcount+1,1) / 2 - notesize + oldmp2
              if f(f12,12) = 1 
                obx = 20000         /* Taking this out &dA05/25/03&d@ (not checked)  ????
              end 
            end 
            if jtype = "C" 
              if f(f12,12) = 2 and oby >= 1000 
                mclef(f12,2) = ntype 
              else 
                mclef(f12,1) = ntype 
              end 
            end 
            if jtype = "K" 
              mkey(f12) = ntype 
            end 
            if jtype = "T" 
              if barcount = delta 
                mtcode(f12) = ntype 
              else 
                mtcode(f12) = 10000 
              end 
            end 
&dA 
&dA &d@      Re-writing this section &dA12/24/03&d@.  The problem is that the old code 
&dA &d@      dealt with suppressing D-type records below the top staff line by 
&dA &d@      simply skipping them.  This worked as long as the full score was being
&dA &d@      printed.  But if the top line is taken out for some reason, then 
&dA &d@      "top line" directives are lost.  The solution is to suppress D-type 
&dA &d@      records by setting the font in the W-subobjects to zero.  This way 
&dA &d@      the directives can be turned back on, if necessary 
&dA 
            if jtype = "D" 
              if ntype = 0 
                goto CZ3 
              end 
              if bit(1,ntype) = 1 
                goto CZ3 
              end 
              if bit(2,ntype) = 1 and f12 = 1 
                goto CZ3 
              end 
              if bit(3,ntype) = 1 and f12 = f11 
                goto CZ3 
              end 
&dA 
&dA &d@       Now, turn off W-subobjects associated with this directive 
&dA 
              c8 = rec 
SKD2:         tget [Z,c8] line2 .t3 sobx soby z temp 
              if line2{1} = "W" and z <> 0 
                line2 = "W " // chs(sobx) // " " // chs(soby) // " 0 " 
                line2 = line2 // "(" // chs(z) // ")" // temp 
                tput [Z,c8] ~line2 
                ++c8 
                goto SKD2 
              end 
            end 
&dA 
&dA &d@   General Object Related Activity  
&dA 
&dA &d@    1. Collect super-object information 
&dA 
CZ3: 
            line = line{5..} 
            t10 = int(line)          /* strip object code 
            t10 = int(line{sub+1..}) /* strip obx 
            line = line{sub+1..} 
            line = trm(line) 
            oby = int(line) 
&dA 
&dA &d@    Don't fix oby yet, because we may need staff info when constructing 
&dA &d@    tie, slur, beam, tuplet, transpos, dashes, trills or wedges superobjects 
&dA 
&dA &d@           if oby >= 700 and f(f12,12) = 2 
&dA &d@             oby -= 1000                  /* for superobjects, need oby relative to staff
&dA &d@           end 
&dA 
            if justflag < 2 
#if CONTINUO 
              if jtype = "F" 
                obx += mhpar(f12,23) 
              end 
#endif 
              ++mainyp 
&dA 
&dA &d@   &dA12/17/03&d@ 
&dA 
&dA &d@      Here is where we determine the larr index which generated 
&dA &d@      the value of "point".  
&dA 
              if psysnum = 0 
                t10 = point 
              else 
                t10 = point - pdist      /* reason: For 2nd and subsequent systems, larr does
              end                        /*         not include the clef and key
&dA    
              tput [Y,mainyp] J ~jtype  ~ntype  ~obx  ~line 
            end 
            lpt = int(line)              /* skip Field 5: oby 
            lpt = int(line{sub+1..})     /* skip Field 6: print code 
            lpt = int(line{sub+1..})     /* skip Field 7: space node number 
            lpt = int(line{sub+1..})     /* skip Field 8: distance increment
            line = line{sub+1..}         /* line starts with Field 9: 
            lpt = 0 
            tline = txt(line,[' '],lpt) 
            supcnt = int(tline) 
            if supcnt > 0 
              loop for t9 = 1 to supcnt 
                tline = txt(line,[' '],lpt) 
                t10 = int(tline) 
                if t10 = 0 
                  tmess = 46 
                  perform dtalk (tmess) 
                end 
&dA &d@       look for previous reference to this superobject 
                loop for t11 = 1 to N_SUPER     /* N_SUPER is New &dA02/01/09&d@ 
                  if supermap(f12,t11) = t10 
                    goto WA 
                  end 
                repeat 
                t7 = 0 
                loop for t11 = 1 to N_SUPER     /* N_SUPER is New &dA02/01/09&d@ 
                  if supermap(f12,t11) = 0 
                    t7 = t11 
                    t11 = N_SUPER               /* New &dA02/01/09&d@ 
                  end 
                repeat 
                if t7 = 0 
                  tmess = 47 
                  perform dtalk (tmess) 
                end 
&dA 
&dA &d@       if not found, then set up reference to this superobject 
&dA &d@          also set superdata(f12,t11,5) = 0 for those super-objects 
&dA &d@          which depend on two locations only and which can be 
&dA &d@          split across a line or page break 
&dA 
                t11 = t7 
                supermap(f12,t11) = t10 
                superpnt(f12,t11) = 1 
                superdata(f12,t11,5) = 0 

                superdata(f12,t11,6) = 0             /* New &dA06/09/08&d@ 
                superdata(f12,t11,7) = 0             /* New &dA06/09/08&d@ 

&dA &d@       t11 (value 1 to N_SUPER) = pointer into superdata for this superobject
WA: 
                t7 = superpnt(f12,t11) 
&dA &d@         store object information in superdata and increment superpnt 
                superpnt(f12,t11) = t7 + 2 
                superdata(f12,t11,t7) = obx 
                superdata(f12,t11,t7+1) = oby               /* unfixed 7-22-93
&dA &d@         if this object is the last bar in a line, 
&dA &d@            then set last bar flag in superdata 
                if jtype = "B" and t7 = 1 
                  superdata(f12,t11,6) = f4 
                end 
              repeat 
            end 
&dA 
&dA &d@   End of General Object-related Activity 
&dA &d@ 
            saverec = rec 
            if "Rr" con jtype                        /* New &dA10/15/07&d@ 
              loop for c8 = 1 to f(f12,13) 
                if "_,.;:!?" con xbyte(f12){c8} 
                  xbyte(f12){c8} = "*" 
                end 
              repeat 
            end 
&dA 
&dA                   &d@  End of &dA12/27/05&d@ change (eliminating code that did nothing)

            if jtype = "B" 
&dA 
&dA &d@    If this is the first part in which this particular bar line is  
&dA &d@      encountered, then set value of barpar(.,3) and f5 
&dA 
              if snode = 6913 and barpar(barcount,3) = 0 
                if oby >= 700 and f(f12,12) = 2 
                  oby -= 1000 
                end 
                barpar(barcount,3) = oby 
                f5 = 0 
              end 
              if rec = endbarrec 
                sobx = 0 
                if oby >= 700         /* &dA 
                  oby -= 1000         /* &dA &d@  Added  &dA04/03/94&d@ 
                end                   /* &dA 
                if oby > 8 
                  f5 = 2 
ABX1:             tget [Z,rec] line2 .t3 sobx soby z 
                  if line2{1} = "K" 
                    if z = 44 
                      if sobx < 0 
                        f5 |= 0x04 
                      else 
                        f5 |= 0x01 
                      end 
                    else 
                      if z > 88 
                        line2 = trm(line2) 
                        if justflag < 2 
                          ++mainyp 
                          tput [Y,mainyp] ~line2 
                        end 
                      end 
                    end 
                    ++rec 
                    goto ABX1 
                  end 
                end 
                if oby = 10 and f5 > 3 
                  sobx = 0 - mhpar(f12,16) - mhpar(f12,17) - mhpar(f12,18) 
                  soby = mvpar(f12,3) 
                  if justflag < 2 
                    ++mainyp 
                    tput [Y,mainyp] K ~sobx  ~soby  44 
                    soby = mvpar(f12,5) 
                    ++mainyp 
                    tput [Y,mainyp] K ~sobx  ~soby  44 
                  end 
                end 
                if larc2 = larc and sobx > 0 
                  bolddist(f12) = bolddist(f12) + sobx + mhpar(f12,11) 
                end 
              end 
              oby = 0 
            end 
            if snode = 6913 

&dA     Code added 8-24-93                            
&dA 
&dA &d@    It can happen that there are one or more grace notes before a controlling 
&dA &d@    barline in this part.  In this case, snode will be = 6913, but the 
&dA &d@    grace note(s) DO NOT generate a larr node.  Therefore these proper        
&dA &d@    objects must not be considered as candidates for the end of the line.  
&dA 
              if jtype = "G" 
                goto CZ 
              end 
&dA     End of code added 8-24-93                     &d@ 

&dA 
&dA &d@    In determining whether this node is the last node in the line  
&dA &d@    for this part, we must consider the case where there was a clef 
&dA &d@    change or time change or key change at the end of the line and 
&dA &d@    where this change occurred in some parts but not in others.  
&dA &d@    For this purpose, we have introduced a fifth element in the 
&dA &d@    larr array, which is 0 for nodes <> 6913 and is a flag for active 
&dA &d@    parts for nodes = 6913 (bit 0 corresponds to part 1).  If the 
&dA &d@    current node is a bar line, but is not the last node, and if 
&dA &d@    all remaining nodes are of the type, snode = 6913, and none 
&dA &d@    of these nodes has the current part as active, then this is 
&dA &d@    the last node on the line, EVEN THOUGH LARC <> LARC2!  
&dA 
              t9 = point + sp 
              t11 = 0 
              if larc2 <> larc and f4 = 1 
                q1 = rec 
                loop for t7 = larc2 + 1 to larc 
                  if larr(t7,SNODE) <> 6913 
                    goto C21A 
                  end 
                  if bit(f12-1,larr(t7,ACT_FLAG)) = 1 
                    goto ABX16                         /* goto secondary test
                  end 
                repeat 

                t11 = 1 
                goto C21A     /* This is a test &dA10/12/07&d@ 

ABX16:                                                 /* secondary test 
                tget [Z,q1] line2 .t5 q2 q2 q2 q2 q2 
                ++q1 
                if line2{1} <> "J" 
                  goto ABX16                           /* keep looking for a "J"
                end 
                if q2 = 6913 
                  goto C21A                            /* set k = 1 if not 6913
                end 

                t11 = 1         /* bar &dAis&d@ last node on line 
              end 

C21A: 
              if larc2 = larc or t11 = 1 
&dA 
&dA &d@   Check to see of the current record = the control record 
&dA &d@      if not then this is not the last record in the line 
&dA &d@   And if not last record in line, look for time directive or clef sign 
&dA 
                t7 = saverec - 1 
                if t7 <> crec 
                  if jtype = "D" 
                    if ntype <> 1 
                      dxoff(f12) = obx - point 
                      dyoff(f12) = oby 
                      drec(f12) = rec - 1 
                    end 
                  else 
                    if jtype = "C" 
                      goto CZ 
                    end 
                    if jtype = "M"        /* added &dA9-29-93&d@ but not thoroughly tested
                      goto CZ 
                    end 
                    tmess = 48 
                    perform dtalk (tmess) 
                  end 

&dA                      
&dA 
&dA &d@   &dA11/21/07&d@   Expanding this section to allow directives to be cast to the next line
&dA &d@                (using c12, c13) 
&dA 
                  if endflag = 0 
                    c12 = 0 
                    if jtype = "D"  /* skip over directives and store data for next line
                      c13 = rec - 1 
SKD1:                 tget [Z,rec] line2 .t3 sobx soby z 
                      if line2{1} = "W" 
                        c12 = 1 
                        ++rec 
                        goto SKD1 
                      end 
                    end 
                    if c12 = 1 
                      ++new_dircnt 
                      new_direct(new_dircnt,1) = f12 
                      new_direct(new_dircnt,2) = c13 
                    end 
                  end 
&dA 
&dA                       &d@ End of &dA11/21/07&d@ expansion 

                  goto CZ 
                end 
&dA 
&dA &d@   look for sub-objects to typeset  
&dA 
                t11 = 0 
ABX2: 
                tget [Z,rec] line2 .t3 sobx soby z 
                if line2{1} = "W"          /* code added &dA02-23-97&d@ 
                  if justflag < 2 
                    tget [Z,rec-1] line2 
                    if line2{1,3} = "J B"       /* then this WORD is a centered number
                      tget [Z,rec] line2 
                      line2 = line2{3..} 
                      t7 = int(line2) 
                      line2 = line2{sub..} 
                      line2 = mrt(line2) 
                      t7 -= half_back 
                      line2 = "W " // chs(t7) // " " // line2 
                    end 
                    ++mainyp 
                    tput [Y,mainyp] ~line2 
                  end 
                  ++rec 
                  goto ABX2 
                end                        /* end of &dA02-23-97&d@ addition 
                if line2{1} = "K" 
                  t7 = sobx 
                  if z = 63 
                    t7 += mhpar(f12,6) 
                  end 
                  if z > 63 and z < 66 
                    t7 += mhpar(f12,7) 
                  end 
                  if z > 36 and z < 39 
                    t7 += mhpar(f12,9) 
                  end 
                  if z > 70 and z < 81 
                    t7 += mhpar(f12,10) 
                  end 
                  line2 = trm(line2) 
                  if justflag < 2 
                    ++mainyp 
                    tput [Y,mainyp] ~line2 
                  end 
                  if t7 > t11 
                    t11 = t7 
                  end 
                  ++rec 
                  goto ABX2 
                end 
                if line2{1} = "A"            /* Added &dA11-11-93&d@ 
                  if justflag < 2 
                    ++mainyp 
                    tput [Y,mainyp] ~line2 
                  end 
                  ++rec 
                  goto ABX2 
                end 
                if t11 > 0 
                  bolddist(f12) += t11 
                end 
&dA 
&dA &d@   check for super-objects at this point in the file  
&dA 
&dA &d@   From looking at the code below, it appears that the only kind of 
&dA &d@   super-objects which can appear in this location are those which 
&dA &d@   are allowed to end at a bar line.  These include: transpositions 
&dA &d@   endings, dashes, trills, and wedges.  None of these super-objects 
&dA &d@   are displayable in color (at the moment), so this code shouldn't 
&dA &d@   need to be altered.  
&dA 
                loop 
                  tget [Z,rec] line 
                  ++rec 
                  temp = line{1} 
                  if "H" con temp  /* Don't try to process "P" here, it shouldn't exist.
                    superline = trm(line) 
                    lpt = 3 
                    tline = txt(line,[' '],lpt) 
&dA &d@  line structure = supernum htype . . .  
                    supernum = int(tline) 
&dA &d@  get superdata for this superobject 
                    loop for t11 = 1 to N_SUPER       /* N_SUPER is New &dA02/01/09
                      if supermap(f12,t11) = supernum 
                        goto WB2 
                      end 
                    repeat 
                    if (Debugg & 0x01) > 0 
                      pute Error: No refererce to superobject ~supernum  in previous objects
                    end 
                    tmess = 49 
                    perform dtalk (tmess) 
*  t11 = index into superdata 
WB2: 
                    htype = txt(line,[' '],lpt) 
                    perform do_more_supers (t11,htype) 
                    supermap(f12,t11) = 0 
                  end 
                repeat while "HP" con temp      /* "P" added &dA12/18/10&d@ 
                --rec 
&dA 
&dA &d@   look for incomplete superobjects and underlines 
&dA 
                f(f12,6) = rec 
                f(f12,5) = rec 
                loop for t11 = 1 to N_SUPER      /* N_SUPER is New &dA02/01/09&d@ 
                  if supermap(f12,t11) = 0 
                    goto CL 
                  end 
                  rec = f(f12,6) 
&dA 
&dA &d@      1) look for object that terminates this super-object 
&dA &d@            get x and y coordinates of this object 
&dA 
                  loop 
                    perform save3             /* want vstaff info; (raw oby)
                    ++rec 
                    if line{1} = "J" 
                      if snode = 10000 
                        if (Debugg & 0x01) > 0 
                          pute Error: No terminating object for super-object ~supermap(f12,t11)
                          pute 
                          pute This error occurred in part number ~f12  of the score at
                          pute approximately measure number ~(barnum - 1) .  The first step would be
                          pute to look in the source file for this part.  Be sure to look
                          pute in the right file; it's name may not be the same as it's order
                          pute in the score.  
                          pute 
                          pute The location of the error may be related to location of the
                          pute super-object only indirectly.  For example, a beam on some grace
                          pute notes (a super_object) might be open and closed properly, but if
                          pute a (much) later grace note has an "=" in column 26 (i.b46 e.b46 , super-
                          pute object not properly started), then mskpage may try to re-open
                          pute the earlier super-object -- hence a much lower super-object
                          pute number than would be expected at the error location.
                        end 
                        tmess = 50 
                        perform dtalk (tmess) 
                      end 
                      x = dvar1 - bolddist(f12) 
                      y = oby 
                      line = line{5..}             /* line starts with Field 3:
                      lpt = int(line)              /* skip Field 3: jcode 
                      lpt = int(line{sub+1..})     /* skip Field 4: oby 
                      lpt = int(line{sub+1..})     /* skip Field 5: oby 
                      lpt = int(line{sub+1..})     /* skip Field 6: print code
                      lpt = int(line{sub+1..})     /* skip Field 7: space node number
                      lpt = int(line{sub+1..})     /* skip Field 8: distance increment
                      line = line{sub+1..}         /* line starts with Field 9:
                      lpt = 0 
                      tline = txt(line,[' '],lpt) 
                      t12 = int(tline) 
                      if t12 > 0 
                        loop for a1 = 1 to t12 
                          tline = txt(line,[' '],lpt) 
                          a2 = int(tline) 
                          if a2 = supermap(f12,t11) 
                            goto WC               /* Object found 
                          end 
                        repeat 
                      end 
                    end 
                  repeat 
&dA 
&dA &d@      2) look for superobject  (beyond object) 
&dA 
WC: 
                  loop 
                    perform save3         /* oby not used here 
                    ++rec 
                    if line{1} = "J" and snode = 10000 
                      if (Debugg & 0x01) > 0 
                        pute Missing superobject ~supermap(f12,t11) , possible extra beam code
                      end 
                      tmess = 51 
                      perform dtalk (tmess) 
                    end 
                    if "HP" con line{1}                 /* "P" added &dA12/18/10
                      lpt = 3 
                      tline = txt(line,[' '],lpt) 
                      if line{1} = "P"                  /* This code added &dA01/18/11
                        tline2 = "" 
                        tline = tline // pad(2) 
                        if tline{1,2} = "0x" 
                          tline2 = tline 
                          tline = txt(line,[' '],lpt) 
                        end 
                      end 
                      t12 = int(tline) 
                      if supermap(f12,t11) = t12 
                        htype = txt(line,[' '],lpt) 
                        if htype = "B" 
                          tmess = 52 
                          perform dtalk (tmess) 
                        end 
&dA 
&dA &d@          Incomplete Tie (section re-coded &dA05/28/03&d@ to fix suggestions for incomplete ties)
&dA 
                        if htype = "T" 
                          sub = lpt 
                          y1 = int(line{sub..}) 
                          x1 = int(line{sub..}) 
                          x2 = int(line{sub..}) 
                          c1 = int(line{sub..}) 
                          c2 = int(line{sub..}) 
                          c3 = int(line{sub..}) 
                          sitflag = int(line{sub..}) 
                          tspan = rmarg - sp - x1 
                          if justflag < 2 
*             create mark for end of tie 
                            ++mainyp 
                            tput [Y,mainyp] J M 0 ~syslen  0 0 6913 0 1 ~t12
*             create "first half" of super-object  
                            ++mainyp 
                            if line{1} = "P"      /* New &dA12/18/10&d@ (color_flag not needed here)
                              if tline2 = "" 
                                tput [Y,mainyp] P ~t12  T ~y1  ~x1  0 ~c1  ~c2  0 ~sitflag  0
                              else 
                                tput [Y,mainyp] P ~tline2  ~t12  T ~y1  ~x1  0 ~c1  ~c2  0 ~sitflag  0
                              end 
                            else 
                              tput [Y,mainyp] H ~t12  T ~y1  ~x1  0 ~c1  ~c2  0 ~sitflag  0
                            end 
                          end                                        
&dA 
&dA &d@   By setting supermap(t11) = 0 at this point, you will cause 
&dA &d@   superdata to be collected on only the terminating note of 
&dA &d@   the tie.  In this case, superpnt(.) will be 2 instead of 4, 
&dA &d@   and the program will know to typeset a small end-tie.  
&dA 
                          conttie(f12) = 1        /* Code added &dA02/25/97&d@ 
                          supermap(f12,t11) = 0 
                          goto CL 
                        end 
&dA 
&dA &d@          Incomplete Slur 
&dA 
                        if htype = "S" 
                          tline = txt(line,[' '],lpt) 
                          sitflag = int(tline) 
                          tline = txt(line,[' '],lpt) 
                          a3 = int(tline) 
                          x1 = a3 + superdata(f12,t11,1) 
                          tline = txt(line,[' '],lpt) 
                          a4 = int(tline) 
                          y1 = a4 + superdata(f12,t11,2) 
                          if y1 > 700 
                            y1 -= 1000     /* correct for vstaff flag 
                          end 
                          tline = txt(line,[' '],lpt) 
                          x2 = int(tline) + rmarg + x - sp 
                          tline = txt(line,[' '],lpt) 
                          a5 = 0 
                          if y > 700 
                            y -= 1000      /* correct for vstaff flag 
                            a5 = 1000      /* and add vstaff offset to location flag
                          end 
                          y2 = int(tline) + y 
*              compute second height as a percentage of total change 
                          a2 = x2 - x1 
                          a1 = rmarg - sp - x1 * 20 / a2 
                          y2 = y2 - y1 * a1 / 20 + y1 
                          x2 = rmarg - sp 
                          y2 += a5 
*              set broken super-object flag 
                          if y2 = 0 
                            y2 = 1 
                          end 
                          superdata(f12,t11,5) = y2    /* include virtual staff flag
                          if justflag < 2 
*              create mark for end of slur 
                            ++mainyp 
                            tput [Y,mainyp] J M 0 ~syslen  ~y2  0 6913 0 1 ~t12
*              write "first half" of super-object  
                            ++mainyp 
                            tput [Y,mainyp] H ~t12  S ~sitflag  ~a3  ~a4  0 0 0 0 0
                          end 
                          goto CL 
                        end 
&dA 
&dA &d@          Incomplete figure continuation lines 
&dA 
                        if htype = "F" 
                          tline = txt(line,[' '],lpt) 
                          a3 = int(tline) 
                          tline = txt(line,[' '],lpt) 
                          x1 = int(tline)    /* + superdata(f12,t11,1) 
                          x2 = rmarg - sp 
*            set broken super-object flag 
                          superdata(f12,t11,5) = 1 
                          if justflag < 2 
*              create mark for end of figure continuation lines  
                            ++mainyp 
                            tput [Y,mainyp] J M 0 ~syslen  0 0 6913 0 1 ~t12
*              write "first half" of super-object  
                            ++mainyp 
                            tput [Y,mainyp] H ~t12  F ~a3  ~x1  0 0 
                          end 
                          goto CL 
                        end 
&dA 
&dA &d@          Incomplete octave transposition 
&dA 
                        if htype = "V" 
                          tline = txt(line,[' '],lpt) 
                          a3 = int(tline) 
                          tline = txt(line,[' '],lpt) 
                          x1 = int(tline)     /* + superdata(f12,t11,1) 
                          tline = txt(line,[' '],lpt) 
                          tline = txt(line,[' '],lpt) 
                          y1 = int(tline)     /* + superdata(f12,t11,2) 
                          a1 = 0 
                          x2 = rmarg - sp 
                          a4 = x2 - x1 
*              set broken super-object flag 
                         superdata(f12,t11,5) = 1 
*      create mark for end of octave transposition (mindful of virtual staff possibility)
                          if justflag < 2 
                            if superdata(f12,t11,2) > 700 and f(f12,12) = 2 
                              ++mainyp 
                              tput [Y,mainyp] J M 0 ~syslen  1000 0 6913 0 1 ~t12
                            else 
                              ++mainyp 
                              tput [Y,mainyp] J M 0 ~syslen  0 0 6913 0 1 ~t12
                            end 
*              write "first half" of super-object  
                            ++mainyp 
                            tput [Y,mainyp] H ~t12  V ~a3  ~x1  0 ~y1  0 
                          end 
                          goto CL 
                        end 
&dA 
&dA &d@          Incomplete ending 
&dA 
                        if htype = "E" 
                          tline = txt(line,[' '],lpt) 
                          a3 = int(tline) 
                          tline = txt(line,[' '],lpt) 
                          x1 = int(tline)     /* + superdata(f12,t11,1) 
                          tline = txt(line,[' '],lpt) 
                          tline = txt(line,[' '],lpt) 
                          y1 = int(tline) 
                          tline = txt(line,[' '],lpt) 
                          a1 = int(tline) 
                          a2 = 0 
                          x2 = rmarg - sp 
*              create mark for end of incomplete ending  
                          if justflag < 2 
                            ++mainyp 
                            tput [Y,mainyp] J M 0 ~syslen  0 0 6913 0 1 ~t12
                          end 
&dA 
&dA &d@     &dA05/06/08&d@  superdata(.,.,5) has been designated as the flag from a split ending
&dA &d@               In earlier verious of mskpage, it had only one non-zero value, namely 1
&dA &d@               Now it has three possible non-zero values: 
&dA 
&dA &d@                 1 = normal split.  (I believe this may no longer be used) 
&dA &d@                 2 = split where the ending starts at the beginning of the page
&dA &d@                 3 = signals that the ending was started on a previous page
&dA 
&dA &d@               superdata(.,.,7) is used to flag this superobject as an ending (magic number)
&dA 
                          if superdata(f12,t11,6) = 0 or superdata(f12,t11,5) = 2    /* New &dA05/06/08
*              write "first half" of super-object  
                            if justflag < 2 
                              ++mainyp 
                              tput [Y,mainyp] H ~t12  E ~a3  ~x1  0 ~y1  ~a1  0
                            end 
&dA*&d@              set broken super-object flag to 3 
                            superdata(f12,t11,5) = 3 
                          else 
                            if justflag < 2 
                              ++mainyp 
                              tput [Y,mainyp] H ~t12  N 
                            end 
&dA*&d@              set broken super-object flag to 2 
                            superdata(f12,t11,5) = 2 
                          end 
                          superdata(f12,t11,7) = 123456                            /* New &dA05/06/08

                          goto CL 
                        end 
&dA 
&dA &d@          Incomplete dashes 
&dA 
                        if htype = "D" 
                          tline = txt(line,[' '],lpt) 
                          x1 = int(tline)     /* + superdata(f12,t11,1) 
                          tline = txt(line,[' '],lpt) 
                          tline = txt(line,[' '],lpt) 
                          y1 = int(tline) 
                          tline = txt(line,[' '],lpt) 
                          a1 = int(tline) 
                          tline = txt(line,[' '],lpt) 
                          a2 = int(tline) 
                          x2 = rmarg - sp 
*              set broken super-object flag 
                          superdata(f12,t11,5) = 1 
                          superdata(f12,t11,6)  = 234567    /* New &dA06/09/08&d@ magic number for dashes
                          if justflag < 2 

&dA                  
&dA 
&dA &d@   New code &dA06/09/08&d@  If this is a page length set of dashes, put in a 
&dA &d@                        mark for the beginning 
&dA 
                            if superdata(f12,t11,7) = 1 
                              x1 = hxpar(8) - sp 

                              if superdata(f12,t11,2) > 700 and f(f12,12) = 2
                                ++mainyp 
                                tput [Y,mainyp] J M 0 ~x1  1000 0 6913 0 1 ~t12
                              else 
                                ++mainyp 
                                tput [Y,mainyp] J M 0 ~x1  0 0 6913 0 1 ~t12
                              end 

                              x1 = 0 
                            end 
&dA 
&dA                  &d@  End of &dA06/09/08&d@ Code 

&dA 
&dA &d@   Now create mark for end of dashes (mindful of virtual staff possibility)
&dA 
                            if superdata(f12,t11,2) > 700 and f(f12,12) = 2 
                              ++mainyp 
                              tput [Y,mainyp] J M 0 ~syslen  1000 0 6913 0 1 ~t12
                            else 
                              ++mainyp 
                              tput [Y,mainyp] J M 0 ~syslen  0 0 6913 0 1 ~t12
                            end 
*              write "first half" (or "full length") super-object 
                            ++mainyp 
                            tput [Y,mainyp] H ~t12  D ~x1  0 ~y1  ~a1  ~a2 
                          end 
                          goto CL 
                        end 
&dA 
&dA &d@          Incomplete Long Trill 
&dA 
                        if htype = "R" 
                          tline = txt(line,[' '],lpt) 
                          a1 = int(tline) 
                          tline = txt(line,[' '],lpt) 
                          x1 = int(tline)     /* + superdata(f12,t11,1) 
                          tline = txt(line,[' '],lpt) 
                          x2 = rmarg - sp 
                          tline = txt(line,[' '],lpt) 
                          y1 = int(tline)     /* + superdata(f12,t11,2) 
*              set broken super-object flag 
                          superdata(f12,t11,5) = 1 
*      create mark for end of long trill (mindful of virtual staff possibility)
                          if justflag < 2 
                            if superdata(f12,t11,2) > 700 and f(f12,12) = 2 
                              ++mainyp 
                              tput [Y,mainyp] J M 0 ~syslen  1000 0 6913 0 1 ~t12
                            else 
                              ++mainyp 
                              tput [Y,mainyp] J M 0 ~syslen  0 0 6913 0 1 ~t12
                            end 
*              write "first half" of super-object  
                            ++mainyp 
                            tput [Y,mainyp] H ~t12  R ~a1  ~x1  0 ~y1 
                          end 
                          goto CL 
                        end 
&dA 
&dA &d@          Incomplete Wedge 
&dA 
                        if htype = "W" 
                          tline = txt(line,[' '],lpt) 
                          c1 = int(tline) 
                          tline = txt(line,[' '],lpt) 
                          c2 = int(tline) 
                          tline = txt(line,[' '],lpt) 
                          x1 = int(tline)     /* + superdata(f12,t11,1) 
                          tline = txt(line,[' '],lpt) 
                          y1 = int(tline) 
                          tline = txt(line,[' '],lpt) 
                          x2 = rmarg - sp 
                          tline = txt(line,[' '],lpt) 
                          y2 = int(tline) 
*              compute second spread 
                          if c1 < c2 
                            if c1 = 0 
                              a1 = c2 - 1 / 2 
                              c2 = c2 * 3 / 4 
                            else 
                              a1 = c2 
                            end 
                          else 
                            if c2 = 0 
                              c2 = c1 / 2 
                              a1 = c1 * 3 / 4 
                            else 
                              a1 = c1 
                            end 
                          end 
*              set broken super-object flag 
                          if a1 = 0 
                            a1 = 1 
                          end 
                          superdata(f12,t11,5) = a1 
*      create mark for end of wedge (mindful of virtual staff possibility) 
                          if justflag < 2 
                            if superdata(f12,t11,2) > 700 and f(f12,12) = 2 
                              ++mainyp 
                              tput [Y,mainyp] J M 0 ~syslen  1000 0 6913 0 1 ~t12
                            else 
                              ++mainyp 
                              tput [Y,mainyp] J M 0 ~syslen  0 0 6913 0 1 ~t12
                            end 
*              write "first half" of super-object  
                            ++mainyp 
                            tput [Y,mainyp] H ~t12  W ~c1  ~c2  ~x1  ~y1  0 ~y2
                          end 
                          goto CL 
                        end 
                      end 
                    end 
                  repeat 
CL: 
                repeat 

                loop for c8 = 1 to f(f12,13) 
                  if "_,.;:!?" con xbyte(f12){c8} 
                    xbyte(f12){c8} = "*" 
                  end 
                repeat 
&dA 
&dA &d@   End of &dA12/27/05&d@ code change (to remove code that did nothing) 
&dA 
&dA                    

                goto CW    /* this is the exit for the music line loop (for each part)

              end 
            end 

            goto CZ 
          end 
&dA 
&dA &d@         S U B - O B J E C T S 
&dA &d@         ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA 
          if line{1} = "K" or line{1} = "k" or line{1} = "C"   /* "C" added &dA12/18/10
            tget [Z,rec-1] line2 
            line2 = trm(line2) 
            if justflag < 2 
              if conttie(f12) = 1      /* (somewhat tricky solution) 
                if line{1} = "k"       /* New &dA12/18/10&d@ 
                  line2{1} = "K"       /* (this ignors color for the moment)
                end 
              end 
              ++mainyp 
              tput [Y,mainyp] ~line2 
            end 
            goto CZ 
          end 
&dA 
&dA &d@         A T T R I B U T E S 
&dA &d@         ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ   
&dA 
          if line{1} = "A"             /* Added &dA11-11-93&d@ 
            tget [Z,rec-1] line2 
            line2 = trm(line2) 
            if justflag < 2 
              ++mainyp 
              tput [Y,mainyp] ~line2 
            end 
            goto CZ 
          end 
&dA 
&dA &d@         W O R D S 
&dA &d@         ÄÄÄÄÄÄÄÄÄ 
&dA 
          if line{1} = "W" 
            line = trm(line) 
            if justflag < 2 
              tget [Z,rec-2] line2        /* added &dA02-23-97&d@ 
              if line2{1,3} = "J B"       /* then this WORD is a centered number
                tget [Z,rec-1] line2 
                line2 = line2{3..} 
                x = int(line2) 
                line2 = line2{sub..} 
                line2 = mrt(line2) 
                x -= half_back 
                line = "W " // chs(x) // " " // line2 
              end                         /* end of &dA02-23-97&d@ addition 
              ++mainyp 
              tput [Y,mainyp] ~line 
            end 
            goto CZ 
          end 
&dA 
&dA &d@         T E X T  (This code re-organized &dA12/19/03&d@ to deal with optional sobx2)
&dA &d@         ÄÄÄÄÄÄÄ 
&dA 
&dA &d@       Step 1: determine object record to which this text belongs 
&dA 
          if line{1} = "T" 

            trec = rec - 2                   /* rec was advanced after getting "T" record
TX1: 
            tget [Z,trec] line2 
            if line2{1} <> "J" and trec > 1 
              --trec 
              goto TX1 
            end 
&dA 
&dA &d@       Step 2: save current value of backtxobrec and set a new value for backtxobrec
&dA 
            if c15 <> backtxobrec 
              c15 = backtxobrec 
              backtxobrec = trec 
            end 
&dA 
&dA &d@       Step 3: gather information from current line
&dA 
&dA &d@  line structure = sobx (or optionally sobx|sobx2 ) soby ttext xbyte textlen
&dA 
            line = trm(line) 
            lpt = 3 
            tline = txt(line,[' '],lpt) 
            tline = tline // " " 
            sobx = int(tline) 
            if tline{sub} = "|" 
              sobx2 = int(tline{sub+1..}) 
            else 
              sobx2 = 100 
            end 
            tline = txt(line,[' '],lpt) 
            soby = int(tline) 
            tline = line{lpt..}        /* this is the rest of line, beginning with a " "
&dA 
&dA &d@       Step 4: Determine if the opportunity exists to improve the placement of text
&dA 
&dA &d@           We now have the following information at this point: 
&dA &d@             point_adv = amount by which the x-pointer has advanced to 
&dA &d@                         produce this "group" of objects 
&dA &d@             cdv_adv   = amount by which the x-pointer in the source i-file
&dA &d@                         advanced to produce this note object 
&dA 
&dA &d@           If point_adv is significantly (?) bigger than cdv_adv (i.e., 
&dA &d@             there is now ample space to the left of this note), AND 
&dA &d@             sobx2 is smaller (i.e., more negative) than sobx (i.e., the 
&dA &d@             ideal position of the text is to the left of the practical 
&dA &d@             position), then we can use sobx2 in place of sobx in 
&dA &d@             positioning the text.  
&dA 
&dA &d@           Also, if point_adv is significantly (?) bigger than cdv_adv 
&dA &d@             (i.e., there is now ample space to the left of this note), 
&dA &d@             AND the sobx2 &dEfrom the previous note&d@ containing text &dEwas&d@ 
&dA &d@             &dElarger&d@ (i.e., less negative) &dEthan&d@ the sobx for that note 
&dA &d@             (i.e., the ideal position of the text is to the right of 
&dA &d@             the practical position for the previous note), then we 
&dA &d@             should try to go back to the previous text record(s) and 
&dA &d@             replace the sobx with a saved_sobx2.  To do this, we will 
&dA &d@             need a valid back pointer to &dEnote object&d@ which generated 
&dA &d@             previous text records, and the saved_sobx2 value.  
&dA 
&dA &d@       Step 5: c10 > 0.  Try to determine how best to use this "extra" space.
&dA 
&dA &d@         Step 5a: determine value of sobx (c11) for previous note with text
&dA 
            c10 = point_adv - cdv_adv 
            if c10 > 0 
              if c15 > 0 
                trec = c15 + 1 
TX2: 
                tget [Z,trec] line2 .t3 c11 
                if line2{1} <> "T" 
                  ++trec 
                  goto TX2 
                end 
              else                     /* for corner case of no valid backtxobrec
                c11 = 10000            /*   this guarentees that c12 will be 0
              end 
&dA 
&dA &d@         Step 5b: determine benefit to moving previous text to the right (c12) -->
&dA 
              if saved_sobx2 <> 100 and saved_sobx2 > c11   /* benefit to moving text -->
                c12 = saved_sobx2 - c11 
              else 
                c12 = 0 
              end 
&dA 
&dA &d@         Step 5c: determine benefit to moving current text to the left (c13) <--
&dA 
              if sobx2 <> 100 and sobx2 < sobx 
                c13 = sobx - sobx2                   /* a positive number in this scheme
              else 
                c13 = 0 
              end 
&dA 
&dA &d@         Step 5d: determine how to distribute extra distance.                    
&dA 
              c14 = c12 + c13 
              if c14 > c10 
                if c13 = 0 
                  c12 = c10 
                else 
                  if c12 = 0 
                    c13 = c10 
                  else 
                    c13 = c13 * c10 / c14 
                    c12 = c10 - c13 
                  end 
                end 
              end 
&dA 
&dA &d@       Step 6: Move the horizontal position of text as appropriate               
&dA 
&dA &d@         Step 6a: if c12 > 0,  move previous text position(s) to the right -->
&dA 
              if c12 > 0 
                trec = c15 + 1 
                tget [Z,trec] line2 
                loop 
                  if line2{1} = "T" 
                    c14 = int(line2{3..}) 
                    c14 += c12 
                    line2 = "T " // chs(c14) // line2{sub..} 
                  end 
                  ++trec 
                  tget [Z,trec] line2 
                repeat while "KTkC" con line2{1}   /* "C" added &dA12/18/10&d@ 
              end 
&dA 
&dA &d@         Step 6b: if c13 > 0,  move current text position to the left <-- 
&dA 
              if c13 > 0 
                sobx -= c13 
              end 
            end 
&dA 
&dA &d@       Step 7: Save current value of sobx2
&dA 
            saved_sobx2 = sobx2 
&dA 
&dA &d@       Step 8: Reconstitute this "T" text line without sobx2 and recompute lpt
&dA 
            line = "T " // chs(sobx) // " " // chs(soby) // tline       
            tput [Z,rec-1] ~line 
&dA 
&dA &d@       Step 9: Recompute lpt 
&dA 
&dA &d@  line structure = sobx (or optionally sobx|sobx2 ) soby ttext xbyte textlen
&dA 
            line = trm(line) 
            lpt = 3 
            tline = txt(line,[' '],lpt) 
            tline = tline // " " 
            sobx = int(tline) 
            tline = txt(line,[' '],lpt) 
            soby = int(tline) 
&dA 
&dA &d@       Step 10: if justflag < 2, store line in Y table 
&dA 
            if justflag < 2 
              ++mainyp 
              tput [Y,mainyp] ~line 
            end 
&dA 
&dA &d@    End of &dA12/19/03&d@ code re-write 
&dA 
            ttext = txt(line,[' '],lpt) 
            xbyte(f12){soby} = txt(line,[' '],lpt) 
            tline = txt(line,[' '],lpt) 
            textlen = int(tline) 
            x = sp + obx + sobx 
            y = sq(f12) + f(f12,9) 
            backloc(f12) = x + textlen 
            uxstart(f12) = x + textlen + mhpar(f12,3) 
            goto CZ 
          end 
&dA 
&dA &d@         S U P E R - O B J E C T S 
&dA &d@         ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
&dA &d@             line structure = supernum htype . . .  
&dA 
          if "HP" con line{1}                 /* "P" added &dA12/18/10&d@ 
            superline = trm(line) 
            lpt = 3 
            tline = txt(line,[' '],lpt) 
            if line{1} = "P"                  /* This code added &dA01/18/11&d@ 
              tline2 = "" 
              tline = tline // pad(2) 
              if tline{1,2} = "0x" 
                tline2 = tline 
                tline = txt(line,[' '],lpt) 
              end 
            end 
            supernum = int(tline) 
*  get superdata for this superobject 
            loop for t11 = 1 to N_SUPER           /* N_SUPER is New &dA02/01/09
              if supermap(f12,t11) = supernum 
                goto WB 
              end 
            repeat 
            tmess = 53 
            perform dtalk (tmess) 
*  t11 = index into superdata 
WB: 
            htype = txt(line,[' '],lpt) 
&dA 
&dA &d@  structure of &dDtie superobject&d@:  4. vertical position of tied note 
&dA &d@                                 5. horiz. displacement from 1st note 
&dA &d@                                 6. horiz. displacement from 2nd note 
&dA &d@                                 7. vacent 
&dA &d@                                 8. vacent 
&dA &d@                                 9. vacent 
&dA &d@                                10. sitflag 
&dA &d@                                11. recalc flag 
&dA 
            if htype = "T" 
              color_flag = 0        /* New &dA12/18/10&d@ 
              if line{1} = "P"      /* We must do this here, because line is changed below
                color_flag = 1 
              end 

              tline = txt(line,[' '],lpt) 
              y1 = int(tline) 
              tline = txt(line,[' '],lpt) 
              x1 = int(tline) + superdata(f12,t11,1) 
              tline = txt(line,[' '],lpt) 
              x2 = int(tline) 
              line = line{lpt+1..} 
              sitflag = int(line)              /* skip Field 7 
              sitflag = int(line{sub+1..})     /* skip Field 8 
              sitflag = int(line{sub+1..})     /* skip Field 9 
              line = line{sub+1..} 
              sitflag = int(line) 
&dA 
&dA &d@    determine first note location (x1,y1) and tspan 
&dA 
&dA &d@       1. Normal case 
&dA 
              if superpnt(f12,t11) = 5 
                if justflag < 2 
                  ++mainyp 
                  tput [Y,mainyp] ~superline 
                end 
                tspan = superdata(f12,t11,3) + x2 - x1 
              end 
&dA 
&dA &d@       2. Continued tie 
&dA 
              if superpnt(f12,t11) = 3 
                x1 = superdata(f12,t11,1) + x2 - mhpar(f12,1) 
                tspan = mhpar(f12,1) 
                if justflag < 2 
*       create mark at beginning of line 
                  ++mainyp 
                  tput [Y,mainyp] J M 0 ~x1  0 0 6913 0 1 ~supernum 
*       create "second half" of super-object 
                  ++mainyp 
                  if color_flag = 1   /* New &dA12/18/10&d@ 
                    if tline2 = "" 
                      tput [Y,mainyp] P ~supernum  T ~y1  0 ~x2  0 0 0 ~sitflag  0
                    else 
                      tput [Y,mainyp] P ~tline2  ~supernum  T ~y1  0 ~x2  0 0 0 ~sitflag  0
                    end 
                  else 
                    tput [Y,mainyp] H ~supernum  T ~y1  0 ~x2  0 0 0 ~sitflag  0
                  end 
                end 
              end 
              supermap(f12,t11) = 0 
              conttie(f12) = 0        /* Code added &dA02/25/97&d@ 
              color_flag = 0          /* New &dA12/18/10&d@ 
              goto CZ 
            end 
&dA 
&dA &d@  structure of &dDbeam superobject&d@: slope vertoff font# #obs bc(1) ...  
&dA 
            if htype = "B" 
              color_flag = 0          /* New &dA12/18/10&d@ 
              if line{1} = "P"        /* We must do this here, because line is changed below
                color_flag = 1 
              end 

              tline = txt(line,[' '],lpt) 
              t3 = int(tline) 
              tline = txt(line,[' '],lpt) 
              t4 = int(tline) 
              temp2 = line{lpt..} 
              temp2 = mrt(temp2) 
              tline = txt(line,[' '],lpt) 
              beamfont = int(tline) 

              tline = txt(line,[' '],lpt) 
              bcount = int(tline) 
              if bcount > MAX_BNOTES 
                t10 = MAX_BNOTES 
                if (Debugg & 0x01) > 0 
                  pute At the present time, this program can only accommodate ~t10  notes
                  pute under one beam.
                end 
                tmess = 54 
                perform dtalk (tmess) 
              end 
              t10 = 1 
              loop for t9 = 1 to bcount 
                bdata(t9,1) = superdata(f12,t11,t10) 
                bdata(t9,2) = superdata(f12,t11,t10+1) 
                temp = txt(line,[' '],lpt) 
                temp = rev(temp) 
                t5 = 6 - len(temp) 
                msk_beamcode(t9) = temp // "00000"{1,t5} 
                t10 += 2 
              repeat 
*   print beam 
              perform setbeam (t3,t4) 

              supermap(f12,t11) = 0 

              if justflag < 2 
                ++mainyp 
                if color_flag = 1   /* New &dA12/18/10&d@ 
                  if tline2 = "" 
                    tput [Y,mainyp] P ~supernum  ~htype  ~t3  ~t4  ~temp2 
                  else 
                    tput [Y,mainyp] P ~tline2  ~supernum  ~htype  ~t3  ~t4  ~temp2
                  end 
                else 
                  tput [Y,mainyp] H ~supernum  ~htype  ~t3  ~t4  ~temp2 
                end 
              end 

              color_flag = 0        /* New &dA12/18/10&d@ 
              goto CZ 
            end 
&dA 
&dA &d@  structure of &dDslur superobject&d@:  4. sitflag 
&dA &d@                                  5. extra horiz. displ. from obj-1 
&dA &d@                                  6. extra vert. displ. from obj-1 
&dA &d@                                  7. extra horiz. displ. from obj-2 
&dA &d@                                  8. extra vert. displ. from obj-2 
&dA &d@                                  9. post horiz. displ.  
&dA &d@                                 10. post vert. displ.  
&dA &d@                                 11. stock slur number 
&dA 
            if htype = "S" 
              tline = txt(line,[' '],lpt) 
              sitflag = int(tline) 
              tline = txt(line,[' '],lpt) 
              y1 = superdata(f12,t11,5) 
              if y1 = 0 
                if justflag < 2 
                  ++mainyp 
                  tput [Y,mainyp] ~superline 
                end 
              else 
                tline = txt(line,[' '],lpt) 
                tline = txt(line,[' '],lpt) 
                a3 = int(tline) 
                x2 = a3 + superdata(f12,t11,3) 
                x1 = hxpar(8) - sp - notesize 
                a1 = x2 - x1 
                if a1 < mhpar(f12,14) 
                  a2 = mhpar(f12,14) - a1 
                  x1 -= a2 
                end 
                tline = txt(line,[' '],lpt) 
                y2 = int(tline)     /* + superdata(f12,t11,4) 
*      create mark at beginning of line (mindful of virtual staff possibility) 
                if justflag < 2 
                  if y1 > 700 and f(f12,12) = 2 
                    ++mainyp 
                    tput [Y,mainyp] J M 0 ~x1  1000 0 6913 0 1 ~supernum 
                    y1 -= 1000 
                  else 
                    ++mainyp 
                    tput [Y,mainyp] J M 0 ~x1  0 0 6913 0 1 ~supernum 
                  end 
*       create "second half" of super-object 
                  ++mainyp 
                  tput [Y,mainyp] H ~supernum  S ~sitflag  0 ~y1  ~a3  ~y2  0 0 0
                end 
              end 
              supermap(f12,t11) = 0 
              goto CZ 
            end 
&dA 
&dA &d@  structure of &dDfigcon super-object&d@:  4. figure level 
&dA &d@                                     5. horiz. disp. from obj1 
&dA &d@                                     6. horiz. disp. from obj2 
&dA 
            if htype = "F" 
              tline = txt(line,[' '],lpt) 
              a3 = int(tline) 
              tline = txt(line,[' '],lpt) 
              x1 = int(tline) 
              tline = txt(line,[' '],lpt) 
              x2 = int(tline)     /* + superdata(f12,t11,3) 
              if justflag < 2 
                if superdata(f12,t11,5) = 0 
                  ++mainyp 
                  tput [Y,mainyp] ~superline 
                  x1 += superdata(f12,t11,1) 
                else 
                  x1 = hxpar(8) - sp 
*       create mark at beginning of line 
                  ++mainyp 
                  tput [Y,mainyp] J M 0 ~x1  0 0 6913 0 1 ~supernum 
*       create "second half" of super-object 
                  ++mainyp 
                  tput [Y,mainyp] H ~supernum  F ~a3  0 ~x2  0 
                end 
              end 
              supermap(f12,t11) = 0 
              goto CZ 
            end 
&dA 
&dA &d@  structure of &dDtuplet super-object&d@:  4. situation flag 
&dA &d@                                     5. tuplet number 
&dA &d@                                     6. horiz. disp. from obj1 
&dA &d@                                     7. vert. disp. from obj1 
&dA &d@                                     8. horiz. disp. from obj2 
&dA &d@                                     9. vert. disp. from obj2 
&dA &d@                                    10. associated beam super-number 
&dA 
            if htype = "X" 
              if justflag < 2 
                ++mainyp 
                tput [Y,mainyp] ~superline 
              end 
              supermap(f12,t11) = 0 
              goto CZ 
            end 
&dA 
&dA &d@    For the rest of the superbjects, please see code 
&dA &d@      at procedure do_more_supers 
&dA 
            perform do_more_supers (t11,htype) 
            supermap(f12,t11) = 0 
            goto CZ 
          end 
CW: 
          if barnum > newbarnum 
            newbarnum = barnum 
          end 
*    mark end of line  
          if justflag < 2 
            ++mainyp 
            tput [Y,mainyp] E ~xbyte(f12) 
          end 
        repeat 
&dA 
&dA &d@    New &dA11/21/07&d@ 
&dA 
        loop for c12 = 1 to new_dircnt 
          save_direct(c12,1) = new_direct(c12,1) 
          save_direct(c12,2) = new_direct(c12,2) 
        repeat 
        save_dircnt = new_dircnt 
        new_dircnt = 0 
&dA                 

        barnum = newbarnum 
&dA 
&dA &d@   Check to see that multiple rest flags are equal 
&dA 
        loop for f12 = 1 to f11 
          f(f12,7) = f(f12,11) 
        repeat 
&dA &d@                                                                   
&dA &d@       Step 8. Typeset bar lines 
&dA &d@                                                                   
        if gbarflag = 1 
          if justflag < 2 
            ++mainyp 
            tput [Y,mainyp] B ~gbar(2)  ~gbar(1)  0 
          end 
          gbarflag = 0 
        end 
        obx = pdist     /* + sp 
        loop for barcount = 1 to delta 
          obx += barpar(barcount,1) 
          a8 = barpar(barcount,3) 
          if barcount = delta 
            if a8 = 9 
              a8 = 5 
            end 
            if a8 = 10 
              a8 = 6 
            end 
          end 
          if justflag < 2 
            ++mainyp 
            tput [Y,mainyp] B ~a8  ~obx  0 
          end 
        repeat 

&dA &d@                                                                              
&dA &d@       Step 9. At this point you have completed the typsetting                
&dA &d@               of a complete system.  Now is the time to look for             
&dA &d@               optional staff lines (i.e., staff line that are                
&dA &d@               flagged to be taken out if they contain nothing                
&dA &d@               but rests.                                                     
&dA 
&dA &d@        New code (&dA12/24/03&d@) added to implement optional staff lines 
&dA 

        if justflag < 2 
          c16 = 0 
          tf11 = f11                        /* number of lines in system; initially f11
          loop for c8 = 1 to f11 
            tsq(c8) = sq(c8) 
            tvst(c8) = vst(c8) 
            tnotesize(c8) = f(c8,14) 
          repeat 

TAKEOUT: 
          y2p = mainyp 
          c9 = 0 
          c10 = 0 
          c11 = 0 
          c12 = 0 
          c13 = 0 

          loop for y3p = y1p to y2p 
            tget [Y,y3p] line 
            if line{1} = "S" 
              c10 = y3p 
            end 
            if line{1} = "L" or line{1} = "l"     /* "l" added &dA12/18/05&d@ 
              ++c9 
              c13 = 0 
              c11 = y3p 
            end 
            if line{1} = "E" 
              c12 = y3p 
              if c13 = 0 or type1_dflag(c9) = ON or type2_dflag(c9) = ON    /* modified &dA01/06/04
&dA 
&dA &d@      Step E-1:  Modify System line 
&dA 
                tget [Y,c10] line2 
                sub = 3 
                c8 = int(line2{sub..})            /* 0 
                c8 = int(line2{sub..})            /* system x 
                c8 = int(line2{sub..})            /* system y 
                c8 = int(line2{sub..})            /* system length 
                c6 = sub 
                c8 = int(line2{sub..})            /* system height 

                if tf11 = 1 
                  tmess = 55 
                  perform dtalk (tmess) 
                end 

                if c9 < tf11 
                  c14 = tsq(c9+1) - tsq(c9) 
                else 
                  c14 = tsq(tf11) - tsq(tf11-1) 

                  c14 += 4 * tnotesize(tf11)      /* staff line thickness for tf11
                  c14 -= 4 * tnotesize(tf11-1)    /* staff line thickness for tf11-1
                  if tvst(tf11) > 0 
                    c14 += tvst(tf11)             /* 2nd line for tf11 
                  end 
                  if tvst(tf11-1) > 0 
                    c14 -= tvst(tf11)             /* 2nd line for tf11-1 
                  end 

                end 
                c8 -= c14                         /* takeout on this "pass" 
                c16 += c14                        /* cumulative total takeout

                c7 = int(line2{sub..})            /* number of parts 
                --c7 

                line2 = line2{1,c6} // chs(c8) // " " // chs(c7) // line2{sub..}
                sub = 1 
                loop for c8 = 1 to c9 
                  if line2{sub..} con "." 
                    ++sub 
                  else 
                    if line2{sub..} con "," 
                      ++sub 
                    else 
                      if line2{sub..} con ":" 
                        ++sub 
                      else 
                        if line2{sub..} con ";" 
                          ++sub 
                        end 
                      end 
                    end 
                  end 
                repeat 
                --sub 
                temp = line2{sub-1,3} 
                line2 = line2 // " " 
MTK: 
                if line2{sub-1} = "(" and line2{sub+1} = ")" 
                  line2 = line2{1,sub-2} // line2{sub} // line2{sub+2..} 
                  --sub 
                  goto MTK 
                end 
                if line2{sub-1} = "[" and line2{sub+1} = "]" 
                  line2 = line2{1,sub-2} // line2{sub} // line2{sub+2..} 
                  --sub 
                  goto MTK 
                end 
                if line2{sub-1} = "{" and line2{sub+1} = "}" 
                  line2 = line2{1,sub-2} // line2{sub} // line2{sub+2..} 
                  --sub 
                  goto MTK 
                end 
                line2 = line2{1,sub-1} // line2{sub+1..} 

                if line2 con "[" 
                  if line2{mpt+1} = "]" 
                    line2 = line2{1,mpt-1} // line2{mpt+2..} 
                  end 
                end 
                if line2 con "{" 
                  if line2{mpt+1} = "}" 
                    line2 = line2{1,mpt-1} // line2{mpt+2..} 
                  end 
                end 

                tput [Y,c10] ~line2 
&dA 
&dA &d@      Step E-2:  Eliminate the records between  c11  and  c12; also adjust all Line records
&dA 
                c15 = c12 - c11 + 1 
                loop for c14 = c12 + 1 to y2p 
                  tget [Y,c14] line2 
                  if line2{1} = "L" or line2{1} = "l"    /* "l" added &dA12/18/05
                    c8 = int(line2{3..}) 
                    if c9 < tf11 
                      c8 = c8 + tsq(c9) - tsq(c9+1) 
                    end 
                    line2 = line2{1} // " " // chs(c8) // line2{sub..}  /* Modified &dA12/18/05
                  end 
                  tput [Y,c14-c15] ~line2 
                repeat 
                mainyp -= c15 
&dA 
&dA &d@      Step E-4:  If c9 = 1, turn on the measure numbers for the new top line
&dA &d@                            and turn on any "top line" directives that might
&dA &d@                            be present in the line    
&dA &d@                                                      
                if c9 = 1 
                  loop for c14 = c11 to mainyp 
                    tget [Y,c14] line2 
                    line2 = line2 // pad(40) 
                    if line2{1,2} = "W " 
                      c8 = int(line2{2..})             /* x offset 
                      c8 = int(line2{sub..})           /* y offset 
                      c7 = sub                         /* c7 -> space before font number
                      c8 = int(line2{sub..}) 
                      if c8 = 0                        /* directive has been "turned off"
                        c17 = sub                      /* c17 -> space after font number
                        if line2{c17+1} = "(" 
                          c8 = int(line2{c17+2..})     /* proper font is in ()
                          if c8 <> 0 
                            c17 = sub + 1              /* c17 -> space after ")"
                          else 
                            c8 = M_NUM_FONT 
                          end 
                        else 
                          c8 = M_NUM_FONT 
                        end 
                        line2 = line2{1,c7} // chs(c8) // line2{c17..} 
                        tput [Y,c14] ~line2 
                      end 
                    else 
                      if line2{1} = "E"                /* Exit loop 
                        c14 = mainyp 
                      end 
                    end 
                  repeat 
                end 
&dA 
&dA &d@      Step E-5:  Adjust tsq(.), tvst(.), tnotesize(.), bottom_sq, tf11, 
&dA &d@                   type1_dflag, type2_dflag, to match with system of 1 fewer lines.
&dA &d@                                                      
                if c9 < tf11 
                  c10 = tsq(c9+1) - tsq(c9) 
                  loop for c8 = c9 + 1 to tf11 
                    tsq(c8-1) = tsq(c8) - c10 
                    tvst(c8-1) = tvst(c8) 
                    tnotesize(c8-1) = tnotesize(c8) 
                    type1_dflag(c8-1) = type1_dflag(c8)        /* New &dA01/06/04
                    type2_dflag(c8-1) = type2_dflag(c8)        /*  "     " 
                  repeat 
                end 
                --tf11 
                bottom_sq = tsq(tf11) 
&dA 
&dA &d@      Step E-6:  Circle back to top of process; look for more lines to take out
&dA 
                goto TAKEOUT 
              end 
            end 
&dA 
&dA &d@      This "J" section looks for legitimate musical notation in the line; 
&dA &d@        sets c13 = 1, if found. 
&dA 
            if line{1} = "J" 
              if "GQNRr" con line{3}                   /* New &dA10/28/07&d@ 
                if line{3} <> "R" and line{3} <> "r"   /* New &dA10/15/07&d@ 
                  c13 = 1 
                else 
                  if line{3,3} <> "R 9" and line{3,3} <> "r 9"   /* New &dA10/15/07
                    if line{3} <> "r"                            /* New &dA10/15/07
                      c13 = 1 
                    end 
                  else 
                    sub = 7 
                    c8 = int(line{sub..})    /* obx 
                    c8 = int(line{sub..})    /* oby 
                    c8 = int(line{sub..})    /* pcode 
                    c8 = int(line{sub..})    /* "1" 
                    c8 = int(line{sub..})    /* inctype 
                    if c8 <> 10001 and line{3} <> "r"            /* New &dA10/15/07
                      c13 = 1 
                    end 
                  end 
                end 
              end 
            end 
          repeat 
&dA 
&dA &d@   Cleanup Section:  Fix all "stray" Q records and 10001 inctypes 
&dA 
          loop for y3p = y1p to y2p 
            tget [Y,y3p] line 
            if line{1,3} = "Q R" or line{1,3} = "Q r"     /* New &dA10/15/07&d@ 
              line = "J R " // line{5..}                  /* New &dA10/15/07&d@ 
              tput [Y,y3p] ~line 
            end 
            if line{1,6} = "J R 9 " or line{1,6} = "J r 9 "   /* New &dA10/15/07
              sub = 7 
              c8  = int(line{sub..})    /* obx 
              c9  = int(line{sub..})    /* oby 
              c10 = int(line{sub..})    /* pcode 
              c11 = int(line{sub..})    /* "1" 
              c11 = int(line{sub..})    /* inctype 
              if c11 = 10001 
                line = "J R 9 " // chs(c8) // " " // chs(c9) // " " // chs(c10) // " 1 0" // line{sub..}
                tput [Y,y3p] ~line 
              end 
            end 
&dA 
&dA &d@    /* New &dA10/15/07&d@ 
&dA 
             if line{1,3} = "J r" 
               line = "J R " // line{5..}                  /* New &dA10/15/07&d@ 
               tput [Y,y3p] ~line 
             end 
&dA    
          repeat 
&dA 
&dA &d@   Cleanup, part II:  Re-set bottom of system 
&dA 
          if c16 > 0 
            sys_bottom -= c16 
          end 
        end 
&dA 
&dA &d@   End of &dA12/24/03&d@ addition 
&dA 
        if justflag < 2 
          ++psysnum 
        end 
&dA &d@                                                                  
&dA &d@      Step 10. Now we have the final sq(.)'s and we can check to  
&dA &d@               see of we have "overrun" the bottom of the page.   
&dA &d@               If so, we need to start a new page and reset the   
&dA &d@               height of the system to top of the page.  If this  
&dA &d@               is the first system on the first page, and we have 
&dA &d@               overrun the bottom, the program needs to report    
&dA &d@               this condition and HALT.                           
&dA 
&dA &d@    New page control code &dA12/24/03&d@ 
&dA 
        if justflag < 2 
          c16 = sys_bottom 
&dA 
&dA &d@     Step 0:  Report on progress
&dA 
          if (Debugg & 0x0a) > 0 
            pute .w3 ~(page+1)  .w1 measure ~mnum 
          end 

          if c16 > lowerlim 
&dA 
&dA &d@     Step 1:  Setup new page and tranfer all but the last system 
&dA 
            page = page + 1 
            if page < 10 
              outfile = outlib // "/0" // chs(page) 
            else 
              outfile = outlib // "/" // chs(page) 
            end 
            t6 = sv_mainyp 
            if t6 = 1 
              t6 = mainyp 
            end 

            if t6 > 0 
              perform output_page (t6) 
            else 
              --page 
            end 
&dA 
&dA &d@     Step 2:  Move last system to top of table; fix system line.  
&dA &d@                There will be a new value of mainyp 
&dA 
            treset [T] 
            c14 = 1 
            c15 = t6 + 1 
            if t6 < mainyp 
              tget [Y,c15] line 
              c10 = int(line{3..})         /* 0 
              c11 = int(line{sub..})       /* x co-ordinate of system on page
              c12 = int(line{sub..})       /* y co-ordinate of system on page
              line = line{sub..} 
              c13 = c12 - toplim           /* amount by which system is moved "up"
              c12 = toplim 
              line = "S " // chs(c10) // " " // chs(c11) // " " // chs(c12) // line
              tput [T,c14] ~line 

              loop for c15 = sv_mainyp + 2 to mainyp 
                tget [Y,c15] line 
                ++c14 
                tput [T,c14] ~line 
              repeat 
            else 
              c14 = 0 
            end 
            treset [Y] 
&dA 
&dA &d@     Step 3:  Load last system into top of Y table.  Increment mainyp 
&dA 
            loop for mainyp = 1 to c14 
              tget [T,mainyp] line 
              tput [Y,mainyp] ~line 
            repeat 
            mainyp = c14 
&dA 
&dA &d@     Step 4:  Adjust value of bottom_sq  (sq(f11)) 
&dA 
            bottom_sq -= c13 
            sys_bottom -= c13 
          end 
        end 
&dA   

&dA &d@                                                                  
&dA &d@      Step 11. If task is not complete, jump to top of general    
&dA &d@               music system loop                                  
&dA &d@                                                                  

        if endflag = 1 
          goto FINE 
        end 
        goto CHH 
&dA &d@                                                                  
&dA &d@        IV. End of program                                        
&dA &d@                                                                  
&dA &d@            Normal exit                                           
&dA &d@                                                                  
FINE: 
        if justflag < 2 
          if mainyp > 0 
            page = page + 1 
            if page < 10 
              outfile = outlib // "/0" // chs(page) 
            else 
              outfile = outlib // "/" // chs(page) 
            end 
            old_sys_bottom = 0                 /* do this for last page only
            perform output_page (mainyp) 
          end 
        end 

        if justflag > 1 
          if (Debugg & 0x0a) > 0 
            pute 
          end 
&dA 
&dA &d@    New code &dA05/28/05&d@ for mid-movement justification 
&dA 
          t1 = 0 
          t2 = 1 
          start_sys = 0 
          start_look = 1 
&dA 
&dA &d@     New code &dA10/15/07&d@ to fix a corner case.  I actually think there may 
&dA &d@     be more to it than this, but this fix is a start.  
&dA 
          loop for t9 = 1 to syscnt 
            if sysbarpar(t9,5) > sysbarpar(t9,1) 
              sysbarpar(t9,5) = 0 
            end 
          repeat 
          loop for t9 = 1 to syscnt 
            if sysbarpar(t9,5) > 0 
              ++t1 

              if start_sys = 0 
                if sysbarpar(t9,5) < sysbarpar(t9,1) 
                  new_syscnt(t1) = t9 
                  if new_maxsystems(t1) = 0 
                    new_maxsystems(t1) = t9 
                  end 
                  start_sys = t1 
                  start_look = t2 

                else 
                  if t9 = syscnt 
                    start_sys = t1 
                    start_look = t2 

                    new_syscnt(t1) = syscnt 
                    if new_maxsystems(t1) = 0 
                      new_maxsystems(t1) = syscnt 
                    end 
                  end 
                end 
                t2 = t9 + 1 
              end 
            end 
HERE: 

          repeat 

          if t1 < 2 
            goto OLD_JUST 
          end 

          section_cnt = t1 

          if (Debugg & 0x0a) > 0 
            pute Execute New Just 
          end 

          mspace(mcnt) += deadspace * 100000 
          t10 = 1 
          loop for t9 = 1 to mcnt 
            if mspace(t9) > 100000 
              t11 = mspace(t9) / 100000 
              mspace(t9) = rem 
              mspace2(t9) = rem 
              loop for t7 = t10 to t9 
                mspace(t7) -= t11 
              repeat 
              loop for t7 = t9 to t10 + 1 step -1 
                mspace(t7) -= mspace(t7-1) 
              repeat 
              t10 = t9 + 1 
            else 
              mspace2(t9) = mspace(t9) 
            end 
          repeat 

          loop for t1 = start_sys to section_cnt 
            if no_action = t1 
              no_action = 0 
              goto NEXT_JUST 
            end 

            t10 = 0 
            t11 = 0 
            loop for t9 = start_look to new_syscnt(t1) 
              t10 += sysbarpar(t9,2) 
              ++t11 
            repeat 
            if t11 > 0 
              average_extra = t10 / t11 
            else 
              goto REALWORK                        /* New &dA11/23/07&d@    Another cluge.
            end 

            if new_syscnt(t1) > new_maxsystems(t1) 

              if (Debugg & 0x0a) > 0 
                pute We have inadvertantly overstepped our target size for section ~t1
              end 
              ++sysbarpar(lastk,3) 
              new_start_look = lastk + 1 
              start_look = lastk + 1 
              if old_extra < 2 * average_extra or lastk >= new_syscnt(t1) - 1
                if (Debugg & 0x0a) > 0 
                  pute We must go back to a previous solution for this section.
                end 
                no_action = t1 
                goto REALWORK 
              end 

              t10 = 1000000 
              t11 = 0 
              loop for t9 = start_look to new_syscnt(t1) 
                if old_sysbarpar(t9,2) < t10 
                  t11 = t9 
                  t10 = old_sysbarpar(t9,2) 
                end 
              repeat 
              if t10 = 1000000 
                if (Debugg & 0x0a) > 0 
                  pute No more situations can be found to improve the layout for
                  pute this section.  We must use the present configuration.
                end 
                goto NEXT_JUST 
              end 

              if (Debugg & 0x0a) > 0 
                pute We will try advancing a measure from system ~t11 
              end 
              justflag = 3 
              lastk = t11 
              sysbarpar(t11,3) = old_sysbarpar(t11,1) - 1 
              goto REALWORK 
            end 

            t2 = new_syscnt(t1) 
            t4 = mcnts(t2) + 1 

            t3 = sysbarpar(t2,5) + mcnts(t2) 
            t3 = rmarg - mspace2(t3) 
&dA 
&dA &d@     Step 1: if sysbarpar(t2,2) < 0, then automatically move measure to next system
&dA 
            if sysbarpar(t2,2) < 0 
              t11 = t2 
              if (Debugg & 0x0a) > 0 
                pute The current configuration has too many bars on the last line of
                pute of this section.  We must move the final bar forward to the next section.
                pute System ~t11  is the one affected.  We will recalculate with this change.
              end 
              justflag = 3 
              lastk = t11 
              sysbarpar(t11,3) = sysbarpar(t11,1) - 1 
              goto REALWORK 
            end 

            if (Debugg & 0x0a) > 0 
              pute Currently there are ~sysbarpar(t2,1)  bars on the last system in
              pute   section ~t1 , and ~sysbarpar(t2,2)  units of extra space on the line.
            end 
            old_extra = sysbarpar(t2,2) 
&dA 
&dA &d@     Step 2: if number of bars is currect and distribution is average, then 
&dA &d@               this section is finished 
&dA 
            if sysbarpar(t2,1) <= sysbarpar(t2,5) 
              if sysbarpar(t2,2) < average_extra 
                if (Debugg & 0x0a) > 0 
                  pute It turns out that this is less than the average for all of the
                  pute systems in this section.  In this case, we should not try to
                  pute reconfigure the systems, but should go with the present configuration.
                end 
                goto NEXT_JUST 
              end 
            end 
&dA 
&dA &d@     Step 3: if number of bars is currect and this section has only one system, them
&dA &d@               this section is finished 
&dA 
            if sysbarpar(t2,1) <= sysbarpar(t2,5) 
              if t1 = 1 
                t10 = new_syscnt(t1) 
              else 
                t10 = new_syscnt(t1) - new_syscnt(t1-1) 
              end 
              if t10 = 1 
                if (Debugg & 0x0a) > 0 
                  pute This section consists of only a single line.  We will justify.
                  pute 
                end 
                goto NEXT_JUST 
              end 
            end 
&dA 
&dA &d@     Step 4: Look at option of throwing a measure from the previous system onto
&dA &d@               last system of this section. 
&dA 
            t10 = 0 
            loop for t4 = 1 to t2 - 1 
              t10 += sysbarpar(t4,1) 
            repeat 

            if t10 > 0 
              if (Debugg & 0x0a) > 0 
                pute Throwing a measure from the previous system onto the last line
                pute would add ~mspace(t10)  units to the line.  
              end 
            end 
&dA 
&dA &d@     Step 4a: Do if only if the average can be improved 
&dA 
            if (average_extra > sysbarpar(t2,2)) or (t10 = 0) 
              if (Debugg & 0x0a) > 0 
                pute Currently, the computed average_extra space = ~average_extra , and this
                pute is greater than the number of extra units ~sysbarpar(t2,2)  on the
                pute last system, so moving forward a measure will not improve the situation.
              end 
            else 
&dA 
&dA &d@     Step 4b: Do if only if added space fits              
&dA 
              if mspace(t10) > t3 
                if (Debugg & 0x0a) > 0 
                  pute As it turns out, the amount of space ~mspace(t10)  added to the
                  pute to the last system exceeds the available space ~t3  so
                  pute no forward movement is possible at this time.  
                end 
              else 
&dA 
&dA &d@     Step 4c: Look backward through systems for the one with the least extra space
&dA &d@                (since we are going to be increasing this space) 
&dA 
                t7 = mspace(t10) 
                t10 = 1000000 
                t11 = 0 

                t6 = start_look 
                if new_start_look > t6 
                  t6 = new_start_look 
                end 

                loop for t9 = t6 to t2 - 1 
                  if sysbarpar(t9,4) < t10 
                    a4 = abs(sysbarpar(t9,2) - sysbarpar(t2,2)) 
                    a5 = abs(sysbarpar(t9,4) - sysbarpar(t2,2) + t7) 
                    if a4 > a5 
                      t11 = t9 
                      t10 = sysbarpar(t9,4) 
                    end 
                  end 
                repeat 
&dA 
&dA &d@     Step 4d: Only if t10 <> 1000000 has a prospect been found 
&dA 
                if t10 <> 1000000 
                  if (Debugg & 0x0a) > 0 
                    pute System ~t11  is the best system from which to advance a measure.
                    pute We will recalculate with this change.  
                  end 
                  justflag = 3 
                  lastk = t11 
                  sysbarpar(t11,3) = sysbarpar(t11,1) - 1 
                  goto REALWORK 
                end 
              end 
            end 
&dA 
&dA &d@     Step 5: If there are extra measures on the last system, then move one of these
&dA &d@               into the next section.  
&dA 
            if sysbarpar(t2,1) > sysbarpar(t2,5) 
              t6 = sysbarpar(t2,1) - sysbarpar(t2,5) 
              t11 = t2 
              if (Debugg & 0x0a) > 0 
                pute Section ~t1  has ~t6  extra bars in the last line.  We need to throw one
                pute these to the next section.  
                pute System ~t11  is the one affected.  We will recalculate with this change.
              end 
              justflag = 3 
              lastk = t11 
              sysbarpar(t11,3) = sysbarpar(t11,1) - 1 
              goto REALWORK 
            end 
&dA 
&dA &d@     Step 6: Follow normal procedure 
&dA 
            if (Debugg & 0x0a) > 0 
              pute Normal procedure being followed 
              pute Currently there are ~sysbarpar(t2,1)  bars on the last system in
              pute   section ~t1 , and ~t3  units of extra space on the line.
            end 
            old_extra = sysbarpar(t2,2) 

            if sysbarpar(t2,2) < average_extra 
              if (Debugg & 0x0a) > 0 
                pute It turns out that this is less than the average for all of the
                pute systems in this section.  In this case, we should not try to
                pute reconfigure the systems, but should go with the present configuration.
              end 
              goto NEXT_JUST 
            end 

            if t1 = 1 
              t10 = new_syscnt(t1) 
            else 
              t10 = new_syscnt(t1) - new_syscnt(t1-1) 
            end 
            if t10 = 1 
              if (Debugg & 0x0a) > 0 
                pute This section consists of only a single line.  We will justify.
                pute 
              end 
              goto NEXT_JUST 
            end 

            t10 = 0 
            loop for t4 = 1 to t2 - 1 
              t10 += sysbarpar(t4,1) 
            repeat 

            if (Debugg & 0x0a) > 0 
              pute Throwing a measure from the previous system onto the last line
              pute would add ~mspace(t10)  units to the line.  
            end 

            if mspace(t10) > sysbarpar(syscnt,2) 
              if (Debugg & 0x0a) > 0 
                pute Since this is more than we can use, we must go with the present
                pute configuration for this section.  We will justify the current last line.
                pute 
              end 
              goto NEXT_JUST 
            else 

              t7 = mspace(t10) 
              t10 = 1000000 
              t11 = 0 

              t6 = start_look 
              if new_start_look > t6 
                t6 = new_start_look 
              end 

              loop for t9 = t6 to t2 - 1 
                if sysbarpar(t9,4) < t10 
                  a4 = abs(sysbarpar(t9,2) - sysbarpar(t2,2)) 
                  a5 = abs(sysbarpar(t9,4) - sysbarpar(t2,2) + t7) 
                  if a4 > a5 
                    t11 = t9 
                    t10 = sysbarpar(t9,4) 
                  end 
                end 
              repeat 

              if t10 = 1000000 
                if (Debugg & 0x0a) > 0 
                  pute No more situations can be found to improve the layout.  We must use the
                  pute present configuration for this section.   We will justify the current
                  pute last line.  
                end 
                goto NEXT_JUST 
              end 

              if (Debugg & 0x0a) > 0 
                pute System ~t11  is the best system from which to advance a measure.
                pute We will recalculate with this change.  
              end 
              justflag = 3 
              lastk = t11 
              sysbarpar(t11,3) = sysbarpar(t11,1) - 1 
              goto REALWORK 
            end 

NEXT_JUST: 
            if new_maxsystems(t1+1) = 0 
              new_maxsystems(t1+1) = new_syscnt(t1+1) 
            end 
          repeat 
          justflag = 1 
          goto REALWORK 

&dA     End of 05/28/05 code for mid-movement justification      

OLD_JUST: 
          t10 = 0 
          loop for t9 = 1 to syscnt 
            t10 += sysbarpar(t9,2) 
          repeat 
          average_extra = t10 / syscnt 

          if justflag = 3 and syscnt > maxsystems 
            if (Debugg & 0x0a) > 0 
              pute We have inadvertantly overstepped our target size.  
            end 
            ++sysbarpar(lastk,3) 
            start_look = lastk + 1 
            if old_extra < 2 * average_extra or lastk >= syscnt - 1 
              if (Debugg & 0x0a) > 0 
                pute We must go back to a previous solution.  
              end 
&dA 
&dA &d@    &dA11/20/06&d@  Restore sysbarpar parameters from a solution that worked 
&dA 
              loop for t9 = 1 to maxsystems 
                sysbarpar(t9,1) = sav_sysbarpar(t9,1) 
                sysbarpar(t9,2) = sav_sysbarpar(t9,2) 
                sysbarpar(t9,3) = sav_sysbarpar(t9,3) 
                sysbarpar(t9,4) = sav_sysbarpar(t9,4) 
                sysbarpar(t9,5) = sav_sysbarpar(t9,5) 
              repeat 
&dA               &d@ End of &dA11/20/06&d@ Addition 

              justflag = 1 
              goto REALWORK 
            end 

            t10 = 1000000 
            t11 = 0 
            loop for t9 = start_look to maxsystems 
              if old_sysbarpar(t9,2) < t10 
                t11 = t9 
                t10 = old_sysbarpar(t9,2) 
              end 
            repeat 
            if t10 = 1000000 
              if (Debugg & 0x0a) > 0 
                pute No more situations can be found to improve the layout.  We must
                pute use the present configuration.   We will justify the current last line.
              end 
              justflag = 1 
              goto REALWORK 
            end 

            if (Debugg & 0x0a) > 0 
              pute We will try advancing a measure from system ~t11 
            end 
            justflag = 3 
            lastk = t11 
            sysbarpar(t11,3) = old_sysbarpar(t11,1) - 1 
            goto REALWORK 
          end 

          mspace(mcnt) += deadspace * 100000 
          t10 = 1 
          loop for t9 = 1 to mcnt 
            if mspace(t9) > 100000 
              t11 = mspace(t9) / 100000 
              mspace(t9) = rem 
              loop for t7 = t10 to t9 
                mspace(t7) -= t11 
              repeat 
              loop for t7 = t9 to t10 + 1 step -1 
                mspace(t7) -= mspace(t7-1) 
              repeat 
              t10 = t9 + 1 
            end 
          repeat 
          if justflag = 2 
            maxsystems = syscnt 
          end 

          if (Debugg & 0x0a) > 0 
            pute Currently there are ~sysbarpar(syscnt,1)  bars on the last 
            pute system and ~sysbarpar(syscnt,2)  units of extra space on the line.
          end 
          old_extra = sysbarpar(syscnt,2) 

          if sysbarpar(syscnt,2) < average_extra 
            if (Debugg & 0x0a) > 0 
#if DMUSE 
              putc It turns out that this is &dAless than&d@ the average for all of the
              putc systems in this piece.  In this case, we should not try to
              putc reconfigure the systems, but should go with the present configuration.
#else 
              pute It turns out that this is less than the average for all of the
              pute systems in this piece.  In this case, we should not try to
              pute reconfigure the systems, but should go with the present configuration.
#endif 
            end 
            justflag = 1 
            goto REALWORK 
          end 
&dA 
&dA &d@    &dA11/20/06&d@  Saving sysbarpar parameters from a solution that worked 
&dA 
          loop for t9 = 1 to maxsystems 
            sav_sysbarpar(t9,1) = sysbarpar(t9,1) 
            sav_sysbarpar(t9,2) = sysbarpar(t9,2) 
            sav_sysbarpar(t9,3) = sysbarpar(t9,3) 
            sav_sysbarpar(t9,4) = sysbarpar(t9,4) 
            sav_sysbarpar(t9,5) = sysbarpar(t9,5) 
          repeat 
&dA               &d@ End of &dA11/20/06&d@ Addition 

          t10 = mcnt - sysbarpar(syscnt,1) 
          if t10 = 0 
            if (Debugg & 0x0a) > 0 
              pute Single line.  We will justify.  
            end 
            justflag = 1 
            goto REALWORK 
          end 

          if (Debugg & 0x0a) > 0 
            pute Throwing a measure from the previous system onto the last line
            pute would add ~mspace(t10)  units to the line.  
          end 

          if mspace(t10) > sysbarpar(syscnt,2) 
            if (Debugg & 0x0a) > 0 
              pute Since this is more than we can use, we must go with the present
              pute configuration.  We will justify the current last line.  
            end 
            justflag = 1 
            goto REALWORK 
          else 
            t7 = mspace(t10) 
            t10 = 1000000 
            t11 = 0 
            loop for t9 = start_look to syscnt - 1 
              if sysbarpar(t9,4) < t10 
                a4 = abs(sysbarpar(t9,2) - sysbarpar(syscnt,2)) 
                a5 = abs(sysbarpar(t9,4) - sysbarpar(syscnt,2) + t7) 
                if a4 > a5 
                  t11 = t9 
                  t10 = sysbarpar(t9,4) 
                end 
              end 
            repeat 
            if t10 = 1000000 
              if (Debugg & 0x0a) > 0 
                pute No more situations can be found to improve the layout.  We must
                pute use the present configuration.   We will justify the current last line.
              end 
              justflag = 1 
              goto REALWORK 
            end 
            if (Debugg & 0x0a) > 0 
              pute System ~t11  is the best system from which to advance a measure.
              pute We will recalculate with this change.  
            end 
            justflag = 3 
            lastk = t11 
            sysbarpar(t11,3) = sysbarpar(t11,1) - 1 
          end 
          goto REALWORK 
        end 

        if (Debugg & 0x0a) > 0 
          pute Total pages = ~page  in ~outlib 
        end 

      return  
&dA 
&dA &d@   End of mskpage processing music data 
&dA 
