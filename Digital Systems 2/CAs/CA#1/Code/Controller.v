
`define s0 4'b0000
`define s1 4'b0001
`define s2 4'b0010
`define s3 4'b0011
`define s4 4'b0100
`define s5 4'b0101
`define s6 4'b0110
`define s7 4'b0111
`define s8 4'b1000
`define s9 4'b1001
`define s10 4'b1010
`define s11 4'b1011
`define s12 4'b1100
`define s13 4'b1101
`define s14 4'b1110
`define s15 4'b1111

module controller (input done5times, sum5, twosDone, shAdone, addDone, clk, rst, start, ov, divBy0,
		output reg ldA, ldQ, ldD, q0, shA, shQ, twosStart, sel, sel2, sel3, done, addStart);

	reg [3:0] ps, ns;
	always @(posedge clk)
		if (rst)
			ps <= 4'b0000;
		else
			ps <= ns;

	always @(ps, start) begin
		case (ps)
			`s0: ns = start? `s1: `s0;
			`s1: ns = ~(ov | divBy0)? `s2: `s0;
			`s2: ns = `s3;
			`s3: ns = twosDone? `s4: `s2;
			`s4: ns = `s5;
			`s5: ns = shAdone? `s6: `s4;
			`s6: ns = `s7;
			`s7: ns = (addDone & ~sum5)? `s11: (addDone & sum5)? `s8: `s6;
			`s8: ns = `s9;
			`s9: ns = `s10;
			`s10: ns = addDone? `s12: `s9;
			`s11: ns = `s12;
			`s12: ns = done5times? `s14: `s13;
			`s13: ns = `s5;
			`s14: ns = `s0;
		endcase
	end
	

	
	always @(ps) begin
		
		{ldA, ldQ, ldD, q0, shA, shQ, twosStart, sel, sel2, sel3, done, addStart} = 12'b0000_0000_0000;	
		
		case (ps)
			`s0: ;
			`s1: {ldA, ldQ, ldD, sel3} = 4'b1111;
			`s2: twosStart = 1'b1;
			`s3: ;
			`s4: {shA, shQ} = 2'b11;
			`s5: ;
			`s6: addStart = 1'b1;
			`s7: ;
			`s8: {ldA, sel} = 2'b11;
			`s9: {sel2, addStart} = 2'b11;
			`s10: ;
			`s11: {ldQ, q0} = 2'b11;
			`s12: ;
			`s13: {shA, shQ, sel} = 3'b111;
			`s14: done = 1'b1;
		endcase
	end

endmodule