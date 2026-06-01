clear; clc; close all;

sys_teorico = tf(1,[0.0564 1]);
load('Sistema_pratico.mat');
Data
fs = Data.frequencia_amostragem;
f = Data.frequencia_senoides;
N = length(f);

mag = zeros(1,N);
fase = zeros(1,N);
    
for i = 1:N
    u = Data.Entradas{i};
    y = Data.Respostas{i};

    % regime permanente (última metade)
    u = u(round(end/2):end);
    y = y(round(end/2):end);

    % amplitude
    Ax = (max(u)-min(u))/2;
    Ay = (max(y)-min(y))/2;

    % magnitude (dB)
    mag(i) = 20*log10(Ay/Ax);

    % fase via detecção de pico
    [~, idx_u] = max(u);
    [~, idx_y] = max(y);

    delay = (idx_y - idx_u) / fs;   % delay em segundos
    w_i = 2*pi*f(i);

    T = 1/f(i);
    delay = mod(delay + T/2, T) - T/2;

    fase(i) = -w_i * delay;
end
    w = 2*pi*f;
    
    %% Magnitude
    figure;
    subplot(2,1,1)
    semilogx(w, mag, 'o','LineWidth',2)
    
    abs = 10^(mag(1)/20)
    %  10^(3.4664/20)
    hold on
    grid on
    K = 10^(mean(mag(1:3))/20);   
    yline(20*log10(K), 'r', 'LineWidth', 2)
    title('Sistema Pratico')
    ylabel('Magnitude (dB)')
    
    %% Fase
    subplot(2,1,2)
    semilogx(w, fase,'o','LineWidth',2)
    grid on
    ylabel('Fase (rad)')
    xlabel('Frequência (rad/s)')
    
    %% FTs
    
    figure;
    [mag_model, phase_model] = bode(sys_teorico, w);
    mag_model = squeeze(20*log10(mag_model));
    phase_model = squeeze(phase_model) * (pi/180);
    subplot(2,1,1)
    semilogx(w, mag_model, 'r', 'LineWidth', 2)
    grid on; hold on
    semilogx(w, mag, 'bo', 'LineWidth', 2, 'MarkerFaceColor', 'b')
    ylabel('Magnitude (dB)')
    legend('Modelo teórico', 'Experimental')

    subplot(2,1,2)
    semilogx(w, phase_model, 'r', 'LineWidth', 2)
    grid on; hold on
    semilogx(w, fase, 'bo', 'LineWidth', 2, 'MarkerFaceColor', 'b')
    ylabel('Fase (rad)')
    xlabel('\omega (rad/s)')
    legend('Modelo teórico', 'Experimental')
