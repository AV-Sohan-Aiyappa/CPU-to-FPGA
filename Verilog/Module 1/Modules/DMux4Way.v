// DMux4Way.v
// Created by Soohan on 17-03-2025


module DMux4Way(input in, input [1:0] sel, output reg a, b, c, d);
    always @(*) begin
        case(sel)
            2'b00: {a, b, c, d} = 4'b1000;
            2'b01: {a, b, c, d} = 4'b0100;
            2'b10: {a, b, c, d} = 4'b0010;
            2'b11: {a, b, c, d} = 4'b0001;
        endcase
    end
endmodule
