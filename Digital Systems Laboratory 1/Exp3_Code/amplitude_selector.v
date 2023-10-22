module amplitude_selector (
    wave_in,
    wave_out,
    sel
);


input       [7:0]   wave_in;
output      [7:0]   wave_out;
input       [1:0]   sel;


mux_4
# (
    .N(8)
)
(
    .i0(wave_in),
    .i1(wave_in >> 1),
    .i2(wave_in >> 2),
    .i3(wave_in >> 3),
    .sel(sel),
    .out(wave_out)
);

endmodule