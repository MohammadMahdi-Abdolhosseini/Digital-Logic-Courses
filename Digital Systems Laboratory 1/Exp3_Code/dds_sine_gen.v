module dds_sine_gen (
    clk,
    rst,
    phase_ctrl,
    wave,
    reg_out,
    reg_in
);


input                   clk;
input                   rst;
input           [1:0]   phase_ctrl;
output      reg [7:0]   wave;


output            [7:0]   reg_out;
output            [7:0]   reg_in;


assign reg_in = {6'b0, phase_ctrl} + reg_out + 8'd1;



register 
# (
    .N(8)
)
Register_0
(
    .clk(clk),
    .rst(rst),
    .in(reg_in),
    .out(reg_out)
);


(* romstyle = "M9K" *)(* ram_init_file = "sine.mif" *) reg [7:0] rom [255:0];

always @(posedge clk) begin
    wave = rom[reg_out];
end

endmodule