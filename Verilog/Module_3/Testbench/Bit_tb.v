/// Bit_tb.v
/// Created by Sohan on 18-04-2025
/// Testbench for Bit module

module Bit_tb;
    reg in, load, clk;
    wire out;

    Bit uut (.in(in), .load(load), .clk(clk), .out(out));

    initial begin
        $display("Time\tin\tload\tout");
        clk = 0; in = 0; load = 0;
        #5 in = 1; load = 1;
        #5 clk = 1; #5 clk = 0;
        #5 in = 0; load = 0;
        #5 clk = 1; #5 clk = 0;
        $finish;
    end
endmodule
