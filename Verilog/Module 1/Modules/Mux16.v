// Mux16.v
// created by sohan on 16-03-2025
//16-bit MUX

module Mux16(input [15:0] a, b, input sel, output [15:0] out);
    assign out = sel ? b : a;
endmodule
