module MyBuffer (input a,b , output w);
	wire y1,y2,y3;
	supply1 Vdd;
	supply0 Gnd;
	pmos #(5,6,7) T1(y1,Vdd,a);
	pmos #(5,6,7) T2(w,y1,y2);
	
	//inverter:
	pmos #(5,6,7) T3(y2,Vdd,b);
	nmos #(3,4,5) T4(y2,Gnd,b);

	nmos #(3,4,5) T5(w,y3,b);
	nmos #(3,4,5) T6(y3,Gnd,a);

endmodule