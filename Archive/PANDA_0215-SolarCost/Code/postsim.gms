* --
* -- PANDA - PRC Aggregate National Development Assessment Model
* --
* --           All rights reserved
* --
* --           David Roland-Holst, Samuel G. Evans
* --           Cecilia Han Springer, and MU Yaqian
* --
* --           Berkeley Energy and Resources, BEAR LLC
* --           1442A Walnut Street, Suite 108
* --           Berkeley, CA 94705 USA
* --
* --           Email: dwrh@berkeley.edu
* --           Tel: 510-220-4567
* --           Fax: 510-524-4591
* --
* --           October, 2016

* --

* -- postscn.gms
* --
* -- This file produces scnulation results in Excel compatible CSV files
* -- Two files are produced for each interval, a reportfile containing desired scnulation variables,
* --      and a samfile containing complete Social Accounting Matrices
* --

* ----- Output the results

put reportfile ;

rscale = scale ;

* ----- Sectoral results

loop(i,
  put scn.tl, t.tl, 'xp',      i.tl, '', 'S1', (rscale*xp.l(i)) / ;
  put$lcsv scn.tl, t.tl, 'pp',      i.tl, '', 'S2', (pp.l(i)) / ;
  put scn.tl, t.tl, 'px',      i.tl, '', 'S2', (px.l(i)) / ;
  put scn.tl, t.tl, 'nd',      i.tl, '', 'S2', (nd.l(i)) / ;
  put$lcsv scn.tl, t.tl, 'va',      i.tl, '', 'S1', (rscale*va.l(i)) / ;
  put scn.tl, t.tl, 'pva',     i.tl, '', 'S2', (pva.l(i)) / ;
) ;

*loop(k$lcsv, put scn.tl, t.tl, 'int',     k.tl, '', 'S1', (rscale*sum(j,xap.l(k,j))) / ; ) ;

loop(kt,
   loop(i,
     put scn.tl, t.tl, 'kd',      i.tl, kt.tl, 'S1', (rscale*kd.l(i,kt)) / ;
     put scn.tl, t.tl, 'rent',    i.tl, kt.tl, 'S2', (rent.l(i,kt)) / ;
     put scn.tl, t.tl, 'lambdak', i.tl, kt.tl, 'S2', (lambdak.l(i,kt)) / ;

loop(g$lcsv,
     put$lcsv scn.tl, t.tl, 'tfk', i.tl, kt.tl, g.tl, (tfk.l(i,kt,g)) / ;
) ;

   ) ;
) ;

*loop(nr,
loop(i$lcsv,
     put scn.tl, t.tl, 'rd',      i.tl, "natr", 'S1', (rd.l(i)/escale) / ;
     put scn.tl, t.tl, 'pr',      i.tl, "natr", 'S1', (pr.l(i)) / ;
loop(g,
     put scn.tl, t.tl, 'tfr',     i.tl, "natr", g.tl, (rscale*tfr.l(i,g)) / ;
) ;
     put scn.tl, t.tl, 'CPrice',  i.tl, "natr", 'S1', (rscale*sum(g,tfr.l(i,g))*pr.l(i)*10000) / ;
*     put scn.tl, t.tl, 'xpad',    i.tl, "xpad", 'S1', (rscale*xpad(i)) / ;

     put scn.tl, t.tl, 'lambdar', i.tl, "natr", 'S2', (lambdar.l(i)) / ;
*     put scn.tl, t.tl, 'lambdae', i.tl, "ene", , (lambdae.l(i)) /;
*     put$lcsv scn.tl, t.tl, 'tfk',     i.tl, kt.tl, 'S2', (tfk.l(i,kt)) / ;
   ) ;
*) ;

loop(lt$lcsv,
   loop(i,
     put scn.tl, t.tl, 'td',      i.tl, lt.tl, '', (rscale*td.l(i,lt)) / ;

loop(g,
     put scn.tl, t.tl, 'tft',     i.tl, lt.tl, g.tl, (tft.l(i,lt,g)) / ;
) ;

     put scn.tl, t.tl, 'pt',      i.tl, lt.tl, 'S2', (pt.l(i,lt)) / ;
     put scn.tl, t.tl, 'lambdat', i.tl, lt.tl, 'S2', (lambdat.l(i,lt)) / ;
   ) ;
) ;

loop(l,
   loop(i, put scn.tl, t.tl, 'ld',      i.tl, l.tl, 'L1', (rscale*ld.l(i,l)) / ; ) ;
   loop(i$lcsv, put scn.tl, t.tl, 'lambdal', i.tl, l.tl, 'L2', (lambdal.l(i,l)) / ; ) ;
   loop(i, put scn.tl, t.tl, 'wage',    i.tl, l.tl, 'L2', (wage.l(i,l)) / ; ) ;
   loop(h$lcsv, put scn.tl, t.tl, 'yhl',     h.tl, l.tl, 'L2', (xlh(h,l)*ly.l(l)) / ; ) ;

loop(g,
   loop(i$lcsv, put scn.tl, t.tl, 'tfl', i.tl, l.tl, g.tl, (tfl.l(i,l,g)) / ; ) ;
) ;

) ;

loop(k$lcsv, put scn.tl, t.tl, 'x',          k.tl, '', 'S1', (rscale*x.l(k)) / ; ) ;
loop(h,
   loop(k, put scn.tl, t.tl, 'xac',     h.tl, k.tl,  'H1', (rscale*xac.l(k,h)) / ; ) ;
*   loop(k, put scn.tl, t.tl, 'mu',     h.tl, k.tl,  'H1', (rscale*mu.l(k,h)) / ; ) ;
   put scn.tl, t.tl, 'eexp',     h.tl, '',  'H1', (rscale*sum(k$erg(k),pa.l(k)*xac.l(k,h))) / ;
   put scn.tl, t.tl, 'erxp',     h.tl, '',  'H1', (rscale*sum(k$erg(k),xac.l(k,h))) / ;
*   loop(k, put scn.tl, t.tl, 'erxp',     h.tl, '',  'H1', (rscale*pa0(k)*eexp.l(k,h)/pa.l(k)) / ; ) ;
) ;

loop(f$lcsv,
   loop(k, put scn.tl, t.tl, 'xaf',     k.tl, f.tl, 'S1', (rscale*xaf.l(k,f)) / ; ) ;
   put scn.tl, t.tl, 'pf',     f.tl, '', 'M2', (pf.l(f)) / ;
   put scn.tl, t.tl, 'xf',     f.tl, '', 'M1', (rscale*xf.l(f)) / ;
   put scn.tl, t.tl, 'yf',     f.tl, '', 'M1', (rscale*yf.l(f)) / ;
) ;

loop(k,
     put$lcsv scn.tl, t.tl, 'xa',  k.tl, '', 'S1', (rscale*xa.l(k)) / ;
     put scn.tl, t.tl, 'xd',  k.tl, '', 'S1', (rscale*xdd.l(k)) / ;
     put scn.tl, t.tl, 'xmt', k.tl, '', 'S1', (rscale*xmt.l(k)) / ;
     put scn.tl, t.tl, 'xet', k.tl, '', 'S1', (rscale*xet.l(k)) / ;
     put$lcsv scn.tl, t.tl, 'p',   k.tl, '', 'S2', (p.l(k))   / ;
     put scn.tl, t.tl, 'pa',  k.tl, '', 'S2', (pa.l(k))  / ;
     put scn.tl, t.tl, 'pd',  k.tl, '', 'S2', (pd.l(k))  / ;
     put$lcsv scn.tl, t.tl, 'pmt', k.tl, '', 'S2', (pmt.l(k)) / ;
     put$lcsv scn.tl, t.tl, 'pet', k.tl, '', 'S2', (pet.l(k)) / ;

     loop(r$lcsv, put scn.tl, t.tl, "xm", k.tl, r.tl, "S3", (rscale*xm.l(k,r)) / ; ) ;
     loop(r$lcsv, put scn.tl, t.tl, "xe", k.tl, r.tl, "S3", (rscale*xe.l(k,r)) / ; ) ;
) ;
     put$lcsv scn.tl, t.tl, 'endem', '', '', 'S2', sum(k$erg(k), pa.l(k)*xa.l(k)) / ;
     put$lcsv scn.tl, t.tl, 'erdem', '', '', 'S2', sum(k$erg(k), xa.l(k)) / ;


put$lcsv scn.tl, t.tl, 'mue',  "", "CO2", 'm2', (mue.l("co2")) / ;
put$lcsv scn.tl, t.tl, 'utef', '', "CO2", 'm2', (utef.l("co2")) / ;

loop((i,ef),  put scn.tl, t.tl, 'efi',  i.tl, ef.tl, 'S2', (efi.l(ef,i) ) / ; ) ;
loop((h,ef),  put scn.tl, t.tl, 'efh',  h.tl, ef.tl, 'S2', (efh.l(ef,h)) / ; ) ;
loop(ef, put scn.tl, t.tl, 'eft',  "", ef.tl, 'm2', (sum(i,efi.l(ef,i)) + sum(h,efh.l(ef,h))) / ; ) ;
loop(ef, put scn.tl, t.tl, 'utef',  "", ef.tl, 'm2', utef.l(ef) / ; ) ;
*loop(ef, put scn.tl, t.tl, 'eft',  "", ef.tl, 'm2', (sum(i,sum(ces,emit(ces,ef) *pa.l(ces)*xap.l(ces,i)*(1-r_feed(ces,i,ef)))) + sum(h,sum(ces,emit(ces,ef) *pa.l(ces)*xac.l(ces,h)))) / ; ) ;
*loop(i,  put scn.tl, t.tl, 'efi',  i.tl, "CO2", 'S2', (xp.l(i)*EF_GHG(i,"GHG_Total")) / ; ) ;
*loop(h,  put scn.tl, t.tl, 'efh',  h.tl, "CO2", 'S2', sum(k,sum(i$mapik(i,k),xac.l(k,h)*EF_GHG(i,"GHG_Total"))) / ; ) ;
*put scn.tl, t.tl, 'eft',  "", "CO2", 'm2',
*	(sum(i,1000*xp.l(i)*EF_GHG(i,"GHG_Total")) + sum((k,h),sum(i$mapik(i,k),xac.l(k,h)*EF_GHG(i,"GHG_Total")))) / ;

*loop(i,  put scn.tl, t.tl, 'efi',  i.tl, "CO2", 'S2', (efi.l("co2",i)/escale) / ; ) ;
*loop(h,  put scn.tl, t.tl, 'efh',  h.tl, "CO2", 'S2', (efh.l("co2",h)/escale) / ; ) ;

efkh.l(ef,k,h) = mue.l(ef)*lambdac.l(ef,k,h)*xac.l(k,h) ;

loop((ces,j), put scn.tl, t.tl, 'EneConsumptionI', ces.tl, j.tl, 'S2', (EneConsumptionI.l(ces,j))  /; );
*put scn.tl, t.tl, 'EneConsumptionT', '', '', '', (EneConsumptionT.l) ;/

loop(k$lcsv, loop(h,  put scn.tl, t.tl, 'efkh',  h.tl, k.tl, 'S2', (efkh.l("co2",k,h)/escale) / ; ) ; ) ;

loop(g$lcsv,
loop(i,  put scn.tl, t.tl, 'tef',  i.tl, "CO2", g.tl, (tef.l("co2",i,g)/escale) / ; ) ;
) ;

*loop(i$lcsv, put scn.tl, t.tl, 'lambdae',  i.tl, "CO2", 'S2', (lambdae.l("co2",i)) / ; ) ;

loop(k$lcsv, loop(h, put scn.tl, t.tl, 'lambdac',  k.tl, h.tl, 'S2', (lambdac.l("co2",k,h)) / ; )) ;

loop(g,
loop(i$lcsv, put scn.tl, t.tl, 'tp',  i.tl, '', g.tl, (tp.l(i,g)) / ; ) ;
loop(k$lcsv, loop(j, put scn.tl, t.tl, 'tcp',  k.tl, j.tl, g.tl, (tcp.l(k,j,g)) / ; )) ;
loop(k$lcsv, loop(h, put scn.tl, t.tl, 'tcc',  k.tl, h.tl, g.tl, (tcc.l(k,h,g)) / ; )) ;
loop(k$lcsv, loop(f, put scn.tl, t.tl, 'tcf',  k.tl, f.tl, g.tl, (tcf.l(k,f,g)) / ; )) ;
) ;

loop(mg$lcsv, loop(k, put scn.tl, t.tl, 'tmg', k.tl, mg.tl, 'S2', (tmg.l(k,mg)) / ; ) ; ) ;

* ----- Macro variables

put scn.tl, t.tl, 'gdpmp',    '', '', 'M1', (rscale*gdpmp.l) / ;
put scn.tl, t.tl, 'rgdpmp',   '', '', 'M1', (rscale*rgdpmp.l) / ;
put scn.tl, t.tl, 'pgdpmp',   '', '', 'M2', (pgdpmp.l) / ;
put scn.tl, t.tl, 'pinc',   '', '', 'M2',
	(sum(l,ly.l(l)) + sum(kt,ky.l(kt)) + sum(lt,ty.l(lt)) + ry.l + sum((h,g),gtrh.l(h,g)) + sum((e,g),gtre.l(e,g))) / ;

put scn.tl, t.tl, 'tcons',   '', '', 'M1', (rscale*sum(k,sum(h,(1+sum(g,tcc0(k,h,g)))*pa0(k)*xac.l(k,h)))) / ;

loop(g,
put scn.tl, t.tl, 'tgov', g.tl, '', 'M1', (rscale*sum(k,(1+sum(gg,tcf0(k,g,gg)))*pa0(k)*xaf.l(k,g))) / ;
) ;

put scn.tl, t.tl, 'tinv', '', '', 'M1', (rscale*sum(k,(1+sum(g,tcf0(k,"capacct",g)))*pa0(k)*xaf.l(k,"capacct"))) / ;
*put$lcsv scn.tl, t.tl, 'tzig',    '', '', 'M1', (rscale*sum(k,(1+tcf0(k,"ginvs"))*pa0(k)*xaf.l(k,"ginvs"))) / ;
*put$lcsv scn.tl, t.tl, 'tdst',    '', '', 'M1', (rscale*sum(k,(1+tcf0(k,"inventory"))*pa0(k)*xaf.l(k,"inventory"))) / ;
*put$lcsv scn.tl, t.tl, 'ttrdmg',  '', '', 'M1', (rscale*sum(k,(1+tcf0(k,"trdmg"))*pa0(k)*xaf.l(k,"trdmg"))) / ;
put scn.tl, t.tl, 'texp',    '', '', 'M1', (rscale*sum(k,sum(r,er0(r)*wpe0(k,r)*xe.l(k,r)))) / ;
put scn.tl, t.tl, 'timp',    '', '', 'M1', (rscale*sum(k,sum(r,er0(r)*wpm0(k,r)*xm.l(k,r)))) / ;

put scn.tl, t.tl, 'pcons',   '', '', 'M1', (100*sum(k,sum(h,(1+sum(g,tcc.l(k,h,g)))*pa.l(k)*xac0(k,h)))
                                                     /sum(k,sum(h,(1+sum(g,tcc0(k,h,g)))*pa0(k)*xac0(k,h)))) / ;

$ontext
loop(g,
if (xf0(g) ne 0, put scn.tl, t.tl, 'pgov',    g.tl, '', 'M1',
   (100*sum(k,(1+sum(gg,tcf.l(k,g,gg)))*pa.l(k)*xaf0(k,g))/sum(k,(1+sum(gg,tcf0(k,g,gg)))*pa0(k)*xaf0(k,g))) / ; ) ;
) ;

if (xf0("capacct") ne 0, put scn.tl, t.tl, 'pinv',    '', '', 'M1',
   (100*sum(k,(1+sum(g,tcf.l(k,"capacct",g)))*pa.l(k)*xaf0(k,"capacct"))/sum(k,(1+sum(g,tcf0(k,"capacct",g)))*pa0(k)*xaf0(k,"capacct"))) / ; ) ;
$offtext

*if (xf0("ginvs") ne 0, put scn.tl, t.tl, 'pzig',    '', '', 'M1',
*   (100*sum(k,(1+tcf.l(k,"ginvs"))*pa.l(k)*xaf0(k,"ginvs"))/sum(k,(1+tcf0(k,"ginvs"))*pa0(k)*xaf0(k,"ginvs"))) / ; ) ;
*if (xf0("inventory") ne 0, put scn.tl, t.tl, 'pdst',    '', '', 'M1',
*   (100*sum(k,(1+tcf.l(k,"inventory"))*pa.l(k)*xaf0(k,"inventory"))/sum(k,(1+tcf0(k,"inventory"))*pa0(k)*xaf0(k,"inventory"))) / ; ) ;
*if (xf0("trdmg") ne 0, put scn.tl, t.tl, 'ptrdmg',    '', '', 'M1',
*   (100*sum(k,(1+tcf.l(k,"trdmg"))*pa.l(k)*xaf0(k,"trdmg"))/sum(k,(1+tcf0(k,"trdmg"))*pa0(k)*xaf0(k,"trdmg"))) / ; ) ;


*put scn.tl, t.tl, 'pexp',    '', '', 'M1', (100*er.l(r)*sum(k,sum(r,wpe.l(k,r)*xe0(k,r)))/(er0*sum(k,sum(r,wpe0(k,r)*xe0(k,r))))) / ;
*put scn.tl, t.tl, 'pimp',    '', '', 'M1', (100*er.l(r)*sum(k,sum(r,wpm.l(k,r)*xm0(k,r)))/(er0*sum(k,sum(r,wpm0(k,r)*xm0(k,r))))) / ;

put scn.tl, t.tl, 'gdpfc',    '', '', 'M1', (rscale*gdpfc.l) / ;
put scn.tl, t.tl, 'rgdpfc',   '', '', 'M1', (rscale*rgdpfc.l) / ;
put scn.tl, t.tl, 'pgdpfc',   '', '', 'M2', (pgdpfc.l) / ;
put scn.tl, t.tl, 'pk',       '', '', 'M2', (pk.l) / ;
put scn.tl, t.tl, 'pland',    '', '', 'M2', (pland.l) / ;
put scn.tl, t.tl, 'ggdp',     '', '', 'M2', (ggdp.l) / ;
put scn.tl, t.tl, 'gl',       '', '', 'M2', (gl.l) / ;

loop(g,
put scn.tl, t.tl, 'tary',  g.tl, '', 'M1', (rscale*tary.l(g))  / ;
put scn.tl, t.tl, 'rtary', g.tl, '', 'M1', (rscale*rtary.l(g)) / ;
put scn.tl, t.tl, 'tmadj', g.tl, '', 'M1', (tmadj.l(g))        / ;
put scn.tl, t.tl, 'gy',    g.tl, '', 'M1', (rscale*gy.l(g))    / ;
put scn.tl, t.tl, 'gexp',  g.tl, '', 'M1', (rscale*gexp.l(g))  / ;
put scn.tl, t.tl, 'savg',  g.tl, '', 'M1', (rscale*savg.l(g))  / ;
put scn.tl, t.tl, 'rsg',   g.tl, '', 'M1', (rscale*rsg.l(g))   / ;
put scn.tl, t.tl, 'gtrg', g.tl, '', 'M1', (rscale*sum(gg,gtrg.l(g,gg))) / ;
) ;

put scn.tl, t.tl, 'plev', '', '', 'M2', (plev.l) / ;

loop(g,
put scn.tl, t.tl, 'taxadjh',  g.tl, '', 'M2', (taxadjh.l(g)) / ;
) ;

loop(kt,put scn.tl, t.tl, 'ky',   kt.tl, '', 'M1', (rscale*ky.l(kt)) / ; ) ;
loop(lt,put scn.tl, t.tl, 'ty',   lt.tl, '', 'M1', (rscale*ty.l(lt)) / ; ) ;
loop(lt,put scn.tl, t.tl, 'ry',   lt.tl, '', 'M1', (rscale*ry.l) / ; ) ;

loop(e,
   put scn.tl, t.tl, 'cy',       e.tl, '', 'M1', (rscale*cy.l(e)) / ;
   put scn.tl, t.tl, 'savc',     e.tl, '', 'M1', (rscale*savc.l(e)) / ;
*   put scn.tl, t.tl, 'ctrw',     e.tl, '', 'M1', (rscale*ctrw.l(e,r)) / ;

loop(g,
   put scn.tl, t.tl, 'kappac',   e.tl, g.tl, 'M2', (kappac.l(e,g)) / ;
) ;

   put scn.tl, t.tl, 'csavrate', e.tl, '', 'M2', (csavrate.l(e)) / ;
) ;

loop(kt$lcsv, put scn.tl, t.tl, 'tks',   kt.tl, '', 'M1', (rscale*tks.l(kt)) / ; ) ;
loop(kt$lcsv, put scn.tl, t.tl, 'ptks',  kt.tl, '', 'M2', (ptks.l(kt)) / ; ) ;


loop(l, put scn.tl, t.tl, 'ly', l.tl, '', 'M3', (rscale*ly.l(l)) / ; ) ;

loop(h, put scn.tl, t.tl, 'yh',   h.tl, '', 'H1', (rscale*yh.l(h)) / ; ) ;
loop(h, put scn.tl, t.tl, 'yd',   h.tl, '', 'H1', (rscale*yd.l(h)) / ; ) ;
loop(h, put scn.tl, t.tl, 'savh', h.tl, '', 'H1', (rscale*savh.l(h)) / ; ) ;

loop(g,
loop(h, put scn.tl, t.tl, 'taxh', h.tl, g.tl, 'H1', (rscale*taxadjh.l(g)*kappah.l(h,g)*yh.l(h)) / ; ) ;
) ;

loop(h, put scn.tl, t.tl, 'cpi',  h.tl, '', 'H1', (rscale*cpi.l(h)) / ; ) ;
loop(h, put scn.tl, t.tl, 'fpi',  h.tl, '', 'H1', (rscale*fpi.l(h)) / ; ) ;
loop(h, put scn.tl, t.tl, 'epi',  h.tl, '', 'H1', (rscale*epi.l(h)) / ; ) ;

loop(h$lcsv,
 put scn.tl, t.tl, 'pop',  h.tl, '', 'H1', (pop.l(h)) / ;
 put scn.tl, t.tl, 'htr',  h.tl, '', 'H1', (rscale*htr.l(h)) / ;
 put scn.tl, t.tl, 'htrh', h.tl, '', 'H1', (rscale*sum(hh,htrh.l(h,hh))) / ;
* put scn.tl, t.tl, 'htrw', h.tl, '', 'H1', (rscale*htrw.l(h)) / ;

loop(g,
 put scn.tl, t.tl, 'gtrh',   h.tl, g.tl, 'H1', (rscale*gtrh.l(h,g)) / ;
 put scn.tl, t.tl, 'kappah', h.tl, g.tl, 'H2', (kappah.l(h,g)) / ;
) ;

) ;

* ----- Trade block

loop(r,
	put scn.tl, t.tl, 'er',   '', r.tl, 'M2', (er.l(r)) / ;
	put scn.tl, t.tl, 'savf', '', r.tl, 'M1', (rscale*savf.l(r)) / ;

	loop(k, put scn.tl, t.tl, 'xm', k.tl, r.tl, 'T1', (rscale*xm.l(k,r)) / ; ) ;
   loop(k, put scn.tl, t.tl, 'xe', k.tl, r.tl, 'T1', (rscale*xe.l(k,r)) / ; ) ;

   loop(k, put scn.tl, t.tl, 'pm',     k.tl, r.tl, 'T2', (pm.l(k,r)) / ; ) ;
*   loop(k, put scn.tl, t.tl, 'wpm',    k.tl, r.tl, 'T2', (wpm.l(k,r)) / ; ) ;
   loop(k, put scn.tl, t.tl, 'pe',     k.tl, r.tl, 'T2', (pe.l(k,r)) / ; ) ;
*   loop(k, put scn.tl, t.tl, 'wpe',    k.tl, r.tl, 'T2', (wpe.l(k,r)) / ; ) ;
*   loop(k, put scn.tl, t.tl, 'wpendx', k.tl, r.tl, 'T2', (wpendx.l(k,r)) / ; ) ;

loop(g,
   loop(k, put scn.tl, t.tl, 'tm', k.tl, r.tl, g.tl, (tm.l(k,r,g)) / ; ) ;
*   loop(k, put scn.tl, t.tl, 'te', k.tl, r.tl, 'T2', (te.l(k,r)) / ; ) ;
) ;
) ;

* ----- Factor block

loop(gz,
   loop(l$(ls.l(l,gz) ne 0), put scn.tl, t.tl, "ls",    l.tl, gz.tl, 'L3', (ls.l(l,gz)/pscale) / ;) ;
   loop(l$(ls.l(l,gz) ne 0), put scn.tl, t.tl, "ewage", l.tl, gz.tl, 'L4', (ewage.l(l,gz)) / ;) ;
) ;

loop(l$lcsv, put scn.tl, t.tl, "migr", l.tl, '', 'L3', (migr.l(l)/pscale) / ;) ;
