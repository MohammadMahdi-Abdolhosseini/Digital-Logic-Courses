module MyInverter (input a, output w);
	supply1 Vdd;
	supply0 Gnd;
	pmos #(5,6,7) T1(w,Vdd,a);
	nmos #(3,4,5) T2(w,Gnd,a);
endmodule

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

module MyBMUX4_1 (input a,b,c,d,s1,s2 , output w);
	wire y1,y2,y3,y4;
	supply1 Vdd;
	supply0 Gnd;
	MyBuffer G1(a,y1,y2);
	MyBuffer G2(b,s2,y2);
	MyBuffer G3(c,y1,y3);
	MyBuffer G4(d,s2,y3);
	MyBuffer G5(y2,y4,w);
	MyBuffer G6(y3,s1,w);
	MyInverter G7(s2,y1);
	MyInverter G8(s1,y4);
endmodule