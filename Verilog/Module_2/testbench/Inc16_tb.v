/// Inc16_tb.v
/// Created by Sohan on 26-03-2025
/// Testbench for Inc16 module which increments a 16-bit input by 1


module Inc16_tb;

    reg [15:0] in;
    wire [15:0] out;

    Inc16 uut (
        .in(in),
        .out(out)
    );

    initial begin
        $display("Input              | Output");
        $display("------------------|------------------");

        in = 16'h0000; #10;
        $display("%b | %b", in, out);

        in = 16'h0001; #10;
        $display("%b | %b", in, out);

        in = 16'h00FF; #10;
        $display("%b | %b", in, out);

        in = 16'h0F0F; #10;
        $display("%b | %b", in, out);

        in = 16'hFFFF; #10;
        $display("%b | %b", in, out);

        $finish;
    end

endmodule
