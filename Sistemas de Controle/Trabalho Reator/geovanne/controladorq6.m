clear
close all
clc

s = tf('s');
%Planta
G = (-0.2897*(s - 4.056))/(s + 1.633);

%controlador
C = (1.852*(s+ 1.917))/s;

%pert

Q = 0.7424/(s+1.633)

%filtro
Fr = 1.917/(s+1.917);

%Y/R
Yr = feedback(C*G,1)
%Y/Q
Yq = Q/(1+C*G)
YrFr = Yr*Fr

%plot das respostas

step(YrFr);
xlabel('T');
ylabel('Amplitude');
title('Resposta ao degrau da Y/R com filtro');

figure;

step(Yq);
xlabel('T');
ylabel('Amplitude');
title('Resposta ao degrau da Y/Q');

figure;

% Subplots para a saída em relação à referência (Y/R)
% Primeiro subplot: Resposta ao degrau da Y/R com filtro
% subplot(3, 1, 1);
% stepplot(Yr*Fr);
% grid on
% xlabel('T (min)');
% ylabel('Cb [mol/l]');
% title('Resposta ao degrau da Y/R com filtro');

% Segundo subplot: Diagrama de polos e zeros para Y/R
subplot(2, 1, 1);
pzmap(Yr);
title('Diagrama de polos e zeros para Y/R');
ylim([-1, 1]);

% Terceiro subplot: Diagrama de Bode para Y/R com filtro
subplot(2, 1, 2);
bode(YrFr);
title('Diagrama de Bode para Y/R com filtro');


figure
% Subplots para a perturbação (Y/Q)
% Quarto subplot: Resposta ao degrau da Y/Q
% subplot(3, 1, 1);
% step(Yq);
% xlabel('T (min)');
% ylabel('Cb [mol/l]');
% title('Resposta ao degrau da Y/Q');

% Quinto subplot: Diagrama de polos e zeros para Y/Q
subplot(2, 1, 1);
pzmap(Yq);
title('Diagrama de polos e zeros para Y/Q');
ylim([-1, 1]);

% Sexto subplot: Diagrama de Bode para Y/Q
subplot(2, 1, 2);
bode(Yq);
title('Diagrama de Bode para Y/Q');

