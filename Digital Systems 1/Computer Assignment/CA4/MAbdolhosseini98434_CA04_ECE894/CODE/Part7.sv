module Part7_myMasterSlaveDFlipFlop (input D, Clk, RST, output logic Q);
	wire y;
	assign y = D & ~RST;
	Part6_myMasterSlaveDFlipFlop G1 (y,Clk,Q);
endmodule

module Part7_TB ();
	logic DD = 1;
	logic CLK = 0;
	logic rst = 0;
	wire QQ;
	Part7_myMasterSlaveDFlipFlop G1 (DD,CLK,rst,QQ);
	always #50 CLK = ~CLK;
	initial begin
	#100 DD = 0;
	#100 DD = 1;
	#216 rst = 1;
	#100 DD = 0;
	#100 DD = 1;
	#240 rst = 0;
	#100 DD = 0;
	#200 rst = 1;
	#200 $stop;
	end
endmodule

