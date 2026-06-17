clear all;
close all;
clc;

load('step_response_1.mat');
A = step_amplitude;
y = step_response;
y = y - 0.0193571;
ts = 1/fs;
N = numel(y);
tempo = (0:N-1) * ts;

figure();
hold on;
xlabel("Tempo (s)");
ylabel("Amplitude");
grid on;
plot(tempo, y, 'LineWidth', 2);
xlim([0 5])
[K, ksi, wn, L] = lab2_funcs(y, A, fs, 'Subamortecido')
s1 = - ksi * wn + wn * sqrt(ksi^2 - 1)
s2 = - ksi * wn - wn * sqrt(ksi^2 - 1)

s = tf('s');
G = K * wn^2 / (s - s1) / (s - s2);
[degrau, t_degrau] = step(G, tempo);

if(ksi > 1)
    tau1 = -1 / s1;
    tau2 = -1 / s2;
    a = tau1 / (tau1 - tau2);
    b = tau2 / (tau2 - tau1);
    y_saida = A * K * (1 - a*exp( -(tempo - L) / tau1)- b*exp( -(tempo - L) / tau2)) .* (tempo > L);
elseif(ksi == 1)
    tau = - 1 / s1;
    y_saida = A * K * (1 - exp( -(tempo - L) / tau) - 1/tau * (tempo - L) * exp( -(tempo - L) / tau)) .* (tempo > L);
elseif(ksi < 1 && ksi > 0)
    wd = wn * sqrt(1 - ksi^2);
    theta = atan(ksi / sqrt(1 - ksi^2));
    y_saida = A * K .* (1 - (1/sqrt(1 - ksi^2)) * exp(-ksi*wn*(tempo - L)) .* cos(wd*(tempo - L) - theta)) .* (tempo > L);
else
    y_saida = A * K * (1 - 1/sqrt(1 - ksi^2) * cos(wn * (tempo - L) - theta)) .* (tempo > L);
end

plot(tempo, y_saida, 'LineWidth', 2);

[K, ksi, wn, L] = lab2_funcs(y, A, fs, 'Mollenkamp')
s1 = - ksi * wn + wn * sqrt(ksi^2 - 1)
s2 = - ksi * wn - wn * sqrt(ksi^2 - 1)

s = tf('s');
G = K * wn^2 / (s - s1) / (s - s2);
[degrau, t_degrau] = step(G, tempo);

if(ksi > 1)
    tau1 = -1 / s1;
    tau2 = -1 / s2;
    a = tau1 / (tau1 - tau2);
    b = tau2 / (tau2 - tau1);
    y_saida = A * K * (1 - a*exp( -(tempo - L) / tau1)- b*exp( -(tempo - L) / tau2)) .* (tempo > L);
elseif(ksi == 1)
    tau = - 1 / s1;
    y_saida = A * K * (1 - exp( -(tempo - L) / tau) - 1/tau * (tempo - L) * exp( -(tempo - L) / tau)) .* (tempo > L);
elseif(ksi < 1 && ksi > 0)
    wd = wn * sqrt(1 - ksi^2);
    theta = atan(ksi / sqrt(1 - ksi^2));
    y_saida = A * K .* (1 - (1/sqrt(1 - ksi^2)) * exp(-ksi*wn*(tempo - L)) .* cos(wd*(tempo - L) - theta)) .* (tempo > L);
else
    y_saida = A * K * (1 - 1/sqrt(1 - ksi^2) * cos(wn * (tempo - L) - theta)) .* (tempo > L);
end

plot(tempo, y_saida, 'LineWidth', 2);
legend('Sinal de entrada discreto','Subamortecido','Mollenkamp')