clear;
clc;
close all;

load('mqr_sistema_1.mat');
x = x(:);
y = y(:);

%% Formatacao

rhos = [0.1, 1, 10, 100];
Ts   = 1/fs;
tempo = (0:numel(x)-1)*Ts;

figure;
sgtitle('Convergência dos parâmetros estimados', 'FontSize', 12);

figure2 = figure;
sgtitle('Validação do modelo identificado', 'FontSize', 12);

for k = 1:4
    rho = rhos(k);
    N   = numel(x);
    P   = rho*eye(2);
    u   = zeros(2,1);
    theta = zeros(2,N);

    for n = 2:N
        u = [x(n-1); -y(n-1)];
        h = P*u / (1 + u'*P*u);
        theta(:,n) = theta(:,n-1) + h*(y(n) - u.'*theta(:,n-1));
        P = (eye(2) - h*u') * P;
    end

    b1 = theta(1, end);
    a1 = theta(2, end);

    Gz = tf(b1, [1, a1], Ts);
    ye = lsim(Gz, x, tempo);

    %% Figura 1 - subplot convergencia
    figure(1);
    subplot(2,2,k);
    stairs(tempo, theta(1,:), 'b-',  'LineWidth', 1.5, 'DisplayName', 'b_1');
    hold on;
    stairs(tempo, theta(2,:), 'r--', 'LineWidth', 1.5, 'DisplayName', 'a_1');
    xlabel('Tempo (s)');
    ylabel('Parâmetro');
    title(['\rho = ' num2str(rho)]);
    legend('Location', 'best');
    grid on;

    %% Figura 2 - subplot validacao
    figure(figure2);
    subplot(2,2,k);
    plot(tempo, y,  'b-',  'LineWidth', 1.5, 'DisplayName', 'y(n)');
    hold on;
    plot(tempo, ye, 'r--', 'LineWidth', 1.5, 'DisplayName', 'y(n)');
    xlabel('Tempo (s)');
    ylabel('Amplitude');
    title(['\rho = ' num2str(rho)]);
    legend('Location', 'best');
    grid on;
end