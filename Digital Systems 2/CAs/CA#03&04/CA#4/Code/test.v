


module SE12 (in, out);
	input [15:0] in;
	output [31:0] out;

    assign out = {{16{in[15]}}, in};

	// wire [19:0] sign;
	// assign sign = in[11]? 20'd1 : 20'd0;
	// assign out = {sign[19:0], in[11:0]};
		
endmodule

module mem(input clk, input[31:0] Addr,
                          output reg[31:0] Instr);


    reg [31:0] Mem [0:64];
    initial begin
       $readmemb("instructions.txt", Mem); 
    end
    always @(posedge clk)begin
        
        Instr = Mem[Addr[5:0]];
    end

endmodule

module test();

    reg[15:0] Reg [0:15];
    wire[31:0] ins;
    wire[31:0] out;
    reg clk = 1'b0;

    mem m(clk, 32'd0, ins);

    // ShiftLeft2 s(in, out);
    // SE12 d(in, out);

    always begin
        #1 clk = ~clk;

    end

    initial begin        
        #20
        $display("  %b", ins);
        $stop;
    end



endmodule