module Part8_my8BitShiftRegister (input Pin,Clk,RST, output logic [7:0] Pout);
	wire [8:0] y;
	assign y[8] = Pin;
	genvar k;
	generate
		for (k = 7; k >= 0; k = k - 1) begin: latch
			Part7_myMasterSlaveDFlipFlop DL (y[k+1], Clk, RST, y[k]);
		end
		for (k = 7; k >= 0; k = k - 1) begin: outputs
			assign Pout[k] = y[k];
		end
	endgenerate
endmodule



module Part8_TB ();
	logic Pin;
	logic [7:0] A = 8'b00110010;
	logic CLK = 0;
	logic rst = 0;
	wire [7:0] Pout;
	Part8_my8BitShiftRegister G1 (Pin,CLK,rst,Pout);
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
	#300 rst = 1;
	#200 $stop;
	end
endmodule

