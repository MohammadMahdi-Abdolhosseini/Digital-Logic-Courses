`timescale 1ns/1ns
module mux4to1TB ();
	reg [3:0] AA = 0;
	reg [1:0] SS = 0;
	wire WW;
	mux4to1 MUX1(AA, SS, WW);
	initial begin
	#100 AA[0] = 1;
	#100 SS[0] = 1;
	#100 AA[1] = 1;
	#100 SS[0] = 0;
	#50 SS[1] = 1;
	#100 AA[2] = 1;
	#100 SS[0] = 1;
	#100 AA[3] = 1;
	#100 AA[3] = 0;
	#100 $stop;
	end
endmodule

