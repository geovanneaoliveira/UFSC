clear;
clc;

%pkg load control;

% Sistema LTI de primeira ordem
num = 1;
den = [0.1, 1];

H = tf(num, den);

% Entrada
fs = 500;
tmax = 1;
tempo = 0:1/fs:tmax-1/fs;

f0 = 10;
x = sin(2*pi*f0*tempo);

% Saida do sistema
y = lsim(H, x, tempo);

% Resposta em frequencia para f0 = 10 Hz
f0 = 10;
w0 = 2*pi*f0;

Hm = 1./sqrt(1+0.01*w0.^2);
Hp = atan2(-0.1*w0,1);

yp = Hm*sin(2*pi*f0*tempo + Hp);

% Apresentacaoo do resultado
figure;
plot(tempo, x);
hold on;
plot(tempo, y');
plot(tempo, yp);
legend('entrada', 'saida', 'saida em regime');
