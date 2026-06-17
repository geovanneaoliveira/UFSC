clear;
clc;

% ATENÇÃO: Descomente a linha abaixo se estiver utilizando o Octave
% pkg load control

fs = 10;
T = 1/fs;

% Planta
% ------------------------------------------------------
% Parâmetros do circuito RC duplo
R1 = %PREENCHA AQUI
R2 = %PREENCHA AQUI
R3 = %PREENCHA AQUI

C1 = %PREENCHA AQUI
C2 = %PREENCHA AQUI

% função de transferência
num = 1;
den = [R1*R1*C1*C2, R2*C2 + R1*C1*(1+R2/R3) + R1*C2, 1 + (R1+R2)/R3];
H = tf(num, den);

% função de transferência discretizada
Hz = c2d(H, 0.1, 'zoh');

b1 = Hz.num{1}(2);
b2 = Hz.num{1}(3);
a1 = Hz.den{1}(2);
a2 = Hz.den{1}(3);
% ------------------------------------------------------

% Sinal de entrada
tmax =60;
tempo = 0:T:(tmax-T);
N = numel(tempo);

r = zeros(1,N);
r(tempo < 15) = 0.5;
r(tempo >= 15 & tempo < 30) = 1.25;
r(tempo >= 30 & tempo < 45) = 0.75;
r(tempo >= 45 & tempo < 60) = 0;

% Variaveis
y = zeros(1,N);
u = zeros(1,N);
e = zeros(1,N);

for k = 4:N

    % saida do sistema (já com o atraso adicional no sinal de controle)
    y(k) = b1*u(k-2) + b2*u(k-3) - a1*y(k-1) - a2*y(k-2);

    % sinal de erro
    e(k) = r(k) - y(k);

    % CONTROLADOR RST

end

% Resultados
figure;
plot(tempo, r, 'color', 'k');
hold on;
plot(tempo, y, 'color', [1 0.4 0.4]);
legend('referência', 'saída');
grid on;

figure; plot(tempo, e);
hold on;
plot(tempo, u);
legend('sinal de erro', 'sinal de controle');
grid on;

