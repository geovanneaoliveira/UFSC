clear;

pkg load instrument-control

%% ETAPA 1 (configuracao da frequencia de amostragem e do sinal PWM)

% Parametros de amostragem
fs = 40;                    % frequencia de amostragem

fclk = 16e6;                % frequencia do sinal de clock do arduino
PSC = 64;                    % 1, 8, 64, 256, 1024
TOP = fclk/(fs*PSC);        % importante verificar se o valor obtido e
                            % inteiro e esta dentro do intervalo [0, 65535]

% Codigo em C para ajuste da frequencia de amostragem
clc;
fprintf('// Sampling frequency = %d Hz\n', fs);
fprintf('#define PRESCALER %d\n', PSC);
fprintf('#define TOP %d\n', TOP-1);

% Parametros do sinal PWM
fpwm = 2000;                                % frequencia do sinal PWM

PWM_PSC = 1;                                % 1, 8, 64, 256, 1024
PWM_RESOLUTION = fclk/(fpwm*PWM_PSC)-1;     % importante verificar se o valor obtido e
                                            % inteiro e esta dentro do intervalo [0, 65535]

% Codigo em C para ajuste da frequencia do sinal PWM
fprintf('\n// PWM frequency = %d Hz\n', fpwm);
fprintf('#define PWM_PRESCALER %d\n', PWM_PSC);
fprintf('#define PWM_RESOLUTION %d\n', PWM_RESOLUTION);
