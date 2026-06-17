clear;
clc;

% Sistema
f = linspace(0.1, 100, 1000);
w = 2*pi*f;

H = 1./(1+0.01*w.^2) + j*(-0.1*w)./(1+0.01*w.^2);

Hm = 1./sqrt(1+0.01*w.^2);

Hp = atan2(-0.1*w,1);

% Apresentacao dos resultados
f1 = figure;
plot(f, Hm);
ylabel('|H(jw)|');
xlabel('frequencia (Hz)');
grid on;

f2 = figure;
plot(f, 180*Hp/pi);
ylabel('<H(jw)');
xlabel('frequencia (Hz)');
grid on;
