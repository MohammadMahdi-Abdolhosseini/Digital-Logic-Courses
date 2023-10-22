module MyBuffer_TB ();
	reg aa=0,bb=0;
	wire ww;
	MyBuffer CUT1(aa,bb,ww);
	initial begin 
	#50 aa=1;
	#50 bb=1;
	#50 aa=0;
	#50 bb=0;
	#50 bb=1;
	#50 aa=1;
	#50 aa=0;
	#50 aa=1;
	#50 bb=0;
	#50 bb=1;
	#50 aa=0; bb=0;
	#50 aa=1; bb=1;
	#50 $stop;
	end
endmodule
