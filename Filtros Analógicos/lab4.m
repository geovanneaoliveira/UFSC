close all;
clear;
clc;

R1 = 100
R2 = 100
R3 = 259
R4 = 1000

fc = 650;

gaindb = 2;
gainN = 10^(gaindb/20)

r4r3 = gainN - 1

C = 1/(2*pi*R1*R2*fc)

cN = sqrt(C)

%R = 1/(fc*2*pi*C1*C2)

