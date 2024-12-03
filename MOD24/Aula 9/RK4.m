clc
close all
clear

% Runge Kutta 4

% Parâmetros

R = 1e3;
C = 5e-3;
dt = 1; % Passo

% Condição inicial

vo = 4;

t = 0:dt:5;

np = length(t)

vc(1,1) = vo;

for k=1:np-1
  m1 = (-1/(R*C))*vc(1,k);
  m2 = (-1/(R*C))*(vc(1,k)+ (dt/2) * m1);
  m3 = (-1/(R*C))*(vc(1,k)+ (dt/2) * m2);
  m4 = (-1/(R*C))*(vc(1,k)+ dt * m3);
  vc(1,k+1) = vc(1,k) + (((m1/6)+(m2/3)+(m3/3)+(m4/6)) * dt);  
end
vc'
stem(t,vc)