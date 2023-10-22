
`timescale 1ns/1ns

module datapath (input clk, rst, initM1, initM2, shiftCtrl, startMul,
		input [7:0] bias,
		input [31:0] A, B,
		output [31:0] result,
		output mulRes47, doneMul);

	wire S1, S2;
	wire [7:0] E1, E2;
	wire [22:0] M1, M2;
	
	wire [7:0] sum, sub, incResult, E3;
	wire S3;
	wire [23:0] inputM1, inputM2;
	wire [22:0] M3;
	wire [47:0] mulRes, shiftRes, pMRes;

	assign S1 = A[31];
	assign E1 = A[30:23];
	assign M1 = A[22:0];

	assign S2 = B[31];
	assign E2 = B[30:23];
	assign M2 = B[22:0];

	assign M3 = pMRes[45:23];

	// XOR :
	assign #10 S3 = S1 ^ S2;

	// 8bit Adder :
	//sum = E1 + E2;
	adder ad (clk, rst, E1, E2, sum);

	// 8bit Subtractor :
	//sub = sum - bias;
	subtractor sb (clk, rst, sum, bias, sub);

	// 24bit Multiplier :
		assign inputM1 = {1'b1,M1};
		assign inputM2 = {1'b1,M2};
	multiplier mul (clk, rst, inputM1, inputM2, mulRes, startMul, doneMul);
		assign mulRes47 = mulRes[47];

	// MUX1 :
	assign E3 = shiftCtrl? incResult : sub;
		// incrementer :
			assign incResult = sub + 1;

	// MUX2 :
	assign pMRes = shiftCtrl? shiftRes : mulRes;
		// 48bit Shifter :
			assign shiftRes = mulRes >> 1'b1;

	assign result = {S3, E3, M3};

endmodule

