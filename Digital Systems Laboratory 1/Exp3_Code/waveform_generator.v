module waveform_generator
(
    clk,
    rst,
    func_sel,
    wave
);

input               clk;
input               rst;
input       [2:0]   func_sel;
output      [7:0]   wave;


wire        [7:0]   cnt_val;
wire                cnt_cout;
wire        [7:0]   reciprocal_out, square_out, triangle_out;
wire        [7:0]   sine_out, sine_half_rectified_out;
wire        [7:0]   sine_full_rectified_out;

counter  Counter
(
    .clk(clk),
    .rst(rst),
    .cnt_out(cnt_val),
    .cnt_cout(cnt_cout)
);


sinusoid_wave_gen SinusodGenerator (
    .clk(clk),
    .rst(rst),
    .cnt_val(cnt_val),
    .cnt_cout(cnt_cout),
    .wave(sine_out),
    .half_rectified_wave(sine_half_rectified_out),
    .full_rectified_wave(sine_full_rectified_out)
);

reciprocal_wave_gen ReciprocalGenerator (
    .cnt_val(cnt_val),
    .wave(reciprocal_out)
);

square_wave_gen SquareGenerator (
    .cnt_val(cnt_val),
    .wave(square_out)
);


triangle_wave_gen TriangleGenerator (
    .cnt_val(cnt_val),
    .wave(triangle_out)
);

mux_8
# (
    .N(8)
)
Mux0
(
    .i0(reciprocal_out),
    .i1(square_out),
    .i2(triangle_out),
    .i3(sine_out),
    .i4(sine_half_rectified_out),
    .i5(sine_full_rectified_out),
    .i6({8{1'bz}}), //DDS
    .i7({8{1'bz}}),
    .sel(func_sel),
    .out(wave)
);
endmodule