module seven_seg_disp (pin, segout);
input           [3:0]   pin;
output  reg     [6:0]   segout;

always @(segout) begin
    case (pin)
    4'h0: segout = 7'b100_0000;
    4'h1: segout = 7'b111_1001;
    4'h2: segout = 7'b010_0100;
    4'h3: segout = 7'b011_0000;
    4'h4: segout = 7'b001_1001;
    4'h5: segout = 7'b001_0110;
    4'h6: segout = 7'b000_0010;
    4'h7: segout = 7'b111_1000;
    4'h8: segout = 7'b000_0000;
    4'h9: segout = 7'b001_0000;
    4'hA: segout = 7'b000_1000;
    4'hB: segout = 7'b000_0011;
    4'hC: segout = 7'b100_0110;
    4'hD: segout = 7'b010_0001;
    4'hE: segout = 7'b000_0110;
    4'hF: segout = 7'b000_1110;
    endcase
end

endmodule