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


reg     signed  [15:0]  sin, cos;

wire    signed  [8:0]   wave_signed;

always @(posedge clk, posedge rst) begin
    if (rst) begin
        sin = SIN_INIT;
        cos = COS_INIT;
    end
    else begin
        sin = sin + {{6{cos[15]}}, cos[15:6]};
        cos = cos - {{6{sin[15]}}, sin[15:6]};
    end
end

assign wave_signed = sin[15:8] + 8'd127;
assign wave = wave_signed[7:0];

endmodule