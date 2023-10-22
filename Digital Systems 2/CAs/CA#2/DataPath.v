
module datapath (input clk, PCWrite, IorD, MemWrite, MemRead, IRWrite,
			RegWrite, ALUSrcA,
		input [1:0] RegDst, MemToReg, ALUSrcB, PCSrc,
		input [2:0] ALUOperation,
		output Zero,
		output [5:0] Opcode, Function);

	wire [31:0] PCout, MUXout_IorD, Memory_out, IRout, MDRout, MUXout_MemToReg, 
			RegisterFile_out_A, RegisterFile_out_B,
			Aout, Bout, MUXout_ALUSrcA, MUXout_ALUSrcB, ALU_Result, ALU_out, MUXout_PCSrc, SEout, Shl2_32_out;
	wire [27:0] Shl2_26to28_out;
	wire [4:0] MUXout_RegDst;

	Register32 PC (.x(MUXout_PCSrc), .clk(clk), .out(PCout), .ld(PCWrite));
	Register32 IR (.x(Memory_out), .clk(clk), .out(IRout), .ld(IRWrite));
	Register32 MDR (.x(Memory_out), .clk(clk), .out(MDRout), .ld(1'b1));
	Register32 A (.x(RegisterFile_out_A), .clk(clk), .out(Aout), .ld(1'b1));
	Register32 B (.x(RegisterFile_out_B), .clk(clk), .out(Bout), .ld(1'b1));
	Register32 ALUout (.x(ALU_Result), .clk(clk), .out(ALU_out), .ld(1'b1));

	MUX2 MUX_IorD (.in_0(PCout), .in_1(ALU_out), .sel(IorD), .out(MUXout_IorD));
	MUX2 MUX_ALUSrcA (.in_0(PCout), .in_1(Aout), .sel(ALUSrcA), .out(MUXout_ALUSrcA));
	MUX3_5bit MUX_RegDst (.in_0(IRout[20:16]), .in_1(IRout[15:11]), .in_2(5'b11111), .sel(RegDst), .out(MUXout_RegDst));
	MUX3 MUX_MemToReg (.in_0(ALU_out), .in_1(MDRout), .in_2(PCout), .sel(MemToReg), .out(MUXout_MemToReg));
	MUX3 MUX_PCSrc (.in_0(ALU_Result), .in_1({PCout[31:28] , Shl2_26to28_out}), .in_2(ALU_out), .sel(PCSrc), .out(MUXout_PCSrc));
	MUX4 MUX_ALUSrcB (.in_0(Bout), .in_1(32'd4), .in_2(SEout), .in_3(Shl2_32_out), .sel(ALUSrcB), .out(MUXout_ALUSrcB));

	Shl2_26to28 Shl2_up (.in(IRout[25:0]), .out(Shl2_26to28_out));
	Shl2_32 Shl2_down (.in(SEout), .out(Shl2_32_out));
	SE SE_down (.in(IRout[15:0]), .out(SEout));

	Memory MEM (.Address(MUXout_IorD), .WriteData(Bout), .clk(clk), .MemWrite(MemWrite), .MemRead(MemRead), .ReadData(Memory_out));
	RegisterFile RF (.in_1(IRout[25:21]), .in_2(IRout[20:16]), .in_w(MUXout_RegDst), .WriteData(MUXout_MemToReg), .RegWrite(RegWrite), .clk(clk), .ReadData1(RegisterFile_out_A), .ReadData2(RegisterFile_out_B));
	ALU ALU_a (.A(MUXout_ALUSrcA), .B(MUXout_ALUSrcB), .Operation(ALUOperation), .Result(ALU_Result), .Zero(Zero));

	assign Opcode = IRout[31:26];//(~IRout)? Memory_out[31:26] : 
	assign Function = IRout[5:0];//(~IRout)? Memory_out[5:0] : 

endmodule