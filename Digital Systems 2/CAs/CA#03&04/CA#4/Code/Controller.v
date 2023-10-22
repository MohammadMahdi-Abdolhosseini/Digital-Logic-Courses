// OPCs
`define R_type	6'b000000
`define addi	6'b000001
`define slti	6'b000010
`define lw	6'b000011
`define sw	6'b000100
`define beq	6'b000101
`define j	6'b000110
`define jr	6'b000111
`define jal	6'b001000

// functions
`define ADD 6'b000001
`define SUB 6'b000010
`define AND 6'b000100
`define OR  6'b001000
`define SLT 6'b010000


module Controller(
	input  clk,
	input [5:0] OPC, Function,
	//--------- EX
	output reg ALUSrc, RegDst,
	output reg [2:0] ALUOp,
	//--------- MEM
	output reg MemRead, MemWrite, PCSrc,
	//--------- WB
	output reg RegWrite, MemToReg
	);


	always @(OPC, Function) begin
		{ALUSrc, RegDst, ALUOp, MemRead, MemWrite, PCSrc, RegWrite, MemToReg}={10'b0_0_000_0_0_0_0_0};
		case(OPC)
			`R_type: begin 
				RegDst=1'b1;RegWrite=1'b1;ALUSrc=1'b0;MemRead=1'b0;MemWrite=1'b0;MemToReg=1'b0;PCSrc=1'b0;
				case (Function)
					`ADD: ALUOp = 3'b000;
					`SUB: ALUOp = 3'b001;
					`AND: ALUOp = 3'b010;
					`OR: ALUOp = 3'b011;   
					`SLT: ALUOp = 3'b111;
					default: ALUOp = 3'b000;
				endcase
				end
			`addi: 	begin RegDst=1'b0;RegWrite=1'b1;ALUSrc=1'b1;MemRead=1'b0;MemWrite=1'b0;MemToReg=1'b0;ALUOp=2'b00; end
			`slti: 	begin RegDst=1'b0;RegWrite=1'b1;ALUSrc=1'b1;MemRead=1'b0;MemWrite=1'b0;MemToReg=1'b0;ALUOp=2'b10; end
			`lw: 	begin RegDst=1'b0;RegWrite=1'b1;ALUSrc=1'b1;MemRead=1'b1;MemWrite=1'b0;MemToReg=1'b1;ALUOp=2'b00; end
			`sw: 	begin             RegWrite=1'b0;ALUSrc=1'b1;MemRead=1'b0;MemWrite=1'b1;              ALUOp=2'b00; end
			`beq: 	begin 		  RegWrite=1'b0;ALUSrc=1'b0;MemRead=1'b0;MemWrite=1'b0;		     ALUOp=2'b01;PCSrc=1'b1; end	//?
			`j: 	begin		  RegWrite=1'b0;	    MemRead=1'b0;MemWrite=1'b0;	 	 	  	 PCSrc=1'b1; end
	endcase
	end
endmodule

