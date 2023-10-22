module detector_110101(ser_in, clk, rst, clk_en,
    ser_out, ser_out_valid, cnt_out);
input           ser_in, clk, rst, clk_en;
output          ser_out, ser_out_valid;
output  [3:0]   cnt_out;

wire        cnt_co, cnt_inc, cnt_clr;
moore_110101 FSM_1(
    .clk(clk),
    .rst(rst),
    .clk_en(clk_en),
    .ser_in(ser_in),
    .cnt_co(cnt_co),
    .ser_out(ser_out),
    .ser_out_valid(ser_out_valid),
    .cnt_inc(cnt_inc),
    .cnt_clr(cnt_clr)
);

counter Counter_1(
    .clk(clk),
    .rst(rst),
    .clk_en(clk_en),
    .inc(cnt_inc),
    .clr(cnt_clr),
    .co(cnt_co),
    .cnt_out(cnt_out)
);

endmodule