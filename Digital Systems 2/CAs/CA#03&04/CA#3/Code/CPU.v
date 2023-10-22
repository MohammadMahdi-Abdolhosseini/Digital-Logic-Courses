


module CPU(input clk, rst);

    wire PCWrite, MemAdr, MemWrite, MemRead,
         IRWrite, Opr2, RegDst, MemToReg,
		 RegWrite, PCSrc, select, FlagWrite,
         Start_Flag, start, ALUOp, ALUSrcA;

	wire[1:0] ALUSrcB;
	wire[2:0] ALUOperation;
    wire[31:0] DATA;

    datapath dp(
        .clk(clk),
        .PCWrite(PCWrite),
        .MemAdr(MemAdr),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .IRWrite(IRWrite),
        .Opr2(Opr2),
        .RegDst(RegDst),
        .MemToReg(MemToReg),
        .RegWrite(RegWrite),
        .PCSrc(PCSrc),
        .FlagWrite(FlagWrite),
        .Start_Flag(Start_Flag),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
		.ALUOperation(ALUOperation),
        .DATA(DATA),
        .start(start)
    );
    
    Controller cu(
        .clk(clk),
        .rst(rst),
        .start(start),
        .L_20(DATA[20]), .L_26(DATA[26]), .I_23(DATA[23]),
        .Type(DATA[29:27]),
        .PCWrite(PCWrite),
        .MemAdr(MemAdr),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .IRWrite(IRWrite),
        .Opr2(Opr2),
        .RegDst(RegDst),
        .MemToReg(MemToReg),
        .RegWrite(RegWrite),
        .ALUSrcA(ALUSrcA),
        .PCSrc(PCSrc),
        .FlagWrite(FlagWrite),
        .ALUOp(ALUOp),
        .ALUSrcB(ALUSrcB)
    );

    ALUController ac(
        .clk(clk),
        .ALUOp(ALUOp),
        .OPC(DATA[22:20]),
        .FlagStart(Start_Flag),
        .ALUOperation(ALUOperation)
    );


endmodule