//RAM64
// created by Sohan on 18-04-2025
// 64-register memory using 8 RAM8 modules

module RAM64 (
    input [15:0] in,
    input load,
    input [5:0] address,
    input clk,
    output [15:0] out
);
    wire [15:0] outs[7:0];
    wire [7:0] loads;
    wire [2:0] addr_low = address[2:0];
    wire [2:0] addr_high = address[5:3];

    demux8 dm (.in(load), .sel(addr_high), .out(loads));

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : blocks
            RAM8 r (.in(in), .load(loads[i]), .address(addr_low), .clk(clk), .out(outs[i]));
        end
    endgenerate

    mux8 m (.in(outs), .sel(addr_high), .out(out));
endmodule
