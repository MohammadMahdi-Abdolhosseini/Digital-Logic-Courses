module Part4_myOnesCounter (input [126:0] A , output[6:0] S);
	logic [63:0] B1 = 0;
	logic [47:0] B2 = 0;
	logic [36:0] B3 = 0;
	logic [19:0] B4 = 0;
	logic [11:0] B5 = 0;
	genvar k;
	generate
		for (k = 0 ; k <= 31 ; k = k + 1)begin: Adder1Bit
			Part1_nBitAdder #1 G1(A[3*k],A[3*k+1],A[3*k+2],B1[2*k],B1[2*k+1]);
		end
		for (k = 0 ; k <= 15 ; k = k + 1)begin: Adder2Bit
			Part1_nBitAdder #2 G2(B1[4*k+1:4*k],B1[4*k+3:4*k+2],A[k+96],B2[3*k+1:3*k],B2[3*k+2]);
		end
		for (k = 0 ; k <= 7 ; k = k + 1)begin: Adder3Bit
			Part1_nBitAdder #3 G3(B2[6*k+2:6*k],B2[6*k+5:6*k+3],A[k+112],B3[4*k+2:4*k],B3[4*k+3]);
		end
		for (k = 0 ; k <= 3 ; k = k + 1)begin: Adder4Bit
			Part1_nBitAdder #4 G4(B3[8*k+3:8*k],B3[8*k+7:8*k+4],A[k+120],B4[5*k+3:5*k],B4[5*k+4]);
		end
		for (k = 0 ; k <= 1 ; k = k + 1)begin: Adder5Bit
			Part1_nBitAdder #5 G5(B4[10*k+4:10*k],B4[10*k+9:10*k+5],A[k+124],B5[6*k+4:6*k],B5[6*k+5]);
		end
	endgenerate
	Part1_nBitAdder #6 G6(B5[5:0],B5[11:6],A[126],S[5:0],S[6]);
endmodule

