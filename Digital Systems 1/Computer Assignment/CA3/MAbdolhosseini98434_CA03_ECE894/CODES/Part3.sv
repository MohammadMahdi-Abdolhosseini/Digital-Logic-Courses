module Part2_TB ();
	logic [3:0] A = 0;
	logic [3:0] B = 0;
	logic Cin = 0;
	wire [3:0] S;
	wire Co;
	Part2_nBitAdder #4 G1 (A,B,Cin,S,Co);
	initial begin
	repeat(10) #100 A = $random(); #100 B = $random(); #100 Cin = $random();
	#200 $stop;
	end
endmodule

