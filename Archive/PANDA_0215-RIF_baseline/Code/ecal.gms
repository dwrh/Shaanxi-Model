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

efi0(ef,i) = 0 ;
efi0(ef,i) = sum(ces,emit(ces,ef) *sam(ces,i)*(1-r_feed(ces,i,ef)));

the0(k,g) = 0 ;

efh0(ef,h) = 0 ;
efh0(ef,h) = sum(ces,  emit(ces,ef) *sam(ces,h));

efkh0(ef,k,h) =xac0(k,h)*sum(i$mapik(i,k),emit(i,ef)) ;

eft0(ef) = sum(i,efi0(ef,i)) + sum(h,efh0(ef,h)) ;

*efcap0(ef) = eft0(ef) ;


chk = sum(i,NonCo2(i)) ;

lambdac0("co2",kelect,h) = chk*(xac0(kelect,h)/sum(hh,xac0(kelect,hh)))
        *eft0("co2")*(ghginv("res","2012")/ghginv("Total","2012"))/xac0(kelect,h) ;

lambdac0("co2",kgas,h) = (1-chk)*(xac0(kgas,h)/sum(hh,xac0(kgas,hh)))
        *eft0("co2")*(ghginv("res","2012")/ghginv("Total","2012"))/xac0(kgas,h) ;

*## Add in Non-C02 Equivalent Emissions
*lambdae0("co2",i)$xp0(i) = efi0("co2",i)/xp0(i) ;

rac("co2",icap) = efi0("co2",icap)/sum(iicap,efi0("co2",iicap)) ;

display eft0, efi0, efkh0, efh0, mue0, lambdae0, xp0, lambdac0 ;

ctax0(ces,i,ef) = emit(ces,ef) * utef0(ef) ; 