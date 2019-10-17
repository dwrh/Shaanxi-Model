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

*## ----- emission calibration

mue0("co2") = ghginv("total",t)/ghginv("total","2008") ;

eft.l(ef) = eftrend(t,ef) ;
eft.l(ef) = eftrend(t,ef) ;
eft.l("co2") = ghginv("total",t) ;
efcap0(ef) = eft.l(ef) ;

chk = sum(i,NonCo2(i)) ;
display$ivb eft.l, chk ;

efi.l(ef,i) = 0 ;
efh.l(ef,h) = 0 ;
the0(k) = 0 ;

*## Impute a fixed percentages of emissions to transport generation other industry and households

*## Electric Power Generation is attributed to LSES
  efi.l("co2","a07Distelec") = eft.l("co2")*ghginv("elec",t)/ghginv("Total",t) ;

*## Transport Services
 chk = sum(itrans,xap.l("c17OilRef",itrans))+sum(h,xac.l("c17OilRef",h)) ;
 chktr(i) = 0 ;
 chktr(itrans) = xap.l("c17OilRef",itrans)/chk ;
 chkh(h) = xac.l("c17OilRef",h)/chk ;
 chk = sum(i,chktr(i)) + sum(h,chkh(h)) ;
 display chktr, chkh, chk ;

 efi.l("co2",itrans) = chktr(itrans)*eft.l("co2")*ghginv("trans",t)/ghginv("Total",t) ;

*## Households

lambdac.fx("co2","c17OilRef",h) = chkh(h)*eft.l("co2")
	*(ghginv("trans",t)/ghginv("Total",t))/xac.l("c17Oilref",h) ;

chk = sum(h,xac.l("c07Distelec",h))/sum(h,xac.l("c07Distelec",h)+xac.l("c08Distgas",h))
display chk ;

lambdac.fx("co2","c07Distelec",h) = chk*(xac.l("c07Distelec",h)/sum(hh,xac.l("c07Distelec",hh)))
	*eft.l("co2")*(ghginv("res",t)/ghginv("Total",t))/xac.l("c07Distelec",h) ;

lambdac.fx("co2","c08Distgas",h) = (1-chk)*(xac.l("c08Distgas",h)/sum(hh,xac.l("c08Distgas",hh)))
	*eft.l("co2")*(ghginv("res",t)/ghginv("Total",t))/xac.l("c08Distgas",h) ;

efkh.l("co2",k,h) = mue.l("co2")*lambdac.l("co2",k,h)*xac.l(K,h) ;
efh.l("co2",h) = sum(k,efkh.l("co2",k,h)) ;

*## Impute residual pollution to other sectors

     chke("co2") = eft.l("co2") - sum(i,efi.l("co2",i)) - sum(h,efh.l("co2",h)) ;
     efi.l("co2",ier) = chke("co2")*xap.l("c17OilRef",ier)/sum(jer,xap.l("c17OilRef",jer)) ;
 	  chk = sum(ier, efi.l("co2",ier)) ;

display chke, chk ;
  

display eft.l ;

 
eft.l(ef) = sum(i,efi.l(ef,i)) + sum(h,efh.l(ef,h)) ;

efcap0(ef) = eft.l(ef) ;

*## Add in Non-C02 Equivalent Emissions
     lambdae.fx("co2",i) = efi.l("co2",i)/xp.l(i) ;

   rac("co2",icap) = efi.l("co2",icap)/sum(iicap,efi.l("co2",iicap)) ;

rd.l(j) = efi.l("co2",j) ;
rs.l(i) = rd.l(i) ;

mue.l(ef) = mue0(ef) ;

display eft.l, efi.l, efkh.l, efh.l, mue0, lambdae.l, xp.l, lambdac.l ;
