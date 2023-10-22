module sinusoid_wave_gen (
    clk,
    rst,
    cnt_val,
    cnt_cout,
    wave,
    half_rectified_wave,
    full_rectified_wave
);

input                   clk;
input                   rst;
input           [7:0]   cnt_val;
input                   cnt_cout;
output          [7:0]   wave;
output          [7:0]   half_rectified_wave;
output          [7:0]   full_rectified_wave;


sine_wave_gen SineGenerator (
    .clk(clk),
    .rst(rst),
    .cnt_val(cnt_val),
    .cnt_cout(cnt_cout),
    .wave(wave)
);

assign half_rectified_wave = (wave < 8'd128) ? 8'd127 : wave;
assign full_rectified_wave = (wave < 8'd128) ? 8'd255 - wave : wave;
endmodule