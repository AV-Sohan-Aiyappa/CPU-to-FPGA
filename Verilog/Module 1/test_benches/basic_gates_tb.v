
//basic_gates_tb
// created by Sohan
// Testbench for Basic Logic Gates



module basic_gates_tb;

    
    reg a, b;
    wire nand_out, and_out, or_out, not_out, xor_out, nor_out;

    
    basic_gates uut (
        .a(a),
        .b(b),
        .nand_out(nand_out),
        .and_out(and_out),
        .or_out(or_out),
        .not_out(not_out),
        .xor_out(xor_out),
        .nor_out(nor_out)
    );

    
    initial begin
        $display("A B | NAND AND OR NOT XOR NOR");
        $display("-----------------------------");

        // Loop through all combinations of a and b
        a = 0; b = 0; #10;
        $display("%b %b |  %b    %b   %b  %b   %b   %b", a, b, nand_out, and_out, or_out, not_out, xor_out, nor_out);

        a = 0; b = 1; #10;
        $display("%b %b |  %b    %b   %b  %b   %b   %b", a, b, nand_out, and_out, or_out, not_out, xor_out, nor_out);

        a = 1; b = 0; #10;
        $display("%b %b |  %b    %b   %b  %b   %b   %b", a, b, nand_out, and_out, or_out, not_out, xor_out, nor_out);

        a = 1; b = 1; #10;
        $display("%b %b |  %b    %b   %b  %b   %b   %b", a, b, nand_out, and_out, or_out, not_out, xor_out, nor_out);

        $finish;
    end

endmodule
