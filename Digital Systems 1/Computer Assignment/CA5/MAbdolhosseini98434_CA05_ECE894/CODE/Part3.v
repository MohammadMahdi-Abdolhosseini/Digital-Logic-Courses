
`timescale 1ns/1ns

module Moore_Mealy_TestBench ();

	reg clk = 0;
	reg rst = 0;
	reg j = 0;
	reg XOR = 0;
	wire w_moore, wQ_moore, w_mealy, wQ_mealy;

	Moore10010 mrVS2 (clk, rst, j, w_moore);
	Moore_Q mrVS1 (clk, rst, j, wQ_moore);
	Mealy10010 mlVS2 (clk, rst, j, w_mealy);
	Mealy_Q mlVS1 (clk, rst, j, wQ_mealy);

	assign XOR = wQ_moore ^ wQ_mealy;

	always #50 clk = ~clk;
	initial begin
	#180 j = 1;
	#100 j = 0;
	#100 j = 0;
	#100 j = 1;
	#100 j = 0;
	#100 j = 0;
	#100 j = 1;
	#100 j = 0;
	#100 j = 0;
	#100 j = 0;
	#100 j = 1;
	#100 j = 0;
	#200 $stop;
	end

endmodule

