//tb_Mux16.sv
//created by Sohan on 16-03-2025

module tb_Mux16;
    reg [15:0] a, b;
    reg sel;
    wire [15:0] out;
    
    Mux16 uut (.a(a), .b(b), .sel(sel), .out(out));
    
    initial begin
        $monitor("a=%h b=%h sel=%b | out=%h", a, b, sel, out);
        a = 16'hAAAA; b = 16'h5555; sel = 0; #10;
        sel = 1; #10;
        $finish;
    end
endmodule
