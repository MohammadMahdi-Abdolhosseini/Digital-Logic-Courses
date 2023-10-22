module mux_4 
#(
    parameter N = 8
)
(
    i0,
    i1,
    i2,
    i3,
    sel,
    out
);

input           [N-1:0]     i0;
input           [N-1:0]     i1;
input           [N-1:0]     i2;
input           [N-1:0]     i3;
input           [1:0]       sel;
output  reg     [N-1:0]     out;


always @(*) begin
    case (sel)
    2'd0: out = i0;
    2'd1: out = i1;
    2'd2: out = i2;
    2'd3: out = i3;
    endcase
end

endmodule