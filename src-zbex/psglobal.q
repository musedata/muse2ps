
&dA                                                                  
&dA &d@                                                                &dA 
&dA &d@               Global Variables and Global Program              &dA 
&dA &d@                                                                &dA 
&dA                                                                  

      str out.10000,line.480,temp.480,temp3.480,temp4.160 
      str slurstr.160,slurover.80,slurunder.80 
      str ttext.480,jtype.1 
      str tcode.4(MAX_M),tdata.80(MAX_M,2) 
      str sobl.120(30),tsdata.100(MAX_OBJECTS) 
      str tsr.TSR_LENG(MAX_OBJECTS)                           /* &dA05/14/03&d@ expanded length to 116
      str mrest_line.200                                      /* New &dA03/07/06
      int tv1(MAX_M),tv2(MAX_M),tv3(MAX_M),tv4(MAX_M),tv5(MAX_M) 
      int tiecnt 
      int supcnt,supnums(12) 
      int mf(256),beampar(4,MAX_PASS,BM_SZ)                   /* &dA05/14/03&d@ expanded BM_SZ to 7
      int slurar(8,SL_SIZE),tuar(4,MAX_PASS,4) 
      int super_flag,slur_flag 
      int spc(255),nsp(33),claveax(50),measax(4,50)           /* &dA06/04/08&d@ expanding measax to (4,50)
      int zak(2,7),wak(9),hpar(200),vpar(200),bvpar(35),vpar20 
      int clef_vpos 
      int @n,old@n 
      int notesize,mtfont,twfont,curfont,mdirfont,dtivfont 
      int olddivspq,divspq 
      int cline(MAX_STAFF),clef(MAX_STAFF),key 
      int a1,a2,a5,a6 
      int c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17 
      int beamdata(4,MAX_PASS,31),beamcode(31) 
      int emptyspace(MAX_STAFF,45) 
      int ts(MAX_OBJECTS,TS_SIZE) 
      int sct,oldsct,maxsct,measnum 
      int esnum 
      int tsnum(MAX_PASS) 
      int pre_tsnum(MAX_PASS),pre_ctrarrf(MAX_PASS),pre_try(MAX_PASS) 
      int ntype,f8,inctype,jcode,pcode,passtype,passsize,stem 
      int firstoff,sigflag 
      int obx,oby,sobx,soby,sobcnt,snum 
      int c8flag(MAX_STAFF),transflag(MAX_STAFF),tuflag,passnum,spn 
      int ctrflag(MAX_PASS) 
      int mindist 
      int tnum,tden,nstaves 
      int scnt 
      int vflag 
      int granddist,tword_height,outpnt 
      int note_dur 
      int minshort 
      int global_tpflag 
      int tpflag 
      int pcontrol,px,py,pyy,pxx 
      int putobjpar 
      int repeater_case 
      int textconflag 
      int min_space                                              /* added &dA11/19/07
      int slur_adjust                                            /* added &dA05/01/08

      bstr outslurs.8 
      label E(20),TT(6),SS(21),PSUG(20),TPF(5),TPFF(5),ADJS(5)    /* expanding PSUG &dA05/01/08
      table X(400000),Y(400000) 

      int curvedata(8,4,8) 

      int ndata(20,11) 
      int pcnt 
      int printpos(10) 
      int gl(2,45),gr(2,45) 
      int pseudo_gr(2,45) 
      int pseudo_gl(2,45) 

      int p,x,y,z 
      int m_number 
      int xmindist 
      int opt_rest_flag 
      int fix_next_inctype 

      str hitestr.270 
      str fontspac.18000 

      int XFonts(12,19) 
      int sizenum 
      int kernmap(52,26) 
      int all_real_kernmaps(30,26,26) 
      int revsizes(24) 
      int revmap(400) 

      int art_flag 
      int single_line 
      int stem_change_flag 
      int dot_difference_flag 

      int multirest_flag 
      int key_reprint_flag 
      int mixed_color_flag 

      int suppress_key 
      int font_base,font_height,zero_height 
      int in_line_edslur 
      int large_clef_flag 
      int rest_collapse 

      int how_much_mrest(2) 
&dA 
&dA &d@   Variables initialized by get_options and possibly 
&dA &d@     altered by the control line 
&dA 
      int Cfactor
      int Debugg 
      int Vspace_flag
      int Granddist 
      int Min_space 
      int Just_flag 
      int Length_of_page 
      int Marg_left 
      int Max_sys_cnt
      int Minshort   
      int W(32)   
      int Sys_width  
      int Defeat_flag
      int Notesize  
      int Nparts 
      str Syscode.80 
&dA 
&dA &d@   These variables are new additions to global from mskpage 
&dA 
      int f(32,17),f11,f12 
      str cjtype.1 
      str msk_beamcode.6(MAX_BNOTES),syscode.80,superline.180 
      int ldist,larr(300,MARR_PARS),marr(60,MARR_PARS),larc,marc,tarr(32) 
      int tdist(32,2) 
      int small(300),cflag,dxoff(32),dyoff(32) 
      int rec,crec,drec(32),beamfont 
      int hxpar(25),mhpar(32,25),mvpar(32,41),mvpar20(32) 
      int snode,dincf,maxnotesize,oldbarnum,cntype,coby,cz,csnode 
      int lowerlim,toplim,false_rmarg 
      int superdata(32,N_SUPER,SUPERSIZE) 
      int sp,vst(32),psq(32),x1,x2,y1,y2 
      int bcount,bdata(MAX_BNOTES,2),supernum 
      int mkey(32),mclef(32,2),mtcode(32),savtcode(32) 
      int gbar(2),gbarflag,tplace,w(32) 
      int olddist(32),dvar1,cdv 
      int lpt,intersys,sys_bottom,old_sys_bottom 

      str outfile.280 
      str tacetline.180,mvtline.180 
      str lbyte.1,last_jtype.1 
      int justflag,start_look,sys_count,firstsys 
      int adj_space,small2(300),scnt2 
      int mainyp,pn_left,psysnum,mnum 
      int no_action 
      int zcnt 

      table Z(400000) 
&dA 
&dA &d@   These variables are new additions to global from pspage 
&dA 
      str line2.480,xbyte.1(10) 
      str longslur.800(250) 
      str gstr.8000000 
      str slurpar06.600(11,11,6) 
      str slurpar14.600(11,11,6) 
      str slurpar16.600(11,11,6) 
      str slurpar18.600(11,11,6) 
      str slurpar21.300(11,11,6) 
      str mtloc.100 

      bstr slmap.4500(750) 
      bstr bt.2500(250) 
      bstr dotted.2500 

      int beamt,qwid,stemchar,bthick,backloc(10),uxstart(10),uxstop(10) 
      int ibackloc(10),phpar(63),pvpar(45),pvpar20 
      int underflag,pos(256),urpos(256),underspc(12),hyphspc(12) 
      int beamext(435,12),tiearr(N_SIZES,4,TIE_DISTS,12) 
      int tupldata(7),tbflag 
      int z3 
      int ps_beamdata(MAX_BNOTES,2),expar(8),sitflag 
      int barbreak(10,2),brkcnt,gapsize 
      int music_con(255),Beaminc(255),Wedginc(255),Tieinc(12,255) 
      int postx,posty,slur_edit_flag 
      int figoff(32),nsz(32) 
      int hookbackshift(14) 
      int FA(7500) 
      int scx,scy,scb,scf 
      int glyph_record(140,256) 
      int sd_cnt,st_cnt,ct_cnt,sst_cnt,pd_cnt,pt_cnt,pt_cnt2,ppt_cnt 
      int ycnt,zpnt,zpnt2 

      real slpara(8,55) 

      table NC(100) 
      table SD(200000)               /* slur dictionaries 
      table ST(50000)                /* primary slur table 
      table CT(10000)                /* character table 
      table SST(10000)               /* longslur table 
      table PD(20000)                /* PostScript dictionary output 
      table PT(20000)                /* PostScript character output 
      table PT2(1000)                /* Auxiliary PostScript character output
      table ZZ(2000)                 /* font/glyph usage table 
      table XX(200000)               /* "fontdict" table 
      table PPT(1200000)             /* combined Postscript character output

      glob slurpars: j:/release/internet/linux/compprogs/sparfils/allinone 
      glob postdict: j:/zprogs/apps/postdict 
      glob gfontspac: j:/release/internet/linux/compprogs/fontspac 
      glob gkernspac: j:/release/internet/linux/compprogs/kernspac 

&dA                              
&dA &d@                            &dA 
&dA &d@       Global Program       &dA 
&dA &d@                            &dA 
&dA                              

      putc Autoset -> Mskpage -> &dEPspage&d@ 

&dK &d@     perform get_options 

      perform load_font_stuff 

&dK &d@     perform my_autoset 

&dK &d@     perform my_mskpage 

      perform my_pspage 

      stop 

&dA                                                                       
&dA &d@                                                                     &dA 
&dA &d@             &dA�����������������������������������������Ŀ&d@             &dA 
&dA &d@             &dA�          P R O C E D U R E S            �&d@             &dA 
&dA &d@             &dA�������������������������������������������&d@             &dA 
&dA &d@                                                                     &dA 
&dA                                                                       