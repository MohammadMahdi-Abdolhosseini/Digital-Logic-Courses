module ui_register (
    clk,
    rst,
    ld,
    in,
    out
);

input               clk;
input               rst;
input               ld;
input       [1:0]   in;
output  reg [1:0]   out;


always @(posedge clk, posedge rst) begin
    if (rst == 1'b1) begin
        out = 2'd0;
    end
    else if (ld == 1'b1) begin
        out = in;
    end
end

endmodule 