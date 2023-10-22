module moore_110101(ser_in, clk_en, rst, clk, cnt_co,
	ser_out, ser_out_valid, cnt_inc, cnt_clr);

input		ser_in, clk_en, rst, clk, cnt_co;
output		ser_out;
output	reg	ser_out_valid, cnt_inc, cnt_clr;

parameter idle = 3'd0, got1 = 3'd1, got2 = 3'd2, got3 = 3'd3, got4 = 3'd4,
	got5 = 3'd5, gotAll = 3'd6;

reg [2:0] ps, ns;

always @(posedge clk, posedge rst) begin
	if (rst == 1'b1) begin
		ps <= idle;
	end
	else begin
		ps <= ns;
	end
end

always @(ser_in, clk_en, ps) begin
	case (ps)
		idle: begin
			if (clk_en == 1'b1) begin
				ns <= ser_in ? got1 : idle;
			end
			else begin
				ns <= ps;
			end
		end
		got1: begin
			if (clk_en == 1'b1) begin
				ns <= ser_in ? got2 : idle;
			end
			else begin
				ns <= ps;
			end
		end
		got2: begin
			if (clk_en == 1'b1) begin
				ns <= ser_in ? got2 : got3;
			end
			else begin
				ns <= ps;
			end
		end
		got3: begin
			if (clk_en == 1'b1) begin
				ns <= ser_in ? got4 : idle;
			end
			else begin
				ns <= ps;
			end
		end
		got4: begin
			if (clk_en == 1'b1) begin
				ns <= ser_in ? got2 : got5;
			end
			else begin
				ns <= ps;
			end
		end
		got5: begin
			if (clk_en == 1'b1) begin
				ns <= ser_in ? gotAll : idle;
			end
			else begin
				ns <= ps;
			end
		end
		gotAll: begin
			if (clk_en == 1'b1) begin
				ns <=  cnt_co ? idle : gotAll;
			end
			else begin
				ns <= ps;
			end
		end
		// gotAll: begin
		// 	ns <=  cnt_co ? idle : gotAll;
		// end
		default: begin
			ns <= idle;
		end
	endcase
end

always @(ps) begin
	{cnt_clr, ser_out_valid, cnt_inc} = 3'b000;
	case (ps)
		idle: begin
			cnt_clr = 1'b1;
		end
		gotAll: begin
			ser_out_valid = 1'b1;
			cnt_inc = 1'b1;
		end
	endcase
end

assign ser_out = ser_in;

endmodule
