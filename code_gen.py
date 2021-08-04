# generate instantiation code of module `notes` to 'code_notes.txt'
# the result should be copied and pasted into the verilog source code 'instrument.v'

notes = ["d2s", "e2", "f2", "f2s", "g2", "g2s", "a2", "a2s", "b2", "c3", "c3s", "d3", "d3s", "e3", "f3", "f3s", "g3", "g3s", "a3", "a3s", "b3", "c4", "c4s", "d4", "d4s", "e4", "f4", "f4s", "g4", "g4s", "a4",
         "a4s", "b4", "c5", "c5s", "d5", "d5s", "e5", "f5", "f5s", "g5", "g5s", "a5", "a5s", "b5", "c6", "c6s", "d6", "d6s", "e6", "f6", "f6s", "g6", "g6s", "a6", "a6s", "b6", "c7", "c7s", "d7", "d7s", "e7", "f7"]

code_note = """
	wire [7:0] q_{};
    defparam {}.sample_cnt = {};
    defparam {}.note_data = "data/{}.txt";
    note {}(
        .clk_100mhz(clk),
        .clk_1000hz(clk_1000hz),
        .rst_n(rst_n),
        .sample_switch(sample_switch),
        .hold(hold[{}]),
        .q(q_{})
    );
"""

# synthesis the outputs of all notes by directly sum up
# note that the pwm period is actually 1023 rather than 255
# this can turn down the volume by 1/4, and avoid too much cutoff / precision loss caused by the narrow range (0~255).
code_synthesis = """
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            pwm_one <= 0;
        end else begin
            sum = 64'b0{};
            if (sum < 0)
                sum = 0;
            if (sum >= 1024)
                sum = 1023;
            pwm_one <= sum;
        end
    end
"""

with open('code_gen_output.txt', 'w') as f:
    l = []
    for i, note in enumerate(notes):
        with open('info/{}.info'.format(note), 'r') as t:
            cnt = int(t.readline())
        f.write(code_note.format(note, note, cnt, note, note, note, i, note))
        l.append(' + q_{}'.format(note))

    l.append(" - 64'd{}".format(128 * len(l) - 512))

    f.write('\n')
    f.write(code_synthesis.format("".join(l)))
