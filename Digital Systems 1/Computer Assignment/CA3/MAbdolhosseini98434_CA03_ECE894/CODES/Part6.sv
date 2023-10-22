module Part6_myOnesCounter (input [126:0] A , output reg [6:0] C);
	integer i;
	always @(A) begin
		C = 7'd0;
		for (i = 0 ; i <= 126 ; i = i + 1) begin
			if (A[i] == 1'b1) C = C + 1;
		end
	end
endmodule

