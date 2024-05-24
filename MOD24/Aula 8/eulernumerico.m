clear
clc
close all

% Euler Expl�cito

% Par�metros

R = 1e3;
C = 5e-3;
dt = 1; % Passo

% Condi��o inicial

vo = 4;

% Tempo

t = 0:dt:20;
np = length(t);

% La�o de repeti��o

vc(1,1) = vo;

for k=1:np-1
  
  %vc(1,k+1) = (1-dt/(R*C))*vc(1,k); % Expl�cito
  vc(1,k+1) = inv((1+dt/(R*C)))*vc(1,k); % Impl�cito
  
end

vc'

stem(t,vc)