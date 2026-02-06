// ===== TOP MODULE =====
module hack_cpu (
    input clk_100MHz,
    input reset,
    input btnc,
    input [15:0] sw,
    output hsync,
    output vsync,
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue
);

    // CPU Registers
    wire i_bit, a_bit;
    reg [15:0] A_reg, D_reg;
    reg [15:0] instruction_history [0:19];
    reg [4:0] instr_count;
    
    wire [15:0] inM, outM;
    wire [14:0] addressM;
    wire writeM;
    wire zr_flag, ng_flag;
    
    // Button debouncing
    reg btnc_prev, btnc_stable;
    reg [19:0] debounce_counter;
    wire btnc_pressed;
    
    always @(posedge clk_100MHz or posedge reset) begin
        if (reset) begin
            debounce_counter <= 0;
            btnc_stable <= 0;
            btnc_prev <= 0;
        end else begin
            if (btnc != btnc_stable) begin
                debounce_counter <= debounce_counter + 1;
                if (debounce_counter == 20'd1000000) begin
                    btnc_stable <= btnc;
                    debounce_counter <= 0;
                end
            end else begin
                debounce_counter <= 0;
            end
            btnc_prev <= btnc_stable;
        end
    end
    
    assign btnc_pressed = btnc_stable && !btnc_prev;
    
    // Memory instance
    reg mem_load;
    RAM16K memory (
        .in(outM),
        .load(mem_load),
        .address(addressM[13:0]),
        .out(inM)
    );
    
    // ALU instance
    wire [15:0] alu_x, alu_y;
    wire alu_zx, alu_nx, alu_zy, alu_ny, alu_f, alu_no;
    
    ALU alu (
        .x(alu_x),
        .y(alu_y),
        .zx(alu_zx),
        .nx(alu_nx),
        .zy(alu_zy),
        .ny(alu_ny),
        .f(alu_f),
        .no(alu_no),
        .out(outM),
        .zr(zr_flag),
        .ng(ng_flag)
    );
    // ===== ALU INPUT SELECTION (HACK DATAPATH) =====
assign alu_x = D_reg;
assign alu_y = a_bit ? inM : A_reg;

    // Current instruction
    reg [15:0] current_instruction;
    reg execute_pending;

    
    // Use sw directly for ALU during execution, otherwise use stored instruction
    wire [15:0] active_instruction;
    assign active_instruction = current_instruction;

    
    // Instruction decode
// Instruction decode (FIXED)


wire [2:0] dest_bits;

assign i_bit     = active_instruction[15];
assign a_bit     = active_instruction[12];
assign dest_bits = active_instruction[5:3];

// ALU control (FIXED)
assign alu_zx = active_instruction[11];
assign alu_nx = active_instruction[10];
assign alu_zy = active_instruction[9];
assign alu_ny = active_instruction[8];
assign alu_f  = active_instruction[7];
assign alu_no = active_instruction[6];


// Dest decode (FIXED)
assign dest_A = dest_bits[2];
assign dest_D = dest_bits[1];
assign dest_M = dest_bits[0];

    
    assign writeM = i_bit && dest_M;
    assign addressM = A_reg[14:0];
    
    // Instruction execution - FIXED to match HACK spec timing
    integer i;
always @(posedge clk_100MHz) begin
    if (reset) begin
        A_reg <= 0;
        D_reg <= 0;
        current_instruction <= 0;
        instr_count <= 0;
        mem_load <= 0;
        execute_pending <= 0;
    end else begin

        mem_load <= 0;

        if (btnc_pressed) begin
            // =======================
            // FETCH
            // =======================
            current_instruction <= sw;
            execute_pending <= 1;

            instruction_history[instr_count] <= sw;
            instr_count <= instr_count + 1;

        end else if (execute_pending) begin
            // =======================
            // EXECUTE (ONCE)
            // =======================
            execute_pending <= 0;

            if (!current_instruction[15]) begin
                // A-instruction
                A_reg <= {1'b0, current_instruction[14:0]};
            end else begin
                // C-instruction
                if (dest_A) A_reg <= outM;
                if (dest_D) D_reg <= outM;
                if (dest_M) mem_load <= 1;
            end
        end
    end
end


    
    // VGA Controller
    vga_controller vga (
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .A_reg(A_reg),
        .D_reg(D_reg),
        .inM(inM),
        .outM(outM),
        .writeM(writeM),
        .addressM(addressM),
        .zr_flag(zr_flag),
        .ng_flag(ng_flag),
        .instr_count(instr_count),
        .instr_0(instruction_history[0]),
        .instr_1(instruction_history[1]),
        .instr_2(instruction_history[2]),
        .instr_3(instruction_history[3]),
        .instr_4(instruction_history[4]),
        .instr_5(instruction_history[5]),
        .instr_6(instruction_history[6]),
        .instr_7(instruction_history[7]),
        .instr_8(instruction_history[8]),
        .instr_9(instruction_history[9]),
        .instr_10(instruction_history[10]),
        .instr_11(instruction_history[11]),
        .instr_12(instruction_history[12]),
        .instr_13(instruction_history[13]),
        .instr_14(instruction_history[14]),
        .instr_15(instruction_history[15]),
        .instr_16(instruction_history[16]),
        .instr_17(instruction_history[17]),
        .instr_18(instruction_history[18]),
        .instr_19(instruction_history[19]),
        .hsync(hsync),
        .vsync(vsync),
        .red(red),
        .green(green),
        .blue(blue)
    );

endmodule

// ===== VGA CONTROLLER =====
module vga_controller (
    input clk_100MHz,
    input reset,
    input [15:0] A_reg, D_reg, inM, outM,
    input writeM,
    input [14:0] addressM,
    input zr_flag, ng_flag,
    input [4:0] instr_count,
    input [15:0] instr_0, instr_1, instr_2, instr_3, instr_4,
    input [15:0] instr_5, instr_6, instr_7, instr_8, instr_9,
    input [15:0] instr_10, instr_11, instr_12, instr_13, instr_14,
    input [15:0] instr_15, instr_16, instr_17, instr_18, instr_19,
    output hsync, vsync,
    output [3:0] red, green, blue
);

    localparam H_TOTAL = 800;
    localparam H_SYNC = 96;
    localparam H_BACK_PORCH = 48;
    localparam H_ACTIVE = 640;
    
    localparam V_TOTAL = 525;
    localparam V_SYNC = 2;
    localparam V_BACK_PORCH = 33;
    localparam V_ACTIVE = 480;
    
    // Pixel clock generation
    reg clk_25MHz;
    reg [1:0] clk_div;
    
    always @(posedge clk_100MHz) begin
        clk_div <= clk_div + 1;
        clk_25MHz <= (clk_div == 2'b00);
    end
    
    // Counters
    reg [10:0] h_count, v_count;
    wire [9:0] x, y;
    wire valid_pix;
    
    always @(posedge clk_100MHz or posedge reset) begin
        if (reset) begin
            h_count <= 0;
            v_count <= 0;
        end else if (clk_25MHz) begin
            if (h_count == H_TOTAL - 1) begin
                h_count <= 0;
                if (v_count == V_TOTAL - 1)
                    v_count <= 0;
                else
                    v_count <= v_count + 1;
            end else
                h_count <= h_count + 1;
        end
    end
    
    // Sync signals
    assign hsync = (h_count >= H_SYNC);
    assign vsync = (v_count >= V_SYNC);
    
    // Active area
    wire h_active = (h_count >= H_SYNC + H_BACK_PORCH) && (h_count < H_SYNC + H_BACK_PORCH + H_ACTIVE);
    wire v_active = (v_count >= V_SYNC + V_BACK_PORCH) && (v_count < V_SYNC + V_BACK_PORCH + V_ACTIVE);
    
    assign x = h_count - (H_SYNC + H_BACK_PORCH);
    assign y = v_count - (V_SYNC + V_BACK_PORCH);
    assign valid_pix = h_active && v_active;
    
    // Display renderer
    wire [3:0] pixel_color;
    wire draw_pixel;
    
    display_renderer renderer (
        .x(x), .y(y),
        .A_reg(A_reg), .D_reg(D_reg), .inM(inM), .outM(outM),
        .writeM(writeM), .addressM(addressM),
        .zr_flag(zr_flag), .ng_flag(ng_flag),
        .instr_count(instr_count),
        .instr_0(instr_0), .instr_1(instr_1), .instr_2(instr_2), .instr_3(instr_3), .instr_4(instr_4),
        .instr_5(instr_5), .instr_6(instr_6), .instr_7(instr_7), .instr_8(instr_8), .instr_9(instr_9),
        .instr_10(instr_10), .instr_11(instr_11), .instr_12(instr_12), .instr_13(instr_13), .instr_14(instr_14),
        .instr_15(instr_15), .instr_16(instr_16), .instr_17(instr_17), .instr_18(instr_18), .instr_19(instr_19),
        .draw(draw_pixel), .color(pixel_color)
    );
    
    // Color output
    assign red = valid_pix ? (draw_pixel ? (pixel_color[3] ? 4'hF : 4'h0) : 4'h2) : 4'h0;
    assign green = valid_pix ? (draw_pixel ? (pixel_color[2] ? 4'hF : 4'h0) : 4'h2) : 4'h0;
    assign blue = valid_pix ? (draw_pixel ? (pixel_color[1:0] == 2'b11 ? 4'hF : 4'h0) : 4'h2) : 4'h0;

endmodule

// ===== DISPLAY RENDERER =====
module display_renderer (
    input [9:0] x, y,
    input [15:0] A_reg, D_reg, inM, outM,
    input writeM,
    input [14:0] addressM,
    input zr_flag, ng_flag,
    input [4:0] instr_count,
    input [15:0] instr_0, instr_1, instr_2, instr_3, instr_4,
    input [15:0] instr_5, instr_6, instr_7, instr_8, instr_9,
    input [15:0] instr_10, instr_11, instr_12, instr_13, instr_14,
    input [15:0] instr_15, instr_16, instr_17, instr_18, instr_19,
    output reg draw,
    output reg [3:0] color
);

    // 8x8 Font ROM 
    function [63:0] font_rom;
        input [7:0] char;
        begin
            case (char)
                "0": font_rom = 64'h3C66666E76663C00; // Circle for 0
                "1": font_rom = 64'h18381818181818FF; // Line for 1
                "A": font_rom = 64'h3C66667E66666600;
                "C": font_rom = 64'h3C66606060663C00;
                "D": font_rom = 64'h7866666666667800;
                "E": font_rom = 64'h7E60607860607E00;
                "G": font_rom = 64'h3C66606E66663C00;
                "I": font_rom = 64'h3C18181818183C00;
                "M": font_rom = 64'h63777F6B63636300;
                "N": font_rom = 64'h66767E7E6E666600;
                "O": font_rom = 64'h3C66666666663C00;
                "R": font_rom = 64'h7C66667C78666600;
                "S": font_rom = 64'h3C66603C06663C00;
                "T": font_rom = 64'h7E18181818181800;
                "U": font_rom = 64'h66666666663C0000;
                "W": font_rom = 64'h63636B7F77630000;
                "Z": font_rom = 64'h7E060C1830607E00;
                ":": font_rom = 64'h0018180000181800;
                default: font_rom = 64'h0000000000000000;
            endcase
        end
    endfunction
    
    // Draw character at position
    function draw_char_pixel;
        input [7:0] char;
        input [2:0] px, py;
        reg [63:0] bitmap;
        begin
            bitmap = font_rom(char);
            draw_char_pixel = bitmap[(7-py)*8 + (7-px)];
        end
    endfunction
    
    // Get instruction by index
    function [15:0] get_instr;
        input [4:0] idx;
        begin
            case (idx)
                0: get_instr = instr_0; 1: get_instr = instr_1; 2: get_instr = instr_2; 3: get_instr = instr_3;
                4: get_instr = instr_4; 5: get_instr = instr_5; 6: get_instr = instr_6; 7: get_instr = instr_7;
                8: get_instr = instr_8; 9: get_instr = instr_9; 10: get_instr = instr_10; 11: get_instr = instr_11;
                12: get_instr = instr_12; 13: get_instr = instr_13; 14: get_instr = instr_14; 15: get_instr = instr_15;
                16: get_instr = instr_16; 17: get_instr = instr_17; 18: get_instr = instr_18; 19: get_instr = instr_19;
                default: get_instr = 0;
            endcase
        end
    endfunction
    
    reg [15:0] current_instr;
    reg [4:0] line_idx;
    reg [3:0] bit_pos;
    reg [2:0] px, py;
    
    always @(*) begin
        draw = 0;
        color = 4'b1111;
        
        // Left side: Instructions (x < 320)
        if (x < 320) begin
            // Title "INSTRUCTIONS"
            if (y >= 10 && y < 18) begin
                py = y - 10;
                if (x >= 10 && x < 98) begin
                    px = (x - 10) % 8;
                    case ((x - 10) / 8)
                        0: if (draw_char_pixel("I", px, py)) begin draw = 1; color = 4'b0011; end
                        1: if (draw_char_pixel("N", px, py)) begin draw = 1; color = 4'b0011; end
                        2: if (draw_char_pixel("S", px, py)) begin draw = 1; color = 4'b0011; end
                        3: if (draw_char_pixel("T", px, py)) begin draw = 1; color = 4'b0011; end
                        4: if (draw_char_pixel("R", px, py)) begin draw = 1; color = 4'b0011; end
                        5: if (draw_char_pixel("U", px, py)) begin draw = 1; color = 4'b0011; end
                        6: if (draw_char_pixel("C", px, py)) begin draw = 1; color = 4'b0011; end
                        7: if (draw_char_pixel("T", px, py)) begin draw = 1; color = 4'b0011; end
                        8: if (draw_char_pixel("I", px, py)) begin draw = 1; color = 4'b0011; end
                        9: if (draw_char_pixel("O", px, py)) begin draw = 1; color = 4'b0011; end
                        10: if (draw_char_pixel("N", px, py)) begin draw = 1; color = 4'b0011; end
                    endcase
                end
            end
            
            // Instruction history
            if (y >= 30 && y < 30 + instr_count * 12 && x >= 10 && x < 154) begin
                line_idx = (y - 30) / 12;
                if (line_idx < instr_count && (y - 30) % 12 < 8) begin
                    py = (y - 30) % 12;
                    bit_pos = (x - 10) / 9;
                    if (bit_pos < 16) begin
                        current_instr = get_instr(line_idx);
                        px = (x - 10) % 9;
                        if (px < 8) begin
                            if (draw_char_pixel(current_instr[15 - bit_pos] ? "1" : "0", px, py)) begin
                                draw = 1;
                                color = 4'b1100;
                            end
                        end
                    end
                end
            end
        end
        
        // Right side (x >= 320)
        if (x >= 320) begin
            // A Register
            if (y >= 30 && y < 38 && x >= 330) begin
                py = y - 30;
                if (x >= 330 && x < 338) begin
                    if (draw_char_pixel("A", x - 330, py)) begin draw = 1; color = 4'b1010; end
                end else if (x >= 340 && x < 348) begin
                    if (draw_char_pixel(":", x - 340, py)) begin draw = 1; color = 4'b1010; end
                end else if (x >= 354 && x < 498) begin
                    bit_pos = (x - 354) / 9;
                    if (bit_pos < 16) begin
                        px = (x - 354) % 9;
                        if (px < 8 && draw_char_pixel(A_reg[15-bit_pos] ? "1" : "0", px, py)) begin
                            draw = 1;
                            color = 4'b1010;
                        end
                    end
                end
            end
            
            // D Register
            if (y >= 50 && y < 58 && x >= 330) begin
                py = y - 50;
                if (x >= 330 && x < 338) begin
                    if (draw_char_pixel("D", x - 330, py)) begin draw = 1; color = 4'b1010; end
                end else if (x >= 340 && x < 348) begin
                    if (draw_char_pixel(":", x - 340, py)) begin draw = 1; color = 4'b1010; end
                end else if (x >= 354 && x < 498) begin
                    bit_pos = (x - 354) / 9;
                    if (bit_pos < 16) begin
                        px = (x - 354) % 9;
                        if (px < 8 && draw_char_pixel(D_reg[15-bit_pos] ? "1" : "0", px, py)) begin
                            draw = 1;
                            color = 4'b1010;
                        end
                    end
                end
            end
            
            // inM
            if (y >= 70 && y < 78 && x >= 330) begin
                py = y - 70;
                if (x >= 330 && x < 338) begin
                    if (draw_char_pixel("I", x - 330, py)) begin draw = 1; color = 4'b1010; end
                end else if (x >= 340 && x < 348) begin
                    if (draw_char_pixel("N", x - 340, py)) begin draw = 1; color = 4'b1010; end
                end else if (x >= 350 && x < 358) begin
                    if (draw_char_pixel("M", x - 350, py)) begin draw = 1; color = 4'b1010; end
                end else if (x >= 360 && x < 368) begin
                    if (draw_char_pixel(":", x - 360, py)) begin draw = 1; color = 4'b1010; end
                end else if (x >= 374 && x < 518) begin
                    bit_pos = (x - 374) / 9;
                    if (bit_pos < 16) begin
                        px = (x - 374) % 9;
                        if (px < 8 && draw_char_pixel(inM[15-bit_pos] ? "1" : "0", px, py)) begin
                            draw = 1;
                            color = 4'b1010;
                        end
                    end
                end
            end
            
            // Bottom section - outM
            if (y >= 260 && y < 268 && x >= 330) begin
                py = y - 260;
                if (x >= 330 && x < 338) begin
                    if (draw_char_pixel("O", x - 330, py)) begin draw = 1; color = 4'b0110; end
                end else if (x >= 340 && x < 348) begin
                    if (draw_char_pixel("U", x - 340, py)) begin draw = 1; color = 4'b0110; end
                end else if (x >= 350 && x < 358) begin
                    if (draw_char_pixel("T", x - 350, py)) begin draw = 1; color = 4'b0110; end
                end else if (x >= 360 && x < 368) begin
                    if (draw_char_pixel("M", x - 360, py)) begin draw = 1; color = 4'b0110; end
                end else if (x >= 370 && x < 378) begin
                    if (draw_char_pixel(":", x - 370, py)) begin draw = 1; color = 4'b0110; end
                end else if (x >= 384 && x < 528) begin
                    bit_pos = (x - 384) / 9;
                    if (bit_pos < 16) begin
                        px = (x - 384) % 9;
                        if (px < 8 && draw_char_pixel(outM[15-bit_pos] ? "1" : "0", px, py)) begin
                            draw = 1;
                            color = 4'b0110;
                        end
                    end
                end
            end
            
            // writeM flag
            if (y >= 290 && y < 298 && x >= 330 && x < 450) begin
                py = y - 290;
                if (x >= 330 && x < 338) begin
                    if (draw_char_pixel("W", x - 330, py)) begin draw = 1; color = 4'b0110; end
                end else if (x >= 340 && x < 348) begin
                    if (draw_char_pixel("R", x - 340, py)) begin draw = 1; color = 4'b0110; end
                end else if (x >= 350 && x < 358) begin
                    if (draw_char_pixel("I", x - 350, py)) begin draw = 1; color = 4'b0110; end
                end else if (x >= 360 && x < 368) begin
                    if (draw_char_pixel("T", x - 360, py)) begin draw = 1; color = 4'b0110; end
                end else if (x >= 370 && x < 378) begin
                    if (draw_char_pixel("E", x - 370, py)) begin draw = 1; color = 4'b0110; end
                end else if (x >= 380 && x < 388) begin
                    if (draw_char_pixel("M", x - 380, py)) begin draw = 1; color = 4'b0110; end
                end else if (x >= 390 && x < 398) begin
                    if (draw_char_pixel(":", x - 390, py)) begin draw = 1; color = 4'b0110; end
                end else if (x >= 404 && x < 412) begin
                    if (draw_char_pixel(writeM ? "1" : "0", x - 404, py)) begin draw = 1; color = 4'b0110; end
                end
            end
            
            // ZR flag
            if (y >= 320 && y < 328 && x >= 330 && x < 410) begin
                py = y - 320;
                if (x >= 330 && x < 338) begin
                    if (draw_char_pixel("Z", x - 330, py)) begin draw = 1; color = 4'b1001; end
                end else if (x >= 340 && x < 348) begin
                    if (draw_char_pixel("R", x - 340, py)) begin draw = 1; color = 4'b1001; end
                end else if (x >= 350 && x < 358) begin
                    if (draw_char_pixel(":", x - 350, py)) begin draw = 1; color = 4'b1001; end
                end else if (x >= 364 && x < 372) begin
                    if (draw_char_pixel(zr_flag ? "1" : "0", x - 364, py)) begin draw = 1; color = 4'b1001; end
                end
            end
            
            // NG flag
            if (y >= 340 && y < 348 && x >= 330 && x < 410) begin
                py = y - 340;
                if (x >= 330 && x < 338) begin
                    if (draw_char_pixel("N", x - 330, py)) begin draw = 1; color = 4'b1001; end
                end else if (x >= 340 && x < 348) begin
                    if (draw_char_pixel("G", x - 340, py)) begin draw = 1; color = 4'b1001; end
                end else if (x >= 350 && x < 358) begin
                    if (draw_char_pixel(":", x - 350, py)) begin draw = 1; color = 4'b1001; end
                end else if (x >= 364 && x < 372) begin
                    if (draw_char_pixel(ng_flag ? "1" : "0", x - 364, py)) begin draw = 1; color = 4'b1001; end
                end
            end
        end
        
        // Dividers
        if (x == 319 || x == 320) begin
            draw = 1;
            color = 4'b1111;
        end
        if ((y == 239 || y == 240) && x >= 320) begin
            draw = 1;
            color = 4'b1111;
        end
    end

endmodule

// ===== SIMPLE RAM16K =====
module RAM16K (
    input [15:0] in,
    input load,
    input [13:0] address,
    output [15:0] out
);
    reg [15:0] memory [0:16383];
    assign out = memory[address];
    
    integer i;
    initial begin
        for (i = 0; i < 16384; i = i + 1) begin
            memory[i] = 16'h0000;
        end
    end
endmodule
