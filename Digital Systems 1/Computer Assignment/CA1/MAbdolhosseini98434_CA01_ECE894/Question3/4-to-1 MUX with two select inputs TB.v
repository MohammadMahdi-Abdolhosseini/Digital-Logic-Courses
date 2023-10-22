module MyMUX4_1_TB ();
	reg aa=0,bb=0,cc=0,dd=0,ss1=0,ss2=0;
	wire ww;
	MyMUX4_1 CUT1(aa,bb,cc,dd,ss1,ss2,ww);
	initial begin
	#50 aa=1;
	#50 bb=1;
	#50 aa=0;
	#50 ss2=1;
	#50 cc=1;
	#50 bb=1;
	#50 ss2=0;
	#50 ss1=1;
	#50 cc=0;
	#50 dd=1;
	#50 ss2=1;
	#50 ss1=0; ss2=0; 
	#50 $stop;
	end
endmodule