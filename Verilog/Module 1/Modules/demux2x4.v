// 2x4 DEMUX
// Created by Sohan on 13-03-2025
// This is a 2x4 DEMUX with two select lines, one input, and four outputs

module demux2x4(
    input wire in,
    input wire [1:0] sel,
    output reg y0, y1, y2, y3
);

    always @(*) begin
        y0 = 0;
        y1 = 0;
        y2 = 0;
        y3 = 0;
        
        case(sel)
            2'b00: y0 = in;
            2'b01: y1 = in;
            2'b10: y2 = in;
            2'b11: y3 = in;
        endcase
    end
endmodule
