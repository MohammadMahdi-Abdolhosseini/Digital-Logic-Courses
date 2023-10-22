
module testBench;

	reg clk, rst, start;
	reg[9:0] x;
	reg[4:0] d;
	wire done, divBy0, ov;
	wire [4: 0] q, w;

	divider DIVmodule(.clk(clk), .rst(rst), .start(start),
			.x(x), .d(d),
			.done(done), .divBy0(divBy0), .ov(ov),
			.q(q), .w(w));

	always begin
		#10 clk = ~clk;
	end

	initial begin
		start = 1'b0;
		rst = 1'b0;
		clk = 1'b0;
		#10 rst = 1'b1;
		#50 rst = 1'b0;
		#50 start = 1'b1;
		x = 10'b00_0100_1011;
		d = 5'b0_1011;
		#100 start = 1'b0;
    	end

endmodule