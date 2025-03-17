// Mux4way16.v
// Created by Sohan on 17-03-2025

module Mux4way16(input [15:0] a, b, c, d, input [1:0] sel, output [15:0] out);
    assign out = (sel == 2'b00) ? a :
                 (sel == 2'b01) ? b :
                 (sel == 2'b10) ? c : d;
endmodule
