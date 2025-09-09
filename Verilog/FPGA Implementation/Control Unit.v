// HackControlVisualizerTop.v
// Shows Hack CPU control signals for a 16-bit opcode on Basys3 LEDs.
// SW[15:0] = instruction opcode
// LEDs show decoded control signals

module HackControlVisualizerTop(
    input  [15:0] sw,     // instruction
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
    wire jlt = sw[2];
    wire jeq = sw[1];
    wire jgt = sw[0];

    // For visualizer, we ignore actual zr/ng and just show if jump bits are set
    wire loadPC = isC & (jlt | jeq | jgt);

    // LED mapping as per requirement
    assign led[0]  = zx;
    assign led[1]  = nx;
    assign led[2]  = zy;
    assign led[3]  = ny;
    assign led[4]  = f;
    assign led[5]  = no;

    assign led[6]  = selA;
    assign led[7]  = selY;

    assign led[8]  = loadA;
    assign led[9]  = loadD;
    assign led[10] = writeM;

    assign led[11] = loadPC;

    // remaining LEDs unused
    assign led[15:12] = 4'b0000;

endmodule
