/// RAM8_tb.v
/// Created by Sohan on 18-04-2025
/// Testbench for RAM8 module

module RAM8_tb;
    reg [15:0] in;
    reg load, clk;
    reg [2:0] address;
    wire [15:0] out;

    RAM8 uut (.in(in), .load(load), .address(address), .clk(clk), .out(out));

    initial begin
        clk = 0; load = 1;
        in = 16'h1234; address = 3'b010;
        #5 clk = 1; #5 clk = 0;
        load = 0; in = 16'h0000;
        #5 clk = 1; #5 clk = 0;
        address = 3'b010;
        #5 $display("Output: %h", out);
        $finish;
    end
endmodule
