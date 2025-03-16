// tb_mux2x2.sv
// created by Sohan on 15-03-2025
// Testbench for 4x2 MUX

module tb_mux4x2;
    reg a, b, c, d;
    reg [1:0] sel;
    wire y;

    mux4x2 uut (
        .a(a), .b(b), .c(c), .d(d), .sel(sel), .y(y)
    );

    initial begin
        $monitor("Time=%0t | a=%b b=%b c=%b d=%b sel=%b y=%b", $time, a, b, c, d, sel, y);
        a = 0; b = 1; c = 0; d = 1;
        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;
        $finish;
    end
endmodule
