//Bit
// created by Sohan on 18-04-2025
// A single bit storage with load control

module Bit (
    input in,
    input load,
    input clk,
    output reg out
);
    always @(posedge clk) begin
        if (load)
            out <= in;
    end
endmodule
