
%% ETAPA 2 (definicao do sinal de entrada)

pkg load signal;

% Sinal de entrada
% -------------------------------------------------------------------------
f0 = 2; % frequencia da onda quadrada

Ts = 1/fs;

tmax = 5;
tempo = 0:Ts:tmax-Ts;
N = numel(tempo);

f0 = 4;
x = 0.5*(square(2*pi*f0*tempo) + 2);

figure;
plot(tempo, x,'Color',[0.3922 0.4745 0.6353]); hold on;
plot(tempo, x,'k.');
xlabel('tempo ($s$)','fontsize',11,'interpreter','latex');
ylabel('Amplitude ($V$)','fontsize',11,'interpreter','latex');
ylim([0, 5]);

clc;
fprintf('Duracao do sinal: %d segundos\n', tmax);

% Conventer amplitude para valor do duty cycle do sinal PWM
xu = uint16((x/5)*PWM_RESOLUTION);

% Codigo em C definindo o vetor com amostras do sinal de entrada
fprintf('\n#define N %d\n', N);
fprintf('uint16_t x[N] = {');
for k = 1:numel(xu)
    if k ~= N
        fprintf('%3d, ', xu(k));
    else
        fprintf('%3d};\n', xu(k));
    end

    if ~mod(k,10)
       fprintf('\n');
    end
end

