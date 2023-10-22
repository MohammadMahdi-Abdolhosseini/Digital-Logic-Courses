module Part5_myOnesCounterTB ();
	logic [126:0] a;
	wire [6:0] w;
	Part4_myOnesCounter GG (a,w);
	initial begin
	#500 a = 127'd114;
	#500 a = 127'd993;
	#500 a = 127'd331;
	#500 a = 127'd556;
	end
endmodule

module Part6_TB ();
	logic [126:0] a;
	wire [6:0] w;
	Part6_myOnesCounter GG(a,w);
	initial begin
	#500 a = 127'd114;
	#500 a = 127'd993;
	#500 a = 127'd331;
	#500 a = 127'd556;
	end
endmodule

