module RAM64_tb;
    reg [15:0] in;
    reg load, clk;
    reg [5:0] address;
    wire [15:0] out;

    RAM64 uut (.in(in), .load(load), .address(address), .clk(clk), .out(out));

    initial begin
        clk = 0; load = 1; address = 6'b001010;
        in = 16'hBEEF;
        #5 clk = 1; #5 clk = 0;
        load = 0; in = 16'h0000;
        #5 clk = 1; #5 clk = 0;
        #5 $display("Output: %h", out);
        $finish;
    end
endmodule
