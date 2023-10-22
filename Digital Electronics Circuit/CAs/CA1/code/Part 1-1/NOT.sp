DIGITAL ELECTRONIC CIRCUITS - CA1: NOT GATE: Part 1:1
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
.param		Beta = 10

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> COMPONENTS		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*

Vvdd		Vdd	Gnd	dc	1v
VA		A	Gnd
Mpmos		Out	A	Vdd	Vdd	pmos		W = 'Wp*Beta'		L = 45n
Mnmos		Out	A	Gnd	Gnd	nmos		W = Wn			L = 45n

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> SIMULATIONS		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.option		post = 2
.dc		VA	0v	1v	0.001v

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
.end