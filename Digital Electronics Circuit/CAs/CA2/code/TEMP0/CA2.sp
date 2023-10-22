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
Vina A 0 PWL 0n 0, '15n-t' 0, 15n vdd, '35n-t' vdd, 35n 0, '50n-t' 0, 50n vdd, '52.5n-t' vdd, 52.5n 0, '55n-t' 0, 55n vdd, 
+ '57.5n-t' vdd, 57.5n 0, '60n-t' 0, 60n vdd, '62.5n-t' vdd, 62.5n 0, '65n-t' 0, 65n vdd, '67.5n-t' vdd, 67.5n 0,  
+ '80n-t' 0, 80n vdd, '100n-t' vdd, 100n 0, '102.5n-t' 0, 102.5n vdd, '105n-t' vdd, 105n 0, '107.5n-t' 0, 107.5n vdd, 
+ '110n-t' vdd, 110n 0, '112.5n-t' 0, 112.5n vdd, '115n-t' vdd, 115n 0, '117.5n-t' 0, 117.5n vdd, '125n-t' vdd, 125n 0,
+ '127.5n-t' 0, 127.5n vdd, '130n-t' vdd, 130n 0, '132.5n-t' 0, 132.5n vdd, '135n-t' vdd, 135n 0, '137.5n-t' 0, 137.5n vdd, 
+ '140n-t' vdd, 140n 0, '142.5n-t' 0, 142.5n vdd, '145n-t' vdd, 145n 0, '147.5n-t' 0, 147.5n vdd, '150n-t' vdd, 150n 0,
+ '152.5n-t' 0, 152.5n vdd, '155n-t' vdd, 155n 0, 162.5n 0


Vinb B 0 PWL 0n 0, '7.5n-t' 0, 7.5n vdd, '12.5n-t' vdd, 12.5n 0, '20n-t' 0, 20n vdd, '32.5n-t' vdd, 32.5n 0, '37.5n-t' 0, 37.5n vdd, 
+ '47.5n-t' vdd, 47.5n 0, '50n-t' 0, 50n vdd, '52.5n-t' vdd, 52.5n 0, '55n-t' 0, 55n vdd, '57.5n-t' vdd, 57.5n 0, 
+ '62.5n-t' 0, 62.5n vdd, '65n-t' vdd, 65n 0, '72.5n-t' 0, 72.5n vdd, '75n-t' vdd, 75n 0, '77.5n-t' 0, 77.5n vdd, 
+ '87.5n-t' vdd, 87.5n 0, '97.5n-t' 0, 97.5n vdd, '112.5n-t' vdd, 112.5n 0, '120n-t' 0, 120n vdd, '122.5n-t' vdd, 122.5n 0, 
+ '125n-t' 0, 125n vdd, '127.5n-t' vdd, 127.5n 0, '135n-t' 0, 135n vdd, '137.5n-t' vdd, 137.5n 0, '140n-t' 0, 140n vdd, 
+ '142.5n-t' vdd, 142.5n 0, '147.5n-t' 0, 147.5n vdd, '150n-t' vdd, 150n 0, '152.5n-t' 0, 152.5n vdd, 162.5n vdd


Vinc C 0 PWL 0n 0, '2.5n-t' 0, 2.5n vdd, '5n-t' vdd, 5n 0, '25n-t' 0, 25n vdd, '30n-t' vdd, 30n 0, '37.5n-t' 0, 37.5n vdd, 
+ '42.5n-t' vdd, 42.5n 0, '45n-t' 0, 45n vdd, '47.5n-t' vdd, 47.5n 0, '55n-t' 0, 55n vdd, '62.5n-t' vdd, 62.5n 0, 
+ '67.5n-t' 0, 67.5n vdd, '72.5n-t' vdd, 72.5n 0, '75n-t' 0, 75n vdd, '87.5n-t' vdd, 87.5n 0, '90n-t' 0, 90n vdd, 
+ '95n-t' vdd, 95n 0, '97.5n-t' 0, 97.5n vdd, '102.5n-t' vdd, 102.5n 0, '107.5n-t' 0, 107.5n vdd, '110n-t' vdd, 110n 0, 
+ '112.5n-t' 0, 112.5n vdd, '115n-t' vdd, 115n 0, '117.5n-t' 0, 117.5n vdd, '120n-t' vdd, 120n 0, '122.5n-t' 0, 122.5n vdd, 
+ '127.5n-t' vdd, 127.5n 0, '130n-t' 0, 130n vdd, '132.5n-t' vdd, 132.5n 0, '140n-t' 0, 140n vdd, '147.5n-t' vdd, 147.5n 0, 
+ '150n-t' 0, 150n vdd, '155n-t' vdd, 155n 0, 157.5n 0


*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> SIMULATIONS		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.option	post=2
.TRAN	10p	170n
.temp	0

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> MEASUREMENTS	*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
******************************* RISE Time (SUM) ********************************
********************************************************************************
.MEASURE	TRAN		t_rise_sum_1
+trig		V(SUM)		td = 2n		val = '0.1*vdd'		rise = 1
+targ		V(SUM)		td = 2n		val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_sum_2
+trig		V(SUM)		td = 7n		val = '0.1*vdd'		rise = 1
+targ		V(SUM)		td = 7n		val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_sum_3
+trig		V(SUM)		td = 13n	val = '0.1*vdd'		rise = 1
+targ		V(SUM)		td = 13n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_sum_4
+trig		V(SUM)		td = 24n	val = '0.1*vdd'		rise = 1
+targ		V(SUM)		td = 24n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_sum_5
+trig		V(SUM)		td = 32n	val = '0.1*vdd'		rise = 1
+targ		V(SUM)		td = 32n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_sum_6
+trig		V(SUM)		td = 42n	val = '0.1*vdd'		rise = 1
+targ		V(SUM)		td = 42n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_sum_7
+trig		V(SUM)		td = 54n	val = '0.1*vdd'		rise = 1
+targ		V(SUM)		td = 54n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_sum_8
+trig		V(SUM)		td = 57n	val = '0.1*vdd'		rise = 1
+targ		V(SUM)		td = 57n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_sum_9
+trig		V(SUM)		td = 62n	val = '0.1*vdd'		rise = 1
+targ		V(SUM)		td = 62n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_sum_10
+trig		V(SUM)		td = 78n	val = '0.1*vdd'		rise = 1
+targ		V(SUM)		td = 78n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_sum_11
+trig		V(SUM)		td = 94n	val = '0.1*vdd'		rise = 1
+targ		V(SUM)		td = 94n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_sum_12
+trig		V(SUM)		td = 104n	val = '0.1*vdd'		rise = 1
+targ		V(SUM)		td = 104n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_sum_13
+trig		V(SUM)		td = 126n	val = '0.1*vdd'		rise = 1
+targ		V(SUM)		td = 126n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_sum_14
+trig		V(SUM)		td = 144n	val = '0.1*vdd'		rise = 1
+targ		V(SUM)		td = 144n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_sum_15
+trig		V(SUM)		td = 149n	val = '0.1*vdd'		rise = 1
+targ		V(SUM)		td = 149n	val = '0.9*vdd'		rise = 1

******************************* FALL Time (SUM) ********************************
********************************************************************************
.MEASURE	TRAN		t_fall_sum_1
+trig		V(SUM)		td = 4n		val = '0.9*vdd'		fall = 1
+targ		V(SUM)		td = 4n		val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_sum_2
+trig		V(SUM)		td = 12n	val = '0.9*vdd'		fall = 1
+targ		V(SUM)		td = 12n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_sum_3
+trig		V(SUM)		td = 19n	val = '0.9*vdd'		fall = 1
+targ		V(SUM)		td = 19n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_sum_4
+trig		V(SUM)		td = 29n	val = '0.9*vdd'		fall = 1
+targ		V(SUM)		td = 29n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_sum_5
+trig		V(SUM)		td = 34n	val = '0.9*vdd'		fall = 1
+targ		V(SUM)		td = 34n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_sum_6
+trig		V(SUM)		td = 44n	val = '0.9*vdd'		fall = 1
+targ		V(SUM)		td = 44n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_sum_7
+trig		V(SUM)		td = 57n	val = '0.9*vdd'		fall = 1
+targ		V(SUM)		td = 57n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_sum_8
+trig		V(SUM)		td = 59n	val = '0.9*vdd'		fall = 1
+targ		V(SUM)		td = 59n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_sum_9
+trig		V(SUM)		td = 75n	val = '0.9*vdd'		fall = 1
+targ		V(SUM)		td = 75n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_sum_10
+trig		V(SUM)		td = 89n	val = '0.9*vdd'		fall = 1
+targ		V(SUM)		td = 89n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_sum_11
+trig		V(SUM)		td = 99n	val = '0.9*vdd'		fall = 1
+targ		V(SUM)		td = 99n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_sum_12
+trig		V(SUM)		td = 112n	val = '0.9*vdd'		fall = 1
+targ		V(SUM)		td = 112n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_sum_13
+trig		V(SUM)		td = 139n	val = '0.9*vdd'		fall = 1
+targ		V(SUM)		td = 139n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_sum_14
+trig		V(SUM)		td = 146n	val = '0.9*vdd'		fall = 1
+targ		V(SUM)		td = 146n	val = '0.1*vdd'		fall = 1

*====================================================================================================
******************************* RISE Time (Cout) *******************************
********************************************************************************
.MEASURE	TRAN		t_rise_cout_1
+trig		V(Cout)		td = 18n	val = '0.1*vdd'		rise = 1
+targ		V(Cout)		td = 18n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_cout_2
+trig		V(Cout)		td = 35n	val = '0.1*vdd'		rise = 1
+targ		V(Cout)		td = 35n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_cout_3
+trig		V(Cout)		td = 44n	val = '0.1*vdd'		rise = 1
+targ		V(Cout)		td = 44n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_cout_4
+trig		V(Cout)		td = 49n	val = '0.1*vdd'		rise = 1
+targ		V(Cout)		td = 49n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_cout_5
+trig		V(Cout)		td = 54n	val = '0.1*vdd'		rise = 1
+targ		V(Cout)		td = 54n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_cout_6
+trig		V(Cout)		td = 59n	val = '0.1*vdd'		rise = 1
+targ		V(Cout)		td = 59n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_cout_7
+trig		V(Cout)		td = 75n	val = '0.1*vdd'		rise = 1
+targ		V(Cout)		td = 75n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_cout_8
+trig		V(Cout)		td = 89n	val = '0.1*vdd'		rise = 1
+targ		V(Cout)		td = 89n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_cout_9
+trig		V(Cout)		td = 96n	val = '0.1*vdd'		rise = 1
+targ		V(Cout)		td = 96n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_cout_10
+trig		V(Cout)		td = 106n	val = '0.1*vdd'		rise = 1
+targ		V(Cout)		td = 106n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_cout_11
+trig		V(Cout)		td = 111n	val = '0.1*vdd'		rise = 1
+targ		V(Cout)		td = 111n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_cout_12
+trig		V(Cout)		td = 116n	val = '0.1*vdd'		rise = 1
+targ		V(Cout)		td = 116n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_cout_13
+trig		V(Cout)		td = 139n	val = '0.1*vdd'		rise = 1
+targ		V(Cout)		td = 139n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_cout_14
+trig		V(Cout)		td = 146n	val = '0.1*vdd'		rise = 1
+targ		V(Cout)		td = 146n	val = '0.9*vdd'		rise = 1
.MEASURE	TRAN		t_rise_cout_15
+trig		V(Cout)		td = 151n	val = '0.1*vdd'		rise = 1
+targ		V(Cout)		td = 151n	val = '0.9*vdd'		rise = 1

******************************* FALL Time (Cout) *******************************
********************************************************************************
.MEASURE	TRAN		t_fall_cout_1
+trig		V(Cout)		td = 31n	val = '0.9*vdd'		fall = 1
+targ		V(Cout)		td = 31n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_cout_2
+trig		V(Cout)		td = 41n	val = '0.9*vdd'		fall = 1
+targ		V(Cout)		td = 41n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_cout_3
+trig		V(Cout)		td = 47n	val = '0.9*vdd'		fall = 1
+targ		V(Cout)		td = 47n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_cout_4
+trig		V(Cout)		td = 51n	val = '0.9*vdd'		fall = 1
+targ		V(Cout)		td = 51n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_cout_5
+trig		V(Cout)		td = 57n	val = '0.9*vdd'		fall = 1
+targ		V(Cout)		td = 57n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_cout_6
+trig		V(Cout)		td = 61n	val = '0.9*vdd'		fall = 1
+targ		V(Cout)		td = 61n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_cout_7
+trig		V(Cout)		td = 86n	val = '0.9*vdd'		fall = 1
+targ		V(Cout)		td = 86n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_cout_8
+trig		V(Cout)		td = 92n	val = '0.9*vdd'		fall = 1
+targ		V(Cout)		td = 92n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_cout_9
+trig		V(Cout)		td = 105n	val = '0.9*vdd'		fall = 1
+targ		V(Cout)		td = 105n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_cout_10
+trig		V(Cout)		td = 109n	val = '0.9*vdd'		fall = 1
+targ		V(Cout)		td = 109n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_cout_11
+trig		V(Cout)		td = 114n	val = '0.9*vdd'		fall = 1
+targ		V(Cout)		td = 114n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_cout_12
+trig		V(Cout)		td = 125n	val = '0.9*vdd'		fall = 1
+targ		V(Cout)		td = 125n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_cout_13
+trig		V(Cout)		td = 142n	val = '0.9*vdd'		fall = 1
+targ		V(Cout)		td = 142n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_cout_14
+trig		V(Cout)		td = 149n	val = '0.9*vdd'		fall = 1
+targ		V(Cout)		td = 149n	val = '0.1*vdd'		fall = 1
.MEASURE	TRAN		t_fall_cout_15
+trig		V(Cout)		td = 154n	val = '0.9*vdd'		fall = 1
+targ		V(Cout)		td = 154n	val = '0.1*vdd'		fall = 1

*====================================================================================================
******************************* DYNAMIC POWER **********************************
********************************************************************************
.measure	tran	pow	AVG	power	from = 1ns	to = 170ns

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
.end