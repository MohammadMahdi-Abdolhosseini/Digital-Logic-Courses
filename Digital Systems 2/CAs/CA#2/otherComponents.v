
module ALU (A, B, Operation, Result, Zero);
	input [31:0] A, B;
	input [2:0] Operation;
	output reg Zero;
	output reg [31:0] Result;

	always @(A, B, Operation) begin
		case (Operation)
			3'b000: Result = A & B;		// AND
			3'b001: Result = A | B;		// OR
			3'b010: Result = A + B;		// ADD
			3'b011: Result = A - B;		// SUB
			3'b111: Result = (A < B)? 
					32'd1 : 32'd0 ;	// SLT
		endcase

		assign Zero = Result? 1'b0 : 1'b1;
	end 
		
endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module SE (in, out);
	input [15:0] in;
	output reg [31:0] out;

	wire [15:0] sign;
	assign sign = in[15]? 16'b1111111111111111 
				: 16'b0000000000000000;
	assign out = {sign[15:0], in[15:0]};
		
endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module Shl2_26to28 (in, out);
	input [25:0] in;
	output reg [27:0] out;

	assign out = {in[25:0], 2'b00};
		
endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module Shl2_32 (in, out);
	input [31:0] in;
	output reg [31:0] out;

	assign out = {in[29:0], 2'b00};
		
endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module MUX2 (in_0, in_1, sel, out);
	input[31:0] in_0, in_1;
	input sel;
	output [31:0] out;

	assign out = sel ? in_1 : in_0;

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module MUX3 (in_0, in_1, in_2, sel, out);
	input [31:0] in_0, in_1, in_2;
	input [1:0] sel;
	output [31:0] out;

	assign out = (sel == 2'b00)? in_0 :
			(sel == 2'b01)? in_1 :
			(sel == 2'b10)? in_2 : in_0;

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module MUX3_5bit (in_0, in_1, in_2, sel, out);
	input[4:0] in_0, in_1, in_2;
	input [1:0] sel;
	output [4:0] out;

	assign out = (sel == 2'b00)? in_0 :
			(sel == 2'b01)? in_1 :
			(sel == 2'b10)? in_2 : in_0;

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module MUX4 (in_0, in_1, in_2, in_3, sel, out);
	input[31:0] in_0, in_1, in_2, in_3;
	input [1:0] sel;
	output [31:0] out;

	assign out = (sel == 2'b00)? in_0 :
			(sel == 2'b01)? in_1 :
			(sel == 2'b10)? in_2 :
			(sel == 2'b11)? in_3 : in_0;

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module Register32 (x, ld, clk, out);
	input [31:0] x;
	input ld, clk;
	output reg [31:0] out;

	initial begin
		out = 32'd0;
	end

	always @(posedge clk) begin
		if(ld) begin
			out = x;
		end

	end

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module Memory (Address, WriteData, clk, MemWrite, MemRead, ReadData);
	input [31:0] Address, WriteData;
	input MemWrite, MemRead, clk;
	output reg [31:0] ReadData;

	reg [7:0] Mem [0:4095];
	initial begin
 		$readmemb("memory.txt", Mem);
	end

	always @(posedge clk, MemWrite, MemRead) begin

		if (MemWrite) begin
			Mem[Address[11:0]+3] = WriteData[7:0];
			Mem[Address[11:0]+2] = WriteData[15:8];
			Mem[Address[11:0]+1] = WriteData[23:16];
			Mem[Address[11:0]+0] = WriteData[31:24];
		end

		if (MemRead) begin
			ReadData[7:0] = Mem[Address[11:0]+3];
			ReadData[15:8] = Mem[Address[11:0]+2];
			ReadData[23:16] = Mem[Address[11:0]+1];
			ReadData[31:24] = Mem[Address[11:0]+0];
		end
		$display("memory[2000] = %b", {Mem[2000],Mem[2001],Mem[2002],Mem[2003]});
		$display("memory[2004] = %b", {Mem[2004],Mem[2005],Mem[2006],Mem[2007]});

	end

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module RegisterFile (in_1, in_2, in_w, WriteData, RegWrite, clk, ReadData1, ReadData2);
	input [4:0] in_1, in_2, in_w, WriteData;
	input RegWrite, clk;
	output reg [31:0] ReadData1, ReadData2;

	reg [31:0] Register [0:31];

	always @(posedge clk, RegWrite) begin
		
		Register[0] = 32'd0;

		if (RegWrite) begin
			Register[in_w] = WriteData;
		end

		ReadData1 = Register[in_1];
		ReadData2 = Register[in_2];

	end

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
