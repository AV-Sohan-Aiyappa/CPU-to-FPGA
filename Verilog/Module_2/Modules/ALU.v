module ALU (
    input [15:0] x, y,
    input zx, nx, zy, ny, f, no,
    output reg [15:0] out,
    output reg zr, ng
);
    wire [15:0] x1, x2, xFinal;
    wire [15:0] y1, y2, yFinal;
    wire [15:0] addOut, andOut, aluOut, aluOutNeg;
    wire or8a, or8b, orFinal;
    
    assign x1 = zx ? 16'b0 : x;
    assign x2 = ~x1;
    assign xFinal = nx ? x2 : x1;
    
    assign y1 = zy ? 16'b0 : y;
    assign y2 = ~y1;
    assign yFinal = ny ? y2 : y1;
    
    assign addOut = xFinal + yFinal;
    assign andOut = xFinal & yFinal;
    assign aluOut = f ? addOut : andOut;
    assign aluOutNeg = ~aluOut;
    
    always @(*) begin
        out = no ? aluOutNeg : aluOut;
        zr = (out == 16'b0) ? 1 : 0;
        ng = out[15]; 
    end

endmodule
