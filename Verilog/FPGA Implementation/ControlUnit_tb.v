// ControlUnit_tb.v
// Testbench for Hack ControlUnit

`timescale 1ns/1ps

module HackControlUnit_tb;

  reg  [15:0] sw;
  wire [15:0] led;

  // Instantiate DUT
  HackControlUnit uut (
    .sw(sw),
    .led(led)
  );

  initial begin
    $monitor("time=%0t | sw=%b | led=%b",
             $time, sw, led);

    // Test 1: A-instruction (e.g. @21 = 0000000000010101)
    sw = 16'b0000000000010101;
    #10;

    // Test 2: C-instruction, AND comp (1110xx0000000)
    // e.g. 1110 0000 0000 0000
    sw = 16'b1110000000000000;
    #10;

    // Test 3: C-instruction, ADD comp (1110xx0110000)
    // (zx=0 nx=0 zy=0 ny=0 f=1 no=0)
    sw = 16'b1110110000000000;
    #10;

    // Test 4: C-instruction with dest bits set (A,D,M)
    sw = 16'b1110111111111000;  // comp=ADD, dest=ADM
    #10;

    // Test 5: C-instruction with jump (JGT)
    sw = 16'b1110110000000001;  // comp=ADD, jump=JGT
    #10;

    $finish;
  end

endmodule
