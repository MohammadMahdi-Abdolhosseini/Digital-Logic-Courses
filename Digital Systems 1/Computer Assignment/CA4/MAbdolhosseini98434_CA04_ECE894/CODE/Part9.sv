module Part9_my8BitShiftRegister (input Pin, Clk, RST, output logic [7:0] Pout);
always @(posedge Clk,posedge RST)begin
if (RST)
	Pout <= 8'd0;
else
	Pout<={Pin,Pout[7:1]};
end
endmodule


module Part9_TB ();
	logic Pin;
	logic [7:0] A = 8'b00110010;
	logic CLK = 0;
	logic rst = 0;
	wire [7:0] Pout;
	Part9_my8BitShiftRegister G1 (Pin,CLK,rst,Pout);
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
	#360 rst = 1;
	#200 $stop;
	end
endmodule

