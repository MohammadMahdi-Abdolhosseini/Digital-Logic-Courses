module frequency_selector
(
    clk,
    rst,
    freq_sel,
    clk_out
);

localparam CNT_IN = 6'd50;

input           clk;
input           rst;
input   [2:0]   freq_sel;
output          clk_out;


wire    [7:0]    cnt_out;

counter_ld 
# (
    .N(9)
)
Counter 
(
    .clk(clk),
    .rst(rst),
    .cnt_in({freq_sel, 6'd50}),
    .cnt_out(cnt_out),
    .cnt_cout(clk_out)
);

endmodule