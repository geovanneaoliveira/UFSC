close all;
clear;
clc;

% ATENÇÃO: Descomente a linha abaixo se estiver utilizando o Octave
% pkg load control

% ------------------------------------------------------
% Carrega os dados obtidos no ENSAIO REAL (Atividade 4a),
% em vez de simular a planta com a equação a diferenças.
%
% Variáveis disponíveis em 'ensaio_lab6_atividade4a.mat':
%   r  -> sinal de referência aplicado          [1xN]
%   y  -> saída medida da planta (circuito RC)  [Nx1]
%   u  -> sinal de controle aplicado à planta   [Nx1]
%   e  -> sinal de erro (r - y)                 [Nx1]
%   fs -> frequência de amostragem utilizada    [Hz]
% ------------------------------------------------------
dados = load('ensaio_lab6_atividade4aJonny.mat');

fs = dados.fs;
T  = 1/fs;

% Garante que todos os sinais estejam como vetores linha,
% independente de como foram salvos no .mat
r = dados.r(:).';
y = dados.y(:).';
u = dados.u(:).';
e = dados.e(:).';

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