clear;
clc;

load('Sistema_1.mat')
fs = Data.frequencia_amostragem;
T = 1/fs;

ind = 1;
x = Data.Entradas{ind};
y = Data.Respostas{ind};

N = numel(x);
tempo = (0:N-1)*T;

figure;
plot(tempo, x, 'b');
hold on;
plot(tempo, y , 'k');
grid on;

