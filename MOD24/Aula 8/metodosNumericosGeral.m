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

t = 0:dt:5;
np = length(t);

% La�o de repeti��o

vcExp(1,1) = vo;
vcImp(1,1) = vo;
vcRK2mi(1,1) = vo;
vcRK2h(1,1) = vo;

for k=1:np-1
  
  vcExp(1,k+1) = (1-dt/(R*C))*vcExp(1,k); % Expl�cito
  
  vcImp(1,k+1) = inv((1+dt/(R*C)))*vcImp(1,k); % Impl�cito
  
  % Ponto Intermedi�rio
  m1RK2mi = (-1/(R*C)) * vcRK2mi(1,k);
  m2RK2mi = (-1/(R*C)) *(vcRK2mi(1,k) + (dt/2) * m1RK2mi);
  vcRK2mi(1,k+1) = vcRK2mi(1,k)+ m2RK2mi * dt;
    
  # Heun 
  m1RK2h = (-1/(R*C)) * vcRK2h(1,k);
  m2RK2h = (-1/(R*C))*(vcRK2h(1,k)+ dt * m1RK2h);
  vcRK2h(1,k+1) = vcRK2h(1,k) + (((m1RK2h /2)+(m2RK2h/2)) * dt);
  
end

[vcExp; vcImp; vcRK2mi; vcRK2h]'

stem(t,vcExp)
hold on
stem(t,vcImp)
stem(t,vcRK2mi)
stem(t,vcRK2h,'x')
grid
legend("Expl�cito","Impl�cito","Ponto Intermedi�rio","Heun")