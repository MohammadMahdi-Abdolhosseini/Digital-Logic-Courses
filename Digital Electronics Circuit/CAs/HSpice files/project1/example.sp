First line of the netlist must be blank.

*------------------------------------------
*****load library*****

*.lib '45nm_PTM.txt' 45nm
.include 'PTM_180nm.txt'

*------------------------------------------
*****define param******
.param Lmin=180nm
+vdd=1.8V
+cx=1fF

.global vdd

*.temp 27

*------------------------------------------
****** SUB_CIRCUIT inverter*******
.SUBCKT INV1 IN OUT
M1 	1 		IN 		vdd 		vdd 	pmos 	w='2.0*Lmin' 	L=Lmin
M2 	1		IN 		0 			0  		nmos 	w='1.0*Lmin' 	L=Lmin
M3 	OUT 	1 		vdd 		vdd 	pmos 	w='2.0*Lmin' 	L=Lmin
M4 	OUT 	1 		0 			0  		nmos 	w='1.0*Lmin' 	L=Lmin	
.ENDS INV1
*-----------------------------

****** Main Code*******
*M(name)	ND	NG	NS	NB	Modelname	W				L
M1			out	in	Vdd	vdd	pmos		W='2.0*Lmin'	L='1.0*Lmin'		
M2			out	in	0	0	nmos		W='1.0*Lmin'	L='1.0*Lmin' 

***********************************************************************
*X1		in 	xx INV1     ** Instance of Invetter

cl		out	0	cx       ** Capacitance of output
*--------------------------------------------------------------------------
*********************Source Voltages**************
V1		vdd		 0 vdd
vin		in		0	pulse	0	vdd		0n	2p	2p		1n		2n ***tran
*vin in 0 0.9 ***dc

*------------------------------------------------------------------------
*************Type of Analysis********

.op
*.tran 0.1ns 4n	0.05n 		***.TRAN start stop (step)
.DC vin 0.1 1.8 0.1		***.DC Vi start stop step 

********************************************

.probe tran i(m1)
.print tran i(m1)i(m2) V(V1) V(out)

*-------------------------------------------------------------------
*******************Measurements*************************************
.MEAS 	tran	MAXpower max 	p(V1) FROM=0	TO=4n   
*.meas	tran	AVGpower avg	p(V1) from=0	to=4n

.MEASURE TRAN tpHL
+ trig V(in) val = 'vdd/2'  rise = 1
+ targ V(out) val = 'vdd/2'  fall = 1

.MEASURE TRAN tpLH
+ trig V(in) val = 'vdd/2'  fall = 1
+ targ V(out) val = 'vdd/2'  rise = 1

.measure tran	tpd		PARAM = ('(tpLH+tpHL)/2')

.MEASURE TRAN t_rise
+ trig V(out) val = '0.1*vdd'  rise = 1
+ targ V(out) val = '0.9*vdd'  rise = 1

.MEASURE TRAN t_fall
+ trig V(out) val = '0.9*vdd'  fall = 1
+ targ V(out) val = '0.1*vdd'  fall = 1

.end
