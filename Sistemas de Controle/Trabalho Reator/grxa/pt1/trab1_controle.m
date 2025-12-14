close all
clc
clear all

%constantes
k1=6.01;
k2=0.8433;
k3=0.1123;

%vetores para armazernar os valores de ca e cb
Caf_values = []; 
U_values = [];  
ca_values = []; 
cb_values = [];  
ca2_values = [];  
cb2_values = []; 
ca3_values = [];  
cb3_values = []; 
ca4_values = [];  
cb4_values = []; 
Caf=4;
 for U=0:0.5:10
            ca = (-(k1+U)+sqrt((k1+U)^2+4*k3*Caf*U))/(2*k3);
            U_values = [U_values U];
            ca_values = [ca_values ca];  % Armazena o valor de z no vetor
            cb = (k1*ca)/(U+k2);
            cb_values = [cb_values cb];
           
 end
  Caf=6;
 for U=0:0.5:10
           
            ca2 = (-(k1+U)+sqrt((k1+U)^2+4*k3*Caf*U))/(2*k3);
            ca2_values = [ca2_values ca2];  % Armazena o valor de z no vetor
            cb2 = (k1*ca2)/(U+k2);
            cb2_values = [cb2_values cb2];
           
 end
 
 
 U = 0.1;
  for Caf=4:0.1:6
     
            ca3 = (-(k1+U)+sqrt((k1+U)^2+4*k3*Caf*U))/(2*k3);
            Caf_values = [Caf_values Caf];  % Armazena o valor de Caf no vetor
            ca3_values = [ca3_values ca3];  % Armazena o valor de z no vetor
            cb3 = (k1*ca3)/(U+k2);
            cb3_values = [cb3_values cb3];
  end
   U = 10;
  for Caf=4:0.1:6
     
            ca4 = (-(k1+U)+sqrt((k1+U)^2+4*k3*Caf*U))/(2*k3);
            ca4_values = [ca4_values ca4];  % Armazena o valor de z no vetor
            cb4 = (k1*ca2)/(U+k2);
            cb4_values = [cb4_values cb4];
  end
  
 %%% Variando U - graficos 
  
tiledlayout(2,1)
nexttile
plot(U_values, ca_values);
hold on 
plot(U_values, ca2_values);
ylim([0,4]);
legend('Caf = 4 [mol/l]','Caf = 6 [mol/l]');
xlabel('U [l/min]');
ylabel('Ca [mol/l]');
title('Gráfico da faixa do nivel de concentração de A em relaçao a variação de Caf');
grid minor

nexttile
plot(U_values, cb_values);
hold on 
plot(U_values, cb2_values);
ylim([0,4]);
legend('Caf = 4 [mol/l]','Caf = 6 [mol/l]');
xlabel('U [l/min]');
ylabel('Cb [mol/l]');
title('Gráfico da faixa do nivel de concentração de B em relaçao a variação de Caf');
grid minor

%%% Variando Caf - graficos

figure
tiledlayout(2,1)
nexttile
plot(Caf_values, ca3_values);
hold on 
plot(Caf_values, ca4_values);
ylim([0,4]);
legend('U = 0.1 [l/min]','U = 10  [l/min]')
xlabel('Caf [mol/l]');
ylabel('Ca [mol/l]');
title('Gráfico da faixa do nivel de concentração de A em relaçao a variação de U');
grid minor


nexttile
plot(Caf_values, cb3_values);
hold on 
plot(Caf_values, cb4_values);
ylim([0,4]);
legend('U = 0.1 [l/min]','U = 10  [l/min]')
xlabel('Caf [mol/l]');
ylabel('Cb [mol/l]');
title('Gráfico da faixa do nivel de concentração de B em relaçao a variação de U');
grid minor

  %%   questao 2
  clear
  close all
  clc
  
  U_values = [];  % Vetor para armazenar os valores de U
  ca8_values = [];  % Vetor para armazenar os valores de ca
  cb8_values = [];  % Vetor para armazenar os valores de cb

  %constantes
  k1=6.01;
  k2=0.8433;
  k3=0.1123; 
  Caf=5.1;
  
 for U=0:0.5:10
            U_values = [U_values U];
            ca = (-(k1+U)+sqrt((k1+U)^2+4*k3*Caf*U))/(2*k3);
            ca8_values = [ca8_values ca];  % Armazena o valor de z no vetor
            cb = (k1*ca)/(U+k2);
            cb8_values = [cb8_values cb];
 end 
 % formação dos graficos
 
 tiledlayout(2,1)
    nexttile
    plot(U_values, ca8_values);
    ylim([0,4]);
    legend('Ca [mol/l]')
    xlabel('U [l/min]');
    ylabel('Ca [mol/l]');
    title('Gráfico da curva de concentração de A em relaçao a variação de U');
    grid minor
    
    nexttile
    plot(U_values, cb8_values);
    ylim([0,4]);
    legend('Cb [mol/l]')
    xlabel('U [l/min]');
    ylabel('Cb [mol/l]');
    title('Gráfico da curva de concentração de B em relaçao a variação de U');
    grid minor
    
    %% Questao 5
     clear
  close all
  clc
  
  % vetor de tempo
    Tc = 0.435/20;
    t = 0:Tc:10;
    N = length(t);
    
   %faixa escolhida inferior e superior
    caf = 5.1;
    u =1;
    u2 = 0.1;
    caf2 = 0.1;
    
    %constantes
    k1=6.01;
    k2=0.8433;
    k3=0.1123;
    
    %vetores para armazenar valors de ca e cb
    ca = zeros(1,N);
    ca(1) = 0;
    cb = zeros(1,N);
    cb(1) = 0;
    cb2 = zeros(1,N);
    cb2(1) = 0;
    ca2 = zeros(1,N);
    ca2(1) = 0;
    
    for k = 2:N
        
    %não linear
    ca(k) = (-k3*ca(k-1)^2-(k1+u)*ca(k-1)+ caf*u)*Tc+ca(k-1);
    cb(k) = (k1*ca(k-1)-k2*cb(k-1)-u*cb(k-1))*Tc+cb(k-1);
     
    % linear
    %%%pequenos sinais
    
    if k>232
    ca2(k)=(-7.1715*ca2(k-1)+4.3808*u2+caf2)*Tc+ca2(k-1);
    cb2(k)=(6.01*ca2(k-1)-1.8433*cb2(k-1)-2.345*u2)*Tc+cb2(k-1);
    end
    
    end
    
    % formação dos graficos
    
    plot(t,ca+ca2)
    ylim([0,0.8]);
    hold on
    plot(t,ca2+0.7192)
    ylim([0,0.8]);
    %legend('Ca [mol/l] - Não-Linear','Ca [mol/l] - Linear')
    xlabel('T (min)');
    ylabel('Ca [mol/l]');
    title('Gráfico de concentração de A e uma pequena perturbação no tempo');
    plot(t,cb+cb2)
    ylim([0,2.5]);
    hold on
    plot(t,cb2+2.345)
    ylim([0,2.5]);
    legend('Ca [mol/l] - Não-Linear','Ca [mol/l] - Linear','Cb [mol/l] - Não-Linear','Cb [mol/l] - Linear')
    xlabel('Tempo (min)');
    ylabel('Concentrações (mol/l)');
    title('Concentrações Ca e Cb');
    grid
%% questao 7
  clear
  close all
  clc
  
s = tf('s');
%Planta
G = (-0.2897*(s - 4.097))/(s + 1.6332);
%controlador
C = (2.25*s+ 6.2532)/s;

%filtro
Fr = 1.6332/(s+1.6332);

%Y/R
Yr = feedback(C*G,1)
%Y/Q
Yq = G/(1+C*G)

%plot das respostas

figure;

% Subplots para a saída em relação à referência (Y/R)
% Primeiro subplot: Resposta ao degrau da Y/R com filtro
subplot(3, 1, 1);
step(Yr*Fr);
xlabel('T (min)');
ylabel('Cb [mol/l]');
title('Resposta ao degrau da Y/R com filtro');

% Segundo subplot: Diagrama de polos e zeros para Y/R
subplot(3, 1, 2);
pzmap(Yr);
title('Diagrama de polos e zeros para Y/R');
ylim([-1, 1]);



% Terceiro subplot: Diagrama de Bode para Y/R com filtro
subplot(3, 1, 3);
bode(Yr*Fr);
title('Diagrama de Bode para Y/R com filtro');


figure
% Subplots para a perturbação (Y/Q)
% Quarto subplot: Resposta ao degrau da Y/Q
subplot(3, 1, 1);
step(Yq);
xlabel('T (min)');
ylabel('Cb [mol/l]');
title('Resposta ao degrau da Y/Q');

% Quinto subplot: Diagrama de polos e zeros para Y/Q
subplot(3, 1, 2);
pzmap(Yq);
title('Diagrama de polos e zeros para Y/Q');
ylim([-1, 1]);

% Sexto subplot: Diagrama de Bode para Y/Q
subplot(3, 1, 3);
bode(Yq);
title('Diagrama de Bode para Y/Q');

stop
%% questao 9 
close all
clear
clc
Ts = 0.08;

% Sinal de Referência 

 t_final = 50; % tempo total de simulação
 t = 0:Ts:t_final+0.08; % vetor de tempo
 t_rampa = 5; % duração da rampa
 rampa_slope = 2.3 / t_rampa; % inclinação da rampa
 rampa_offset = 0; % valor inicial da rampa
 rampa_final_value = 2.345; % valor final após a rampa
 R = rampa_slope .* (t - rampa_offset) .* (t <= t_rampa) + rampa_final_value .* (t > t_rampa);
 R(t >= 20) = 2.5; % mudança de valor a partir de T = 25 
 
 caf = 5.1*ones(size(t)); % vetor inicialmente com valor 5.1 para todos os tempos
 caf(t >= 30) = 5.2; % mudança de valor a partir de T = 25

    %inicialização das variáveis do processo
    k1=6.01;
    k2=0.8433;
    k3=0.1123;
    
    nit = round(t_final/Ts); % numero de iterações do laço de controle
    
    Ca = zeros(1,nit+1);
    Cb = zeros(1,nit+1);
    U = zeros(1,nit+1);
    rf = zeros(1,nit+1);
    
    rfant = 0;
    eant = 0; 
    uant = 0; 
    
    %Laço de Controle
    for k=3:nit+1
        
        % saida do sistema
        y = Cb(k);
        
       %referencia
       rf = 0.8576*rfant+0.07122*R(k)+0.07122*R(k-1);
       
       %calculo do erro
       e = rf - y;
        
       %sinal de controle
       u = uant + 1.993*e - 1.709*eant;
       
        % saturação do sinal de controle
        
        if u >= 10
            u = 10;
        end
        if u <= 0
           u = 0;
        end
        
        % aplicando sinal de controle na planta
        Ca(k+1)=(-k1*Ca(k)-u*Ca(k)-k3*((Ca(k))^2)+caf(k)*u)*Ts+Ca(k);
        
        Cb(k+1)= (k1*Ca(k)-k2*Cb(k)-Cb(k)*u)*Ts+Cb(k);
        
        U(k+1) = u; % para o plot do sinal de controle
        
        % atualização das variaveis de controle
        uant = u;
        eant = e;
        rfant = rf;
        
    end 
    
plot(t, Ca);
grid on;     
xlim([0,50]);
legend('Ca');
xlabel('Tempo [min]');
ylabel('Concentração [mol/l]');
title('Concentração de Ca e Perturbação em U');

figure;
plot(t, U);
xlim([0,50]);
legend('Sinal de Controle u')
grid
figure

plot(t, Cb);
xlim([0,50]);
title('Concentração de Cb e Perturbação em U');
grid on;
xlabel('Tempo [min]');
ylabel('Concentração [mol/l]');
legend('Cb');

% Discretizacao direto das Fts Y/R e Y/Q e a comparação entre discreta e
% continua

s = tf('s');

%continuas
Yr = (-1.1571*(s+1.918)*(s - 4.0559))/(s+3)^2;
Yq = 1.602*s/(s^2+6*s+9);
Fr = 1.917/(s+1.917);
C = 1.851*(s+1.917)/s;

% discretizadas
Yr2 = c2d(Yr,Ts,'Tustin')
Yq2 = c2d(Yq,Ts,'Tustin')
Fr2 = c2d(Fr,Ts,'Tustin')
Con2 = c2d(C,Ts,'Tustin')

figure
step(Yr*Fr,Yr2*Fr2)
xlabel('T (min)');
ylabel('Cb [mol/l]');
title('Resposta ao degrau da Y/R com filtro'); 
legend('Contínuo','Discreto');

figure
step(Yq,Yq2)
title('Resposta ao degrau da Y/Q');
xlabel('T (min)');
ylabel('Cb [mol/l]');
legend('Contínuo','Discreto');

 figure
 bode(C,Con2)
 title('Diagrama de Bode dos controladores');
 legend('Contínuo','Discreto');