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

dt = 0.01;
t = 0:dt:100;

A = [-Ra/La -alpha/La; alpha/J -Br/J];
B = [1/La 0; 0 -1/J];
C = [0 1];
D = [0 0];

Vin = 135 * heaviside(t);
Tc = 25 * heaviside(t-50);

sys = ss(A,B,C,D)
[y,t,x_lsim] = lsim(sys,[Vin' Tc'],t,[x1o; x2o;]);


% Função de Transferência W(s)/Vin(s)

FT = tf([alpha/(J*La)], [1 (Ra/La+Br/J) (alpha^2+Ra*Br)/(J*La)])

[num,den] = ss2tf(sys);

FT2 = tf(num(1,1),den(1,1))

%%% Euler

np = length(t);

n = size(A,1);
m = size(B,2);

u = [Vin;
     Tc];
   
x = zeros(n,1);

for k=1:np-1
  
  x(:,k+1) = (eye(n) + dt * A) * x(:,k) + dt * B * u(:,k);
  
end

%%% RK2 Ponto Intermediário 

xrk2 = zeros(n,1);
urk2 = @(t) [Vin(t); Tc(t)];

for k=1:np-1
  m1(:,k) = A * xrk2(:,k) + B*urk2((k-1)*dt);
  m2(:,k) = A * xrk2(:,k) + 0.5 * dt * m1(:,k) + B * urk2((k-1+0.5)*dt);
  xrk2(:,k+1) = xrk2(:,k) + dt * m2(:,k);
   
end

%%% Plots

subplot(2,1,1)
plot(t,x_lsim(:,1),"--")
hold on
plot(t,x(1,:))
legend('I(Lsim)','I(Euler)')
title('Corrente')
grid

subplot(2,1,2)
plot(t,x_lsim(:,2),"--")
hold on
plot(t,x(2,:))
legend('Velocidade(Lsim)','Velocidade(Euler)')
title('Velocidade')
grid

figure
plot(t,xrk2)