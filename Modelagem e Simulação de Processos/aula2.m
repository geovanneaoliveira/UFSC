clear
clc
close all

t = [0:1e-3:10];

u = @(t) sin(t);

%u = @(t) 1;
%entrada = u(t);

%plot(t,entrada)

xo =[0 0]

a = 1;
b = 1;
c = 1;

dx1 = @(t,x) x(2);
dx2 = @(t,x) (1/a)*(u(t)-b*x(2)-c*x(1));
dxdt = @(t,x) [dx1(t,x);dx2(t,x)];

[t,y] = ode45(dxdt,t,xo)

plot(t,y)
legend('x1', 'x2')

