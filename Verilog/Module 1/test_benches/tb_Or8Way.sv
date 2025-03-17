// tb_Or8Way.sv
// Created by SOhan on 16-03-2025

module tb_Or8Way;
    reg [7:0] in;
    wire out;
    
    Or8Way uut (.in(in), .out(out));
    
    initial begin
        $monitor("in=%b | out=%b", in, out);
        in = 8'b00000000; #10;
        in = 8'b00001000; #10;
        in = 8'b11111111; #10;
        $finish;
    end
endmodule
