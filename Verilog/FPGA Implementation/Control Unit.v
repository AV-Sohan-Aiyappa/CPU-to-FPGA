// HackControlVisualizerTop.v
// Shows Hack CPU control signals for a 16-bit opcode on Basys3 LEDs.
// SW[15:0]  = instruction opcode
// btnU = zr flag, btnD = ng flag (since ALU is not instantiated)

module HackControlVisualizerTop(
    input  [15:0] sw,     // instruction
    input         btnU,   // zr flag (1 = zero)
    input         btnD,   // ng flag (1 = negative)
    output [15:0] led     // control signals visualized
);
    wire isC = sw[15];

    // ALU control bits (Hack ISA comp field)
    wire zx = sw[11];
    wire nx = sw[10];
    wire zy = sw[9];
    wire ny = sw[8];
    wire  f = sw[7];
    wire no = sw[6];

    // mux selects
    wire selY = sw[12];   // 0:A, 1:inM
    wire selA = sw[15];   // 0:instruction, 1:aluOut

    // destination controls (only on C-instructions)
    wire loadA   = (~isC) | (isC & sw[5]);   // A-instr always loads A; C-instr loads A if dest A
    wire loadD   =  isC & sw[4];
    wire writeM  =  isC & sw[3];

    // jump / PC load
    // j2 j1 j0 = sw[2:0] == {JLT,JEQ,JGT} (Hack order is J1=JGT, J2=JEQ, J3=JLT in mnemonic,
    // but in bits it's [2]=JLT, [1]=JEQ, [0]=JGT)
    wire jlt = sw[2];
    wire jeq = sw[1];
    wire jgt = sw[0];
    wire zr  = btnU;
    wire ng  = btnD;

    wire pos = ~ng & ~zr;      // positive
    wire takeJump = (jlt & ng) | (jeq & zr) | (jgt & pos);
    wire loadPC   = isC & takeJump;

    // pack to LEDs
    assign led[5:0]   = {zx, nx, zy, ny, f, no};  // ALU control
    assign led[7:6]   = {selA, selY};             // mux selects
    assign led[10:8]  = {loadA, loadD, writeM};   // A/D/M controls
    assign led[11]    = loadPC;                   // PC control (jump taken)
    assign led[15:12] = 4'b0000;                  // unused

endmodule
