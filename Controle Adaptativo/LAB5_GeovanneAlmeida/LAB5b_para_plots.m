clear;
clc;

%% pkg load control;

% Arquivo com entrada e saida do sistema
load('ensaio_lab5_rls.mat')
x = u(:);
y = y(:);

%% Estimador de minimos quadrados recursivo
N = numel(x);

rho = 500;
P = rho*eye(4);
u = zeros(4,1);

theta = zeros(4,N);

lambda = 0.95;

for n = 3:N

    % Atualiza vetor u
    u = [x(n-1);  x(n-2); -y(n-1);  -y(n-2)];

    % Vetor de ganho h
    h = P*u/(lambda+u'*P*u);

    % Atualizacao dos parametros
    theta(:,n) = theta(:,n-1) + h*(y(n) - u.'*theta(:,n-1));

    % Atualizacao da matriz P
    P = (eye(4) - h*u')*P/lambda;

end

b1 = theta(1, end);
b2 = theta(2, end);
a1 = theta(3, end);
a2 = theta(4, end);

%% Sistema estimado
Ts = 1/fs;
Gz = tf([b1, b2], [1, a1, a2], Ts);

% Resposta do sistema
N = numel(x);
tempo = (0:N-1)*Ts;

ye = lsim(Gz, x, tempo);

t_1 = 17;
t_2 = 32;
 
%% Formatacao
set(groot, 'defaultAxesFontSize',   12, ...
           'defaultAxesFontName',   'Arial', ...
           'defaultTextFontName',   'Arial', ...
           'defaultLegendFontSize', 12);


%% Figura 1 - Evolucao dos parametros
figure;
stairs(tempo, theta');
hold on;
xline(t_1, 'k--', 'LineWidth', 1.2, 'HandleVisibility', 'off');
xline(t_2, 'k--', 'LineWidth', 1.2, 'HandleVisibility', 'off');
text(t_1 + 0.3, max(max(theta))*0.92, 'SW1', 'FontSize', 12);
text(t_2 + 0.3, max(max(theta))*0.92, 'SW2', 'FontSize', 12);
legend('b_1', 'b_2', 'a_1', 'a_2', 'Location', 'best');
xlabel('Tempo (s)');
ylabel('Parâmetros estimados');
title('Evolução temporal dos parâmetros estimados');
grid on;
 
%% Figura 2 - Saida experimental vs estimada
figure;
plot(tempo, y,  'LineWidth', 1.5, 'DisplayName', 'y(n) - Experimental');
hold on;
plot(tempo, ye,'--', 'LineWidth', 1.5, 'DisplayName', 'y(n) - Estimada');
xline(t_1, 'k--', 'LineWidth', 1.2, 'HandleVisibility', 'off');
xline(t_2, 'k--', 'LineWidth', 1.2, 'HandleVisibility', 'off');
text(t_1 + 0.3, max(y)*0.5, 'SW1', 'FontSize', 12);
text(t_2 + 0.3, max(y)*0.5, 'SW2', 'FontSize', 12);
legend('Location', 'best');
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Saída experimental vs. saída estimada');
grid on;
 
