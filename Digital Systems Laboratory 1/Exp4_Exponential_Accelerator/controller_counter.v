module controller_counter (
    clk,
    rst,
    clr,
    en,
    co
);

input           clk;
input           rst;
input           clr;
input           en;
output          co;


reg     [1:0]   value;


always @(posedge clk, posedge rst) begin
    if (rst == 1'b1) begin
        value = 2'd0;
    end
    else if (clr == 1'b1) begin
        value = 2'd0;
    end
    else if (en == 1'b1) begin
        value = value + 2'd1;
    end
end


assign co = &value;


endmodule 