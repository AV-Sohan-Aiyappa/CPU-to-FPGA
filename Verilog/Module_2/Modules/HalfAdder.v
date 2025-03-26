/// HalfAdder.v
/// Created by Sohan on 26-03-2025
/// Computes the sum and carry of two 1-bit inputs using case statement

module HalfAdder(
    input a, b,
    output reg sum, carry
);
    always @(*) begin
        case ({a, b})
            2'b00: {carry, sum} = 2'b00;
            2'b01: {carry, sum} = 2'b01;
            2'b10: {carry, sum} = 2'b01;
            2'b11: {carry, sum} = 2'b10;
        endcase
    end
endmodule
