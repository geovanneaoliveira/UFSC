close all;
clear;
clc;

R = 2.2e3;
C = 47e-9;
fc = 1/(2*pi*R*C);

R=1/(10e3*2*pi*C)

%% Ganho

VASCO = readmatrix('VASCO.xlsx');
SPICEg = [-736e-9; -3e-6; -6.7e-6; -11.7e-6; -18.6e-6
          -74e-6; -299e-6; -668e-6; -1.2e-3; -1.9e-3
          -7.4e-3; -29.8e-3; -69e-3; -118e-3; -183.73e-3
          -685e-3; -2.24; -2.36; -2.45; -2.54; -2.63; -2.72; -2.8; -2.89; -2.989; -3.08; -3.17
          -3.35; -3.53; -3.71; -3.88; -4.11
          -7.25; -12.69; -18.41; -22];
SPICEp = [-24e-3; -48e-3; -71e-3; -94e-3; -118e-3
          -237e-3; -475e-3; -710e-3; -953e-3; -1.2
          -2.4; -4.74; -7.23; -9.43; -11.74
          -22.46; -39.4; -40.37; -41; -41.7; -42.37; -43; -43.64; -44.26; -44.86; -45.45; -46
          -47.15; -48.23; -49.26; -50.26; -51.49
          -64.28; -76.58; -83.1; -85];

raiz = sqrt(1+(VASCO(:,1)./fc).^2);
G = 20*log10(1./raiz);

semilogx(VASCO(:,1), G, 'LineWidth', 2, 'Color', 'b');
grid on;
title('Diagrama de Bode do Filtro Passivo RC');
ylabel('Ganho (dB)');
xlabel('Frequência (Hz)');
hold on;

semilogx(VASCO(:,1), VASCO(:,4), 'LineWidth', 2, 'Color', 'r');
semilogx(VASCO(:,1), SPICEg,'-.', 'LineWidth', 1.7, 'Color', 'g');
legend({'Teórico', 'Prático', 'Simulado'});

%% Fase

phase = atan2(VASCO(:,1), fc);
phase = rad2deg(phase);
phase = -phase;
phasePratico = -VASCO(:, 3);

figure();
semilogx(VASCO(:,1), phase, 'LineWidth', 2, 'Color', 'b');
grid on;
title('Diagrama de Fase do Filtro Passivo RC');
ylabel('Fase (deg)');
xlabel('Frequência (Hz)');
hold on;

semilogx(VASCO(:,1), phasePratico, 'LineWidth', 2, 'Color', 'r');
semilogx(VASCO(:,1), SPICEp,'-.', 'LineWidth', 1.7, 'Color', 'g');
legend({'Teórico', 'Prático', 'Simulado'});