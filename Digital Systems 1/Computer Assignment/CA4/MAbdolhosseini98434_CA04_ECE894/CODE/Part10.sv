module Part10_LFSR (input Pin, Clk, RST, output logic [7:0] Pout);
	wire y;
	int i = 0;
	always @(*)begin
		if (Pout[0] == 0 || Pout[0] == 1)
			i = 1;
	end
	assign y = i? (Pout[7]^Pout[6]^Pout[3]^Pout[0]) : Pin;
	Part9_my8BitShiftRegister SR (y,Clk,RST,Pout);
endmodule


module Part10_LFSR_TB ();
	logic Pin;
	logic [7:0] A = 8'b01000000;
	logic CLK = 0;
	logic rst = 0;
	wire [7:0] Pout;
	Part10_LFSR G1 (Pin,CLK,rst,Pout);
	always #50 CLK = ~CLK;
	initial begin
	#100 Pin = A[0];
	#100 Pin = A[1];
	#100 Pin = A[2];
	#100 Pin = A[3];
	#100 Pin = A[4];
	#100 Pin = A[5];
	#100 Pin = A[6];
	#100 Pin = A[7];
	#7150 $stop;
	end
endmodule

