*========================= Read data from excel ==============================
$call gdxxrw data_input.xlsx par=data rng=A1
*=============================================================================

*======================= Defining a name for the data ========================
*Defining a name for the data
parameter
data(*,*)      input data
*=============================================================================

*========================= CALLING AND LOADING GDX FILE ======================
*Specify the GDX file to be used for reading
$gdxin data_input.gdx

*Read GAMS symbol from the GDX file. Note that the word "iodata" has been
*declared above before the the $load command
$load data

display data;

Set
         l  labor type       /L1*L28/

         i  all input sectors /1*139/

         region /urban,rural/

         alias (l,ll),(i,j);

set maplr(l,region) map from labor to region
/L1        .        Urban
L2        .        Urban
L3        .        Urban
L4        .        Urban
L5        .        Urban
L6        .        Urban
L7        .        Urban
L8        .        Rural
L9        .        Rural
L10        .        Rural
L11        .        Rural
L12        .        Rural
L13        .        Rural
L14        .        Rural
L15        .        Urban
L16        .        Urban
L17        .        Urban
L18        .        Urban
L19        .        Urban
L20        .        Urban
L21        .        Urban
L22        .        Rural
L23        .        Rural
L24        .        Rural
L25        .        Rural
L26        .        Rural
L27        .        Rural
L28        .        Rural
/;


Parameter        LAW0(l)     average wage from micro data in Yuan;
LAW0(l)=data("wage",l);

Parameter        LQ0(i,l)     intinal employment quantity from population census in 10 Thousand person;
LQ0(i,l) = data(i,l)/10000;

Parameter        LAV0(i)      labor compensation by sectors in IO 10 Thousand Yuan ;
LAV0(i)=data(i,"U");

*==============Step1: adjustment from 2010 to 2012==============================

table  em(*,*)  employment data from China annual stats in 10 thousand person
              total        urban      rural
a_2010        76105        34687      41418
b_2012        76704        37102      39602

;
parameter  af(*)  adjustment factors for employment from 2010 to 2012          ;
af('urban')=em('b_2012','urban')/em('a_2010','urban');
af('rural')=em('b_2012','rural')/em('a_2010','rural');


LQ0(i,l)$maplr(l,'urban') = LQ0(i,l)*af('urban');
LQ0(i,l)$maplr(l,'rural') = LQ0(i,l)*af('rural');


*==============Step2: Split the labor input in IO table to 28 detailed labor types======

*definition of matrix A

Parameter        a(i,l)    original matrix for labor compensation from avaliable data in 10 Thousand Yuan;
a(i,l) = LAW0(l)/(sum((j,ll),LAW0(ll)*LQ0(j,ll))/sum((j,ll),LQ0(j,ll)))*LAV0(i)/sum(ll,LQ0(i,ll))*LQ0(i,l);


Parameter        LSW0(i)    average wage by sector in Yuan    ;
LSW0(i)=LAV0(i)*10000/sum(l,LQ0(i,l));


*estimation of matrix X

Variable
obj

x(i,l)   split compensation for labor l in sector i  in  10 Thousand Yuan
LW(i,l)  wage level for labor l in sector i  in Yuan per person
;

*==      Stage 2a: Targeting levelized cost relationships

Equation
objeq
eqx(i,l)
eq1(i)
;

objeq..           obj =e=   sum((i,l)$a(i,l),x(i,l)*(log(x(i,l)/a(i,l))));

eqx(i,l)..        x(i,l) =e= LW(i,l)*LQ0(i,l);

* Market clearing constraint (row sum)
eq1(i)..          sum(l,x(i,l))=e= LAV0(i);

x.l(i,l) =  a(i,l);
x.lo(i,l) = 0.000000000000001*a(i,l);
x.fx(i,l)$(a(i,l) eq 0) =  0;

model ECOMOD1 / all /
solve ECOMOD1 using NLP minimizing obj;

display x.l;


*================= Unloading to Excel through GDX ============================
execute_unload 'data_output.gdx', x.l LW.l LQ0
execute 'gdxxrw.exe data_output.gdx o=Output.xlsx var=x.l rng=compensation! '
execute 'gdxxrw.exe data_output.gdx o=Output.xlsx var=LW.l rng=Wage! '
execute 'gdxxrw.exe data_output.gdx o=Output.xlsx par=LQ0 rng=employment! '
*=============================================================================
*=========================End of the GAMS Code ===============================

* cd /users/Sam/Dropbox/Research/MyStudies/ChinaCGE/EmploymentData/EmploymentDataProcess/Employment.gms
* /users/sam/GAMSMacOS/gams Employment pw=150 ps=9999