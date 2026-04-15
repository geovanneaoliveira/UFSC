clear;
clc;

% Sistema de 1ª ordem
num = 2;
den = [3, 1];

% resposta em frequência
w = 2*pi*logspace(-3, 3, 100);
Hw = freqs(num, den, w);

% módulo da resposta em frequência
Hm_dB = 20*log10(abs(Hw));

figure;
semilogx(w/(2*pi), Hm_dB);
grid on;

% fase da resposta em frequência
Fase = phase(Hw) * 180/pi;

figure;
semilogx(w/(2*pi), Fase);
grid on;
