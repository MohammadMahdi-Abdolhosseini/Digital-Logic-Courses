
// Stages

module IF(
    input clk,
    input[31:0] PCSrc_in_1,
    output [31:0] Instr, PC_added,
    // signals 
    input PCSrc, PC_write
);

    wire[31:0] PC_out, adder_out, PCSrc_out;
    assign PC_added = adder_out;

    Instruction_memory IM(
        .clk(clk),
        .Addr(PC_out),
        .Instr(Instr)
    );

    Register32 PC(
        .clk(clk),
        .in(PCSrc_out),
        .out(PC_out),
        // signals
        .ld(PC_write)

    );

    Adder adder(
        .A(PC_out),
        .B(32'd4),
        .Result(adder_out)
    );

    MUX2_32bit PCsrc(
        .in_0(adder_out),
        .in_1(PCSrc_in_1),                                           
        .out(PCSrc_out),
        // signals
        .sel(PCSrc)
    );


endmodule

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

module ID(
    input clk, 
    input[4:0] write_reg,
    input[31:0] Instr, write_data,
    output [31:0] read_data1, read_data2, data_out,
    output[5:0] OPC,
    output[5:0] Function,
    //signals
    input reg_write
);

    assign OPC = Instr[31:26];
    assign Function = Instr[5:0];

    RegisterFile rf( 
        //input
        .clk(clk),
        .in_1(Instr[25:21]),
        .in_2(Instr[20:16]),
        .in_w(write_reg),
        .WriteData(write_data),
        //output
        .ReadData1(read_data1),
        .ReadData2(read_data2),
        //signals
        .RegWrite(reg_write)
    );


    SE16 se(
        .in(Instr[15:0]),
        .out(data_out)
    );



endmodule


//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

module EX(
    input clk,
    input[31:0] read_data1, read_data2, PC_added, Inst_15_0_se,
    input[31:0] forward_a1, forward_a2, forward_b1, forward_b2,
    input[4:0] Instr_20_16, Instr_15_11,
    output alu_zero,
    output[31:0] alu_result, Adder_out, ForwardB_out,
    output[4:0] Reg_Dst_out,
    //signals
    input RegDst, ALUSrc,   
    input[1:0] ForwardA, ForwardB,
    input[2:0] ALUOp
);

    wire[31:0] alu_src_out, shift_out, forward_a_out, forward_b_out;
    assign ForwardB_out = forward_b_out;

    ALU alu(
        .A(forward_a_out),
        .B(alu_src_out),
        //output
        .zero(alu_zero),
        .Result(alu_result),
        //signals
        .Operation(ALUOp)
    );

    MUX2_32bit mux_alu_src(
        .in_0(forward_b_out),
        .in_1(Inst_15_0_se),
        //output
        .out(alu_src_out),
        //signals
        .sel(ALUSrc)
    );    

    MUX2_5bit mux_reg_dst(
        .in_0(Instr_20_16),
        .in_1(Instr_15_11),
        //output
        .out(Reg_Dst_out),
        //signals
        .sel(RegDst)
    );

    MUX3_32bit mux_forward_a(
        .in_0(read_data1),
        .in_1(forward_a1),
        .in_2(forward_a2),
        //output
        .out(forward_a_out),
        //signals
        .sel(ForwardA)
    );

    MUX3_32bit mux_forward_b(
        .in_0(read_data2),
        .in_1(forward_b1),
        .in_2(forward_b2),
        //output
        .out(forward_b_out),
        //signals
        .sel(ForwardB)
    );

    ShiftLeft2 shift_reg(
        .in(Inst_15_0_se),
        .out(shift_out)

    );

    Adder adder(
        .A(PC_added),
        .B(shift_out),
        //output
        .Result(Adder_out)
    );


endmodule


//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

module MEM(
    input clk, alu_zero,  
    input[31:0] mem_addr, write_data,
    output[31:0] read_data,
    //signals
    input MemWrite, MemRead
);


    Memory meomry(
        .clk(clk),
        .Address(mem_addr),
        .WriteData(write_data),
        //output
        .ReadData(read_data),
        //signals
        .MemWrite(MemWrite),
        .MemRead(MemRead)
    );


endmodule

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

module WB(
    input[31:0] mux_in_0, mux_in_1,
    output[31:0] mux_out,
    //signals
    input MemToReg
);


    MUX2_32bit mem_to_reg(
        .in_0(mux_in_0),
        .in_1(mux_in_1),
        //output
        .out(mux_out),
        //signals
        .sel(MemRoReg)
    );

endmodule