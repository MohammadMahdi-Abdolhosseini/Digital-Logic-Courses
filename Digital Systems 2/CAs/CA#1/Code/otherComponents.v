
module adder6bit(A, B, ci, clk, start, rst, done, co, sum);
	input[5:0] A, B;
	input ci, clk, start, rst;
	output co, done;
	reg co, done;
	output reg[5:0] sum;
	
	
	always @(posedge clk, start)
		if (rst)
			{co, sum} = 7'b0000000;
		else if (start)
		begin
			{co, sum} = A + B + ci;
			done = 1'b1;
		end
		else
			done = 1'b0;
		
endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module count5(countEN, rst, clk, done);
	input countEN, rst, clk;
	output reg done;
	reg[2:0] number;

	always @(posedge clk, rst)begin
		done = 1'b0;
		if (rst)
			number = 3'b000;
		else if (countEN | (number == 3'b101))begin
			if (number == 3'b101)begin
				//number = 3'b000;
				done = 1'b1;
			end
			else 
				number = number + 3'b001;
		end
	end

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module mux5(in1, in2, sel, out);
	
	input[4:0] in1, in2;
	input sel;
	output [4:0] out;

	assign out = sel ? in2 : in1;

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module mux6(in1, in2, sel, out);
	
	input[5:0] in1, in2;
	input sel;
	output [5:0] out;

	assign out = sel ? in2 : in1;

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module reg5bit(x, sin, ld, sh, rst, clk, pout, out);
	
	input[4:0] x;
	input sin, ld, sh, rst, clk;
	output reg[4:0] out;
	output reg pout;


	always @(posedge clk)
	begin
		if (rst)
			out = 5'b00000;
		else begin 
			if(ld)begin
				out = x;
				pout = x[4];
			end
			if (sh) begin
				out = {x[3:0], sin};
				pout = out[4];
			end
		end
	end

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module reg6bit(x, sin, ld, sh, rst, clk, shdone ,pout, out);
	
	input[5:0] x;
	input  sin, ld, sh, rst, clk;
	output reg[5:0] out;
	output reg pout, shdone;

	always @(posedge clk)
	begin
		shdone = 1'b0;
		if (rst)
			out = 6'b000000;
		else begin
			if(ld)begin
				out = x;
				pout = x[5];
			end
			if (sh) begin
				out = {x[4:0], sin};
				pout = out[5];
				shdone = 1'b1;
			end
		end
	end

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module twosComp(d, start, rst, clk, done, out);
	
	input[4:0] d;
	input start, rst, clk;
	output reg[4:0] out;
	output reg done;

	always @(posedge clk)
	begin
		done = 1'b0;
		if (rst)
			out = 5'b00000;
		else if (start)
		begin
			out = ~d + 5'b00001;
			done = 1'b1;
        	end
    	end


endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module errorCheck(x, d, ov, divBy0);
	
	input[4:0] x, d;
	output ov, divBy0;

	assign divBy0 = d == 5'b00000 ? 1'b1 : 1'b0;
	assign ov = (x < d) ? 1'b0 : 1'b1;

endmodule