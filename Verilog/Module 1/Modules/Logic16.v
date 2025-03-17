// Logic16.v
// Created by Soohan on 16-03-2025
// 16-bit AND , OR and NOT gates 

module Logic16(
    input [15:0] a, b,
    output [15:0] not_out, and_out, or_out
);
    assign not_out = ~a;
    assign and_out = a & b;
    assign or_out = a | b;
endmodule
