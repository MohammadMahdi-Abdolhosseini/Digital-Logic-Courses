module register
# (
    parameter N = 16
)
(
    clk,
    rst,
    in,
    out
);

input                   clk;
input                   rst;
input           [N-1:0] in;
output      reg [N-1:0] out;

always @(posedge clk, posedge rst) begin
    if (rst) begin
        out <= {N{1'b0}};
    end
    else begin
        out <= in;
    end
end

endmodule