module sine_wave_gen (
    clk,
    rst,
    cnt_val,
    cnt_cout,
    wave
);

localparam N = 16;
localparam SIN_INIT = 16'd0;
localparam COS_INIT = 16'd30000;

input                   clk;
input                   rst;
input           [7:0]   cnt_val;
input                   cnt_cout;
output          [7:0]   wave;

wire    signed  [15:0]  sin_in, sin_out, new_sin; 
wire    signed  [15:0]  cos_in, cos_out, new_cos;

wire    signed  [8:0]   wave_signed;

register 
# (
    .N(N)
)
sin_reg
(
    .clk(clk),
    .rst(rst),
    .in(sin_in),
    .out(sin_out)
);

register
# (
    .N(N)
)
cos_reg
(
    .clk(clk),
    .rst(rst),
    .in(cos_in),
    .out(cos_out)
);

mux_2 
#(
    .N(N)
)
sin_mux
(
    .a(new_sin),
    .b(SIN_INIT),
    .sel(rst),
    .out(sin_in)
);

mux_2 
#(
   .N(N)
)
cos_mux
(
    .a(new_cos),
    .b(COS_INIT),
    .sel(rst),
    .out(cos_in)
);

assign new_sin = sin_out + ({{6{cos_out[15]}}, cos_out[15:6]});
// assign new_sin = sin_out + (cos_out >>> 6);
assign new_cos = cos_out - ({{6{new_sin[15]}}, new_sin[15:6]});
// assign new_cos = cos_out - ((sin_out + (cos_out >>> 6)) >>> 6);

assign wave_signed = sin_out[15:8] + 8'd127;
assign wave = wave_signed[7:0];

endmodule