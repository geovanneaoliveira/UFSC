clear all;
clc;

% resposta em frequencia

%f = 0:0.1:100;
f = logspace(-2,2,100)

w = 2*pi*f;

% modulo

Hm = 20*log10(1./sqrt(1+0.01*(w.^2)));
%Hm = 1./sqrt(1+0.01*(w.^2));

Hf = atan(-0.1*w);

figure
semilogx(f, Hm)
ylabel('módulo da resp em freq')
xlabel('freq (hz)')
grid on

figure
semilogx(f, Hf)
ylabel('fase da resp em freq')
xlabel('freq (hz)')
grid on
