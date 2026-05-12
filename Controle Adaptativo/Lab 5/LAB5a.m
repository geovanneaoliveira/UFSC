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
    h = P*u / (1 + u'*P*u);

    e = y(n) - u'*theta(:,n-1)

    % Atualizacaoo dos parametros
    theta(:,n) = theta(:,n-1) + h*(y(n) - u.'*theta(:,n-1));

    % Atualizacao da matriz P
    P = (eye(2) - h*u')*P;


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

%% Apresentacao dos resultados
figure;
stairs(tempo, theta');
legend('b_1', 'a_1');
xlabel('tempo (s)');
grid on;

figure;
plot(tempo, y);
hold on;
plot(tempo, ye, 'k:');
xlabel('tempo (s)');
