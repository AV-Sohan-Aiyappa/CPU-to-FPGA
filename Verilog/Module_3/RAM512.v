//RAM512
// created by Sohan on 18-04-2025
// 512-register memory using 8 RAM64 units

module RAM512 (
    input [15:0] in,
    input load,
    input [8:0] address,
    output [15:0] out
);
    wire [15:0] outs[7:0];
    wire [7:0] loads;
    wire [5:0] addr_low = address[5:0];
    wire [2:0] addr_high = address[8:6];

    // Assume demux8 and mux8 are defined
    demux8 dm (.in(load), .sel(addr_high), .out(loads));

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : ram_block
            RAM64 r (.in(in), .load(loads[i]), .address(addr_low), .out(outs[i]));
        end
    endgenerate

    mux8 m (.in(outs), .sel(addr_high), .out(out));
endmodule
