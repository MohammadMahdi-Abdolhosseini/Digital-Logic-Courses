module counter (
    clk,
    rst,
    cnt_out,
    cnt_cout
);

input               clk;
input               rst;
output  reg [7:0]   cnt_out;
output              cnt_cout;


always @(posedge clk, posedge rst) begin
    if (rst) begin
        cnt_out <= 8'd0;
    end
    else begin
        cnt_out <= cnt_out + 1'd1;
    end
end

assign cnt_cout = &cnt_out;

endmodule