`timescale 1ns/1ns
module mux16to1 (input [15:0] A, input [3:0] S, output w);
	
	wire y1,y2,y3,y4,y5,y6;
	mux4to1 M1(A[15:12],S[1:0],y1);
	mux4to1 M2(A[11:8],S[1:0],y2);
	mux4to1 M3(A[7:4],S[1:0],y3);
	mux4to1 M4(A[3:0],S[1:0],y4);
	wire [3:0] J;
	assign J = {y1,y2,y3,y4};
	mux4to1 M5(J,S[3:2],w);

endmodule

