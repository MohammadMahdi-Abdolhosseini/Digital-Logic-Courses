
module datapath (input [9:0] x,
		input [4:0] d,
		input clk, rst, ldA, ldQ, ldD, q0, shA, shQ, twosStart, sel, sel2, sel3, addStart,
		output done5times, sum5, twosDone, shAdone, addDone, ov, divBy0,
		output [4:0] q, w);

	wire [4:0] dv, qu, twosCompOut, mux3out;
	wire [5:0] mux1in1, mux1out, mux2in1, mux2in2, mux2out;
	wire [5:0] a, sum;
	wire y;

	reg6bit A(.x(mux1out), .clk(clk), .rst(rst), .out(a), .sin(y), .ld(ldA), .sh(shA), .shdone(shAdone));
	assign w = sum[4:0];
	assign mux1in1 = {x[9], x[9:5]};
	assign mux2in1 = {twosCompOut[4], twosCompOut};
	assign mux2in2 = {dv[4], dv};
	assign sum5 = sum[5];
	reg5bit Qu(.x(mux3out), .clk(clk), .rst(rst), .out(qu), .sin(q0), .pout(y), .ld(ldQ), .sh(shQ));
	reg5bit D(.x(d), .clk(clk), .rst(rst), .out(dv), .ld(ldD), .sh(1'b0));
	twosComp TW(.d(dv), .out(twosCompOut), .clk(clk), .rst(rst), .start(twosStart), .done(twosDone));
	adder6bit ADD(.clk(clk), .ci(1'b0), .rst(rst), .start(addStart), .A(a), .B(mux2out), .sum(sum), .done(addDone));
	count5 CNT(.clk(clk), .rst(rst), .countEN(shAdone), .done(done5times));
	mux6 M1(mux1in1, sum, sel, mux1out), M2(mux2in1, mux2in2, sel2, mux2out);
	mux5 M3(q, x[4:0], sel3, mux3out);
	mux5 M4(qu, {qu[4:1], q0}, q0, q);
	errorCheck E(.x(x[9:5]), .d(dv), .ov(ov), .divBy0(divBy0));

endmodule