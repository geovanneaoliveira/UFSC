clear
clc
close all

%ENTRADA
t = 0:1e-3:10
xo = 0;
f = @(t) 1;
%u = @(t) sin(t);

%PARAMETROS
B = 1;
M = 1;

%ODEs

dv = @(t,v)(f(t)-B*v(1))*(1/M);
dvdt = @(t,v) [dv(t,v)];

%SOLUÇAO
[t,v] = ode45(dvdt,t,xo)

plot(t,v)