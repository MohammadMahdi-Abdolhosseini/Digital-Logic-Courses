

module Forwarding_Unit(
    input [4:0] FU_EX_Rt, FU_EX_Rs, FU_MEM_Rd, FU_WB_Rd,
    input EX_MEM_RegWrite, MEM_WB_RegWrite,
    //---Forwarding Unit----
    output reg [1:0] ForwardA, ForwardB

);

    always @(
		FU_EX_Rt, FU_EX_Rs, FU_MEM_Rd,
		FU_WB_Rd,EX_MEM_RegWrite,
		MEM_WB_RegWrite
		)begin
		// 1&2 => ForwardA
		if ((EX_MEM_RegWrite == 1) & (FU_MEM_Rd == FU_EX_Rs) & (FU_MEM_Rd != 5'b00000))
			ForwardA = 2'b10;
		// 1$3 => ForwardA
		else if ((MEM_WB_RegWrite == 1) & (FU_WB_Rd == FU_EX_Rs) & (FU_WB_Rd != 5'b00000))
			ForwardA = 2'b01;

		// 1$2 => ForwardB
		else if ((EX_MEM_RegWrite == 1) & (FU_MEM_Rd == FU_EX_Rt) & (FU_MEM_Rd != 5'b00000))
			ForwardB = 2'b10;

		// 1$3 => ForwardB
		else if ((MEM_WB_RegWrite == 1) & (FU_WB_Rd == FU_EX_Rt) & (FU_WB_Rd != 5'b00000))
			ForwardB = 2'b01;
		else begin
			ForwardA = 2'b00;
			ForwardB = 2'b00;
		end
    end

endmodule