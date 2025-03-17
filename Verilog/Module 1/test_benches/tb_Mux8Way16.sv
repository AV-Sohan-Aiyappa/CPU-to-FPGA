//tb_Mux8Way16.sv
// Created by Sohan on 17-03-2025

module tb_Mux8Way16;
    reg [15:0] a, b, c, d, e, f, g, h;
    reg [2:0] sel;
    wire [15:0] out;
    
    Mux8Way16 uut (.a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .h(h), .sel(sel), .out(out));
    
    initial begin
        a = 16'h0001; b = 16'h0002; c = 16'h0004; d = 16'h0008;
        e = 16'h0010; f = 16'h0020; g = 16'h0040; h = 16'h0080;
        $monitor("sel=%b | out=%h", sel, out);
        sel = 3'b000; #10;
        sel = 3'b011; #10;
        sel = 3'b111; #10;
        $finish;
    end
endmodule
