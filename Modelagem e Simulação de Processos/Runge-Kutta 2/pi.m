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

%CI

A = [-5, 1];
