
`timescale 1ns/1ns

module FPM_Q_TB ();

	reg clk, rst, inReady, resultAccepted, startFP, startMul;
	reg [31:0] A, B, ExpectedResult, XOR;
	wire doneFP, resultReady, inAccept, doneMul;
	wire [31:0] result;

	myFloatingPointMultiplier mFPM1 (clk, rst,
		A, B,
		result,
		inReady, resultAccepted, startFP, startMul,
		doneFP, resultReady, inAccept, doneMul);

	initial begin
		rst = 1'b1;
		clk = 1'b0;
		inReady = 1'b0;
		startFP = 1'b0;
		startMul = 1'b0;
		resultAccepted = 1'b0;
	end

	initial #25 rst = 1'b0;

	always #70 clk = ~clk;

	initial begin
		#25 inReady = 1'b1;
		#5 A = 32'b11000000000100000000000000000000; // dec: - 2.25
		#5 B = 32'b01000000100100000000000000000000; // dec: + 4.5
		#200 inReady = 1'b0;
		#210 startFP = 1'b1;
		#200 startFP = 1'b0;
		#210 startMul = 1'b1;
		#200 startMul = 1'b0;

		// Expected result =
		// IEEE-754 Floating Point: 11000001001000100000000000000000
		// dec: - 10.125
		#500 ExpectedResult = 32'b11000001001000100000000000000000;

		// Actual result =
		// IEEE-754 Floating Point:
		// dec:

		#10 XOR = ExpectedResult ^ result;

		#300 $stop;
	end

endmodule

