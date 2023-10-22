module seven_seg_disp (
    pin,
    seg0, seg1, seg2, seg3, seg4, seg5, seg6
);
input           [3:0]   pin;
output                  seg0, seg1, seg2, seg3, seg4, seg5, seg6;

reg             [6:0]   seg;

always @(seg) begin
    case (pin)
    4'h0: seg = 7'b100_0000;
    4'h1: seg = 7'b111_1001;
    4'h2: seg = 7'b010_0100;
    4'h3: seg = 7'b011_0000;
    4'h4: seg = 7'b001_1001;
    4'h5: seg = 7'b001_0010;
    4'h6: seg = 7'b000_0010;
    4'h7: seg = 7'b111_1000;
    4'h8: seg = 7'b000_0000;
    4'h9: seg = 7'b001_0000;
    4'hA: seg = 7'b000_1000;
    4'hB: seg = 7'b000_0011;
    4'hC: seg = 7'b100_0110;
    4'hD: seg = 7'b010_0001;
    4'hE: seg = 7'b000_0110;
    4'hF: seg = 7'b000_1110;
    endcase
end

assign {seg6, seg5, seg4, seg3, seg2, seg1, seg0} = seg;

endmodule