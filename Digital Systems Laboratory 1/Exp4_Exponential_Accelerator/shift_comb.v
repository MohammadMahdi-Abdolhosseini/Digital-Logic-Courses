module shift_comb (
    in,
    out,
    sel
);

input       [17:0]  in;
output      [20:0]  out;
input       [1:0]   sel;

mux_4
# (
    .N(21)
)
Mux1
(
    .i0({3'b000, in}),
    .i1({2'b00, in, 1'b0}),
    .i2({1'b0, in, 2'b00}),
    .i3({in, 3'b000}),
    .sel(sel),
    .out(out)
);

endmodule