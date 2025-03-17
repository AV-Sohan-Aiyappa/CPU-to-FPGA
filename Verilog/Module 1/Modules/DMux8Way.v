//  DMux8Way.v
// Created by Soohan on 17-03-2025


module DMux8Way(input in, input [2:0] sel, output reg a, b, c, d, e, f, g, h);
    always @(*) begin
        case(sel)
            3'b000: {a, b, c, d, e, f, g, h} = 8'b10000000;
            3'b001: {a, b, c, d, e, f, g, h} = 8'b01000000;
            3'b010: {a, b, c, d, e, f, g, h} = 8'b00100000;
            3'b011: {a, b, c, d, e, f, g, h} = 8'b00010000;
            3'b100: {a, b, c, d, e, f, g, h} = 8'b00001000;
            3'b101: {a, b, c, d, e, f, g, h} = 8'b00000100;
            3'b110: {a, b, c, d, e, f, g, h} = 8'b00000010;
            3'b111: {a, b, c, d, e, f, g, h} = 8'b00000001;
        endcase
    end
endmodule
