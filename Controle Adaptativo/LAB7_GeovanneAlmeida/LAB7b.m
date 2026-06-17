clear;
clc;

fs = 10;
T = 1/fs;

% ATENÇÃO: Descomente a linha abaixo se estiver utilizando o Octave
% pkg load control

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

% Variaveis do estimador MQR
rho = 500;
P = rho*eye(4);
v = zeros(4,1);
theta = zeros(4,N);
lambda = 0.95;


for k = 3:N

    % saida do sistema (já com o atraso adicional no sinal de controle)
    y(k) = b1*u(k-2) + b2*u(k-3) - a1*y(k-1) - a2*y(k-2);

    % ESTIMADOR MQR


    % sinal de erro
    e(k) = r(k) - y(k);

    % CONTROLADOR
    if (tempo(k) <= 5)
        u(k) = r(k);
    else
        b1e = theta(1,k);
        a1e = theta(2,k);

        % EQUACAO DO CONTROLADOR RST ADAPTATIVO
    end
end

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
plot(tempo, theta(:,1));
hold on;
plot(tempo, theta(:,2));
plot(tempo, theta(:,3));
plot(tempo, theta(:,4));
legend('b_1', 'b_2', 'a_1', 'a_2');
grid on;

