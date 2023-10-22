module counter_ld 
# (
    parameter N = 9
)
(
    clk,
    rst,
    cnt_in,
    cnt_out,
    cnt_cout
);

input                   clk;
input                   rst;
input       [N-1:0]     cnt_in;
output  reg [N-1:0]     cnt_out;
output                  cnt_cout;


always @(posedge clk, posedge rst) begin
    if (rst) begin
        cnt_out <= {N{1'd0}};
    end
    else if (cnt_cout == 1'b1) begin
        cnt_out <= cnt_in;
    end
    else begin
        cnt_out <= cnt_out + 1'd1;
    end
end

assign cnt_cout = &cnt_out;

endmodule