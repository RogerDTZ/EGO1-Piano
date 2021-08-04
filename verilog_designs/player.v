`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: SUSTech-RogerDTZ
//
// Create Date: 2021/07/20 17:20:26
// Design Name:
// Module Name: player
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module player(input rst_n,
              input clk_100mhz,
              input active,
              output reg [62:0] sheet_hold,
              output reg [5:0] beat_display);
    
    parameter tempo_cnt = 1296;
    reg [62:0] sheet_ctt [0 : tempo_cnt - 1];
    reg [10:0] counter;
    wire tempo_trigger;
    
    always @(posedge rst_n) begin
        $readmemb("city of tears.txt", sheet_ctt);
    end

//  this is the period suitable for the OST 'city of tears'
//  120 BPM, 12/8
//  since the sheet frames are the doubled size of the original sheet, the tempo speed is doubled too (more details in read_midi.py)
    defparam tempo.period = 8333332;
    clk_div tempo(
        .rst_n(rst_n),
        .clk_100mhz(clk_100mhz),
        .clk_out(tempo_trigger)
    );

    
//  display the tempo!
    always @(posedge tempo_trigger or negedge rst_n or negedge active) begin
        if (~rst_n || ~active) begin
            counter    <= 0;
            sheet_hold <= 63'b0;
            beat_display <= 6'b0;
        end else begin
            if (active) begin
                sheet_hold <= sheet_ctt[counter];
                if (counter % 2 == 0) begin
                    case ((counter / 2) % 6) 
                        0: beat_display = 6'b100000;
                        1: beat_display = 6'b010000;
                        2: beat_display = 6'b001000;
                        3: beat_display = 6'b000100;
                        4: beat_display = 6'b000010;
                        5: beat_display = 6'b000001;
                    endcase
                end
                if (counter == tempo_cnt - 1) begin
                    counter <= 0;
                end else begin
                    counter <= counter + 1;
                end
            end
        end
    end
    
    
endmodule
