

module MIPS(
    input clk
);

    // controller input
    wire[5:0] OPC; 
    wire[5:0] Function;


    // Forwarding Unit input
    wire[4:0] ID_EX_Register_Rt, ID_EX_Register_Rs,   
              Ex_MEM_Register_Rd, MEM_WB_Register_Rd;

    //signals
    wire ALUSrc, RegDst, MemRead, MemWrite, PCSrc, RegWrite, MemToReg;
    wire[2:0] ALUOp;

    wire EX_MEM_RegWrite, MEM_WB_RegWrite;
    wire[1:0] ForwardA, ForwardB;

    Datapath datapath(
        .clk(clk),

        //output
        .OPC(OPC),
        .Function(Function),
        .FU_EX_Rt(ID_EX_Register_Rt),
        .FU_EX_Rs(ID_EX_Register_Rs),
        .FU_MEM_Rd(Ex_MEM_Register_Rd),
        .FU_WB_Rd(MEM_WB_Register_Rd),
        .EX_MEM_RegWrite(EX_MEM_RegWrite),
        .MEM_WB_RegWrite(MEM_WB_RegWrite),

        //--signals
        //---controller----
        //--------- EX
        .ALUSrc(ALUSrc),
        .RegDst(RegDst),
        .ALUOp(ALUOp),
        //--------- MEM
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .PCSrc(PCSrc),
        //--------- WB
        .RegWrite(RegWrite),
        .MemToReg(MemToReg),


        //---Forwarding Unit----
        .ForwardA(ForwardA),
        .ForwardB(ForwardB)

    );



    // Conroller 
    Controller controller(
        .clk(clk),
        .OPC(OPC),
        .Function(Function),
        //output 
        .ALUSrc(ALUSrc),
        .RegDst(RegDst),
        .ALUOp(ALUOp),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .PCSrc(PCSrc),
        .RegWrite(RegWrite),
        .MemToReg(MemToReg)
    );

    // Forwarding Unit
    Forwarding_Unit forwarding(
        .FU_EX_Rt(ID_EX_Register_Rt),
        .FU_EX_Rs(ID_EX_Register_Rs),
        .FU_MEM_Rd(Ex_MEM_Register_Rd),
        .FU_WB_Rd(MEM_WB_Register_Rd),
        .EX_MEM_RegWrite(EX_MEM_RegWrite),
        .MEM_WB_RegWrite(MEM_WB_RegWrite),
        //output
        .ForwardA(ForwardA),
        .ForwardB(ForwardB)
    );

    // Hazard Unit



endmodule