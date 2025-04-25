//RAM16K
// created by Sohan on 18-04-2025
// 16K-register memory using 4 RAM4K units

module RAM16K (
    input [15:0] in,
    input load,
    input [13:0] address,
    output [15:0] out
);
    wire [15:0] outs[3:0];
    wire [3:0] loads;
    wire [11:0] addr_low = address[11:0];
    wire [1:0] addr_high = address[13:12];

    demux4 dm (.in(load), .sel(addr_high), .out(loads));

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : ram_block
            RAM4K r (.in(in), .load(loads[i]), .address(addr_low), .out(outs[i]));
        end
    endgenerate

    mux4 m (.in(outs), .sel(addr_high), .out(out));
endmodule
