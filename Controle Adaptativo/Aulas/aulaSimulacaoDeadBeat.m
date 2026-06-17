clear;
clc;
close all;

%parametros desimulacao

T = 0.1;
tmax = 50;
tempo = 0:T:tmax;
N = numel(tempo);

%sinal de entrada

r = ones(1,N);
r(tempo < 2) = 0;
r(tempo >= 2 & tempo < 10) = 0.5;
r(tempo >= 10 & tempo < 20) = 0.75;
r(tempo >= 20 & tempo < 30) = 1.5;

% variaveis
y = zeros(1,N);
e = zeros(1,N);
u = zeros(1,N);

% iteracoes

for n = 6:N

    %saida da planta
    y(n) = 0.07993*u(n-5) + 0.9001 *y(n-1);

    % erro
    e(n) = r(n) - y(n);

    % sinal de controle
    u(n) = 12.511*e(n) - 11.261*e(n-1) + u(n-5);

end

figure; plot(tempo, r); hold on; plot(tempo, y, 'k'); grid on;
figure; plot(tempo, u); grid on;