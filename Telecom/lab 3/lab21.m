close all
clc
clear all

%% 1

% 1. Definição da Frequência de Operação 
f_center = 10e9;  % Frequência central de 10 GHz (Banda X) 
c = 3e8;     
     % Velocidade da luz em m/s 
lambda = c / f_center; 
% 2. Criação do Objeto Antena (Refletor Parabólico) 
ant = reflectorParabolic; 
ant.Radius = 5 * lambda;    
     % Raio do refletor (15 cm) 
ant.FocalLength = 2.5 * lambda;  % Distância focal (f/D = 0.25) 
% 3. Visualização da Geometria 
figure(1); 
show(ant); 
title('Geometria do Refletor Parabólico e Alimentador'); 

%% 2

% Definição do vetor de frequências (9.5 GHz a 10.5 GHz) com 15 pontos 
freq_range = linspace(9.5e9, 10.7e9, 15);  
% Cálculo da impedância 
figure(2); 
impedance(ant, freq_range); 
title('Impedância do Refletor Parabólico'); 
% Cálculo e plotagem do Coeficiente de Reflexão (S11) para Z0 = 50 ohms 
S = sparameters(ant, freq_range, 50); 
figure(3); 
rfplot(S); 
title('Coeficiente de Reflexão (S11)'); 
yline(-10, 'r--', 'Limiar de -10 dB');

%% 3

% 1. Diagrama de Radiação 3D 
% Nota: Pode demorar alguns segundos devido ao tamanho elétrico da antena 
figure(4); 
pattern(ant, f_center); 
title('Diagrama de Radiação 3D (Alta Diretividade)'); 
% 2. Cortes 2D: Plano de Azimute e Plano de Elevação 
figure(5); 
subplot(1,2,1); 
patternAzimuth(ant, f_center); 
title('Corte Azimutal'); 
subplot(1,2,2); 
patternElevation(ant, f_center);