DIGITAL ELECTRONIC CIRCUITS - CA3 - PART2
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	Mohammad Mahdi Abdolhosseini		*
*	810 198 434				*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> LIBRARY		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.lib	'32nm_bulk.pm' TT

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> PARAMETERS		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.param	Wmin = 8n
+	Lmin = 32n
+	Wnmos = '4*Wmin'
+	Wpmos = '8*Wmin'
+	vdd = 1
+	gnd = 0
+	t = 10p

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> INVERTER		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.SUBCKT		INVERTER	in	out
vdd	vdd	gnd	vdd
Mp	out	in	vdd	vdd	pmos	w = Wpmos	l = Lmin
Mn	out	in	gnd	gnd	nmos	w = Wnmos	l = Lmin
.ENDS		INVERTER

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*    ==> Dynamic CMOS XOR	*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.SUBCKT		Dynamic_CMOS_XOR	A	B	CLK	out
vdd	vdd	gnd	vdd
*M	ND	NG	NS	NB	Model	W		L
Mp1	out	CLK	vdd	vdd	pmos	w = Wpmos	l = Lmin
Mn1	out	A	n1	gnd	nmos	w = '3*Wnmos'	l = Lmin
Mn2	out	ABar	n2	gnd	nmos	w = '3*Wnmos'	l = Lmin
Mn3	n1	B	n3	gnd	nmos	w = '3*Wnmos'	l = Lmin
Mn4	n2	BBar	n3	gnd	nmos	w = '3*Wnmos'	l = Lmin
Mn5	n3	CLK	gnd	gnd	nmos	w = '3*Wnmos'	l = Lmin
X1	A	ABar	INVERTER
X2	B	BBar	INVERTER
.ENDS		Dynamic_CMOS_XOR

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*   ==> Transmission Gate XOR	*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.SUBCKT		Transmission_Gate_XOR		A	B	out
vdd	vdd	gnd	vdd
*M	ND	NG	NS	NB	Model	W		L
Mp1	out	A	B	vdd	pmos	w = Wpmos	l = Lmin
Mn1	out	A	BBar	gnd	nmos	w = Wnmos	l = Lmin
Mn2	A	BBar	out	gnd	nmos	w = Wnmos	l = Lmin
Mp2	out	B	A	vdd	pmos	w = Wpmos	l = Lmin
X1	B	BBar	INVERTER
.ENDS		Transmission_Gate_XOR

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> COMPONENTS		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
X1	A	B	CLK	out_Dynamic_CMOS_XOR		Dynamic_CMOS_XOR
*X2	A	B		out_Transmission_Gate_XOR	Transmission_Gate_XOR

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> INPUTS		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
VA	A	gnd	Pulse	gnd	vdd	0	0	0	20ns	40ns
VB	B	gnd	Pulse	gnd	vdd	0	0	0	40ns	80ns 
VCLK	CLK	gnd	Pulse	gnd	vdd	0	0	0	10ns	20ns

*.DATA	datalist	A	B	S
*			+0	0	0
*			+1	0	0
*			+0	1	0
*			+1	1	0
*			+0	0	1
*			+1	0	1
*			+0	1	1
*			+1	1	1
*.END DATA

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> SIMULATIONS		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.option	post=2
.tran   10p   200n

*.tran	10p	160ns	SWEEP	DATA = datalist

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> MEASUREMENTS	*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.measure	AVG_POWER_Dynamic_CMOS_XOR	avg	power	from = 0n	to = 200n

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
.end