*------------------------------------------
*****load library*****

*.lib '45nm_PTM.txt' 45nm
*.include 'PTM_180nm.txt'
.Lib'mm018.l' tt

*------------------------------------------
*****define param******
.param Lmin=180nm
+vdd=1.8V
+Wmin = 220nm
+Wnmos = Wmin
+Wpmos = Wmin
+t=10p

.global vdd

*-----------------------------
***Components***
*M(name)	ND		NG		NS	NB	Modelname	W			L

***Co generator
Mn1 		Nc 		B 		0 	0 	nmos	 	w=Wnmos 	L=Lmin
Mn2 		Nd 		A 		0 	0 	nmos	 	w=Wnmos 	L=Lmin
Mn3 		Nc 		A 		Nd 	Nd 	nmos	 	w=Wnmos 	L=Lmin
Mn4 		O1 		C 		Nc 	Nc 	nmos	 	w=Wnmos 	L=Lmin
Mn5 		O1 		B 		Nd 	Nd 	nmos	 	w=Wnmos 	L=Lmin

Mp1 		Na 		B 		vdd vdd pmos	 	w=Wpmos 	L=Lmin
Mp2 		Nb 		A 		vdd vdd pmos	 	w=Wpmos 	L=Lmin
Mp3 		Nb 		A 		Na 	Na 	pmos	 	w=Wpmos 	L=Lmin
Mp4 		O1 		C 		Na 	Na 	pmos	 	w=Wpmos 	L=Lmin
Mp5 		O1 		B 		Nb 	Nb 	pmos	 	w=Wpmos 	L=Lmin

**not cate for Co
Mp6			Co		O1		vdd	vdd	pmos		W=Wmin		L= Lmin		
Mn6			Co		O1		0	0	nmos		W=Wmin		L= Lmin

*** Sum generator
Mn7 		Ng 		C 		0 	0 	nmos	 	w=Wnmos 	L=Lmin
Mn8 		Nh 		O1 		0 	0 	nmos	 	w=Wnmos 	L=Lmin
Mn9 		Ng 		A 		Nh 	Nh 	nmos	 	w=Wnmos 	L=Lmin
Mn10 		O2 		O1 		Ng 	Ng 	nmos	 	w=Wnmos 	L=Lmin
Mn11 		O2 		B 		Nh 	Nh 	nmos	 	w=Wnmos 	L=Lmin

Mp7 		Ne 		C 		vdd vdd pmos	 	w=Wpmos 	L=Lmin
Mp8 		Nf 		O1 		vdd vdd pmos	 	w=Wpmos 	L=Lmin
Mp9 		Ne 		A 		Nf 	Nf 	pmos	 	w=Wpmos 	L=Lmin
Mp10		O2 		O1 		Ne 	Ne 	pmos	 	w=Wpmos 	L=Lmin
Mp11 		O2 		B 		Nf 	Nf 	pmos	 	w=Wpmos 	L=Lmin

Mp12		Sum		O2		vdd	vdd	pmos		W=Wmin		L= Lmin		
Mn12		Sum		O2		0	0	nmos		W=Wmin		L= Lmin
*-----------------------------
***Source Voltages****
V1		vdd		 0 vdd

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


*------------------------------------------------------------------------
*************Type of Analysis********
.option post=2
.TRAN 10p 180n

.end