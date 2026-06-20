close all;
clear;
clc;

% ATENÇÃO: Descomente a linha abaixo se estiver utilizando o Octave
% pkg load control

% ------------------------------------------------------
% Carrega os dados obtidos no ENSAIO REAL (Atividade 4b),
% em vez de simular a planta e rodar o estimador MQR (RLS).
%
% Variáveis disponíveis em 'ensaio_lab6_atividade4b.mat':
%   r      -> sinal de referência aplicado          [1xN]
%   y      -> saída medida da planta (circuito RC)  [Nx1]
%   u      -> sinal de controle aplicado à planta   [Nx1]
%   e      -> sinal de erro (r - y)                 [Nx1]
%   theta  -> parâmetros estimados pelo MQR a cada
%             instante: linhas = [b1; b2; a1; a2]    [4xN]
%   fs     -> frequência de amostragem utilizada    [Hz]
%   rho    -> fator de inicialização da matriz P
%   lambda -> fator de esquecimento do MQR
% ------------------------------------------------------
dados = load('ensaio_lab6_atividade4b.mat');

fs     = dados.fs;
T      = 1/fs;
rho    = dados.rho;
lambda = dados.lambda;

% Garante que os sinais estejam como vetores linha,
% independente de como foram salvos no .mat
r = dados.r(:).';
y = dados.y(:).';
u = dados.u(:).';
e = dados.e(:).';

theta = dados.theta;   % já vem como 4xN (b1, b2, a1, a2 por linha)

N     = numel(r);
tempo = (0:N-1) * T;

% Resultados
figure;
plot(tempo, r, 'color', 'k');
hold on;
plot(tempo, y, 'color', [1 0.4 0.4]);
legend('referência', 'saída');
grid on;

figure;
plot(tempo, e);
hold on;
plot(tempo, u);
legend('sinal de erro', 'sinal de controle');
grid on;

figure;
plot(tempo, theta(1,:));
hold on;
plot(tempo, theta(2,:));
plot(tempo, theta(3,:));
plot(tempo, theta(4,:));
legend('b_1', 'b_2', 'a_1', 'a_2');
grid on;