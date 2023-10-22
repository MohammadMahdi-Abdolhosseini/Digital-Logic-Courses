`timescale 1 ns/ 100 ps
module top_tb;

reg             clk;
reg             rst;
reg             start;
reg     [4:0]   vi_in;
reg     [1:0]   ui;

wire            done;
wire            wr_req;
wire    [20:0]  wr_data;

localparam half_cycle = 10;


top UUT (
    .clk(clk),
    .rst(rst),
    .start(start),
    .vi_in(vi_in),
    .ui(ui),
    .done(done),
    .wr_req(wr_req),
    .wr_data(wr_data)
);

always begin
    #half_cycle
    clk = 1'b0;
    #half_cycle
    clk = 1'b1;
end


initial begin 
    start = 0;
    rst = 1'b1;
    repeat (4) begin
        #half_cycle;
    end
    rst = 1'b0;
    repeat (2) begin
        #half_cycle;
    end
    vi_in = 5'b01110;
    ui = 2'b01;
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
    vi_in = 5'b11000;
    ui = 2'b00;
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
    vi_in = 5'b10011;
    ui = 2'b00;
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