// CPU.v
// Created by sohan on 29-08-2025
// Function: Executes HACK instructions using ALU, A, D, and PC.

module CPU (
    input         clk,
    input  [15:0] inM,         // M value input (from Memory[addressM])
    input  [15:0] instruction, // current instruction
    input         reset,       // active-high reset
    output [15:0] outM,        // data to write to M
    output [14:0] addressM,    // memory address
    output        writeM,      // memory write enable
    output [14:0] pc           // program counter
);

    // Instruction fields
    wire isC = instruction[15]; // 0 = A-instr, 1 = C-instr

    // A and D registers
    reg [15:0] A, D;

    // ALU connections
    wire [15:0] alu_out;
    wire zr, ng;

    ALU alu (
        .x(D),
        .y(instruction[12] ? inM : A),
        .zx(instruction[11]),
        .nx(instruction[10]),
        .zy(instruction[9]),
        .ny(instruction[8]),
        .f(instruction[7]),
        .no(instruction[6]),
        .out(alu_out),
        .zr(zr),
        .ng(ng)
    );

    // Output assignments
    assign outM    = alu_out;
    assign addressM = A[14:0];
    assign writeM   = isC & instruction[3];

    // Sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            A <= 16'd0;
            D <= 16'd0;
        end else begin
            if (!isC) begin
                // A-instruction
                A <= instruction;
            end else begin
                // C-instruction destination
                if (instruction[5]) A <= alu_out;
                if (instruction[4]) D <= alu_out;
            end
        end
    end

    // Program counter
    wire pc_load;
    assign pc_load = isC & (
        (instruction[2] & (alu_out[15] == 1)) | // negative
        (instruction[1] & (alu_out == 0))    | // zero
        (instruction[0] & (alu_out[15] == 0 && alu_out != 0)) // positive
    );

    PC pc_reg (
        .clk(clk),
        .in(A[14:0]),
        .load(pc_load),
        .inc(1'b1),
        .reset(reset),
        .out(pc)
    );

endmodule
