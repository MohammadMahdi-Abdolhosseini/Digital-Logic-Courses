`timescale 1 ns/ 100 ps
module exponential_tb ();

reg             clk;
reg             rst;
reg             start;
reg     [15:0]  x;
wire            done;
wire    [1:0]   intpart;
wire    [15:0]  fracpart;

localparam half_cycle = 10;

exponential UUT
(
    .clk(clk),
    .rst(rst),
    .start(start),
    .x(x),
    .done(done),
    .intpart(intpart),
    .fracpart(fracpart)
);


always begin
    #half_cycle
    clk = 1'b0;
    #half_cycle
    clk = 1'b1;
end


initial begin 
    start = 0;
    x = 15'd3080;
    rst = 1'b1;
    repeat (4) begin
        #half_cycle;
    end
    rst = 1'b0;
    repeat (2) begin
        #half_cycle;
    end
    start = 1;
    repeat (4) begin
        #half_cycle;
    end
    start = 0;
    repeat (4) begin
        #half_cycle;
    end

    @(done);
    repeat (6) begin
        #half_cycle;
    end
    x = 15'd2481;
    start = 1;
    repeat (4) begin
        #half_cycle;
    end
    start = 0;
    repeat (4) begin
        #half_cycle;
    end
    @(done);
    repeat (8) begin
        #half_cycle;
    end
    $stop;
end

endmodule