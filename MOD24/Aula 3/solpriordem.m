#{
  Aula 3
  Resolucao de sistemas utilizando o octave.
#}

clear
clc
close all

% Parametros
M = 0.5;
B = 0.5;

% CI

vo = 0;

% Entrada

f = @(t) 1;

% EDO

dv = @(t,v) -B/M*v + f(t)/M;

% Solucao

[t,v] = ode45(dv,[0:0.1:10],vo)

% Grafico

figure
plot(t,v)
title('Exercicio 1')
xlabel('Tempo (s)')
ylabel('Velocidade (m/s)')
grid
hold

% Com base na FT no quadro

tau = M/B;
ta = 5*tau;
Gcc = 1/B;

%%%%%%%%%%%% Solucao Analitica %%%%%%%%%%%%%%

va = @(t) 1/B - 1/B * exp(-B/M*t) + vo * exp(-B/M*t);
ran = va(t)
plot(t,ran,'x')

erro = (ran - v);

figure
subplot(2,1,1)
plot(t,ran,'x')
hold
plot(t,v,'o')
grid
legend('Analitico','Numerico')
xlabel('Tempo')
subplot(2,1,2)
plot(t,erro)
xlabel('Tempo')


