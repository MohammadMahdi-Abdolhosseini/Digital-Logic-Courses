

//functions
`define ADD 6'b000001
`define SUB 6'b000010
`define AND 6'b000100
`define OR  6'b001000
`define SLT 6'b010000



module ALUController(input[1:0]ALUOp, input[5:0] Function, output reg[2:0] ALUOperation);

    always @(ALUOp, Function)begin
        case (ALUOp)
            2'b00: ALUOperation = 3'b010;
            2'b01: ALUOperation = 3'b011;
            2'b10: ALUOperation = 3'b111;
            2'b11:begin
                case(Function)
                    `ADD: ALUOperation = 3'b010;
                    `SUB: ALUOperation = 3'b011;
                    `AND: ALUOperation = 3'b000;
                    `OR : ALUOperation = 3'b001;
                    `SLT: ALUOperation = 3'b111;
                endcase
            end
        endcase
    end


endmodule