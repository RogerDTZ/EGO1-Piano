`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: SUSTech-RogerDTZ
//
// Create Date: 2021/07/14 20:55:47
// Design Name:
// Module Name: main
// Project Name:
// Target Devices:
// Tool Versions:
// Description: top module
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


`define c_c 8'b1001_1100
`define c_d 8'b0111_1010
`define c_e 8'b1001_1110
`define c_f 8'b1000_1110
`define c_g 8'b1111_0110
`define c_a 8'b1110_1110
`define c_b 8'b0011_1110

`define c_0 8'b1111_1100
`define c_1 8'b0110_0000
`define c_2 8'b1101_1010
`define c_3 8'b1111_0010
`define c_4 8'b0110_0110
`define c_5 8'b1011_0110
`define c_6 8'b1011_1110
`define c_7 8'b1110_0000
`define c_8 8'b1111_1110
`define c_9 8'b1110_0110
`define c__ 8'b0000_0010

module main(input clk,
            input power_switch,
            input ps2_c,
            input ps2_d,
            output power_led,
            output enhance,
            output speaker,
            output reg mode,
            output [5:0] beat_display,
            output [7:0] seg_en,
            output [7:0] seg_out1,
            output [7:0] seg_out2);

    assign power_led = power_switch;
    assign enhance = power_switch;

    wire [9:0] key_event;
    reg [62:0] hold;
    reg [62:0] piano_hold;
    wire [62:0] sheet_hold;
    reg [7:0] p0, p1, p2, p3, p4, p5, p6, p7;

    keyboard keyboard_u(
        .clk_100mhz(clk),
        .rst_n(power_switch),
        .ps2_c(ps2_c),
        .ps2_d(ps2_d),
        .key_event(key_event)
    );

    instrument piano(
        .clk(clk),
        .rst_n(power_switch),
        .hold(hold),
        .speaker(speaker)
    );

    player player_u(
        .rst_n(power_switch),
        .clk_100mhz(clk),
        .active(mode),
        .sheet_hold(sheet_hold),
        .beat_display(beat_display)
    );

    display display_u(
        .rst_n(power_switch),
        .clk_100mhz(clk),
        .p0(p0),
        .p1(p1),
        .p2(p2),
        .p3(p3),
        .p4(p4),
        .p5(p5),
        .p6(p6),
        .p7(p7),
        .seg_en(seg_en),
        .seg_out1(seg_out1),
        .seg_out2(seg_out2)
    );

    always @(posedge clk or negedge power_switch) begin
        if (~power_switch) begin
            mode <= 0;
            piano_hold <= 62'b0;
            p0 <= 8'b0000_0000;
            p1 <= 8'b0000_0000;
            p2 <= 8'b0000_0000;
            p3 <= 8'b0000_0000;
            p4 <= 8'b0000_0000;
            p5 <= 8'b0000_0000;
            p6 <= 8'b0000_0000;
            p7 <= 8'b0000_0000;
        end else begin
            if (key_event[9]) begin
                if (mode == 0) begin
                    case (key_event[7:0]) 
                        8'h1a: begin if (~key_event[8]) piano_hold[21] <= 0; else begin piano_hold[21] <= 1; p2 <= `c_c; p1 <= `c_4; p0 <= 8'b00000000; end end
                        8'h1b: begin if (~key_event[8]) piano_hold[22] <= 0; else begin piano_hold[22] <= 1; p2 <= `c_c; p1 <= `c_4; p0 <= `c__; end end
                        8'h22: begin if (~key_event[8]) piano_hold[23] <= 0; else begin piano_hold[23] <= 1; p2 <= `c_d; p1 <= `c_4; p0 <= 8'b00000000; end end
                        8'h23: begin if (~key_event[8]) piano_hold[24] <= 0; else begin piano_hold[24] <= 1; p2 <= `c_d; p1 <= `c_4; p0 <= `c__; end end
                        8'h21: begin if (~key_event[8]) piano_hold[25] <= 0; else begin piano_hold[25] <= 1; p2 <= `c_e; p1 <= `c_4; p0 <= 8'b00000000; end end
                        8'h2a: begin if (~key_event[8]) piano_hold[26] <= 0; else begin piano_hold[26] <= 1; p2 <= `c_f; p1 <= `c_4; p0 <= 8'b00000000; end end
                        8'h34: begin if (~key_event[8]) piano_hold[27] <= 0; else begin piano_hold[27] <= 1; p2 <= `c_f; p1 <= `c_4; p0 <= `c__; end end
                        8'h32: begin if (~key_event[8]) piano_hold[28] <= 0; else begin piano_hold[28] <= 1; p2 <= `c_g; p1 <= `c_4; p0 <= 8'b00000000; end end
                        8'h33: begin if (~key_event[8]) piano_hold[29] <= 0; else begin piano_hold[29] <= 1; p2 <= `c_g; p1 <= `c_4; p0 <= `c__; end end
                        8'h31: begin if (~key_event[8]) piano_hold[30] <= 0; else begin piano_hold[30] <= 1; p2 <= `c_a; p1 <= `c_4; p0 <= 8'b00000000; end end
                        8'h3b: begin if (~key_event[8]) piano_hold[31] <= 0; else begin piano_hold[31] <= 1; p2 <= `c_a; p1 <= `c_4; p0 <= `c__; end end
                        8'h3a: begin if (~key_event[8]) piano_hold[32] <= 0; else begin piano_hold[32] <= 1; p2 <= `c_b; p1 <= `c_4; p0 <= 8'b00000000; end end
                        8'h41: begin if (~key_event[8]) piano_hold[33] <= 0; else begin piano_hold[33] <= 1; p2 <= `c_c; p1 <= `c_5; p0 <= 8'b00000000; end end
                        8'h15: begin if (~key_event[8]) piano_hold[33] <= 0; else begin piano_hold[33] <= 1; p2 <= `c_c; p1 <= `c_5; p0 <= 8'b00000000; end end
                        8'h1e: begin if (~key_event[8]) piano_hold[34] <= 0; else begin piano_hold[34] <= 1; p2 <= `c_c; p1 <= `c_5; p0 <= `c__; end end
                        8'h1d: begin if (~key_event[8]) piano_hold[35] <= 0; else begin piano_hold[35] <= 1; p2 <= `c_d; p1 <= `c_5; p0 <= 8'b00000000; end end
                        8'h26: begin if (~key_event[8]) piano_hold[36] <= 0; else begin piano_hold[36] <= 1; p2 <= `c_d; p1 <= `c_5; p0 <= `c__; end end
                        8'h24: begin if (~key_event[8]) piano_hold[37] <= 0; else begin piano_hold[37] <= 1; p2 <= `c_e; p1 <= `c_5; p0 <= 8'b00000000; end end
                        8'h2d: begin if (~key_event[8]) piano_hold[38] <= 0; else begin piano_hold[38] <= 1; p2 <= `c_f; p1 <= `c_5; p0 <= 8'b00000000; end end
                        8'h2e: begin if (~key_event[8]) piano_hold[39] <= 0; else begin piano_hold[39] <= 1; p2 <= `c_f; p1 <= `c_5; p0 <= `c__; end end
                        8'h2c: begin if (~key_event[8]) piano_hold[40] <= 0; else begin piano_hold[40] <= 1; p2 <= `c_g; p1 <= `c_5; p0 <= 8'b00000000; end end
                        8'h36: begin if (~key_event[8]) piano_hold[41] <= 0; else begin piano_hold[41] <= 1; p2 <= `c_g; p1 <= `c_5; p0 <= `c__; end end
                        8'h35: begin if (~key_event[8]) piano_hold[42] <= 0; else begin piano_hold[42] <= 1; p2 <= `c_a; p1 <= `c_5; p0 <= 8'b00000000; end end
                        8'h3d: begin if (~key_event[8]) piano_hold[43] <= 0; else begin piano_hold[43] <= 1; p2 <= `c_a; p1 <= `c_5; p0 <= `c__; end end
                        8'h3c: begin if (~key_event[8]) piano_hold[44] <= 0; else begin piano_hold[44] <= 1; p2 <= `c_b; p1 <= `c_5; p0 <= 8'b00000000; end end
                        8'h43: begin if (~key_event[8]) piano_hold[45] <= 0; else begin piano_hold[45] <= 1; p2 <= `c_c; p1 <= `c_6; p0 <= 8'b00000000; end end
                    endcase
                end
                if (key_event[7:0] == 8'h54 && key_event[8]) begin
                    mode <= 1;
                    p7 <= 8'b0000_0010;
                    p6 <= 8'b0000_0010;
                    p5 <= 8'b0000_0010;
                    p4 <= 8'b0000_0010;
                    p3 <= 8'b0000_0010;
                    p2 <= 8'b0000_0010;
                    p1 <= 8'b0000_0010;
                    p0 <= 8'b0000_0010;
                end
                if (key_event[7:0] == 8'h5b && key_event[8]) begin
                    mode <= 0; 
                    p7 <= 8'b0000_0000;
                    p6 <= 8'b0000_0000;
                    p5 <= 8'b0000_0000;
                    p4 <= 8'b0000_0000;
                    p3 <= 8'b0000_0000;
                    p2 <= 8'b0000_0000;
                    p1 <= 8'b0000_0000;
                    p0 <= 8'b0000_0000;
                end
            end
        end
    end

    always @(mode, piano_hold, sheet_hold, power_switch) begin
        if (~power_switch) begin
            hold <= 63'b0;
        end else begin
            if (~mode)
                hold <= piano_hold;
            else
                hold <= sheet_hold;
        end
    end

endmodule
