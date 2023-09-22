clear
clc
close all

A = [-1 0;0 -10];
B = [1; 0];
C = [1 0];
D = 0;

sys = ss(A,B,C,D)

%POLINOMIO
num = [1 1 5];
den = [1 6 11 6];

%H
FT = tf(num,den)

% poly([-1 -2 -3])
% raizes para achar polinomios

%pole([FT])
%step(FT)
t=0:1e-4:1;
y_ft = impulse(FT,t);
figure
plot(t,y_ft)

%y_ss = step(sys,t);
y_ss = impulse(sys,t);
figure
plot(t,y_ss)

%%%%LSIM

u = sin(2*pi*60*t);
figure
lsim(FT,u,t)
bode(sys)

%%%%%%%%%

[A2,B2,C2,D2] = tf2ss(FT)
sys2 = ss(A2,B2,C2,D2)

[num,den] = ss2tf(sys2)
FT2 = tf(num,den)




