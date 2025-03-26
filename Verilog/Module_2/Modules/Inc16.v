/// Inc16.v
/// Created by Sohan on 26-03-2025
/// Increments a 16-bit value by 1 using case statement

module Inc16(
    input [15:0] in,
    output reg [15:0] out
);
    always @(*) begin
        case (1'b1)
            1'b1: out = in + 1;
        endcase
    end
endmodule
