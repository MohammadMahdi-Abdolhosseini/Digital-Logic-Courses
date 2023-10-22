module top (
    clk,
    rst,
    start,
    vi_in,
    ui,
    done,
    wr_req,
    wr_data
);


input           clk;
input           rst;
input           start;
input   [4:0]   vi_in;
input   [1:0]   ui;

output          done;
output          wr_req;
output  [20:0]  wr_data;



wire            eng_start;
wire            eng_done;
wire            sh_en;
wire            ui_reg_ld;
wire            ld;


wire    [15:0]  vi;
wire    [15:0]  eng_x;
wire    [1:0]   intpart;
wire    [15:0]  fracpart;
wire    [1:0]   shift_comb_sel;

assign vi = {3'd0, vi_in, 8'd0};


wrapper_controller Controller1 (
    .clk(clk),
    .rst(rst),
    .start(start),
    .eng_done(eng_done),
    .done(done),
    .eng_start(eng_start),
    .sh_en(sh_en),
    .ui_reg_ld(ui_reg_ld),
    .ld(ld),
    .wr_req(wr_req)
);


shift_register ShiftRegister1 (
    .clk(clk),
    .rst(rst),
    .sh_en(sh_en),
    .ld(ld),
    .in(vi),
    .out(eng_x)
);

exponential Engine1
(
    .clk(clk),
    .rst(rst),
    .start(eng_start),
    .x(eng_x),
    .done(eng_done),
    .intpart(intpart),
    .fracpart(fracpart)
);


shift_comb ShiftComb1 (
    .in({intpart, fracpart}),
    .out(wr_data),
    .sel(shift_comb_sel)
);



ui_register Register1 (
    .clk(clk),
    .rst(rst),
    .ld(ui_reg_ld),
    .in(ui),
    .out(shift_comb_sel)
);


endmodule