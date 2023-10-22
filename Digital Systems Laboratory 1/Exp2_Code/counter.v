module counter(clk, rst, clk_en, inc, clr, co, cnt_out);
input			clk, rst, clk_en, inc, clr;
output			co;
output reg		[3:0] cnt_out;


always @(posedge clk, posedge rst) begin
	if (rst == 1'b1) begin
		cnt_out <= 4'd0;
	end
	else if (clr == 1'b1) begin
		cnt_out <= 4'd0;
	end
	else if (inc == 1'b1) begin
		if (clk_en == 1'b1) begin
			if (co == 1'b1) begin
				cnt_out <= 4'd0;
			end
			else begin
				cnt_out <= cnt_out + 1'd1;
			end
		end
	end
end

assign co = cnt_out == 4'd9;

endmodule
