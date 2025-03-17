// tb_Mux4Way16.sv
// Testbench for Mux4Way16
//Created by Sohan on 16-03-2025

module tb_Mux4Way16;
    reg [15:0] a, b, c, d;
    reg [1:0] sel;
    wire [15:0] out;
    
    Mux4Way16 uut (.a(a), .b(b), .c(c), .d(d), .sel(sel), .out(out));
    
    initial begin
        a = 16'hAAAA; b = 16'h5555; c = 16'hF0F0; d = 16'h0F0F;
        $monitor("sel=%b | out=%h", sel, out);
        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;
        $finish;
    end
endmodule
