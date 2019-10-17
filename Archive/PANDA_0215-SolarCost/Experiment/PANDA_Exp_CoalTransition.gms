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

set
allscn          / Baseline, RF, CoalTrans, UK, Germany, Readj /
scn(allscn) / Baseline, RF, CoalTrans, UK, Germany, Readj /
;

*## Scenarios
*--
*  Baseline - PANDA baseline
*--
*  RF - Reinventing Fire baseline - energy systems transition
*--
*  CoalTrans - RF + Coal transition (jobs lost in coal) 
*--
*  UK - RF + Coal transition (jobs lost in coal) + export demand adjustment
*--
*  Germany - RF + Coal transition (jobs lost in coal) + income transfer to households
*--
*  Readj - RF + Coal transition (full employment - readjustment)
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

options limcol=0, limrow=0 ;
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

* Set sectors covered under the emissions cap
icap(i) = yes ;
ncap(i) = not(icap(i)) ;
hcap(h) = no ;

* Set energy types covered under energy consumption cap
set EneExempt(ces) Define exempt energy types /wind, solar, hydro, biomass /;
cesNCap(ces)$EneExempt(ces) = yes ;
cesCap(ces) = not(cesNCap(ces)) ;

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
display xap0 ;

$include "Code/ecal.gms"
display eta, theta, mu0;
*$goto outofhere

* ---- Initialize emissions and energy  levels
*rs0(i) = efi0("co2",i) ;
*rd0(i) = efi0("co2",i) ;
ry0  = .001 ;
efcap("co2") = 10*eft0("co2") ;
parameter 
eftT(t,ef) Baseline emissions by year
*ElecConsCapT(t)	Baseline electric power consumption by year 
asav0(h)
ge0(k)
tp00(i,g)
;

parameter EneRevShares(h) Shares for distributing energy trading revenue to households ;
EneRevShares("HHurban") = 0.5 ;
EneRevShares("HHrural") = 0.5 ; 

eftT(t,"co2") = 10 ;
EneConsumptionTT(t) = 0 ;
*display rd0, ry0 ;
display a00 ;
asav0(h) = asav(h) ;
ge0(k) = ge(k) ;
tp00(i,g) = tp0(i,g) ;

$include "Code/init.gms"

$include "Code/pandamodel.gms"

* ----- Load the dynamic definitions

*## Cap definitions

parameter samCSV(s,ss) ;

$include "Code/sam.gms"

* ----- Load data for Reinventing Fire baseline scenario
$include "Data/scenRIF.dat"

* ----- Run the scnulations
loop (scn,

*## Reinitialize scenario parameters
        atrh(h) = 0 ;
*       a.fx(k,j) = a0(k,j) ;
*       af(k,f) = af0(k,f) ;

*        icap(i) = no ;
*        ncap(i) = not(icap(i)) ;
                poff = 0 ;
        offset(i) = 0 ;


$include "Code/cal.gms"
$include "Code/init.gms"

   calflag = 0 ;
     if (ord(scn) le 2,
   calflag = 1 ;
     ) ;

   if (ord(scn) eq 2,
		mut(t,k,h) = mu0(k,h)*(38-ord(t)+1)/38 
			+ sum(tre$mapktre(k,tre),mu0(k,h)*.01*gdpus2015(tre)*(ord(t)-1)/(38*sum(kk$mapktre(kk,tre),mu0(kk,h)))) ;
     ) ;
chkth(t,h) = sum(k,mut(t,k,h)) ;
display mut, chkth ;				

*## Compute Annual Equilibria
loop(t$(year(t) ge 2012 and year(t) le 2050),

		if(ord(scn) ge 2,
*## Scenario RF (Reinventing Fire baseline)	
*		lambdae.fx(i) = lambdae0(i)*(1+AEEI)**(ord(t)-1);
*		a.fx(elec_k,"T_D") = elsh(elec_k,t)*sum(elec_kk,a00(elec_kk,"T_D")) ;
*		a.fx(k_primene,j_hvyene)$ensh(k_primene,j_hvyene,t) = ensh(k_primene,j_hvyene,t)*sum(kk_primene,a00(kk_primene,j_hvyene)) ;

*$ontext
		lambdae.fx(i) = lambdae0(i)*(1+AEEI)**(ord(t)-1);
		aene(elec_k,"T_D")$elsh(elec_k,t) = elsh(elec_k,t)*sum(elec_kk,aene(elec_kk,"T_D")) ;
		aene(k_primene,j_hvyene)$ensh(k_primene,j_hvyene,t) = ensh(k_primene,j_hvyene,t)*sum(kk_primene,aene(kk_primene,j_hvyene)) ;

*		a.fx(k_primene,j_hvyene)$ensh(k_primene,j_hvyene,t) = ensh(k_primene,j_hvyene,t)*sum(kk_primene,a00(kk_primene,j_hvyene)) ;
**		a.fx(k_primene,j_hvyene) = ensh(k_primene,j_hvyene,t)*sum(kk_primene,a00(kk_primene,j_hvyene)) ;
		mu.fx(k,h) = mut(t,k,h) ;
		asav(h) = asav0(h)*(1-0.65*(ord(t)-1)/38) ;
		csavrate.fx(e)  = csavrate0(e)*(1-0.50*(ord(t)-1)/38) ;
		savf.fx(r) = savf0(r)*(1-.5*(ord(t)-1)/38) ;
		ge(k) = ge0(k)*(1-0.90*(ord(t)-1)/38) ;
*$offtext
	);
		
        if(ord(scn) ge 3,
*## Scenario CoalTrans (coal productivity decrease)
		lambdae.fx("Coal_Power") = lambdae0("Coal_Power")*(1-.025)**(ord(t)-1);
		lambdae.fx("Coal") = lambdae0("Coal")*(1-.1)**(ord(t)-1);
*		omegal(l,gz) = 0;
    ) ;

*## Scenario UK 
        if(ord(scn) eq 4,
		  ae(k,r)$(etae(k,r) ne inf) = ae00(k,r)*(1+1.0*(ord(t)-1)/38) ;
*		ed.fx(k,r) = ed0(k,r)*1.1;
*		omegal(l,gz) = 0;
        ) ;

*## Scenario Germany
		if (ord(scn) eq 5,
		gtrh.fx(h,g) = 2*gtrh0(h,g);
*		omegal(l,gz) = 0;
*		EneCap = EneConsumptionTT(t)*(1-efcapT(t)) ;
*		efcap("co2") = eftT(t,"co2")*(1-efcapT(t)) ;
		);
		
*## Scenario Readj 
        if(ord(scn) eq 6,
*		omegal(l,gz) = 1;
        ) ;

*## Configure Dynamic Calibration
* Add second baseline calibration for the reinventing fire GDP growth rates
if (ord(scn) eq 2,
scen(t,"gdp") = GDP_RIF(t) ;
);

$include "Code/dyncal.gms"

*display savc0, savh0, yf0, savg0 ;

*      EXECUTE_LOADPOINT 'PANDA_p';
*      PANDA.Savepoint = 1;

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
display utef.l, ctax.l, emit ;
display xap.l, EneConsumptionI.l, ShadowPriceEne.l, enetax.l, sigmap, sigmav, sigmakl, sigmaene, eta, eta0;

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
     
     if (ord(scn) eq 1,
	EneConsumptionTT(t) = EneConsumptionT.l ;
     eftT(t,"co2") = eft.l("co2") ;
);
$ontext
        f (ord(scn) eq 2,
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

if (ord(scn) eq 1 and year(t) eq 2014,
$include 'Code/sam.gms'
) ;
display EneConsumptionTT ;
) ;
) ;

$label outofhere
