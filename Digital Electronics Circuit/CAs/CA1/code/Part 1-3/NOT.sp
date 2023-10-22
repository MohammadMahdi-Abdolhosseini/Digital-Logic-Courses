DIGITAL ELECTRONIC CIRCUITS - CA1: NOT GATE: Part 1:3
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	Mohammad Mahdi Abdolhosseini		*
*	810 198 434				*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> LIBRARY		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.lib		'45nm_PTM.txt'	45nm

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> PARAMETERS		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.param		Wp = 90n
.param		Wn = 90n
.param		Beta = 2
.param		Cout = 20fF

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> COMPONENTS		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*

Vvdd		Vdd	Gnd	dc	1v
VA		A	Gnd	pulse(0 1 0ps 10ps 10ps 20ns 100ns)
Mpmos		Out	A	Vdd	Vdd	pmos		W = 'Wp*Beta'		L = 45n
Mnmos		Out	A	Gnd	Gnd	nmos		W = Wn			L = 45n
Cout		Out	Gnd	Cout

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> SIMULATIONS		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.option		post = 2
.tran		0.1fs		200ns

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> MEASUREMENTS	*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.MEASURE	TRAN		t_rise
+trig		V(Out)		val = '0.1'		rise = 1
+targ		V(Out)		val = '0.9'		rise = 1

.MEASURE	TRAN		t_fall
+trig		V(Out)		val = '0.9'		fall = 1
+targ		V(Out)		val = '0.1'		fall = 1

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
.end