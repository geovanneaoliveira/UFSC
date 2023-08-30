clear
clc
close all

%ENTRADA
t = 0:1e-3:10;
xo = [0 0];
f = @(t) 10;
%u = @(t) sin(t);

%PARAMETROS
B = 10;
M = 1;
K = 2;

%ODEs
%Mx'' + Bx' + Kx = f
%X1 = x -> X1' = x' = x2
%X2 = x'-> X2' = (f - BX2 -KX1)/M

dx1 = @(t,x) x(2);
dx2 = @(t,x) (1/M)*(f(t)-B*x(2)-K*x(1));
dxdt = @(t,x) [dx1(t,x);dx2(t,x)];

%SOLUÇAO
[t,y2] = ode45(dxdt,t,xo);

plot(t,y2);
legend('x1', 'x2');