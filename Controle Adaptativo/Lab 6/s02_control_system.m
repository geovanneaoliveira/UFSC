
%% ETAPA 2 (definicao do sinal de entrada)

pkg load signal;

% Sinal de entrada
% -------------------------------------------------------------------------
tmax = 60;
tempo = 0:1/fs:(tmax-1/fs);
N = numel(tempo);

r = ones(1,N);
r(tempo < 15) = 0.5;
r(tempo >= 15 & tempo < 30) = 1.25;
r(tempo >= 30 & tempo < 45) = 0.75;
r(tempo >= 45 & tempo < 60) = 0;


figure;
plot(tempo, r,'Color',[0.3922 0.4745 0.6353]); hold on;
plot(tempo, r,'k.');
xlabel('tempo ($s$)','fontsize',11,'interpreter','latex');
ylabel('Amplitude ($V$)','fontsize',11,'interpreter','latex');
ylim([0, 5]);

clc;
fprintf('Duracao do sinal: %d segundos\n', tmax);

% Conventer amplitude para valor do duty cycle do sinal PWM
ru = uint16((r/5)*PWM_RESOLUTION);

% Codigo em C definindo o vetor com amostras do sinal de entrada
fprintf('\n#define N %d\n', N);
fprintf('uint16_t x[N] = {');
for k = 1:numel(ru)
    if k ~= N
        fprintf('%3d, ', ru(k));
    else
        fprintf('%3d};\n', ru(k));
    end

    if ~mod(k,10)
       fprintf('\n');
    end
end

