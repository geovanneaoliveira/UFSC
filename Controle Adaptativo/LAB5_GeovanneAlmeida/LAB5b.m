clear;
clc;

%% pkg load control;

% Arquivo com entrada e saida do sistema
load('ensaio_lab5_rls.mat')
x = u(:);
y = y(:);

%% Estimador de minimos quadrados recursivo
N = numel(x);

rho = 100;
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

%% Apresentacao dos resultados
figure;
stairs(tempo, theta');
legend('b_1', 'b_2', 'a_1', 'a_2');
xlabel('tempo (s)');
grid on;

figure;
plot(tempo, y);
hold on;
plot(tempo, ye, 'k:');
xlabel('tempo (s)');
