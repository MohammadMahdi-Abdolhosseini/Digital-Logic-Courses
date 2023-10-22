
module datapath (input clk, PCWrite, MemAdr, MemWrite, MemRead, IRWrite,
			Opr2, RegDst, MemToReg, ALUSrcA,
			RegWrite, PCSrc,
			FlagWrite, Start_Flag,
		input [1:0] ALUSrcB,
		input [2:0] ALUOperation,
		output [31:0] DATA, output start);

	wire [31:0] PCout, MUXout_MemAdr, Memory_out, IRout, MDRout, MUXout_MemToReg, 
			RegisterFile_out_A, RegisterFile_out_B,
			Aout, Bout, MUXout_ALUSrcA, MUXout_ALUSrcB, ALU_Result, ALU_out,
			MUXout_PCSrc, SE12_out, SE26_out;
	wire [3:0] MUXout_RegDst, MUXout_Opr2, ZCNV;

	Register32 PC (.x(MUXout_PCSrc), .clk(clk), .out(PCout), .ld(PCWrite));
	Register32 IR (.x(Memory_out), .clk(clk), .out(IRout), .ld(IRWrite));
	Register32 MDR (.x(Memory_out), .clk(clk), .out(MDRout), .ld(1'b1));
	Register32 A (.x(RegisterFile_out_A), .clk(clk), .out(Aout), .ld(1'b1));
	Register32 B (.x(RegisterFile_out_B), .clk(clk), .out(Bout), .ld(1'b1));
	Register32 ALUout (.x(ALU_Result), .clk(clk), .out(ALU_out), .ld(1'b1));

	MUX2_32bit MUX_MemAdr (.in_0(ALU_Result), .in_1(PCout), .sel(MemAdr), .out(MUXout_MemAdr));
	MUX2_4bit MUX_Opr2 (.in_0(IRout[15:12]), .in_1(IRout[3:0]), .sel(Opr2), .out(MUXout_Opr2));
	MUX2_32bit MUX_ALUSrcA (.in_0(RegisterFile_out_A), .in_1(PCout), .sel(ALUSrcA), .out(MUXout_ALUSrcA));
	MUX2_4bit MUX_RegDst (.in_0(4'b1111), .in_1(IRout[15:12]), .sel(RegDst), .out(MUXout_RegDst));
	MUX2_32bit MUX_MemToReg (.in_0(ALU_out), .in_1(MDRout), .sel(MemToReg), .out(MUXout_MemToReg));
	MUX2_32bit MUX_PCSrc (.in_0(ALU_out), .in_1(ALU_Result), .sel(PCSrc), .out(MUXout_PCSrc));
	MUX4_32bit MUX_ALUSrcB (.in_0(RegisterFile_out_B), .in_1(SE12_out), .in_2(SE26_out), .in_3(32'd1), .sel(ALUSrcB), .out(MUXout_ALUSrcB));

	SE12 SE_down12 (.in(IRout[11:0]), .out(SE12_out));
	SE26 SE_down26 (.in(IRout[25:0]), .out(SE26_out));

	Memory MEM (.Address(MUXout_MemAdr), .WriteData(Bout), .clk(clk), .MemWrite(MemWrite), .MemRead(MemRead), .ReadData(Memory_out));
	RegisterFile RF (.in_1(IRout[19:16]), .in_2(MUXout_Opr2), .in_w(MUXout_RegDst), .WriteData(MUXout_MemToReg), .RegWrite(RegWrite), .clk(clk), .ReadData1(RegisterFile_out_A), .ReadData2(RegisterFile_out_B));
	ALU ALU_a (.A(MUXout_ALUSrcA), .B(MUXout_ALUSrcB), .Operation(ALUOperation), .Result(ALU_Result), .ZCNV(ZCNV));


	Flag fl(.ZCNV(ZCNV), .select(Start_Flag), .check(IRout[31:30]), .flagWrite(FlagWrite), .clk(clk), .out(start));

	assign DATA = IRout[31:0];

endmodule