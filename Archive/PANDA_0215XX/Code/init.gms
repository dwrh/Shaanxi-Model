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

* ------------------------------------------------------------------------------
*
* Initialize model variables
*
* ------------------------------------------------------------------------------

* ----- Production block

   nd.l(i)         = nd0(i) ;
   va.l(i)         = va0(i) ;
   px.l(i)         = px0(i) ;
   pp.l(i)         = pp0(i) ;
   a.fx(k,j)       = a00(k,j) ;
   xap.l(k,j)      = xap0(k,j) ;
   pnd.l(i)        = pnd0(i) ;

   ene.l(i)        = ene0(i);


   kl.l(i)         = kl0(i) ;
   ttd.l(i)        = ttd0(i) ;
   rd.l(i)         = rd0(i) ;
   pva.l(i)        = pva0(i) ;

   pene.l(i) 	   = pene0(i);

   usk.l(i)        = usk0(i) ;
   ksk.l(i)        = ksk0(i) ;
   pkl.l(i)        = pkl0(i) ;

   skl.l(i)        = skl0(i) ;
   ktd.l(i)        = ktd0(i) ;
   pksk.l(i)       = pksk0(i) ;

   ld.l(i,l)       = ld0(i,l) ;
   pusk.l(i)       = pusk0(i) ;
   pskl.l(i)       = pskl0(i) ;

   kd.l(i,kt)      = kd0(i,kt) ;
   pktd.l(i)       = pktd0(i) ;

   td.l(i,lt)      = td0(i,lt) ;
   pttd.l(i)       = pttd0(i) ;

   xp.l(i)         = xp0(i) ;
   p.l(k)          = p0(k) ;

* ----- Income block

   ly.l(l)         = ly0(l) ;
   ky.l(kt)        = ky0(kt) ;
   ty.l(lt)        = ty0(lt) ;
   ry.l            = ry0 ;
	pinc.l			= pinc0 ;

   ktre.l(kt)      = ktre0(kt) ;
   ktrh.l(kt)      = ktrh0(kt) ;
   ktrw.l(kt,r)      = ktrw0(kt,r) ;

   cy.l(e)         = cy0(e) ;
   savc.l(e)       = savc0(e) ;
   ctrh.l(e)       = ctrh0(e) ;
   ctrw.l(e,r)       = ctrw0(e,r) ;

   yh.l(h)         = yh0(h) ;
   yd.l(h)         = yd0(h) ;
   htr.l(h)        = htr0(h) ;
   htrh.l(h,hh)    = htrh0(h,hh) ;
   htrw.l(h,r)       = htrw0(h,r) ;

* ----- Demand block

   mu.fx(k,h)      = mu0(k,h) ;
   xac.l(k,h)      = xac0(k,h) ;
   savh.l(h)       = savh0(h) ;
   cpi.l(h)        = cpi0(h) ;
   fpi.l(h)        = fpi0(h) ;
   epi.l(h)        = epi0(h) ;
   eexp.l(k,h)	   = eexp0(k,h) ;

   xaf.l(k,f)      = xaf0(k,f) ;
   pf.l(f)         = pf0(f) ;
   yf.l(f)         = yf0(f) ;

* ----- Trade block

   xa.l(k)         = xa0(k) ;
   xdd.l(k)        = xdd0(k) ;
   xmt.l(k)        = xmt0(k) ;
   pa.l(k)         = pa0(k) ;

   pm.l(k,r)       = pm0(k,r) ;
   xm.l(k,r)       = xm0(k,r) ;
   pmt.l(k)        = pmt0(k) ;

   pe.l(k,r)       = pe0(k,r) ;
   xds.l(k)        = xds0(k) ;
   xet.l(k)        = xet0(k) ;
   x.l(k)          = x0(k) ;

   xe.l(k,r)       = xe0(k,r) ;
   pet.l(k)        = pet0(k) ;

   ed.l(k,r)       = ed0(k,r) ;

* ----- Domestic trade and transport margins

   ytmg.l(k,mg)    = ytmg0(k,mg) ;
   xtmg.l(k,mg)    = xtmg0(k,mg) ;
   xamg.l(k,kk,mg) = xamg0(k,kk,mg) ;
   ptmg.l(k,mg)    = ptmg0(k,mg) ;

* ----- Goods market equilibrium

   pd.l(k)         = pd0(k) ;
   wpe.l(k,r)      = wpe0(k,r) ;

* ----- Government accounts

   tary.l(g)          = tary0(g) ;
   rtary.l(g)        = rtary0(g) ;
   gy.l(g)            = gy0(g) ;
   gexp.l(g)          = gexp0(g) ;
   savg.l(g)          = savg0(g) ;
   taxadjh.l(g)       = taxadjh0(g) ;
   gtrg.l(g,gg)    = gtrg0(g,gg) ;

* ----- Closure

   xf.l(f)         = xf0(f) ;
*   plev.fx          = plev0 ;
   plev.l          = plev0 ;
   walras          = walras0 ;

* ----- Factor block

   ls.l(l,gz)      = ls0(l,gz) ;
   ewage.l(l,gz)   = ewage0(l,gz) ;
   wage.l(i,l)     = wage0(i,l) ;

   migr.l(l)       = migr0(l) ;
   awage.l(l,gz)   = awage0(l,gz) ;

   tks.l(kt)       = tks0(kt) ;
   pk.l            = pk0 ;

   ks.l(i,kt)      = ks0(i,kt) ;
   ptks.l(kt)      = ptks0(kt) ;
   rent.l(i,kt)    = rent0(i,kt) ;

   tts.l(lt)       = tts0(lt) ;
   pland.l         = pland0 ;

   ts.l(i,lt)      = ts0(i,lt) ;
   ptts.l(lt)      = ptts0(lt) ;
   pt.l(i,lt)      = pt0(i,lt) ;

   rs.l(i)         = rs0(i) ;
   pr.l(i)         = pr0(i) ;

* ----- Macro variables

   gdpmp.l         = gdpmp0 ;
   rgdpmp.l        = rgdpmp0 ;
   pgdpmp.l        = pgdpmp0 ;
   gdpfc.l         = gdpfc0 ;
   rgdpfc.l        = rgdpfc0 ;
   pgdpfc.l        = pgdpfc0 ;

* ----- Growth variables

   ggdp.l          = ggdp0 ;
   lambdal.l(i,l)  = lambdal0(i,l) ;
   lambdak.l(i,kt)  = lambdak0(i,kt) ;
   lambdat.l(i,lt)  = lambdat0(i,lt) ;
   geg.l(k,j)      = geg0(k,j) ;
   gce.l(k,h)       =gce0(k,h) ;

* ----- Growth factors

   gl.fx            = gl0 ;
   lambdar.fx(i)    = lambdar0(i) ;
   lambdae.fx(i)	= lambdae0(i) ;
   ksup.fx          = ksup0 ;
   tk.fx            = tk0 ;
   land.fx          = land0 ;
   pop.fx(h)        = pop0(h) ;
   glab.fx(l,gz)    = glab0(l,gz) ;

* ----- Trade closure

   wpm.fx(k,r)     = wpm0(k,r) ;
   wpendx.fx(k,r)  = wpendx0(k,r) ;
   er.fx(r)           = er0(r) ;
	savf.fx(r) 		= savf0(r) ;

* ----- Policy variables

   rsg.fx(g)          = rsg0(g) ;
   tp.l(i,g)         = tp0(i,g) ;
   tcp.fx(k,j,g)     = tcp0(k,j,g) ;
   tcc.fx(k,h,g)     = tcc0(k,h,g) ;
   tcf.fx(k,f,g)     = tcf0(k,f,g) ;
   kappah.fx(h,g)    = kappah0(h,g) ;
   gtrh.fx(h,g)      = gtrh0(h,g) ;
   gtrl.fx(l,g)      = gtrl0(l,g) ;
   gtrk.fx(kt,g)      = gtrk0(kt,g) ;
   kappac.fx(e,g)    = kappac0(e,g) ;

   tmadj.fx(g)        = tmadj0(g) ;
   tm.fx(k,r,g)      = tm0(k,r,g) ;
   te.fx(k,r,g)      = te0(k,r,g) ;

   tfl.fx(j,l,g)     = tfl0(j,l,g) ;
   tfk.fx(j,kt,g)    = tfk0(j,kt,g) ;
   tft.fx(j,lt,g)    = tft0(j,lt,g) ;
   tfr.fx(j,g)       = tfr0(j,g) ;
   sfr.fx(j,g)       = sfr0(j,g) ;

* ----- Miscellaneous variables

   wtrh.fx(h,r)      = wtrh0(h,r) ;
   wtrg.fx(r,g)      = wtrg0(r,g) ;
   gtrw.fx(r,g)         = gtrw0(r,g) ;
   gtrg.fx(g,gg)     = gtrg0(g,gg) ;
   ctrw.l(e,r)       = ctrw0(e,r) ;
   gtre.l(e,g)       = gtre0(e,g) ;
   csavrate.fx(e)  = csavrate0(e) ;
   tmg.fx(k,mg)    = tmg0(k,mg) ;

   efi.l(ef,i) = efi0(ef,i) ;
   efh.l(ef,h) = efh0(ef,h) ;
   efkh.l(ef,k,h) = efkh0(ef,k,h) ;
   eft.l(ef) = eft0(ef)  ;
   tef.fx(ef,i,g) = tef0(ef,i,g) ;
   the.fx(k,g) = the0(k,g) ;
*   utef.fx(ef) = utef0(ef) ;
*   lambdae.fx(ef,i) = lambdae0(ef,i) ;
   lambdac.fx(ef,k,h) = lambdac0(ef,k,h) ;
   mue.l(ef) = mue0(ef) ;
   pef.fx(ef,i) = pef0(ef,i) ;
   cef.fx(ef,i) = cef0(ef,i) ;
   pefx.fx(ef,i) = pef0(ef,i) ;
   cefx.fx(ef,i) = cef0(ef,i) ;
