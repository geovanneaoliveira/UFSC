clear
clc
close all

% Euler Explícito

% Parâmetros

R = 1e3;
C = 5e-3;
dt = 1; % Passo

% Condição inicial

vo = 4;

% Tempo

t = 0:dt:20;
np = length(t);

% Laço de repetição

vc(1,1) = vo;

for k=1:np-1
  
  %vc(1,k+1) = (1-dt/(R*C))*vc(1,k); % Explícito
  vc(1,k+1) = inv((1+dt/(R*C)))*vc(1,k); % Implícito
  
end

vc'

stem(t,vc)