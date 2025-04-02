
module ALU_tb;
    reg [15:0] x, y;
    reg zx, nx, zy, ny, f, no;
    wire [15:0] out;
    wire zr, ng;
    
    ALU uut (
        .x(x), .y(y), .zx(zx), .nx(nx), .zy(zy), .ny(ny), .f(f), .no(no),
        .out(out), .zr(zr), .ng(ng)
    );

    initial begin
        
        $dumpfile("alu_tb.vcd");  
        $dumpvars(0, ALU_tb);
        
        
        $monitor("x=%b, y=%b, zx=%b, nx=%b, zy=%b, ny=%b, f=%b, no=%b -> out=%b, zr=%b, ng=%b", 
                 x, y, zx, nx, zy, ny, f, no, out, zr, ng);
        
        x = 16'b0000000000000000; y = 16'b0000000000000000; zx = 1; nx = 0; zy = 1; ny = 0; f = 1; no = 0;
        #10;
        
        x = 16'b1111111111111111; y = 16'b0000000000000001; zx = 0; nx = 0; zy = 0; ny = 0; f = 1; no = 0;
        #10;
        
        x = 16'b0000000000000111; y = 16'b0000000000000001; zx = 0; nx = 0; zy = 0; ny = 0; f = 1; no = 0;
        #10;
        
        x = 16'b0000000000000111; y = 16'b0000000000000001; zx = 0; nx = 0; zy = 0; ny = 0; f = 1; no = 1;
        #10;
        
        x = 16'b0000000000000111; y = 16'b0000000000000001; zx = 0; nx = 0; zy = 0; ny = 0; f = 0; no = 0;
        #10;
        
        x = 16'b0000000000000111; y = 16'b0000000000000001; zx = 0; nx = 0; zy = 0; ny = 0; f = 0; no = 1;
        #10;
        
        $finish;
    end
endmodule
