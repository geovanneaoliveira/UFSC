clear;
clc;
close all;

%% Parametros de entrada
tipo = 'prbs';            % entrada (degrau, quadrada, prbs)
sgr2 = 1e-6;                % variancia do ruido na saida do sistema

L = 20;                     % numero de amostras

Runs = 100;                 % numero de realizacoes do processo de estimacao

% Sistema discretizado
b1 = 0.0275;
b2 = 0.0252; % estava 0.0242 mas na atividade está 0.0252 então alterei
a1 = -1.6097;
a2 = 0.6873;

% Entrada do sistema
tmax = 5;
fs = 40;
Ts = 1/fs;

tempo = 0:Ts:tmax-Ts;
N = numel(tempo);

if strcmpi(tipo, 'degrau')
    x = ones(N,1);
    x(1) = 0;
elseif strcmpi(tipo, 'quadrada')
    freq = 2;
    duty = 50;
    x = 0.5+0.5*square(2*pi*freq.*tempo,duty);
elseif strcmpi(tipo, 'prbs')
    order = 11;
    seed  = floor(rand(1)* (2^order-1));
    x = f_prbs(order, N, seed);
end

x = x(:);

Theta = zeros(4, Runs);

for r = 1:Runs

    % ruidodo na saida do sistema
    v = sqrt(sgr2)*randn(N,1);

    % resposta do sistema
    y = zeros(N,1);

    x = [0;0; x];       % condicoes iniciais
    y = [0;0; y];
    v = [0;0; v];

    for n = 3:N+2
        y(n) = b1*x(n-1) + b2*x(n-2) - a1*y(n-1) - a2*y(n-2) + v(n);
    end

    x = x(3:end);
    y = y(3:end);

    % Estimador de minimos quadrados

    % IMPLEMENTE AQUI A EQUACAO DO ESTIMADO DE MINIMOS QUADRADOS

    ul = [x(end-L:end-1).'; x(end-L-1:end-2).' ; -y(end-L:end-1).'; -y(end-L-1:end-2).'];

    UL = (ul(:,1:L).');
    yL = y(end-L+1:end);



    theta = inv((UL.'*UL))*UL.'*yL;

    % parametros estimados
    Theta(:,r) = theta;

end


% Sistema estimado

ThetaMed = [mean(Theta(1,:)); mean(Theta(2,:)) ; mean(Theta(3,:)) ;mean(Theta(4,:))]

Gz = tf([ThetaMed(1) , ThetaMed(2)], [1, ThetaMed(3), ThetaMed(4)], Ts);

% Resposta do sistema
N = numel(x);
tempo = (0:N-1)*Ts;

ye = lsim(Gz, x, tempo);

%% Apresentacao dos resultados

figure('Units','normalized','Position',[0.05 0.05 0.9 0.85])

params = {Theta(1,:), Theta(2,:), Theta(3,:), Theta(4,:)};
reais  = {b1, b2, a1, a2};
nomes  = {'b_1', 'b_2', 'a_1', 'a_2'};

for i = 1:4
    subplot(2,2,i)
    
    h = histogram(params{i}, 15, 'FaceColor', [0.2 0.4 0.8], 'EdgeColor', 'white', 'FaceAlpha', 0.85);
    hold on
    
    xline(reais{i}, 'k--', 'LineWidth', 2.5, 'Label', sprintf('Real = %.4f', reais{i}), 'LabelVerticalAlignment', 'bottom', 'FontSize', 22);
    
    xlabel(sprintf('$\\hat{%s}$', nomes{i}), 'Interpreter', 'latex', 'FontSize', 22)
    ylabel('Frequência', 'FontSize', 22)
    title(sprintf('Estimativas de $%s$ - sinal %s', nomes{i}, tipo), 'Interpreter', 'latex', 'FontSize', 22)
    
    legend(sprintf('Estimativas de $%s$', nomes{i}), 'Interpreter', 'latex', 'FontSize', 22, 'Location', 'best')
    
    grid on
    box on
    set(gca, 'FontSize', 22)
end

sgtitle(sprintf('Desempenho do estimador MQ com %d realizações e sinal %s', Runs, tipo), 'FontSize', 24, 'FontWeight', 'bold')