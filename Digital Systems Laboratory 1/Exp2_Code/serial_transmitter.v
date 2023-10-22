module serial_transmitter (
    clk, rst, in_pulse, ser_in,
    ser_out, ser_out_valid,
    seg0, seg1, seg2, seg3, seg4, seg5, seg6
);

input               clk, rst, in_pulse, ser_in;
output              ser_out, ser_out_valid;
output              seg0, seg1, seg2, seg3, seg4, seg5, seg6;

wire        [3:0]   cnt_out;


top UNIT_1(
    .clk(clk),
    .rst(rst),
    .in_pulse(in_pulse),
    .ser_in(ser_in),
    .ser_out(ser_out),
    .ser_out_valid(ser_out_valid),
    .cnt_out(cnt_out)
);


seven_seg_disp SEVEN_SEG_1(
    .pin(cnt_out),
    .seg0(seg0),
    .seg1(seg1),
    .seg2(seg2),
    .seg3(seg3),
    .seg4(seg4),
    .seg5(seg5),
    .seg6(seg6),
);

endmodule