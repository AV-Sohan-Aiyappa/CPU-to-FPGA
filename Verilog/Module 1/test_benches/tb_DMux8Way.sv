// tb_DMux8Way.sv
// created by Sohan on 17-03-2025

module tb_DMux8Way;
    reg in;
    reg [2:0] sel;
    wire a, b, c, d, e, f, g, h;
    
    DMux8Way uut (.in(in), .sel(sel), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .h(h));
    
    initial begin
        in = 1;
        $monitor("sel=%b | outputs=%b%b%b%b%b%b%b%b", sel, a, b, c, d, e, f, g, h);
        sel = 3'b000; #10;
        sel = 3'b101; #10;
        sel = 3'b111; #10;
        $finish;
    end
endmodule
