$COMMENT *
$Oninline
$inlinecom { }
$eolcom !

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
* -- Experiment file
* --


$Title PANDA_Exp

*Path Variable
$if not set EMPath $set EMPath _2L

*# Scenarios
* S1 = proposed regulation

set
allscn          / BAU, S1, S2, S3 /
scn(allscn) / BAU /
;

*## Scenarios
*--
*  S1 - Helicopter money - household transfers 100 percent
*--
*  S2 - Tax cuts - Cut household taxes 50 percent
*--
*  S3 - Trickle down - cut production taxes 50 percent (hold ag subsidies constant)
*##

parameter
ivb Verbose Output /0/
inco2 CO2 Scenarios /0/
echk /1.0/
CalFlag Flag determining nature of dynamic scenarios
iann Annual Results Posted /1/
iter3    Iteration counter /1/
lump govt program transfer /.1/
capinc incremental cap
cappro progressive cap
capdef deferred cap
;

* Set CalFlag to 1 to calibrate labor productivity, 0 otherwise

CalFlag = 0 ;

parameter Header Flag determining whether to output header records in output files ;
Header = 1 ;

*----- Declare the output file names

file reportfile / "Output/Panda.csv" / ;
file samfile   / "Output/samComp.csv" / ;
file samout    / "Output/samout.csv" / ;

* ----- Model output options
display "Begin output listing" ;

options limcol=1000, limrow=1000 ;
options solprint=off ;
option solvelink=2;

* ----- Input the base SAM and aggregate

$include "Data/panda42%EMPath%.dat"

$include "Data/prc42_Emit.dat"
$include "Data/scen2050.dat"
*======add this code  to change the balance of updated sam by Yaqian==========
*execute_unload 'Data\SAM_PANDA.gdx', sam
*execute 'gdxxrw.exe Data\SAM_PANDA.gdx o=Data\SAM_PANDA.xlsx par=sam rng=IO!'

*$include "Data/Scen.dat"


parameter niter(t, scn) Iteration steps ; niter(t,scn) = 1 ;

icap(i) = no ;
ncap(i) = not(icap(i)) ;
hcap(h) = no ;

* ----- Calibrate, initialize and define the model

$include "Code/decl.gms"

efi0(ef,i) = 0 ;
efi0("co2",i) = 0 ;
poff = 0 ;
offset(i) = 0 ;
auction = 0 ;
atrh(h) = 0 ;
recycle = 0 ;


rec(i) = 0 ;
$include "Code/cal.gms"

display eta, theta, mu0;
*$goto outofhere

* ---- Initialize emissions
rs0(i) = efi0("co2",i) ;
rd0(i) = efi0("co2",i) ;
ry0  = .001 ;
*display rd0, ry0 ;

$include "Code/init.gms"
$include "Code/pandamodel.gms"

* ----- Load the dynamic definitions

*## Cap definitions

parameter samCSV(s,ss) ;

$include "Code/sam.gms"


* ----- Run the scnulations
loop (scn,

*## Reinitialize scenario parameters
        atrh(h) = 0 ;
*       a.fx(k,j) = a0(k,j) ;
*       af(k,f) = af0(k,f) ;

        icap(i) = no ;
        ncap(i) = not(icap(i)) ;
                poff = 0 ;
        offset(i) = 0 ;


$include "Code/cal.gms"
$include "Code/init.gms"

   calflag = 0 ;
     if (ord(scn) le 1,
   calflag = 1 ;
     ) ;

*## Compute Annual Equilibria
loop(t$(year(t) le 2012),
*loop(t$(year(t) ge 2012 and year(t) le 2050),


        if(ord(scn) eq 2,
*## Scenario S1
                gtrh.fx(h,g) = 2*gtrh0(h,g) ;
        ) ;
*display gtrh.l ;

        if(ord(scn) eq 3,
*## Scenario S2
                kappah.fx(h,g) = .5*kappah0(h,g) ;
        ) ;

        if(ord(scn) eq 4,
*## Scenario S3
                tcp.fx(k,j,g) = .5*tcp0(k,j,g) ;
                tcp.fx(k,"agfff",g) = tcp0(k,"agfff",g) ;
        ) ;


*## Configure Dynamic Calibration
$include "Code/dyncal.gms"

*display savc0, savh0, yf0, savg0 ;

      solve PANDA using mcp ;

            put screen ;
            put //, "End of solver: scn - ", scn.tl, "  Year - ", t.tl, " Iteration - ", iter3:2:0, " of ", niter(t, scn):2:0, " iterations" // ;
            putclose ;

            if (PANDA.solvestat ne 1 or PANDA.modelstat gt 2,
               Abort$(1) "Model did not solve, aborting..."
            ) ;

*) ;

* ---- Calculate WALRAS' Law

walras =  sum(r,
                                        sum(k,wpe.l(k,r)*xe.l(k,r)) - sum(k,wpm.l(k,r)*xm.l(k,r))
                                        + sum(h,wtrh.l(h,r)) + sum(g,wtrg.l(r,g)) + savf.l(r)
                        - (sum(h,htrw.l(h,r)) + sum(g,gtrw.l(r,g))
                                +  sum(e,ctrw.l(e,r)) + sum(kt,ktrw.l(kt,r)))/er.l(r)
                         ) ;

display walras ;
display savf.l ;
display gl.l ;

* ----- Save intermediate results

     if (CalFlag eq 1,
        glT(t) = gl.l ;
        mueT(t,ef) = mue.l(ef) ;
        xpT(t,i) = xp.l(i) ;
        eftt(t,ef) = eft.l(ef) ;
        xacT(t,k,h) = xac.l(k,h) ;
        xafT(t,k,f) = xaf.l(k,f) ;
        xapT(t,k,j) = xap.l(k,j) ;
                  ndt(t,j) = nd.l(j) ;
                  ydt(t,h) = yd.l(h) ;
                  pat(t,k) = pa.l(k) ;
                  pft(t,f) = pf.l(f) ;
                  xft(t,f) = xf.l(f) ;
     ) ;

$ontext
                  if (ord(scn) eq 2,
        mueT(t,ef) = mue.l(ef) ;
        muT(t,k,h) = mu.l(k,h) ;
*       aeleT(t,j) = a.l("c15DistElec",j) ;
*       agasT(t,j) = a.l("c16DistGas",j) ;
        rdT(t,i) = rd.l(i) ;
        efit(t,ef,i) = efi.l(ef,i) ;
        eftt(t,ef) = eft.l(ef) ;
        eft0(ef) = eft.l(ef) ;
     ) ;
$Offtext

        if (TR(t),
     xpad(i) = xp.l(i) - sum(g,tfr.l(i,g))*pr.l(i)*10*efi.l("co2",i) ;
$include 'Code/postsim.gms'
      ) ;

if (ord(scn) eq 1 and year(t) eq 2012,
$include 'Code/sam.gms'
) ;

) ;
) ;
$label outofhere