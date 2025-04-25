//RAM8
// created by Sohan on 18-04-2025
// 8-register memory using 8 Register modules

module RAM8 (
    input [15:0] in,
    input load,
    input [2:0] address,
    input clk,
    output [15:0] out
);
    wire [7:0] loads;
    wire [15:0] outs[7:0];

    demux8 dm (.in(load), .sel(address), .out(loads));

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : regs
            Register r (.in(in), .load(loads[i]), .clk(clk), .out(outs[i]));
        end
    endgenerate

    mux8 m (.in(outs), .sel(address), .out(out));
endmodule
