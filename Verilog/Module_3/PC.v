//PC
// created by Sohan on 18-04-2025
// Program Counter: can load, increment, or reset

module PC (
    input [15:0] in,
    input load, inc, reset,
    output reg [15:0] out
);
    always @(*) begin
        if (reset)
            out = 16'b0;
        else if (load)
            out = in;
        else if (inc)
            out = out + 1;
    end
endmodule
