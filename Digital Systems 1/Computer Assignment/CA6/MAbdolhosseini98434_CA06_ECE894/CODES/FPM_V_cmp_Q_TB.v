
`timescale 1ns/1ns

module FPM_V_cmp_Q_TB ();

	reg clk, rst, inReady, resultAccepted, startFP, startMul;
	reg [31:0] A, B;
	wire doneFP_V, resultReady_V, inAccept_V, doneMul_V, doneFP_Q, resultReady_Q, inAccept_Q, doneMul_Q;
	wire [31:0] result_V, result_Q;

	myFloatingPointMultiplierV mvFPMV (clk, rst,
		A, B,
		result_V,
		inReady, resultAccepted, startFP, startMul,
		doneFP_V, resultReady_V, inAccept_V, doneMul_V);

	myFloatingPointMultiplier mqFPM (clk, rst,
		A, B,
		result_Q,
		inReady, resultAccepted, startFP, startMul,
		doneFP_Q, resultReady_Q, inAccept_Q, doneMul_Q);

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

		#800 $stop;
	end

endmodule

