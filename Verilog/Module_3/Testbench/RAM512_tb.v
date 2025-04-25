/// RAM512_tb.v
/// Created by Sohan on 18-04-2025
/// Testbench for RAM512 module

module RAM512_tb;
    reg [15:0] in;
    reg load, clk;
    reg [8:0] address;
    wire [15:0] out;

    RAM512 uut (.in(in), .load(load), .address(address), .clk(clk), .out(out));

    initial begin
        clk = 0; load = 1; address = 9'b000101010;
        in = 16'hDEAD;
        #5 clk = 1; #5 clk = 0;
        load = 0; in = 16'h0000;
        #5 clk = 1; #5 clk = 0;
        $display("Output: %h", out);
        $finish;
    end
endmodule
