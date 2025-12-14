%% Parte 1
clc
clear
close all

k1 = 6.01;
k2 = 0.8433;
k3 = 0.1123;

Caf0 = 5.1;
FV0 = 1;

[U,Caf] = meshgrid(0:0.1:10,4:0.1:6);

Ca = (-(k1+U)+sqrt((k1 + U).^2+4*k3*Caf.*U))/2*k3;
Cb = (k1./(k2 + U)).*Ca;

close all


surf(U,Caf,Ca);
title('Gráfico da variação de Ca(t) em função de u(t) e Caf')
figure
surf(U,Caf,Cb);
title('Gráfico da variação de Cb(t) em função de u(t) e Caf')