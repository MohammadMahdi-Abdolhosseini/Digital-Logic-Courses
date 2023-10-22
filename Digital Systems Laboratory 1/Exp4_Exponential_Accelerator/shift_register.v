module shift_register(
    clk,
    rst,
    sh_en,
    ld,
    in,
    out
);

localparam N = 16;

input                   clk;
input                   rst;
input                   sh_en;
input                   ld;
input       [N-1:0]     in;
output  reg [N-1:0]     out;


always @(posedge clk, posedge rst) begin
    if (rst == 1'b1) begin
        out = {N{1'b0}};
    end
    else begin
        if (ld == 1'b1) begin
            out = in;
        end
        else if (sh_en == 1'b1) begin
            // out = {1'b0, out[N-1:1]};
            out = out << 1;
        end
    end
end


endmodule