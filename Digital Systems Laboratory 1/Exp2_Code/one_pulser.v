module one_pulser(in_pulse, out_pulse, clk, rst);
	input		in_pulse, clk, rst;
	output		out_pulse;

	parameter A = 2'd0, B = 2'd1, C = 2'd2;
	reg [1:0] ps, ns;

	always @(posedge clk, posedge rst) begin
		if (rst == 1'b1) begin
			ps <= A;
		end
		else begin
			ps <= ns;
		end
	end

	always @(ps, in_pulse) begin
		case (ps)
			A: begin
				ns = in_pulse ? B : A;
			end
			B: begin
				ns = C;
			end
			C: begin
				ns = in_pulse ? C : A;
			end
			default: begin
				ns = A;
			end
		endcase
	end

	assign out_pulse = ps == B;
endmodule
