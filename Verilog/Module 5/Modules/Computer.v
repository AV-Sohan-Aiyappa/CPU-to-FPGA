// Computer.v
// Created by sohan on 29-08-2025
// Function: Complete HACK computer system with CPU, Memory, and ROM.

module Computer (
    input clk,
    input reset,
    input [15:0] keyboard_in,
    output [15:0] screen_out
);

    wire [14:0] pc;
    wire [15:0] instruction, inM, outM;
    wire [14:0] addressM;
    wire writeM;

    // Instruction ROM (contains program)
    ROM32K rom (
        .address(pc),
        .out(instruction)
    );

    // Memory (RAM16K + Screen + Keyboard)
    Memory memory (
        .clk(clk),
        .in(outM),
        .address(addressM),
        .load(writeM),
        .out(inM),
        .screen_out(screen_out),
        .keyboard_in(keyboard_in)
    );

    // CPU
    CPU cpu (
        .clk(clk),
        .inM(inM),
        .instruction(instruction),
        .reset(reset),
        .outM(outM),
        .addressM(addressM),
        .writeM(writeM),
        .pc(pc)
    );

endmodule
