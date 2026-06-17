clear;
clc;
close all;

% Arquivo com entrada e saida do sistema
load('mqr_sistema_1.mat');
x = x(:);
y = y(:);

%% Estimador de minimos quadrados recursivo
N = numel(x);

rho = 1; % valor para ajustar
P = rho*eye(2);
u = zeros(2,1);

theta = zeros(2,N);

for n = 2:N

    % Atualizar vetor u
    u = [x(n-1); -y(n-1)];
    
    % Vetor de ganho h
    h = P*u/(1+u'*P*u);

    % Atualizacaoo dos parametros
    theta(:,n) = theta(:,n-1) + h*(y(n)-u.'*theta(:,n-1));

    % Atualizacao da matriz P
    P = (eye(2)-h*u')*P;


end

b1 = theta(1, end);
a1 = theta(2, end);

%% Sistema estimado
Ts = 1/fs;
Gz = tf(b1, [1, a1], Ts);

% Resposta do sistema
N = numel(x);
tempo = (0:N-1)*Ts;

ye = lsim(Gz, x, tempo);

 
%% Figura 1 - Convergencia dos parametros
figure;
stairs(tempo, theta','LineWidth', 1.5);
legend('b_1', 'a_1','Location', 'best');
xlabel('Tempo (s)');
ylabel('Valor do parâmetro');
title(['Convergência dos parâmetros estimados - \rho = ' num2str(rho)]);
grid on;

%% Figura 2 - Validacao do modelo
figure;
plot(tempo, y,'LineWidth', 1.5, 'DisplayName', 'y(n) - Experimental');
hold on;
plot(tempo, ye,'k:' ,'LineWidth', 1.5, 'DisplayName', 'y(n) - Estimada');
xlabel('Tempo (s)');
ylabel('Amplitude');
title(['Validação do modelo - \rho = ' num2str(rho)]);
legend('Location', 'best');
grid on;

