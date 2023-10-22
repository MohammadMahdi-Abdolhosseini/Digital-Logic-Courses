// States
`define IF 4'b0000
`define Flag 4'b0001
`define Rb_Offset 4'b0010
`define Operation 4'b0011
`define Offset_PC 4'b0100
`define FillMDR 4'b0101
`define Mem_Rd 4'b0110
`define WriteDataFlag 4'b0111
`define SetR15 4'b1000
`define Rd_MDR 4'b1001


// Types
`define DataProcess 3'b000
`define DataTransfer 3'b010
`define Branch 3'b101



module Controller(input clk, rst, start, L_20, L_26, I_23, input[2:0] Type, output reg PCWrite,
				  MemAdr, MemWrite, MemRead, IRWrite, Opr2, RegDst, MemToReg, RegWrite, ALUSrcA,
                  PCSrc, FlagWrite, ALUOp, output reg[1:0] ALUSrcB);



	reg [3:0] ps, ns;

	always @(posedge clk)begin
		if(rst)
			ps = `IF;
		else
			ps = ns;
	end

	always @(ps) begin
		case (ps)
			`IF: ns = `Flag;
			`Flag: ns = (start == 1'b0) ? `IF :
							(Type == `DataProcess) ? `Operation :
							(Type == `DataTransfer) ? `Rb_Offset :
							(Type == `Branch) ? `Offset_PC : `IF;
			`Rb_Offset: ns = L_20 ? `Mem_Rd : `FillMDR;
			`Mem_Rd: ns = `IF;
			`FillMDR: ns = `Rd_MDR;
			`Rd_MDR: ns = `IF;
			`Operation: ns = `WriteDataFlag;
			`WriteDataFlag: ns = `IF;
			`Offset_PC: ns = L_26 ? `IF : `SetR15;
			`SetR15 : ns = `IF; 
			default: ns = `IF;
		endcase
	end



    always @(ps) begin
        {PCWrite, MemAdr, MemWrite, MemRead, IRWrite, Opr2, RegDst,
		MemToReg, RegWrite, ALUSrcA, PCSrc, FlagWrite, ALUOp, ALUSrcB} = 15'b0_1_0_0_0_0_1_1_0_0_0_0_0_00;
        case(ps)
		`IF: {MemAdr, MemRead, IRWrite, PCWrite, PCSrc, ALUSrcA, ALUSrcB} = 8'b111111_11;
		`Flag: {Opr2, RegDst, ALUSrcA, ALUSrcB, ALUOp} = {~I_23, 5'b11_10_0};
		`Rb_Offset: {ALUOp, ALUSrcA, ALUSrcB, Opr2} = 5'b0_0_01_0;
		`Operation: {ALUOp, FlagWrite, ALUSrcA, ALUSrcB} = {4'b1_1_0_0, I_23};
		`Offset_PC: {PCSrc, PCWrite} = 2'b01;
		`FillMDR: {MemAdr, MemRead} = 2'b01;
		`Mem_Rd: {MemAdr, MemWrite} = 2'b01;
		`WriteDataFlag: {MemToReg, RegWrite, FlagWrite, RegDst, ALUSrcB} = {6'b0111_0, I_23};
		`SetR15: {RegDst, MemToReg, RegWrite} = 3'b001;
		`Rd_MDR: {MemToReg, RegWrite, RegDst} = 3'b111;
        endcase
    end




endmodule