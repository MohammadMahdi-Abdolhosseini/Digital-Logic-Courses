module triangle_wave_gen (
    cnt_val,
    wave
);

input   [7:0]   cnt_val;
output  [7:0]   wave;

assign wave = (cnt_val <= 8'd127) ? (cnt_val << 1) : ((8'd255 - cnt_val) << 1);

endmodule