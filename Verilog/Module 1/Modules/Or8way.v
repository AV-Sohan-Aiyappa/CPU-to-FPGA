// Or8way.v
// created by sohan on 16-03-2025
// Takes 8-bit value and performs OR operation with each of the values 

module Or8Way(input [7:0] in, output out);
    assign out = in[0] | in[1] | in[2] | in[3] | in[4] | in[5] | in[6] | in[7];
endmodule
