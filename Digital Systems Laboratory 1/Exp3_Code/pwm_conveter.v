module pwm_converter (
    clk,
    rst,
    wave_in,
    wave_out,
);

input           clk;
input           rst;
input   [7:0]   wave_in;
output          wave_out;


wire            cnt_cout;
wire    [7:0]   cnt_val;

counter Conter1 (
    .clk(clk),
    .rst(rst),
    .cnt_out(cnt_val),
    .cnt_cout(cnt_cout)
);

assign wave_out = cnt_val < wave_in ? 1'b1 : 1'b0;

endmodule