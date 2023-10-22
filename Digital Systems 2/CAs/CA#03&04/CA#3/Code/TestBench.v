



module TB;

	reg clk, rst;

	CPU cpu(clk, rst);

	always begin
		#10 clk = ~clk;
	end

	initial begin
		clk = 1'b0;
		rst = 1'b1;
		#20 rst = 1'b0;
	end


endmodule