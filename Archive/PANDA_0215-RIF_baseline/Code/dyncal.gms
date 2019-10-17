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

if (ord(t) eq 1,

*     Define the necessary lags

      lambdalLag(i,l)  = lambdal0(i,l) ;
      lambdakLag(i,kt)  = lambdak0(i,kt) ;
      lambdatLag(i,lt)  = lambdat0(i,lt) ;
      rgdpmpLag        = rgdpmp0 ;
      rgdpfcLag        = rgdpfc0 ;
      xaplag(k,j)      = xap0(k,j) ;
      xaclag(k,h)      = xac0(k,h) ;


*     Update exogenous variables

      als(l,"Tot") = als(l,"Tot") ;
*      als(l,"Tot") = als(l,"Tot")*(1+0.01*lScen(t,l)) ;

      pop.fx(h)    = pop0(h) ;

      xf.fx("govt") = xf0("govt") ;

      tk.fx        = tk0 ;
      ksup.fx      = (ksup0/tk0)*tk0 ;

      land.fx      = land0 ;

      ars(i)       = ars(i) ;

      tmg.fx(k,mg) = tmg0(k,mg) ;

*     Update agricultural productivity

      lambdal.fx(np,l)  = lambdal0(np,l) ;
      lambdak.fx(np,kt) = lambdak0(np,kt) ;
      lambdat.fx(np,lt) = lambdat0(np,lt) ;
      lambdal.lo(ip,l)  = -inf ;
      lambdak.lo(ip,kt) = -inf ;
      lambdat.lo(ip,lt) = -inf ;
      lambdal.up(ip,l)  = +inf ;
      lambdak.up(ip,kt) = +inf ;
      lambdat.up(ip,lt) = +inf ;

else

*     Define the necessary lags

      lambdalLag(i,l)  = lambdal.l(i,l) ;
      lambdakLag(i,kt)  = lambdak.l(i,kt) ;
      lambdatLag(i,lt)  = lambdat.l(i,lt) ;
      rgdpmpLag        = rgdpmp.l ;
      rgdpfcLag        = rgdpfc.l ;
      xaplag(k,j)      = xap.l(k,j) ;
      xaclag(k,h)      = xac.l(k,h) ;


*     Update exogenous variables

      als(l,"Tot") = als(l,"Tot") ;
*      als(l,"Tot") = als(l,"Tot")*(1+0.01*Scen(t,"grlab")) ;
*      als(l,"Tot") = als(l,"Tot")*(1+0.01*lScen(t,l)) ;

      pop.fx(h)    = pop.l(h)*(1+0.01*Scen(t,"Pop")) ;

      xf.fx("govt") = xf.l("govt")*(1+0.01*Scen(t,"GDP"))**step(t) ;

      tk.fx        = (1-0.01*Scen(t,"depr"))*tk.l + xf.l("capacct") ;
*      tk.fx        = tk.l*(1+0.01*Scen(t,"Pop")) ;
      ksup.fx      = (ksup0/tk0)*tk.l ;

      land.fx      = (1+0.01*Scen(t,"LandR"))*land.l ;

      ars(i)       = (1+0.01*Scen(t,"NatR"))*ars(i) ;

      tmg.fx(k,mg) = (1+0.01*Scen(t,"Margin"))*tmg.l(k,mg) ;

*     Update agricultural productivity

*      lambdal.fx(ag,l)  = (1+0.01*Scen(t,"AgProd"))*lambdal.l(ag,l) ;
*      lambdak.fx(ag,kt) = (1+0.01*Scen(t,"AgProd"))*lambdak.l(ag,kt) ;
*      lambdat.fx(ag,lt) = (1+0.01*Scen(t,"AgProd"))*lambdat.l(ag,lt) ;

);

*  Fiscal Closure
*    1. Endogenous Government Saving, fixed taxes
*   	rsg.lo = -inf ;
*   	rsg.up = +inf ;
*   	taxadjh.fx = taxadjh0 ;
*    2. Fixed Government Saving, lump sum redistribution
   	taxadjh.lo(g) = -inf ;
   	taxadjh.up(g) = +inf ;
   	rsg.fx(g) = rsg0(g) ;

*if (ord(t) ne 1,

      if (CalFlag eq 1,

*     Endogenize factor productivity growth for the Baseline calibration

         gl.lo = -inf ;
         gl.up = +inf ;

*         if (ord(t) eq 2, gl.l = 0.01 ; ) ;

         ggdp.fx = (1+0.01*Scen(t,"GDP"))**step(t) ;

$Ontext
*    Run Baseline Pollution Intensity Forward
     if (ord(scn) eq 1,
          mue.fx(ef) = mue.l(ef) ;
          eft.lo(ef) = -inf ;
          eft.up(ef) = +inf ;
     ) ;          
$offtext
 
    else      

         gl.fx = glT(t) ;

         ggdp.lo = -inf ;
         ggdp.up = +inf ;

		
	) ;
$ontext
*  Fiscal Closure
if(1,
*    1. Endogenous Government Saving, fixed taxes
	   	rsg.lo = -inf ;
	   	rsg.up = +inf ;
	   	taxadjh.fx = taxadjh0 ;	
else
*    2. Fixed Government Saving, lump sum redistribution
   		rsg.fx = rsg0 ;
   		taxadjh.lo = -inf ;
   		taxadjh.up = +inf ;
) ;
*     Endogenize labor productivity growth for the BaU, else
*     Endogenize GDP growth

      if (CalFlag eq 1,

         gl.lo = -inf ;
         gl.up = +inf ;

         if (ord(t) eq 2, gl.l = 0.01 ; ) ;

**         ggdp.fx = (1+0.01*Scen(t,"GDP")) ;
       ggdp.fx = 0.01*Scen(t,"GDP") ;

*    Run BAU Pollution Intensity Forward
     if (ord(sim) eq 1,
          mue.fx(ef) = mue.l(ef) ;
          eft.lo(ef) = -inf ;
          eft.up(ef) = +inf ;
     ) ;          

      else

         gl.fx = glT(t) ;

         ggdp.lo = -inf ;
         ggdp.up = +inf ;

      ) ;
$offtext
