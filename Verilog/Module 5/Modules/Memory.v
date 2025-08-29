// Memory.v
// Created by sohan pn 29-08-2025
// Function: Combines RAM16K, Screen, and Keyboard into unified memory-mapped module.

module Memory (
    input         clk,
    input  [15:0] in,        // data input
    input  [14:0] address,   // memory address (0–24576)
    input         load,      // write enable
    output [15:0] out,       // data output
    // Screen and Keyboard external connections
    output [15:0] screen_out,
    input  [15:0] keyboard_in
);

    // Internal wires
    wire [15:0] ram_out, screen_mem_out, keyboard_out;
    wire ram_load, screen_load;

    // RAM16K (addresses 0–16383)
    assign ram_load    = load & (address < 15'd16384);

    RAM16K ram16k (
        .clk(clk),
        .in(in),
        .address(address[13:0]),
        .load(ram_load),
        .out(ram_out)
    );

    // Screen memory (16384–24575)
    assign screen_load = load & (address >= 15'd16384 && address < 15'd24576);

    Screen screen_mem (
        .clk(clk),
        .in(in),
        .address(address[12:0]), // 8K locations
        .load(screen_load),
        .out(screen_mem_out),
        .screen_out(screen_out)
    );

    // Keyboard (mapped to address 24576)
    assign keyboard_out = (address == 15'd24576) ? keyboard_in : 16'd0;

    // Output Mux
    assign out = (address < 15'd16384)  ? ram_out :
                 (address < 15'd24576)  ? screen_mem_out :
                                           keyboard_out;

endmodule
