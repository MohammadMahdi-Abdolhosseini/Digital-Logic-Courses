`timescale 1ns/1ns
module mux16to1TB ();
	reg [15:0] AA = 0;
	reg [3:0] SS = 0;
	wire WW;
	mux16to1 M16(AA, SS, WW);
	initial begin
	#200 AA[2] = 1;
	#200 SS[1] = 1;
	#200 SS[2] = 1;
	#200 AA[6] = 1;
	#200 SS[3] = 1;
	#200 AA[14] = 1;
	#200 SS[2] = 0;
	#200 AA[10] = 1;
	#200 SS[1] = 0;
	#200 AA[8] = 1;
	#200 SS[0] = 1;
	#200 AA[9] = 1;
	#200 SS[3] = 0;
	#200 AA[1] = 1;
	#200 SS[2] = 1;
	#200 AA[5] = 1;
	#300 $stop;
	end
endmodule

