
module IF_ID(
    input clk,
    input[31:0] Instr_in, PC_added_in,
    output reg[31:0] Instr_out, PC_added_out,
    //signals
    input IF_ID_Write
);


    always @(posedge clk) begin
        if(IF_ID_Write)begin
            Instr_out <= Instr_in;
            PC_added_out <= PC_added_in;
        end

    end

endmodule
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

module ID_EX(
    input clk,
    input[31:0] PC_added_in, read_data1_in, read_data2_in, Inst_15_0_se_in,
    input[4:0] Rd_in, Rs_in, Rt_in,

    output reg[31:0] PC_added_out, read_data1_out, read_data2_out, Inst_15_0_se_out,
    output reg[4:0] Rd_out, Rs_out, Rt_out,
    
    //---controller----
    //--------- EXE
    input ALUSrc,RegDst,
    input[2:0] ALUOp,
    output reg ALUSrc_out,RegDst_out,
    output reg[2:0] ALUOp_out,
    //--------- MEM
    input MemRead, MemWrite, PCSrc,
    output reg MemRead_out, MemWrite_out, PCSrc_out,
    //--------- WB
    input RegWrite, MemToReg,
    output reg RegWrite_out, MemToReg_out
);


always @(posedge clk) begin
    PC_added_out <= PC_added_in;
    read_data1_out <= read_data1_in;
    read_data2_out <= read_data2_in;
    Rt_out <= Rt_in;
    Rd_out <= Rd_in;
    Rs_out <= Rs_in;
    ALUSrc_out <= ALUSrc;
    RegDst_out <= RegDst;
    ALUOp_out <= ALUOp;
    MemRead_out <= MemRead;
    MemWrite_out <= MemWrite;
    PCSrc_out <= PCSrc;
    RegWrite_out <= RegWrite;
    MemToReg_out <= MemToReg;
end

endmodule

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

module EX_MEM(
    input clk, alu_zero_in,
    input[31:0] alu_result_in, Adder_result_in, ForwardB_in,
    input[4:0] Reg_Dst_in,
    output reg alu_zero_out,
    output reg[31:0] alu_result_out, Adder_result_out, ForwardB_out,
    output reg[4:0] Reg_Dst_out,
    
    //---controller----
    //--------- MEM
    input MemRead, MemWrite, PCSrc,
    output reg MemRead_out, MemWrite_out, PCSrc_out,
    //--------- WB
    input RegWrite, MemToReg,
    output reg RegWrite_out, MemToReg_out
);



always @(posedge clk) begin
    alu_zero_out <= alu_zero_in; 
    alu_result_out <= alu_result_in; 
    Adder_result_out <= Adder_result_in; 
    ForwardB_out <= ForwardB_in; 
    Reg_Dst_out <= Reg_Dst_in; 
    MemRead_out <= MemRead;
    MemWrite_out <= MemWrite;
    PCSrc_out <= PCSrc & alu_zero_in;                 // this is for 'beq' 
    RegWrite_out <= RegWrite;
    MemToReg_out <= MemToReg;
end



endmodule

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=


module MEM_WB(
    input clk, 
    input[31:0] read_data_in, mem_addr_in,
    input[4:0] Rd_in,
    output reg[31:0] read_data_out, mem_addr_out,
    output reg[4:0] Rd_out,
    //---controller----
    //--------- WB
    input RegWrite, MemToReg,
    output reg RegWrite_out, MemToReg_out
);



always @(posedge clk) begin
    read_data_out <= read_data_in;
    mem_addr_out <= mem_addr_in;
    RegWrite_out <= RegWrite;
    MemToReg_out <= MemToReg;
    Rd_out <= Rd_in;
end



endmodule
