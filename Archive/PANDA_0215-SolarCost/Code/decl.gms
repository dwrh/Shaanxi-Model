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
* --------------------------------------------------------------------------------------------------
*
*  Initialize output files
*
* --------------------------------------------------------------------------------------------------

put reportfile ;
if (Header eq 1, put 'Scenario,year,variable,sector,qualifier,type,value' / ; ) ;

reportfile.pc   = 5 ;
reportfile.pw = 255 ;
reportfile.nj =   1 ;
reportfile.nw =  15 ;
reportfile.nd =   9 ;
reportfile.nz =   0 ;
reportfile.nr =   0 ;

file screen / 'con' / ;

* ------------------------------------------------------------------------------
*
* Declare initial variables
*
* ------------------------------------------------------------------------------

parameters

* ----- Production block

   nd0(i)         Initial demand for aggregate intermediates
   va0(i)         Initial demand for aggregate value added
   px0(i)         Initial unit cost
   pp0(i)         Initial producer price

   xap0(k,j)      Initial demand for intermediate goods
   pnd0(i)        Initial price of aggregate intermediate demand
   geg0(k,j)      Growth rate of electrity and gas use

   ene0(i)      Initial demand for aggregate energy bundle

   kl0(i)         Initial demand for aggregate capital labor bundle
   ttd0(i)        Initial demand for aggregate land
   rd0(i)         Initial demand for sector specific resource
   pva0(i)        Initial price of aggregate value added

   usk0(i)        Initial demand for aggregate unskilled labor bundle
   ksk0(i)        Initial demand for capital skilled bundle
   pkl0(i)        Initial price of capital labour bundle

   pene0(i)      Initial price of aggregate energy bundle

   skl0(i)        Initial demand for skilled labor bundle
   ktd0(i)        Initial demand for aggregate capital
   pksk0(i)       Initial price of capital skilled labor bundle

   ld0(i,l)       Initial demand for labor by skill
   pusk0(i)       Initial price of aggregate unskilled labor bundle
   pskl0(i)       Initial price of skilled labor bundle

   kd0(i,kt)      Initial demand for capital
   pktd0(i)       Initial price of aggregate capital

   td0(i,lt)      Initial demand for land
   pttd0(i)       Aggregate land price

   xp0(i)         Initial production level
   p0(k)          Initial average commodity price

* ----- Income distribution

   ly0(l)         Initial aggregate labor income
   ky0(kt)        Initial aggregate capital income
   ty0(lt)        Initial land income
   ry0            Initial income from sector specific resource
        rysh(g)                 Governemnt shares of resource income

   ktre0(kt)      Initial aggregate corporate income
   ktrh0(kt)      Initial aggregate capital transfers to households
   ktrw0(kt,r)      Initial aggregate transfers to ROW

   cy0(e)         Initial corporate income
   savc0(e)       Initial corporate retained earnings
   ctrh0(e)       Initial aggregate corporate transfers to households
   ctrw0(e,r)       Initial corporate transfers to rest of world

* ----- Income block

   yh0(h)         Initial total household income
   yd0(h)         Initial disposable income
   htr0(h)        Initial total household transfers
   htrh0(h,hh)    Initial intra household transfers
   htrw0(h,r)       Initial transfers to rest of world

        pinc0                      Initial Personal income

* ----- Demand block

   xac0(k,h)      Initial household demand for goods and services
   savh0(h)       Initial household saving
   cpi0(h)        Initial household price index
   fpi0(h)        Initial household food price index
   epi0(h)        Initial household energy price index
   eexp0(k,h)   Value of energy expenditure by source and household
   gce0(k,h)      Growth rate of electricity and gas demand
   xaf0(k,f)      Initial sectoral expenditures for other final demand accounts
   pf0(f)         Initial expenditure deflator for other final demand accounts
   yf0(f)         Initial aggregate value of expenditures
   af0(k,f)       Final demand expenditure share parameters

* ----- Trade block

   xa0(k)         Initial Armington demand
   xdd0(k)        Initial local demand for domestic production
   xmt0(k)        Initial aggregate level of imports
   pa0(k)         Initial Armington price inclusive of margins

   pm0(k,r)       Initial import price by region inclusive of tariffs
   xm0(k,r)       Initial volume of imports by region of origin
   pmt0(k)        Initial aggregate import price

   pe0(k,r)       Initial export price by region
   xds0(k)        Initial supply for domestic sales
   xet0(k)        Initial aggregate volume of exports
   x0(k)          Initial supply of commodities

   xe0(k,r)       Initial supply of exports by region of destination
   pet0(k)        Initial aggregate export price

   ed0(k,r)       Initial demand for exports by region of destination

* ----- Domestic trade and transport margins

   ytmg0(k,mg)    Initial aggregate margin values
   xtmg0(k,mg)    Initial aggregate margin volumes
   xamg0(k,kk,mg) Initial margins
   ptmg0(k,mg)    Initial aggregate margin price index

* ----- Goods market equilibrium

   pd0(k)         Initial price of domestic sales
   wpe0(k,r)      Initial world export price in international currency terms

* ----- Government accounts

   tary0(g)          Initial level of tariff revenue
   rtary0(g)         Initial real level of tariff revenue
   gy0(g)            Initial government income
   gexp0(g)          Initial aggregate government expenditures
   savg0(g)          Initial government savings
   taxadjh0(g)       Initial household tax adjustment
   gtrg0(g,gg)          Inter governmental transfers
         gtr0(g)                                Initial intergovernmental transfers
* ----- Investment and macro closure

   xf0(f)         Initial aggregate volume of expenditures
   plev0          Initial price level
   walras0        Initial level of walras law

* ----- Factor block

   ls0(l,gz)      Initial labor supply by skill
   ewage0(l,gz)   Initial equilibrium wage
   wage0(i,l)     Initial sectoral wage by skill level

   migr0(l)       Initial migration level
   awage0(l,gz)   Initial average wage

   tlabs0         Initial total labor supply
   twage0         Initial aggregate wage

   tks0(kt)       Initial aggregate capital supply normalized
   PK0            Initial price of capital

   ks0(i,kt)      Initial sectoral capital supply
   ptks0(kt)      Initial aggregate price of capital
   rent0(i,kt)    Initial rate of return for capital

   tts0(lt)       Initial total land supply
   PLand0         Initial aggregate price of land

   ts0(i,lt)      Initial sectoral land supply
   ptts0(lt)      Initial average price of land
   pt0(i,lt)      Initial sectoral price of land

   rs0(i)         Initial sectoral sector specific resource
   pr0(i)         Initial price of sector specific resource

* ----- Macro identities

   gdpmp0         Initial GDP at market price
   rgdpmp0        Initial real GDP at market price
   pgdpmp0        Initial GDP deflator at market price
   gdpfc0         Initial GDP at factor cost
   rgdpfc0        Initial real GDP at factor
   pgdpfc0        Initial real GDP at factor cost deflator

* ----- Growth variables

   ggdp0          Initial GDP growth rate
   lambdal0(i,l)  Initial labor productivity

* ----- Growth factors

   gl0            Initial labor productivity growth rate
   lambdak0(i,kt) Initial capital productivity
   lambdat0(i,lt) Initial land productivity
   lambdar0(i)    Initial resource productivity
   lambdae0(i)	  Initial energy productivity
   KSup0          Initial aggregate capital supply normalized
   tk0            Initial non normalized aggregate capital stock
   Land0          Initial aggregate supply of land

* ----- Trade prices

   wpm0(k,r)      Initial world import price in international currency terms
   wpendx0(k,r)   Initial world export price index
   er0(r)            Initial exchange rate

* ----- Policy variables

   rsg0           Initial real government savings
   tp0(j,g)         Initial production tax
   tcp0(k,j,g)      Initial sales tax in intermediate demand
   tcc0(k,h,g)      Initial sales tax in household demand
   tcf0(k,fd,g)     Initial sales tax in other final demand
   kappah0(h,g)     Initial income rate
   gtrh0(h,g)       Initial government transfers to households
   gtrl0(l,g)       Initial government transfers to labor
   gtrk0(kt,g)       Initial government transfers to capital
   gtre0(e,g)      Government transfers to enterprises
   kappac0(e,g)     Initial corporate tax rate
   tmadj0(g)         Initial tariff adjustment factor
   tm0(k,r,g)       Initial tariff rates
   te0(k,r,g)       Initial export tax and or subsidy
   tfl0(j,l,g)      Initial tax on labor
   tfk0(j,kt,g)     Initial tax on capital
   tft0(j,lt,g)     Initial tax on land
   the0(k,g)        Initial tax on household emissions
   tfr0(j,g)        Initial tax on sector specific resource
   sfr0(j,g)        Initial subsidy on sector specific resource

*== changes for emission cap
   permits0(ces,i)  initial emission permits required by sector i for the use of fuel ces

* ----- Miscellaneous variables

   wtrh0(h,r)       Initial remittances from row
   wtrg0(r,g)          Initial transfers to government from rest of the world
   gtrw0(r,g)          Initial transfers to the rest of the world from the government
   savf0(r)          Initial foreign investment inflows
   csavrate0(e)   Initial corporate saving rate
   tmg0(k,mg)     Initial domestic margins

* ----- Dynamic variables

   pop0(h)        Initial population level
   glab0(l,gz)    Initial growth rate of labor

* ----- Lagged variables

   rgdpmpLag       Lagged GDP
   rgdpfcLag       Lagged GDP at fixed cost
   lambdalLag(i,l) Lagged labor productivity factor
   lambdakLag(i,kt) Lagged capital productivity factor
   lambdatLag(i,lt) Lagged land productivity factor
   lslag(l,gz)     Lagged labor supply
   teftlag         lagged pollution tax
   xaplag(k,j)     lagged intermediate use
   xaclag(k,h)      lagged consumption

;

* ------------------------------------------------------------------------------
*
* Declare key model parameters
*
* ------------------------------------------------------------------------------

parameters

* ----- Production block

   sigmac(k)     CES substitution of produced goods into commodities


  sigmap(i)     CES elasticity between ND and eVA bundles
  
   sigmav(i)     CES elasticity between KL and T bundles
   sigmaene(i)     CES elasticity between energy goods
   sigmakl(i)    CES elasticity between USK and KS
   sigmaks(i)    CES elasticity between K and SKL
   sigmau(i)     CES elasticity across unskilled labor
   sigmas(i)     CES elasticity across skilled labor
   sigmat(i)     CES elasticity across different types of land
   sigmak(i)     CES elasticity across different types of capital

* ----- Demand block

   eta(k,h)      Household income elasticities

* ----- Trade block

   sigmam(k)     First level Armington elasticity
   sigmaw(k)     Second level Armington elasticity
   sigmax(k)     First level CET elasticity
   sigmaz(k)     Second level CET elasticity
   etae(k,r)     Export demand elasticity


* pollution items

   efi0(ef,i) initial sectoral emissions
   efh0(ef,h) initial household emissions
   efkh0(ef,k,h) initial household emissions
   eft0(ef) initial total emissions
*   efcap0(ef) cap on restricted sectors
   tef0(ef,i,g) initial effluent tax by industry and pollutant
   efd0(ef,i,k) initial demand for abatement service
   ef0(ef,i) initial effluent tax by industry and pollutant
   pef0(ef,i) initial price of effluent abatement or diversion
   cef0(ef,i) initial cost of effluent abatement or diversion
   tefx0(ef,i,g) initial effluent tax by industry and pollutant in output units
   pefx0(ef,i) initial price of effluent abatement or diversion in output units
   cefx0(ef,i) initial cost of effluent abatement or diversion in output units
   utef0(ef) uniform sectoral effluent tax
*   lambdae0(ef,i) effluent rate per unit of output
   lambdac0(ef,k,h) effluent rate per unit of consumption
   mue0(ef) aggregate emission calibration
   cab(ef,i)  total cost of carbon abatement
   rab(ef,i,j)  price of carbon derivative
   abt(ef,i)  carbon abated
   dab(ef,k)  demand for abatement services   
   
   efcap(ef)	Exogenous emissions cap (billion tco2e)
   ctax0(ces,i,ef) 	Initial energy input specific effluent tax
   
   ElecCons0	Total base year electricity consumption (billion Yuan)
   elecShr_i(i)	Sectoral share of total electric power demand
   elecShr_h(h)	Household share of total electric power demand
   elecShr_e	Exports share of total electric power demand
   EneConsumptionI0(ces,j)	Initial industry energy use by energy type (million TCE)
   EneConsumptionT0 		Initial total energy use (million TCE) 
   Y2TCE(ces,j)				Conversion factor between output and TCE (TCE per thousand Yuan) 
   
   EneCap					Energy consumption Cap (million TCE)
   EneTax0(ces,j)			Base year energy tax ;
   ;


* ------------------------------------------------------------------------------
*
* Declare calibrated model parameters
*
* ------------------------------------------------------------------------------

parameters

* ----- Production block

   ac(i,k)       CES share parameters for transforming produced goods into commodities

   ava(i)        VA share parameter
   and(i)        ND share parameter

   a00(k,j)        Input output coefficients

   aenet(j)  	energy share in value added bundle
   aene(ces,j) 	share of each energy commodity in energy bundle

   akl(i)        KL share parameter
   au(i)         USK share parameter
   aksk(i)       KSK share parameter
   as(i)         SKL share parameter

   akt(i)        Aggregate capital share parameter
   ak(i,kt)      Capital share parameter
   att(i)        Aggregate land share parameter
   ar(i)         Natural resource share parameter
   at(i,lt)      Land share parameter
   al(i,l)       Labor by skill share parameters

* ----- Income distribution parameters

   xkht(kt)      Aggregate household share of capital earnings
   xket(kt)      Aggregate enterprise share of capital earnings
   xkwt(kt,r)      Aggregate ROW share of capital earnings

   xkh(kt,h)     Household shares of capital earnings
   xke(kt,e)     ROW shares of capital earnings
   xkw(kt,r)       ROW shares of capital earnings

   xcht(e)       Aggregate household share of corporate income
   xcwt(e,r)       Aggregate ROW share of corporate income

   xch(e,h)      Household shares of corporate earnings
   xcw(e,r)        ROW shares of corporate earnings

   xth(lt,h)     Household shares of land income

   xlh(h,l)      Household shares of labor earnings

   xrh(h)        Household share of sector specific factor earnings

* ----- Demand block

   mu0(k,h)      Marginal propensity to consume
   theta(k,h)    Subsistence minima
   asav(h)       Saving rate
   etas(h)       Income elasticity of saving
   mus(h)        Marginal propensity to save

   ahtr(h)       Share of household after tax income going to transfers
   ahtrh(h,hh)   Share of household transfers going to other households
   ahtrw(h,r)      Share of household transfers going to rest of the world

   af(k,f)       Final demand expenditure share parameters

   agtr(g)       Share of govenment income intergovernmental transfers
   agtrg(g,gg)   Share of intergovernmental transfers

* ----- Trade block

   ad(k)          Domestic share parameter
   am(k)          Import share parameter

   aw(k,r)        Second level share parameters

   gd(k)          Domestic CET share parameter
   ge(k)          Export CET share parameter

   gx(k,r)        Second level CET share parameters

   ae(k,r)        Export demand elasticity shifter
   ae00(k,r)      Initial Export demand elasticity shifter

   amg(k,kk,mg)   Domestic trade margin shares

* ----- Factor block

   als(l,gz)      Labor supply share parameter by category

   atks(kt)       Capital supply share parameters by type
   aks(i,kt)      Capital supply share parameters
   akst(kt)       Top level capital supply share parameters

   atts(lt)       Aggregate land supply share parameters
   ats(i,lt)      Land supply share parameters

   ars(i)         Sector specific supply shift parameter

   chil(i,v)      Sector and skill specific shift parameters
   phil(i,l)      Inter sectoral wage differential parameter
   chim(l)        Shift parameter for migration function
;

* ------------------------------------------------------------------------------
*
* Declare diagnostic variables for post-processing
*
* ------------------------------------------------------------------------------

parameters
   sam(s,ss)     Post proc social accounting matrix
   vatax(v,j,g)    Value added tax matrix
   walras        Evaluation of walras law
   rscale        Scale variable for output
   work          A working scalar
   index         A temporary index
   delta         Discrepancy
;

* ------------------------------------------------------------------------------
*
* Declare model variables
*
* ------------------------------------------------------------------------------

variables

* ----- Production block

   nd(i)        Demand for aggregate intermediates
   va(i)        Demand for aggregate value added
   px(i)        Unit cost
   pp(i)        Producer price
   a(k,j)        Input output coefficients
   geg(k,j)     Growth rate of electricity and gas use

   xap(k,j)     Demand for intermediate goods
   pnd(i)       Price of aggregate intermediate demand

   kl(i)        Demand for KL bundle
   ttd(i)       Aggregate sectoral demand for land
   rd(i)        Demand for the natural resource
   pva(i)       Price of aggregate value added

   pene(i)     demand for aggregated energy bundle
   ene(i)     demand for aggregate energy bundle
   
   usk(i)       Demand for aggregate unskilled labor
   ksk(i)       Demand for capital skilled labor bundle
   pkl(i)       Price of KL bundle

   skl(i)       Demand for aggregate skilled labor
   ktd(i)       Aggregate sectoral capital demand
   pksk(i)      Price of KS bundle

   ld(i,l)      Demand for labor by skill
   pusk(i)      Price of aggregate unskilled labor bundle
   pskl(i)      Price of skilled labor bundle

   kd(i,kt)     Demand for capital
   pktd(i)      Sectoral price of aggregate capital
   td(i,lt)     Demand for land
   pttd(i)      Sectoral price of aggregate land

   xp(i)        Production level
   p(k)         Aggregate commodity price

* ----- Income block

   ly(l)        Aggregate labor income
   ky(kt)       Aggregate capital income
   ltr(h)       Total labor transfers
   ktr(h)       Total capital transfers
   ty(lt)       Land income
   ry           Aggregate income from sector specific factor

   ktre(kt)     Capital income transferred to enterprises
   ktrh(kt)     Capital income transferred to households
   ktrw(kt,r)     Capital income transferred to ROW

   cy(e)        Aggregate corporate income
   savc(e)      Corporate savings
   ctrh(e)      Corporate income transferred to households
   ctrw(e,r)      Corporate income transferred to ROW

   yh(h)        Total income
   yd(h)        Disposable income
   htr(h)       Total household transfers
   htrh(h,hh)   Intra household transfers
   htrw(h,r)      Household transfers to rest of world

        pinc                       Personal income

* ----- Demand block

   mu(k,h)      Marginal propensity to consume
   gce(k,h)     Growth rate of electricity and gas consumption
   xac(k,h)     Household demand for goods and services
   savh(h)      Household savings
   cpi(h)       Consumer price deflator
   fpi(h)        Initial household food price index
   epi(h)        Initial household energy price index
   eexp(k,h)    Value of energy expenditure by source and household

   xaf(k,f)     Other final demand accounts
   pf(f)        Final demand expenditure deflator
   yf(f)        Final demand aggregate value

* ----- Trade block

   xa(k)        Aggregate Armington demand
   xdd(k)       Domestic demand for domestic output
   xmt(k)       Aggregate sectoral import demand
   pa(k)        Armington price inclusive of margins

   pm(k,r)      Import price by region inclusive of tariffs
   xm(k,r)      Import demand by region of origin
   pmt(k)       Aggregate import price

   pe(k,r)      Export producer price by region
   xds(k)       Export supply
   xet(k)       Aggregate CET volume
   x(k)         Aggregate commodity supply

   xe(k,r)      Export volumes by region of destination
   pet(k)       Aggregate export price

   ed(k,r)      Export demand

* ----- Domestic trade and transport margins

   ytmg(kk,mg)        Aggregate value of trade and transport services
   xtmg(kk,mg)        Aggregate demand for trade and transport services
   xamg(k,kk,mg)      Demand for trade and transport services
   ptmg(kk,mg)        Aggregate price of trade and transport services

* ----- Goods market equilibrium

   pd(k)        Domestic price of domestic output
   wpe(k,r)     World export price in international currency terms

* ----- Government accounts

   tary(g)               Tariff revenues
   rtary(g)              Real tariff revenues
   gy(g)                 Government revenues
   gexp(g)               Government expenditures
   savg(g)               Government savings
   taxadjh(g)            Tax adjustment factor
   gtrg(g,gg)                            Intergovernmental transfers

* ----- Closure

   xf(f)        Final demand aggregate volume
   plev         Domestic price level

* ----- Factor block

   ls(l,gz)           Aggregate labor supply by category
   ewage(l,gz)        Equilibrium wage rate
   wage(i,l)          Sectoral wage by skill level

* ----- Migration variables

   migr(l)            Rural to urban migration
   awage(l,gz)        Average wage by zone

   tks(kt)            Aggregate capital stock
   pk                 Aggregate rate of return to capital

   ptks(kt)           Aggregate rate of return to capital
   ks(i,kt)           Sectoral capital supply
   rent(i,kt)         Rate of return for capital

   tts(lt)            Land supply by type
   pland              Aggregate price of land

   ts(i,lt)           Land supply by type and sector
   ptts(lt)           Price of land by type
   pt(i,lt)           Price of land

   rs(i)              Supply of sector specific resource
   pr(i)              Price of natural resource

* ----- Macro variables

   gdpmp        GDP at market price
   rgdpmp       Real GDP at market price
   pgdpmp       GDP at market price deflator

   gdpfc        GDP at factor cost
   rgdpfc       Real GDP at factor cost
   pgdpfc       GDP at factor cost deflator

* ----- Growth variables

   ggdp          GDP growth rate
   lambdal(i,l)  Labor productivity

* ----- Growth factors

   gl            Labor productivity growth rate
   lambdak(i,kt) Capital productivity
   lambdat(i,lt) Land productivity
   lambdar(i)    Natural resource productivity
   lambdae(i)	 Energy input productivity
   ksup          Aggregate normalized capital supply
   tk            Aggregate non normalized capital supply
   land          Aggregate land supply
   pop(h)        Population
   glab(l,gz)    Labor force growth rate by zone

* ----- Trade prices

   wpm(k,r)     World import price in international currency terms
   wpendx(k,r)  Export price index
   er(r)           Exchange rate

* ----- Policy variables

   rsg(g)          Real government savings
   tp(i,g)        Production tax
   tcp(k,j,g)     Indirect taxes on intermediate consumption
   tcc(k,h,g)     Indirect taxes on household consumption
   tcf(k,f,g)     Indirect taxes on other final demand
   kappah(h,g)    Income tax rate
   gtrh(h,g)      Government transfers to households
   gtrl(l,g)      Government transfers to labor
   gtrk(kt,g)      Government transfers to capital
   kappac(e,g)       Corporate tax rate
   gtre(e,g)    Government transfers to enterprises

   tmadj(g)                     Tariff uniform adjustment factor
   tm(k,r,g)      Tariff rates
   te(k,r,g)      Export tax rates

   tfl(j,l,g)     Labor tax
   tfk(j,kt,g)    Capital tax
   tft(j,lt,g)    Land tax
   the(k,g)        Initial tax on household emissions
   tfr(j,g)       Tax on sector specific resource
   sfr(j,g)       Subsidy on sector specific resource for revenue recycling

* ----- Miscellaneous variables

   wtrh(h,r)      Remittances to households from abroad
   wtrg(r,g)         Transfers to government from rest of the world
   gtrw(r,g)         Government transfers to rest of the world
   savf(r)         Foreign investment inflows
   csavrate(e)  Corporate savings rate
   tmg(k,mg)    Domestic trading margins

* ----- pollution items
   efi(ef,i)      sectoral emissions
   efh(ef,h)      household emissions
   efkh(ef,k,h)   household emissions by commmodity
   eft(ef)        economywide emissions
   efd(ef,i,k)    initial demand for abatement service or effluent derivatives
   tef(ef,i,g)      effluent tax by industry and pollutant
   pef(ef,i)    price of effluent abatement or diversion
   cef(ef,i)    cost of effluent abatement or diversion
   tefx(ef,i,g)     effluent tax by industry and pollutant in output units
   pefx(ef,i)   price of effluent abatement or diversion in output units
   cefx(ef,i)   cost of effluent abatement or diversion in output units
*   lambdae(ef,i)  effluent rate per unit of output
   lambdac(ef,k,h)  effluent rate per unit of consumption
   mue(ef)        aggregate emission calibration
   
   EneConsumptionI(ces,j)		Sectoral energy use (million TCE)
   EneConsumptionT				Total Energy use (million TCE)
   EneCapRev					Energy trading revenue
   EmisCapRev					Emissions trading revenue
   

        fpiT(r,h,t)     agrofood price index
        epiT(r,h,t)     energy price index
        eexpT(k,h)      Value of energy expenditure by source and household

  permits(ces,i)  emission permits required by sector i for the use of fuel ces


Positive Variables
   utef(ef)       uniform sectoral effluent tax
   ctax(ces,i,ef)	Energy input-specific effluent tax
   
   ShadowPriceEne	Shadow price on energy consumption 
   EneTax(ces,j)	Energy input specific energy tax
   ;

* ----- Parameters for storing intermediate results
parameter glT(t), muT(t,k,h), mueT(t,ef), efit(t,ef,i), eftt(t,ef), EneConsumptionTT, EneConsumptionT_S2(t),
        eftmax(ef), xpt(t,i), aeleT(t,j), agasT(t,j) ;
parameter lambdarT(t,i), lambdacT(t,ef,k,h),rdt(t,i), xapT(t,k,j), xacT(t,k,h), xsh(i), ndt(t,i), ydt(t,h), pat(t,k), pft(t,f),
        xft(t,f), xafT(t,k,f), chil0(i,kt), stp, xap1(k,j), xaf1(k,f), ylhT(t,h,l) ;
parameter lambdaeT(t,i) ;

set iprod(i) Sectors with Productivity Growth ;
parameter
ar0(i)
cpt(t,i)
prt(t,i)
tfrt(t,i)
xpad(i)
stp /0/
catc /1/
catp /1/
;

glT(t) = 0 ;
xact(t,k,h) = 0 ;
xaft(t,k,f) = 0 ;
xapt(t,k,j) = 0 ;
ndt(t,i) = 0 ;
ydt(t,h) = 0 ;
pat(t,k) = 0 ;
pft(t,f) = 0 ;
xft(t,f) = 0 ;

parameter

     mu0(k,h) initial consumption shares

     ifcap(ef) indicator for effluent taxes on a cap
     ifseqa indicator for agricultural carbon sequestration         /0/
     ifseqf indicator for forest carbon sequestration               /0/
     ifseqg indicator for geologic carbon sequestration             /0/
     ifrev       indicator for revenue neutral carbon sequestration /0/
     acsa    metric tons of carbon sequestered per unit of output   /0/
     tca      payment per ton of carbon sequestered                 /0/
     acsf    metric tons of carbon sequestered per unit of output   /0/
*     tcf      payment per ton of carbon sequestered                /0/
     acsg    metric tons of carbon sequestered per unit of output   /0/
     tcg      payment per ton of carbon sequestered                 /0/
     aland  land supply calibration parameter                       /0/
     omegats price elasticity of land supply                        /.2/
     ifseq3 Two criteria for three sequestration methods            /0/
     ifland Land supply endogenous                                  /0/
     ifchp                                                          /0/
     chpen                                                          /0/
     omegag                                                         /1.5/
     ifrr      Revenue Recycling                                    /0/
     rsc        scalar for auction revenue allocation                                                   /1/

     recycle
                chke(ef)
     chkk(k)
     chki(i)
                chkki(k,i)
                chkkh(k,h)
                chkkf(k,f)
     chkh(h)
		chkth(t,h)
                chkf(f)
     chkkh1(k,h)
     chkkh2(k,h)
     chkr(r)
     chk
     chk1
     chk2
     chk3
     chk4
     chk5
     chktr(i)
     chkef(ef)
     rac(ef,i)
     catcred Credit for Climate Action Policies
     forcred Credit for Afforestation /0/
     offset(i)
     poff price of offsets per mmtco2e /0/
     auction number of permits available
         atrh(h) auction revenue shares transferred to households
         rec(i) recycled revenue share returned to sectors
     ;

* -- Definitions for ELES Calibration

parameters
   share0(k,h)    Initial budget shares
;

variables
   thetav(k,h)    Calibrated theta parameters
;

equations
   thetaeq(k,h)   Consumer demand calibration equation
;

thetaeq(k,h)$(savh0(h) ne 0)..
   xac0(k,h)*(1+sum(g,tcc0(k,h,g)))*pa0(k) =e= (1+sum(g,tcc0(k,h,g)))*pa0(k)*thetav(k,h) + mu0(k,h)*(yd0(h)
                                   -   sum(kk,(1+sum(g,tcc0(k,h,g)))*pa0(kk)*thetav(kk,h))) ;

model eles / thetaeq / ;


* -----------------------------------------------------------------------------
*
* Declare model equations
*
* ------------------------------------------------------------------------------

equations

* ----- Production block

   ndeq(i)        Demand for aggregate intermediates
   vaeq(i)        Demand for aggregate value added
   pxeq(i)        Unit cost definition
   ppeq(i)        Producer price definition
   tpeq(i,g)        Producer taxes inclusive of auction rebates

   xapeq1(m,j)     Demand for intermediate goods
   xapeq2(ces,j)     Demand for energy goods
   pndeq(i)       Price of aggregate intermediate demand

   eneeq(i)     Demand for aggregated energy bundle
   peneeq(i)	Price of energy bundle

   kleq(i)        Demand for KL bundle
   ttdeq(i)       Demand for land bundle
   rdeq(i)        Demand for natural resource bundle
   pvaeq(i)       Price of aggregate value added

   uskeq(i)       Demand for USK bundle
   kskeq(i)       Demand for KSK bundle
   pkleq(i)       Price of KL bundle

   skleq(i)       Demand for SKL bundle
   ktdeq(i)       Demand for capital bundle
   pkskeq(i)      Price of KSK bundle

   ldeq1(i,l)     Demand for labor across unskilled types
   ldeq2(i,l)     Demand for labor across skilled types
   puskeq(i)      Price of USK bundle
   pskleq(i)      Price of SKL bundle

   kdeq(i,kt)     Demand for capital
   pktdeq(i)      Price of capital bundle
   tdeq(i,lt)     Demand for land
   pttdeq(i)      Price of land bundle

   xpeq1(i,k)     Demand for output from sector i finite substitution
   xpeq2(i,k)     Demand for output from sector i infinite substitution
   peq1(k)        Aggregate price of commodity k finite substitution
   peq2(k)        Aggregate price of commodity k infinite substitution

* ----- Income distribution

   lyeq(l)        Aggregate labor remuneration
   kyeq(kt)       Aggregate capital remuneration
   tyeq(lt)       Land income
   ryeq           Aggregate sector specific factor income

   ktreeq(kt)     Capital transfers to enterprises
   ktrheq(kt)     Capital transters to households
   ktrweq(kt,r)     Capital transfers to ROW

   cyeq(e)        Corporate remuneration
   savceq(e)      Corporate savings
   ctrheq(e)      Corporate transfers to households
   ctrweq(e,r)      Corporate transfers to ROW

* ----- Income block

   yheq(h)        Household income
   ydeq(h)        Disposable household income
   htreq(h)       Transfers by households
   htrheq(h,hh)   Intra household transfers
   htrweq(h,r)      Household transfers to rest of world

* ----- Demand block

   xaceq(k,h)     Household demand for goods and services
   savheq(h)      Household savings
   cpieq(h)       Consumer price index
   fpieq(h)       Food price index
   epieq(h)       Energy price index
   eexpeq(k,h)    Energy expenditure

   xafeq(k,f)     Other final demand for goods and services
   pfeq(f)        Other final demand expenditure deflator
   yfeq(f)        Expenditure identity

* ----- Trade block

   xaeq(k)        Aggregate Armington demand
   xddeq(k)       Domestic demand for domestic production
   xmteq(k)       Aggregate sectoral import demand
   paeq(k)        Aggregate Armington price

   pmeq(k,r)      Tariff inclusive price of imports
   xmeq(k,r)      Import demand by region of origin
   pmteq(k)       Aggregate sectoral import price

   peeq(k,r)      Domestic export producer price
   xdseq1(k)      Domestic supply of domestic production with finite elasticity
   xdseq2(k)      Domestic supply of domestic production with infinite elasticity
   xeteq1(k)      Aggregate export supply with finite elasticity
   xeteq2(k)      Aggregate export supply with infinite elasticity
   xeq1(k)        Output aggregation with finite elasticity
   xeq2(k)        Output aggregation with infinite elasticity

   xeeq1(k,r)     Export supply by region of destination with finite elasticity
   xeeq2(k,r)     Export supply by region of destination with infinite elasticity
   peteq1(k)      Aggregate export price with finite elasticity
   peteq2(k)      Aggregate export price with infinite elasticity

   edeq1(k,r)     Export demand elasticity with finite elasticity
   edeq2(k,r)     Export demand elasticity with infinite elasticity

        bop                             Three way balance of payments constraint
        era                             Exchange rate arbitrage condition

* ----- Trade and transport equations

   ytmgeq1(kk)      Aggregate value of trade and transport services for domestic goods
   ytmgeq2(kk)      Aggregate value of trade and transport services for imported goods
   ytmgeq3(kk)      Aggregate value of trade and transport services for exported goods
   xtmgeq(kk,mg)    Aggregate demand for trade and transport services
   xamgeq(k,kk,mg)  Demand for trade and transport services
   ptmgeq(kk,mg)    Aggregate price of trade and transport services

* ----- Goods market equilibrium

   pdeq(k)        Domestic market equilibrium
   wpeeq(k,r)     Export market equilibrium

* ----- Government accounts

   taryeq(g)         Tariff revenues identity
   rtaryeq(g)        Real tariff revenues
   gyeq(g)           Government revenues
   gexpeq(g)         Government expenditures
   savgeq(g)         Government savings
   rsgeq(g)          Real government savings

* ----- Closure equations

   tieq           Saving investment balance
   pleveq         Price level

* ----- Factor markets

   lseq1(l)       Labor supply equation with finite supply
   lseq2(l)       Labor supply equation with infinite supply
   ewageq(l)      Equilibrium wage rate
   wageq(i,l)     Sectoral wages

* ----- Migration equations

   migreq(l)      Migration equation
   awageq(l,gz)   Average wage equations

   ewageq2(l,gz)  Equilibrium wage
   wageq2(i,l,gz) Sectoral wages

   rlseq(l)       Rural labor supply
   ulseq(l)       Urban labor supply
   tlseq(l)       Total labor supply

   tkseq1(kt)     Capital supply by type with finite transformation
   tkseq2(kt)     Capital supply by type with infinite transformation
   pkeq1          Aggregate price of capital with finite transformation
   pkeq2          Aggregate price of capital with infinite transformation

   kseq1(i,kt)    Capital supply with finite transformation
   kseq2(i,kt)    Capital supply with infinite transformation
   ptkseq1(kt)    Capital price with finite transformation
   ptkseq2(kt)    Capital price with infinite transformation
   renteq(i,kt)   Equilibrium sectoral rental rates

   ttseq1(lt)     Supply of land by type with finite transformation
   ttseq2(lt)     Supply of land by type with infinite transformation
   plandeq1       Aggregate land price with finite transformation
   plandeq2       Aggregate land price with infinte transformation

   tseq1(i,lt)    Land supply with finite transformation
   tseq2(i,lt  )  Land supply with infinite transformation
   pttseq1(lt)    Price of land by type with finite transformation
   pttseq2(lt)    Price of land by type with infinite transformation
   pteq(i,lt)     Equilibrium sectoral land rates

   rseq1(i)       Sector specific supply function with finite elasticity
   rseq2(i)       Sector specific supply function with infinite elasticity
   preq(i)        Sector specific factor market equilibrium condition

* ----- Macro identities

   gdpmpeq        GDP at market price identity
   rgdpmpeq       Real GDP at market price identity
   pgdpmpeq       GDP at market price deflator

   gdpfceq        GDP at factor cost identity
   rgdpfceq       Real GDP at factor cost identity
   pgdpfceq       Real GDP at factor cost deflator

* ----- Growth equations

   ggdpeq         Growth rate of real GDP
   lambdaleq(i,l) Labor productivity factor
   lambdakeq(i,kt) Labor productivity factor
   lambdateq(i,lt) Labor productivity factor
   gegeq(k,j)     Growth of intermediate energy use
   gceeq(k,h)     Growth of household energy use

* ----- Pollution Equations

   efieq(ef,i) emissions by industry and pollutant
   efheq(ef,h) emissions by industry and pollutant
   efteq(ef)  economywide emissions by pollutant
   efcapeq(ef)     emissions cap on restricted activities
   efcieq(ef,i)  homogeneous quota rents (tef) for effluent cap
   efckeq(ef,k)  homogeneous quota rents (the) for effluent cap
   sfreq(i,g) Revenue recycling ad valorem equivalent subsidy
   
   ctaxeq(ces,i,ef)	Energy input specific effluent tax
   
   EneConsumptionIeq(ces,j)	Sectoral energy use (million TCE)
   EneConsumptionTeq		Total energy use (million TCE)
   
   EneCapeq			Cap on energy consumption
   EneTaxeq(ces,j)	Sectoral tax on energy consumption
   EneCapReveq		Energy trading revenue
   EmisCapReveq		Emissions trading revenue


*   pefxeq(ef,i)
*   cefxeq(ef,i)
   ;
