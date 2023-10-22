module Part1_myFullAdder (input ai,bi,ci , output si,co);
	wire [1:11] y;
	nand #(10,8) G1(y[3],y[1],ai);
	nand #(10,8) G2(y[4],y[2],bi);
	nand #(10,8) G3(y[9],y[3],y[4]);
	nand #(10,8) G4(y[11],y[9],ci);
	nand #(10,8) G5(y[7],y[5],ci);
	nand #(10,8) G6(y[8],y[6],y[9]);
	nand #(10,8) G7(si,y[7],y[8]);
	nand #(10,8) G8(y[10],bi,ai);
	nand #(10,8) G9(co,y[10],y[11]);
	not #(5,7) N1(y[1],bi);
	not #(5,7) N2(y[2],ai);
	not #(5,7) N3(y[5],y[9]);
	not #(5,7) N4(y[6],ci);
endmodule

module Part1_nBitAdder #(parameter n=4) (input [n:1] A,B, input Cin , output [n:1] S , output Co);
	wire [1:n+1] J;
	assign J[1] = Cin;
	assign Co = J[n+1];
	genvar k;
	generate
		for (k = 1 ; k <= n ; k = k + 1) begin: Adders
			Part1_myFullAdder nBA (A[k],B[k],J[k],S[k],J[k+1]);
		end
	endgenerate
endmodule

module Part1_TB ();
	logic [3:0] A = 0;
	logic [3:0] B = 0;
	logic Cin = 0;
	wire [3:0] S;
	wire Co;
	Part1_nBitAdder G1 (A,B,Cin,S,Co);
	initial begin
	#100 A[0] = 1;
	#100 A[2] = 1;
	#100 B[2] = 1;
	#100 B[1] = 1;
	#100 A[2] = 0;
	#100 A[1] = 1;
	#100 B[3] = 1;
	#200 $stop;
	end
endmodule

