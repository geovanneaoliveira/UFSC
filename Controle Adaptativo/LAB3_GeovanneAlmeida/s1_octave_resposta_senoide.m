clc;

% Frequencia da senoide
% -------------------------------------------------------------------------
f0 = 5; % frequencia da senoide

% Numero de ciclos
P = 30;

% -------------------------------------------------------------------------
fprintf('//Frequência da senoide: %d Hz\n\n', f0);

% PARAMETROS DA AMOSTRAGEM
% -------------------------------------------------------------------------

fs = [20:200]*f0;                 % frequencia de amostragem

fclk = 16e6;                % frequencia do sinal de clock do arduino
PSC = [1, 8, 64, 256, 1024];% 1, 8, 64, 256, 1024
TOP = fclk./(fs.'*PSC);

% importante verificar se o valor obtido e inteiro e esta dentro
% do intervalo [0, 65535]

aux = TOP < 2^15-1;
[v, ~] = find(aux);
min_v = min(v);
min_u = min(find(aux(min_v,:)));

if ~isempty(min_v) & ~isempty(min_u)

  fs = fs(min_v);
  PSC = PSC(min_u);

  TOP = fclk/(fs*PSC);
  TOP = floor(TOP);

  fs = fclk./(floor(TOP)*PSC);

  % Codigo em C para ajuste da frequencia de amostragem
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

  % SINAL DE ENTRADA
  % -------------------------------------------------------------------------
  tmax = P * 1/f0;   % intervalo de tempo necessario para 15 periodos

  tempo = 0:1/fs:(tmax-1/fs);
  N = numel(tempo);

  x = sin(2*pi*f0/fs*[0:N-1])+2.5;

  figure;
  plot(tempo, x,'Color',[0.3922 0.4745 0.6353]); hold on;
  plot(tempo, x,'k.');
  xlabel('tempo ($s$)','fontsize',11,'interpreter','latex');
  ylabel('Amplitude ($V$)','fontsize',11,'interpreter','latex');
  ylim([0, 5]);
  xlim([tempo(1), tempo(end)]);


  fprintf('//Duracao do sinal: %d segundos\n', tmax);

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

else
  fprintf('Nao foi encontrar valores de PRESCALER e TOP para a frequencia de amostragem desejada!\n');
endif;

