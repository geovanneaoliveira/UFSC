clear;
clc;

load('Sistema_1.mat');
fs = Data.frequencia_amostragem;
freq = Data.frequencia_senoides;

k = 1;
x = Data.Entradas{k};
y = Data.Respostas{k};

Ts = 1/fs;
tempo = (0:numel(x)-1)*Ts;

figure;
plot(tempo, x, 'k');
hold;
plot(tempo, y, 'b--');
grid on;
xlabel('tempo (s)');




