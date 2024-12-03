clear
close all
clc

% Parâmetros

M = 0.1;
B = 0.1;
L = 0.5;
g = 10;

% Tempo

dt = 0.001;
t = 0:dt:10;
np = length(t);

% Entrada

tau = 0.1*heaviside(t) + 0.01 * heaviside(t-5);

% Euler explícito

x(1,1) = 0;
x(2,1) = 0;

for k=1:np-1
  
  x(1,k+1) = x(1,k) + dt*(x(2,k));
  x(2,k+1) = x(2,k) + dt*(-g*sin(x(1,k))/L - B/(M*L^2)*x(2,k) + tau(k)/(M*L^2));
  
end

figure
subplot(2,1,1)
plot(t,x(1,:),'linewidth',3)
title('Deslocamento angular')
subplot(2,1,2)
plot(t,x(2,:),'linewidth',3)
title('Velocidade angular')

