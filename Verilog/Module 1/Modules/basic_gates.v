//basic_gates
// created by Sohan
// Basic Logic Gates



module basic_gates(
    input wire a, b,
    output wire nand_out, and_out, or_out, not_out, xor_out, nor_out
);
    assign nand_out = ~(a & b);
    assign and_out = a & b;
    assign or_out = a | b;
    assign not_out = ~a;
    assign xor_out = a ^ b;
    assign nor_out = ~(a | b);
endmodule
