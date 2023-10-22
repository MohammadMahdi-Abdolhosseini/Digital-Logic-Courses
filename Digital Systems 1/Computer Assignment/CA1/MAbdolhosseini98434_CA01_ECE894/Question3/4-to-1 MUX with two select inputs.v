module MyNAND_2 (input a,b , output w);
	wire y;
	supply1 Vdd;
	supply0 Gnd;
	pmos #(5,6,7) T1(w,Vdd,a);
	pmos #(5,6,7) T2(w,Vdd,b);
	nmos #(3,4,5) T3(y,Gnd,b);
	nmos #(3,4,5) T4(w,y,a);
endmodule

module MyNAND_3 (input a,b,c , output w);
	wire y1,y2;
	supply1 Vdd;
	supply0 Gnd;
	pmos #(5,6,7) T1(w,Vdd,a);
	pmos #(5,6,7) T2(w,Vdd,b);
	pmos #(5,6,7) T3(w,Vdd,c);
	nmos #(3,4,5) T4(w,y1,a);
	nmos #(3,4,5) T5(y1,y2,b);
	nmos #(3,4,5) T6(y2,Gnd,c);
endmodule

module MyNAND_4 (input a,b,c,d , output w);
	wire y1,y2,y3;
	supply1 Vdd;
	supply0 Gnd;
	pmos #(5,6,7) T1(w,Vdd,a);
	pmos #(5,6,7) T2(w,Vdd,b);
	pmos #(5,6,7) T3(w,Vdd,c);
	pmos #(5,6,7) T4(w,Vdd,d);
	nmos #(3,4,5) T5(w,y1,a);
	nmos #(3,4,5) T6(y1,y2,b);
	nmos #(3,4,5) T7(y2,y3,c);
	nmos #(3,4,5) T8(y3,Gnd,d);
endmodule

module MyMUX4_1 (input a,b,c,d,s1,s2 , output w);
	wire y1,y2,y3,y4,y5,y6;
	supply1 Vdd;
	supply0 Gnd;
	MyNAND_3 G1(a,y5,y6,y1);
	MyNAND_3 G2(b,y5,s2,y2);
	MyNAND_3 G3(c,y6,s1,y3);
	MyNAND_3 G4(d,s1,s2,y4);
	MyNAND_2 G5(s1,s1,y5); //inverter
	MyNAND_2 G6(s2,s2,y6); //inverter
	MyNAND_4 G7(y1,y2,y3,y4,w);
endmodule

