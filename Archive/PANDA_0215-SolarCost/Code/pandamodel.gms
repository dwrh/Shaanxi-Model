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
* Define model equations
*
* ------------------------------------------------------------------------------

* ----- Production block

* ----- Top level nest

* ----- Equation (P-1)

ndeq(i)..
   nd(i)*pnd(i)**sigmap(i) =e= and(i)*xp(i)*px(i)**sigmap(i) ;

* ----- Equation (P-2)

vaeq(i)$(va0(i) ne 0)..
   va(i)*pva(i)**sigmap(i) =e= ava(i)*xp(i)*px(i)**sigmap(i) ;

va.fx(i)$(va0(i) eq 0) = 0 ;

* ----- Equation (P-3)

pxeq(i)..
   px(i)**(1-sigmap(i)) =e= and(i)*pnd(i)**(1-sigmap(i)) + ava(i)*pva(i)**(1-sigmap(i)) ;

* ----- Equation (P-4)

ppeq(i)..
    pp(i) =e= (1+sum(g,tp(i,g)))*px(i) ;

tpeq(i,g)..
   tp(i,g) =e= tp0(i,g) ;

* ----- Second level nests

* ----- Equation (P-5)
*== change to seperate intermediates and energy Input

xapeq1(m,j)$(xap0(m,j) ne 0)..
   xap(m,j) =e= a(m,j)*nd(j) ;

xap.fx(m,j)$(xap0(m,j) eq 0) = 0 ;

* ----- Equation (P-6)

pndeq(j)..
   pnd(j) =e= sum(m,a(m,j)*(1+sum(g,tcp(m,j,g)))*pa(m)) ;

* ----- Equation (P-7)
  eneeq(i)$(ene0(i) ne 0)..
      lambdae(i)*ene(i)*pene(i)**sigmav(i) =e= aenet(i)*va(i)*(lambdae(i)*pva(i))**sigmav(i) ;

  ene.fx(i)$(ene0(i) eq 0) = 0 ;

* ----- Equation (P-7)

kleq(i)$(kl0(i) ne 0)..
   kl(i)*pkl(i)**sigmav(i) =e= akl(i)*va(i)*(pva(i)**sigmav(i)) ;

kl.fx(i)$(kl0(i) eq 0) = 0 ;


* ----- Equation (P-8)

ttdeq(i)$(att(i) ne 0)..
   ttd(i)*pttd(i)**sigmav(i) =e= att(i)*va(i)*(pva(i)**sigmav(i)) ;

ttd.fx(i)$(att(i) eq 0) = 0 ;

* ----- Equation (P-9)

rdeq(i)$(rd0(i) ne 0)..
   lambdar(i)*rd(i)*pr(i)**sigmav(i) =e= ars(i)*va(i)*(lambdar(i)*pva(i))**sigmav(i) ;

rd.fx(i)$(rd0(i) eq 0) = 0 ;

* ----- Equation (P-10)

pvaeq(i)$(va0(i) ne 0)..
   pva(i)**(1-sigmav(i)) =e= akl(i)*pkl(i)**(1-sigmav(i))
                                                        + aenet(i)*(pene(i)/lambdae(i))**(1-sigmav(i))
*                          +  ars(i)*pr(i)**(1-sigmav(i))
                          +  ars(i)*(pr(i)/lambdar(i))**(1-sigmav(i))
                          +  att(i)*pttd(i)**(1-sigmav(i)) ;

pva.fx(i)$(va0(i) eq 0) = 1 ;

* ----- Equation (P-7)
xapeq2(ces,i)$(ene0(i) ne 0)..
      xap(ces,i)*(sum(ef,ctax(ces,i,ef))+enetax(ces,i)+pa(ces))**sigmaene(i) 
      =e= aene(ces,i)*ene(i)*(pene(i)**sigmaene(i)) ;     

  xap.fx(ces,i)$(  xap0(ces,i) eq 0) = 0 ;

peneeq(j).. pene(j)=e= sum(ces, aene(ces,j)*
            (sum(ef,ctax(ces,j,ef))+enetax(ces,j)+pa(ces)*(1+sum(g,tcp(ces,j,g))))
            **(1-sigmaene(j)));
            

* ----- Third level nest

* ----- Equation (P-11)

uskeq(i)$(au(i) ne 0)..
   usk(i)*pusk(i)**sigmakl(i) =e= au(i)*kl(i)*pkl(i)**sigmakl(i) ;

usk.fx(i)$(au(i) eq 0) = 0 ;

* ----- Equation (P-12)

kskeq(i)$(aksk(i) ne 0)..
   ksk(i)*pksk(i)**sigmakl(i) =e= aksk(i)*kl(i)*pkl(i)**sigmakl(i) ;

ksk.fx(i)$(aksk(i) eq 0) = 0 ;

* ----- Equation (P-13)

pkleq(i)$(kl0(i) ne 0)..
   pkl(i)**(1-sigmakl(i)) =e= au(i)*pusk(i)**(1-sigmakl(i)) + aksk(i)*pksk(i)**(1-sigmakl(i)) ;

pkl.fx(i)$(kl0(i) eq 0) = 1 ;

* ----- Fourth level nest

* ----- Equation (P-14)

skleq(i)$(as(i) ne 0)..
   skl(i)*pskl(i)**sigmaks(i) =e= as(i)*ksk(i)*pksk(i)**sigmaks(i) ;

skl.fx(i)$(as(i) eq 0) = 0 ;

* ----- Equation (P-15)

ktdeq(i)$(akt(i) ne 0)..
   ktd(i)*pktd(i)**sigmaks(i) =e= akt(i)*ksk(i)*pksk(i)**sigmaks(i) ;

ktd.fx(i)$(akt(i) eq 0) = 0 ;

* ----- Equation (P-16)

pkskeq(i)$(ksk0(i) ne 0)..
   pksk(i)**(1-sigmaks(i)) =e= as(i)*pskl(i)**(1-sigmaks(i)) + akt(i)*pktd(i)**(1-sigmaks(i)) ;

pksk.fx(i)$(ksk0(i) eq 0) = 1 ;

* ----- Decomposition of labor demand

* ----- Equation (P-17)

ldeq1(i,ul)$(al(i,ul) ne 0)..
   lambdal(i,ul)*ld(i,ul)*wage(i,ul)**sigmau(i) =e=
      al(i,ul)*usk(i)*(pusk(i)*lambdal(i,ul))**sigmau(i) ;

* ----- Equation (P-18)

ldeq2(i,sl)$(al(i,sl) ne 0)..
   lambdal(i,sl)*ld(i,sl)*wage(i,sl)**sigmas(i) =e=
      al(i,sl)*skl(i)*(pskl(i)*lambdal(i,sl))**sigmas(i) ;

ld.fx(i,l)$(al(i,l) eq 0) = 0 ;

* ----- Equation (P-19)

puskeq(i)$(usk0(i) ne 0)..
   pusk(i)**(1-sigmau(i)) =e= sum(ul, al(i,ul)*(wage(i,ul)/lambdal(i,ul))**(1-sigmau(i))) ;

* ----- Equation (P-20)

pskleq(i)$(skl0(i) ne 0)..
   pskl(i)**(1-sigmas(i)) =e= sum(sl, al(i,sl)*(wage(i,sl)/lambdal(i,sl))**(1-sigmas(i))) ;

pusk.fx(i)$(usk0(i) eq 0) = 1 ;
pskl.fx(i)$(skl0(i) eq 0) = 1 ;

* ----- Decompose capital bundle

* ----- Equation (P-21)

kdeq(i,kt)$(ak(i,kt) ne 0)..
   lambdak(i,kt)*kd(i,kt)*rent(i,kt)**sigmak(i) =e= ak(i,kt)*ktd(i)*(pktd(i)*lambdak(i,kt))**sigmak(i) ;

kd.fx(i,kt)$(ak(i,kt) eq 0) = 0 ;

* ----- Equation (P-22)

pktdeq(i)$(akt(i) ne 0)..
   pktd(i)**(1-sigmak(i)) =e= sum(kt,ak(i,kt)*(rent(i,kt)/lambdak(i,kt))**(1-sigmak(i))) ;

pktd.fx(i)$(akt(i) eq 0) = 1 ;

* Decompose the land bundle

* ----- Equation (P-23)

tdeq(i,lt)$(at(i,lt) ne 0)..
   lambdat(i,lt)*td(i,lt)*pt(i,lt)**sigmat(i) =e= at(i,lt)*ttd(i)*(lambdat(i,lt)*pttd(i))**sigmat(i) ;

td.fx(i,lt)$(at(i,lt) eq 0) = 0 ;

* ----- Equation (P-24)

pttdeq(i)$(att(i) ne 0)..
   pttd(i)**(1-sigmat(i)) =e= sum(lt,at(i,lt)*(pt(i,lt)/lambdat(i,lt))**(1-sigmat(i))) ;

pttd.fx(i)$(att(i) eq 0) = 0 ;

* ----- Aggregation into commodities

* ----- Equation (P-25)

xpeq1(i,k)$(mapik(i,k) and sigmac(k) ne inf)..

   xp(i)*pp(i)**sigmac(k) =e= ac(i,k)*x(k)*p(k)**sigmac(k) ;

xpeq2(i,k)$(mapik(i,k) and sigmac(k) eq inf)..
   pp(i) =e= p(k) ;

* ----- Equation (P-26)

peq1(k)$(sigmac(k) ne inf and x0(k) ne 0)..
   p(k)**(1-sigmac(k)) =e= sum(i$mapik(i,k),ac(i,k)*pp(i)**(1-sigmac(k))) ;

peq2(k)$(sigmac(k) eq inf and x0(k) ne 0)..
   x(k) =e= sum(i$mapik(i,k),xp(i)) ;

p.fx(k)$(x0(k) eq 0) = 1 ;

* ----- Income distribution

* ----- Aggregate factor incomes net of factor taxes

* ----- Equation (Y-1)

lyeq(l)..
   ly(l) =e= sum(i,wage(i,l)*ld(i,l)/(1+sum(g,tfl(i,l,g))))  + plev*sum(g,gtrl(l,g));

* ----- Equation (Y-2)

kyeq(kt)..
   ky(kt) =e= sum(i,rent(i,kt)*kd(i,kt)/(1+sum(g,tfk(i,kt,g))))  + plev*sum(g,gtrk(kt,g));

* ----- Equation (Y-3)

tyeq(lt)$(ty0(lt) ne 0)..
   ty(lt) =e= sum(i,pt(i,lt)*td(i,lt)/(1+sum(g,tft(i,lt,g)))) ;

ty.fx(lt)$(ty0(lt) eq 0) = 0 ;

* ----- Equation (Y-4)

ryeq$(ry0 ne 0)..
   ry =e= sum(i,pr(i)*rd(i)) ;
*   ry =e= sum(i,pr(i)*rd(i)/(1+tfr(i)-sfr(i)))- sum(icap,poff*offset(icap));

ry.fx$(ry0 eq 0) = 0 ;

* ----- Distribution of capital income

* ----- Equation (Y-5)

ktreeq(kt)$(ktre0(kt) ne 0)..
   ktre(kt) =e= xket(kt)*ky(kt) ;

ktre.fx(kt)$(ktre0(kt) eq 0) = 0 ;

* ----- Equation (Y-6)

ktrheq(kt)$(ktrh0(kt) ne 0)..
   ktrh(kt) =e= xkht(kt)*ky(kt) ;

ktrh.fx(kt)$(ktrh0(kt) eq 0) = 0 ;

* ----- Equation (Y-7)

ktrweq(kt,r)$(ktrw0(kt,r) ne 0)..
   ktrw(kt,r) =e= xkwt(kt,r)*ky(kt) ;

ktrw.fx(kt,r)$(ktrw0(kt,r) eq 0) = 0 ;

* ----- Distribution of corporate income

* ----- Equation (Y-8)

cyeq(e)$(cy0(e) ne 0)..
   cy(e) =e= sum(kt,xke(kt,e)*ktre(kt)) ;

cy.fx(e)$(cy0(e) eq 0) = 0 ;

* ----- Equation (Y-9)

savceq(e)$(savc0(e) ne 0)..
   savc(e) =e= csavrate(e)*((1-sum(g,kappac(e,g)))*cy(e)) ;

savc.fx(e)$(savc0(e) eq 0) = 0 ;

* ----- Equation (Y-10)

ctrheq(e)$(ctrh0(e) ne 0)..
   ctrh(e) =e= xcht(e)*((1-sum(g,kappac(e,g)))*cy(e)) ;

ctrh.fx(e)$(ctrh0(e) eq 0) = 0 ;

* ----- Equation (Y-11)

ctrweq(e,r)$(ctrw0(e,r) ne 0)..
   ctrw(e,r) =e= xcwt(e,r)*((1-sum(g,kappac(e,g)))*cy(e)) ;

ctrw.fx(e,r)$(ctrw0(e,r) eq 0) = 0 ;

* ----- Household income

* ----- Equation (Y-12)

yheq(h)..
   yh(h) =e= sum(l,xlh(h,l)*ly(l)) + sum(kt,xkh(kt,h)*ktrh(kt)) + sum(e,xch(e,h)*ctrh(e))
                +  sum(lt,xth(lt,h)*ty(lt)) + plev*sum(g,gtrh(h,g)) + sum(hh,htrh(h,hh))
                                + sum(r,er(r)*wtrh(h,r)) + atrh(h)*rsc*ry 
                                + EneRevShares(h) * EneCapRev ;


* ----- Equation (Y-13)

ydeq(h)..
   yd(h) =e= (1-sum(g,taxadjh(g)*kappah(h,g)))*yh(h) - htr(h) ;

* ----- Equation (Y-14)

htreq(h)$(ahtr(h) ne 0)..
   htr(h) =e= ahtr(h)*(1-sum(g,taxadjh(g)*kappah(h,g)))*yh(h) ;

htr.fx(h)$(ahtr(h) eq 0) = 0 ;

* ----- Equation (Y-15)

htrheq(h,hh)$(ahtrh(h,hh) ne 0)..
   htrh(h,hh) =e= ahtrh(h,hh)*htr(hh) ;

htrh.fx(h,hh)$(ahtrh(h,hh) eq 0) = 0 ;

* ----- Equation (Y-16)

htrweq(h,r)$(ahtrw(h,r) ne 0)..
   htrw(h,r) =e= ahtrw(h,r)*htr(h) ;

htrw.fx(h,r)$(ahtrw(h,r) eq 0) = 0 ;

* ----- Demand block

* ----- Household demand

* ----- Equation (D-1)

xaceq(k,h)$(mu0(k,h) ne 0)..
   xac(k,h)*(1+sum(g,tcc(k,h,g)))*pa(k) =e= (1+sum(g,tcc(k,h,g)))*pa(k)*theta(k,h)*pop(h) + mu(k,h)*(yd(h)*(1-asav(h))
                                -   pop(h)*sum(kk,(1+sum(g,tcc(kk,h,g)))*pa(kk)*theta(kk,h))) ;

xac.fx(k,h)$(mu0(k,h) eq 0) = 0 ;


* ----- Equation (D-2)

savheq(h)..
   savh(h) =e= yd(h) - sum(k,(1+sum(g,tcc(k,h,g)))*pa(k)*xac(k,h)) ;

* ----- Equation (D-3)

cpieq(h)..
   cpi(h)*sum(k,(1+sum(g,tcc0(k,h,g)))*pa0(k)*xac0(k,h)) =e= sum(k,(1+sum(g,tcc(k,h,g)))*pa(k)*xac0(k,h)) ;

fpieq(h)..
   fpi(h)*sum(food,(1+sum(g,tcc0(food,h,g)))*pa0(food)*xac0(food,h)) =e= sum(food,(1+sum(g,tcc(food,h,g)))*pa(food)*xac0(food,h)) ;

epieq(h)..
   epi(h)*sum(erg,(1+sum(g,tcc0(erg,h,g)))*pa0(erg)*xac0(erg,h))
        =e= sum(erg,(1+sum(g,tcc(erg,h,g)))*pa(erg)*xac0(erg,h)) ;

eexpeq(k,h)$(eexp0(k,h) ne 0)..
   eexp(k,h) =e= pa(k)*xac(k,h) ;

eexp.fx(k,h)$(eexp0(k,h) eq 0) = 0 ;

* ----- Other final demand

* ----- Equation (D-4)

xafeq(k,f)$(af(k,f) ne 0)..
   xaf(k,f)*((1+sum(g,tcf(k,f,g)))*pa(k))**sigmaf(f) =e= af(k,f)*xf(f)*pf(f)**sigmaf(f) ;

xaf.fx(k,f)$(af(k,f) eq 0) = 0 ;

* ----- Equation (D-5)

pfeq(f)$(xf0(f) ne 0)..
   pf(f)**(1-sigmaf(f)) =e= sum(k,af(k,f)*((1+sum(g,tcf(k,f,g)))*pa(k))**(1-sigmaf(f))) ;

pf.fx(f)$(xf0(f) eq 0) = 1 ;

* ----- Equation (D-6)

yfeq(f)$(xf0(f) ne 0)..
   yf(f) =e= pf(f)*xf(f) ;

yf.fx(f)$(xf0(f) eq 0) = 0 ;
xf.fx(f)$(xf0(f) eq 0) = 0 ;

* ----- Trade block

* ----- Armington system

* ----- Equation (T-1)

xaeq(k)..
*   xa(k) =e= sum(j,xap(k,j)) + sum(h,xac(k,h)) + sum(f,xaf(k,f)) + sum(kk, sum(mg, xamg(k,kk,mg))) ;
*    xa(k) =e= sum(j,xap(k,j)) + sum(h,xac(k,h)) + sum(f,xaf(k,f)) + sum(kk, xamg(k,kk,"d")) ;
    xa(k) =e= sum(j,xap(k,j)) + sum(h,xac(k,h)) + sum(f,xaf(k,f))  ;
*             + sum(ef,dab(ef,k)) ;

* ----- Equation (T-2)

xddeq(k)$(xdd0(k) ne 0)..
   xdd(k)*(pd(k)*(1+tmg(k,"d")))**sigmam(k) =e= ad(k)*xa(k)*pa(k)**sigmam(k) ;

xdd.fx(k)$(xdd0(k) eq 0) = 0 ;

* ----- Equation (T-3)

xmteq(k)$(xmt0(k) ne 0)..
   xmt(k)*pmt(k)**sigmam(k) =e= am(k)*xa(k)*pa(k)**sigmam(k) ;

xmt.fx(k)$(xmt0(k) eq 0) = 0 ;

* ----- Equation (T-4)

paeq(k)..
   pa(k)**(1-sigmam(k)) =e= ad(k)*(pd(k)*(1+tmg(k,"d")))**(1-sigmam(k))
                         +  am(k)*(pmt(k)**(1-sigmam(k))) ;

* ----- Equation (T-5)

pmeq(k,r)$(xm0(k,r) ne 0)..
   pm(k,r) =e= er(r)*wpm(k,r)*(1+sum(g,tmadj(g)*tm(k,r,g))) ;

pm.fx(k,r)$(xm0(k,r) eq 0) = 1 ;

* ----- Equation (T-6)

xmeq(k,r)$(xm0(k,r) ne 0)..
   xm(k,r)*((1+tmg(k,"m"))*pm(k,r))**sigmaw(k) =e= aw(k,r)*xmt(k)*pmt(k)**sigmaw(k) ;

xm.fx(k,r)$(xm0(k,r) eq 0) = 0 ;

* ----- Equation (T-7)

pmteq(k)$(xmt0(k) ne 0) ..
   pmt(k)**(1-sigmaw(k)) =e= sum(r,aw(k,r)*((1+tmg(k,"m"))*pm(k,r))**(1-sigmaw(k))) ;

pmt.fx(k)$(xmt0(k) eq 0) = 1 ;

* ----- CET system

* ----- Equation (T-8)

peeq(k,r)$(xe0(k,r) ne 0)..
   pe(k,r)*(1+tmg(k,"x"))*(1+sum(g,te(k,r,g))) =e= er(r)*wpe(k,r) ;

pe.fx(k,r)$(xe0(k,r) eq 0) = 1 ;

* ----- Equation (T-9)

xdseq1(k)$(sigmax(k) ne inf and xds0(k) ne 0)..
   xds(k)*p(k)**sigmax(k) =e= gd(k)*x(k)*pd(k)**sigmax(k) ;

xdseq2(k)$(sigmax(k) eq inf and xds0(k) ne 0)..
   pd(k) =e= p(k) ;

xds.fx(k)$(xds0(k) eq 0) = 0 ;

* ----- Equation (T-10)

xeteq1(k)$(sigmax(k) ne inf and xet0(k) ne 0)..
   xet(k)*p(k)**sigmax(k) =e= ge(k)*x(k)*pet(k)**sigmax(k) ;

xeteq2(k)$(sigmax(k) eq inf and xet0(k) ne 0)..
   pet(k) =e= p(k) ;

xet.fx(k)$(xet0(k) eq 0) = 0 ;

* ----- Equation (T-11)

xeq1(k)$(sigmax(k) ne inf and x0(k) ne 0)..
   p(k)**(1+sigmax(k)) =e= gd(k)*pd(k)**(1+sigmax(k)) + ge(k)*pet(k)**(1+sigmax(k)) ;

xeq2(k)$(sigmax(k) eq inf and x0(k) ne 0)..
   x(k) =e= xds(k) + xet(k) ;

x.fx(k)$(x0(k) eq 0) = 0 ;

* ----- Equation (T-12)

xeeq1(k,r)$(sigmaz(k) ne inf and xe0(k,r) ne 0)..
   xe(k,r)*pet(k)**sigmaz(k) =e= gx(k,r)*xet(k)*pe(k,r)**sigmaz(k) ;

xeeq2(k,r)$(sigmaz(k) eq inf and xe0(k,r) ne 0)..
   pe(k,r) =e= pet(k) ;

xe.fx(k,r)$(xe0(k,r) eq 0) = 0 ;

* ----- Equation (T-13)

peteq1(k)$(sigmaz(k) ne inf and xet0(k) ne 0)..
   pet(k)**(1+sigmaz(k)) =e= sum(r,gx(k,r)*pe(k,r)**(1+sigmaz(k))) ;

peteq2(k)$(sigmaz(k) eq inf and xet0(k) ne 0)..
   xet(k) =e= sum(r,xe(k,r)) ;

pet.fx(k)$(xet0(k) eq 0) = 1 ;

* ----- Export demand

* ----- Equation (T-14)

edeq1(k,r)$(etae(k,r) ne inf and ed0(k,r) ne 0)..
   ed(k,r)*wpe(k,r)**etae(k,r) =e= ae(k,r)*wpendx(k,r)**etae(k,r) ;

edeq2(k,r)$(etae(k,r) eq inf and ed0(k,r) ne 0)..
   wpe(k,r) =e= wpendx(k,r) ;

ed.fx(k,r)$(ed0(k,r) eq 0) = 0 ;
$ontext
* ----- Domestic trade margins

* ----- Equation (M-1)

ytmgeq1(k)$(xtmg0(k,"d") ne 0)..
   ytmg(k,"d") =e= tmg(k,"d")*pd(k)*xdd(k)  ;

* ----- Equation (M-2)

ytmgeq2(k)$(xtmg0(k,"m") ne 0)..
   ytmg(k,"m") =e= sum(r,tmg(k,"m")*pm(k,r)*xm(k,r)) ;

* ----- Equation (M-3)

ytmgeq3(k)$(xtmg0(k,"x") ne 0)..
   ytmg(k,"x") =e= sum(r,tmg(k,"x")*pe(k,r)*xe(k,r)) ;

ytmg.fx(k,mg)$(xtmg0(k,mg) eq 0) = 0 ;

* ----- Equation (M-4)

xtmgeq(kk,mg)$(xtmg0(kk,mg) ne 0)..
   ptmg(kk,mg)*xtmg(kk,mg) =e= ytmg(kk,mg) ;
xtmg.fx(kk,mg)$(xtmg0(kk,mg) eq 0) = 0 ;

* ----- Equation (M-5)

xamgeq(k,kk,mg)$(amg(k,kk,mg) ne 0)..
   xamg(k,kk,mg) =e= amg(k,kk,mg)*xtmg(kk,mg) ;
xamg.fx(k,kk,mg)$(amg(k,kk,mg) eq 0) = 0 ;

* ----- Equation (M-6)

ptmgeq(kk,mg)$(xtmg0(kk,mg) ne 0)..
   ptmg(kk,mg) =e= sum(k,amg(k,kk,mg)*pa(k)) ;
ptmg.fx(kk,mg)$(xtmg0(kk,mg) eq 0) = 1 ;

$offtext
* ----- Goods market equilibrium conditions

* ----- Equation (E-1)

pdeq(k)$(xdd0(k) ne 0)..
   xds(k) =e= xdd(k) ;

pd.fx(k)$(xdd0(k) eq 0) = 1 ;

* ----- Equation (E-2)

wpeeq(k,r)$(ed0(k,r) ne 0)..
   ed(k,r) =e= xe(k,r) ;

wpe.fx(k,r)$(ed0(k,r) eq 0) = 1 ;

* ----- Macro closure

* ----- Government accounts

* ----- Equation (C-1)

taryeq(g)..
   tary(g) =e= sum(k,sum(r,er(r)*tmadj(g)*tm(k,r,g)*wpm(k,r)*xm(k,r))) ;

* ----- Equation (C-2)

rtaryeq(g)..
   plev*rtary(g) =e= tary(g) ;

* ----- Equation (C-3)

gyeq(g)..
   gy(g) =e= sum(i,tp(i,g)*px(i)*xp(i))
       +  sum(k,pa(k)*(sum(j,tcp(k,j,g)*xap(k,j)) + sum(h,tcc(k,h,g)*xac(k,h)) + sum(f,tcf(k,f,g)*xaf(k,f))))
       +  tary(g) + sum(k,sum(r,te(k,r,g)*(1+tmg(k,"x"))*pe(k,r)*xe(k,r)))
       +  sum(lt,sum(i,tft(i,lt,g)*pt(i,lt)*td(i,lt)/(1+sum(gg,tft(i,lt,gg)))))
       +  sum(kt,sum(i,tfk(i,kt,g)*rent(i,kt)*kd(i,kt)/(1+sum(gg,tfk(i,kt,gg)))))
       +  sum(l,sum(i,tfl(i,l,g)*wage(i,l)*ld(i,l)/(1+sum(gg,tfl(i,l,gg)))))
       +  rysh(g)*ry
                 + sum(gg,gtrg(g,gg))
       + sum(i,tfr(i,g)*pr(i)*rd(i))
       +  sum(e,kappac(e,g)*cy(e)) + taxadjh(g)*sum(h,kappah(h,g)*yh(h)) + sum(r,er(r)*wtrg(r,g))
       + EmisCapRev
       + EneCapRev
       ;

* ----- Equation (C-4)

gexpeq(g)..
   gexp(g) =e= yf(g)
                                + sum(h,plev*gtrh(h,g))+plev*(sum(l,gtrl(l,g))+sum(kt,gtrk(kt,g)))+ sum(r,er(r)*gtrw(r,g)) + sum(gg,gtrg(gg,g))
                                + rsc*ry ;

* ----- Equation (C-5)

savgeq(g)..
   savg(g) =e= gy(g) - gexp(g) ;

* ----- Equation (C-6)

rsgeq(g)..
   plev*rsg(g) =e= savg(g) ;

* ----- Closure equations

* ----- Equation (C-7)

tieq..
   yf("capacct") =e= sum(e,savc(e)) + sum(h,savh(h)) + sum(g,savg(g)) + sum(r,er(r)*savf(r)) ;
*   yf("capacct") + yf("ginvs") =e= sum(e,savc(e)) + sum(h,savh(h)) + savg + sum(rer(r)*savf(r)) ;

* ----- Equation (C-8)

xf.fx(g) = xf0(g) ;

* ----- Equation (C-9)

*xf.fx("ginvs") = xf0("ginvs") ;

* ----- Equation (C-10)

*xf.fx("trdmg") = xf0("trdmg") ;

* ----- Equation (C-11)

*xf.fx("inventory") = xf0("inventory") ;

* ----- Equation (C-12)

pleveq..
   plev*sum(k,pa0(k)*xa0(k)) =e= sum(k,pa(k)*xa0(k)) ;

* ----- Factor markets

* ----- Integrated labor market

* ----- Equations (F-1)-(F-3) are dropped in the case of segmented labor markets
*       and replaced with equations (L-1) through (L-7). The elasticity omegam
*       drives the choice of labor market specification.

* ----- Equation (F-1)

lseq1(l)$(omegal(l,"Tot") ne inf and ls0(l,"Tot") ne 0 and omegam(l) eq inf)..
   ls(l,"Tot")*plev**omegal(l,"Tot") =e=
         als(l,"Tot")*ewage(l,"Tot")**omegal(l,"Tot") ;

lseq2(l)$(omegal(l,"Tot") eq inf and ls0(l,"Tot") ne 0 and omegam(l) eq inf)..
   ewage(l,"tot") =e= plev*ewage0(l,"tot") ;

ls.fx(l,"Tot")$(ls0(l,"Tot") eq 0 and omegam(l) eq inf) = 0 ;

* ----- Equation (F-2)

ewageq(l)$(ls0(l,"Tot") ne 0 and omegam(l) eq inf)..
   ls(l,"Tot") =e= sum(i,ld(i,l)) ;

ewage.fx(l,"Tot")$(ls0(l,"Tot") eq 0 and omegam(l) eq inf) = 1 ;

* ----- Equation (F-3)

wageq(i,l)$(ld0(i,l) ne 0 and omegam(l) eq inf)..
   wage(i,l) =e= phil(i,l)*ewage(l,"Tot") ;

wage.fx(i,l)$(ld0(i,l) eq 0) = 0 ;

* ----- Segmented labor market

* ----- Equation (L-1)

migreq(l)$(omegam(l) ne inf)..
   migr(l)*awage(l,"rur")**omegam(l)
      =e= chim(l)*awage(l,"urb")**omegam(l) ;

* ----- Equation (L-2)

awageq(l,gz2)$(omegam(l) ne inf and ls0(l,gz2) ne 0)..
   awage(l,gz2)*sum(i$(mapg(i,gz2)),ld(i,l))
      =e= sum(i$(mapg(i,gz2)),wage(i,l)*ld(i,l)/(1+sum(g,tfl(i,l,g)))) ;

*awage.fx(l,gz2)$(ls0(l,gz2) eq 0) = 1 ;

* ----- Equation (L-3)

ewageq2(l,gz2)$(ls0(l,gz2) ne 0 and omegam(l) ne inf)..
   ls(l,gz2) =e= sum(i$(mapg(i,gz2)),ld(i,l)) ;

ewage.fx(l,gz2)$(ls0(l,gz2) eq 0 and omegam(l) ne inf) = 1 ;

* ----- Equation (L-4)

wageq2(i,l,gz2)$(mapg(i,gz2) and ld0(i,l) ne 0 and omegam(l) ne inf)..
   wage(i,l) =e= phil(i,l)*ewage(l,gz2) ;

wage.fx(i,l)$(ld0(i,l) eq 0 and omegam(l) ne inf) = 1 ;

* ----- Equation (L-5)

rlseq(l)$(omegam(l) ne inf)..
   ls(l,"rur") =e= lslag(l,"rur")*(1+glab(l,"rur")) - migr(l) ;

* ----- Equation (L-6)

ulseq(l)$(omegam(l) ne inf)..
   ls(l,"urb") =e= lslag(l,"urb")*(1+glab(l,"urb")) + migr(l) ;

* ----- Equation (L-7)

tlseq(l)$(omegam(l) ne inf)..
   ls(l,"tot") =e= sum(gz2,ls(l,gz2)) ;

* ----- Capital markets

* ----- Equation (F-4)

tkseq1(kt)$(omegakt ne inf and tks0(kt) ne 0)..
   tks(kt)*pk**omegakt =e= akst(kt)*ksup*ptks(kt)**omegakt  ;

tkseq2(kt)$(omegakt eq inf and tks0(kt) ne 0)..
   ptks(kt) =e= pk ;

tks.fx(kt)$(tks0(kt) eq 0) = 0 ;

* ----- Equation (F-5)

pkeq1$(omegakt ne inf)..
   pk**(1+omegakt) =e= sum(kt,akst(kt)*ptks(kt)**(1+omegakt)) ;

pkeq2$(omegakt eq inf)..
   ksup =e= sum(kt,tks(kt)) ;

* ----- Equation (F-6)

kseq1(i,kt)$(omegak(kt) ne inf and ks0(i,kt) ne 0)..
   ks(i,kt)*((1+sum(g,tfk(i,kt,g)))*ptks(kt))**omegak(kt) =e= aks(i,kt)*tks(kt)*rent(i,kt)**omegak(kt) ;

kseq2(i,kt)$(omegak(kt) eq inf and ks0(i,kt) ne 0)..
   rent(i,kt) =e= ptks(kt) ;

ks.fx(i,kt)$(ks0(i,kt) eq 0) = 0 ;

* ----- Equation (F-7)

ptkseq1(kt)$(omegak(kt) ne inf and tks0(kt) ne 0)..
   ptks(kt)**(1+omegak(kt)) =e= sum(i,aks(i,kt)*(rent(i,kt)/(1+sum(g,tfk(i,kt,g))))**(1+omegak(kt))) ;

ptkseq2(kt)$(omegak(kt) eq inf and tks0(kt) ne 0)..
   tks(kt) =e= sum(i,ks(i,kt)) ;

ptks.fx(kt)$(tks0(kt) eq 0) = 1 ;

* ----- Equation (F-8)

renteq(i,kt)..
   ks(i,kt) =e= kd(i,kt) ;

* ----- Land markets

* ---- Top level CET

* ----- Equation (F-9)

ttseq1(lt)$(tts0(lt) ne 0 and omegatl ne inf)..
   tts(lt)*pland**omegatl =e= atts(lt)*land*ptts(lt)**omegatl ;

ttseq2(lt)$(tts0(lt) ne 0 and omegatl eq inf)..
   ptts(lt) =e= pland ;

tts.fx(lt)$(tts0(lt) eq 0) = 0 ;

* ----- Equation (F-10)

plandeq1$(land0 ne 0 and omegatl ne inf)..
   pland**(1+omegatl) =e= sum(lt,atts(lt)*ptts(lt)**(1+omegatl)) ;

plandeq2$(land0 ne 0 and omegatl eq inf)..
   land =e= sum(lt,tts(lt)) ;

pland.fx$(land0 eq 0) = pland0 ;

* ---- Second level CET

* ----- Equation (F-11)

tseq1(i,lt)$(ts0(i,lt) ne 0 and omegat(lt) ne inf)..
   ts(i,lt)*((1+sum(g,tft(i,lt,g)))*ptts(lt))**omegat(lt) =e= ats(i,lt)*tts(lt)*pt(i,lt)**omegat(lt) ;

tseq2(i,lt)$(ts0(i,lt) ne 0 and omegat(lt) eq inf)..
   pt(i,lt) =e= ptts(lt) ;

ts.fx(i,lt)$(ts0(i,lt) eq 0) = 0 ;

* ----- Equation (F-12)

pttseq1(lt)$(tts0(lt) ne 0 and omegat(lt) ne inf)..
   ptts(lt)**(1+omegat(lt)) =e= sum(i,ats(i,lt)*(pt(i,lt)/(1+sum(g,tft(i,lt,g))))**(1+omegat(lt))) ;

pttseq2(lt)$(tts0(lt) ne 0 and omegat(lt) eq inf)..
   tts(lt) =e= sum(i,ts(i,lt)) ;

ptts.fx(lt)$(tts0(lt) eq 0) = ptts0(lt) ;

* ----- Equation (F-13)

pteq(i,lt)$(ts0(i,lt) ne 0)..
   ts(i,lt) =e= td(i,lt) ;

pt.fx(i,lt)$(ts0(i,lt) eq 0) = 1 ;

* ----- Sector specific factor market

* ----- Equation (F-14)

rseq1(i)$(rs0(i) ne 0 and omegar(i) ne inf)..
*    rs(i)*((1+tfr(i)-sfr(i))*plev)**omegar(i) =e= ars(i)*pr(i)**omegar(i) ;
     rs(i)*plev**omegar(i) =e= ars(i)*pr(i)**omegar(i) ;

*rseq2(ncap)$(rs0(ncap) ne 0 and omegar(ncap) eq inf)..
*   pr(ncap) =e= plev*pr0(ncap) ;
rseq2(i)$(rs0(i) ne 0 and omegar(i) eq inf)..
   pr(i) =e= plev*pr0(i) ;
*  pr(ncap) =e= (1+tfr(ncap)-sfr(ncap))*plev*pr0(ncap) ;

rs.fx(i)$(rs0(i) eq 0) = 0 ;

* ----- Equation (F-15)

*preq(ncap)$(rs0(ncap) ne 0)..
*   rd(ncap) =e= rs(ncap) ;
preq(i)$(rs0(i) ne 0)..
        rd(i) =e= rs(i) ;
*  rd(i) =e= rs(i)*(1+tfr(i)) ;

pr.fx(i)$(rs0(i) eq 0) = pr0(i) ;

* ----- Macro identities

* ----- Equation (I-1)

gdpmpeq..
   gdpmp =e= sum(k,sum(h,(1+sum(g,tcc(k,h,g)))*pa(k)*xac(k,h)))
                          + sum(k,sum(f,(1+sum(g,tcf(k,f,g)))*pa(k)*xaf(k,f)))
           + sum(k,sum(r, er(r)*wpe(k,r)*xe(k,r)))
           - sum(k,sum(r, er(r)*wpm(k,r)*xm(k,r))) ;

* ----- Equation (I-2)

rgdpmpeq..
   rgdpmp =e= sum(k,sum(h,(1+sum(g,tcc0(k,h,g)))*pa0(k)*xac(k,h)))
                                + sum(k,sum(f,(1+sum(g,tcf0(k,f,g)))*pa0(k)*xaf(k,f)))
           +  sum(k,sum(r,er0(r)*wpe0(k,r)*xe(k,r)))
           -  sum(k,sum(r,er0(r)*wpm0(k,r)*xm(k,r))) ;

* ----- Equation (I-3)

pgdpmpeq..
   pgdpmp*rgdpmp =e= gdpmp ;

* ----- Equation (I-4)

gdpfceq..
   gdpfc =e= sum(i,sum(l,wage(i,l)*ld(i,l)))
          +  sum(kt,sum(i,rent(i,kt)*kd(i,kt)))
          +  sum(i,pr(i)*rd(i))
          +  sum(lt,sum(i,pt(i,lt)*td(i,lt))) ;

* ----- Equation (I-5)

rgdpfceq..
   rgdpfc =e= sum(i,sum(l,wage0(i,l)*lambdal(i,l)*ld(i,l)))
           +  sum(kt,sum(i,rent0(i,kt)*lambdak(i,kt)*kd(i,kt)))
           +  sum(i,pr0(i)*lambdar(i)*rd(i))
           +  sum(lt,sum(i,pt0(i,lt)*lambdat(i,lt)*td(i,lt))) ;

* ----- Equation (I-6)

pgdpfceq..
   pgdpfc*rgdpfc =e= gdpfc ;

* ----- Growth equations

* ----- Equation (G-1)

ggdpeq..
 rgdpfc =e= ggdp*rgdpfcLag ;

* ----- Equation (G-2)

lambdaleq(ip,l)..
   lambdal(ip,l)  =e= (1+gl+chil(ip,l))*lambdalLag(ip,l) ;

lambdakeq(ip,kt)..
   lambdak(ip,kt) =e= (1+gl+chil(ip,kt))*lambdakLag(ip,kt);

lambdateq(ip,lt)..
   lambdat(ip,lt) =e= (1+gl+chil(ip,lt))*lambdatLag(ip,lt) ;

* ----- Equation (G-3)

gegeq(k,j)$xap0(k,j)..
   xap(k,j) =e= geg(k,j)*xaplag(k,j) ;

* ----- Equation (G-4)

gceeq(k,h)..
   xac(k,h) =e= gce(k,h)*xaclag(k,h) ;
   
* ----- Energy Consumption accounting (for tracking energy use in million tonnes of coal equivalent.

EneConsumptionIeq(ces,j)$EneConsumptionI0(ces,j).. EneConsumptionI(ces,j) =e= Y2TCE(ces,j) * xap(ces,j) ;
EneConsumptionI.fx(ces,j)$(EneConsumptionI0(ces,j) eq 0) = 0 ;

EneConsumptionTeq$EneConsumptionT0.. EneConsumptionT =e= sum((ces,j), EneConsumptionI(ces,j)) ; 

* ----- Energy Consumption cap
EneCapeq.. EneCap =g= EneConsumptionT ;
ShadowPriceEne.fx$(EneConsumptionT0 eq 0) = 0 ;

EneTaxeq(cesCap,j).. EneTax(cesCap,j) =e= Y2TCE(cesCap,j) * ShadowPriceEne ;
EneTax.fx(cesNCap,j) = 0 ;
EneTax.fx(ces,j)$(EneConsumptionI0(ces,j) eq 0) = 0 ;

EneCapReveq.. EneCapRev =e= sum((ces,j), EneTax(ces,j) * xap(ces,j)) ;

* ----- emission functions

efieq(ef,i)$efi0(ef,i).. efi(ef,i) =e=   sum(ces,emit(ces,ef) *xap(ces,i)*(1-r_feed(ces,i,ef)));

     efi.fx(ef,i)$(efi0(ef,i) eq 0) = 0 ;


efheq(ef,h)$efh0(ef,h).. efh(ef,h) =e= sum(ces,  emit(ces,ef) *xac(ces,h));
     efh.fx(ef,h)$(efh0(ef,h) eq 0) = 0 ;

efteq(ef)$eft0(ef)..   eft(ef) =e= sum(i,efi(ef,i)) + sum(h,efh(ef,h)) ;

     eft.fx(ef)$(eft0(ef) eq 0) = 0 ;

*== emission cap
*   efcapeq(ef)$ifcap(ef)..   efcap(ef) =e= eft(ef) ;
*   efcapeq(ef)$ifcap(ef)..   efcap(ef) =e= eft(ef) - sum(i,offset(i));
*   efcapeq(ef)$ifcap(ef)..   efcap(ef) =e= sum(icap,efi(ef,icap)-offset(icap)) + sum(hcap,efh(ef,hcap));

*   efcieq("co2",icap)$ifcap("co2").. utef("co2") =e= pr(icap) ;

*   efckeq("co2",k)$ifcap("co2").. utef("co2") =e= the(k,"govt") ;

*   sfreq(icap,g)$ifrr.. sfr(icap,g) =e= rac("co2",icap)*sum(j,pr(j)*rd(j)/(1+sum(gg,tfr(j,gg))))/xp(icap);


* Step 1: Define emissions constraint. This equation defines the economy-wide shadow price on carbon (utef)
efcapeq(ef).. efcap(ef) =g= eft(ef) ;
utef.fx(ef)$(eft0(ef) eq 0) = 0 ;

* Step 2: Convert the economy wide effluent tax to a energy commodity-specific input tax
ctaxeq(ces,icap,ef).. ctax(ces,icap,ef) =e= utef(ef) * emit(ces,ef) ;
ctax.fx(ces,ncap,ef) = 0 ;
ctax.fx(ces,i,ef)$(efi0(ef,i) eq 0) = 0 ;

* Calculate revenues from emissions permits
EmisCapReveq.. EmisCapRev =e= sum((ces,i), sum(ef, ctax(ces,i,ef)) * xap(ces,i)) ;

*   pefxeq(ef,i).. pefx(ef,i) =e= mue(ef)*lambdae(ef,i)*pef(ef,i) ;

*   cefxeq(ef,i).. cefx(ef,i) =e= mue(ef)*lambdae(ef,i)*cef(ef,i) ;

        bop..
                sum(r,savf(r)) =e= sum(r,savf0(r)) ;

        era..
                        er("row") =e= 1 ;


model PANDA /
   ewageq, wageq, lseq2, preq, rseq2,
   peneeq, puskeq, pskleq, pktdeq, pttdeq, pkskeq, pkleq, pvaeq, pndeq, pxeq, ppeq,
   peq1, xpeq2, pmeq, pmteq, paeq, peeq, peteq1, xeq1, xdseq2, xeteq2, xeeq2,
   cpieq, fpieq, epieq, eexpeq,
   ndeq, vaeq, xapeq1, xapeq2, eneeq,  ttdeq, tdeq, kleq, rdeq, uskeq, kskeq, skleq, ktdeq, kdeq, ldeq1, ldeq2,
   lyeq, ryeq, kyeq, ktreeq, ktrheq, ktrweq, cyeq, savceq, ctrheq, ctrweq, tyeq,
   yheq, ydeq, htreq, htrheq, htrweq, xaceq, savheq,
   xafeq, pfeq, yfeq,
   xaeq, xddeq, xmteq, xmeq,
   peteq2, xpeq1, peq2, xeq2, xdseq1, xeteq1, xeeq1, edeq1, edeq2,
*   xtmgeq, ytmgeq1, ytmgeq2, ytmgeq3, ptmgeq, xamgeq,
   taryeq, rtaryeq, gyeq, gexpeq, savgeq, rsgeq, tieq, pleveq,
   pdeq, wpeeq,
   lseq1, awageq, ewageq2, wageq2, migreq,
   rlseq, ulseq, tlseq,
   kseq1, kseq2, ptkseq1, ptkseq2, renteq,
   pkeq1, pkeq2, tkseq1, tkseq2,
   plandeq1, plandeq2, ttseq1, ttseq2, pttseq1, pttseq2,
   tseq1, tseq2, pteq, rseq1,
   gdpmpeq, rgdpmpeq, pgdpmpeq, gdpfceq, rgdpfceq, pgdpfceq,
   ggdpeq,
    lambdaleq,lambdakeq,lambdateq
        , gegeq, gceeq,
	EneConsumptionIeq, EneConsumptionTeq,
	EneCapeq.ShadowPriceEne, 
	EneTaxeq.EneTax, EneCapReveq.EneCapRev
    efieq, efheq, efteq,
   efcapeq.utef, 
   ctaxeq.ctax, EmisCapReveq,
*    efcieq,
*   sfreq
*   pefxeq, cefxeq,
   tpeq
   / ;   

PANDA.holdfixed = 1 ;
