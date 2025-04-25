/// HalfAdder_tb.v
/// Created by Sohan on 26-03-2025
/// Testbench for HalfAdder using case statement


module HalfAdder_tb;

    reg a, b;
    wire sum, carry;

    HalfAdder uut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    initial begin
        $display("A B | Sum Carry");
        $display("----------------");

        a = 0; b = 0; #10;
        $display("%b %b |  %b    %b", a, b, sum, carry);

        a = 0; b = 1; #10;
        $display("%b %b |  %b    %b", a, b, sum, carry);

        a = 1; b = 0; #10;
        $display("%b %b |  %b    %b", a, b, sum, carry);

        a = 1; b = 1; #10;
        $display("%b %b |  %b    %b", a, b, sum, carry);

        $finish;
    end

endmodule
