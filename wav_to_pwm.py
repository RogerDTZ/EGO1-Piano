import numpy as np
import wave
import os

# EGO1 clock frequency = 100MHz
sys_clk = 100000000

# PWM period = 255 sys_clk (8 bit precision)
pwm_factor = 255


def wav_to_pwm(name):
    with wave.open('notes/{}.wav'.format(name), 'rb') as wav:
        n_channels, sample_width, frame_rate, n_frames, _, _ = wav.getparams()
        assert sample_width in (1, 2)
        pcm = wav.readframes(n_frames)

    pcm = np.fromstring(pcm, np.int16).astype(np.float)
    pcm = pcm.reshape(n_frames, n_channels)[:, 0]

    # convert wav sample points to percentage data (relative to the lowest and highest sample point)
    min_v = np.min(pcm)
    max_v = np.max(pcm)
    percentage = (pcm - min_v) / (max_v - min_v)

    # convert percentage data to high level time (how many clocks should the speaker stays 1 during the 255-clock PWM period)
    res = []
    for i in range(n_frames):
        rate = percentage[i]
        high = int(round(rate * pwm_factor))
        res.append(high)

    if not os.path.exists('info'):
        os.mkdir('info')
    if not os.path.exists('data'):
        os.mkdir('data')

    # output frame count
    with open('info/{}.info'.format(name), 'w') as f:
        f.write(str(len(res)))
    # output binary data that can be directly loaded into a register by verilog through #readmemb
    with open('data/{}.txt'.format(name), 'w') as f:
        for x in res:
            f.write('{:08b}\n'.format(x))


if __name__ == '__main__':
    notes = ["d2s", "e2", "f2", "f2s", "g2", "g2s", "a2", "a2s", "b2", "c3", "c3s", "d3", "d3s", "e3", "f3", "f3s", "g3", "g3s", "a3", "a3s", "b3", "c4", "c4s", "d4", "d4s", "e4", "f4", "f4s", "g4", "g4s", "a4",
             "a4s", "b4", "c5", "c5s", "d5", "d5s", "e5", "f5", "f5s", "g5", "g5s", "a5", "a5s", "b5", "c6", "c6s", "d6", "d6s", "e6", "f6", "f6s", "g6", "g6s", "a6", "a6s", "b6", "c7", "c7s", "d7", "d7s", "e7", "f7"]
    for note in notes:
        wav_to_pwm(note)
    # to be continue
    # wav_to_pwm("tbc_cut_low")
