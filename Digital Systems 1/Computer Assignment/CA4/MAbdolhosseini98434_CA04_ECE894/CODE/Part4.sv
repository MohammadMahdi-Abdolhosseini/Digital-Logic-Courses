module Part4_my8BitShiftRegister (input Pin, input Clk, output logic [7:0] Pout);
	wire [8:0] y;
	assign y[8] = Pin;
	genvar k;
	generate
		for (k = 7; k >= 0; k = k - 1) begin: latch
			Part3_myDLatchClk DL (y[k+1], Clk, y[k]);
		end
		for (k = 7; k >= 0; k = k - 1) begin: outputs
			assign Pout[k] = y[k];
		end
	endgenerate
endmodule

