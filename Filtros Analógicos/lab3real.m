close all;
clear;
clc;

Av = 4;
Avn = 10^(4/20);

R1 = 100
R2 = 150

gain = -R2/R1

fc = 10e3;

C = 1/(2*pi*R2*fc)



%R=1/(10e3*2*pi*C)

