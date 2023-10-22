`timescale 1ns/1ns
module top_TB();

reg             clk, rst;
reg             in_pulse, ser_in;
wire            ser_out, ser_out_valid;
wire    [3:0]   cnt_out;

parameter half_cycle = 10;

top UUT(
    .clk(clk),
    .rst(rst),
    .in_pulse(in_pulse),
    .ser_in(ser_in),
    .ser_out(ser_out),
    .ser_out_valid(ser_out_valid),
    .cnt_out(cnt_out)
);

always begin
    #half_cycle
    clk = 1'b0;
    #half_cycle
    clk = 1'b1;
end

always begin
    #half_cycle
    @(posedge clk);
    in_pulse = 1'b0;
    repeat (3) begin
        @(posedge clk);
    end
    #half_cycle
    in_pulse = 1'b1;
    repeat (10) begin
        @(posedge clk);
    end
end

initial begin
    ser_in = 1'b0;

    repeat (2) begin
        @(posedge UUT.clk_en);
    end
    
    @(posedge UUT.clk_en);
    ser_in = 1'b1;
    @(posedge UUT.clk_en);
    ser_in = 1'b1;
    @(posedge UUT.clk_en);
    ser_in = 1'b0;
    @(posedge UUT.clk_en);
    ser_in = 1'b1;
    @(posedge UUT.clk_en);
    ser_in = 1'b0;
    @(posedge UUT.clk_en);
    ser_in = 1'b1;
    repeat (20) begin
        @(posedge UUT.clk_en);
    end
    $stop;
end

initial begin
    rst = 1'b1;
    #50
    rst = 1'b0;
end

endmodule