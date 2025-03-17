//tb_Logic16.sv
//Created by Sohan on 16-03-2024
// 16-bit AND , OR and NOT gates

module tb_Logic16;
    reg [15:0] a, b;
    wire [15:0] not_out, and_out, or_out;
    
    Logic16 uut (.a(a), .b(b), .not_out(not_out), .and_out(and_out), .or_out(or_out));
    
    initial begin
        $monitor("a=%h b=%h | NOT a=%h AND=%h OR=%h", a, b, not_out, and_out, or_out);
        a = 16'hFFFF; b = 16'h0000; #10;
        a = 16'hAAAA; b = 16'h5555; #10;
        a = 16'h0F0F; b = 16'hF0F0; #10;
        $finish;
    end
endmodule
