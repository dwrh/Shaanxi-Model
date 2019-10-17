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

*
* Initialize the variables
*
* ------------------------------------------------------------------------------

* ----- Basic prices

p0(k)        = 1 ;
pa0(k)      = 1 ;
pp0(i)       = 1 ;
pd0(k)      = 1 ;
pmt0(k)     = 1 ;
wpm0(k,r)   = 1 ;
pet0(k)     = 1 ;
wpe0(k,r)   = 1 ;
*wage0(i,l)  = 1 ;
rent0(i,kt) = 1 ;
pt0(i,lt)   = 1 ;
pr0(i)      = 1e-8 ;
*pr0(i)      = .007 ;
rysh("govt") = 1 ;

plev0       = 1 ;
er0(r)      = 1 ;

ifcap(ef) = 0 ;

* ------------------------------------------------------------------------------
*
* Initialize the trade block
*
* This must be the first step due to the possibility of the law of one price
*
* ------------------------------------------------------------------------------
*
* ----- Second level Armington

tm0(k,r,"govt") = wtf_pm0(r,k)-sam(r,k) ;
xm0(k,r) = sam(r,k)/(wpm0(k,r)*er0(r)) ;

tm0(k,r,g)$(xm0(k,r) ne 0) = tm0(k,r,g)/(er0(r)*wpm0(k,r)*xm0(k,r)) ;
pm0(k,r) = er0(r)*wpm0(k,r)*(1+sum(g,tm0(k,r,g))) ;

* ----- Calculate pre-FOB price of exports

xe0(k,r) = (sam(k,r))/(er0(r)*wpe0(k,r)) ;
te0(k,r,"govt") = er0(r)*wpe0(k,r)*xe0(k,r) - wtf_pe0(r,k) ;
te0(k,r,g)$(xe0(k,r) ne 0) = te0(k,r,g)/(er0(r)*wpe0(k,r)*xe0(k,r) - sum(gg,te0(k,r,gg))) ;
pe0(k,r) = (er0(r)*wpe0(k,r))/(1+sum(g,te0(k,r,g))) ;

* ----- Calculate the Armington aggregate

xap0(k,j) = sam(k,j)/pa0(k) ;
xac0(k,h) = sam(k,h)/pa0(k) ;
display$ivb xac0 ;
*xac0(k,h) = (xac0(k,h)+sam(k,h))/pa0(k) ;

eexp0(erg,h) = pa0(erg)*xac0(erg,h) ;

*xac0(k,h) = (sum(h0$(maph(h,h)),sum(k0$(mapk(k,k)),sam(k,h))))/pa0(k) ;
xaf0(k,f) = sam(k,f)/pa0(k) ;
display xaf0 ;

* ----- Calculate the indirect taxes on production and final demand

tcp0(k,j,g) = patax0(k,j,g) ;
*tcp0(k,j,g) = 0 ;
tcp0(k,j,g)$(xap0(k,j) ne 0) = tcp0(k,j,g)/(pa0(k)*xap0(k,j)) ;

tcc0(k,h,g) = fdtax0(k,h,g);
tcc0(k,h,g)$(xac0(k,h) ne 0) = tcc0(k,h,g)/(pa0(k)*xac0(k,h)) ;

tcf0(k,f,g) = fdtax0(k,f,g) ;
tcf0(k,f,g)$(xaf0(k,f) ne 0) = tcf0(k,f,g)/(pa0(k)*xaf0(k,f)) ;


* ----- Initialize the demand for domestic trade and transport services
* !!!!! Assume it is only for one sector for the moment

xamg0(k,kk,"d") = sam(k,kk)/pa0(k) ;
ptmg0(kk,"d")   = 1 ;
ytmg0(kk,"d")   = sum(k,pa0(k)*xamg0(k,kk,"d")) ;
xtmg0(kk,"d")   = ytmg0(kk,"d")/ptmg0(kk,"d") ;

xa0(k)  = sum(j,xap0(k,j)) + sum(h,xac0(k,h)) + sum(f,xaf0(k,f)) + sum(kk, xamg0(k,kk,"d")) ;

* ----- Initialize production

* ----- First, aggregate value added

*sam(s,ss)  = 0 ;
sam(v,j)   = sam(v,j) ;
vatax(v,j,g) = vatax0(v,j,g) ;

* ----- Production will be divided by the relevant price below,
*       after figuring whether the law of one price holds

ld0(j,l)  = labvol0(j,l) ;
wage0(j,l) = 1 ;
wage0(j,l)$(ld0(j,l) ne 0) = sam(l,j)/ld0(j,l) ;
display ld0, wage0 ;
*ld0(j,l)  = sam(l,j)/wage0(j,l) ;
tfl0(j,l,g)$(ld0(j,l) gt 0) = vatax(l,j,g)/(wage0(j,l)*ld0(j,l) - sum(gg,vatax(l,j,gg))) ;

*kd0(j,kt) = sam(kt,j)/rent0(j,kt) ;
kd0(j,kt) = (tk0*sam(kt,j)/sum(i,sam(kt,i)))/rent0(j,kt) ;
tfk0(j,kt,g)$(kd0(j,kt) gt 0) = vatax(kt,j,g)/(rent0(j,kt)*kd0(j,kt) - sum(gg,vatax(kt,j,gg))) ;

td0(j,lt) = sam(lt,j)/pt0(j,lt) ;
tft0(j,lt,g)$(td0(j,lt) gt 0) = vatax(lt,j,g)/(pt0(j,lt)*td0(j,lt) - sum(gg,vatax(lt,j,gg))) ;

*rd0(j) = sum(nr,sam(nr,j))/pr0(j) ;
*rd0(j) = 0 ;
 rd0(j) = 1e-3*efi0("co2",j) ;
*rd0(j) = efi0("co2",j) ;
rs0(i) = rd0(i) ;
*tfr0(j,g)$(rd0(j) gt 0) = sum(nr,vatax(nr,j,g)/(pr0(j)*rd0(j) - sum(gg,vatax(nr,j,gg)))) ;
tfr0(j,g) = 0 ;
sfr0(j,g) = 0 ;

display rd0 ;
display$ivb tfl0, tfk0, tft0, tfr0 ;

tp0(j,g)    = sam(g,j) ;
*tp0(j) = 0 ;

tef0(ef,i,g) = 0 ;
utef0(ef) = 0 ;
pef0(ef,i) = 0 ;
pefx0(ef,i) = 0 ;
cef0(ef,i) = 0 ;
cefx0(ef,i) = 0 ;

lambdae0(ef,i) = 0 ;
mue0(ef) = 1 ;

xp0(j)    = sum(k,(1+sum(g,tcp0(k,j,g)))*pa0(k)*xap0(k,j)) + sum(l,wage0(j,l)*ld0(j,l))
          + sum(kt,rent0(j,kt)*kd0(j,kt)) + sum(lt,pt0(j,lt)*td0(j,lt)) + pr0(j)*rd0(j)
**          + tp0(j) + sum((ef,g),tef0(ef,j,g))) + sum(ef,cef0(ef,j));
          + sum((ef,g),tef0(ef,j,g)) + sum(ef,cef0(ef,j));

tp0(j,g)$xp0(j)    = tp0(j,g)/(xp0(j) - sum(gg,tp0(j,gg)) - sum(ef,sum(gg,tef0(ef,j,gg)))) ;

* ----- Initialize aggregate commodity supply and calibrate

x0(k)     = sum(i$mapik(i,k),xp0(i)) ;

display$ivb xp0, x0 ;

*## ----- emission calibration

*eft0("co2") = carb1("2012") ;
eft0("co2") = ghginv("total","2012") ;
eft0(ef) = 1 ;
efcap0(ef) = eft0(ef) ;

chk = sum(i,NonCo2(i)) ;
*eft0("co2") = ghg("2012","tel") - chk;
display$ivb eft0, chk ;

*eft0(ef) = 0 ;
efi0(ef,i) = 0 ;
efi0(ef,i) = sum(ces,emit(ces,ef) *sam(ces,i)*(1-r_feed(ces,i,ef)));
*efi0(ef,i) = xp0(i)*emit(i,ef) ;
*efi0(ef,i) = xp0(i)*EF_GHG(i,"GHG_Total") ;


the0(k,g) = 0 ;

$ontext
*## Impute a fixed percentages of emissions to transport generation other industry and households

*## Electric Power Generation is attributed to LSES
  efi0("co2",ielec) = eft0("co2")*ghginv("elec","2012")/ghginv("Total","2012") ;
*  efi0("co2",ielec) = eft0("co2")*arbinv0("Power","2010")/arbinv0("Total","2010") ;
*  efi0("co2",ielec) = .01*effsrc("co2","gen")*eft0("co2") ;

*## Transport Services
 chk = sum((koil,itrans),xap0(koil,itrans))+sum((koil,h),xac0(koil,h)) ;
 chktr(i) = 0 ;
 chktr(itrans) = sum(koil,xap0(koil,itrans))/chk ;
 chkh(h) = sum(koil,xac0(koil,h))/chk ;
 chk = sum(i,chktr(i)) + sum(h,chkh(h)) ;
 display chktr, chkh, chk ;

 efi0("co2",itrans) = chktr(itrans)*eft0("co2")*ghginv("trans","2012")/ghginv("Total","2012") ;
*efi0("co2",itrans) = chktr(itrans)*eft0("co2")*arbinv0("Trans","2010")/arbinv0("Total","2010") ;
*efi0("co2",itrans) = chktr(itrans)*.01*effsrc("co2","veh")*eft0("co2") ;

*## Households

* lambdac0("co2",koil,h)$xac0(koil,h) = chkh(h)*.01*effsrc("co2","veh")*eft0("co2")/xac0(koil,h) ;

* chkh(h) = xac0(koil,h)/sum(hh,xac0(koil,hh));

*lambdac0("co2",koil,h) = chkh(h)*.01*effsrc("co2","veh")*eft0("co2")/sum(hh,xac0(koil,hh)) ;

lambdac0("co2",koil,h) = chkh(h)*eft0("co2")
	*(ghginv("trans","2012")/ghginv("Total","2012"))/xac0(koil,h) ;
*	*(arbinv0("Trans","2010")/arbinv0("Total","2010"))/sum(hh,xac0(koil,hh)) ;
*lambdac0("co2",koil,h) = chkh(h)*.01*effsrc("co2","veh")*eft0("co2")/xac0(koil,h) ;


*chkh(h) = xac0(kelec,h)/(xac0(kelec,h)+xac0(kgas,h))

chk = sum((kelect,h),xac0(kelect,h))/sum((h,kelect,kgas),xac0(kelect,h)+xac0(kgas,h))
display chk ;
$offtext

lambdac0("co2",kelect,h) = chk*(xac0(kelect,h)/sum(hh,xac0(kelect,hh)))
	*eft0("co2")*(ghginv("res","2012")/ghginv("Total","2012"))/xac0(kelect,h) ;
*	*(arbinv0("Res","2010")/arbinv0("Total","2010"))/sum(hh,xac0(kelec,hh)) ;
lambdac0("co2",kgas,h) = (1-chk)*(xac0(kgas,h)/sum(hh,xac0(kgas,hh)))
	*eft0("co2")*(ghginv("res","2012")/ghginv("Total","2012"))/xac0(kgas,h) ;
*	*(arbinv0("Res","2010")/arbinv0("Total","2010"))/sum(hh,xac0(kgas,hh)) ;
*lambdac0("co2",kelec,h) = chk*.01*effsrc("co2","res")*effbase("co2")/sum(hh,xac0(kelec,hh)) ;
*lambdac0("co2",kgas,h) = (1-chk)*.01*effsrc("co2","res")*effbase("co2")/sum(hh,xac0(kgas,hh)) ;

efh0(ef,h) = 0 ;
efh0(ef,h) = sum(ces,  emit(ces,ef) *sam(ces,h));

efkh0(ef,k,h) =xac0(k,h)*sum(i$mapik(i,k),emit(i,ef)) ;

*efkh0("co2",k,h) =xac0(k,h)*sum(i$mapik(i,k),EF_GHG(i,"GHG_Total")) ;
**efkh0("co2",k,h) = mue0("co2")*lambdac0("co2",k,h)*xac0(K,h) ;
*efkh0("co2",k,h) = mue0("co2")*lambdac0("co2",k,h)*xac0(K,h) ;
*efh0(ef,h) = sum(k,efkh0(ef,k,h)) ;

*efh0("co2",h) = mue0("co2")*sum(k,lambdac0("co2",k,h)*xac0(K,h)) ;

$Ontext
*## Impute residual pollution to other sectors

     chke("co2") = eft0("co2") - sum(i,efi0("co2",i)) - sum(h,efh0("co2",h)) ;
     efi0("co2",ier) = chke("co2")*sum(koil,xap0(koil,ier))/sum((koil,jer),xap0(koil,jer)) ;
 		chk = sum(ier, efi0("co2",ier)) ;

display chke, chk ;

display eft0 ;
$offtext

eft0(ef) = sum(i,efi0(ef,i)) + sum(h,efh0(ef,h)) ;

efcap0(ef) = eft0(ef) ;

*## Add in Non-C02 Equivalent Emissions
*     efi0("Co2",i) = efi0("Co2",i) + NonCo2(i) ;
     lambdae0("co2",i)$xp0(i) = efi0("co2",i)/xp0(i) ;

   rac("co2",icap) = efi0("co2",icap)/sum(iicap,efi0("co2",iicap)) ;

display eft0, efi0, efkh0, efh0, mue0, lambdae0, xp0, lambdac0 ;

* ----- Calculate the commodity-specific trade margin

tmg0(kk,"d")$(x0(kk) + sum(r,pm0(kk,r)*xm0(kk,r))) = ytmg0(kk,"d")/(x0(kk) + sum(r,pm0(kk,r)*xm0(kk,r))) ;
tmg0(kk,mg)  = tmg0(kk,"d") ;

* ----- Calculate aggregate imports

xmt0(k) = sum(r,pm0(k,r)*(1+tmg0(k,"m"))*xm0(k,r))/pmt0(k) ;

* ----- The export price should now reflect the producer price, i.e. net of the margin

pe0(k,r) = pe0(k,r)/(1+tmg0(k,"x")) ;

sigmax(k) = KeyComm(k,"sigmax") ;
sigmaz(k) = KeyComm(k,"sigmaz") ;
sigmac(k) = KeyComm(k,"sigmac") ;
sigmac(k)$(sigmac(k) eq 1) = 1.01 ;

* !!!! Re-base pet0 if the law of one price holds
* !!!! This would pose a problem if there are multiple trading partners with destination
*      specific export tariffs. In such a case, it would be better to use a finite
*      transformation elasticity, even if high.

loop(k$(sigmaz(k) eq inf), loop(r$(ord(r) eq 1), pet0(k) = pe0(k,r) ; ) ; ) ;

* Re-base pd0 if the law of one-price-holds

pd0(k)$(sigmax(k) eq inf) = pet0(k) ;
p0(k)$(sigmax(k) eq inf)  = pet0(k) ;
loop(k$(sigmac(k) eq inf),
   loop(i$mapik(i,k),
      pp0(i) = p0(k) ;
   ) ;
) ;

* Re-base output

xp0(i) = xp0(i)/pp0(i) ;
x0(k)  = x0(k)/p0(k) ;

* ------------------------------------------------------------------------------
*
* Initialize and calibrate the production block
*
* ------------------------------------------------------------------------------

* ----- Initialize prices and productivity parameters

lambdal0(i,l)  = 1 ;
lambdak0(i,kt) = 1 ;
lambdat0(i,lt) = 1 ;
lambdar0(i)    = 1 ;

ac(i,k)   = 0 ;

loop(k,
   if (sigmac(k) ne inf,
*      loop(i$mapik(i,k),
         ac(i,k)$x0(k) = (xp0(i)/x0(k))*(pp0(i)/p0(k))**sigmac(k) ;
*         ac(i,k) = (nsam(i,k)/x0(k))*(pp0(i)/p0(k))**sigmac(k) ;

*          ac(j,k) = (((1+tcp0(k,j))*pa0(k)*xap0(k,j) + sum(l,wage0(j,l)*ld0(j,l))
*               + sum(kt,rent0(j,kt)*kd0(j,kt)) + sum(lt,pt0(j,lt)*td0(j,lt)) + pr0(j)*rd0(j)
*          + tp0(j) + sum(ef,tef0(ef,j)*mue(ef)*lambdae0(j,ef))*xap0(k,j))
*          /x0(k))*(pp0(j)/p0(k))**sigmac(k) ;
*      ) ;
   ) ;
) ;

* ----- Calibrate the unskilled labor bundle

pusk0(j)  = 1 ;
usk0(j)   = sum(ul,wage0(j,ul)*ld0(j,ul))/pusk0(j) ;
sigmau(j) = KeySect(j,"sigmau") ;
sigmau(j)$(sigmau(j) eq 1) = 1.01 ;
al(j,ul)$(ld0(j,ul) ne 0) = (ld0(j,ul)/usk0(j))*((wage0(j,ul)/pusk0(j))**sigmau(j))*(lambdal0(j,ul)**(1-sigmau(j))) ;

* ----- Calibrate the skilled labor bundle

pskl0(j)  = 1 ;
skl0(j)   = sum(sl,wage0(j,sl)*ld0(j,sl))/pskl0(j) ;
sigmas(j) = KeySect(j,"sigmas") ;
sigmas(j)$(sigmas(j) eq 1) = 1.01 ;
al(j,sl)$(ld0(j,sl) ne 0) = (ld0(j,sl)/skl0(j))*((wage0(j,sl)/pskl0(j))**sigmas(j))*(lambdal0(j,sl)**(1-sigmas(j))) ;

* ----- Calibrate the aggregate capital bundle

pktd0(j) = 1 ;
ktd0(j)  = sum(kt, rent0(j,kt)*kd0(j,kt))/pktd0(j) ;
sigmak(j) = KeySect(j,"sigmak") ;
sigmak(j)$(sigmak(j) eq 1) = 1.01 ;
ak(j,kt)$(kd0(j,kt) ne 0) = (kd0(j,kt)/ktd0(j))*((rent0(j,kt)/pktd0(j))**sigmak(j))*(lambdak0(j,kt)**(1-sigmak(j))) ;

* ----- Calibrate the aggregate land bundle

pttd0(j) = 1 ;
ttd0(j)  = sum(lt, pt0(j,lt)*td0(j,lt))/pttd0(j) ;
sigmat(j) = KeySect(j,"sigmat") ;
sigmat(j)$(sigmat(j) eq 1) = 1.01 ;
at(j,lt)$(td0(j,lt) ne 0) = (td0(j,lt)/ttd0(j))*((pt0(j,lt)/pttd0(j))**sigmat(j))*(lambdat0(j,lt)**(1-sigmat(j))) ;

* ----- Calibrate the KSK bundle

pksk0(j)  = 1 ;
ksk0(j)   = (pktd0(j)*ktd0(j) + pskl0(j)*skl0(j))/pksk0(j) ;
sigmaks(j) = KeySect(j,"sigmaks") ;
sigmaks(j)$(sigmaks(j) eq 1) = 1.01 ;
as(j)$(skl0(j) ne 0)  = (skl0(j)/ksk0(j))*((pskl0(j)/pksk0(j))**sigmaks(j)) ;
akt(j)$(ktd0(j) ne 0) = (ktd0(j)/ksk0(j))*((pktd0(j)/pksk0(j))**sigmaks(j)) ;

*display$ivb sigmaks, as, akt ;

* ----- Calibrate the KL bundle

pkl0(j)  = 1 ;
kl0(j)   = (pusk0(j)*usk0(j) + pksk0(j)*ksk0(j))/pkl0(j) ;
sigmakl(j) = KeySect(j,"sigmakl") ;
sigmakl(j)$(sigmakl(j) eq 1) = 1.01 ;
au(j)$(usk0(j) ne 0)  = (usk0(j)/kl0(j))*((pusk0(j)/pkl0(j))**sigmakl(j)) ;
aksk(j)$(kl0(j) ne 0) = (ksk0(j)/kl0(j))*((pksk0(j)/pkl0(j))**sigmakl(j)) ;

* ----- Calibrate the value added bundle

pva0(j)   = 1 ;
va0(j)    = (pkl0(j)*kl0(j) + pr0(j)*rd0(j) + pttd0(j)*ttd0(j))/pva0(j) ;
sigmav(j) = KeySect(j,"sigmav") ;
**sigmav(j) = .057*KeySect(j,"sigmav") ;
*sigmav(j) = KeySect(j,"sigmav") ;
sigmav(j)$(sigmav(j) eq 1) = 1.01 ;
akl(j)$(kl0(j) ne 0)  = (kl0(j)/va0(j))*((pkl0(j)/pva0(j))**sigmav(j)) ;
att(j)$(ttd0(j) ne 0) = (ttd0(j)/va0(j))*((pttd0(j)/pva0(j))**sigmav(j)) ;
ar(j)$(rd0(j) ne 0)  = (rd0(j)/va0(j))*((pr0(j)/pva0(j))**sigmav(j)) ;

* ----- Calibrate the top level bundle

**px0(j)$xp0(j)    = pp0(j)/(1+tp0(j)+sum(ef,tef0(ef,j)*efi0(ef,j))/xp0(j)) ;
px0(j)$xp0(j)    = pp0(j)/(1+sum(g,tp0(j,g))+sum((ef,g),tef0(ef,j,g)*efi0(ef,j))/xp0(j)) ;
pnd0(j)   = 1 ;
nd0(j)    = (sum(k,(1+sum(g,tcp0(k,j,g)))*pa0(k)*xap0(k,j)))/pnd0(j) ;
sigmap(j) = KeySect(j,"sigmap") ;
sigmap(j)$(sigmap(j) eq 1) = 1.01 ;
ava(j)$xp0(j)    = (va0(j)/xp0(j))*((pva0(j)/px0(j))**sigmap(j)) ;
and(j)$xp0(j)    = (nd0(j)/xp0(j))*((pnd0(j)/px0(j))**sigmap(j)) ;

* ----- Calibrate the IO coefficients

a00(k,j)$(nd0(j) ne 0) = xap0(k,j)/nd0(j) ;
*display a00 ;

* ------------------------------------------------------------------------------
*
* Initialize and calibrate the demand block
*
* ------------------------------------------------------------------------------

* ---- Initialize household variables

htrh0(h,hh) = sam(h,hh) ;
kappah0(h,g)  = sam(g,h) ;
taxadjh0(g)    = 1 ;
htrw0(h,r)  = sam(r,h) ;
savh0(h)    = sam("capacct",h) ;
*savh0(h)    = sum(h0$(maph(h,h)),sam("capacct",h) + sam("depry",h)) ;

htr0(h)     = sum(hh,htrh0(hh,h)) + sum(r,htrw0(h,r)) ;

yh0(h)      = sum(k,(1+sum(g,tcc0(k,h,g)))*pa0(k)*xac0(k,h)) + htr0(h) + sum(g,kappah0(h,g)) + savh0(h) ;

yd0(h)      = sum(k,(1+sum(g,tcc0(k,h,g)))*pa0(k)*xac0(k,h)) + savh0(h) ;

kappah0(h,g) = kappah0(h,g)/yh0(h) ;
asav(h)    = savh0(h)/yd0(h) ;

display yh0, kappah0, yd0 ;

ahtr(h) = htr0(h)/((1-sum(g,kappah0(h,g)))*yh0(h)) ;
ahtrh(h,hh)$(htr0(hh) ne 0) = htrh0(h,hh)/htr0(hh) ;
ahtrw(h,r)$(htr0(h) ne 0)     = htrw0(h,r)/htr0(h) ;

* ----- Calculate the maximum share in domestic transfers to guarantee
*       that the shares add up to 1

loop(h,
   delta = sum(hh, ahtrh(hh,h)) + sum(r,ahtrw(h,r)) ;

   work = -inf ;
   if (sum(hh,ahtrh(hh,h)) ne 0,
      loop(hh,
         if (ahtrh(hh,h) gt work,
            work = ahtrh(hh,h) ;
            index = ord(hh) ;
         ) ;
      ) ;
   ) ;
   loop(hh$(ord(hh) eq index), ahtrh(hh,h) = ahtrh(hh,h) + (1-delta) ; ) ;
) ;

* ----- Calibrate the ELES system

eta(k,h)$xac0(k,h) = eta0(k,h);

             display$ivb eta ;

if(0,

*  Use the standard ELES calibration

   thetav.l(k,h) = 0.1*xac0(k,h) ;
   share0(k,h)   = (1+sum(g,tcc0(k,h,g)))*pa0(k)*xac0(k,h)/yd0(h) ;
   mu0(k,h)       = eta(k,h)*share0(k,h) ;
   mus(h)  = 1 - sum(k,mu0(k,h)) ;
   etas(h)$(savh0(h) ne 0) = mus(h)/(savh0(h)/yd0(h)) ;
   display$ivb mus, etas ;

   solve eles using mcp ;

   theta(k,h) = thetav.l(k,h) ;

else

*  Use the Frisch parameter technique

*  Adjust the eta parameters so that the normalization conditions hold

   eta(k,h)$(xac0(k,h) eq 0) = 0 ;

     share0(k,h)   = (1+sum(g,tcc0(k,h,g)))*pa0(k)*xac0(k,h)/yd0(h) ;
*    share0(k,h)   = (1+tcc0(k,h))*pa0(k)*xac0(k,h)/(yd0(h)-savh0(h)) ;

   display$ivb eta ;

   eta(k,h) = eta(k,h) + share0(k,h)*(1-sum(kk,share0(kk,h)*eta(kk,h)))/sum(kk,share0(kk,h)*share0(kk,h)) ;

   display$ivb eta ;

*  Calibrate mu and theta

   mu0(k,h)    = eta(k,h)*share0(k,h) ;
   theta(k,h) = xac0(k,h)*(1+eta(k,h)/frisch(h)) ;

   loop(h, work = 1000000*(sum(k,eta(k,h)*share0(k,h))) ; display$ivb work ) ;

   display$ivb mu0, theta ;
) ;

cpi0(h)      = 1 ;
fpi0(h)      = 1 ;
epi0(h)      = 1 ;

* ----- Final demand expenditures

pf0(f) = 1 ;
xf0(f) = (sum(k,(1+sum(g,tcf0(k,f,g)))*pa0(k)*xaf0(k,f)))/pf0(f) ;
yf0(f) = pf0(f)*xf0(f) ;

sigmaf(f)$(sigmaf(f) eq 1) = 1.01 ;
af(k,f)$(xf0(f) ne 0) = (xaf0(k,f)/xf0(f))*((1+sum(g,tcf0(k,f,g)))*pa0(k)/pf0(f))**sigmaf(f) ;

af0(k,f) = af(k,f) ;

* ----- Domestic demand for domestic production

xdd0(k) = (pa0(k)*xa0(k) - pmt0(k)*xmt0(k))/((1+tmg0(k,"d"))*pd0(k)) ;

* ----- Calibrate the second level Armington function

sigmaw(k) = KeyComm(k,"sigmaw") ;
sigmaw(k)$(sigmaw(k) eq 1) = 1.01 ;

aw(k,r)$(xmt0(k) ne 0) = (xm0(k,r)/xmt0(k))*(pm0(k,r)*(1+tmg0(k,"m"))/pmt0(k))**sigmaw(k) ;

* ----- Calibrate the first level Armington demand function

sigmam(k) = KeyComm(k,"sigmam") ;
sigmam(k)$(sigmam(k) eq 1) = 1.01 ;

ad(k)$xa0(k) = (xdd0(k)/xa0(k))*(pd0(k)*(1+tmg0(k,"d"))/pa0(k))**sigmam(k) ;
am(k)$xa0(k) = (xmt0(k)/xa0(k))*(pmt0(k)/pa0(k))**sigmam(k) ;

* ----- Calibrate the export system

xds0(k)  = xdd0(k) ;

xet0(k) = sum(r,pe0(k,r)*xe0(k,r))/pet0(k) ;

* ----- Top level CET

loop(k$(x0(k) ne 0),
   if (sigmax(k) ne inf,
      gd(k) = (xds0(k)/x0(k))*(p0(k)/pd0(k))**sigmax(k) ;
      ge(k) = (xet0(k)/x0(k))*(p0(k)/pet0(k))**sigmax(k) ;
   ) ;
) ;

* ----- Second level CET

loop(k$(xet0(k) ne 0),
   if (sigmaz(k) ne inf,
      gx(k,r) = (xe0(k,r)/xet0(k))*(pet0(k)/pe0(k,r))**sigmaz(k) ;
   ) ;
) ;

* ----- Export demand

ed0(k,r) = xe0(k,r) ;
wpendx0(k,r) = wpe0(k,r) ;

* !!!!! Data entry should be split by region of destination
etae(k,r) = KeyComm(k,"etae") ;
ae(k,r)$(etae(k,r) ne inf) = ed0(k,r)*(wpe0(k,r)/wpendx0(k,r))**etae(k,r) ;

display$ivb xe0, te0, pe0, ae, ed0, wpe0, wpendx0, etae ;


* ----- Finish updating margin variables

display$ivb xamg0 ;

amg(k,kk,mg)$(xamg0(k,kk,"d") ne 0) = xamg0(k,kk,"d")/xtmg0(kk,"d") ;

ptmg0(k,mg)  = 1 ;
ytmg0(k,"d") = pd0(k)*tmg0(k,"d")*xdd0(k) ;
ytmg0(k,"m") = sum(r,pm0(k,r)*tmg0(k,"m")*xm0(k,r)) ;
ytmg0(k,"x") = sum(r,pe0(k,r)*tmg0(k,"x")*xe0(k,r)) ;
xtmg0(k,mg)  = ytmg0(k,mg)/ptmg0(k,mg) ;
xamg0(k,kk,mg) = amg(k,kk,mg)*xtmg0(kk,mg) ;

display$ivb xamg0 ;

* ------------------------------------------------------------------------------
*
* Initialize and calibrate income distribution
*
* ------------------------------------------------------------------------------

* ----- Factor income

sam(e,v)      = sam(e,v) ;
sam(h,v)      = sam(h,v) ;
sam(r,v)  = sam(r,v) ;

gtrk0(kt,g) = sam(kt,g) ;

ky0(kt)   = sum(i,rent0(i,kt)*kd0(i,kt)/(1+sum(g,tfk0(i,kt,g))))  + sum(g,gtrk0(kt,g));

ktre0(kt) = sum(e,sam(e,kt)) ;
ktrh0(kt) = sum(h,sam(h,kt)) ;
ktrw0(kt,r) = sam(r,kt) ;

chk1 = sum(kt, ktre0(kt)+ktrh0(kt)+sum(r,ktrw0(kt,r))) ;
display$ivb chk1, ky0 ;

* ----- Calibrate the aggregate shares

xkht(kt)$ky0(kt)  = ktrh0(kt)/ky0(kt) ;
xket(kt)$ky0(kt)  = ktre0(kt)/ky0(kt) ;
xkwt(kt,r)$sum(rr,sam(rr,kt))  = (1 - xkht(kt) - xket(kt))*sam(r,kt)/sum(rr,sam(rr,kt)) ;

* ----- Calibrate the sub-aggregate shares

xkh(kt,h)$(ktrh0(kt) ne 0) = sam(h,kt)/ktrh0(kt) ;
xke(kt,e)$(ktre0(kt) ne 0) = sam(e,kt)/ktre0(kt) ;
xkw(kt,r)$(ktrw0(kt,r) ne 0)   = sam(r,kt)/ktrw0(kt,r) ;

chk1 = sum(kt,sum(h, xkh(kt,h))) ;
display$ivb chk1 ;
chk1 = sum(kt,sum(e, xke(kt,e))) ;
display$ivb chk1 ;
chkr(r) = sum(kt,xkw(kt,r)) ;
display$ivb chkr ;

* ---- Make sure the shares sum to 1 by assigning any discrepancy to the highest share

loop(kt,
   if (ktrh0(kt) ne 0,
      delta = sum(h, xkh(kt,h)) ;

      if (sum(h, xkh(kt,h)) ne 0,
         work = -inf ;
         loop(h,
            if (xkh(kt,h) gt work,
               work = xkh(kt,h) ;
               index = ord(h) ;
            ) ;
         ) ;
         loop(h$(ord(h) eq index), xkh(kt,h) = xkh(kt,h) + (1-delta) ; ) ;
      ) ;
   ) ;

   if (ktre0(kt) ne 0,
      delta = sum(e, xke(kt,e)) ;

      work = -inf ;
      loop(e,
         if (xke(kt,e) gt work,
            work = xke(kt,e) ;
            index = ord(e) ;
         ) ;
      ) ;
      loop(e$(ord(e) eq index), xke(kt,e) = xke(kt,e) + (1-delta) ; ) ;
   ) ;

) ;

* ----- Land income

ty0(lt)   = sum(i,pt0(i,lt)*td0(i,lt)/(1+sum(g,tft0(i,lt,g)))) ;

* ----- Calibrate the sub-aggregate shares

xth(lt,h)$(ty0(lt) ne 0) = sam(h,lt)/ty0(lt) ;

chk1 = sum(lt,sum(h,xth(lt,h))) ;

display$ivb chk1 ;

* ---- Make sure the shares sum to 1 by assigning any discrepancy to the highest share

loop(lt,
   if (ty0(lt) ne 0,
      delta = sum(h, xth(lt,h)) ;

      work = -inf ;
      loop(h,
         if (xth(lt,h) gt work,
            work = xth(lt,h) ;
            index = ord(h) ;
         ) ;
      ) ;
      loop(h$(ord(h) eq index), xth(lt,h) = xth(lt,h) + (1-delta) ; ) ;
   ) ;
) ;

chk1 = sum(lt,sum(h,xth(lt,h))) ;

display$ivb chk1 ;

* ----- Labor income

gtrl0(l,g) = sam(l,g) ;

ly0(l)   = sum(i,wage0(i,l)*ld0(i,l)/(1+sum(g,tfl0(i,l,g))))  + sum(g,gtrl0(l,g));

xlh(h,l) = sam(h,l)/ly0(l) ;

display ly0, xlh, tfl0 ;

* ---- Make sure the shares sum to 1 by assigning any discrepancy to the highest share
* ---- Make it proportional instead
loop(l,
   delta = sum(h, xlh(h,l)) ;
   xlh(h,l) = xlh(h,l)/delta ;
) ;

$ontext
loop(l,
   delta = sum(h, xlh(h,l)) ;

   work = -inf ;
   loop(h,
      if (xlh(h,l) gt work,
         work = xlh(h,l) ;
         index = ord(h) ;
      ) ;
   ) ;
   loop(h$(ord(h) eq index), xlh(h,l) = xlh(h,l) + (1-delta) ; ) ;

   delta = sum(h, xlh(h,l)) ;
) ;
$offtext

display$ivb ly0, xlh ;

* ----- Income from sector specific resource

ry0 = sum(i,pr0(i)*rd0(i)/(1+sum(g,tfr0(i,g)))) ;

xrh(h)$(ry0 ne 0) = 0 ;
*xrh(h)$(ry0 ne 0) = sam(h,"natr")/ry0 ;

* ---- Make sure the shares sum to 1 by assigning any discrepancy to the highest share
$ontext
if(ry0 ne 0,
   delta = sum(h, xrh(h)) ;

   work = -inf ;
   loop(h,
      if (xrh(h) gt work,
         work = xrh(h) ;
         index = ord(h) ;
      ) ;
   ) ;
   loop(h$(ord(h) eq index), xrh(h) = xrh(h) + (1-delta) ; ) ;

) ;
$offtext

* ----- Corporate income

cy0(e)     = sum(kt,xke(kt,e)*ktre0(kt)) ;
kappac0(e,g)$(cy0(e) ne 0) = (sam(g,e)-sam(e,g))/cy0(e) ;

savc0(e)   = sam("capacct",e) + sam("invent",e) ;
*+sam("inventory",e)) ;

csavrate0(e)$(cy0(e) ne 0) = savc0(e)/((1-sum(g,kappac0(e,g)))*cy0(e)) ;

ctrh0(e) = sum(h,sam(h,e)) ;
ctrw0(e,r) = sam(r,e) ;

xcht(e)$(cy0(e) ne 0) = ctrh0(e)/((1-sum(g,kappac0(e,g)))*cy0(e)) ;
xcwt(e,r)$(cy0(e) ne 0) = ctrw0(e,r)/((1-sum(g,kappac0(e,g)))*cy0(e)) ;
*xcwt(e,r)$sum(rr,sam(rr,e)) = (1 - csavrate0(e) - xcht(e))*sam(r,e)/sum(rr,sam(rr,e)) ;

xch(e,h)$(ctrh0(e) ne 0) = sam(h,e)/ctrh0(e) ;
xcw(e,r)$(ctrw0(e,r) ne 0) = (sam(r,e)-sam(e,r))/ctrw0(e,r) ;

display ctrh0, xcht, xch, ctrw0, xcwt ;

* ---- Make sure the shares sum to 1 by assigning any discrepancy to the highest share

loop(e,

   delta = sum(h, xch(e,h)) ;
   work = -inf ;
   loop(h,
      if (xch(e,h) gt work,
         work = xch(e,h) ;
         index = ord(h) ;
      ) ;
   ) ;
   loop(h$(ord(h) eq index), xch(e,h) = xch(e,h) + (1-delta) ; ) ;

) ;

* ----- Other sources of income

gtrh0(h,g) = sam(h,g) ;
*gtre0(e,g) = sam(e,g) ;
gtre0(e,g) = 0 ;
wtrh0(h,r) = sam(h,r)/er0(r) ;


* ------------------------------------------------------------------------------
*
* Initialize and calibrate government accounts
*
* ------------------------------------------------------------------------------

gtrg0(g,gg) = sam(g,gg) ;
wtrg0(r,g) = sam(g,r)/er0(r) ;
display gtrg0 ;

tmadj0(g) = 1 ;
tary0(g)  = sum(k,sum(r,tmadj0(g)*tm0(k,r,g)*er0(r)*wpm0(k,r)*xm0(k,r))) ;
rtary0(g) = tary0(g) ;

gy0(g) = sum(i,tp0(i,g)*px0(i)*xp0(i))
    + sum(k,pa0(k)*(sum(j,tcp0(k,j,g)*xap0(k,j))+sum(h,tcc0(k,h,g)*xac0(k,h))+sum(f,tcf0(k,f,g)*xaf0(k,f))))
    + tary0(g) + sum(k,sum(r,te0(k,r,g)*(1+tmg0(k,"x"))*pe0(k,r)*xe0(k,r)))
    + sum(lt,sum(i,tft0(i,lt,g)*pt0(i,lt)*td0(i,lt)/(1+sum(gg,tft0(i,lt,gg)))))
    + sum(kt,sum(i,tfk0(i,kt,g)*rent0(i,kt)*kd0(i,kt)/(1+sum(gg,tfk0(i,kt,gg)))))
    + sum(l,sum(i,tfl0(i,l,g)*wage0(i,l)*ld0(i,l)/(1+sum(gg,tfl0(i,l,gg)))))
    + rysh(g)*ry0
	 + sum(gg,gtrg0(g,gg))
*   + sum(i,tfr0(i)*pr0(i)*rd0(i)/(1+tfr0(i)))
    + sum(i,sum(ef, tef0(ef,i,g)*efi0(ef,i)))
    + sum(e,kappac0(e,g)*cy0(e)) + sum(h,kappah0(h,g)*yh0(h)) + sum(r,er0(r)*wtrg0(r,g)) ;

*display tp0, tcp0, tcc0, tcf0, tary0, te0, tmg0, tft0, tfk0, tfl0, tfr0, tef0, kappac0, kappah0, wtrg0 ;

gtrw0(r,g) = sam(r,g)/er0(r) ;
gexp0(g) = yf0(g) + sum(h,gtrh0(h,g))+ sum(l,gtrl0(l,g))+ sum(kt,gtrk0(kt,g)) + sum(r,gtrw0(r,g)) + sum(gg,gtrg0(gg,g));

display gy0, gexp0, te0 ;
savg0(g) = gy0(g) - gexp0(g) ;
rsg0(g)  = savg0(g)/plev0 ;

display yf0, savg0, savh0, savc0 ;

* ------------------------------------------------------------------------------
*
* Initialize and calibrate factor markets
*
* ------------------------------------------------------------------------------

* ----- Labor markets

ls0(l,"Tot") = sum(i,ld0(i,l)) ;
ewage0(l,"Tot")$(omegam(l) eq inf) = sum(i,ld0(i,l)*wage0(i,l))/ls0(l,"Tot") ;
phil(i,l)$(omegam(l) eq inf) = wage0(i,l)/ewage0(l,"Tot") ;

als(l,"Tot") = 0 ;
als(l,"Tot")$(omegam(l) eq inf and omegal(l,"Tot") ne inf) = ls0(l,"Tot")*(plev0/ewage0(l,"Tot"))**omegal(l,"Tot") ;

loop(l$(omegam(l) ne inf),
   awage0(l,gz2) = sum(i$mapg(i,gz2),wage0(i,l)*ld0(i,l)/(1+sum(g,tfl0(i,l,g))))
                 / sum(i$mapg(i,gz2),ld0(i,l)) ;
   ewage0(l,gz2) = 1 ;
   loop(gz2,loop(i$mapg(i,gz2), phil(i,l) = wage0(i,l)/ewage0(l,gz2) ; )) ;
   ls0(l,gz2) = sum(i$mapg(i,gz2),ld0(i,l)) ;
   chim(l) = migr0(l)*(awage0(l,"rur")/awage0(l,"urb"))**omegam(l) ;
   lslag(l,"Rur") = (ls0(l,"Rur")+migr0(l))/(1+glab0(l,"Rur")) ;
   lslag(l,"Urb") = (ls0(l,"Urb")-migr0(l))/(1+glab0(l,"Urb")) ;
) ;

* ----- Capital markets

ptks0(kt)  = 1 ;
pk0        = 1 ;
tks0(kt)   = sum(i,rent0(i,kt)*kd0(i,kt)/(1+sum(g,tfk0(i,kt,g))))/ptks0(kt) ;
ks0(i,kt)  = kd0(i,kt) ;

ksup0      = sum(kt, ptks0(kt)*tks0(kt))/pk0 ;


loop(kt$(tks0(kt) ne 0),
   if(omegak(kt) ne inf,
      aks(i,kt) = (ks0(i,kt)/tks0(kt))*((1+sum(g,tfk0(i,kt,g)))*ptks0(kt)/rent0(i,kt))**omegak(kt) ;
   ) ;

   if (omegakt ne inf,
      akst(kt) = (tks0(kt)/ksup0)*(pk0/ptks0(kt))**omegakt ;
   ) ;
) ;

display tks0, omegak, aks, omegakt, akst ;

display tk0, ksup0, tks0, kd0, ptks0, pk0, rent0, aks, akst ;

* ----- Land markets

ts0(i,lt) = td0(i,lt) ;
pland0    = 1+0*uniform(0.5,4) ;
ptts0(lt) = 1 ;

tts0(lt) = sum(i,pt0(i,lt)*td0(i,lt)/(1+sum(g,tft0(i,lt,g))))/ptts0(lt) ;
land0    = sum(lt,ptts0(lt)*tts0(lt))/pland0 ;

if (land0 ne 0 and omegatl ne inf,
   atts(lt) = (tts0(lt)/land0)*(pland0/ptts0(lt))**omegatl ;
) ;

loop(lt,
   if (tts0(lt) ne 0 and omegat(lt) ne inf,
      ats(i,lt) = (ts0(i,lt)/tts0(lt))*((1+sum(g,tft0(i,lt,g)))*ptts0(lt)/pt0(i,lt))**omegat(lt) ;
   ) ;
) ;

* ----- Market for sector specific resource

rs0(i) = rd0(i) ;

loop(i$(rs0(i) ne 0),
   if (omegar(i) ne inf,
      ars(i) = rs0(i)*(plev0/pr0(i))**omegar(i) ;
   ) ;
) ;

* ------------------------------------------------------------------------------
*
* Miscellaneous initializations
*
* ------------------------------------------------------------------------------

savf0(r)   = (sam("capacct",r)-sam(r,"capacct"))/er0(r) ;

gdpmp0  = sum(k,sum(h,xac0(k,h)*(1+sum(g,tcc0(k,h,g)))*pa0(k)))
			+ sum(k,sum(f,pa0(k)*(1+sum(g,tcf0(k,f,g)))*xaf0(k,f)))
        	+ sum(k,sum(r,er0(r)*wpe0(k,r)*xe0(k,r)))
        	- sum(k,sum(r,er0(r)*wpm0(k,r)*xm0(k,r))) ;

rgdpmp0 = gdpmp0 ;
pgdpmp0 = 1 ;

gdpfc0  = sum(i,sum(l,wage0(i,l)*lambdal0(i,l)*ld0(i,l)))
        + sum(kt,sum(i,rent0(i,kt)*lambdak0(i,kt)*kd0(i,kt)))
        + sum(i,pr0(i)*lambdar0(i)*rd0(i))
        + sum(lt,sum(i,pt0(i,lt)*lambdat0(i,lt)*td0(i,lt))) ;

rgdpfc0 = gdpfc0 ;
pgdpfc0 = 1 ;

pop0(h)   = tpop0*popsh0(h) ;
gl0       = 0 ;
ggdp0     = 0 ;
geg0(k,j) = 1 ;
gce0(k,h) = 1 ;
chil(i,v) = 0 ;

pinc0 = sum(l,ly0(l)) + sum(kt,ky0(kt)) + sum(lt,ty0(lt)) + ry0 + sum((h,g),gtrh0(h,g)) + sum((e,g),gtre0(e,g)) ;

* Rescale theta relative to population

theta(k,h) = theta(k,h)/pop0(h) ;

walras0 =  sum(r,
					sum(k,wpe0(k,r)*xe0(k,r)) - sum(k,wpm0(k,r)*xm0(k,r))
					+ sum(h,wtrh0(h,r)) + sum(g,wtrg0(r,g)) + savf0(r)
         		- ( sum(h,htrw0(h,r))/er0(r) + sum(g,gtrw0(r,g))
        			+  sum(e,ctrw0(e,r))/er0(r) + sum(kt,ktrw0(kt,r))/er0(r) )
				) ;

display walras0, savf0, er0 ;
