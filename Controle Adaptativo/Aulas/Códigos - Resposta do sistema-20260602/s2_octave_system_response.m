clc;
%% ETAPA 2 (definicao do sinal de entrada)

pkg load signal;

% Sinal de entrada
% -------------------------------------------------------------------------


Ts = 1/fs;

tmax = 5;
tempo = 0:Ts:tmax-Ts;
N = numel(tempo);

en = zeros(1,N);
en (tempo >= 1 & tempo <= 4) = 1;
Nen = sum(tempo >= 1 & tempo <= 4);

x = ones(1,N);
x(tempo >= 1 & tempo <= 4) = x(tempo >= 1 & tempo <= 4) + 0.1*randn(1,Nen) ;


figure;
plot(tempo, x,'Color',[0.3922 0.4745 0.6353]); hold on;
plot(tempo, x,'k.');
xlabel('tempo ($s$)','fontsize',11,'interpreter','latex');
ylabel('Amplitude ($V$)','fontsize',11,'interpreter','latex');
ylim([0, 5]);

clc;
fprintf('Duracao do sinal: %d segundos\n', tmax);

% Conventer amplitude para valor do duty cycle do sinal PWM
% xu = uint16((x/5)*PWM_RESOLUTION);

% Codigo em C definindo o vetor com amostras do sinal de entrada
fprintf('\n#define N %d\n', N);
fprintf('float x[N] = {');
for k = 1:numel(x)
    if k ~= N
        fprintf('%6.4f, ', x(k));
    else
        fprintf('%6.4f};\n', x(k));
    end

    if ~mod(k,10)
       fprintf('\n');
    end
end


% fprintf('\n#define N %d\n', N);
fprintf('uint8_t en[N] = {');
for k = 1:numel(en)
    if k ~= N
        fprintf('%2d, ', en(k));
    else
        fprintf('%2d};\n', en(k));
    end

    if ~mod(k,10)
       fprintf('\n');
    end
end
