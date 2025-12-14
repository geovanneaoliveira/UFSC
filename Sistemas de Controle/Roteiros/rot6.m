clear
close all
clc

G = tf([0.07581],[1 0.07581]);

opts = bodeoptions;
opts.MagUnits = 'abs';

bode(G, opts)
t5 = 19.785;
Mp = 0.15;
xi = sqrt(1/(((pi/log(Mp))^2) +1))
Wn = 3/(xi*t5);
pd1 = -xi*Wn
pd2 = Wn*sqrt(1 - xi^2)
pd = pd1 + pd2*i;
pd_conjugado = conj(pd)
th1 = atan2d(pd2,(pd1))
th2 = atan2d(pd2,(pd1+0.07581))
Nc = -180+th1+th2
z = -pd1 + pd2/(tand(Nc))
Klrm = (pd*(pd + 0.07581))/(pd + z)
Klr = abs(Klrm)
K = Klr/0.07581
C = tf([K K*z],[1 0])
H = feedback(C * G, 1); % Sistema em malha fechada
% Plotando o Lugar das Raízes
figure;
rlocus(H); % Gera o gráfico do lugar das raízes
title('Lugar das Raízes');
% Plotando o Diagrama de Polos e Zeros
figure;
pzmap(H); % Gera o diagrama de polos e zeros
title('Diagrama de Polos e Zeros')


