clear;
clc;

pkg load control;
pkg load signal;

%% Sistema 1
K = 1;
Wn = 20;
Xi = 0.7;

G1 = tf([K*(Wn^2)], [1, 2*Xi*Wn, Wn^2]);

% sistema discretizado
fs = 10;
T = 1/fs;

G1z = c2d(G1, T, 'zoh');
b1_1 = G1z.num{1}(1);
b2_1 = G1z.num{1}(2);
a1_1 = G1z.den{1}(2);
a2_1 = G1z.den{1}(3);

%% Sistema 2
K = 0.95;
Wn = 19;
Xi = 0.6;

G2 = tf([K*(Wn^2)], [1, 2*Xi*Wn, Wn^2]);

G2z = c2d(G2, T, 'zoh');
b1_2 = G2z.num{1}(1);
b2_2 = G2z.num{1}(2);
a1_2 = G2z.den{1}(2);
a2_2 = G2z.den{1}(3);

%% Planta variante no tempo
tmax = 20;
tempo = 0:T:tmax-T;
N = numel(tempo);

b1 = b1_1*ones(1,N);
b2 = b2_1*ones(1,N);
a1 = a1_1*ones(1,N);
a2 = a2_1*ones(1,N);

b1(N/2:end) = b1_2;
b2(N/2:end) = b2_2;
a1(N/2:end) = a1_2;
a2(N/2:end) = a2_2;

%% Entrada e saida do sistema
freq = 2;
duty = 50;
x = square(2*pi*freq.*tempo,duty);

y = zeros(1,N);


%%
rho = 1;
P = rho*eye(4);
u = zeros(4,1);

theta = zeros(4,N);

lambda = 0.95;

for n = 3:N

    % saida do sistema
    y(n) = b1(n)*x(n-1) + b2(n)*x(n-2) - a1(n)*y(n-1) -a2(n)*y(n-2);

    % atualizacao vetor u


    % vetor de ganho h


    % Atualizacao dos parametros


    % atualizacao da matriz P


end


% Resultados
figure;
stairs(tempo, theta');
hold on;
plot(tempo, b1, 'k:');
plot(tempo, b2, 'k:');
plot(tempo, a1, 'k:');
plot(tempo, a2, 'k:');
legend('b_1', 'b_2', 'a_1', 'a_2');
xlabel('tempo (s)');
grid on;
