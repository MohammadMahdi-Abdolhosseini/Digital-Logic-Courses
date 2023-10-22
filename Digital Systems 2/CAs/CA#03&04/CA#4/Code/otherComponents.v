
// All components of MIPS processor Datapath


`define AND 3'b000
`define OR 3'b001
`define ADD 3'b010
`define SUB 3'b011
`define SLT 3'b111




module ALU(
	input[31:0] A, B,
	output reg[31:0] Result,
	output reg zero,
	//signals
	input[2:0] Operation
);


	always @(A, B, Operation) begin
		case(Operation)
			`AND: Result = A & B;
			`OR: Result = A | B;		
			`ADD: Result = A + B;		
			`SUB: Result = A - B;		
			`SLT: Result = (A < B) ? 32'd1 : 32'd0;			
		endcase

		if (Result == 32'd0)
			zero = 1;
		else
			zero = 0; 
	end

endmodule

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

module Instruction_memory(input clk, input[31:0] Addr,
                          output reg[31:0] Instr);



    reg [7:0] Mem [0:4095];
    initial begin
       $readmemb("instructions.txt", Mem); 
    end
    always @(posedge clk) begin
		Instr[7:0] = Mem[Addr[11:0]+3];
		Instr[15:8] = Mem[Addr[11:0]+2];
		Instr[23:16] = Mem[Addr[11:0]+1];
		Instr[31:24] = Mem[Addr[11:0]+0];

	end

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module Register32 (in, ld, clk, out);
	input [31:0] in;
	input ld, clk;
	output reg [31:0] out;

	initial begin
		out = 32'd0;
	end

	always @(posedge clk) begin
		if(ld) begin
			out = in;
		end

	end

endmodule

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module Adder(input[31:0]A, B, output reg[31:0] Result);


    always @(A, B)begin
        Result = A + B;
    end

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module MUX2_32bit (in_0, in_1, sel, out);
	input[31:0] in_0, in_1;
	input sel;
	output [31:0] out;

	assign out = sel ? in_1 : in_0;

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module MUX2_5bit (in_0, in_1, sel, out);
	input[4:0] in_0, in_1;
	input sel;
	output [4:0] out;

	assign out = sel ? in_1 : in_0;

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module MUX3_32bit (in_0, in_1, in_2, sel, out);
	input[31:0] in_0, in_1, in_2;
	input[1:0] sel;
	output [31:0] out;

	assign out = (sel == 2'b00) ? in_0:
				 (sel == 2'b01) ? in_1: in_2;

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

	end

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module RegisterFile (
	input clk,
	input[4:0] in_1, in_2, in_w,
	input[31:0] WriteData,
	output reg[31:0] ReadData1, ReadData2,
	//signals
	input RegWrite
	);

	reg [31:0] Register [31:0];

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
module SE16 (in, out);
	input [15:0] in;
	output [31:0] out;

	assign out = {{16{in[15]}}, in};
		
endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module ShiftLeft2(
	input[31:0] in,
	output[31:0] out
);

	assign out = in << 2;

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
