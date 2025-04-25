/// RAM16K_tb.v
/// Created by Sohan on 18-04-2025
/// Testbench for RAM16K module

module RAM16K_tb;
    reg [15:0] in;
    reg load, clk;
    reg [13:0] address;
    wire [15:0] out;

    RAM16K uut (.in(in), .load(load), .address(address), .clk(clk), .out(out));

    initial begin
        clk = 0; load = 1; address = 14'b00000000101010;
        in = 16'hF00D;
        #5 clk = 1; #5 clk = 0;
        load = 0; in = 16'h0000;
        #5 clk = 1; #5 clk = 0;
        $display("Output: %h", out);
        $finish;
    end
endmodule
