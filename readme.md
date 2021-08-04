
<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [1. 简介](#1-简介)
- [2. 工作流程](#2-工作流程)
  - [2.1. 音色处理和导入](#21-音色处理和导入)
  - [2.2. 曲谱的录入](#22-曲谱的录入)
- [3. 设计结构](#3-设计结构)
- [4. 彩蛋](#4-彩蛋)

<!-- /code_chunk_output -->


# 1. 简介

本项目是一位verilog初学者所作，实现方式或许较暴力（?轻喷

系统内置63个钢琴音符的单段波形，精度为8bit。通过反复播放同一波形并辅以ADSR音量包络，较好地还原了钢琴/电钢琴的效果
钢琴支持多个音符同时播放，且附带自动演奏功能

需要接入键盘和耳机使用。键盘`zsxdcvgbhnjm,`对应`C4`八度，`q2w3er5t6y7ui`对应`C5`八度。七段数码管会显示最后按下的音符名
按下`]`开始自动弹奏泪水之城(city of tears)，按下`[`停止播放

由于实现上的经验不足，键盘的多键存在很大的冲突问题且时不时会卡bug，待解决

# 2. 工作流程

## 2.1. 音色处理和导入

1. 用FL Studios的FL Keys弹奏63个音符，导出为`notes/piano_note_samples.wav`，再手动取各音符单段波形，保存为`notes/xxx.wav`
2. 运行`wav_to_pwm.py`将各音符波形转化为PWM信号，导出为`data/xxx.txt`（pwm信号）和`info/xxx.info`（音符波形长度）
3. 运行`code_gen.py`自动生成所有音符的例化代码与音符输出合成代码，结果存在`code_gen_output.txt`中，将所有代码拷贝至设计文件`instrument.v`的对应部分
4. 将`data`目录下的所有PWM信号文件拷贝至verilog项目的设计文件夹下，与`note.v`等文件处于同一位置

## 2.2. 曲谱的录入

1. 用FL Studios敲谱，输出MIDI文件
2. 运行`midi_reader.py`，将MIDI文件转化为所有按键关于时间的按下状态。泪城的节奏及其丰富，有大量旋律穿插，直接输出的MIDI存在许多某些音符还未松开就再次按下的情况。为了不被吞音，我选择在每两个原帧之间插入一个新帧，用于加入额外的松键指令。这样`note`模块就能模拟出真实弹奏时的效果
3. 将2.生成的曲谱`city of tears.txt`拷贝至verilog项目的设计文件夹下，与`player.v`等文件处于同一位置


# 3. 设计结构

![](https://raw.githubusercontent.com/RogerDTZ/EGO1-Piano/main/structure.png)

# 4. 彩蛋

项目内置了to be continue的波形文件，试着用note模块魔改或直接实现一个PWM播放器把经典片段播放出来吧 XD
