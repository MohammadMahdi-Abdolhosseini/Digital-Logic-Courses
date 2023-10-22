NotCircuit
.lib  '45nm_PTM.txt' 45nm
***Voltages***
V1		vdd1		 0 drain
V2		vdd2		 0 drain
V3		vdd3		 0 drain
V4		vdd4		 0 drain
Vin1		A		0	0.4
Vin2		B		0	0.6
Vin3		C		0	0.8
Vin4		D		0	1

***Components***
*M(name)	ND	NG	NS	NB	Modelname	W		

M1			Vdd1	A	0	0	nmos		W=1u		L= 100n
M2			Vdd2	B	0	0	nmos		W=1u		L= 100n
M3			Vdd3	C	0	0	nmos		W=1u		L= 100n
M4			Vdd4	D	0	0	nmos		W=1u		L= 100n

***Analysis***
.option		post=2	nomod

.param		drain = 1
.DC		drain 	0	1	0.01


.end
	