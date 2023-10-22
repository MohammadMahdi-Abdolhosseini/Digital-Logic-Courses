
module adder (input clk, rst,
		input [7:0] A, B,
		output reg [7:0] result);

	always @(posedge clk, posedge rst) begin

		if (rst == 1)
			result <= 7'b0;
		else
			result <= A + B;

	end

endmodule

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

module subtractor (input clk, rst,
		input [7:0] A, B,
		output reg [7:0] result);

	always @(posedge clk, posedge rst) begin

		if (rst == 1)
			result <= 7'b0;
		else
			result <= A - B;

	end

endmodule

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

module multiplier (input clk, rst,
		input [23:0] A, B,
		output reg [47:0] result,
		input startMul,
		output reg doneMul);

	always @(posedge clk, posedge rst) begin

		if (rst == 1)
			result <= 48'b0;
		else if (startMul == 1) begin
			result <= A * B;
			doneMul <= 1;
		end
	end

endmodule

