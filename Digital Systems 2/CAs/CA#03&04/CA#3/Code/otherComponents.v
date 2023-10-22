
// OPC
`define ADD 3'b000
`define SUB 3'b001
`define RSB 3'b010
`define AND 3'b011
`define NOT 3'b100
`define TST 3'b101
`define CMP 3'b110
`define MOV 3'b111

module ALU (A, B, Operation, Result, ZCNV);
	input [31:0] A, B;
	input [2:0] Operation;
	output reg [3:0] ZCNV;
	output reg [31:0] Result;

	reg [32:0] TempResult; 

	always @(A, B, Operation) begin
		case (Operation)
			`ADD: TempResult = A + B;		// ADD
			`SUB: TempResult = A - B;		// SUB
			`RSB: TempResult = A - B;		// RSB
			`AND: TempResult = A & B;		// AND
			`NOT: TempResult = ~A +1;		// NOT
			`TST: TempResult = A & B;		// TST
			`CMP: TempResult = A - B;		// CMP
			`MOV: TempResult = B;			// AND
		endcase

	end

	assign ZCNV[3] = (TempResult == 33'd0)? 1'b1 : 1'b0;	// Zero
	assign ZCNV[2] = TempResult[32]? 1'b1 : 1'b0;		// Carry
	assign ZCNV[1] = TempResult[31]? 1'b1 : 1'b0;		// Negative
	assign ZCNV[0] = 					// OverFlow
			((A[31]==1'b1) & (B[31]==1'b1) & (TempResult[31]==1'b0)) |
			((A[31]==1'b0) & (B[31]==1'b0) & (TempResult[31]==1'b1)) ? 1'b1 : 1'b0;
	//assign ZCNV[1] = (A < B)? 1'b1 : 1'b0;
	assign Result = ((Operation==`CMP)&(A<=B))? A : ((Operation==`CMP)&(A>=B))? B : TempResult;
		
endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module SE12 (in, out);
	input [11:0] in;
	output reg [31:0] out;

	wire [19:0] sign;
	assign sign = in[11]? 20'b1111_1111_1111_1111_1111 : 20'd0;
	assign out = {sign[19:0], in[11:0]};
		
endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module SE26 (in, out);
	input [25:0] in;
	output reg [31:0] out;

	wire [5:0] sign;
	assign sign = in[25]? 6'b11_1111 : 6'd0;
	assign out = {sign[5:0], in[25:0]};
		
endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module MUX2_32bit (in_0, in_1, sel, out);
	input[31:0] in_0, in_1;
	input sel;
	output [31:0] out;

	assign out = sel ? in_1 : in_0;

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module MUX2_4bit (in_0, in_1, sel, out);
	input[3:0] in_0, in_1;
	input sel;
	output [3:0] out;

	assign out = sel ? in_1 : in_0;

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module MUX4_32bit (in_0, in_1, in_2, in_3, sel, out);
	input[31:0] in_0, in_1, in_2, in_3;
	input [1:0] sel;
	output [31:0] out;

	assign out = (sel == 2'b00)? in_0 :
			(sel == 2'b01)? in_1 :
			(sel == 2'b10)? in_2 :
			(sel == 2'b11)? in_3 : in_0;

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module Register1 (x, ld, clk, out);
	input x;
	input ld, clk;
	output reg out;

	initial begin
		out = 1'b0;
	end

	always @(posedge clk) begin
		if(ld) begin
			out = x;
		end

	end

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

	reg [31:0] Mem [0:4095];
	initial begin
 		$readmemb("memory.txt", Mem);
	end

	always @(posedge clk, MemWrite, MemRead) begin

		if (MemWrite) begin
			Mem[Address[11:0]] = WriteData[31:0];
		end

		if (MemRead) begin
			ReadData[31:0] = Mem[Address[11:0]];
		end
		$display("memory[2000] = %b", Mem[2000]);
		$display("memory[2004] = %b", Mem[2004]);

	end

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module RegisterFile (in_1, in_2, in_w, WriteData, RegWrite, clk, ReadData1, ReadData2);
	input [3:0] in_1, in_2, in_w;
	input [31:0] WriteData;
	input RegWrite, clk;
	output reg [31:0] ReadData1, ReadData2;

	reg [31:0] Register [0:15];

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
module Flag (ZCNV, select, check, flagWrite, clk, out);
	input [3:0] ZCNV;
	input [1:0] check;
	input select, flagWrite, clk;
	output reg  out;

	wire Zout, Cout, Nout, Vout;
	reg EQ, GT, LT, AL;

	Register1 Zzz(ZCNV[3], flagWrite, clk, Zout);
	Register1 Ccc(ZCNV[2], flagWrite & select, clk, Cout);
	Register1 Nnn(ZCNV[1], flagWrite, clk, Nout);
	Register1 Vvv(ZCNV[0], flagWrite & select, clk, Vout);

	assign EQ = Zout;
	assign GT = ~Zout & ((Nout & Vout)|(~Nout & ~Vout));
	assign LT = (~Nout & Vout) | (Nout & ~Vout) | (Nout & Vout);//Nout;//Nout;//(~Nout & Vout) | (Nout & ~Vout) | (Nout & Vout);
	assign AL = 1'b1;

	assign out = (check == 2'b00) ? EQ :
		(check == 2'b01) ? GT :
		(check == 2'b10) ? LT :
		(check == 2'b11) ? AL : AL;
endmodule