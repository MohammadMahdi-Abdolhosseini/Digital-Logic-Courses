`timescale 1ns/1ns
module barrelShifterTB ();
	reg [3:0] AA = 0;
	reg [1:0] SS = 0;
	wire [3:0] SHOWW;
	barrelShifter B1(AA, SS, SHOWW);
	initial begin
	#100 AA[0] = 1;
	#100 SS[0] = 1;
	#100 SS[1] = 1;
	#100 SS[0] = 0;
	#100 AA[3] = 1;
	#100 SS[0] = 1;
	#100 $stop;
	end
endmodule

