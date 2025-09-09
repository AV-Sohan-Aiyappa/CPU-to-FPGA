//ALU.v
//Created by Sohan
//4-bit ALU for FPGA , opcodes: f,no,zx,zy,nx,ny


module ALU (
    input [3:0] x, y,
    input zx, nx, zy, ny, f, no,
    output reg [3:0] out,
    output reg zr, ng
);
    wire [3:0] x1, x2, xFinal;
  wire [3:0] y1, y2, yFinal;
  wire [3:0] addOut, andOut, aluOut, aluOutNeg;
    wire or8a, or8b, orFinal;
    
    assign x1 = zx ? 4'b0 : x;
    assign x2 = ~x1;
    assign xFinal = nx ? x2 : x1;
    
    assign y1 = zy ? 4'b0 : y;
    assign y2 = ~y1;
    assign yFinal = ny ? y2 : y1;
    
    assign addOut = xFinal + yFinal;
    assign andOut = xFinal & yFinal;
    assign aluOut = f ? addOut : andOut;
    assign aluOutNeg = ~aluOut;
    
    always @(*) begin
        out = no ? aluOutNeg : aluOut;
      zr = (out == 4'b0) ? 1 : 0;
      ng = out[3]; 
    end

endmodule
