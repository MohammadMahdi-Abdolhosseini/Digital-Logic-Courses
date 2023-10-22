


module Datapath(
    input clk,
    output[5:0] OPC,
    output[5:0] Function,
    output[4:0] FU_EX_Rt, FU_EX_Rs, FU_MEM_Rd, FU_WB_Rd,
    output EX_MEM_RegWrite, MEM_WB_RegWrite,

    //--signals
    //---controller----
    //--------- EX
    input ALUSrc, RegDst,
    input[2:0] ALUOp,
    //--------- MEM
    input MemRead, MemWrite, PCSrc,
    //--------- WB
    input RegWrite, MemToReg,


    //---Forwarding Unit----
    input[1:0] ForwardA, ForwardB

    //---Hazard Unit----
    // input PC_write, IF_ID_Write

);

    // wires that go backward
    wire[4:0] WB_Rd;
    wire[31:0] WB_mem_to_reg;
    wire[31:0] MEM_addr, MEM_adder_result;
    // signals that go backward
    wire MEM_PCSrc;
    wire WB_RegWrite;



    wire[31:0] IF_instr, IF_pc_added;

    IF IF_stage(
        .clk(clk),
        .PCSrc_in_1(MEM_adder_result),
        //output
        .Instr(IF_instr),
        .PC_added(IF_pc_added),
        // signals 
        .PCSrc(MEM_PCSrc),
        .PC_write(1'b1)                             // this signal comes from Hazard Unit
    );

    wire[31:0] ID_instr, ID_pc_added;

    IF_ID IF_ID_pipe(
        .clk(clk),
        .Instr_in(IF_instr),
        .PC_added_in(IF_pc_added),
        //output
        .Instr_out(ID_instr),
        .PC_added_out(ID_pc_added),
        //signals
        .IF_ID_Write(1'b1)                           // this signal comes from Hazard Unit
    );  


    wire[31:0] ID_read_data1, ID_read_data2, ID_data_out;


    ID ID_stage(
        .clk(clk), 
        .write_reg(WB_Rd),
        .Instr(ID_instr),
        .write_data(WB_mem_to_reg),
        //output
        .read_data1(ID_read_data1),
        .read_data2(ID_read_data2),
        .data_out(ID_data_out),
        .OPC(OPC),
        .Function(Function),
        //signals
        .reg_write(WB_RegWrite)
    );

    wire[31:0] EX_PC_added, EX_read_data1, EX_read_data2, EX_Inst_15_0_se;
    wire[4:0] EX_Rt, EX_Rd;
    //signals in EX
    wire EX_ALUSrc, EX_RegDst, EX_MemRead, EX_MemWrite,
         EX_PCSrc, EX_RegWrite, EX_MemToReg;
    wire[2:0] EX_ALUOp;

    ID_EX ID_EX_pipe(
        .clk(clk),
        .PC_added_in(ID_pc_added),
        .read_data1_in(ID_read_data1),
        .read_data2_in(ID_read_data2),
        .Inst_15_0_se_in(ID_data_out),
        .Rt_in(IF_instr[20:16]),
        .Rd_in(IF_instr[15:11]),
        .Rs_in(IF_instr[25:21]),
        //output
        .PC_added_out(EX_PC_added),
        .read_data1_out(EX_read_data1),
        .read_data2_out(EX_read_data2),
        .Inst_15_0_se_out(EX_Inst_15_0_se),
        .Rt_out(EX_Rt),
        .Rd_out(EX_Rd),
        .Rs_out(FU_EX_Rs),
        //---controller----
        //--------- EXE
        .ALUSrc(ALUSrc),
        .RegDst(RegDst),
        .ALUOp(ALUOp),
        .ALUSrc_out(EX_ALUSrc),
        .RegDst_out(EX_RegDst),
        .ALUOp_out(EX_ALUOp),
        //--------- MEM
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .PCSrc(PCSrc),
        .MemRead_out(EX_MemRead),
        .MemWrite_out(EX_MemWrite),
        .PCSrc_out(EX_PCSrc),
        //--------- WB
        .RegWrite(RegWrite),
        .MemToReg(MemToReg),
        .RegWrite_out(EX_RegWrite),
        .MemToReg_out(EX_MemToReg)
    );

    assign FU_EX_Rt = EX_Rt;

    wire EX_zero;
    wire[31:0] EX_alu_result, EX_adder_result, EX_ForwardB_out; 
    wire[4:0] EX_RegDst_out;

    EX EX_stage(
        .clk(clk),
        .read_data1(EX_read_data1),
        .read_data2(EX_read_data2),
        .PC_added(EX_PC_added),
        .Inst_15_0_se(EX_Inst_15_0_se),
        .forward_a1(WB_mem_to_reg),
        .forward_a2(MEM_addr),
        .forward_b1(WB_mem_to_reg),
        .forward_b2(MEM_addr),
        .Instr_20_16(EX_Rt),
        .Instr_15_11(EX_Rd),
        //output
        .alu_zero(EX_zero),
        .alu_result(EX_alu_result),
        .Adder_out(EX_adder_result),
        .ForwardB_out(EX_ForwardB_out),
        .Reg_Dst_out(EX_RegDst_out),
        //signals
        .RegDst(EX_RegDst),
        .ALUSrc(EX_ALUSrc),
        .ForwardA(ForwardA),
        .ForwardB(ForwardB),
        .ALUOp(EX_ALUOp)
    );

    wire MEM_zero;
    wire[31:0] MEM_Write_data;
    wire[4:0] MEM_Reg_Dst;
    //signals in MEM
    wire MEM_MemRead, MEM_MemWrite,
         MEM_RegWrite, MEM_MemToReg;

    EX_MEM EX_MEM_pipe(
        .clk(clk),
        .alu_zero_in(EX_zero),
        .alu_result_in(EX_alu_result),
        .Adder_result_in(EX_adder_result),
        .ForwardB_in(EX_ForwardB_out),
        .Reg_Dst_in(EX_RegDst_out),
        //output
        .alu_zero_out(MEM_zero),
        .alu_result_out(MEM_addr),
        .Adder_result_out(MEM_adder_result),
        .ForwardB_out(MEM_Write_data),
        .Reg_Dst_out(MEM_Reg_Dst),
    
        
        //---controller----
        //--------- MEM
        .MemRead(EX_MemRead),
        .MemWrite(EX_MemWrite),
        .PCSrc(EX_PCSrc),
        .MemRead_out(MEM_MemRead),
        .MemWrite_out(MEM_MemWrite),
        .PCSrc_out(MEM_PCSrc),
        //--------- WB
        .RegWrite(EX_RegWrite),
        .MemToReg(EX_MemToReg),
        .RegWrite_out(MEM_RegWrite),
        .MemToReg_out(MEM_MemToReg)
    );

    assign EX_MEM_RegWrite = MEM_RegWrite;
    assign FU_MEM_Rd = MEM_Reg_Dst;

    wire[31:0] MEM_read_data;

    MEM MEM_stage(
        .clk(clk),
        .alu_zero(MEM_zero),
        .mem_addr(MEM_addr),
        .write_data(MEM_Write_data),
        //output
        .read_data(MEM_read_data),
        //signals
        .MemWrite(MEM_MemWrite),
        .MemRead(MEM_MemRead)
    );

    wire[31:0] WB_addr, WB_read_data;
    // signals in WB
    wire WB_MemToReg;

    MEM_WB MEM_WB_pipe(
        .clk(clk),
        .read_data_in(MEM_read_data),
        .mem_addr_in(MEM_addr),
        .Rd_in(MEM_Reg_Dst),
        //output
        .read_data_out(WB_read_data),
        .mem_addr_out(WB_addr),
        .Rd_out(WB_Rd),
        //---controller----
        //--------- WB
        .RegWrite(MEM_RegWrite),
        .MemToReg(MEM_MemToReg),
        .RegWrite_out(WB_RegWrite),
        .MemToReg_out(WB_MemToReg)
    );

    assign MEM_WB_RegWrite = MEM_RegWrite;
    assign FU_WB_Rd = WB_Rd;

    WB WB_stage(
        .mux_in_0(WB_addr),
        .mux_in_1(WB_read_data),
        //output
        .mux_out(WB_mem_to_reg),
        //signals
        .MemToReg(WB_MemToReg)
    );

endmodule