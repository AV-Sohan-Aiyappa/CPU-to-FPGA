// tb_demus2x4.sv
// created by sohan on 16-03-2025
// Testbench for 2x4 DEMUX

module tb_demux2x4;
    reg in;
    reg [1:0] sel;
    wire y0, y1, y2, y3;

    demux2x4 uut (
        .in(in), .sel(sel), .y0(y0), .y1(y1), .y2(y2), .y3(y3)
    );

    initial begin
        $monitor("Time=%0t | in=%b sel=%b y0=%b y1=%b y2=%b y3=%b", $time, in, sel, y0, y1, y2, y3);
        in = 1;
        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;
        $finish;
    end
endmodule
