DIGITAL ELECTRONIC CIRCUITS - CA4 - PART1
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	Mohammad Mahdi Abdolhosseini		*
*	810 198 434				*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> LIBRARY		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.inc	'0.5micron.lib'

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> PARAMETERS		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.param	Vdd = 1
+	Vss = -1

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> COMPONENTS		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*

Vdd	Vdd	gnd	Vdd
Vss	Vss	gnd	Vss

Cpar1 Out 0 C=213.165f
Cpar2 2 0 C=100.89f
Cpar3 Vss 0 C=219.123f
Cpar4 Vdd 0 C=265.5f

M1 Out A Vdd Vdd PMOS L=5u W=9u AD=81p PD=36u AS=81p PS=36u 
* M1 DRAIN GATE SOURCE BULK (-96.5 53.5 -91.5 62.5) 

M2 Out B Vdd Vdd PMOS L=5u W=9u AD=81p PD=36u AS=81p PS=36u 
* M2 DRAIN GATE SOURCE BULK (-40 53.5 -35 62.5) 

M3 2 A Out Vss NMOS L=5u W=9u AD=81p PD=36u AS=81p PS=36u 
* M3 DRAIN GATE SOURCE BULK (-111.5 19.5 -106.5 28.5) 

M4 2 B Vss Vss NMOS L=5u W=9u AD=81p PD=36u AS=81p PS=36u 
* M4 DRAIN GATE SOURCE BULK (-40 19.5 -35 28.5) 

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> INPUTS		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
VA	A	gnd	Pulse	Vss	Vdd	0	0	0	200ns	400ns
VB	B	gnd	Pulse	Vss	Vdd	0	0	0	400ns	800ns

*//\/\/\/\//\/\/\/\/\//\/\/\\/\/\///\\/\/\//\\//\/\/\/\//\/\/\/\\\//\/\//\/\\/\/\\/\\/\\/\\/\/\\/\\/\
*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*
*	==> SIMULATIONS		*
*uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu*
.option	post=2
.tran   10p   2000n
.END
