module Part6_myMasterSlaveDFlipFlop (input D, input Clk, output logic Q);
	wire y;
	Part3_myDLatchClk DL1 (D,Clk,y);
	Part3_myDLatchClk DL2 (y,~Clk,Q);
endmodule

module Part6_TB ();
	logic DD = 1;
	logic CLK = 0;
	wire QQ;
	Part6_myMasterSlaveDFlipFlop G1 (DD,CLK,QQ);
	always #50 CLK = ~CLK;
	initial begin
	#100 DD = 0;
	#100 DD = 1;
	#100 DD = 0;
	#100 DD = 1;
	#200 $stop;
	end
endmodule

