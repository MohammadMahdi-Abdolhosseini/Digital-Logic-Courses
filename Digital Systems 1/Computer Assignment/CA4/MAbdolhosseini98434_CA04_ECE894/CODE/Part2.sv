module Part2_mySRLatchClk_TB ();
	logic SS = 1;
	logic RR = 0;
	logic CLK = 0;
	wire QQ;
	Part1_mySRLatchClk G1 (SS,RR,CLK,QQ);
	always #50 CLK = ~CLK;
	initial begin
	#100 SS = 1;
	#100 RR = 1;
	#100 SS = 0;
	#100 SS = 1;
	#100 RR = 0;
	#100 SS = 0;
	#100 SS = 1;
	#200 $stop;
	end
endmodule


