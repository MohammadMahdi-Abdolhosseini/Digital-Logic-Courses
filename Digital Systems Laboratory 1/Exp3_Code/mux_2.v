module mux_2 
#(
    parameter N = 8
)
(
    a,
    b,
    sel,
    out
);

input   [N-1:0]     a;
input   [N-1:0]     b;
input               sel;
output  [N-1:0]     out;

assign out = sel ? b : a;

endmodule