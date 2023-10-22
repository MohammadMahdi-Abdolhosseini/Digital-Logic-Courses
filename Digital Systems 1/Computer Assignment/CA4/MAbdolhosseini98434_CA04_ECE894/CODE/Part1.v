module Part1_mySRLatchClk (input S, R, Clk, output logic Q);
	wire [1:5] y;
	wire QBar;
	nand #8 G1(y[1],y[3],y[4]);
	nand #8 G2(y[2],y[4],y[5]);
	nand #8 G3(Q,y[1],QBar);
	nand #8 G4(QBar,y[2],Q);
	nand #8 N1(y[3],S,S);
	nand #8 N2(y[4],Clk,Clk);
	nand #8 N3(y[5],R,R);
endmodule

