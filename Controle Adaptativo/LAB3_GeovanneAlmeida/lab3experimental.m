clear; clc; close all;

arquivos = {'Sistema_1.mat', 'Sistema_2.mat', 'Sistema_3.mat'};
sys_teorico = {tf(-0.8997,[1/3.7 1]), tf(317.9,[1 12.206 289]), tf(-169,[1 19.2374 169])};
for k = 1:3
    
    load(arquivos{k});
    Data
    fs = Data.frequencia_amostragem;
    f = Data.frequencia_senoides;
    N = length(f);
    
    mag = zeros(1,N);
    fase = zeros(1,N);
    
    for i = 1:N
        
        u = Data.Entradas{i};
        y = Data.Respostas{i};
        
        % pega regime permanente (última metade)
        u = u(round(end/2):end);
        y = y(round(end/2):end);
        
        % amplitude
        Ax = (max(u)-min(u))/2;
        Ay = (max(y)-min(y))/2;
        
        % magnitude (dB)
        mag(i) = 20*log10(Ay/Ax);
        
        % fase (correlação)
        [c,lags] = xcorr(y,u);
        [~,idx] = max(c);
        delay = lags(idx)/fs;
        
        w = 2*pi*f(i);
        fase(i) = -w*delay;
        
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
    title(['Sistema ', num2str(k)])
    ylabel('Magnitude (dB)')
    
    %% Fase
    subplot(2,1,2)
    semilogx(w, fase,'o','LineWidth',2)
    grid on
    ylabel('Fase (rad)')
    xlabel('Frequência (rad/s)')
    
    %% FTs
    
    figure;
    [mag_model, phase_model] = bode(sys_teorico{k}, w);
    mag_model   = squeeze(20*log10(mag_model));
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
    
end

K  = -1;       
wn = 13;        
w  = 13.895;        
G_dB = -4.0174; 

M = 10^(G_dB/20);

xi = sqrt( K^2 * (wn^4/M^2) - (wn^2 - w^2)^2 ) / (2*wn*w);

fprintf('xi = %.4f\n', xi);