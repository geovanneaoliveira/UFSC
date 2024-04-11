clc
clear
close all

% Parametros

M = 1;
B = 10;
K = 2;
x = [0;0]

% Entrada

t = 0:0.1:50
u = @(t) 1;
f = @(t) 10;

dx1 = @(t,x) x(2);
dx2 = @(t,x) -1/M*(B*x(2) + K*x(1) - u(t));
dxdt = @(t,x) [dx1(t,x); dx2(t,x)];

% solucao

[t,x2] = ode45(dxdt,t,x);

%figure
%plot(t,x2)
%grid
%legend('x1','x2')

ta = 5*B/2*M
csi = (B/(2*M)) * sqrt(K/M)

% SOBREAMORTECIDO

B = 3;
M = 1;
K = 1;

dx2 = @(t,x) -1/M*(B*x(2) + K*x(1) - u(t));
dxdt = @(t,x) [dx1(t,x); dx2(t,x)];

% solucao

[t,x2] = ode45(dxdt,t,x);

figure
plot(t,x2)
title("SOBREAMORTECIDO")
grid
legend('x1','x2')

% SUBAMORTECIDO

B = 2;
M = 1;
K = 2;

dx2 = @(t,x) -1/M*(B*x(2) + K*x(1) - u(t));
dxdt = @(t,x) [dx1(t,x); dx2(t,x)];

% solucao

[t,x2] = ode45(dxdt,t,x);

figure
plot(t,x2)
title("SUBAMORTECIDO")
grid
legend('x1','x2')

% CRITICAMENTE AMORTECIDO

B = 2;
M = 1;
K = 1;

dx2 = @(t,x) -1/M*(B*x(2) + K*x(1) - u(t));
dxdt = @(t,x) [dx1(t,x); dx2(t,x)];

% solucao

[t,x2] = ode45(dxdt,t,x);

figure
plot(t,x2)
title("CRITICAMENTE AMORTECIDO")
grid
legend('x1','x2')

% OSCILATÓRIO

B = 0;
M = 1;
K = 1;

dx2 = @(t,x) -1/M*(B*x(2) + K*x(1) - u(t));
dxdt = @(t,x) [dx1(t,x); dx2(t,x)];

% solucao

[t,x2] = ode45(dxdt,t,x);

figure
plot(t,x2)
title("OSCILATÓRIO")
grid
legend('x1','x2')



