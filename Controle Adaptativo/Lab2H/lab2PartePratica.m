clear all
close all
clc

%% Componentes nominais
% R1 = R2 = 470kOhm
% C1 = C2 = 100nF
% R3 = R4 = 1kOhm
%% Componentes reais
% R1 = 468.4 kOhm
% R2 = 475.9 kOhm
% R3 = 0.978 kOhm
% R4 = 0.982 kOhm
% C1 = 68 nF
% C2 = 50 nF

load('ensaio_lab5.mat')
ts = 1 / fs;
N = numel(y);
tempo = (0:N-1) * ts;
A = 1;
plot(tempo, y, 'LineWidth', 2);

GsTeorica = GeraFT(470e3,470e3,1e3,1e3,100e-9,100e-9);
GsReal = GeraFT(468.4e3, 475.9e3, 0.978e3, 0.982e3, 68e-9, 50e-9);
[K, qsi, wn, L] = lab2_funcs(y, A, fs, 'Standard');
Gs_Standard = GeraFT_Advanced(K, wn, qsi, L);
[K, qsi, wn, L] = lab2_funcs(y, A, fs, 'Mollenkamp');
Gs_Mollenkamp = GeraFT_Advanced(K, wn, qsi, L);



function Gs = GeraFT(R1, R2, R3, R4, C1, C2)
    s = tf('s');
    K = 1 + R4/R3;
    numerador = K / (R1 * R2 * C1 * C2);
    denominador = s^2 + (1/R2/C1 + 1/R2/C2 + 1/R1/C2 - K/R2/C1)*s + 1/R1/R2/C1/C2;
    Gs = numerador/denominador;
end

function Gs = GeraFT_Advanced(K, Wn, qsi, L)
    s = tf('s');
    Gs = K * exp(-L * s) / ((s^2)/Wn^2 + 2*qsi*s/Wn+ 1);
end