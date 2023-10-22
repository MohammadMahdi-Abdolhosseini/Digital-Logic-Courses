module MyNAND (input a,b , output w);
	wire y;
	supply1 Vdd;
	supply0 Gnd;
	pmos #(5,6,7) T1(w,Vdd,a);
	pmos #(5,6,7) T2(w,Vdd,b);
	nmos #(3,4,5) T3(y,Gnd,b);
	nmos #(3,4,5) T4(w,y,a);
endmodule

module MyNAND2 (input a,b , output w);
	nand #(10,8) (w,a,b);
endmodule