%% DPZ discreto
clc
clear 
close all
s = tf('s');
C = (1.85159*(s + 1.916991766))/(s);
G = (0.28975*(-s + 4.05651))/(s + 1.6334);
Yr = (C*G)/(1 + C*G);
pzmap(Yr)