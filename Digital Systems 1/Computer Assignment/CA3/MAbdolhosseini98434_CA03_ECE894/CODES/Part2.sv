module Part2_nBitAdder #(parameter n=4) (input [n:1] A,B, input Cin , output [n:1] S , output Co);
	assign #40 {Co,S} = A + B + Cin;
endmodule

