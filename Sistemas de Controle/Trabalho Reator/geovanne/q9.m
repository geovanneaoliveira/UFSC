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
Yr = (-1.1576*(s+1.917)*(s - 4.055))/(s+3)^2;
Yq = 1.6018*s/((s+3)^2);
Fr = 1.917/(s+1.917);
C = 1.852*(s+1.917)/s;

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