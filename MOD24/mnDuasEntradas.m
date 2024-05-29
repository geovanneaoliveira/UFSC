clc
close all
clear all

Ra = 0.1;
La = 0.1;
J = 10;
alpha = 0.1;
Br = 1;
x1o = 0;
x2o = 0;

dt = 0.001;
t = 0:dt:100;

A = [-Ra/La -alpha/La; alpha/J -Br/J];
B = [1/La 0; 0 -1/J];
C = [0 1];
D = [0 0];

Vin = 135 * heaviside(t);
Tc = 25 * heaviside(t-50);

sys = ss(A,B,C,D)
[y,t,x_lsim] = lsim(sys,[Vin' Tc'],t,[x1o; x2o;]);
subplot(2,1,1)
plot(t,x_lsim(:,1))
title('Corrente')
grid
subplot(2,1,2)
plot(t,x_lsim(:,2))
title('Velocidade')
grid

% Função de Yransferência W(s)/Vin(s)

FT = tf([alpha/(J*La)], [1 (Ra/La+Br/J) (alpha^2+Ra*Br)/(J*La)])

[num,den] = ss2tf(sys);

FT2 = tf(num(1,1),den(1,1))

