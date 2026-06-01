clear;
clc;

% Arquivo com entrada e saida do sistema
load('mq_sistema_1.mat');
N = numel(x);

%% Estimador de minimos quadrados
L = 20     % numero de amostras utilizadas na estimacao

% equação a diferenças

ul = [x(1:L).' ; -y(1:L).']

UL = (ul(:,1:L).');
yL = y(2:L+1)

theta = inv((UL.'*UL))*UL.'*yL
b1 = theta(1);
a1 = theta(2);

%% Sistema estimado
Ts = 1/fs;
Gz = tf(b1, [1, a1], Ts);

% Resposta do sistema
N = numel(x);
tempo = (0:N-1)*Ts;

ye = lsim(Gz, x, tempo);

%% Apresentação dos resultados

figure;

plot(tempo, y, 'b', 'LineWidth', 1.8);
hold on;

plot(tempo, ye, 'r--', 'LineWidth', 1.8);

grid on;
box on;

xlabel('Tempo (s)', 'FontSize', 12);
ylabel('Amplitude', 'FontSize', 12);

title('Comparação entre a saída real e a saída estimada', 'FontSize', 14);

legend({'Saída real y(n)', 'Saída estimada \ity_e(n)'}, 'Location', 'best','FontSize', 11);

set(gca, 'FontSize', 11);