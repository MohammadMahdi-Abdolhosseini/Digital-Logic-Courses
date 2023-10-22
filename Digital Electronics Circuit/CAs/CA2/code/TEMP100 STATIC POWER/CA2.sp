DIGITAL ELECTRONIC CIRCUITS - CA2
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	Mohammad Mahdi Abdolhosseini		*
*	810 198 434				*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> LIBRARY		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.lib	'mm018.l' tt

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> PARAMETERS		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.param	Wmin = 220n
+	Lmin = 180n
+	Wnmos = '2*Wmin'
+	Wpmos = '6*Wmin'
+	vdd = 1.8
+	gnd = 0
+	t = 10p

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> INVERTER		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.SUBCKT		INVERTER	in	out
vdd	vdd	gnd	vdd
Mp	out	in	vdd	vdd	pmos	w = Wnmos	l = Lmin
Mn	out	in	gnd	gnd	nmos	w = Wmin	l = Lmin
.ENDS		INVERTER

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> COMPONENTS		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
vdd	vdd	gnd	dc	1.8v
Mp1	n1	B	vdd	vdd	pmos	w = Wpmos	l = Lmin
Mp2	n2	A	vdd	vdd	pmos	w = Wpmos	l = Lmin
Mp3	n1	A	n2	vdd	pmos	w = Wpmos	l = Lmin
Mp4	n3	C	n1	vdd	pmos	w = Wpmos	l = Lmin
Mp5	n3	B	n2	vdd	pmos	w = Wpmos	l = Lmin
Mn6	n3	C	n4	gnd	nmos	w = Wnmos	l = Lmin
Mn7	n3	B	n5	gnd	nmos	w = Wnmos	l = Lmin
Mn8	n4	A	n5	gnd	nmos	w = Wnmos	l = Lmin
Mn9	n4	B	gnd	gnd	nmos	w = Wnmos	l = Lmin
Mn10	n5	A	gnd	gnd	nmos	w = Wnmos	l = Lmin
Mp11	n6	C	vdd	vdd	pmos	w = Wpmos	l = Lmin
Mp12	n7	n3	vdd	vdd	pmos	w = Wpmos	l = Lmin
Mp13	n6	A	n7	vdd	pmos	w = Wpmos	l = Lmin
Mp14	n8	n3	n6	vdd	pmos	w = Wpmos	l = Lmin
Mp15	n8	B	n7	vdd	pmos	w = Wpmos	l = Lmin
Mn16	n8	n3	n9	gnd	nmos	w = Wnmos	l = Lmin
Mn17	n8	B	n10	gnd	nmos	w = Wnmos	l = Lmin
Mn18	n9	A	n10	gnd	nmos	w = Wnmos	l = Lmin
Mn19	n9	C	gnd	gnd	nmos	w = Wnmos	l = Lmin
Mn20	n10	n3	gnd	gnd	nmos	w = Wnmos	l = Lmin

X1	n3	Cout	INVERTER
X2	n8	SUM	INVERTER


*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> INPUTS		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*

Vina	A	0	PWL	0n	0	, '10n-t'	0,	10n	vdd

Vinb	B	0	PWL	0n	0	, '5n-t'	0,	5n	vdd,
+	'10n-t'	vdd,	10n	0,	'15n-t'	0,	15n	vdd

Vinc	C	0	PWL	0n	0,	'2.5n-t'	0,	2.5n	vdd,
+	'5n-t'	vdd,	5n	0,	'7.5n-t'	0,	7.5n	vdd,
+	'10n-t'	vdd,	10n	0,	'12.5n-t'	0,	12.5n	vdd,
+	'15n-t'	vdd,	15n	0,	'17.5n-t'	0,	17.5n	vdd

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> SIMULATIONS		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.option	post=2
.TRAN	1p	20n
.temp	100

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> MEASUREMENTS	*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*

*====================================================================================================
******************************* STATIC POWER ***********************************
********************************************************************************
.measure	tran	static_power_1	AVG	power	from = 0ns	to = 2.5ns
.measure	tran	static_power_2	AVG	power	from = 2.5ns	to = 5ns
.measure	tran	static_power_3	AVG	power	from = 5ns	to = 7.5ns
.measure	tran	static_power_4	AVG	power	from = 7.5ns	to = 10ns
.measure	tran	static_power_5	AVG	power	from = 10ns	to = 12.5ns
.measure	tran	static_power_6	AVG	power	from = 12.5ns	to = 15ns
.measure	tran	static_power_7	AVG	power	from = 15ns	to = 17.5ns
.measure	tran	static_power_8	AVG	power	from = 17.5ns	to = 20ns

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
.end