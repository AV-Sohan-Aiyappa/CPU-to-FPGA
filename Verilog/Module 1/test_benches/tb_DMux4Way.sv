//tb_DMux4Way.sv
//Created by Sohan on 17-03-2025

module tb_DMux4Way;
    reg in;
    reg [1:0] sel;
    wire a, b, c, d;
    
    DMux4Way uut (.in(in), .sel(sel), .a(a), .b(b), .c(c), .d(d));
    
    initial begin
        in = 1;
        $monitor("sel=%b | outputs=%b%b%b%b", sel, a, b, c, d);
        sel = 2'b00; #10;
        sel = 2'b11; #10;
        $finish;
    end
endmodule
