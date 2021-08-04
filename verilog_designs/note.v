`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: SUSTech-RogerDTZ
//
// Create Date: 2021/07/14 15:47:14
// Design Name:
// Module Name: note
// Project Name:
// Target Devices:
// Tool Versions:
// Description: implementation of each note, with ADSR envelop
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

`define bigm 17'd512

`define ADSR_A 13'd10   // 10 ms
`define ADSR_D 13'd350   // 350 ms
`define ADSR_S 13'd3000 // 3000 ms

`define ADSR_A_PRD 7'd1   // +100 = +10 / 1ms
`define ADSR_D_PRD 7'd35   // -60 = -6 / 35ms
`define ADSR_S_PRD 7'd60 // -50 = -1 / 60ms
`define ADSR_R_PRD 7'd4 // -1 / 4 ms

`define AMP_DENO 7'd100

module note(input clk_100mhz,
	        input clk_1000hz,
			input rst_n,
			input sample_switch,
            input hold,
            output reg [7:0] q);
    
    parameter sample_cnt = 1;
	parameter note_data = "data/c5.txt";

	reg [7:0] sample [0: sample_cnt - 1];
    reg [11:0] ptr;
    reg [7:0] w;
	reg hold_state;
    reg [12:0] hold_timer;
	reg [6:0] f, g;
	reg [9:0] tmp;

	reg [6:0] cycle_timer;
	reg [6:0] cycle_st;

    // hold duration timer and release_time recording
    always @(posedge clk_1000hz or negedge rst_n) begin
		if (~rst_n) begin
			hold_state <= 0;
			hold_timer <= 0;
			cycle_timer <= 125;
			cycle_st <= 125;
		end else begin
			if (hold) begin
				if (~hold_state) begin
					hold_state <= 1;
					hold_timer <= 1;
				end else begin
					if (hold_timer != 8000)
						hold_timer <= hold_timer + 1;
				end
				if (hold_timer <= `ADSR_A) begin
					cycle_st = 125 - `ADSR_A_PRD;
				end	else if (hold_timer <= `ADSR_A + `ADSR_D) begin
					cycle_st = 125 - `ADSR_D_PRD;
				end else if (hold_timer <= `ADSR_A + `ADSR_D + `ADSR_S) begin
					cycle_st = 125 - `ADSR_S_PRD;
				end else begin
					cycle_st = 125;
				end
			end else begin
				if (hold_state) begin
					hold_state <= 0;
					hold_timer <= 0;
				end
				cycle_st = 125 - `ADSR_R_PRD;
			end
			if (cycle_timer >= 125) begin
				cycle_timer <= cycle_st + 1;
			end else begin
				cycle_timer <= cycle_timer + 1;
			end
		end
    end

	// amp controller
	always @(posedge clk_100mhz) begin
		if (w >= 128) begin
			tmp = `bigm + ((w - 15'd128) * g / `AMP_DENO);	
		end else begin
			tmp = `bigm - ((15'd128 - w) * g / `AMP_DENO);
		end
		if (tmp > `bigm + 127)
			tmp = `bigm + 127;
		if (tmp < `bigm - 128)
			tmp = `bigm - 128;
		q <= tmp + 128 - `bigm;
	end

    // ADSR envelop 
    always @(posedge clk_1000hz or negedge rst_n) begin
		if (~rst_n) begin
			f <= 0;
		end else begin
			if (hold_state) begin
				if (hold_timer <= `ADSR_A) begin
					if (cycle_timer >= 125) begin
						if (f + 10 <= `AMP_DENO)
							f <= f + 10;	
						else
							f <= `AMP_DENO;
					end
				end	else if (hold_timer <= `ADSR_A + `ADSR_D) begin
					if (cycle_timer >= 125) begin
						if (f >= 6)
							f <= f - 6;	
						else
							f <= 0;
					end
				end else if (hold_timer <= `ADSR_A + `ADSR_D + `ADSR_S) begin
					if (cycle_timer >= 125) begin
						if (f > 0)
							f <= f - 1;	
					end
				end else begin
					f <= 0;
				end
			end else if (cycle_timer >= 125) begin
				if (f > 0) 
					f <= f - 1;
			end
		end
    end

    // sample switcher
    always @(posedge sample_switch or negedge rst_n) begin
		if (~rst_n) begin
			w <= 0;
			ptr <= 0;
			g <= 0;
		end else begin
			w <= sample[ptr];
            if (ptr == sample_cnt - 1) begin
                ptr <= 0;
				g <= f;
            end else begin
                ptr <= ptr + 1;
            end
		end
    end

	// sample loader
	always @(posedge rst_n) begin
		$readmemb(note_data, sample);
	end

endmodule