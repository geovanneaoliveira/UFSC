clear
clc
close all

%% Exercicio Megaloblatta pt 2
% Mx'' + Bx' = f
% Mv' + Bv = f
% x1 = v -> x1' = v'
% v' = (f - bv)/M
% 1 tau = 63.2%
% 2 tau = 86.3%
% 3 tau = 95%
% 4 tau = 98.3%
% 5 tau = 99.3%

set(0,'defaultlineLinewidth',2)

t = 0:0.1:50;
f =@(t) 1;
b = 0.1;
M = 1;
x0 = 0;

figure(2);
hold on
dv =@(t,v) (f(t) - b*v(1))/M;
dvdt =@(t,v) [dv(t,v)];

[t,v] = ode45(dvdt, t, x0); % Metodo ODE
vrc = @(t) 1/b+(x0-1/b)*exp(-b/M*t); % Metodo analítico - feito na mão
va = vrc(t);

plot(t,v);
plot(t,va);

xlabel("Tempo [s]");
ylabel("Distância [m]");
legend('Distância ODE45 [m]', 'Distâcnia Analítico [m] ');
