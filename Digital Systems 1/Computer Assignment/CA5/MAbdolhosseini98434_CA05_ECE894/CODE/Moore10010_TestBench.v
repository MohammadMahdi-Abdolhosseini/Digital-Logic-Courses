
module Moore10010_TestBench ();

	reg clk = 0;
	reg rst = 0;
	reg j = 0;
	wire w;

	Moore10010 M1 (clk, rst, j, w);

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
	#200 $stop;
	end

endmodule

