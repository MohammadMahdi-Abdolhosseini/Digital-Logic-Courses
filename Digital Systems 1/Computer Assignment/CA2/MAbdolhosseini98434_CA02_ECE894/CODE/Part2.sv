`timescale 1ns/1ns
module barrelShifter (input [3:0] A, input [1:0] S, output [3:0] SHO);
	
	wire [3:0] J1,J2,J3,J4;
	assign J1 = {A[2], A[1], A[0], A[3]};
	mux4to1 M1(J1, S, SHO[3]);
	assign J2 = {A[1], A[0], A[3], A[2]};
	mux4to1 M2(J2, S, SHO[2]);
	assign J3 = {A[0], A[3], A[2], A[1]};
	mux4to1 M3(J3, S, SHO[1]);
	assign J4 = {A[3], A[2], A[1], A[0]};
	mux4to1 M4(J4, S, SHO[0]);
	
endmodule

