// States
`define IF 4'b0000
`define ID 4'b0001
`define JumpCompletion 4'b0010
`define BranchCompletion 4'b0011
`define Execution 4'b0100
`define RTypeCompletion 4'b0101
`define MemAddrComputation 4'b0110
`define MemAccessRead 4'b0111
`define MemAccessWrite 4'b1000
`define MemReadCompletion 4'b1001
`define AddiComputation 4'b1010
`define SltiComputation 4'b1011
`define AddiSltiCompletion 4'b1100
`define JrCompletion 4'b1101
`define JalComputation 4'b1110
`define JalCompletion 4'b1111

// OPCs
`define R_type 6'b000000
`define addi 6'b000001
`define slti 6'b000010
`define lw 6'b000011
`define sw 6'b000100
`define beq 6'b000101
`define j 6'b000110
`define jr 6'b000111
`define jal 6'b001000



module Controller(input clk, rst, input[5:0] OPC, output reg PCWrite, PCwriteCond, IorD, MemWrite, MemRead, IRWrite,
                  RegWrite, ALUSrcA, output reg[1:0] ALUOp, RegDst, MemToReg, ALUSrcB, PCSrc);



	reg [3:0] ps, ns;

	always @(posedge clk)begin
		if(rst)
			ps = `IF;
		else
			ps = ns;
	end

	always @(ps) begin
		case (ps)
			`IF: ns = `ID;
			`ID:begin
				case(OPC)
					`R_type: ns = `Execution;
					`addi: ns = `AddiComputation;
					`slti: ns = `SltiComputation;
					`lw: ns = `MemAddrComputation;
					`sw: ns = `MemAddrComputation;
					`beq: ns = `BranchCompletion;
					`j: ns = `JumpCompletion;
					`jr: ns = `JrCompletion;
					`jal: ns = `JalComputation;

				endcase
			end  
            		`JumpCompletion: ns = `IF;
			`BranchCompletion: ns = `IF;
			`Execution: ns = `RTypeCompletion;
			`RTypeCompletion: ns = `IF;
			`MemAddrComputation:begin
                			case(OPC)
                    				`lw: ns = `MemAccessRead;
                    				`sw: ns = `MemAccessWrite;
                			endcase
            				end
            		`MemAccessRead: ns = `MemReadCompletion;
            		`MemAccessWrite: ns = `IF;
           		`MemReadCompletion: ns = `IF;
            		`AddiComputation: ns = `AddiSltiCompletion;
            		`SltiComputation: ns = `AddiSltiCompletion;
            		`AddiSltiCompletion: ns = `IF;
            		`JrCompletion: ns = `IF;
            		`JalComputation: ns = `JalCompletion;
            		`JalCompletion: ns = `IF;
        	endcase
	end



    always @(ps) begin
            {PCWrite, PCwriteCond, IorD, MemWrite, MemRead, IRWrite, RegWrite, ALUSrcA,
            ALUOp, RegDst, MemToReg, ALUSrcB, PCSrc} = 18'b0_0_0_0_0_0_0_1_00_00_00_00_10;
        case(ps)
            `IF: {MemRead, ALUSrcA, ALUSrcB, IorD, ALUOp, PCWrite, PCSrc, IRWrite} = 11'b1_0_01_0_00_1_00_1 ;
            `ID: {ALUSrcA, ALUSrcB, ALUOp} = 5'b0_11_00;
            `JumpCompletion: {PCSrc, PCWrite} = 3'b01_1;
            `BranchCompletion: {ALUSrcA, ALUSrcB, ALUOp, PCSrc, PCwriteCond} = 8'b1_00_01_10_1;
            `Execution: {ALUSrcA, ALUSrcB, ALUOp} = 5'b1_00_11;
            `RTypeCompletion: {RegDst, MemToReg, RegWrite} = 5'b01_00_1;
            `MemAddrComputation: {ALUSrcA, ALUSrcB, ALUOp} = 5'b1_10_00;
            `MemAccessRead: {IorD, MemRead} = 2'b1_1;
            `MemAccessWrite: {IorD, MemWrite} = 2'b1_1;
            `MemReadCompletion:{RegDst, MemToReg, RegWrite} = 5'b00_01_1;
            `AddiComputation: {ALUSrcA, ALUSrcB, ALUOp} = 5'b1_10_00;
            `SltiComputation: {ALUSrcA, ALUSrcB, ALUOp} = 5'b1_10_10;
            `AddiSltiCompletion: {RegDst, MemToReg, RegWrite} = 5'b00_00_1;
            `JrCompletion: {ALUSrcA, ALUSrcB, ALUOp, PCWrite, PCSrc} = 8'b1_00_00_1_00;
            `JalComputation: {RegDst, MemToReg, RegWrite} = 5'b10_10_1;
            `JalCompletion: {PCSrc, PCWrite} = 3'b01_1;
        endcase
    end




endmodule