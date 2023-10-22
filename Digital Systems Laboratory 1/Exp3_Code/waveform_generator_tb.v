`timescale 1ns/1ns
module waveform_generator_tb();

reg             clk, rst;
reg     [2:0]   func_sel;
wire    [7:0]   wave;

localparam half_cycle = 10;

waveform_generator UUT (
    .clk(clk),
    .rst(rst),
    .func_sel(func_sel),
    .wave(wave)
);

always begin
    #half_cycle
    clk = 1'b0;
    #half_cycle
    clk = 1'b1;
end

initial begin
    #half_cycle
    rst = 1'b0;
    repeat (4) begin
        #half_cycle;
    end
    rst = 1'b1;
    repeat (4) begin
        #half_cycle;
    end
    rst = 1'b0;
end


initial begin
    repeat (8) begin
        #half_cycle;
    end
    func_sel = 3'b000; 
    repeat (2) begin
        repeat (512) begin
            #half_cycle;
        end
    end
    func_sel = 3'b001; 
    repeat (2) begin
        repeat (512) begin
            #half_cycle;
        end
    end
    func_sel = 3'b010; 
    repeat (2) begin
        repeat (512) begin
            #half_cycle;
        end
    end
    func_sel = 3'b011; 
    repeat (2) begin
        repeat (512) begin
            #half_cycle;
        end
    end
    func_sel = 3'b100; 
    repeat (2) begin
        repeat (512) begin
            #half_cycle;
        end
    end
    func_sel = 3'b101; 
    repeat (2) begin
        repeat (512) begin
            #half_cycle;
        end
    end
    repeat (200) begin
        #half_cycle;
    end
    $stop;
end

endmodule