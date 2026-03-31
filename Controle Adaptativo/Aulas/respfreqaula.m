clear all;
clc;

% octave
pkg load control

% sistema

H = tf(1, [0.1, 1])

% entrada

f = 10;
A = 2;

tmax = 2;
T = 0.01;
t = 0:T:tmax;

x = A*sin(2*pi*f*t)

% saida do sistema

y = lsim(H,x,t);

% saida teorica

yrm = 2*0.157*sin(2*pi*f*t - 1.41)

figure;
plot(t,x)
hold on;
plot(t,y,'k')
plot(t,yrm,'r--')
grid on;



