
module My_MIPS (input clk, rst);

	wire PCWriteF, IorD, MemWrite, MemRead, IRWrite, RegWrite, ALUSrcA, Zero, PCWrite, PCwriteCond;
	wire [1:0] ALUOp, RegDst, MemToReg, ALUSrcB, PCSrc;
	wire [2:0] ALUOperation;
	wire [5:0] Opcode, Function;

	datapath dp(clk, PCWriteF, IorD, MemWrite, MemRead, IRWrite,
			RegWrite, ALUSrcA,
		RegDst, MemToReg, ALUSrcB, PCSrc,
		ALUOperation,
		Zero,
		Opcode, Function);

	Controller cu(clk, rst, Opcode, PCWrite, PCwriteCond, IorD, MemWrite, MemRead, IRWrite,
                  RegWrite, ALUSrcA, ALUOp, RegDst, MemToReg, ALUSrcB, PCSrc);

	ALUController ALUcu(ALUOp, Function, ALUOperation);

	assign PCWriteF = PCWrite | (PCwriteCond & Zero);

endmodule
