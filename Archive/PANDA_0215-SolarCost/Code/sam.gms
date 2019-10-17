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

* -- sam.gms
* --
* ------------------------------------------------------------------------------
*
* Calculate the SAM based on model variables
*
* ------------------------------------------------------------------------------

samCSV(s,ss) = 0 ;

* ----- Production block

samCSV(k,j)       = pa.l(k)*a.l(k,j)*nd.l(j) ;

samCSV(l,j)       = wage.l(j,l)*ld.l(j,l)/(1+sum(g,tfl.l(j,l,g))) ;
samCSV(kt,j)      = rent.l(j,kt)*kd.l(j,kt)/(1+sum(g,tfk.l(j,kt,g))) ;
samCSV(lt,j)      = pt.l(j,lt)*td.l(j,lt)/(1+sum(g,tft.l(j,lt,g))) ;
samCSV(nr,j)      = pr.l(j)*rd.l(j)/(1+sum(g,tfr.l(j,g))) ;
*samCSV(g,j) = tp.l(j,g)*px.l(j)*xp.l(j) + sum(k,tcp.l(k,j,g)*pa.l(k)*xap.l(k,j)) ;
samCSV(g,l) = sum(j,tfl.l(j,l,g)*wage.l(j,l)*ld.l(j,l)/(1+tfl.l(j,l,g))) ;
samCSV(g,kt) =   + sum(j,tfk.l(j,kt,g)*rent.l(j,kt)*kd.l(j,kt)/(1+tfk.l(j,kt,g))) ;
samCSV(g,lt) =   + sum(j,tft.l(j,lt,g)*pt.l(j,lt)*td.l(j,lt)/(1+tft.l(j,lt,g))) ;

*samCSV(g,r) =   + tfr.l(j)*pr.l(j)*rd.l(j)/(1+tfr.l(j)) ;
*samCSV("vat",j) = sum(l,tfl.l(j,l)*wage.l(j,l)*ld.l(j,l)/(1+tfl.l(j,l)))
*               + sum(kt,tfk.l(j,kt)*rent.l(j,kt)*kd.l(j,kt)/(1+tfk.l(j,kt)))
*               + sum(lt,tft.l(j,lt)*pt.l(j,lt)*td.l(j,lt)/(1+tft.l(j,lt)))
*               + tfr.l(j)*pr.l(j)*rd.l(j)/(1+tfr.l(j)) ;
samCSV(g,j) = sum(k,tcp.l(k,j,g)*pa.l(k)*xap.l(k,j)) ;

samCSV(g,k) = sum(r,tm.l(k,r,g)*er.l(r)*wpm.l(k,r)*xm.l(k,r)) ;
*samCSV("xduty",k) = sum(r,te.l(k,r)*er.l(r)*wpe.l(k,r)*xe.l(k,r)) ;

samCSV(r,k)       = er.l(r)*wpm.l(k,r)*xm.l(k,r) ;

*== there are problems in the following two equations
*samCSV(j,k)$(mapik(j,k)) = xp.l(j)*pp.l(j) ;

*samCSV(k,kk) = pa.l(k)*sum(mg,xamg.l(k,kk,mg)) ;

* ----- Income distribution

samCSV(h,l)         = xlh(h,l)*ly.l(l) ;

samCSV(h,nr)        = xrh(h)*ry.l ;

samCSV(e,kt)        = xke(kt,e)*ktre.l(kt) ;
samCSV(h,kt)        = xkh(kt,h)*ktrh.l(kt) ;
samCSV(r,kt)    	= xkw(kt,r)*ktrw.l(kt,r) ;

samCSV(h,lt)        = xth(lt,h)*ty.l(lt) ;

samCSV(g,e)   = kappac.l(e,g)*cy.l(e) ;
samCSV("capacct",e)   = savc.l(e) ;
samCSV(h,e)         = xch(e,h)*ctrh.l(e) ;
samCSV(r,e)     = xcw(e,r)*ctrw.l(e,r) ;

* ---- Household accounts

samCSV(k,h)       = pa.l(k)*xac.l(k,h) ;
samCSV(g,h) = sum(k,tcc.l(k,h,g)*pa.l(k)*xac.l(k,h)) ;
samCSV("capacct",h) = savh.l(h) ;
samCSV(hh,h)      = htrh.l(hh,h) ;
samCSV(g,gg)      = gtrg.l(g,gg) ;
samCSV(g,h) = taxadjh.l(g)*kappah.l(h,g)*yh.l(h) ;
samCSV(r,h)   = htrw.l(h,r) ;

* ----- Final demand accounts

samCSV(k,f)         = pa.l(k)*xaf.l(k,f) ;
*??samCSV(g,f)   = sum(k,tcf.l(k,f,g)*pa.l(k)*xaf.l(k,f)) ;
samCSV(h,g)       = plev.l*gtrh.l(h,g) ;
samCSV("capacct",g) = savg.l(g) ;
samCSV(r,g)   = er.l(r)*gtrw.l(r,g) ;
samCSV(g,gg)  = gtrg.l(g,gg) ;

*samCSV("govt","capacct") = yf.l("ginvs") ;
*samCSV("inventory","capacct") = yf.l("inventory") ;

* ----- Tax revenues

**samCSV(g,g)$g(g) = sum(k,sum(r,er.l(r)*tm.l(k,r,g)*wpm.l(k,r)*xm.l(k,r))) ;
*samCSV("govt","itax") = sum(i,tp.l(i)*px.l(i)*xp.l(i)) ;
**samCSV("govt","govt") = taxadjh.l*sum(h,kappah.l(h)*yh.l(h)) + sum(e,kappac.l(e)*cy.l(e)) ;
*samCSV("govt","xduty") = sum(k,sum(r,pe.l(k,r)*(1+tmg.l(k,"x"))*xe.l(k,r)*te.l(k,r))) ;

*samCSV("govt","indtx") = sum(k,pa.l(k)*(sum(j,tcp.l(k,j)*xap.l(k,j)) + sum(h,tcc.l(k,h)*xac.l(k,h))
*                     + sum(f,tcf.l(k,f)*xaf.l(k,f)))) ;

*samCSV("govt","vat") = sum(j,samCSV("vat",j)) ;
*samCSV("govt",v) = sum(j,vatax(v,j)) ;

* ----- BoP inflows

samCSV(k,r)       = er.l(r)*wpe.l(k,r)*xe.l(k,r) ;
*samCSV("xduty",k) = sum(r,pe.l(k,r)*(1+tmg.l(k,"x"))*xe.l(k,r)*te.l(k,r)) ;
samCSV(h,r)   = er.l(r)*wtrh.l(h,r) ;
samCSV(g,r) = er.l(r)*wtrg.l(r,g) ;
samCSV("capacct",r) = er.l(r)*savf.l(r) ;
*samCSV("trdmg",r) = yf.l("trdmg") ;
samCSV(r,r) = sum(k,samCSV(k,r)) - sum(k,samCSV(r,k)) ;

display sam, samCSV;

* ------------------------------------------------------------------------------
*
* Write out the SAM in CSV format
*
* ------------------------------------------------------------------------------
*$ontext

put samout ;
samout.pc   = 5 ;
samout.pw = 10000 ;
samout.nj =   1 ;
samout.nw =  15 ;
samout.nd =   9 ;
samout.nz =   0 ;
samout.nr =   0 ;


*loop(s,loop(ss$(samCSV(s,ss) ne 0),
*   put system.title,t.tl,s.tl,ss.tl,(samCSV(s,ss)/scale) / ;
*)) ;

put 'SAM'; loop (s, put s.tl ) ; put / ;
loop(s,
put  s.tl, loop(ss, put samCSV(s,ss)) ; put / ;

 ) ;

*$offtext
