// ALU_tb.v
// Testbench for 4-bit ALU

`timescale 1ns/1ps

module ALU_tb;

  reg [3:0] x, y;
  reg zx, nx, zy, ny, f, no;
  wire [3:0] out;
  wire zr, ng;

  // Instantiate ALU
  ALU uut (
    .x(x), .y(y),
    .zx(zx), .nx(nx), .zy(zy), .ny(ny), .f(f), .no(no),
    .out(out), .zr(zr), .ng(ng)
  );

  initial begin
    $monitor("time=%0t | x=%b y=%b zx=%b nx=%b zy=%b ny=%b f=%b no=%b | out=%b zr=%b ng=%b",
              $time, x, y, zx, nx, zy, ny, f, no, out, zr, ng);

    // Test 1: AND
    x=4'b1010; y=4'b1100;
    zx=0; nx=0; zy=0; ny=0; f=0; no=0;
    #10;

    // Test 2: ADD
    x=4'b0011; y=4'b0101;
    zx=0; nx=0; zy=0; ny=0; f=1; no=0;
    #10;

    // Test 3: Zero
    x=4'b1111; y=4'b1111;
    zx=1; nx=0; zy=1; ny=0; f=1; no=0;
    #10;

    // Test 4: Negation
    x=4'b0110; y=4'b0011;
    zx=0; nx=0; zy=0; ny=0; f=1; no=1;
    #10;

    $finish;
  end

endmodule

