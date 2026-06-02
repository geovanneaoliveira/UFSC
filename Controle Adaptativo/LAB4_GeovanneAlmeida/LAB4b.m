clear all;
clc;
close all;

% Arquivo com entrada e saida do sistema
load('ensaio_lab4.mat');

x = x(:)
y = y(:)

%% Estimador de minimos quadrados
L = 320;       % numero de amostras utilizadas na estimacaoo

ul = [x(1:L-1).' ; -y(1:L-1).'];

UL = (ul(:,1:L-1).');
yL = y(2:L);

theta = inv((UL.'*UL))*UL.'*yL
b1 = theta(1);
a1 = theta(2);

%% Sistema estimado
Ts = 1/fs;
Gz = tf([0 b1], [1, a1], Ts, 'Variable', 'z^-1')

% Resposta do sistema
N = numel(x);
tempo = (0:N-1)*Ts;

ye = lsim(Gz, x, tempo);

%% Apresentacao dos resultados
figure;
plot(tempo, y, 'b', 'LineWidth', 1.8);
hold on;
plot(tempo, ye, 'r--', 'LineWidth', 1.8);
grid on;
box on;
xlabel('Tempo (s)', 'FontSize', 11);
ylabel('Amplitude', 'FontSize', 11);
legend({'Experimental','Estimado'},'Location', 'best','FontSize', 11);
set(gca, 'FontSize', 11);