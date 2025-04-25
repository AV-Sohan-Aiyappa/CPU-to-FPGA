//Register
// created by Sohan on 18-04-2025
// A 16-bit register built from 16 Bit modules

module Register (
    input [15:0] in,
    input load,
    input clk,
    output [15:0] out
);
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : bits
            Bit b (.in(in[i]), .load(load), .clk(clk), .out(out[i]));
        end
    endgenerate
endmodule
