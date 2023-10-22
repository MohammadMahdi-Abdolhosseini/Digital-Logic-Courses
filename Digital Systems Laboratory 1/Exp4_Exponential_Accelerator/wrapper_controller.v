module wrapper_controller (
    clk,
    rst,
    start,
    eng_done,
    done,
    eng_start,
    sh_en,
    ui_reg_ld,
    ld,
    wr_req
);


input               clk;
input               rst;
input               start;
input               eng_done;

output  reg         done;
output  reg         eng_start;
output  reg         sh_en;
output  reg         ui_reg_ld;
output  reg         ld;
output  reg         wr_req;


localparam  
    idle = 3'd0,
    wait_start_clear = 3'd1,
    init = 3'd2,
    start_eng = 3'd3,
    wait_eng = 3'd4,
    check_count = 3'd5,
    init_next = 3'd6;



reg [2:0] ps, ns;


wire cnt_co;
reg cnt_clr, cnt_en;

controller_counter C1 (
    .clk(clk),
    .rst(rst),
    .clr(cnt_clr),
    .en(cnt_en),
    .co(cnt_co)
);

always @(posedge clk, posedge rst) begin
	if (rst == 1'b1) begin
		ps <= idle;
	end
	else begin
		ps <= ns;
	end
end


always @(*) begin
    case (ps)
        idle:
            ns <= start ? wait_start_clear : idle;
        wait_start_clear:
            ns <= start ? wait_start_clear : init;
        init:
            ns <= start_eng;
        start_eng:
            ns <= wait_eng;
        wait_eng:
            ns <= eng_done ? check_count : wait_eng;
        check_count:
            ns <= cnt_co ? idle : init_next;
        init_next:
            ns <= start_eng;
        default:
            ns <= idle;
    endcase
end


always @(*) begin 
    {done, cnt_clr, ld, ui_reg_ld, cnt_en, sh_en, eng_start, wr_req} = 8'd0;
    case (ps)
        idle: begin
            done = 1'b1;
        end
        init: begin
            cnt_clr = 1'b1;
            ld = 1'b1;
            ui_reg_ld = 1'b1;
        end
        start_eng: begin
            eng_start = 1'b1;
        end
        check_count: begin
            wr_req = 1'b1;
        end
        init_next: begin
            cnt_en = 1'b1;
            sh_en = 1'b1;
        end
    endcase
end
endmodule
