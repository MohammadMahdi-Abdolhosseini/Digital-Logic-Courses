module reciprocal_wave_gen (
    cnt_val,
    wave
);

input   [7:0]   cnt_val;
output  [7:0]   wave;

wire    [8:0]   wave_intermediate;


assign wave_intermediate = 9'd255 / (9'd256 - cnt_val);
assign wave = wave_intermediate[7:0];

endmodule