`timescale 1ns/1ns
module mux4to1 (input [3:0] A, input [1:0] S, output w);
	
	assign #37.5 w = A[S];
	
endmodule

