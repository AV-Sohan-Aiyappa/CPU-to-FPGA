//RAM4K
// created by Sohan on 18-04-2025
// 4K-register memory using 8 RAM512 units

module RAM4K (
    input [15:0] in,
    input load,
    input [11:0] address,
    output [15:0] out
);
    wire [15:0] outs[7:0];
    wire [7:0] loads;
    wire [8:0] addr_low = address[8:0];
    wire [2:0] addr_high = address[11:9];

    demux8 dm (.in(load), .sel(addr_high), .out(loads));

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : ram_block
            RAM512 r (.in(in), .load(loads[i]), .address(addr_low), .out(outs[i]));
        end
    endgenerate

    mux8 m (.in(outs), .sel(addr_high), .out(out));
endmodule
