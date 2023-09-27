clear
clc
close all

% Tempo

dt = 1e-3;
tf = 10;
t = [0:dt:tf];
np = tf/dt;

% Entrada

u = @(t) 1 +0*t;

A = [0 1; -1 -2;];
B = [0; 1;];
C = [1 0];
D = 0;

sys = ss(A,B,C,D);

[y,t,x_lsim] = lsim(sys,u(t),t,[0; 0;]);

plot(t,x_lsim,'--')



