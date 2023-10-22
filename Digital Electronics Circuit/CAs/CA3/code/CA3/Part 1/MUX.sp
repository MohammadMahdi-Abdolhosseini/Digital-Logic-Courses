DIGITAL ELECTRONIC CIRCUITS - CA3 - PART1
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
*   ==> Static CMOS 2:1 MUX	*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.SUBCKT		Static_CMOS_MUX		A	B	S	out
vdd	vdd	gnd	vdd
*M	ND	NG	NS	NB	Model	W		L
Mp1	n1	A	vdd	vdd	pmos	w = Wpmos	l = Lmin
Mp2	n1	SBar	vdd	vdd	pmos	w = Wpmos	l = Lmin
Mp3	n2	B	n1	vdd	pmos	w = Wpmos	l = Lmin
Mp4	n2	S	n1	vdd	pmos	w = Wpmos	l = Lmin
Mn1	n2	A	n3	gnd	nmos	w = Wnmos	l = Lmin
Mn2	n2	B	n4	gnd	nmos	w = Wnmos	l = Lmin
Mn3	n3	SBar	gnd	gnd	nmos	w = Wnmos	l = Lmin
Mn4	n4	S	gnd	gnd	nmos	w = Wnmos	l = Lmin
X1	S	SBar	INVERTER
X2	n2	out	INVERTER
.ENDS		Static_CMOS_MUX

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*   ==> Pseudo NMOS 2:1 MUX	*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.SUBCKT		Pseudo_NMOS_MUX		A	B	S	out
vdd	vdd	gnd	vdd
*M	ND	NG	NS	NB	Model	W		L
Mp1	n1	gnd	vdd	vdd	pmos	w = Wpmos	l = Lmin
Mn1	n1	A	n2	gnd	nmos	w = Wpmos	l = Lmin
Mn2	n1	B	n3	gnd	nmos	w = Wpmos	l = Lmin
Mn3	n2	SBar	gnd	gnd	nmos	w = Wpmos	l = Lmin
Mn4	n3	S	gnd	gnd	nmos	w = Wpmos	l = Lmin
X1	S	SBar	INVERTER
X2	n1	out	INVERTER
.ENDS		Pseudo_NMOS_MUX

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> COMPONENTS		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
X1	A	B	S	out_Static_CMOS_MUX	Static_CMOS_MUX
X2	A	B	S	out_Pseudo_NMOS_MUX	Pseudo_NMOS_MUX


*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> INPUTS		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
VA	A	gnd	Pulse	gnd	vdd	0	0	0	200ns	400ns
VB	B	gnd	Pulse	gnd	vdd	0	0	0	400ns	800ns
VS	S	gnd	Pulse	gnd	vdd	0	0	0	100ns	200ns

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
.tran   10p   2000n

*.tran	10p	160ns	SWEEP	DATA = datalist

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> MEASUREMENTS	*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.measure	AVG_POWER	avg	power	from = 0n	to = 2000n

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
.end