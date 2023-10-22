`timescale 1ns/1ns
module top_tb;


reg 	clk;
reg 	rst;

reg 	[2:0] freq_sel;
reg 	[1:0] amplitude_sel;
reg 	[2:0] wave_sel;
reg     [1:0] phase_sel;

wire 	freq_sel_out;
wire 	cnt_co;
wire 	[7:0]   amplitude_seletor_out;
wire 	[7:0]   cnt_val;
wire 	[7:0]   dds_wave;
wire 	[7:0]   mux_out;
wire 	[7:0]   reciprocal_out;
wire 	[7:0]   sine_full_rectified_out;
wire 	[7:0]   sine_half_rectified_out;
wire 	[7:0]   sine_out;
wire 	[7:0]   square_out;
wire 	[7:0]   triangle_out;
wire            pwm_converter_out;
wire    [7:0]   rom_reg_out;
wire    [7:0]   rom_reg_in;




localparam half_cycle = 10;


top UUT (
	.freq_sel_out(freq_sel_out),
	.clk(clk),
	.rst(rst),
	.freq_sel(freq_sel),
	.cnt_co(cn_co),
	.amplitude_seletor_out(amplitude_seletor_out),
	.amplitude_sel(amplitude_sel),
	.wave_sel(wave_sel),
	.cnt_val(cnt_val),
	.dds_wave(dds_wave),
	.mux_out(mux_out),
	.reciprocal_out(reciprocal_out),
	.sine_full_rectified_out(sine_full_rectified_out),
	.sine_half_rectified_out(sine_half_rectified_out),
	.sine_out(sine_out),
	.square_out(square_out),
	.triangle_out(triangle_out),
    .pwm_converter_out(pwm_converter_out),
    .rom_reg_out(rom_reg_out),
    .rom_reg_in(rom_reg_in)
);



always begin
    #half_cycle
    clk = 1'b0;
    #half_cycle
    clk = 1'b1;
end

initial begin
    #half_cycle
    rst = 1'b1;
    repeat (4) begin
        #half_cycle;
    end
    rst = 1'b0;
    repeat (4) begin
        #half_cycle;
    end
    rst = 1'b1;
end

initial begin
    freq_sel = 3'b110;
    amplitude_sel = 2'd1;
    wave_sel = 3'd3;
    phase_sel = 2'b0;

    repeat (50) begin
        repeat (512) begin
            #half_cycle;
        end
    end
    freq_sel = 3'd7;
    repeat (50) begin
        repeat (512) begin
            #half_cycle;
        end
    end
    amplitude_sel = 2'd0;
    repeat (50) begin
        repeat (512) begin
            #half_cycle;
        end
    end
    wave_sel = 3'd0;
    repeat (50) begin
        repeat (512) begin
            #half_cycle;
        end
    end
    wave_sel = 3'd1;
    repeat (50) begin
        repeat (512) begin
            #half_cycle;
        end
    end
    wave_sel = 3'd2;
    repeat (50) begin
        repeat (512) begin
            #half_cycle;
        end
    end
    wave_sel = 3'd4;
    repeat (50) begin
        repeat (512) begin
            #half_cycle;
        end
    end
    wave_sel = 3'd5;
    repeat (50) begin
        repeat (512) begin
            #half_cycle;
        end
    end
    // wave_sel = 3'd6;
    // repeat (50) begin
    //     repeat (512) begin
    //         #half_cycle;
    //     end
    // end
    // phase_sel = 2'd3;
    repeat (100) begin
        repeat (512) begin
            #half_cycle;
        end
    end
    $stop;
end
endmodule