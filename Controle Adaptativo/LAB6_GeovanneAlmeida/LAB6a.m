close all;
clear;
clc;

% ATENÇÃO: Descomente a linha abaixo se estiver utilizando o Octave
% pkg load control

fs = 10;
T = 1/fs;

% Planta
% ------------------------------------------------------
% Parâmetros do circuito RC duplo
R1 = 10e3;
R2 = 1e3;
R3 = 10e3;

C1 = 470e-6;
C2 = 10e-6;

% função de transferência
num = 1;
den = [R1*R2*C1*C2, R2*C2 + R1*C1*(1+R2/R3) + R1*C2, 1 + (R1+R2)/R3]; % estava r1*r1?
H = tf(num, den);

% função de transferência discretizada
Hz = c2d(H, 0.1, 'zoh');

b1 = Hz.num{1}(2);
b2 = Hz.num{1}(3);
a1 = Hz.den{1}(2);
a2 = Hz.den{1}(3);
% ------------------------------------------------------

% Parâmetros do controlador Dahlin
% Especificações de malha fechada: K' = 1, tau' = 2 s, d = 1
K_p   = 1;
tau_p = 2;
cp    = -exp(-T / tau_p);   % c' = -exp(-T/tau') ≈ -0.9512

% Sinal de entrada
tmax = 60;
tempo = 0:T:(tmax-T);
N = numel(tempo);

r = zeros(1,N);
r(tempo < 15)                    = 0.5;
r(tempo >= 15 & tempo < 30)      = 1.25;
r(tempo >= 30 & tempo < 45)      = 0.75;
r(tempo >= 45 & tempo < 60)      = 0;

% Variaveis
y = zeros(1,N);
u = zeros(1,N);
e = zeros(1,N);
y_ma = zeros(1,N);
u_ma = zeros(1,N);

for k = 4:N

    % saida do sistema (já com o atraso adicional no sinal de controle)
    y(k) = b1*u(k-2) + b2*u(k-3) - a1*y(k-1) - a2*y(k-2);

    % Saída em malha aberta
    y_ma(k) = b1*u_ma(k-2) + b2*u_ma(k-3) - a1*y_ma(k-1) - a2*y_ma(k-2);

    % sinal de erro
    e(k) = r(k) - y(k);

    % CONTROLADOR DAHLIN
    u(k) = - ((b1*cp + b2) / b1)                 * u(k-1) ...
         + ((b1*K_p*(1+cp) - b2*cp) / b1)      * u(k-2) ...
         + (b2*K_p*(1+cp) / b1)                * u(k-3) ...
         + (K_p*(1+cp) / b1)                  * e(k)   ...
         + (K_p*(1+cp) * a1 / b1)              * e(k-1) ...
         + (K_p*(1+cp) * a2 / b1)              * e(k-2);

    u_ma(k) = r(k);
end

% Resultados
figure;
plot(tempo, r, 'color', 'k','LineWidth', 1.5);
hold on;
plot(tempo, y, 'color', [1 0.4 0.4],'LineWidth', 1.5);
plot(tempo, y_ma, 'color', 'b','LineWidth', 1.5);
legend('Referência', 'Saída','Malha Aberta');
grid on;

figure;
plot(tempo, e,'LineWidth', 1.5);
hold on;
plot(tempo, u,'LineWidth', 1.5);
legend('Sinal de erro', 'Sinal de controle');
grid on;
