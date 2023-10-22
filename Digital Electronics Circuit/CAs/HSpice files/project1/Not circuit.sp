NotCircuit
.lib  '45nm_PTM.txt' 45nm
***Voltages***
V1		vdd		 0 1
Vin		A		0	pulse	0	1		0n	10p	10p		20n		100n
*Vin		A		 0 input
***Components***
*M(name)	ND	NG	NS	NB	Modelname	W		
M1			out	A	Vdd	vdd	pmos		W=180n	L= 45n		
M2			out	A	0	0	nmos		W=90n		L= 45n
C1			out	0	20fF
***Analysis***
.option		post=2	nomod
*.param		input=1
*.DC		input 	0	1.8	0.01
.tran		1ps		300ns

.MEASURE TRAN t_rise
+ trig V(out) val = 0.1  rise = 1
+ targ V(out) val = 0.9  rise = 1

.MEASURE TRAN t_fall
+ trig V(out) val = 0.9  fall = 1
+ targ V(out) val = 0.1  fall = 1
	
.end
	