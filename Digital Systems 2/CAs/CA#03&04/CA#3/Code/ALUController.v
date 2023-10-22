

// OPC
`define ADD 3'b000
`define SUB 3'b001
`define RSB 3'b010
`define AND 3'b011
`define NOT 3'b100
`define TST 3'b101
`define CMP 3'b110
`define MOV 3'b111




module ALUController(input ALUOp,clk, input[2:0] OPC,
                     output reg FlagStart, output reg[2:0] ALUOperation);


	always @(ALUOp, OPC)begin

        	ALUOperation <= (ALUOp == 1'b0) ? 3'b000:
                       (OPC == `ADD) ? 3'b000:
                       (OPC == `SUB) ? 3'b001:
                       (OPC == `RSB) ? 3'b010:
                       (OPC == `AND) ? 3'b011:
                       (OPC == `NOT) ? 3'b100:
                       (OPC == `TST) ? 3'b101:
                       (OPC == `CMP) ? 3'b110:
                       (OPC == `MOV) ? 3'b111: 3'b111;
	end

	always @(clk, OPC)begin

        FlagStart <=   (OPC == `CMP) ? 1'b1: 1'b0;//(OPC == `ADD) ? 1'b1: 
                       //(OPC == `SUB) ? 1'b1:
                       //(OPC == `RSB) ? 1'b1:

	end


endmodule