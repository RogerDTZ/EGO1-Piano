`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: SUSTech-RogerDTZ
//
// Create Date: 2021/07/16 19:23:41
// Design Name:
// Module Name: keyboard
// Project Name:
// Target Devices:
// Tool Versions:
// Description: a module that handles the keyboard inputs using PS2 protocol
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module keyboard(input clk_100mhz,
                input rst_n,
                input ps2_c,
                input ps2_d,
                output reg [9:0] key_event);

    reg [3:0] ps2_c_filter, ps2_d_filter;
    reg ps2_c_f, ps2_d_f;

    reg [21:0] buffer;
    reg [3:0] counter;

    always @(posedge clk_100mhz or negedge rst_n) begin
        if (~rst_n) begin
            ps2_c_filter <= 4'b1111;
            ps2_d_filter <= 4'b1111;
            ps2_c_f <= 1;
            ps2_d_f <= 1;
        end else begin
            ps2_c_filter <= {ps2_c, ps2_c_filter[3:1]};
            ps2_d_filter <= {ps2_d, ps2_d_filter[3:1]};
            if (ps2_c_filter == 4'b1111)
                ps2_c_f <= 1;
            else if (ps2_c_filter == 4'b0000)
                ps2_c_f <= 0;
            if (ps2_d_filter == 4'b1111)
                ps2_d_f <= 1;
            else if (ps2_d_filter == 4'b0000)
                ps2_d_f <= 0;
        end
    end

    always @(negedge ps2_c or negedge rst_n) begin
        if (~rst_n) begin
            buffer <= 22'b0;
            counter <= 4'b0;
            key_event <= 10'b0;
        end else begin
            buffer <= {ps2_d, buffer[21:1]};
            if (counter == 10) begin
                if (buffer[20:13] != 8'b11110000) begin
                    if (buffer[9:2] != 8'b11110000) begin
                        key_event[8] <= 1;
                    end else begin
                        key_event[8] <= 0;
                    end
                    key_event[7:0] <= buffer[20:13];
                    key_event[9] <= 1;
                end else begin
                    key_event[9] <= 0;
                end
                counter <= 0;
            end else begin
                counter <= counter + 1;
                key_event[9] <= 0;
            end
        end
    end

endmodule
