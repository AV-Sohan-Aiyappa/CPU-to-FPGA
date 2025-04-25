/// RAM4K_tb.v
/// Created by Sohan on 18-04-2025
/// Testbench for RAM4K module

module RAM4K_tb;
    reg [15:0] in;
    reg load, clk;
    reg [11:0] address;
    wire [15:0] out;

    RAM4K uut (.in(in), .load(load), .address(address), .clk(clk), .out(out));

    initial begin
        clk = 0; load = 1; address = 12'b000000101010;
        in = 16'hC0DE;
        #5 clk = 1; #5 clk = 0;
        load = 0; in = 16'h0000;
        #5 clk = 1; #5 clk = 0;
        $display("Output: %h", out);
        $finish;
    end
endmodule
