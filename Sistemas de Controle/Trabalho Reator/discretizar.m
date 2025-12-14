%% Discretizar
clc
clear
close all
s = tf("s");
C = (1.851593965*s + 3.549490385)/(s)
Ts = 0.08;
Cz = c2d(C, Ts, 'zoh')
