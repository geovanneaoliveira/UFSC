clear all;
close all;
clc;

% Carrega variáveis de ambiente para simulação
load('step_response_1.mat');
A = step_amplitude;
y = step_response;
y = y - 0.0193571;
ts = 1/fs; % Tempo de simulação

N = numel(y);
tempo = (0:N-1) * ts;

figure();
hold on;
xlabel("Tempo [s]");
ylabel("Amplitude");
grid on;
plot(tempo, y, 'LineWidth', 2);
plot(tempo, y, 'k.');

[K, qsi, wn, L] = lab2_funcs(y, A, fs, 'Mollenkamp')
p1 = - qsi * wn + wn * sqrt(qsi^2 - 1)
p2 = - qsi * wn - wn * sqrt(qsi^2 - 1)

s = tf('s');
G = K * wn^2 / (s - p1) / (s - p2);
[degrau, t_degrau] = step(G, tempo);

if(qsi > 1)
    tau1 = -1 / p1;
    tau2 = -1 / p2;
    a = tau1 / (tau1 - tau2);
    b = tau2 / (tau2 - tau1);
    y_saida = A * K * (1 - a*exp( -(tempo - L) / tau1)- b*exp( -(tempo - L) / tau2)) .* (tempo > L);
elseif(qsi == 1)
    tau = - 1 / p1;
    y_saida = A * K * (1 - exp( -(tempo - L) / tau) - 1/tau * (tempo - L) * exp( -(tempo - L) / tau)) .* (tempo > L);
elseif(qsi < 1 && qsi > 0)
    wd = wn * sqrt(1 - qsi^2);
    theta = atan(qsi / sqrt(1 - qsi^2));
    y_saida = A * K .* (1 - (1/sqrt(1 - qsi^2)) * exp(-qsi*wn*(tempo - L)) .* cos(wd*(tempo - L) - theta)) .* (tempo > L);
else
    y_saida = A * K * (1 - 1/sqrt(1 - qsi^2) * cos(wn * (tempo - L) - theta)) .* (tempo > L);
end

plot(tempo, y_saida, 'LineWidth', 2);
