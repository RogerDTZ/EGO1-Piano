`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: SUSTech-RogerDTZ
//
// Create Date: 2021/07/16 19:47:46
// Design Name:
// Module Name: clk_div
// Project Name:
// Target Devices:
// Tool Versions:
// Description: a simple clock divider
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module clk_div(input clk_100mhz,
               input rst_n,
               output reg clk_out);
    
    parameter period = 100000;
    
    reg [31:0] cnt;
    
    always @(posedge clk_100mhz or negedge rst_n) begin
        if (~rst_n) begin
            cnt <= 0;
            clk_out <= 0;
        end else begin
            if (cnt == (period >> 1) - 1) begin
                clk_out <= ~clk_out;
                cnt <= 0;
            end else begin
                cnt <= cnt + 1;
            end
        end
    end
    
endmodule
