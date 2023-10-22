
module myFloatingPointMultiplierV (input clk, rst,
		input [31:0] A, B,
		output [31:0] result,
		input inReady, resultAccepted, startFP, startMul,
		output doneFP, resultReady, inAccept, doneMul);

	wire initM1, initM2, shiftCtrl, mulRes47;
	wire [7:0] bias;

	datapath dP (
			.clk(clk),
			.rst(rst),
			.initM1(initM1),
			.initM2(initM2),
			.bias(bias),
			.shiftCtrl(shiftCtrl),
			.startMul(startMul),
			.A(A),
			.B(B),
			.result(result),
			.mulRes47(mulRes47),
			.doneMul(doneMul)
			);

	controller control (
			.clk(clk),
			.rst(rst),
			.inReady(inReady),
			.resultAccepted(resultAccepted),
			.mulRes47(mulRes47),
			.startFP(startFP),
			.shiftCtrl(shiftCtrl),
			.initM1(initM1),
			.initM2(initM2),
			.doneFP(doneFP),
			.resultReady(resultReady),
			.bias(bias),
			.inAccept(inAccept)
			);

endmodule

