/// FullAdder_tb.v
/// Created by Sohan on 26-03-2025
/// Testbench for FullAdder using case statement

module FullAdder_tb;

    // Testbench signals
    reg a, b, cin;
    wire sum, carry;

    // Instantiate the FullAdder module
    FullAdder uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .carry(carry)
    );

    initial begin
        $display("A B Cin | Sum Carry");
        $display("-------------------");

        a = 0; b = 0; cin = 0; #10;
        $display("%b %b  %b  |  %b    %b", a, b, cin, sum, carry);

        a = 0; b = 0; cin = 1; #10;
        $display("%b %b  %b  |  %b    %b", a, b, cin, sum, carry);

        a = 0; b = 1; cin = 0; #10;
        $display("%b %b  %b  |  %b    %b", a, b, cin, sum, carry);

        a = 0; b = 1; cin = 1; #10;
        $display("%b %b  %b  |  %b    %b", a, b, cin, sum, carry);

        a = 1; b = 0; cin = 0; #10;
        $display("%b %b  %b  |  %b    %b", a, b, cin, sum, carry);

        a = 1; b = 0; cin = 1; #10;
        $display("%b %b  %b  |  %b    %b", a, b, cin, sum, carry);

        a = 1; b = 1; cin = 0; #10;
        $display("%b %b  %b  |  %b    %b", a, b, cin, sum, carry);

        a = 1; b = 1; cin = 1; #10;
        $display("%b %b  %b  |  %b    %b", a, b, cin, sum, carry);

        $finish;
    end

endmodule
