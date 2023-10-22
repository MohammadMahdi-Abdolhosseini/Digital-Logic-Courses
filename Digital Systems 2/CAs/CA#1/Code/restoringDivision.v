
module divider (input clk, rst, start,
		input [9:0] x,
		input [4:0] d,
		output done, divBy0, ov,
		output [4:0] q, w);

	wire ldA, ldQ, ldD, q0, shA, shQ, twosStart, sel, sel2, sel3, addStart, done5times, sum5, twosDone, shAdone, addDone;

	datapath dp(x, d, clk, rst, ldA, ldQ, ldD, q0, shA, shQ, twosStart, sel, sel2, sel3, addStart, done5times, sum5, twosDone, shAdone, addDone, ov, divBy0, q, w);

	controller cu(done5times, sum5, twosDone, shAdone, addDone, clk, rst, start, ov, divBy0,ldA, ldQ, ldD, q0, shA, shQ, twosStart, sel, sel2, sel3, done, addStart);

endmodule