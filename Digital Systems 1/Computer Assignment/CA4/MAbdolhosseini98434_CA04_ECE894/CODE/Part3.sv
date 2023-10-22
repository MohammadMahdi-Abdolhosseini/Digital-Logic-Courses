module Part3_myDLatchClk (input D, Clk, output logic Q);
	wire [1:4] y;
	wire QBar;
	nand #8 G1(y[1],D,y[4]);
	nand #8 G2(y[2],y[4],y[3]);
	nand #8 G3(Q,y[1],QBar);
	nand #8 G4(QBar,y[2],Q);
	nand #8 N1(y[3],D,D);
	nand #8 N2(y[4],Clk,Clk);
endmodule



module Part3_myDLatchClk_TB ();
	logic DD = 1;
	logic CLK = 0;
	wire QQ;
	Part3_myDLatchClk G1 (DD,CLK,QQ);
	always #50 CLK = ~CLK;
	initial begin
	#100 DD = 0;
	#100 DD = 1;
	#100 DD = 0;
	#100 DD = 1;
	#200 $stop;
	end
endmodule

