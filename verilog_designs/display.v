`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: SUSTech-RogerDTZ
// 
// Create Date: 2021/07/20 01:10:36
// Design Name: 
// Module Name: display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: control the display of 7-seg tubes
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module display(input rst_n,
               input clk_100mhz,
               input [7:0] p0,
               input [7:0] p1,
               input [7:0] p2,
               input [7:0] p3,
               input [7:0] p4,
               input [7:0] p5,
               input [7:0] p6,
               input [7:0] p7,
               output reg [7:0] seg_en,
               output reg [7:0] seg_out1,
               output reg [7:0] seg_out2);
    
    reg [2:0] scan_cnt;
    wire clk_slow;

    defparam clk_div_slow.period = 200000;
    clk_div clk_div_slow(
        .rst_n(rst_n),
        .clk_100mhz(clk_100mhz),
        .clk_out(clk_slow)
    );

    always @(posedge clk_slow or negedge rst_n) begin
        if (~rst_n) begin
            scan_cnt <= 0;
        end else begin
            if (scan_cnt == 3'b111) begin
                scan_cnt <= 3'b000; 
            end else begin
                scan_cnt <= scan_cnt + 1;
            end
        end
    end 

    always @(scan_cnt) begin
        case (scan_cnt)
            3'b000: seg_en <= 8'b00000001;
            3'b001: seg_en <= 8'b00000010;
            3'b010: seg_en <= 8'b00000100;
            3'b011: seg_en <= 8'b00001000;
            3'b100: seg_en <= 8'b00010000;
            3'b101: seg_en <= 8'b00100000;
            3'b110: seg_en <= 8'b01000000;
            3'b111: seg_en <= 8'b10000000;
            default: seg_en <= 8'b00000000;
        endcase
    end

    always @(scan_cnt) begin
        case (scan_cnt) 
            3'b000: begin seg_out1 <= p0; seg_out2 <= 8'b0; end
            3'b001: begin seg_out1 <= p1; seg_out2 <= 8'b0; end
            3'b010: begin seg_out1 <= p2; seg_out2 <= 8'b0; end
            3'b011: begin seg_out1 <= p3; seg_out2 <= 8'b0; end
            3'b100: begin seg_out2 <= p4; seg_out1 <= 8'b0; end
            3'b101: begin seg_out2 <= p5; seg_out1 <= 8'b0; end
            3'b110: begin seg_out2 <= p6; seg_out1 <= 8'b0; end
            3'b111: begin seg_out2 <= p7; seg_out1 <= 8'b0; end
        endcase
    end
    
endmodule