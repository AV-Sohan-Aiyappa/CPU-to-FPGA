/// Register_tb.v
/// Created by Sohan on 18-04-2025
/// Testbench for Register module

module Register_tb;
    reg [15:0] in;
    reg load, clk;
    wire [15:0] out;

    Register uut (.in(in), .load(load), .clk(clk), .out(out));

    initial begin
        clk = 0; in = 16'hAAAA; load = 1;
        #5 clk = 1; #5 clk = 0;
        in = 16'h5555; load = 0;
        #5 clk = 1; #5 clk = 0;
        $finish;
    end
endmodule
