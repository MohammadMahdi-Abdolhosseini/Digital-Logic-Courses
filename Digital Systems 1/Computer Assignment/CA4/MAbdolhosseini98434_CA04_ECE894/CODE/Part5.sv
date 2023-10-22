module Part5_my8BitShiftRegister_TB ();
	logic Pin;
	logic [7:0] A = 8'b00100111;
	logic CLK = 0;
	wire [7:0] Pout;
	Part4_my8BitShiftRegister G1 (Pin,CLK,Pout);
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
	#200 $stop;
	end
endmodule

