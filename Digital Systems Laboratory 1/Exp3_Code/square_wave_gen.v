module square_wave_gen (
    cnt_val,
    wave
);

input   [7:0]   cnt_val;
output  [7:0]   wave;

assign wave = (cnt_val < 8'd128) ? 8'd0 : 8'd255;

endmodule