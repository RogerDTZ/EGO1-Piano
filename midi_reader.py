# convert midi file to the hold states of each note

# frames are doubled to solve the problem that a note may be pressed before it is released
# therefore, a new frame is added between any two adjacent original frames to perform the additional release

import mido

note_on = [[False for i in range(1024)] for j in range(120)]
note_off = [[False for i in range(1024)] for j in range(120)]


def print_midi(file_name):
    mid = mido.MidiFile(file_name + '.mid')
    note_min = 1000
    note_max = -1
    for i, track in enumerate(mid.tracks):
        if (track.name != 'FL Keys'):
            continue
        timer = 0
        for msg in track:
            if msg.type == 'note_on' or msg.type == 'note_off':
                timer += msg.time
                note_min = min(note_min, msg.note)
                note_max = max(note_max, msg.note)
                if msg.type == 'note_on':
                    note_on[msg.note][timer // 32] = True
                else:
                    note_off[msg.note][timer // 32] = True
    tick = timer // 32
    sheet = []
    hold = [False for i in range(120)]
    for t in range(tick + 1):
        if (t > 0):
            sheet.append(hold.copy())
        for note in range(120):
            if note_off[note][t] or (hold[note] and note_on[note][t]):
                sheet[len(sheet) - 1][note] = False
                hold[note] = False
            if note_on[note][t]:
                hold[note] = True
        sheet.append(hold.copy())

    with open('{}.txt'.format(file_name), 'w') as f:
        for state in sheet:
            for i in reversed(range(note_min, note_max + 1)):
                x = state[i]
                if (x == False):
                    f.write('0')
                else:
                    f.write('1')
            f.write('\n')


if __name__ == '__main__':
    print_midi('city of tears')
