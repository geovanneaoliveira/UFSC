clear; clc; close all; 
% Configurações 
f = 900; % MHz 
ht = 50; % metros 
hr = 2;  % metros 
d = 1:1:50; % Distância em km 
% 1. Perda de Espaço Livre (FSPL) 
PL_free = 32.44 + 20*log10(f) + 20*log10(d); 
% 2. Modelo Log-Distância (Ex: Urbano com n=3.5) 
n = 3.5; 
d0 = 1; % Distância de referência 
PL_d0 = 32.44 + 20*log10(f) + 20*log10(d0); 
PL_log = PL_d0 + 10*n*log10(d/d0); 
% 3. Modelo Hata (Cidade de Médio Porte) 
ahr = (1.1*log10(f) - 0.7)*hr - (1.56*log10(f) - 0.8); 
PL_hata = 69.55 + 26.16*log10(f) - 13.82*log10(ht) - ahr + (44.9 - 6.55*log10(ht))*log10(d); 
% Plotagem dos Resultados 
figure; 
plot(d, PL_free, 'k--', 'LineWidth', 1.5); hold on; 
plot(d, PL_log, 'r', 'LineWidth', 1.5); 
plot(d, PL_hata, 'b', 'LineWidth', 1.5); 
grid on; 
xlabel('Distância (km)'); 
ylabel('Perda de Percurso (dB)'); 
title(['Comparação de Modelos de Propagação @ ', num2str(f), ' MHz']); 
legend('Espaço Livre (n=2)', 'Log-Distância (n=3.5)', 'Hata (Urbano)'); 