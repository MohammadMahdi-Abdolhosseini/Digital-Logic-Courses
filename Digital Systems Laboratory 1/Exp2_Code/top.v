module top(clk, rst, in_pulse, ser_in,
    ser_out, ser_out_valid, cnt_out);

input           clk, rst, in_pulse, ser_in;
output          ser_out, ser_out_valid;
output  [3:0]   cnt_out;
wire            clk_en;

detector_110101 Detector_1(
    .ser_in(ser_in),
    .clk(clk),
    .rst(rst),
    .clk_en(clk_en),
    .ser_out(ser_out),
    .ser_out_valid(ser_out_valid),
    .cnt_out(cnt_out)
);

one_pulser Pulser_1(
    .in_pulse(in_pulse),
    .out_pulse(clk_en),
    .clk(clk),
    .rst(rst)
);

endmodule