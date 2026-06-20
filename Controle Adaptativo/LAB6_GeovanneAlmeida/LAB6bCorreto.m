close all;
clear;
clc;

fs = 10;
T = 1/fs;

% ATENÇÃO: Descomente a linha abaixo se estiver utilizando o Octave
% pkg load control

% Planta
% ------------------------------------------------------
% Parâmetros do circuito RC duplo
R1 = 10e3;
R2 = 10e2;
R3 = 10e3;

C1 = 470e-6;
C2 = 10e-6;

% função de transferência
num = 1;
den = [R1*R2*C1*C2, R2*C2 + R1*C1*(1+R2/R3) + R1*C2, 1 + (R1+R2)/R3];
H = tf(num, den);

% função de transferência discretizada
Hz = c2d(H, 0.1, 'zoh');

b1 = Hz.num{1}(2);
b2 = Hz.num{1}(3);
a1 = Hz.den{1}(2);
a2 = Hz.den{1}(3);
% ------------------------------------------------------

% Parâmetros do controlador Dahlin
K_p   = 1;
tau_p = 2;
cp    = -exp(-T / tau_p);

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

% Variaveis do estimador MQR
rho    = 500;
P      = rho * eye(4);
v      = zeros(4,1);
theta  = zeros(4,N);
lambda = 0.95;


for k = 4:N

    % saida do sistema (já com o atraso adicional no sinal de controle)
    y(k) = b1*u(k-2) + b2*u(k-3) - a1*y(k-1) - a2*y(k-2);

    % Saída em malha aberta
    y_ma(k) = b1*u_ma(k-2) + b2*u_ma(k-3) - a1*y_ma(k-1) - a2*y_ma(k-2);

    % ESTIMADOR MQR
    phi = [u(k-2); u(k-3); -y(k-1); -y(k-2)];

    K_gain         = (P * phi) / (lambda + phi' * P * phi);
    theta(:,k)     = theta(:,k-1) + K_gain * (y(k) - phi' * theta(:,k-1));
    P              = (1/lambda) * (eye(4) - K_gain * phi') * P;

    % sinal de erro
    e(k) = r(k) - y(k);

    % CONTROLADOR
    if (tempo(k) <= 5)
        u(k) = r(k);
    else
        % Parâmetros estimados correntes
        b1e = theta(1,k);
        b2e = theta(2,k);
        a1e = theta(3,k);
        a2e = theta(4,k);

        % EQUACAO DO CONTROLADOR DAHLIN ADAPTATIVO
        if abs(b1e) < 1e-6
            u(k) = u(k-1);
        else
            u(k) = (K_p*(1+cp) / b1e)                 * e(k)   ...
                 + (K_p*(1+cp) * a1e / b1e)            * e(k-1) ...
                 + (K_p*(1+cp) * a2e / b1e)            * e(k-2) ...
                 - ((b1e*cp + b2e) / b1e)               * u(k-1) ...
                 + ((b1e*K_p*(1+cp) - b2e*cp) / b1e)   * u(k-2) ...
                 + (b2e*K_p*(1+cp) / b1e)               * u(k-3);
            u_ma(k) = r(k);
        end
    end

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

figure;
plot(tempo, theta(1,:),'LineWidth', 1.5);
hold on;
plot(tempo, theta(2,:),'LineWidth', 1.5);
plot(tempo, theta(3,:),'LineWidth', 1.5);
plot(tempo, theta(4,:),'LineWidth', 1.5);
legend('b_1', 'b_2', 'a_1', 'a_2');
grid on;