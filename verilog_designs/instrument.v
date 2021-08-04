`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: SUSTech-RogerDTZ
// 
// Create Date: 2021/07/16 19:55:54
// Design Name: 
// Module Name: instrument
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: the instrument, manager of all notes
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// based on the sample frequency of the wav file (in my case, the piano samples), calculate and change the parameters below:
// `define sample_prd 15625  // 6400 Hz
`define sample_prd 2268      // 44100 Hz

module instrument(input clk,
                  input rst_n,
                  input [63:0] hold,
                  output reg speaker);

    parameter counter_upperbound = 10000;
    parameter pwm_prd = 1024;

    wire clk_1000hz;

    clk_div clk_div_1000hz(
        .clk_100mhz(clk),
        .rst_n(rst_n),
        .clk_out(clk_1000hz)
    );

    reg [15:0] pwm_one;
    reg pwm_state;
    reg [15:0] pwm_timer;
    reg signed [63:0] sum;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            pwm_state <= 0;
            pwm_timer <= counter_upperbound;
            speaker <= 0;
        end else begin
            if (pwm_timer >= counter_upperbound) begin
                if (pwm_state == 0) begin
                    pwm_state <= 1;
                    pwm_timer = counter_upperbound - pwm_one;
                end else begin
                    pwm_state <= 0;
                    pwm_timer = counter_upperbound - (pwm_prd - pwm_one);
                end
                speaker <= ~speaker;
            end
            pwm_timer = pwm_timer + 1;
        end
    end

    wire sample_switch;

    defparam sample_clock.period = `sample_prd;
    clk_div sample_clock(
        .rst_n(rst_n),
        .clk_100mhz(clk),
        .clk_out(sample_switch)
    );


//  paste content from code_gen_output.txt [Start]

	wire [7:0] q_d2s;
    defparam d2s.sample_cnt = 1110;
    defparam d2s.note_data = "data/d2s.txt";
    note d2s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[0]),
        .q(q_d2s)
    );

	wire [7:0] q_e2;
    defparam e2.sample_cnt = 1064;
    defparam e2.note_data = "data/e2.txt";
    note e2(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[1]),
        .q(q_e2)
    );

	wire [7:0] q_f2;
    defparam f2.sample_cnt = 1003;
    defparam f2.note_data = "data/f2.txt";
    note f2(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[2]),
        .q(q_f2)
    );

	wire [7:0] q_f2s;
    defparam f2s.sample_cnt = 930;
    defparam f2s.note_data = "data/f2s.txt";
    note f2s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[3]),
        .q(q_f2s)
    );

	wire [7:0] q_g2;
    defparam g2.sample_cnt = 898;
    defparam g2.note_data = "data/g2.txt";
    note g2(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[4]),
        .q(q_g2)
    );

	wire [7:0] q_g2s;
    defparam g2s.sample_cnt = 841;
    defparam g2s.note_data = "data/g2s.txt";
    note g2s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[5]),
        .q(q_g2s)
    );

	wire [7:0] q_a2;
    defparam a2.sample_cnt = 801;
    defparam a2.note_data = "data/a2.txt";
    note a2(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[6]),
        .q(q_a2)
    );

	wire [7:0] q_a2s;
    defparam a2s.sample_cnt = 757;
    defparam a2s.note_data = "data/a2s.txt";
    note a2s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[7]),
        .q(q_a2s)
    );

	wire [7:0] q_b2;
    defparam b2.sample_cnt = 714;
    defparam b2.note_data = "data/b2.txt";
    note b2(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[8]),
        .q(q_b2)
    );

	wire [7:0] q_c3;
    defparam c3.sample_cnt = 714;
    defparam c3.note_data = "data/c3.txt";
    note c3(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[9]),
        .q(q_c3)
    );

	wire [7:0] q_c3s;
    defparam c3s.sample_cnt = 632;
    defparam c3s.note_data = "data/c3s.txt";
    note c3s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[10]),
        .q(q_c3s)
    );

	wire [7:0] q_d3;
    defparam d3.sample_cnt = 599;
    defparam d3.note_data = "data/d3.txt";
    note d3(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[11]),
        .q(q_d3)
    );

	wire [7:0] q_d3s;
    defparam d3s.sample_cnt = 566;
    defparam d3s.note_data = "data/d3s.txt";
    note d3s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[12]),
        .q(q_d3s)
    );

	wire [7:0] q_e3;
    defparam e3.sample_cnt = 529;
    defparam e3.note_data = "data/e3.txt";
    note e3(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[13]),
        .q(q_e3)
    );

	wire [7:0] q_f3;
    defparam f3.sample_cnt = 499;
    defparam f3.note_data = "data/f3.txt";
    note f3(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[14]),
        .q(q_f3)
    );

	wire [7:0] q_f3s;
    defparam f3s.sample_cnt = 467;
    defparam f3s.note_data = "data/f3s.txt";
    note f3s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[15]),
        .q(q_f3s)
    );

	wire [7:0] q_g3;
    defparam g3.sample_cnt = 442;
    defparam g3.note_data = "data/g3.txt";
    note g3(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[16]),
        .q(q_g3)
    );

	wire [7:0] q_g3s;
    defparam g3s.sample_cnt = 422;
    defparam g3s.note_data = "data/g3s.txt";
    note g3s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[17]),
        .q(q_g3s)
    );

	wire [7:0] q_a3;
    defparam a3.sample_cnt = 395;
    defparam a3.note_data = "data/a3.txt";
    note a3(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[18]),
        .q(q_a3)
    );

	wire [7:0] q_a3s;
    defparam a3s.sample_cnt = 374;
    defparam a3s.note_data = "data/a3s.txt";
    note a3s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[19]),
        .q(q_a3s)
    );

	wire [7:0] q_b3;
    defparam b3.sample_cnt = 360;
    defparam b3.note_data = "data/b3.txt";
    note b3(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[20]),
        .q(q_b3)
    );

	wire [7:0] q_c4;
    defparam c4.sample_cnt = 335;
    defparam c4.note_data = "data/c4.txt";
    note c4(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[21]),
        .q(q_c4)
    );

	wire [7:0] q_c4s;
    defparam c4s.sample_cnt = 320;
    defparam c4s.note_data = "data/c4s.txt";
    note c4s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[22]),
        .q(q_c4s)
    );

	wire [7:0] q_d4;
    defparam d4.sample_cnt = 294;
    defparam d4.note_data = "data/d4.txt";
    note d4(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[23]),
        .q(q_d4)
    );

	wire [7:0] q_d4s;
    defparam d4s.sample_cnt = 278;
    defparam d4s.note_data = "data/d4s.txt";
    note d4s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[24]),
        .q(q_d4s)
    );

	wire [7:0] q_e4;
    defparam e4.sample_cnt = 264;
    defparam e4.note_data = "data/e4.txt";
    note e4(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[25]),
        .q(q_e4)
    );

	wire [7:0] q_f4;
    defparam f4.sample_cnt = 252;
    defparam f4.note_data = "data/f4.txt";
    note f4(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[26]),
        .q(q_f4)
    );

	wire [7:0] q_f4s;
    defparam f4s.sample_cnt = 240;
    defparam f4s.note_data = "data/f4s.txt";
    note f4s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[27]),
        .q(q_f4s)
    );

	wire [7:0] q_g4;
    defparam g4.sample_cnt = 224;
    defparam g4.note_data = "data/g4.txt";
    note g4(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[28]),
        .q(q_g4)
    );

	wire [7:0] q_g4s;
    defparam g4s.sample_cnt = 209;
    defparam g4s.note_data = "data/g4s.txt";
    note g4s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[29]),
        .q(q_g4s)
    );

	wire [7:0] q_a4;
    defparam a4.sample_cnt = 199;
    defparam a4.note_data = "data/a4.txt";
    note a4(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[30]),
        .q(q_a4)
    );

	wire [7:0] q_a4s;
    defparam a4s.sample_cnt = 185;
    defparam a4s.note_data = "data/a4s.txt";
    note a4s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[31]),
        .q(q_a4s)
    );

	wire [7:0] q_b4;
    defparam b4.sample_cnt = 177;
    defparam b4.note_data = "data/b4.txt";
    note b4(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[32]),
        .q(q_b4)
    );

	wire [7:0] q_c5;
    defparam c5.sample_cnt = 167;
    defparam c5.note_data = "data/c5.txt";
    note c5(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[33]),
        .q(q_c5)
    );

	wire [7:0] q_c5s;
    defparam c5s.sample_cnt = 158;
    defparam c5s.note_data = "data/c5s.txt";
    note c5s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[34]),
        .q(q_c5s)
    );

	wire [7:0] q_d5;
    defparam d5.sample_cnt = 150;
    defparam d5.note_data = "data/d5.txt";
    note d5(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[35]),
        .q(q_d5)
    );

	wire [7:0] q_d5s;
    defparam d5s.sample_cnt = 141;
    defparam d5s.note_data = "data/d5s.txt";
    note d5s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[36]),
        .q(q_d5s)
    );

	wire [7:0] q_e5;
    defparam e5.sample_cnt = 133;
    defparam e5.note_data = "data/e5.txt";
    note e5(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[37]),
        .q(q_e5)
    );

	wire [7:0] q_f5;
    defparam f5.sample_cnt = 124;
    defparam f5.note_data = "data/f5.txt";
    note f5(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[38]),
        .q(q_f5)
    );

	wire [7:0] q_f5s;
    defparam f5s.sample_cnt = 120;
    defparam f5s.note_data = "data/f5s.txt";
    note f5s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[39]),
        .q(q_f5s)
    );

	wire [7:0] q_g5;
    defparam g5.sample_cnt = 111;
    defparam g5.note_data = "data/g5.txt";
    note g5(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[40]),
        .q(q_g5)
    );

	wire [7:0] q_g5s;
    defparam g5s.sample_cnt = 105;
    defparam g5s.note_data = "data/g5s.txt";
    note g5s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[41]),
        .q(q_g5s)
    );

	wire [7:0] q_a5;
    defparam a5.sample_cnt = 100;
    defparam a5.note_data = "data/a5.txt";
    note a5(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[42]),
        .q(q_a5)
    );

	wire [7:0] q_a5s;
    defparam a5s.sample_cnt = 94;
    defparam a5s.note_data = "data/a5s.txt";
    note a5s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[43]),
        .q(q_a5s)
    );

	wire [7:0] q_b5;
    defparam b5.sample_cnt = 89;
    defparam b5.note_data = "data/b5.txt";
    note b5(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[44]),
        .q(q_b5)
    );

	wire [7:0] q_c6;
    defparam c6.sample_cnt = 83;
    defparam c6.note_data = "data/c6.txt";
    note c6(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[45]),
        .q(q_c6)
    );

	wire [7:0] q_c6s;
    defparam c6s.sample_cnt = 79;
    defparam c6s.note_data = "data/c6s.txt";
    note c6s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[46]),
        .q(q_c6s)
    );

	wire [7:0] q_d6;
    defparam d6.sample_cnt = 75;
    defparam d6.note_data = "data/d6.txt";
    note d6(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[47]),
        .q(q_d6)
    );

	wire [7:0] q_d6s;
    defparam d6s.sample_cnt = 70;
    defparam d6s.note_data = "data/d6s.txt";
    note d6s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[48]),
        .q(q_d6s)
    );

	wire [7:0] q_e6;
    defparam e6.sample_cnt = 66;
    defparam e6.note_data = "data/e6.txt";
    note e6(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[49]),
        .q(q_e6)
    );

	wire [7:0] q_f6;
    defparam f6.sample_cnt = 63;
    defparam f6.note_data = "data/f6.txt";
    note f6(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[50]),
        .q(q_f6)
    );

	wire [7:0] q_f6s;
    defparam f6s.sample_cnt = 59;
    defparam f6s.note_data = "data/f6s.txt";
    note f6s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[51]),
        .q(q_f6s)
    );

	wire [7:0] q_g6;
    defparam g6.sample_cnt = 55;
    defparam g6.note_data = "data/g6.txt";
    note g6(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[52]),
        .q(q_g6)
    );

	wire [7:0] q_g6s;
    defparam g6s.sample_cnt = 53;
    defparam g6s.note_data = "data/g6s.txt";
    note g6s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[53]),
        .q(q_g6s)
    );

	wire [7:0] q_a6;
    defparam a6.sample_cnt = 50;
    defparam a6.note_data = "data/a6.txt";
    note a6(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[54]),
        .q(q_a6)
    );

	wire [7:0] q_a6s;
    defparam a6s.sample_cnt = 47;
    defparam a6s.note_data = "data/a6s.txt";
    note a6s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[55]),
        .q(q_a6s)
    );

	wire [7:0] q_b6;
    defparam b6.sample_cnt = 44;
    defparam b6.note_data = "data/b6.txt";
    note b6(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[56]),
        .q(q_b6)
    );

	wire [7:0] q_c7;
    defparam c7.sample_cnt = 42;
    defparam c7.note_data = "data/c7.txt";
    note c7(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[57]),
        .q(q_c7)
    );

	wire [7:0] q_c7s;
    defparam c7s.sample_cnt = 39;
    defparam c7s.note_data = "data/c7s.txt";
    note c7s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[58]),
        .q(q_c7s)
    );

	wire [7:0] q_d7;
    defparam d7.sample_cnt = 37;
    defparam d7.note_data = "data/d7.txt";
    note d7(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[59]),
        .q(q_d7)
    );

	wire [7:0] q_d7s;
    defparam d7s.sample_cnt = 35;
    defparam d7s.note_data = "data/d7s.txt";
    note d7s(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[60]),
        .q(q_d7s)
    );

	wire [7:0] q_e7;
    defparam e7.sample_cnt = 33;
    defparam e7.note_data = "data/e7.txt";
    note e7(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[61]),
        .q(q_e7)
    );

	wire [7:0] q_f7;
    defparam f7.sample_cnt = 31;
    defparam f7.note_data = "data/f7.txt";
    note f7(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[62]),
        .q(q_f7)
    );


    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            pwm_one <= 0;
        end else begin
            sum = 64'b0 + q_d2s + q_e2 + q_f2 + q_f2s + q_g2 + q_g2s + q_a2 + q_a2s + q_b2 + q_c3 + q_c3s + q_d3 + q_d3s + q_e3 + q_f3 + q_f3s + q_g3 + q_g3s + q_a3 + q_a3s + q_b3 + q_c4 + q_c4s + q_d4 + q_d4s + q_e4 + q_f4 + q_f4s + q_g4 + q_g4s + q_a4 + q_a4s + q_b4 + q_c5 + q_c5s + q_d5 + q_d5s + q_e5 + q_f5 + q_f5s + q_g5 + q_g5s + q_a5 + q_a5s + q_b5 + q_c6 + q_c6s + q_d6 + q_d6s + q_e6 + q_f6 + q_f6s + q_g6 + q_g6s + q_a6 + q_a6s + q_b6 + q_c7 + q_c7s + q_d7 + q_d7s + q_e7 + q_f7 - 64'd7552;
            if (sum < 0)
                sum = 0;
            if (sum >= 1024)
                sum = 1023;
            pwm_one <= sum;
        end
    end

//  paste content from code_gen_output.txt [End]

endmodule
